From: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V6 0/2] iio: input: ti_am335x_adc: Add continuous sampling support
Date: Sun, 25 Aug 2013 23:45:22 +0100
Message-ID: <1377470724-15710-1-git-send-email-zubair.lutfullah@gmail.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

This applies to togreg branch in iio.

Round 6 updates
Fixed trigger the way iio list wanted. Driver has its own trigger.
Triggers at every FIFO Threshold IRQ and pushes samples to iio buffer.

Went through the driver and cleaned it up quite a bit.

Squashed patches together instead of having multiple tiny patches.

Zubair Lutfullah (2):
  input: ti_am335x_tsc: Enable shared IRQ for TSC
  iio: ti_am335x_adc: Add continuous sampling support

 drivers/iio/adc/ti_am335x_adc.c           |  254 ++++++++++++++++++++++++++---
 drivers/input/touchscreen/ti_am335x_tsc.c |   24 ++-
 include/linux/mfd/ti_am335x_tscadc.h      |   13 ++
 3 files changed, 264 insertions(+), 27 deletions(-)

-- 
1.7.9.5
