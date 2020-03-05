# +----------------------
# |
# | XP Bottler
# |
# | Simple script to bottle and save your XP
# |
# +----------------------
#
# @author Civalo
# @date 2020/03/04
# @denizen-build REL-1703
# @script-version 1.1
#
# Installation:
# Just put the script in your denizen scripts folder and reload. (/ex reload)
#
# Thanks to mcmonkey for pushing updates to Denizen to make this all work right!
# ---------------------------- END HEADER ----------------------------

# --------------------------- World Scripts --------------------------
XpBottler:
  type: world
  debug: true
  events:
    on player right clicks with XpEmpty using hand:
      - if <player.xp_total> >= 100:
        - narrate <player.xp_total>
        - take xp quantity:100
        - give Xp100
        - take XpEmpty quantity:1
      - else:
        - narrate "<red>You don't have enough XP"

    # Flag the player for item used
    on player right clicks with Xp100:
      - flag player xpBottleValue:100
    on player right clicks with Xp400:
      - flag player xpBottleValue:400
    on player right clicks with Xp900:
      - flag player xpBottleValue:900

    on experience bottle breaks:
      - if <context.entity.shooter.has_flag[xpBottleValue]>:
        - define value <context.entity.shooter.flag[xpBottleValue]>
        - flag player xpBottleValue:!
        - determine experience:<[value]>

# --------------------------- Item Scripts ---------------------------
XpEmpty:
  type: item
  material: glass_bottle
  display name: <gold>Empty Bottle O' Enchanting
  lore:
  - This XP bottle is empty
  - Right Click with it in your hand to fill it
  enchantments:
  - unbreaking:1
  mechanisms:
    flags: HIDE_ENCHANTS
  recipes:
    1:
      type: shaped
      output_quantity: 8
      input:
      - glass_bottle|glass_bottle|glass_bottle
      - glass_bottle|prismarine_crystals|glass_bottle
      - glass_bottle|glass_bottle|glass_bottle

Xp100:
  type: item
  material: experience_bottle
  display name: <gold> 100 XP Bottle O' Enchanting
  lore:
  - <green>This bottle contains 100 XP points
  recipes:
    1:
      type: shapeless
      output_quantity: 9
      input: Xp900
    2:
      type: shapeless
      output_quantity: 4
      input: Xp400

Xp400:
  type: item
  material: experience_bottle
  display name: <gold> 400 XP Bottle O' Enchanting
  lore:
  - <green>This bottle contains 400 XP points
  recipes:
    1:
      type: shapeless
      output_quantity: 1
      input: Xp100|Xp100|Xp100|Xp100

Xp900:
  type: item
  material: experience_bottle
  display name: <gold> 900 XP Bottle O' Enchanting
  lore:
  - <green>This bottle contains 900 XP points
  recipes:
    1:
      type: shapeless
      output_quantity: 1
      input: Xp100|Xp100|Xp100|Xp100|Xp100|Xp100|Xp100|Xp100|Xp100
