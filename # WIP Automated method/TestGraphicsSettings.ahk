#Requires AutoHotkey v2.0
#SingleInstance Force
#Warn All, Off
SendMode "Input"
CoordMode "Mouse", "Client"


full_command_line := DllCall("GetCommandLine", "str")
if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try
    {
        if A_IsCompiled
            Run '*RunAs "' A_ScriptFullPath '" /restart'
        else
            Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
    }
    ExitApp
}


Class Screen_Coordinates {
    Class KKKK {
        Class Interface_Small {
            ;GUI Status checking
            menu_options := [425, 1880]
            menu_options_video := [425, 1720]
            menu_open_pause_symbol := [3751, 111]
            ;Video options Status checking
            video_general_tab := [1262, 660]
            video_tab_highlighted_color := "0xF5F5F5"



            ;Quality
            general_sampling         := [1750, 809]
            general_texture          := [1750, 884]
            general_objects          := [1750, 955]
            general_terrain          := [1750, 1027]
            ;
            general_shadow           := [1750, 1144]
            general_particles        := [1750, 1215]
            general_cloud            := [1750, 1283]
            general_pip              := [1750, 1358]
            ;
            general_overall_dist      := [2787, 800] ;Input Box
            general_object_dist       := [2787, 875] ;Input Box
            general_shadow_dist       := [2787, 955] ;Input Box
            general_pip_dist          := [2787, 1015] ;Input Box
            ;Lighting
            general_hdr              := [2775, 1213]
            general_dynamic_lights    := [2775, 1285]
            general_water_reflections := [2775, 1350]
            ; Display
            display_brightness := [1900, 1140] ;Input Box
            ; Postprocesses
            aapp_bloom          := [1876, 798] ;Input Box
            aapp_depth_of_field   := [1876, 1017] ;Input Box
            aapp_sharpen_filter  := [1876, 1086] ;Input Box
            aapp_ao             := [1753, 1237]
            ; Postprocess color corrections
            aapp_brightness     := [2790, 874]  ;Input Box
            aapp_contrast       := [2790, 946] ;Input Box
            aapp_saturation     := [2790, 1018] ;Input Box
            ; Antialiasing
            aapp_fsaa            := [2774, 1172]
            aapp_atoc            := [2774, 1240]
            aapp_ppaa            := [2774, 1309]
            aapp_ansio_filtering := [2774, 1379]

            setting_names := ArmaGraphicsSettings()
            default_settings := DefaultSettings()



            Wait_For_Window(coords, colors) {
                fail_counter := 0
                Loop {
                    pause_symbol_check := PixelGetColor(coords[1], coords[2])
                    for color in colors {
                        If pause_symbol_check = color {
                            ;MsgBox "Menu open"
                            return True
                        }
                    }

                    If fail_counter = 80 { 
                        ;MsgBox "exit"
                        return False
                    }

                    fail_counter += 1
                    Sleep 25
                }
            }


            Test_Sampling() {
                ;MsgBox(this.setting_names.general_texture[6])
                Send "{ESC}"
                ;If pause symbol not found, reset
                if (this.Wait_For_Window(this.menu_open_pause_symbol, ["0xFFFFFF","0xFEFFFF"])) = False {
                    return
                }
                ;Pause symbol has been found, proceed
                Click this.menu_options[1], this.menu_options[2]
                ;Wait for animation
                Sleep 800
                Click this.menu_options_video[1], this.menu_options_video[2]
                ; some shit here
            }
        }
    }
}

Class ArmaGraphicsSettings {
    ;Quality
    general_sampling := [50,67,75,80,83,88,100,114,120,125,133,150,200]
    general_texture := ["Very Low", "Standard", "High", "Very High", "Ultra", "Extreme"]
    general_objects := ["Very Low", "Standard", "High", "Very High", "Ultra", "Extreme"]
    general_terrain := ["Very Low", "Standard", "High", "Very High", "Ultra", "Extreme"]
    ;
    general_shadow := ["Disabled", "Low", "Standard", "High", "Very High", "Ultra", "Extreme"]
    general_particles := ["Low", "Standard", "High", "Very High"]
    general_cloud := ["Low", "Standard", "High", "Very High", "Ultra", "Extreme"]
    general_pip := ["Disabled", "Low", "Standard", "High", "Very High", "Ultra", "Extreme"]
    ;Next half
    general_overall_dist := [100,500,1000,2000,3000,4000,5000,6000,120000]
    general_object_dist := [100,500,1000,2000,3000,4000,5000,6000,120000]
    general_shadow_dist := [50]
    general_pip_dist := [200]
    ;Lighting
    general_hdr := ["Low", "Standard"]
    general_dynamic_lights := ["Low", "Standard", "High", "Very High", "Ultra", "Extreme"]
    general_water_reflections := ["Disabled", "Standard", "High", "Very High", "Ultra"]
    display_brightness := [0.5,0.6,0.7,0.8,0.9,1.0,1.1,1.2,1.3,1.4,1.5]
    ; Postprocesses
    aapp_bloom := [0,50,100,150,200,250,300]
    aapp_depth_of_field := [0,50,100,150,200,250,300,350,400,450,500]
    aapp_sharpen_filter := [0,50,100,150,200,250,300,350,400]
    aapp_ao := ["Disabled", "HDAO Low", "HDAO Standard", "HDAO High", "HBAO+ Soft", "HBAO+ Medium", "HBAO+ Strong"]
    ; Postprocess color corrections
    aapp_brightness := [0,25,50,75,100,125,150,175,200]
    aapp_contrast := [0,25,50,75,100,125,150,175,200]
    aapp_saturation := [0,25,50,75,100,125,150,175,200]
    ; Antialiasing
    aapp_fsaa := ["Disabled", "2x", "4x", "8x"]
    aapp_atoc := ["Disabled", "Grass", "Arma 2 trees", "Arma 2 tress + grass", "Arrowhead trees", "Arrowhead trees + grass", "All trees", "All trees + grass"]
    aapp_ppaa := ["Disabled", "FXAA Standard", "FXAA High", "FXAA Very High", "FXAA Ultra", "SMAA Standard", "SMAA High", "SMAA Very High", "SMAA Ultra", "CMAA"]
    aapp_ansio_filtering := ["Disabled", "Low", "Standard", "High", "Very High", "Ultra"]
}

Class DefaultSettings {
    ;Quality
    general_sampling         := 7
    general_texture          := 5
    general_objects          := 5
    general_terrain          := 5
    ;
    general_shadow           := 1
    general_particles        := 1
    general_cloud            := 2
    general_pip              := 1
    ;
    general_overall_dist      := 9 ;Input Box
    general_object_dist       := 9 ;Input Box
    general_shadow_dist       := 1 ;Input Box
    general_pip_dist          := 1 ;Input Box
    ;Lighting
    general_hdr              := 2
    general_dynamic_lights    := 2
    general_water_reflections := 1
    ; Display
    display_brightness := 6 ;Input Box
    ; Postprocesses
    aapp_bloom          := 1 ;Input Box
    aapp_depth_of_field   := 1 ;Input Box
    aapp_sharpen_filter  := 3 ;Input Box
    aapp_ao             := 1
    ; Postprocess color corrections
    aapp_brightness     := 5 ;Input Box
    aapp_contrast       := 5 ;Input Box
    aapp_saturation     := 5 ;Input Box
    ; Antialiasing
    aapp_fsaa            := 3
    aapp_atoc            := 1
    aapp_ppaa            := 1
    aapp_ansio_filtering := 6
}



test := Screen_Coordinates.KKKK.Interface_Small()

*1::
{
    test.Test_Sampling()
}