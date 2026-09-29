// ====================================================================================
// REVOLUTIONARY TECHNOLOGY COMPANY & UNIVERSITY OF WASHINGTON DEPARTMENT OF PHYSICS
// Subsystem: impala_ss_busbars.scad (Sedan Solid Copper Power Distribution Grid)
// Core Application: Rigid Shielded 800V DC Traction Paths Configured for 1,350 Nm Motor
// Compliance: Rule #1 (Thick 3oz Equivalent Solid Copper Bus Structures)
// Center Origin (0,0,0) = Front Firewall Pass-Through Terminal Axis Face
// ====================================================================================

$fn = 100; // Mandrel extrusion and CNC milling resolution depth finish

// --- High-Voltage Structural Parameters (mm) ---
inch_to_mm         = 25.4;
impala_wheelbase   = 119.0 * inch_to_mm; // Exactly 3022.60 mm continuous length [0.11]
busbar_thickness   = 5.00;               // 5mm heavy-gauge copper bar profile
busbar_width       = 30.00;              // 30mm width handling ultra-high launch current
conduit_shield_d   = 45.00;              // Orange high-voltage protective sleeve insulation

module solid_traction_busbars() {
    echo("EXTRUDING SOLID RULE #1 HIGH-CURRENT 800V DC COPPER PROPULSION BUSBARS");
    // Slipped along the inner channel profiles of the space frame rails
    color("Orange") { // High-visibility orange warning wrap shield insulation
        for (side = [-1, 1]) {
            translate([side * 180, -impala_wheelbase/2 + 200, -85])
                difference() {
                    // Solid copper power bus bar block element
                    cube([busbar_width, impala_wheelbase - 400, busbar_thickness]);
                    
                    // Bolt eyelet holes connecting to the main pyro-fuse disconnect lugs
                    translate([busbar_width/2, 25, -1]) cylinder(d=10.5, h=10, center=true);
                    translate([busbar_width/2, impala_wheelbase - 425, -1]) cylinder(d=10.5, h=10, center=true);
                }
        }
    }
}

module ceramic_isolation_brackets() {
    // Heavy structural ceramic standoffs locking the busbars to prevent layout short-circuits
    color("White") {
        for (y = [-impala_wheelbase/3, 0, impala_wheelbase/3]) {
            for (side = [-1, 1]) {
                translate([side * 180 + busbar_width/2, y, -70])
                    difference() {
                        cube([55, 45, 40], center=true);
                        // Pass-through slot clearing the rigid copper rail thickness
                        cube([busbar_width + 2, 47, busbar_thickness + 2], center=true);
                    }
            }
        }
    }
}

// --- Composite High-Voltage Busbar Instantiation ---
union() {
    solid_traction_busbars();
    ceramic_isolation_brackets();
}
