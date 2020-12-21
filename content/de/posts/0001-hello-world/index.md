---
id: 1
title: "How to measure water levels using raspi"
description: "How to measure water levels using raspi."
date: 2020-12-19T22:32:19+01:00
publishDate: 2020-12-19T22:21:42+01:00
author: "Alexander Held"
images: []
draft: false
tags: ["raspi", "sensors", "iot", "microcontroller"]
---

## Connections

Now let’s talk about the connections of the raspberry pi, ultrasonic sensor and Buzzer.Please follow the circuit diagram as given

![Wiring](https://content.instructables.com/ORIG/FUU/VKGC/K9R6AUTT/FUUVKGCK9R6AUTT.jpg?auto=webp&frame=1&fit=bounds&md=b31d299106cc04ccca9ffae0fe04f4b3)

- Ultrasonic sensor vcc to 5v of Raspberry Pi
- Ultrasonic sensor Gnd to Gnd of Raspberry Pi
- Trigger to GPIO 2
- Echo to GPIO 3
- Buzzer + to GPIO 4
- Buzzer – to Gnd

## Structure

![Structure](https://content.instructables.com/ORIG/FHQ/VQN7/K9D1RIS2/FHQVQN7K9D1RIS2.jpg?auto=webp&frame=1&width=1024&height=1024&fit=bounds&md=93c940d5a5b0f67365fa77ecaf466a5e)

- Attach a scale to the bucket.
- Next attach the buzzer and ultrasonic sensor to the scale

## Code

```python
print "hello world!"
```

## Testing

Fill water in the bucket. When the distance of ultrasonic sensor from the water is around 4 centimetre, the buzzer will beep, alerting the bucket is almost full.
