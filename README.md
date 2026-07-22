# sml-spectrum

[![CI](https://github.com/sjqtentacles/sml-spectrum/actions/workflows/ci.yml/badge.svg)](https://github.com/sjqtentacles/sml-spectrum/actions/workflows/ci.yml)

Zero-dependency Standard ML library for spectroscopy and astrophysical calculations.

## API

```sml
signature SPECTRUM =
sig
  val c        : real   (* speed of light: 2.99792458e8 m/s *)
  val h        : real   (* Planck constant: 6.62607015e-34 J·s *)
  val eVJoule  : real   (* 1 eV in Joules: 1.602176634e-19 *)
  val rInf     : real   (* Rydberg constant: 1.0973731568e7 /m *)

  val wavelengthToFreq : real -> real        (* m -> Hz *)
  val freqToWavelength : real -> real        (* Hz -> m *)
  val wavenumber       : real -> real        (* m -> m^-1 *)
  val photonEnergyJ    : real -> real        (* wavelength m -> J *)
  val photonEnergyEv   : real -> real        (* wavelength m -> eV *)

  val dopplerClassical    : {restM:real, vMs:real} -> real
  val dopplerRelativistic : {restM:real, beta:real} -> real

  val redshiftFromWavelength : {observed:real, rest:real} -> real
  val velocityFromZ          : real -> real

  val rydberg : {n1:int, n2:int} -> real
end
```

## Worked example

```sml
(* Wavelength of H-alpha (Balmer series, n=3->n=2) *)
val hAlpha = Spectrum.rydberg {n1=2, n2=3}
(* ~656.3 nm *)

(* Photon energy of 500 nm green light *)
val eV = Spectrum.photonEnergyEv 500.0e~9
(* ~2.48 eV *)

(* Classical Doppler redshift at 300 km/s recession *)
val shifted = Spectrum.dopplerClassical {restM=656.3e~9, vMs=3.0e5}
```

## Example

`make example` builds and runs [`examples/demo.sml`](examples/demo.sml), which
prints the module's physical constants and walks through wavelength/frequency
conversion, photon energy, classical and relativistic Doppler shift, cosmological
redshift, and the hydrogen Rydberg series (output is byte-identical under MLton
and Poly/ML):

```
Physical constants:
  c       = 299792458.000000 m/s
  h       = 6.626070  (x1e-34 J*s)
  eVJoule = 1.602177  (x1e-19 J)
  rInf    = 1.097373  (x1e7 /m)

Visible light at 500 nm:
  frequency        = 599.5849 THz
  round-trip       = 500.0000 nm
  wavenumber       = 2.000000  (x1e6 /m)
  photon energy    = 3.9729  (x1e-19 J) = 2.4797 eV

H-alpha (656.3 nm) Doppler shift at 300 km/s recession:
  beta (v/c)       = 0.001001
  classical shift  = 656.9568 nm
  relativistic     = 656.9571 nm

Cosmological redshift, observed 658.0 nm vs rest 656.3 nm:
  z                = 0.002590
  recession vel    = 775.5403 km/s

Hydrogen Rydberg series, n=3 -> n=2 (H-alpha check):
  wavelength       = 656.1123 nm
```

## Scope and limitations

- Covers single-photon optics, Doppler shifts, Rydberg formula, and cosmological redshift.
- Does not model spectral line broadening, absorption coefficients, or radiative transfer.
- The Rydberg formula applies to hydrogen-like atoms only.
- Relativistic Doppler assumes radial motion; no transverse term.

## Build and test

Requires [MLton](http://mlton.org/) and Poly/ML in PATH.

```
make all-tests
```
