extends PanelContainer
class_name MetaUpgradeCard

@onready var name_label = %NameLabel
@onready var description_label = %DescriptionLabel
@onready var animation_player = $AnimationPlayer


func set_meta_upgrade (upgrade: MetaUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description
