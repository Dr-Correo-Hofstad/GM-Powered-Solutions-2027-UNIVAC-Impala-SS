// ====================================================================================
// REVOLUTIONARY TECHNOLOGY COMPANY & UNIVERSITY OF WASHINGTON DEPARTMENT OF PHYSICS
// Subsystem: sedan_police_protection.scad (Tactical Armor & Roof Lightbar Chase Rack)
// Core Application: 2027 Impala SS Interceptor Frame-Anchored Push Bars & Roll Cage
// Center Origin (0,0,0) = Mid-point of the Front Space-Frame Crossmember Face
// ====================================================================================

$fn = 120; // High-precision CNC plasma-cutting and mandrel tube-bending rendering depth

// --- Tactical Chassis Constants (mm) ---
inch_to_mm         = 25.4;
frame_rail_width   = 44.0  * inch_to_mm; // 1117.60 mm wide muscle-car frame core
impala_wheelbase   = 119.0 * inch_to_mm; // Exactly 3022.60 mm classic tracking length
tube_diameter_mm   = 76.20;              // Heavy-duty 3-inch structural safety tubing
sedan_roof_height  = 950.00;             // Vertical height of the sedan roofline profile
lightbar_mount_w   = 52.0  * inch_to_mm; // Sized for standard 52" tactical lightbars

module front_chassis_ram_bumper() {
    echo("COMPILING REINFORCED CHASSIS-MOUNTED FRONT TACTICAL INTERCEPTOR RAM BAR");
    // Front ram assembly (Welds straight into the titanium frame rail front horn plates)
    color("Black") {
        translate([-frame_rail_width/2 - 60, -100, -150]) {
            difference() {
                // Main heavy horizontal push fascia bar block
                cube([frame_rail_width + 120, 80, 280]);
                // Cutouts clearing classic grille mesh contours
                translate([40, -1, 40]) cube([frame_rail_width + 40, 82, 200]);
            }
            // Left Heavy Vertical Push-Knee (PIT-Maneuver Tooth)
            translate([80, -50, -40]) cube([45, 120, 360]);
            // Right Heavy Vertical Push-Knee (PIT-Maneuver Tooth)
            translate([frame_rail_width, -50, -40]) cube([45, 120, 360]);
        }
    }
}

module over_roof_chase_rack_hoop() {
    echo("COMPILING CHASSIS-INTEGRATED OVER-ROOF ROLL BAR HOOP AND CHASE PLATFORM");
    // Main vertical safety loop extending 80mm above the sedan roof profile to clear lightbar lines
    color("DimGrey") {
        translate([0, -200, sedan_roof_height + 80]) { 
            rotate([0, 90, 0]) {
                difference() {
                    cylinder(d=tube_diameter_mm, h=frame_rail_width + 80, center=true);
                    cylinder(d=tube_diameter_mm - 8, h=frame_rail_width + 86, center=true); // Internal hollow wall
                }
            }
        }
        // Left and Right main vertical support down-legs anchoring straight through floor to frame rails
        for (side = [-1, 1]) {
            translate([side * (frame_rail_width/2 + 20), -200, (sedan_roof_height + 80)/2])
                difference() {
                    cube([tube_diameter_mm, tube_diameter_mm, sedan_roof_height + 80], center=true);
                    cube([tube_diameter_mm - 8, tube_diameter_mm - 8, sedan_roof_height + 86], center=true);
                }
        }
    }
}

module tactical_lightbar_tray() {
    // Rigid horizontal mount tray centered at the absolute peak of the rollover safety loop
    color("Silver") {
        translate([0, -160, sedan_roof_height + 130]) {
            difference() {
                cube([lightbar_mount_w, 65, 8.0], center=true); // Flat billet attachment plate
                for (side = [-1, 1]) {
                    translate([side * (lightbar_mount_w/2 - 20), 0, 0])
                        cube([30, 20, 12], center=true); // Slotted bolt slots for strobe legs
                }
            }
        }
    }
}

// --- Composite Structural Armor System Instantiation ---
union() {
    front_chassis_ram_bumper();
    over_roof_chase_rack_hoop();
    tactical_lightbar_tray();
}
