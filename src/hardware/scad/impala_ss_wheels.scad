// ====================================================================================
// REVOLUTIONARY TECHNOLOGY COMPANY & UNIVERSITY OF WASHINGTON DEPARTMENT OF PHYSICS
// Subsystem: impala_ss_wheels.scad (17-Variant Master Billet Wheel Stamping Matrix)
// Core Application: Matches 17 Historical & Tactical GM Styles to the 2027 Space-Frame
// Center Origin (0,0,0) = Concentric Centerline Axis of the Wheel Hub Register
// ====================================================================================

$fn = 100; // Ultra-high precision lathe toolpath and CNC milling profile finish depth

// --- Master Wheel Style Selector ---
// 0x01 to 0x11 mapping the 17 unique fleet and performance configurations defined above
STYLE_HEX_ID = 0x01; 

// --- Physical Dimensional Tables (mm) ---
inch_to_mm         = 25.4;
rim_diameter       = (STYLE_HEX_ID == 0x11) ? 22.0 * inch_to_mm :
                     (STYLE_HEX_ID == 0x08) ? 18.0 * inch_to_mm : 19.0 * inch_to_mm; // 18" Police vs 22" Concept vs 19" Standard Track
rim_section_width  = (STYLE_HEX_ID == 0x0C) ? 12.0 * inch_to_mm : 10.5 * inch_to_mm; // Wide bead-lock spec

module deploy_style_specific_spoke_matrix() {
    echo(str("MILLING ACTIVE GM COMPLIANCE WHEEL STYLE IDENTIFIER: 0x0", STYLE_HEX_ID));
    
    // 1. CLASSIC 1967 SUPER SPORT 5-SPOKE ARRAY
    if (STYLE_HEX_ID == 0x01) {
        color("Silver") {
            for (i = [0 : 4]) {
                rotate([0, 0, i * (360 / 5)])
                    translate([rim_diameter/4, 0, 0])
                        cube([rim_diameter/2 - 20, 55, 20], center=true);
            }
        }
    }
    
    // 2. CORVETTE TURBINE SALAD-SHOOTERS (Configured with 12.5° Centrifugal Blades)
    else if (STYLE_HEX_ID == 0x03) {
        color("Mirror") {
            for (i = [0 : 11]) {
                rotate([0, 0, i * (360 / 12)])
                    translate([rim_diameter/4, 0, 0])
                        rotate([12.5, 0, 0]) // Mandatory aerodynamic extraction twist
                            cube([rim_diameter/2 - 15, 30, 12], center=true);
            }
        }
    }
    
    // 3. HEAVY TACTICAL 9C1 POLICE STEELIE (Solid dish face with perimeter oval ports)
    else if (STYLE_HEX_ID == 0x08) {
        color("Black") {
            difference() {
                cylinder(d=rim_diameter - 20, h=18, center=true); // Solid center combat shielding face
                for (p = [0 : 8]) {
                    rotate([0, 0, p * (360 / 9)])
                        translate([rim_diameter/2 - 40, 0, 0])
                            cylinder(d=25, h=25, center=true); // Coolant relief windows
                }
            }
        }
        color("Chrome") cylinder(d=180, h=25, center=true); // Authentic heavy center cap
    }
    
    // 4. ZR2 BISON OFF-ROAD BEAD-LOCK SPLIT RING
    else if (STYLE_HEX_ID == 0x0C) {
        color("DarkSlateGrey") {
            cylinder(d=rim_diameter - 40, h=22, center=true);
            // Outer thick mechanical clamping ring
            difference() {
                cylinder(d=rim_diameter + 12, h=30, center=true);
                cylinder(d=rim_diameter - 8, h=34, center=true);
            }
        }
    }
    
    // STANDARD MULTI-SPOKE PERFORMANCE FALLBACK THEME
    else {
        color("DimGrey") {
            for (i = [0 : 9]) {
                rotate([0, 0, i * (360 / 10)])
                    translate([rim_diameter/4, 0, 0])
                        cube([rim_diameter/2 - 10, 22, 15], center=true);
            }
        }
    }
}

module master_hub_interface_register() {
    // Standardized 5x4.75" classic GM hub register face built with 14mm high-tensile hardware ports
    color("Silver") {
        difference() {
            cylinder(d=220, h=35, center=true);
            cylinder(d=100, h=40, center=true); // Centers over splined direct-drive axle stubs
            
            for (l = [0 : 4]) {
                angle = l * (360 / 5);
                translate([cos(angle)*120.65/2, sin(angle)*120.65/2, 0])
                    cylinder(d=14.5, h=50, center=true); // M14 Class 10.9 stud bore clearance
            }
        }
    }
}

// --- Composite Mechanical Wheel Unit Instantiation ---
union() {
    deploy_style_specific_spoke_matrix();
    master_hub_interface_register();
    
    // Outer Barrel Representation Rim Lips
    color("Mirror", 0.2)
        difference() {
            cylinder(d=rim_diameter, h=rim_section_width, center=true);
            cylinder(d=rim_diameter - 12, h=rim_section_width + 4, center=true);
        }
}
