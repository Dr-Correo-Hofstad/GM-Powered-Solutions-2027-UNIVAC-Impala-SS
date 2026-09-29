// ====================================================================================
// REVOLUTIONARY TECHNOLOGY COMPANY & UNIVERSITY OF WASHINGTON DEPARTMENT OF PHYSICS
// Subsystem: impala_ss_4door_body.scad (2027 Impala 4-Door Sedan Stamping Mask)
// Core Application: 1967 B-Body Silhouette Mated to Modern Titanium Architecture
// COMPLIANCE GATE: Maintains absolute 65mm lower open clearance for underbody armor
// Center Origin (0,0,0) = Geometric Centerpoint of the 119-Inch Wheelbase Centerline
// ====================================================================================

$fn = 100; // Parametric panel contour surface finish path resolution

// --- 1967/2027 Impala SS 4-Door Dimensional Constants (mm) ---
inch_to_mm         = 25.4;
impala_wheelbase   = 119.0 * inch_to_mm; // Exactly 3022.60 mm classic tracking length
body_total_width   = 79.6 * inch_to_mm;  // 2021.84 mm wide muscle-car shoulder stance
sheet_metal_thick  = 1.50;               // Heavy fleet-gauge stamped steel skin scale

// Underbody Clearance Rule Compliance
UNDER_ARMOR_CLEARANCE_MM = 65.00;

module stamped_front_hood_and_fenders() {
    echo("STAMPING 2027 IMPALA SS 4-DOOR SEDAN EXTERIOR FLEET MASK");
    // Sweeping front nose clip clearing the 1,350 Nm Square-Tooth propulsion engine core
    color("ClassicTeal") {
        difference() {
            // Front clip exterior boundary envelope
            translate([0, impala_wheelbase/2 + 400, 180])
                cube([body_total_width, 1450, 620], center=true);
            
            // Hollow inner engine bay cavity clearing structural chassis rails
            translate([0, impala_wheelbase/2 + 400, 180])
                cube([body_total_width - 32, 1454, 600], center=true);
                
            // LOWER PROFILE STANDOFF: Cuts base line to leave open armor installation room
            translate([0, impala_wheelbase/2 + 400, -140])
                cube([body_total_width + 10, 1460, UNDER_ARMOR_CLEARANCE_MM * 3], center=true);
                
            // 7-INCH ROUND HEADLIGHT BUCKETS: Dual circular sealed-beam socket cutouts
            for (side = [-1, 1]) {
                for (offset = [-60, 60]) {
                    translate([side * (body_total_width/2 - 160) + offset, impala_wheelbase/2 + 1120, 260])
                        rotate([-90, 0, 0])
                            cylinder(d=177.8, h=40, center=true); // 7.00 inches diameter standard
                }
            }
        }
    }
}

module pillarless_4door_cabin_shell() {
    // Stamped four-door passenger compartment featuring extended rear suicide door glass tracks
    color("DarkSlateGrey") {
        difference() {
            // Main greenhouse roof and side flank block profile
            translate([0, -100, 520])
                cube([body_total_width, 2250, 950], center=true);
            // Hollow interior cabin cockpit cave clearing the OtterBox console skeleton
            translate([0, -100, 520])
                cube([body_total_width - 40, 2230, 910], center=true);
                
            // LOWER ROCKER PANEL ARMOR SEAT OVERRIDE
            translate([0, -100, -30])
                cube([body_total_width + 10, 2260, UNDER_ARMOR_CLEARANCE_MM * 2], center=true);
        }
    }
}

module coke_bottle_rear_quarter_panels() {
    // Stamped rear trunk deck and classic curved "coke-bottle" rear fender hips
    color("ClassicTeal") {
        translate([0, -impala_wheelbase/2 - 500, 140]) {
            difference() {
                cube([body_total_width, 1600, 520], center=true);
                cube([body_total_width - 32, 1604, 500], center=true); // Hollow fuel cell pocket
                
                // Base clearance plane saving the 65mm underbody shield gap
                translate([0, 0, -200])
                    cube([body_total_width + 10, 1610, UNDER_ARMOR_CLEARANCE_MM * 2], center=true);
            }
        }
    }
}

// --- Composite 4-Door Impala Body Instantiation ---
union() {
    stamped_front_hood_and_fenders();
    pillarless_4door_cabin_shell();
    coke_bottle_rear_quarter_panels();
}
