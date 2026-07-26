# PWM Generator on a Basys 3 FPGA

A PWM generator on the Basys 3 FPGA. You can set a value with the buttons (controls below) and it shows up on the 7-segment display. That value determines the brightness of all 16 LEDs.

PWM duty cycle: 0 is off, 255 is full brightness.

## Buttons

- **Right** — +1
- **Left** — −1
- **Up** — +10
- **Down** — −10
- **Center** — reset to 0

All five are debounced (10 ms) so one press counts once.

## How it works

The value is compared against a free-running 8-bit counter. The LED is on while the counter is below the value, off above it. so a bigger value means the LED is on for more of each cycle, which looks brighter. That's the PWM duty cycle.

## Modules

- `top_module.v` — wires everything together
- `buttons.v` — reads the buttons and holds the count (0–255)
- `debounce.v` — one debouncer, instantiated once per button
- `pwm_generator.v` — makes the PWM signal from the value
- `sevenseg.v` — drives the 4-digit display

​```
top_module
├── button_counter → debounce (×5)
├── pwm_gen
└── seven_seg
​```

## Building

Open in Vivado, target the Basys 3 (`xc7a35tcpg236-1`), add the source files, and generate the bitstream.

## Future Improvements:

- Create functionality for other electronics such as motors, sound, VGA, etc.
- Generate multiple independent PWM waves per component
- Manually edit independent PWM waves with switches
