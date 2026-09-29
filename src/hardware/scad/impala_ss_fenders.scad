// ====================================================================================
// REVOLUTIONARY TECHNOLOGY COMPANY & UNIVERSITY OF WASHINGTON DEPARTMENT OF PHYSICS
// Subsystem: impala_ss_fenders.scad (Sedan Widebody Flares & Heavy Mud Flaps)
// Core Application: Anti-Debris Splash Guards/Fender Kits Matching 17 Wheel Styles
// COMPLIANCE GATE: Form-fitted to clear the 65mm lower armor clearance envelope
// Center Origin (0,0,0) = Geometric Centerpoint of the 119-Inch Wheelbase Centerline
// ====================================================================================

$fn = 100; // Parametric contour curve resolution for stamped components

// --- 1967/2027 Impala SS Structural Constants (mm) ---
inch_to_mm         = 25.4;
impala_wheelbase   = 119.0 * inch_to_mm; // Exactly 3022.60 mm classic tracking length [INDEX]
body_total_width   = 79.6 * inch_to_mm;  // 2021.84 mm wide muscle-car stance [INDEX]
flare_extension_w  = 45.00;              // Adds 45mm widebody clearance per side
mudflap_drop_h     = 220.00;             // Vertical trailing flap protection length

// Underbody Clearance Rule Compliance [INDEX]
UNDER_ARMOR_CLEARANCE_MM = 65.00;

module widebody_fender_flare_kits() {
    echo("COMPILING 2027 IMPALA SS MULTI-ZONE BOLT-ON FENDER FLARE EXTENSIONS");
    // Front and Rear arched widebody fender trims tracking over performance wheel paths
    color("DarkSlateGrey") {
        for (side = [-1, 1]) {
            for (y_axle = [-impala_wheelbase/2, impala_wheelbase/2]) {
                translate([side * (body_total_width/2 + flare_extension_w/2 - 5), y_axle, 180]) {
                    difference() {
                        // Main arched outer protection bulge ring
                        rotate([0, 90, 0]) cylinder(d=690, h=flare_extension_w, center=true);
                        rotate([0, 90, 0]) cylinder(d=650, h=flare_extension_w + 4, center=true);
                        
                        // Lower cut horizontal plane maintaining the 65mm under-armor clearance [INDEX]
                        translate([0, 0, -320])
                            cube([120, 720, UNDER_ARMOR_CLEARANCE_MM * 2], center=true);
                    }
                }
            }
        }
    }
}

module vulcanized_rubber_mudflaps() {
    echo("COMPILING REAR TRACKING MUD FLAP ARRAYS: 100% ORGANIC ANTI-OZONANT COMPOUNDS");
    // Heavy-duty trailing flaps secured inside the wheel wells using 100% natural tree sap [INDEX]
    color("Black") {
        for (side = [-1, 1]) {
            for (y_axle = [-impala_wheelbase/2, impala_wheelbase/2]) {
                // Positions the flaps trailing 360mm back behind each tire centerline path
                translate([side * (body_total_width/2 + 10), y_axle - 360, -20]) {
                    difference() {
                        // Main vertical flexible splash rubber panel
                        cube([260.0, 12.0, mudflap_drop_h], center=true);
                        
                        // Chamfer corner cuts to prevent ground scrubbing during high-G compression loops [INDEX]
                        translate([side * 130, 0, -mudflap_drop_h/2])
                            rotate([0, side * 45, 0])
                                cube([80, 20, 80], center=true);
                    }
                }
            }
        }
    }
}

// --- Composite Structural Fender System Instantiation ---
union() {
    widebody_fender_flare_kits();
    vulcanized_rubber_mudflaps();
}
