From: Eugen Hristev <eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [PATCH 00/14] iio: triggers: add consumer support
Date: Fri, 22 Dec 2017 17:07:07 +0200
Message-ID: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Eugen Hristev <eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hello,

I would like to introduce his patch series which implements:
- new iio channel IIO_POSITION
- new inkern API to expose iio triggers to consumer drivers
- new bindings for trigger consumer drivers in device tree
- new input touchscreen driver for SAMA5D2
- implementation of POSITION and PRESSURE channels in sama5d2_adc driver
- devicetree changes for sama5d2 soc w.r.t. resistive touchscreen.

The SAMA5D2 SOC contains the ADC IP which has support
for a resistive touchscreen inside, using channels 0,1,2,3 from the ADC.
As discussed earlier on the mailing list, here is an implementation based
on the fact that the IIO device can expose the trigger and the required
channels to another driver (in our case the input touchscreen driver).
This touchscreen driver will consume the trigger and the values ( by
feeding them to the input subsystem).

Design decisions: The touchscreen driver will do a successful probe at
all times. Only on touch open and close, it will connect to the ADC device.
This is done to avoid a hard dependency between loading the ADC module and
the touchscreen one. So probe will always succeed and the dependency
is only soft.

Below it's an explanation of each patch in the series. Some changes were
required in the inkern API and the implementation was done in the ADC driver
and the touchscreen driver.

1: Added maintainers entry for new driver. This is done in commit:
MAINTAINERS: add sama5d2 resistive touchscreen

2: First we need a new set of channels named Position to report from the IIO
device the position on the touchpad. This is done in commit :
iio: Add channel for Position

3: we need device tree connection between the trigger producer and the
trigger consumer. I made new bindings very similar with the ones for the IIO
channels. This is done in the commit:
dt-bindings: iio: add binding support for iio trigger
    provider/consumer

4: we need bindings for the input touchscreen driver, named sama5d2_rts
(resistive touch screen). This driver will be the consumer for the IIO
trigger and channels. This is done in the commit:
dt-bindings: input: touchscreen: sama5d2_rts: create bindings

5: we need some helper functions to get the trigger from the iio device
from inkern API. This is done in the commit:
iio: triggers: add helper function to retrieve trigger

6: we need helper functions to attach and detach a pollfunction to and
from the trigger itself. The trigger is registered by an IIO device, and
is still connected to it, but we need to be able to register a different
pollfunc from another driver. Thus I exposed this API to be inkern API.
This is done in commit:
iio: triggers: expose attach and detach helpers for pollfuncs

7: we need to be able to attach a pollfunc to a trigger, even if the
pollfunc is not coming from an iio device. Thus, register the pollfunc using
the iio_dev of the trigger (in case it's coming as NULL from the pollfunc).
This is done in the commit:
iio: triggers: on pollfunc attach, complete iio_dev if NULL

8: we need a private data on the pollfunc, such that the consumer
driver has a pointer to it's private data when the handler is called.
This is done in the commit:
iio: triggers: add private data to pollfuncs

9: we need to have inkern API to be able to look inside the devicetree
and find from the properties, which trigger(s) need to be connected.
Created some API that will look through the properties and return found
triggers. This is done in the commit:
iio: inkern: triggers: create helpers for OF trigger retrieval

10: in at91-sama5d2_adc we need to remove trigger on module remove in
order to not have stray triggers that are unusable after the module is
removed and reinserted. If such triggers stay registered, the code that
looks through the list of triggers will not work as intended.
This is done in commit:
iio: adc: at91-sama5d2_adc: force trigger removal on module remove

11: we need consecutive indexes for the channels provided by at91-sama5d2_adc
so that we optimize the index values and easier to connect the
touchscreen driver to the channels as a consumer. This is done in the commit:
iio: adc: at91-sama5d2_adc: optimize scan index for diff channels

12: the implementation of the channels and the support for position
conversion and pressure is done in the at91-sama5d2_adc driver.
The implementation provides a trigger named "touch" which can be
connected to a consumer driver.
Once a driver connects and attaches a pollfunc to this trigger, the
configure trigger callback is called, and then the ADC driver will
initialize pad measurement.
First step is to enable touchscreen 4wire support and enable
pen detect IRQ.
Once a pen is detected, a periodic trigger is setup to trigger every 2 ms
(e.g.) and sample the resistive touchscreen values. The trigger poll
is called, and the consumer driver is then woke up, and it can read the
respective channels for the values : X, and Y for position and pressure
channel.
Because only one trigger can be active in hardware in the same time,
while touching the pad, the ADC will block any attempt to use the
triggered buffer. Same, conversions using the software trigger are also
impossible (since the periodic trigger is setup).
If some driver wants to attach while the trigger is in use, it will also fail.
Once the pen is not detected anymore, the trigger is free for use (hardware
or software trigger, with or without DMA).
Channels 0,1,2 and 3 are unavailable if a touchscreen is enabled.
This is done in the commit:
iio: adc: at91-sama5d2_adc: support for position and pressure channels

13: the implementation of the basic touchscreen driver, which is an IIO
consumer.
The driver registers an input device and connects to the given IIO device from
devicetree. It requires an IIO trigger (acting as a consumer) and three IIO
channels : one for X position, one for Y position and one for pressure.
It the reports the values to the input subsystem.
This is done in the commit:
input: touchscreen: sama5d2_rts: SAMA5D2 Resistive touchscreen driver

14: Finally, we need to have the node in the sama5d2.dtsi,
as it's part of the SoC. This is done in the commit:
ARM: dts: at91: sama5d2: Add resistive touch device

This series is based on the discussion in mailing list and probably requires
some patching up, but hopefully the idea and the implementation of the inkern
trigger consumers and the splitting between the ADC driver and the input
driver is ok like this.

The implementation avoids using a MFD driver, which means to make three
drivers in fact, one for ADC, one for touch, with a shared IRQ, and a general
MFD driver that will be a placeholder for the two.

This implementation is based on patches initially written by
Swamy Bandaru Venkateshwara and Mohamed Jamsheeth Hajanajubudeen

Eugen Hristev (14):
  MAINTAINERS: add sama5d2 resistive touchscreen
  iio: Add channel for Position
  dt-bindings: iio: add binding support for iio trigger
    provider/consumer
  dt-bindings: input: touchscreen: sama5d2_rts: create bindings
  iio: triggers: add helper function to retrieve trigger
  iio: triggers: expose attach and detach helpers for pollfuncs
  iio: triggers: on pollfunc attach, complete iio_dev if NULL
  iio: triggers: add private data to pollfuncs
  iio: inkern: triggers: create helpers for OF trigger retrieval
  iio: adc: at91-sama5d2_adc: force trigger removal on module remove
  iio: adc: at91-sama5d2_adc: optimize scan index for diff channels
  iio: adc: at91-sama5d2_adc: support for position and pressure channels
  input: touchscreen: sama5d2_rts: SAMA5D2 Resistive touchscreen driver
  ARM: dts: at91: sama5d2: Add resistive touch device

 Documentation/ABI/testing/sysfs-bus-iio            |  11 +
 .../devicetree/bindings/iio/iio-bindings.txt       |  52 ++-
 .../bindings/input/touchscreen/sama5d2_rts.txt     |  31 ++
 MAINTAINERS                                        |   6 +
 arch/arm/boot/dts/sama5d2.dtsi                     |  12 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 | 460 ++++++++++++++++++++-
 drivers/iio/iio_core_trigger.h                     |  21 +
 drivers/iio/industrialio-core.c                    |   1 +
 drivers/iio/industrialio-trigger.c                 |  42 +-
 drivers/iio/inkern.c                               |  91 ++++
 drivers/input/touchscreen/Kconfig                  |  13 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/sama5d2_rts.c            | 287 +++++++++++++
 include/linux/iio/trigger_consumer.h               |  21 +
 include/uapi/linux/iio/types.h                     |   1 +
 tools/iio/iio_event_monitor.c                      |   2 +
 16 files changed, 1036 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/sama5d2_rts.txt
 create mode 100644 drivers/input/touchscreen/sama5d2_rts.c

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
