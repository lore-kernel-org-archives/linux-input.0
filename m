From: Andi Shyti <andi@etezian.org>
Subject: [PATCH v5 0/2] add support for the Samsung S6SY761 touchscreen
Date: Thu, 02 Nov 2017 15:07:24 +0900
Message-ID: <20171102060726.3745-1-andi@etezian.org>
References: <CGME20171102060735epcas1p11d1055bff699a680e723abc4f4f52186@epcas1p1.samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:17788 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdKBGHj (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 2 Nov 2017 02:07:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>

Hi,

This patchset adds support for the Samsung s6sy761 touchscreen.

Thanks,
Andi

v4 - v5
 - The previous patch has been split in two parts as requested
   by Rob and added his ack in the dt-binding patch.
 - I tried to fix all the reviews from Dmitry[*]
 - other random cleanups

[*] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1523520.html

v3 - v4
 - fixed a mismatch on the module name

v2 - v3
 - added security check on an unsigned value which can (unlikely)
   get a "negative" value

 - in the probe function the interrupt is requested after the
   input device registration in order to avoid checking in the
   interrupt handler whether the input device has been registered

 - removed the 'prev_pm_state' variable. Its original meaning
   was to restore the state of the device when coming back from
   sleep mode, but because I removed in patch v2 the low power
   mode, now the device works only in two modes and therefore
   'prev_pm_state' is not required any longer.

v1 - v2
 - remove the low power functionality as it doesn't bring any
   benefit
 - use get_unaligned_be16 instead of the form 'a << 8 | b'
 - use max_t instead of '? :'
 - use managed 'devm_device_add_group()'

Andi Shyti (2):
  dt-bindings: Input: add Samsung S6SY761 touchscreen binding file
  Input: add support for the Samsung S6SY761 touchscreen

 .../bindings/input/touchscreen/samsung,s6sy761.txt |  34 ++
 drivers/input/touchscreen/Kconfig                  |  11 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/s6sy761.c                | 548 +++++++++++++++++++++
 4 files changed, 594 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.txt
 create mode 100644 drivers/input/touchscreen/s6sy761.c

-- 
2.14.2

