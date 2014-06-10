<Cabbage>
form size(500, 130), caption("FM-synth"), pluginID("simple-fm")
keyboard bounds(0, 80, 500, 50)

groupbox bounds(0, 0, 300, 80), text("Fm Synth"), preset("preset"), plant("synth") {
    rslider bounds(0, 25, 50, 50), channel("ampl"), range(0, 1, 0.3, 0.5), text("ampl") 
    rslider bounds(50, 25, 50, 50), channel("mod"), range(0, 200, 50, 0.5, 1), text("mod")
    rslider bounds(100, 25, 50, 50), channel("l1"), range(0, 100, 0, 0.2, 0.001), text("l1")
    rslider bounds(150, 25, 50, 50), channel("l2"), range(0, 100, 3, 0.2, 0.001), text("l2")
    rslider bounds(200, 25, 50, 50), channel("l3"), range(0, 100, 0.005, 0.2, 0.001), text("l3")
    rslider bounds(250, 25, 50, 50), channel("car"), range(1, 15, 3, 1, 1), text("car")
}

groupbox bounds(300, 0, 200, 80), text("Envelope"), preset("preset"), plant("envelope") {
    rslider bounds(0, 25, 50, 50), channel("a"), range(0.001, 10, 0.001, 0.4, 0.001), text("a")
    rslider bounds(50, 25, 50, 50), channel("d"), range(0.001, 10, 1, 0.4, 0.001), text("d")
    rslider bounds(100, 25, 50, 50), channel("s"), range(0.001, 10, 1, 0.4, 0.001), text("s")
    rslider bounds(150, 25, 50, 50), channel("r"), range(0.001, 10, 1, 0.4, 0.001), text("r")
}
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 64
nchnls = 2
0dbfs = 1

instr 1
    icps cpsmidi
    ivel veloc 0,1
    kbend pchbend 0,2
    gkamp chnget "ampl"
    kmod chnget "mod"
    iline1 chnget "l1"
    iline2 chnget "l2"
    iline3 chnget "l3"
    kcarraw chnget "car"
    kcarraw = int(kcarraw)
    iatt chnget "a"
    idec chnget "d"
    isus chnget "s"
    irel chnget "r"
    kcar pow 2, (kcarraw-4)
    kamp = gkamp*ivel
    kcps = icps*semitone(kbend)
    kndx line iline1, iline2, iline3
    ifn = 1
    asig foscil kamp, kcps, kcar, kmod, kndx, ifn
    kadsr mxadsr iatt, idec, isus, irel
    ares = asig*kadsr
    outs ares, ares
endin

</CsInstruments>  
<CsScore>
f1 0 1024 10 1
f0 3600
</CsScore>
</CsoundSynthesizer>
