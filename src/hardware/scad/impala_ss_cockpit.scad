// ====================================================================================
// REVOLUTIONARY TECHNOLOGY COMPANY & UNIVERSITY OF WASHINGTON DEPARTMENT OF PHYSICS
// Subsystem: impala_ss_cockpit.scad (Unified Sedan Interior Accessory Modules)
// Core Application: Deploys Bose Speaker Cavities, Peltier Ducts, and Tablet Dock
// Center Origin (0,0,0) = Geometric Centerpoint of the Dashboard Sub-Car Beam
// ====================================================================================

$fn = 100; // High-precision CNC laser-cutting and molding path resolution

// --- Core Geometric System Parameters (mm) ---
inch_to_mm         = 25.4;
bose_midrange_dia  = 90.00;            // Sized for tuned Bose Neodymium arrays
peltier_duct_w     = 180.00;           // Matches active thermoelectric hvac housing
crank_spindle_dia  = 16.00;            // Flush-mount emergency mechanical override pop-out shaft
tablet_dock_w      = 265.00;           // Sized precisely for the 10-inch detachable family module

module bose_acoustic_dashboard_pods() {
    echo("COMPILING SHIELDED BOSE ACOUSTIC SPEECH SPEAKER HOUSINGS");
    // Symmetrical speaker cutouts molded into the dashboard deck
    for (side = [-1, 1]) {
        translate([side * 420, 60, 40]) {
            color("DimGrey") {
                difference() {
                    cylinder(d=bose_midrange_dia + 16, h=50, center=true);
                    cylinder(d=bose_midrange_dia, h=52, center=true); // Tuned compression chamber
                }
            }
        }
    }
}

module hvac_peltier_duct_manifolds() {
    echo("COMPILING SOLID-STATE PELTIER AIRFLOW MANIFOLDS");
    // Left and right directional climate venting passages feeding the cabin space
    color("Black") {
        for (side = [-1, 1]) {
            translate([side * 200, 10, -20])
                cube([peltier_duct_w, 80, 45], center=true);
        }
    }
}

module dual_mode_window_regulators() {
    echo("COMPILING DETACHABLE ELECTRIC REGULATORS WITH SPRING-OUT MECHANICAL EMERGENCY CRANKS");
    // Inner door shackle plate holding the electric motor track and the emergency mechanical crank shaft
    for (side = [-1, 1]) {
        scale([side, 1, 1]) {
            translate([600, -250, -100]) {
                color("Silver") {
                    difference() {
                        cylinder(d=crank_spindle_dia + 20, h=35, center=true);
                        cylinder(d=crank_spindle_dia, h=37, center=true); // Pop-out spring sleeve
                    }
                }
                // High-torque electric regular lifter motor block
                translate([-50, 0, -10]) color("DimGrey") cube([40, 60, 50], center=true);
            }
        }
    }
}

module magnetic_tablet_dock_station() {
    echo("COMPILING DETACHABLE FAMILY CO-PILOT TABLET RECEPTACLE ASSEMBLY");
    // Flush-mounted central docking bezel equipped with rear alignment magnets and pogo pin ports
    color("DarkSlateGrey") {
        translate([80, -10, -10]) {
            difference() {
                cube([tablet_dock_w + 16, 20, 190], center=true);
                cube([tablet_dock_w, 22, 174], center=true); // Pocket clearing the tablet rear frame
            }
            // Central high-reliability gold-plated pogo pin array block
            translate([0, -8, -50]) color("Gold") cube([60, 4, 12], center=true);
        }
    }
}

// --- Composite Accessory Systems Compilation ---
union() {
    bose_acoustic_dashboard_pods();
    hvac_peltier_duct_manifolds();
    dual_mode_window_regulators();
    magnetic_tablet_dock_station();
}
