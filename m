From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/5] Support for TSC/ADC MFD driver
Date: Thu, 23 Aug 2012 16:18:05 +0530
Message-ID: <1345718886-15737-1-git-send-email-rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This patch set adds a MFD core driver which registers
touchscreen and ADC as its client drivers.
The existing touchscreen has been modified to work as
a MFD client driver and a new ADC driver has been added
in the IIO subsystem.

There are 8 analog input lines, which can be used as:
1. 8 general purpose ADC channels
2. 4 wire TS, with 4 general purpose ADC channels
3. 5 wire TS, with 3 general purpose ADC channels

This patch set has been tested on AM335x EVM.

These set of patches are based on top of Touchscreen patch
set submitted.
Subject: [PATCH 0/4] input: TSC: ti_tscadc: TI Touchscreen driver updates [1]


[1] http://www.spinics.net/lists/linux-input/msg22107.html

Patil, Rachna (5):
  input: TSC: ti_tscadc: Rename the existing touchscreen driver
  MFD: ti_tscadc: Add support for TI's TSC/ADC MFDevice
  input: TSC: ti_tsc: Convert TSC into a MFDevice
  IIO : ADC: tiadc: Add support of TI's ADC driver
  MFD: ti_tscadc: Add check on number of i/p channels

 drivers/iio/adc/Kconfig               |    7 +
 drivers/iio/adc/Makefile              |    1 +
 drivers/iio/adc/ti_adc.c              |  219 ++++++++++++++
 drivers/input/touchscreen/Kconfig     |    4 +-
 drivers/input/touchscreen/Makefile    |    2 +-
 drivers/input/touchscreen/ti_tsc.c    |  358 ++++++++++++++++++++++
 drivers/input/touchscreen/ti_tscadc.c |  522 ---------------------------------
 drivers/mfd/Kconfig                   |    9 +
 drivers/mfd/Makefile                  |    1 +
 drivers/mfd/ti_tscadc.c               |  218 ++++++++++++++
 include/linux/mfd/ti_tscadc.h         |  146 +++++++++
 include/linux/platform_data/ti_adc.h  |    9 +
 12 files changed, 971 insertions(+), 525 deletions(-)
 create mode 100644 drivers/iio/adc/ti_adc.c
 create mode 100644 drivers/input/touchscreen/ti_tsc.c
 delete mode 100644 drivers/input/touchscreen/ti_tscadc.c
 create mode 100644 drivers/mfd/ti_tscadc.c
 create mode 100644 include/linux/mfd/ti_tscadc.h
 create mode 100644 include/linux/platform_data/ti_adc.h
