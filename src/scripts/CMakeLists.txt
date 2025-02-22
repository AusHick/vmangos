
set(LIBRARY_NAME scripts)

set (SCRIPTS_SRCS 
    ScriptLoader.h
    custom/custom.h
    custom/npc_j_eevee.h
    eastern_kingdoms/burning_steppes/blackrock_depths/blackrock_depths.h
    eastern_kingdoms/burning_steppes/blackrock_spire/blackrock_spire.h
    eastern_kingdoms/burning_steppes/blackwing_lair/blackwing_lair.h
    eastern_kingdoms/burning_steppes/molten_core/molten_core.h
    eastern_kingdoms/dun_morogh/gnomeregan/gnomeregan.h
    eastern_kingdoms/eastern_plaguelands/naxxramas/naxxramas.h
    eastern_kingdoms/eastern_plaguelands/stratholme/stratholme.h
    eastern_kingdoms/stormwind_city/quest_stormwind_rendezvous.h
    eastern_kingdoms/stranglethorn_vale/zulgurub/zulgurub.h
    eastern_kingdoms/swamp_of_sorrows/sunken_temple/sunken_temple.h
    eastern_kingdoms/tirisfal_glades/scarlet_monastery/scarlet_monastery.h
    eastern_kingdoms/uldaman/uldaman.h
    eastern_kingdoms/western_plaguelands/scholomance/scholomance.h
    eastern_kingdoms/westfall/deadmines/deadmines.h
    kalimdor/ashenvale/blackfathom_deeps/blackfathom_deeps.h
    kalimdor/desolace/maraudon/maraudon.h
    kalimdor/dustwallow_marsh/onyxias_lair/instance_onyxia_lair.h
    kalimdor/feralas/dire_maul/dire_maul.h
    kalimdor/moonglade/boss_omen.h
    kalimdor/silithus/ruins_of_ahnqiraj/ruins_of_ahnqiraj.h
    kalimdor/silithus/temple_of_ahnqiraj/temple_of_ahnqiraj.h
    kalimdor/tanaris/zulfarrak/zulfarrak.h
    kalimdor/the_barrens/razorfen_downs/razorfen_downs.h
    kalimdor/the_barrens/razorfen_kraul/razorfen_kraul.h
    kalimdor/the_barrens/wailing_caverns/def_wailing_caverns.h
    PrecompiledHeaders/scriptPCH.h
    world/dragons_of_nightmare/boss_dragon_of_nightmare.h
    ScriptLoader.cpp
    ScriptLoader_noscripts.cpp
    battlegrounds/battleground.cpp
    battlegrounds/battleground_alterac.cpp
    custom/boss_arena_hardog.cpp
    custom/custom.cpp
    custom/custom_creatures.cpp
    custom/event_attack_city.cpp
    custom/gmisland.cpp
    custom/npc_escort.cpp
    custom/zero_creatures.cpp
    custom/npc_j_eevee.cpp
    eastern_kingdoms/alterac_mountains/alterac_mountains.cpp
    eastern_kingdoms/arathi_highlands/arathi_highlands.cpp
    eastern_kingdoms/blasted_lands/blasted_lands.cpp
    eastern_kingdoms/burning_steppes/burning_steppes.cpp
    eastern_kingdoms/burning_steppes/blackrock_depths/arena_challenge_ai.cpp
    eastern_kingdoms/burning_steppes/blackrock_depths/blackrock_depths.cpp
    eastern_kingdoms/burning_steppes/blackrock_depths/boss_anubshiah.cpp
    eastern_kingdoms/burning_steppes/blackrock_depths/boss_emperor_dagran_thaurissan.cpp
    eastern_kingdoms/burning_steppes/blackrock_depths/boss_general_angerforge.cpp
    eastern_kingdoms/burning_steppes/blackrock_depths/boss_gorosh_the_dervish.cpp
    eastern_kingdoms/burning_steppes/blackrock_depths/boss_grizzle.cpp
    eastern_kingdoms/burning_steppes/blackrock_depths/boss_high_interrogator_gerstahn.cpp
    eastern_kingdoms/burning_steppes/blackrock_depths/boss_magmus.cpp
    eastern_kingdoms/burning_steppes/blackrock_depths/boss_tomb_of_seven.cpp
    eastern_kingdoms/burning_steppes/blackrock_depths/instance_blackrock_depths.cpp
    eastern_kingdoms/burning_steppes/blackrock_spire/boss_halycon.cpp
    eastern_kingdoms/burning_steppes/blackrock_spire/boss_highlord_omokk.cpp
    eastern_kingdoms/burning_steppes/blackrock_spire/boss_overlord_wyrmthalak.cpp
    eastern_kingdoms/burning_steppes/blackrock_spire/boss_shadow_hunter_voshgajin.cpp
    eastern_kingdoms/burning_steppes/blackrock_spire/boss_the_beast.cpp
    eastern_kingdoms/burning_steppes/blackrock_spire/boss_urok.cpp
    eastern_kingdoms/burning_steppes/blackrock_spire/boss_warmaster_voone.cpp
    eastern_kingdoms/burning_steppes/blackrock_spire/instance_blackrock_spire.cpp
    eastern_kingdoms/burning_steppes/blackrock_spire/ubrs_trash.cpp
    eastern_kingdoms/burning_steppes/blackwing_lair/boss_broodlord_lashlayer.cpp
    eastern_kingdoms/burning_steppes/blackwing_lair/boss_chromaggus.cpp
    eastern_kingdoms/burning_steppes/blackwing_lair/boss_ebonroc.cpp
    eastern_kingdoms/burning_steppes/blackwing_lair/boss_firemaw.cpp
    eastern_kingdoms/burning_steppes/blackwing_lair/boss_flamegor.cpp
    eastern_kingdoms/burning_steppes/blackwing_lair/boss_nefarian.cpp
    eastern_kingdoms/burning_steppes/blackwing_lair/boss_razorgore.cpp
    eastern_kingdoms/burning_steppes/blackwing_lair/boss_vaelastrasz.cpp
    eastern_kingdoms/burning_steppes/blackwing_lair/boss_victor_nefarius.cpp
    eastern_kingdoms/burning_steppes/blackwing_lair/instance_blackwing_lair.cpp
    eastern_kingdoms/burning_steppes/molten_core/boss_baron_geddon.cpp
    eastern_kingdoms/burning_steppes/molten_core/boss_garr.cpp
    eastern_kingdoms/burning_steppes/molten_core/boss_gehennas.cpp
    eastern_kingdoms/burning_steppes/molten_core/boss_golemagg.cpp
    eastern_kingdoms/burning_steppes/molten_core/boss_lucifron.cpp
    eastern_kingdoms/burning_steppes/molten_core/boss_magmadar.cpp
    eastern_kingdoms/burning_steppes/molten_core/boss_majordomo_executus.cpp
    eastern_kingdoms/burning_steppes/molten_core/boss_ragnaros.cpp
    eastern_kingdoms/burning_steppes/molten_core/boss_shazzrah.cpp
    eastern_kingdoms/burning_steppes/molten_core/boss_sulfuron_harbinger.cpp
    eastern_kingdoms/burning_steppes/molten_core/instance_molten_core.cpp
    eastern_kingdoms/burning_steppes/molten_core/molten_core.cpp
    eastern_kingdoms/dun_morogh/dun_morogh.cpp
    eastern_kingdoms/dun_morogh/gnomeregan/boss_thermaplugg.cpp
    eastern_kingdoms/dun_morogh/gnomeregan/gnomeregan.cpp
    eastern_kingdoms/dun_morogh/gnomeregan/instance_gnomeregan.cpp
    eastern_kingdoms/duskwood/duskwood.cpp
    eastern_kingdoms/eastern_plaguelands/eastern_plaguelands.cpp
    eastern_kingdoms/eastern_plaguelands/naxxramas/boss_anubrekhan.cpp
    eastern_kingdoms/eastern_plaguelands/naxxramas/boss_faerlina.cpp
    eastern_kingdoms/eastern_plaguelands/naxxramas/boss_four_horsemen.cpp
    eastern_kingdoms/eastern_plaguelands/naxxramas/boss_gluth.cpp
    eastern_kingdoms/eastern_plaguelands/naxxramas/boss_gothik.cpp
    eastern_kingdoms/eastern_plaguelands/naxxramas/boss_grobbulus.cpp
    eastern_kingdoms/eastern_plaguelands/naxxramas/boss_heigan.cpp
    eastern_kingdoms/eastern_plaguelands/naxxramas/boss_kelthuzad.cpp
    eastern_kingdoms/eastern_plaguelands/naxxramas/boss_loatheb.cpp
    eastern_kingdoms/eastern_plaguelands/naxxramas/boss_maexxna.cpp
    eastern_kingdoms/eastern_plaguelands/naxxramas/boss_noth.cpp
    eastern_kingdoms/eastern_plaguelands/naxxramas/boss_patchwerk.cpp
    eastern_kingdoms/eastern_plaguelands/naxxramas/boss_razuvious.cpp
    eastern_kingdoms/eastern_plaguelands/naxxramas/boss_sapphiron.cpp
    eastern_kingdoms/eastern_plaguelands/naxxramas/boss_thaddius.cpp
    eastern_kingdoms/eastern_plaguelands/naxxramas/instance_naxxramas.cpp
    eastern_kingdoms/eastern_plaguelands/stratholme/boss_baroness_anastari.cpp
    eastern_kingdoms/eastern_plaguelands/stratholme/boss_cannon_master_willey.cpp
    eastern_kingdoms/eastern_plaguelands/stratholme/boss_dathrohan_balnazzar.cpp
    eastern_kingdoms/eastern_plaguelands/stratholme/boss_magistrate_barthilas.cpp
    eastern_kingdoms/eastern_plaguelands/stratholme/boss_maleki_the_pallid.cpp
    eastern_kingdoms/eastern_plaguelands/stratholme/boss_nerubenkan.cpp
    eastern_kingdoms/eastern_plaguelands/stratholme/boss_order_of_silver_hand.cpp
    eastern_kingdoms/eastern_plaguelands/stratholme/boss_postmaster_malown.cpp
    eastern_kingdoms/eastern_plaguelands/stratholme/boss_ramstein_the_gorger.cpp
    eastern_kingdoms/eastern_plaguelands/stratholme/boss_timmy_the_cruel.cpp
    eastern_kingdoms/eastern_plaguelands/stratholme/instance_stratholme.cpp
    eastern_kingdoms/eastern_plaguelands/stratholme/stratholme.cpp
    eastern_kingdoms/elwynn_forest/elwynn_forest.cpp
    eastern_kingdoms/hillsbrad_foothills/hillsbrad_foothills.cpp
    eastern_kingdoms/hinterlands/hinterlands.cpp
    eastern_kingdoms/loch_modan/loch_modan.cpp
    eastern_kingdoms/redridge_mountains/redridge_mountains.cpp
    eastern_kingdoms/searing_gorge/searing_gorge.cpp
    eastern_kingdoms/silverpine_forest/silverpine_forest.cpp
    eastern_kingdoms/silverpine_forest/shadowfang_keep/instance_shadowfang_keep.cpp
    eastern_kingdoms/stormwind_city/quest_stormwind_rendezvous.cpp
    eastern_kingdoms/stormwind_city/stormwind_city.cpp
    eastern_kingdoms/stranglethorn_vale/stranglethorn_vale.cpp
    eastern_kingdoms/stranglethorn_vale/zulgurub/boss_arlokk.cpp
    eastern_kingdoms/stranglethorn_vale/zulgurub/boss_gahzranka.cpp
    eastern_kingdoms/stranglethorn_vale/zulgurub/boss_grilek.cpp
    eastern_kingdoms/stranglethorn_vale/zulgurub/boss_hakkar.cpp
    eastern_kingdoms/stranglethorn_vale/zulgurub/boss_hazzarah.cpp
    eastern_kingdoms/stranglethorn_vale/zulgurub/boss_jeklik.cpp
    eastern_kingdoms/stranglethorn_vale/zulgurub/boss_jindo.cpp
    eastern_kingdoms/stranglethorn_vale/zulgurub/boss_mandokir.cpp
    eastern_kingdoms/stranglethorn_vale/zulgurub/boss_marli.cpp
    eastern_kingdoms/stranglethorn_vale/zulgurub/boss_renataki.cpp
    eastern_kingdoms/stranglethorn_vale/zulgurub/boss_thekal.cpp
    eastern_kingdoms/stranglethorn_vale/zulgurub/boss_venoxis.cpp
    eastern_kingdoms/stranglethorn_vale/zulgurub/boss_wushoolay.cpp
    eastern_kingdoms/stranglethorn_vale/zulgurub/instance_zulgurub.cpp
    eastern_kingdoms/stranglethorn_vale/zulgurub/zulgurub_trash.cpp
    eastern_kingdoms/swamp_of_sorrows/swamp_of_sorrows.cpp
    eastern_kingdoms/swamp_of_sorrows/sunken_temple/instance_sunken_temple.cpp
    eastern_kingdoms/swamp_of_sorrows/sunken_temple/sunken_temple.cpp
    eastern_kingdoms/tirisfal_glades/scarlet_monastery/boss_arcanist_doan.cpp
    eastern_kingdoms/tirisfal_glades/scarlet_monastery/boss_azshir_the_sleepless.cpp
    eastern_kingdoms/tirisfal_glades/scarlet_monastery/boss_herod.cpp
    eastern_kingdoms/tirisfal_glades/scarlet_monastery/boss_high_inquisitor_fairbanks.cpp
    eastern_kingdoms/tirisfal_glades/scarlet_monastery/boss_houndmaster_loksey.cpp
    eastern_kingdoms/tirisfal_glades/scarlet_monastery/boss_interrogator_vishas.cpp
    eastern_kingdoms/tirisfal_glades/scarlet_monastery/instance_scarlet_monastery.cpp
    eastern_kingdoms/uldaman/boss_archaedas.cpp
    eastern_kingdoms/uldaman/boss_ironaya.cpp
    eastern_kingdoms/uldaman/instance_uldaman.cpp
    eastern_kingdoms/uldaman/uldaman.cpp
    eastern_kingdoms/undercity/undercity.cpp
    eastern_kingdoms/western_plaguelands/western_plaguelands.cpp
    eastern_kingdoms/western_plaguelands/scholomance/boss_doctor_theolen_krastinov.cpp
    eastern_kingdoms/western_plaguelands/scholomance/boss_illucia_barov.cpp
    eastern_kingdoms/western_plaguelands/scholomance/boss_instructor_malicia.cpp
    eastern_kingdoms/western_plaguelands/scholomance/boss_jandice_barov.cpp
    eastern_kingdoms/western_plaguelands/scholomance/boss_kormok.cpp
    eastern_kingdoms/western_plaguelands/scholomance/boss_lord_alexei_barov.cpp
    eastern_kingdoms/western_plaguelands/scholomance/boss_lorekeeper_polkelt.cpp
    eastern_kingdoms/western_plaguelands/scholomance/boss_ras_frostwhisper.cpp
    eastern_kingdoms/western_plaguelands/scholomance/boss_the_ravenian.cpp
    eastern_kingdoms/western_plaguelands/scholomance/boss_vectus.cpp
    eastern_kingdoms/western_plaguelands/scholomance/instance_scholomance.cpp
    eastern_kingdoms/western_plaguelands/scholomance/scholo_trash.cpp
    eastern_kingdoms/westfall/westfall.cpp
    eastern_kingdoms/westfall/deadmines/boss_mr_smite.cpp
    eastern_kingdoms/westfall/deadmines/deadmines.cpp
    eastern_kingdoms/westfall/deadmines/instance_deadmines.cpp
    eastern_kingdoms/wetlands/wetlands.cpp
    kalimdor/ashenvale/ashenvale.cpp
    kalimdor/ashenvale/blackfathom_deeps/instance_blackfathom_deeps.cpp
    kalimdor/azshara/azshara.cpp
    kalimdor/darkshore/darkshore.cpp
    kalimdor/desolace/desolace.cpp
    kalimdor/desolace/maraudon/boss_celebras_the_cursed.cpp
    kalimdor/desolace/maraudon/boss_landslide.cpp
    kalimdor/desolace/maraudon/boss_noxxion.cpp
    kalimdor/desolace/maraudon/instance_maraudon.cpp
    kalimdor/durotar/durotar.cpp
    kalimdor/dustwallow_marsh/dustwallow_marsh.cpp
    kalimdor/dustwallow_marsh/onyxias_lair/boss_onyxia.cpp
    kalimdor/dustwallow_marsh/onyxias_lair/instance_onyxia_lair.cpp
    kalimdor/felwood/felwood.cpp
    kalimdor/feralas/feralas.cpp
    kalimdor/feralas/dire_maul/boss_gordok_king.cpp
    kalimdor/feralas/dire_maul/boss_immol_thar.cpp
    kalimdor/feralas/dire_maul/boss_tendris_warpwood.cpp
    kalimdor/feralas/dire_maul/boss_zevrim.cpp
    kalimdor/feralas/dire_maul/dreadsteed_ritual.cpp
    kalimdor/feralas/dire_maul/instance_dire_maul.cpp
    kalimdor/moonglade/boss_omen.cpp
    kalimdor/moonglade/moonglade.cpp
    kalimdor/mulgore/mulgore.cpp
    kalimdor/silithus/silithus.cpp
    kalimdor/silithus/ruins_of_ahnqiraj/boss_ayamiss.cpp
    kalimdor/silithus/ruins_of_ahnqiraj/boss_buru.cpp
    kalimdor/silithus/ruins_of_ahnqiraj/boss_kurinnaxx.cpp
    kalimdor/silithus/ruins_of_ahnqiraj/boss_moam.cpp
    kalimdor/silithus/ruins_of_ahnqiraj/boss_ossirian.cpp
    kalimdor/silithus/ruins_of_ahnqiraj/instance_ruins_of_ahnqiraj.cpp
    kalimdor/silithus/ruins_of_ahnqiraj/npc_sandstalker.cpp
    kalimdor/silithus/ruins_of_ahnqiraj/ruins_of_ahnqiraj.cpp
    kalimdor/silithus/temple_of_ahnqiraj/boss_bug_trio.cpp
    kalimdor/silithus/temple_of_ahnqiraj/boss_cthun.cpp
    kalimdor/silithus/temple_of_ahnqiraj/boss_fankriss.cpp
    kalimdor/silithus/temple_of_ahnqiraj/boss_huhuran.cpp
    kalimdor/silithus/temple_of_ahnqiraj/boss_ouro.cpp
    kalimdor/silithus/temple_of_ahnqiraj/boss_sartura.cpp
    kalimdor/silithus/temple_of_ahnqiraj/boss_skeram.cpp
    kalimdor/silithus/temple_of_ahnqiraj/boss_twinemperors.cpp
    kalimdor/silithus/temple_of_ahnqiraj/boss_viscidus.cpp
    kalimdor/silithus/temple_of_ahnqiraj/instance_temple_of_ahnqiraj.cpp
    kalimdor/silithus/temple_of_ahnqiraj/mob_anubisath_sentinel.cpp
    kalimdor/stonetalon_mountains/stonetalon_mountains.cpp
    kalimdor/tanaris/tanaris.cpp
    kalimdor/tanaris/zulfarrak/instance_zulfarrak.cpp
    kalimdor/tanaris/zulfarrak/zulfarrak.cpp
    kalimdor/teldrassil/teldrassil.cpp
    kalimdor/the_barrens/the_barrens.cpp
    kalimdor/the_barrens/razorfen_downs/instance_razorfen_downs.cpp
    kalimdor/the_barrens/razorfen_downs/razorfen_downs.cpp
    kalimdor/the_barrens/razorfen_kraul/instance_razorfen_kraul.cpp
    kalimdor/the_barrens/razorfen_kraul/razorfen_kraul.cpp
    kalimdor/the_barrens/wailing_caverns/instance_wailing_caverns.cpp
    kalimdor/the_barrens/wailing_caverns/wailing_caverns.cpp
    kalimdor/thousand_needles/thousand_needles.cpp
    kalimdor/ungoro_crater/ungoro_crater.cpp
    kalimdor/winterspring/winterspring.cpp
    world/areatrigger_scripts.cpp
    world/elemental_invasions.cpp
    world/fireworks_show.cpp
    world/go_scripts.cpp
    world/npcs_special.cpp
    world/totems.cpp
    world/scourge_invasion.cpp
    world/scourge_invasion.h
    world/world_event_wareffort.cpp
    world/world_event_wareffort.h
    world/dragons_of_nightmare/boss_dragon_of_nightmare.cpp
    world/dragons_of_nightmare/boss_emeriss.cpp
    world/dragons_of_nightmare/boss_lethon.cpp
    world/dragons_of_nightmare/boss_taerar.cpp
    world/dragons_of_nightmare/boss_ysondre.cpp

)

if((${CMAKE_VERSION} VERSION_LESS "3.16") OR USE_PCH_OLD)
  list(APPEND SCRIPTS_SRCS
        PrecompiledHeaders/scriptPCH.cpp
    )
  # Enable precompiled headers when using the GCC compiler.
  if(USE_PCH)
    include_directories(${CMAKE_CURRENT_BINARY_DIR})
  endif()
endif()

if(WIN32)
  if(MINGW)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fpermissive")
  endif()
endif()

# Used in game ScriptMgr, not need here
list(REMOVE_ITEM SCRIPTS_SRCS ScriptLoader.cpp)
list(REMOVE_ITEM SCRIPTS_SRCS ScriptLoader_noscripts.cpp)
list(REMOVE_ITEM SCRIPTS_SRCS ScriptLoader.h)

foreach(SRC ${SCRIPTS_SRCS})
  get_filename_component(PTH ${SRC} PATH)
  if(PTH)
    if(NOT XCODE) # FIXME: Xcode Generator has bug with nested dirs
      string(REPLACE "/" "\\\\" PTH ${PTH})
    endif()
    source_group(${PTH} FILES ${SRC})
  endif()
endforeach(SRC)

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}/PrecompiledHeaders
  ${CMAKE_SOURCE_DIR}/src/shared
  ${CMAKE_SOURCE_DIR}/src/framework
  ${CMAKE_SOURCE_DIR}/src/framework/Network
  ${CMAKE_SOURCE_DIR}/src/game
  ${CMAKE_SOURCE_DIR}/src/game/AI
  ${CMAKE_SOURCE_DIR}/src/game/Anticheat
  ${CMAKE_SOURCE_DIR}/src/game/AuctionHouse
  ${CMAKE_SOURCE_DIR}/src/game/Battlegrounds
  ${CMAKE_SOURCE_DIR}/src/game/Chat
  ${CMAKE_SOURCE_DIR}/src/game/Commands
  ${CMAKE_SOURCE_DIR}/src/game/Database
  ${CMAKE_SOURCE_DIR}/src/game/Group
  ${CMAKE_SOURCE_DIR}/src/game/Guild
  ${CMAKE_SOURCE_DIR}/src/game/Handlers
  ${CMAKE_SOURCE_DIR}/src/game/LFG
  ${CMAKE_SOURCE_DIR}/src/game/Mail
  ${CMAKE_SOURCE_DIR}/src/game/Maps
  ${CMAKE_SOURCE_DIR}/src/game/Maps/Pool
  ${CMAKE_SOURCE_DIR}/src/game/Movement
  ${CMAKE_SOURCE_DIR}/src/game/Movement/spline
  ${CMAKE_SOURCE_DIR}/src/game/Objects
  ${CMAKE_SOURCE_DIR}/src/game/OutdoorPvP
  ${CMAKE_SOURCE_DIR}/src/game/PlayerBots
  ${CMAKE_SOURCE_DIR}/src/game/Protocol
  ${CMAKE_SOURCE_DIR}/src/game/Spells
  ${CMAKE_SOURCE_DIR}/src/game/Threat
  ${CMAKE_SOURCE_DIR}/src/game/Transports
  ${CMAKE_SOURCE_DIR}/src/game/vmap
  ${CMAKE_SOURCE_DIR}/dep/include
  ${CMAKE_SOURCE_DIR}/dep/recastnavigation
  ${CMAKE_SOURCE_DIR}/dep/include/g3dlite
  ${CMAKE_SOURCE_DIR}/dep/recastnavigation/Detour/Include
  ${CMAKE_BINARY_DIR}
  ${CMAKE_BINARY_DIR}/src/shared
  ${TBB_INCLUDE_DIRS}
  ${ACE_INCLUDE_DIR}
  ${MYSQL_INCLUDE_DIR}
)

add_library(${LIBRARY_NAME} STATIC
  ${SCRIPTS_SRCS}
)

SET_TARGET_PROPERTIES (${LIBRARY_NAME} PROPERTIES FOLDER "Game Libs")

target_link_libraries(scripts
  game
)

#add_dependencies(${LIBRARY_NAME} revision.h)

if((${CMAKE_VERSION} VERSION_LESS "3.16") OR USE_PCH_OLD)
  if(USE_PCH)
    if(MSVC OR XCODE)
      if(MSVC)
        set(scripts_pch "${CMAKE_CURRENT_SOURCE_DIR}/PrecompiledHeaders/scriptPCH.cpp")
      endif()
      add_native_precompiled_header(scripts ${CMAKE_CURRENT_SOURCE_DIR}/PrecompiledHeaders/scriptPCH.h)
    elseif(CMAKE_COMPILER_IS_GNUCXX)
      add_precompiled_header(scripts ${CMAKE_CURRENT_SOURCE_DIR}/PrecompiledHeaders/scriptPCH.h)
    endif()
  endif()
else()
  set(PCHS
      ../game/Mail/Mail.h
      ../game/ScriptMgr.h
      ../game/Objects/Object.h
      ../game/ObjectMgr.h
      ../game/Objects/Unit.h
      ../game/Spells/Spell.h
      ../game/Objects/Creature.h
      ../game/AI/CreatureAI.h
      ../game/Objects/GameObject.h
      ../game/GameEventMgr.h
      ../game/AI/ScriptedAI.h
      ../game/AI/ScriptedPetAI.h
      ../game/AI/ScriptedGameObject.h
      ../game/AI/ScriptedFollowerAI.h
      ../game/AI/ScriptedEscortAI.h
      ../game/ScriptedGossip.h
      ../game/Maps/GridSearchers.h
      ../game/AI/ScriptedInstance.h
      ../game/Spells/SpellAuras.h
      ../game/Objects/TemporarySummon.h
      ../game/AI/NullCreatureAI.h
      ../game/Chat/Chat.h
      ../game/Battlegrounds/BattleGroundAV.h
      ../game/World.h
      ../game/Weather.h
      ../game/AI/TotemAI.h
      PrecompiledHeaders/scriptPCH.h
      )

  if(WIN32)
      list(APPEND PCHS <windows.h>)
  endif()

  # Generate precompiled header
  if(USE_PCH)
      target_precompile_headers(${LIBRARY_NAME} PRIVATE
          ${PCHS}
          )
  endif()
endif()

