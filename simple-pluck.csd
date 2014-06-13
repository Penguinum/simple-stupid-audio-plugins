<Cabbage>
form size(600, 130), caption("Pluck"), pluginID("simple-pluck")
keyboard bounds(0, 80, 600, 50)

groupbox bounds(0, 0, 400, 80), text("Karplus-Strong pluck"), plant("pluck"), preset("pluck"), colour(20, 20, 20) {
    combobox bounds(5, 32, 140, 30), channel("method"), items("Simple averaging", "Stretched averaging", "Simple drum", "Stretched drum", "Weighted averaging", "Recursive filter")
    rslider bounds(150, 25, 50, 50), channel("amplitude"), range(0, 1, 0.5),                    text("amplitude")
    rslider bounds(210, 25, 50, 50), channel("freqbuf"),   range(1, 100000, 10000, 0.3, 1),     text("buf freq") 
    rslider bounds(270, 25, 50, 50), channel("smooth1"),   range(0, 100, 0, 0.3, 0.001),        text("smooth1") 
    rslider bounds(330, 25, 50, 50), channel("smooth2"),   range(0, 100, 0, 0.3, 0.001),        text("smooth2") 
}

groupbox bounds(400, 0, 200, 80), text("Envelope"), preset("preset"), plant("envelope"), colour(20, 20, 20) {
    rslider bounds(0,   25, 50, 50), channel("a"), range(0.001, 10, 0.001, 0.4, 0.001), text("a")
    rslider bounds(50,  25, 50, 50), channel("d"), range(0.001, 10, 1, 0.4, 0.001),     text("d")
    rslider bounds(100, 25, 50, 50), channel("s"), range(0.001, 10, 1, 0.4, 0.001),     text("s")
    rslider bounds(150, 25, 50, 50), channel("r"), range(0.001, 10, 1, 0.4, 0.001),     text("r")
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
    kamp chnget "amplitude"
    imeth chnget "method"
    iparm1 chnget "smooth1"
    iparm2 chnget "smooth2"
    icps chnget "freqbuf"
    iatt chnget "a"
    idec chnget "d"
    isus chnget "s"
    irel chnget "r"

    asig pluck kamp, p4, icps, 0, imeth, iparm1, iparm2
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
