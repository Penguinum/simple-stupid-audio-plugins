<Cabbage>
form size(250, 130), caption("Sine"), pluginID("simple-sine")
keyboard bounds(0, 80, 250, 50)

groupbox bounds(0, 0, 50, 80), text("Sine"), preset("preset"), plant("sine"), colour(20, 20, 20) {
    rslider bounds(0, 25, 50, 50), channel("amp"), range(0, 0.7, 0.3, 1, 0.01), text("amp")
}
groupbox bounds(50, 0, 200, 80), text("Envelope"), preset("preset"), plant("envelope"), colour(20, 20, 20) {
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
0dbfs=1

instr 1
    iamp chnget "amp"
    iatt chnget "a"
    idec chnget "d"
    isus chnget "s"
    irel chnget "r"

    asig oscil iamp, p4, 1
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
