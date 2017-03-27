From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH v3 0/2] STM FingerTip S touchscreen support for TM2 board
Date: Mon, 27 Mar 2017 22:07:41 +0900
Message-ID: <20170327130743.27783-1-andi.shyti@samsung.com>
References: <CGME20170327130756epcas1p3e4d73c234d6f5b613b0b7cb37b54b972@epcas1p3.samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49315 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752779AbdC0NIO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 09:08:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>

Hi,

this patchset provides support for the ST-Microelectronics
FingerTip S device driver and enables it in the tm2 and tm2e
devices.

It's tested on top of next-20170210 kernel.

Thanks,
Andi

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
 drivers/input/touchscreen/Kconfig                  |  12 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/stmfts.c                 | 805 +++++++++++++++++++++
 4 files changed, 861 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt
 create mode 100644 drivers/input/touchscreen/stmfts.c

-- 
2.11.0

