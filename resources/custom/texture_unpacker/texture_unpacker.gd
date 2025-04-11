@tool
class_name TextureUnpacker extends Resource

@export var texture_pack: Texture2D
@export var texture_count := Vector2i.ONE
@export var texture_padding := Vector2i.ZERO
@export var export_name: String
@export var export_path: String

@export_tool_button("Unpack") var unpack = unpack_textures


func unpack_textures() -> void:
	var img_text := ImageTexture.create_from_image(texture_pack.get_image())
	var step := Vector2i(img_text.get_size()) / texture_count
	for y in range(texture_count.y):
		for x in range(texture_count.x):
			var unpacked_texture := AtlasTexture.new()
			unpacked_texture.atlas = img_text
			unpacked_texture.region = Rect2i(Vector2i(x, y) * step + texture_padding, step - 2 * texture_padding)
			var err := ResourceSaver.save(unpacked_texture, export_path + export_name + "-%s-%s.tres" % [x, y])
			assert(err == OK, "Encountered error while unpacking texture: (%s) %s" % [err, error_string(err)])
