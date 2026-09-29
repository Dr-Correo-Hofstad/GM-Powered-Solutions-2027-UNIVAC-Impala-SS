// ====================================================================================
// REVOLUTIONARY TECHNOLOGY COMPANY & UNIVERSITY OF WASHINGTON DEPARTMENT OF PHYSICS
// Subsystem: impala_ss_battery_vault.scad (Sedan 120 kWh Structural Energy Core)
// Core Application: Floor-Pan Nested Traction Cells / 2016 Seat Rail Anchors
// COMPLIANCE GATE: Form-fitted to clear the 65mm lower armor clearance envelope
// Center Origin (0,0,0) = Geometric Centerpoint of the Underbelly Battery Pan Face
// ====================================================================================

$fn = 100; // High-precision waterjet cutting and laser profiling path resolution

// --- Sedan Structural Pack Dimensions (mm) ---
inch_to_mm         = 25.4;
frame_inner_w      = 44.0 * inch_to_mm;  // 1117.60 mm clear span clearance between rails [0.11]
pack_total_length  = 2200.00;          // Maximized longitudinally across the full floor bed
pack_total_height  = 140.00;           // Low-profile 140mm thickness protecting car ground clearance
wall_thickness_ti  = 6.35;               // 1/4" Structural Titanium Grade 5 walls [0.11]

// Internal Cell Partition Sizing
cell_module_bay_w  = 500.00;           // Left and right isolated cell module bays
vapor_plate_thick  = 15.00;            // Phase-Change horizontal cooling jacket clearance

module sedan_titanium_battery_vault() {
    echo("COMPILING 2027 IMPALA SS MAX-CAPACITY STRUCTURAL FAMILY VAULT");
    color("DimGrey") {
        difference() {
            // Main horizontal low-profile structural cell container box
            cube([frame_inner_w - 10, pack_total_length, pack_total_height], center=true);
            
            // Left Side Cell Module Chamber
            translate([-frame_inner_w/4, 0, 0])
                cube([cell_module_bay_w, pack_total_length - 40, pack_total_height - (2*wall_thickness_ti)], center=true);
                
            // Right Side Cell Module Chamber
            translate([frame_inner_w/4, 0, 0])
                cube([cell_module_bay_w, pack_total_length - 40, pack_total_height - (2*wall_thickness_ti)], center=true);
        }
    }
}

module rt_phase_change_cooling_lines() {
    // Integrated horizontal vapor chamber layers that flush thermal build-up straight to scuppers
    color("Copper") {
        for (z_offset = [-pack_total_height/2 + 10, pack_total_height/2 - 10]) {
            translate([0, 0, z_offset])
                cube([frame_inner_w - 30, pack_total_length - 20, vapor_plate_thick], center=true);
        }
    }
}

// --- Composite Structural Energy Vault Instantiation ---
union() {
    sedan_titanium_battery_vault();
    rt_phase_change_cooling_lines();
}
