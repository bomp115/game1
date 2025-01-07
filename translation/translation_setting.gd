extends Node
class_name _translation_setting

func en():
	
	var po_file = load("res://translation/en.po")
	#var translation = Translation.new()
	TranslationServer.add_translation(po_file)
	Global_var.language = "en"
	Global_var._ready()
	TranslationServer.set_locale("en")
	
func default():
	var current_locale = TranslationServer.get_locale().split("_")[0]
	Global_var.scene = 1
	if current_locale == "en_US" or current_locale == "en_AU" or current_locale == "en" or current_locale == "en_CA" or current_locale == "en_GB":
		var po_file = load("res://translation/en.po")
		TranslationServer.add_translation(po_file)
		Global_var.language = "en"
	else:	
		var po_file = load("res://translation/en.po")
		TranslationServer.remove_translation(po_file)
		Global_var.language = "ja"	
	TranslationServer.set_locale(current_locale)	
	
func jp():
	var po_file = load("res://translation/en.po")
	TranslationServer.remove_translation(po_file)
	Global_var.language = "ja"
	Global_var._ready()
	TranslationServer.set_locale("")	
	
	
	
