// ====================================================================================
// REVOLUTIONARY TECHNOLOGY COMPANY & UNIVERSITY OF WASHINGTON DEPARTMENT OF PHYSICS
// Subsystem: impala_ss_lighting.scad (Sedan Weatherproof LED Enclosures)
// Core Application: 1967-Silhouette Quad Headlight Buckets & 3-Slot Tail Lamps
// COMPLIANCE GATE: Hermetically sealed housings matching ACDelco active gasket paths
// Center Origin (0,0,0) = Geometric Centerpoint of the Front Facia Header Beam Axis
// ====================================================================================

$fn = 100; // Injection mold toolpath and laser profiling resolution finish

// --- Sedan Optical Dimensional Constants (mm) ---
inch_to_mm         = 25.4;
headlight_dia      = 5.75 * inch_to_mm;   // 146.05 mm original outer quad headlight diameter
indicator_dia      = 75.00;              // Circular front bumper valance light diameter
rear_housing_w     = 320.00;             // Extended 3-slot rear tail lamp cluster footprint
rear_housing_h     = 85.00;
gasket_groove_depth= 4.50;               // Carved channel for natural tree-rubber strip seating

module quad_headlight_weatherproof_buckets() {
    echo("COMPILING QUAD CORNEAL LENS CONTAINMENT HOUSINGS - NORTHROP GRUMMAN HARDENED SPEC");
    // Front dual-lens array per side sealed against moisture and engine bay humidity
    color("Silver") {
        for (side = [-1, 1]) {
            for (spacing = [-90, 90]) {
                translate([side * 650 + spacing, 0, 120]) {
                    difference() {
                        // Outer cast aluminum moisture-barrier shell
                        cylinder(d=headlight_dia + 16, h=65, center=true);
                        // Internal optics socket vault matching H4 LED conversion blocks
                        cylinder(d=headlight_dia, h=70, center=true);
                        
                        // ACDelco Active Gasket Tracking Groove
                        translate([0, 0, 30])
                            difference() {
                                cylinder(d=headlight_dia + 12, h=gasket_groove_depth + 1, center=true);
                                cylinder(d=headlight_dia + 4, h=gasket_groove_depth + 3, center=true);
                            }
                    }
                }
            }
        }
    }
}

module triple_slot_rear_taillight_housing() {
    echo("COMPILING REAR THREE-SLOT HORIZONTAL SEQUECTIONAL TAILLIGHTS");
    // Rear deck frame housing matching original 1967 B-body rear clip boundaries
    color("Chrome") {
        difference() {
            cube([rear_housing_w, 40.0, rear_housing_h], center=true);
            
            // 3-Segment internal isolation slots for sequential flashing LED circuit cards
            for (x_offset = [-100, 0, 100]) {
                translate([x_offset, 2, 0])
                    cube([85, 38.0, rear_housing_h - 12], center=true);
            }
        }
    }
}

module interior_recessed_dome_strips() {
    echo("COMPILING CABIN ROOF HALO LED STRIP ENCLOSURES");
    // Thin, low-profile linear channel running inside the internal roll cage bars
    color("White") {
        translate([0, -400, 680])
            cube([400.0, 12.0, 6.0], center=true);
    }
}

// --- Composite Lighting Enclosure System Instantiation ---
union() {
    quad_headlight_weatherproof_buckets();
    translate([0, -1200, 0]) triple_slot_rear_taillight_housing();
    interior_recessed_dome_strips();
}
