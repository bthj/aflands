# Sonic Pi playback function and usage example
# for a sample pack generated by synth.is
# published at
# https://synth.is/pub/sound/01eb1sh43v5ks1e4j0aj9phfbk_13_11_FM-AM-filter-distortion_6000

########### sample pack playback function

gated_distorted_realm_1596725652_sample_pack_parent_folder = "~/samples"
gated_distorted_realm_1596725652_sample_pack = "#{gated_distorted_realm_1596725652_sample_pack_parent_folder}/synth_is_01eb1sh43v5ks1e4j0aj9phfbk_13_11_FM-AM-filter-distortion_6000/01eb1sh43v5ks1e4j0aj9phfbk_13_11_FM-AM-filter-distortion_6000__samples/"

define :gated_distorted_realm_1596725652_player do |note, velocity, opts={}|
  sample gated_distorted_realm_1596725652_sample_pack, note.is_a?(Numeric) ? "midi#{note}" : "note#{note}", "vel#{velocity}", opts
end


########### example usage

gated_distorted_realm_1596725652_duration = 6.00
gated_distorted_realm_1596725652_sleep = gated_distorted_realm_1596725652_duration / 1.65
gated_distorted_realm_1596725652_attack = 0.01
gated_distorted_realm_1596725652_release = 1
gated_distorted_realm_1596725652_start = 0
gated_distorted_realm_1596725652_finish = 0.7

gated_distorted_realm_1596725652_velocities =
  [15,31,47,63,79,95,111,127].ring.butlast.stretch(2).reflect
two_tone_names = ["F4","A4"].ring
kick_sleep = 0.454
kick_sleep_multi = 1

playerOpts = {
  attack: gated_distorted_realm_1596725652_attack,
  release: gated_distorted_realm_1596725652_release,
  start: gated_distorted_realm_1596725652_start,
  finish: gated_distorted_realm_1596725652_finish,
  start: 0.05
}

live_loop :two_tone, delay: 0.01 do # about that delay: https://in-thread.sonic-pi.net/t/live-loops-sync-questions/1172/13
  gated_distorted_realm_1596725652_player two_tone_names.tick(:note_tick),
    gated_distorted_realm_1596725652_velocities.tick(:vel_tick),
    playerOpts
  sleep gated_distorted_realm_1596725652_sleep
end

live_loop :kick do
  sync :two_tone
  (8*kick_sleep_multi).round.times do
    sample :bd_haus, cutoff: rrand(66, 90), amp:1
    sleep kick_sleep / kick_sleep_multi
  end
end

with_fx :echo, phase: 0.125, mix: 0.4 do
  live_loop :cymbal do
    sync :two_tone
    (16*kick_sleep_multi).round.times do
      sample :drum_cymbal_soft, sustain: 0, release: 0.1, hpf_attack:2, amp:0.8
      sleep kick_sleep / 2 / kick_sleep_multi
    end
  end
end
