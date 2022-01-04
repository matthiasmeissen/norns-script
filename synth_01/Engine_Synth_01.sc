Engine_Synth_01 : CroneEngine {

    var params;

	alloc {

        SynthDef("Synth_1", {
	        arg freq = 300, sub_div = 5, noise_level = 0.1, 
            cutoff = 6000, resonance = 1,
            attack = 0.3, release = 2,
            amp = 0.2, pan = 0, out = 0;
            
            var pulse = Pulse.ar(freq: freq);
            var saw = Saw.ar(freq: freq);
            var sub = Pulse.ar(freq: freq / sub_div);
            var noise = WhiteNoise.ar(mul: noise_level);
            
            var mix = Mix([pulse, saw, sub, noise]);
            
            var envelope = Env.perc(attackTime: attack, releaseTime: release, level: amp).kr(doneAction: 2);
            
            var filter = MoogFF.ar(in: mix, freq: cutoff * envelope, gain: resonance);
            
            var snd = Pan2.ar(filter * envelope, pan);
            
            Out.ar(out, snd);
        }).add;
        

        this.addCommand("play", "f", { arg msg;
            Synth.new("Synth_1");
        });
		
	}

}