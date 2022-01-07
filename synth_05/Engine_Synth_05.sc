Engine_Synth_05 : CroneEngine {

    var synth;
    var synth_attack = 0.2;
    var synth_release = 0.6;
    var synth_cutoff = 6000;
    var synth_resonance = 1;

    alloc {

        SynthDef("Synth1", {
            arg freq = 300, sub_div = 5, noise_level = 0.1, 
            attack = 0.2, release = 0.6,
            cutoff = 6000, resonance = 1, amp = 0.2;

            var pulse = Pulse.ar(freq: freq);
            var saw = Saw.ar(freq: freq);
            var sub = Pulse.ar(freq: freq / sub_div);
            var noise = WhiteNoise.ar(mul: noise_level);

            var env = EnvGen.kr(Env(
                [0, 1, 0],
                [attack, release],
                [0, 0]), 
                doneAction: 2
            );

            var mix = Mix([pulse, saw, sub, noise]);
            var filter = MoogFF.ar(in: mix, freq: cutoff, gain: resonance) * env;
            var snd = Pan2.ar(filter, 0) * amp;

            Out.ar(0, snd);
        }).add;


        this.addCommand("play","f", { arg msg;
            Synth.new("Synth1", [attack: synth_attack, release: synth_release]);
        });
        
        this.addCommand("attack","f", { arg msg;
            synth_attack = msg[1];
        });
        
        this.addCommand("release","f", { arg msg;
            synth_release = msg[1];
        });
        
        this.addCommand("cutoff","f", { arg msg;
            synth_cutoff = msg[1];
        });
        
        this.addCommand("resonance","f", { arg msg;
            synth_resonance = msg[1];
        });

}

    free {
        synth.free;
    }
}
