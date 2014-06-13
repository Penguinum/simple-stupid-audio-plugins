<Cabbage>
form size(660, 130), caption("Pluck"), pluginID("simple-pluck")
keyboard bounds(0, 80, 660, 50)

groupbox bounds(0, 0, 460, 80), text("Karplus-Strong pluck"), plant("pluck"), preset("pluck"), colour(20, 20, 20) {
    combobox bounds(5, 30, 130, 30), channel("method"), items("Simple averaging", "Stretched averaging", "Simple drum", "Stretched drum", "Weighted averaging", "Recursive filter"), colour(17, 17, 17)
    label bounds(27, 62, 80, 12), text("decay method")
    combobox bounds(140, 30, 75, 30), channel(ftable), items("Random", "Sine"), colour(17, 17, 17)
    label bounds(150, 62, 50, 12), text("ftable")
    rslider bounds(220, 25, 50, 50), channel("amplitude"), range(0, 1, 0.5),                    text("ampl")
    rslider bounds(280, 25, 50, 50), channel("freqbuf"),   range(1, 100000, 10000, 0.3, 1),     text("buf freq") 
    rslider bounds(340, 25, 50, 50), channel("smooth1"),   range(0, 100, 0, 0.3, 0.001),        text("smooth1") 
    rslider bounds(400, 25, 50, 50), channel("smooth2"),   range(0, 100, 0, 0.3, 0.001),        text("smooth2") 
}

groupbox bounds(460, 0, 200, 80), text("Envelope"), preset("preset"), plant("envelope"), colour(20, 20, 20) {
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
    ifn chnget "ftable"
    iparm1 chnget "smooth1"
    iparm2 chnget "smooth2"
    icps chnget "freqbuf"
    iatt chnget "a"
    idec chnget "d"
    isus chnget "s"
    irel chnget "r"

    asig pluck kamp, p4, icps, ifn-1, imeth, iparm1, iparm2
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
