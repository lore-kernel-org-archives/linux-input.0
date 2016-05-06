From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v6 0/9] mfd: max8997: Add regmap support
Date: Fri, 06 May 2016 09:21:20 +0200
Message-ID: <1462519289-2356-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57921 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbcEFHVl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 May 2016 03:21:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, rtc-linux@googlegroups.com
Cc: r.baldyga@hackerion.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi,


This is a rebase and extension of old Robert Baldyga's work. [0]

Robert no longer works in Samsung.

>From the original cover letter:
"This patchset modifies max8997 driver and associated function drivers to use
register maps instead of operating directly on i2c bus. This change allowed
to simplify irq handling, and to move some initializations to individual
function drivers. Hence now when some functions are not enabled, their i2c
clients, regmaps and irqs are not registered."


My changes (since Robert's v5)
==============================
1. Rebase on v4.6-rc6.
2. Collect more acks.
3. Add few fixes:
   a. Haptic fix from Marek,
   b. Extcon and RTC fix from me,
   c. DTS fixes from Marek.

DTS changes are independent but rest of them (extcon/input/MFD) rely
on each other.

One way of merging would be to pick everything (except DTS) through
one tree. Or use tags.


Best regards,
Krzysztof

[0] http://lkml.iu.edu/hypermail//linux/kernel/1411.1/03152.html


Krzysztof Kozlowski (3):
  extcon: max8997: Fix handling error code of regmap_irq_get_virq()
  rtc: max8997: Check for ERRNO of regmap_irq_get_virq()
  extcon: max8997: Fix inconsistent indenting

Marek Szyprowski (3):
  input: max8997-haptic: Fix NULL pointer dereference
  ARM: dts: exynos: Fix regulator name to avoid forbidden character on
    exynos4210-trats
  ARM: dts: exynos: Add interrupt line to MAX8997 PMIC on
    exynos4210-trats

Robert Baldyga (3):
  mfd: max8997: Use regmap to access registers
  mfd: max8997: handle IRQs using regmap
  mfd: max8997: Change irq names to upper case

 arch/arm/boot/dts/exynos4210-trats.dts |   4 +-
 drivers/extcon/extcon-max8997.c        |  72 ++++---
 drivers/input/misc/max8997_haptic.c    |  40 ++--
 drivers/leds/leds-max8997.c            |  13 +-
 drivers/mfd/Kconfig                    |   3 +-
 drivers/mfd/Makefile                   |   2 +-
 drivers/mfd/max8997-irq.c              | 383 ---------------------------------
 drivers/mfd/max8997.c                  | 245 ++++++++++++++-------
 drivers/power/max8997_charger.c        |  33 +--
 drivers/regulator/max8997.c            |  87 ++++----
 drivers/rtc/rtc-max8997.c              |  60 +++---
 include/linux/mfd/max8997-private.h    |  82 +++++--
 12 files changed, 392 insertions(+), 632 deletions(-)
 delete mode 100644 drivers/mfd/max8997-irq.c

-- 
1.9.1

