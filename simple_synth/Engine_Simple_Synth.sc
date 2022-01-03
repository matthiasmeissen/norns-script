Engine_Simple_Synth : CroneEngine {

	var simpleSynth;

	*new { arg context, doneCallback;
		^super.new(context, doneCallback);
	}

	alloc {
		// define synth
		SynthDef("Simple Oscillator", {
		    arg freq=110.0,amp=0;
		    var snd;
		    snd=SinOsc.ar([freq,freq+2]);
			Out.ar(0,snd*amp);
		}).add;

		context.server.sync;

		// create synth
        simpleSynth = Synth("Simple Oscillator", target:context.server);

		// define commands for lua script
        this.addCommand("amp","f", { arg msg;
        	simpleSynth.set(\amp,msg[1]);
        });
        this.addCommand("hz","f", { arg msg;
        	simpleSynth.set(\freq,msg[1]);
        });
        this.addCommand("note","i", { arg msg;
        	simpleSynth.set(\freq,msg[1].midicps);
        });
	}

    free {
		// free any variable created
		simpleSynth.free;
    }
}
