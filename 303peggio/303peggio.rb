use_synth :tb303
live_loop :squelch do
  with_fx :reverb do
    with_fx :flanger, depth:4 do # depth: 2
      with_fx :compressor, relax_time:0.8, pre_mix: 0.9, amp: 2, slope_above: 0.5 do
        n = (ring :e1, :e2, :e3).tick
        play n, release: 0.125, cutoff: 38, res: 0.9, wave: 0  # cutoff: 18, release: 4, res: 0.999
        sleep 0.125
      end
    end
  end
end
