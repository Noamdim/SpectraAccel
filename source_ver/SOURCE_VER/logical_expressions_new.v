module logical_expressions (
    clk, rst_n, valid_in,
    comparison_flags,
    brightness_in, red_in, green_in, blue_in,
    classifier_rules_packed, 
    
    valid_out,
    classification_vector,
    brightness_out, red_out, green_out, blue_out
);

    // --- System Inputs ---
    input  wire        clk;
    input  wire        rst_n;
    input  wire        valid_in;

    // --- Data Inputs ---
    input  wire [5:0]  comparison_flags; // From Comparator Block

    // --- Control Inputs ---
    // 8 Rules * 12 bits per rule = 96 bits
    // Format: {Rule7_Config, Rule6_Config, ... Rule0_Config}
    input  wire [95:0] classifier_rules_packed;

    // --- Pass-Through Inputs ---
    input  wire [2:0]  brightness_in;
    input  wire [7:0]  red_in;
    input  wire [7:0]  green_in;
    input  wire [7:0]  blue_in;

    // --- Outputs ---
    output reg         valid_out;
    
    // The 8 resulting Boolean Expressions (1 bit each)
    output reg [7:0]   classification_vector;

    // --- Pass-Through Outputs ---
    output reg [2:0]   brightness_out;
    output reg [7:0]   red_out;
    output reg [7:0]   green_out;
    output reg [7:0]   blue_out;

    // =========================================================
    // 1. Logic Calculation Variables
    // =========================================================
    integer r; // Rule iterator (0 to 7)
    integer f; // Flag iterator (0 to 5)

    reg [11:0] current_rule_cfg; // 12 bits for current rule
    reg [1:0]  flag_cfg;         // 2 bits for current flag
    reg        term;             // Temporary term for one flag
    reg        rule_result;      // Temporary result for one rule
    reg        any_enabled;      // Track if any flag is enabled in a rule

    // =========================================================
    // 2. Classifier Pipeline (Registered)
    // =========================================================
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid_out             <= 0;
            classification_vector <= 0;
            red_out               <= 0;
            green_out             <= 0;
            blue_out              <= 0;
            brightness_out        <= 0;
        end else begin
            if (valid_in) begin
                valid_out <= 1;

                // Pass-Throughs
                red_out        <= red_in;
                green_out      <= green_in;
                blue_out       <= blue_in;
                brightness_out <= brightness_in;

                // --- Evaluate all 8 Rules ---
                for (r = 0; r < 8; r = r + 1) begin
                    // 1. Extract the 12-bit config for this rule
                    // Rules are packed: Rule 0 is LSBs, Rule 7 is MSBs.
                    current_rule_cfg = classifier_rules_packed[(r*12)+11 -: 12];

                    // 2. Initialize the AND chain
                    // (Start with '1' because we are doing logical ANDs)
                    rule_result = 1'b1;
                    any_enabled = 1'b0;

                    // 3. Loop through all 6 Flags
                    for (f = 0; f < 6; f = f + 1) begin
                        // Extract 2 control bits for this flag
                        flag_cfg = current_rule_cfg[(f*2)+1 -: 2];
                        
                        // Bit 0: Enable Influence? (1=Yes, 0=No/Ignore)
                        // Bit 1: Polarity? (1=Normal, 0=Complement)
                        
                        if (flag_cfg[0] == 1'b0) begin
                            // Case: IGNORE
                            term = 1'b1;
                        end else begin
                            any_enabled = 1'b1;
                            if (flag_cfg[1] == 1'b1) begin
                                // Case: NORMAL (Influence by Him)
                                term = comparison_flags[f];
                            end else begin
                                // Case: COMPLEMENT (Influence by ~Him)
                                term = ~comparison_flags[f];
                            end
                        end

                        // AND this term into the rule result
                        rule_result = rule_result & term;
                    end
                    
                    // 4. Store the final result for this rule
                    classification_vector[r] <= rule_result & any_enabled;
                end

            end else begin
                valid_out <= 0;
            end
        end
    end

endmodule