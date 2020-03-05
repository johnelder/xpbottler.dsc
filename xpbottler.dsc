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
# @script-version 1.0
#
# Installation:
# Just put the script in your denizen scripts folder and reload. (/ex reload)
#
#
# ---------------------------- END HEADER ----------------------------



# --------------------------- World Scripts --------------------------
XpBottler:
  type: world
  debug: false
  events:
    on player right clicks with XpEmpty using hand:
      - if <player.xp_total> >= 100:
        - execute as_op "exp take <player.name> 100"
        - give Xp100
        - take XpEmpty quantity:1
      - else:
        - narrate "<red>You don't have enough XP"

    # Flag the player for item used
    on player right clicks with Xp100:
      - flag player xpBottlerItem:Xp100
    on player right clicks with Xp400:
      - flag player xpBottlerItem:Xp400
    on player right clicks with Xp900:
      - flag player xpBottlerItem:Xp900

    #Spawn xp orb for player if they have the approopriate flag, remove flag
    on thrown_exp_bottle hits block:
      - if <player.has_flag[xpBottlerItem]>:
        - if <player.flag[xpBottlerItem]> == "Xp100":
            - execute as_server "summon minecraft:experience_orb <context.location.x> <context.location.y> <context.location.z> {Value:97}"
        - else if <player.flag[xpBottlerItem]> == "Xp400":
            - execute as_server "summon minecraft:experience_orb <context.location.x> <context.location.y> <context.location.z> {Value:397}"
        - else if <player.flag[xpBottlerItem]> == "Xp900":
            - execute as_server "summon minecraft:experience_orb <context.location.x> <context.location.y> <context.location.z> {Value:897}"
        - flag player xpBottlerItem:!


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
  - <red>WARNING: Throwing too fast can lose XP
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
  - <red>WARNING: Throwing too fast can lose XP
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
  - <red>WARNING: Throwing too fast can lose XP
  recipes:
    1:
      type: shapeless
      output_quantity: 1
      input: Xp100|Xp100|Xp100|Xp100|Xp100|Xp100|Xp100|Xp100|Xp100
