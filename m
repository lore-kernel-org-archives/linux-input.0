From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH 0/5] add resistive touchscreen support for new Allwinner SoCs' GPADC's driver
Date: Wed, 20 Jul 2016 10:29:06 +0200
Message-ID: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, maxime.ripard@free-electrons.com, wens@csie.org, dmitry.torokhov@gmail.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, antoine.tenart@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Allwinner SoCs all have an ADC that can also act as a touchscreen
controller and a thermal sensor. The first four channels can be used either
for the ADC or the touchscreen and the fifth channel is used for the
thermal sensor. We currently have a driver for the two latter functions in
drivers/input/touchscreen/sun4i-ts.c but we don't have access to the ADC
feature at all.

The temperature sensor returns valid values only when the GPADC is in
touchscreen mode.

This patch series is based on the patch series named "add support for
Allwinner SoCs ADC": https://lkml.org/lkml/2016/6/28/226

This adds the TP_UP_PENDING VIRQ in the MFD which occurs when the thing
(stylus or finger) touching the screen releases the touch. This VIRQ is
then handled in the touchscreen driver to notify the input framework of an
up event.
The MFD probes the touchscreen driver if the property
"allwinner,ts-attached" is set in rtp node of the DT.

The touchscreen driver needs data from the IIO ADC driver to retrieve touch
coordinates. The ADC driver exposes its four ADC channels to the
touchscreen driver. The touchscreen driver retrieves the four ADC channels,
associates a buffer with these channels and registers a callback to handle
buffer data. When the touchscreen driver is open, it starts the buffering
in the ADC driver and activates the callback. The ADC driver will be
notified a buffer is started and will then activate the FIFO_DATA_PENDING
interrupt which occurs when there is data to read in the FIFO. It also
selects the right mode (touchscreen or ADC). Then the FIFO_DATA_PENDING
VIRQ handler will continuously fill in a buffer with all data from the
hardware FIFO and send it to the touchscreen driver via the callback the
touchscreen driver registered previously when the VIRQ has been handled.
When in touchscreen mode, the hardware FIFO is filled in following this
pattern: X then Y coordinates of the first event, X and Y coordinates of
the second event, etc. This VIRQ is disabled only when the ADC driver is
notified a buffer is stopped. The touchscreen driver gets this buffer in
its defined callback and notifies the input framework of all events'
coordinates. When the touchscreen driver is closed, it stops the buffering
which deactivates the callback.

The hardware FIFO contains a maximum of 32 u32 values. Locations of the
first buffer retrieved after an up event are unreliable and are thus
dropped.

This patch replaces drivers/input/touchscreen/sun4i-ts.c by
drivers/input/touchscreen/sunxi-gpadc-ts.c, adding the ADC feature to
Allwinner SoCs' GPADC.

Quentin Schulz (5):
  mfd: sunxi-gpadc-mfd: add TP_UP_PENDING irq
  mfd: sunxi-gpadc-mfd: add buffer structure
  iio: adc: sunxi-gpadc-iio: enable iio_buffers
  input: touchscreen: support Allwinner SoCs' touchscreen
  mfd: sunxi-gpadc-mfd: probe sunxi-gpadc-ts driver

 drivers/iio/adc/Kconfig                    |   1 +
 drivers/iio/adc/sunxi-gpadc-iio.c          | 153 +++++++++--
 drivers/input/touchscreen/Kconfig          |  11 +-
 drivers/input/touchscreen/Makefile         |   2 +-
 drivers/input/touchscreen/sun4i-ts.c       | 419 -----------------------------
 drivers/input/touchscreen/sunxi-gpadc-ts.c | 195 ++++++++++++++
 drivers/mfd/sunxi-gpadc-mfd.c              | 127 ++++++---
 include/linux/mfd/sunxi-gpadc-mfd.h        |   5 +
 8 files changed, 433 insertions(+), 480 deletions(-)
 delete mode 100644 drivers/input/touchscreen/sun4i-ts.c
 create mode 100644 drivers/input/touchscreen/sunxi-gpadc-ts.c

-- 
2.5.0
