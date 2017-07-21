include ../test/more.proc

# KlattSlope.praat
# Paul Boersma, 25 November 2010

# This script tests whether a sound created with the Klatt synthesizer
# is similar to a sound created with "To Sound (phonation)".

@no_plan()

openPhase = 0.7
collisionPhase = 0.03
power = 3.0
f1 = 250
b1 = 100
f2 = 3200
b2 = 100
duration = 0.8
f0start = 150
f0end = 110

procedure formant_bandwith: .formant
  formant_bandwidth = (.formant - 0.5) * 1000 / 10
endproc

numberOfFormants = 20

pitchTier = Create PitchTier: "a", 0, duration
Add point: 0, f0start
Add point: duration, f0end
pulses = To PointProcess
sound = To Sound (phonation):
   ... 44100, 1, 0.05, openPhase, collisionPhase, power, power + 1

Filter with one formant (in-line): f1, b1
Filter with one formant (in-line): f2, b2
for formant from 3 to numberOfFormants
   @formant_bandwith: formant
   Filter with one formant (in-line): (formant - 0.5) * 1000, formant_bandwidth
endfor

spectrum = To Spectrum: "yes"
slope1 = Get band density difference: 0, 1000, 2000, 4000

removeObject: pitchTier, pulses, sound, spectrum

klatt = Create KlattGrid: "a", 0, duration, numberOfFormants, 0, 0, 0, 0, 0, 0
Add voicing amplitude point: 0, 90.0
Add pitch point: 0, f0start
Add pitch point: duration, f0end
Add power1 point: 0, power
Add power2 point: 0, power + 1
Add open phase point: 0, openPhase
Add collision phase point: 0, collisionPhase
Add oral formant frequency point: 1, 0, f1
Add oral formant bandwidth point: 1, 0, b1
Add oral formant frequency point: 2, 0, f2
Add oral formant bandwidth point: 2, 0, b2
for formant from 3 to numberOfFormants
   @formant_bandwith: formant
   Add oral formant frequency point: formant, 0, (formant - 0.5) * 1000
   Add oral formant bandwidth point: formant, 0, formant_bandwidth
endfor
sound = To Sound
spectrum = To Spectrum: "yes"
slope2 = Get band density difference: 0, 1000, 2000, 4000

removeObject: klatt, sound, spectrum

@diag: "Phonation slope: " + fixed$(slope1, 6) + " dB"
@diag: "Klatt slope:     " + fixed$(slope2, 6) + " dB"
@is_approx: slope1, slope2, 3, "Slopes of sounds are similar"

@ok_selection()

@done_testing()
