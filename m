From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v3 0/4] mfd: max8997: add regmap support
Date: Thu, 13 Mar 2014 10:38:48 +0100
Message-ID: <1394703532-494-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:33083 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399AbaCMJjL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Mar 2014 05:39:11 -0400
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

Changelog:

v3:
- fix error handling
- fix deinitializations order
- move muic irq enum values renaming to separate patch

v2: https://lkml.org/lkml/2014/3/12/237
- rebase patches on Lee Jones' MFD tree
- add missing selects in Kconfig
- add missing deinitializations
- add interrupt disabling when suspend
- few minor changes and typo fixes

v1: https://lkml.org/lkml/2014/3/11/291

Robert Baldyga (4):
  mfd: max8997: use regmap to access registers
  mfd: max8997: handle IRQs using regmap
  mfd: max8997: change irq names to upper case
  mfd: max8997: move regmap handling to function drivers

 drivers/extcon/extcon-max8997.c     |  181 +++++++++++++---
 drivers/input/misc/max8997_haptic.c |  121 +++++++++--
 drivers/leds/leds-max8997.c         |   13 +-
 drivers/mfd/Kconfig                 |    3 +-
 drivers/mfd/Makefile                |    2 +-
 drivers/mfd/max8997-irq.c           |  387 -----------------------------------
 drivers/mfd/max8997.c               |  236 +++++++--------------
 drivers/power/max8997_charger.c     |   33 +--
 drivers/regulator/max8997.c         |   87 ++++----
 drivers/rtc/rtc-max8997.c           |  102 ++++++---
 include/linux/mfd/max8997-private.h |   88 ++++++--
 11 files changed, 532 insertions(+), 721 deletions(-)
 delete mode 100644 drivers/mfd/max8997-irq.c

-- 
1.7.9.5

