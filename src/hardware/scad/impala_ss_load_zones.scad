// ====================================================================================
// REVOLUTIONARY TECHNOLOGY COMPANY & UNIVERSITY OF WASHINGTON DEPARTMENT OF PHYSICS
// Subsystem: impala_ss_load_zones.scad (Sedan Occupant & Luggage Force Anchor Pockets)
// Core Application: Multi-Zone Structural Weight Tracking for Active Suspension Balance
// Center Origin (0,0,0) = Geometric Centerpoint of the 119-Inch Wheelbase Centerline
// ====================================================================================

$fn = 100; // High-precision CNC milling and sensor pocket depth resolution

// --- 1967/2027 Impala SS Cabin Grid Constants (mm) ---
inch_to_mm         = 25.4;
impala_wheelbase   = 119.0 * inch_to_mm; // Exactly 3022.60 mm classic tracking length [INDEX]
body_total_width   = 79.6 * inch_to_mm;  // 2021.84 mm wide muscle-car stance [INDEX]
load_cell_pocket_d = 45.00;              // Square pocket housing heavy-tonnage load cell buttons

module passenger_seat_load_pockets() {
    echo("COMPILING ARMORED FLOOR PAN SEAT TRACK LOAD SENSOR APERTURES");
    // Generates 4x isolated structural weight sensor pockets underneath front and rear seat rails
    color("DimGrey") {
        for (side = [-1, 1]) {
            // Front Seat Row Coordinates Mapped over Titanium Rails [INDEX]
            translate([side * 400, 150, -118])
                cube([load_cell_pocket_d, load_cell_pocket_d, 12], center=true);
            
            // Rear Passenger Row Coordinates Mapped over 2016 Fabric Cutters [INDEX]
            translate([side * 400, -450, -118])
                cube([load_cell_pocket_d, load_cell_pocket_d, 12], center=true);
        }
    }
}

module trunk_luggage_weight_pan() {
    echo("COMPILING RECESSED REAR CARGO PROFILE LUGGAGE SENSOR DECK");
    // Deep luggage compartment force tracking pan positioned behind the rear axle centerline
    color("DarkSlateGrey") {
        translate([0, -impala_wheelbase/2 - 400, -80]) {
            difference() {
                // Main structural luggage weight platform deck plate
                cube([body_total_width - 120, 950, 15.0], center=true);
                // Weight optimization grooves clearing the 5° sloped check-valve scuppers [INDEX]
                translate([0, 0, -5])
                    cube([body_total_width - 240, 900, 10.0], center=true);
            }
        }
    }
}

// --- Composite Load Zone Platform Instantiation ---
union() {
    passenger_seat_load_pockets();
    trunk_luggage_weight_pan();
}
