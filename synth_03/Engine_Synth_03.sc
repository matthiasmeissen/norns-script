Engine_Synth_03 : CroneEngine {

var synth;

	alloc {

        SynthDef("Synth_1", {
	        arg freq = 300, sub_div = 5, noise_level = 0.1, 
            cutoff = 6000, resonance = 1, amp = 0.2;
            
            var pulse = Pulse.ar(freq: freq);
            var saw = Saw.ar(freq: freq);
            var sub = Pulse.ar(freq: freq / sub_div);
            var noise = WhiteNoise.ar(mul: noise_level);
            
            var mix = Mix([pulse, saw, sub, noise]);
            var filter = MoogFF.ar(in: mix, freq: cutoff, gain: resonance);
            var snd = Pan2.ar(filter, 0) * amp;
            
            Out.ar(0, snd);
        }).add;


        context.server.sync;

        synth = Synth("Synth_01", target:context.server);
        

        this.addCommand("amp","f", { arg msg;
        	simpleSynth.set('amp', msg[1]);
        });

        this.addCommand("cut","f", { arg msg;
        	simpleSynth.set('cutoff', msg[1]);
        });
		
	}

}