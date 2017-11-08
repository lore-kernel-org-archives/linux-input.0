From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH v6 0/2] add support for the Samsung S6SY761 touchscreen
Date: Wed, 08 Nov 2017 17:21:03 +0900
Message-ID: <20171108082105.30739-1-andi.shyti@samsung.com>
References: <CGME20171108082115epcas2p46263ae444b08441c2e35d9e3a51dd0ca@epcas2p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

Hi,

This patchset adds support for the Samsung s6sy761 touchscreen.

Thanks,
Andi

v5 - v6
 - make a clear logical split between hw initialization and
   resume.
 - fix an inconsistency when applying the maximum x and y
   coordinates (as discussed with Dmitry[*]).

[*] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1528801.html

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
 drivers/input/touchscreen/s6sy761.c                | 564 +++++++++++++++++++++
 4 files changed, 610 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.txt
 create mode 100644 drivers/input/touchscreen/s6sy761.c

-- 
2.15.0
