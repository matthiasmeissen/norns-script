Engine_Synth_04 : CroneEngine {

    var synth;

	alloc {

        SynthDef("Synth1", {
	        arg freq = 300, sub_div = 5, noise_level = 0.1, 
	        cutoff = 6000, resonance = 1, amp = 0.2;
            
	        var pulse = Pulse.ar(freq: freq);
	        var saw = Saw.ar(freq: freq);
	        var sub = Pulse.ar(freq: freq / sub_div);
	        var noise = WhiteNoise.ar(mul: noise_level);
	
	        var env = EnvGen.kr(Env(
		        [0, 1, 0],
		        [0.2, 0.6],
		        [0, 0]), 
                doneAction: 2
	        );
            
	        var mix = Mix([pulse, saw, sub, noise]);
	        var filter = MoogFF.ar(in: mix, freq: cutoff, gain: resonance) * env;
	        var snd = Pan2.ar(filter, 0) * amp;
            
	        Out.ar(0, snd);
        }).add;
        

        this.addCommand("play","f", { arg msg;
        	Synth.new("Synth1");
        });
	}

    free {
		synth.free;
    }
}
