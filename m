From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 0/3] mfd: max8997: add regmap support
Date: Tue, 11 Mar 2014 14:58:21 +0100
Message-ID: <1394546304-15191-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:47042 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbaCKN6s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Mar 2014 09:58:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sameo@linux.intel.com, lee.jones@linaro.org
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, rtc-linux@googlegroups.com, m.szyprowski@samsung.com, k.kozlowski@samsung.com, Robert Baldyga <r.baldyga@samsung.com>

Hi,

This patchset modifies max8997 driver and associated function drivers to use
register maps instead of operating directly on i2c bus. This change allowed
to simplify irq handling, and to move some initializations to individual
function drivers. Hence now when some functions are not enabled, their i2c
clients, regmaps and irqs are not registered.

Best regards
Robert Baldyga
Samsung R&D Institute Poland

Robert Baldyga (3):
  mfd: max8997: use regmap to access registers
  mfd: max8997: handle IRQs using regmap
  mfd: max8997: move regmap handling to function drivers

 drivers/extcon/extcon-max8997.c     |  136 ++++++++++--
 drivers/input/misc/max8997_haptic.c |  117 +++++++++--
 drivers/leds/leds-max8997.c         |   13 +-
 drivers/mfd/Makefile                |    2 +-
 drivers/mfd/max8997-irq.c           |  387 -----------------------------------
 drivers/mfd/max8997.c               |  207 ++++++-------------
 drivers/power/max8997_charger.c     |   33 +--
 drivers/regulator/max8997.c         |   87 ++++----
 drivers/rtc/rtc-max8997.c           |   98 ++++++---
 include/linux/mfd/max8997-private.h |   86 ++++++--
 10 files changed, 482 insertions(+), 684 deletions(-)
 delete mode 100644 drivers/mfd/max8997-irq.c

-- 
1.7.9.5

