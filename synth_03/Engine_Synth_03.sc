Engine_Synth_03 : CroneEngine {

    var synth;

    *new { arg context, doneCallback;
		^super.new(context, doneCallback);
	}

	alloc {

        SynthDef("Synth1", {
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

        synth = Synth("Synth1", target:context.server);
        

        this.addCommand("amp","f", { arg msg;
        	synth.set('amp', msg[1]);
        });

        this.addCommand("cutoff","f", { arg msg;
        	synth.set('cutoff', msg[1]);
        });
		
	}

    free {
		synth.free;
    }
}
