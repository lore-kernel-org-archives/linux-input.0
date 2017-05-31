From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH v4 0/2] STM FingerTip S touchscreen support for TM2 board
Date: Wed, 31 May 2017 15:59:13 +0900
Message-ID: <20170531065915.15695-1-andi.shyti@samsung.com>
References: <CGME20170531065928epcas1p20b5ee8e7d3c74670fda56cb1ed4ca06e@epcas1p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

Hi,

this patchset provides support for the ST-Microelectronics
FingerTip S touchscreen device.

It's tested on top of mainline kernel on TM2 and TM2e boards.

Thanks,
Andi

Changelog V3-V4
===============
V3: https://marc.info/?l=linux-kernel&m=149062016401170&w=2
After an offline discussion, I applied some changes suggested by
Dmitry.

 - some cosmetic changes
 - interrupt gets disabled explicitly instead of using
   IRQ_NOAUTOEN
 - cleaner management of the input reports
 - the parsing of the event has been split into two major switch
   chunks, this might cause some event id overlapping, but the
   probability is quite rare

Changelog V2-V3
===============
V2: https://marc.info/?l=linux-kernel&m=148669314305915&w=2

 - fixed multi touch broken protocol reported by Chanwoo;
 - disabled irqs at the registration by setting the IRQ_NOAUTOEN
   flag, as suggested by Andrzej;
 - changed the interrupt handling policy: in the V1 and V2 the
   events were read one by one (8 each), this was increasing the
   overhead. Now all the events are read in a single operation,
   but because the stack is deep 32 events (256bytes, 32*8), it's
   impossible to use the smbus protocol. The i2c_transfer()
   functions is used instead;
 - random code changes;
 - patch 3 in the V1 and V2 patchset has been omitted because
   Krzysztof already merged it.

Changelog V1-V2
===============
V1: https://marc.info/?l=linux-kernel&m=148466204431327&w=2

 - fixed Javier's, Krzysztof's and Dmitry's reviews
 - added Javier's review tag on patch 1 and 3
 - the main difference of the driver from v2 is that the driver
   generates only one input interface instead of two (one for the
   touchscreen and one for the touchkeys). The job of filtering
   the events is demanded to userspace applications that are
   accessing the device. This is done by making an ioctl call:

	ioctl(fd, EVIOCSMASK, &mask);

   where 'mask' is an 'input_mask' structure that contains the type
   variable of the EV_* that needs to be filtered out.

Andi Shyti (2):
  Input: add STMicroelectronics FingerTip touchscreen driver
  Input: add support for the STMicroelectronics FingerTip touchscreen

 .../bindings/input/touchscreen/st,stmfts.txt       |  43 ++
 drivers/input/touchscreen/Kconfig                  |  11 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/stmfts.c                 | 823 +++++++++++++++++++++
 4 files changed, 878 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt
 create mode 100644 drivers/input/touchscreen/stmfts.c

-- 
2.11.0
