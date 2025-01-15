# 8bits-SAR-ADC-CHIP
Project for ESE5730 and ESE5750, chip design &amp; measurement

This repo includes all the detailed we made for this 2-semester, chip design(ESE5730) & measurement(ESE5750) courses, with all steps and thinking during this period.

## Chips-Design

Our technology is [TSMC 180nm](https://www.tsmc.com/english/dedicatedFoundry/technology/logic/l_018micron)


### Proposal

The first challenging part of this course is choosing a chip design topic—deciding what you want to design. For those with more experience in analog circuits, ideas like an equalizer might come to mind.

Personally, with a primarily digital background, I chose to work on a mixed-signal chip instead of a purely digital one. Here are a few reasons why:

1) Our technology is only 180nm, which is not enough to build accurate digital circuits. Ideally < 60nm is reasonable technology for doing that.

2) Pure digital chips can be difficult to measure. For a single-chip setup, the output signal is typically real and analog, making it hard to measure directly as binary values like 0 or 1.

3) According to the course handout, our initial step is to build the schematic in Cadence Virtuoso and simulate the expected results, similar to the traditional analog chip design process. This is quite different from a typical digital chip design flow, which involves RTL design, synthesis, verification, STA, CDC, and other steps before reaching the tape-out stage (from RTL to GDS).

After reviewing some research papers, we decided to replicate one of the designs: **8bit SAR ADC with 100Mhz clock frequency**.



## Chips-Measurement 


### Proposal 



### PCB design

We use Altium to design the simple 2-layer circuits board. (Without assembly!!!) For our design, we need several LDOs to get the stable 

### Off-chips Measurement 
