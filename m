From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v5 0/3] mfd: max8997: add regmap support
Date: Wed, 12 Nov 2014 08:23:13 +0100
Message-ID: <1415776996-11569-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-leds-owner@vger.kernel.org>
Sender: linux-leds-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: sameo@linux.intel.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, paul.gortmaker@windriver.com, sachin.kamat@linaro.org, k.kozlowski@samsung.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, rtc-linux@googlegroups.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-input@vger.kernel.org

This patchset modifies max8997 driver and associated function drivers to use
register maps instead of operating directly on i2c bus. This change allowed
to simplify irq handling, and to move some initializations to individual
function drivers. Hence now when some functions are not enabled, their i2c
clients, regmaps and irqs are not registered.

Because patches are under review for very long time and I still don't have
all needed Acks, I'm resending this series rebased to the latest next branch.

Best regards
Robert Baldyga
Samsung R&D Institute Poland

Changelog:

v5:
- rebase patches to last next branch

v4:
- remove patch moving regmap handling to function drivers

v3: https://lkml.org/lkml/2014/3/13/101
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

Robert Baldyga (3):
  mfd: max8997: use regmap to access registers
  mfd: max8997: handle IRQs using regmap
  mfd: max8997: change irq names to upper case

 drivers/extcon/extcon-max8997.c     |  66 +++---
 drivers/input/misc/max8997_haptic.c |  34 ++--
 drivers/leds/leds-max8997.c         |  13 +-
 drivers/mfd/Kconfig                 |   3 +-
 drivers/mfd/Makefile                |   2 +-
 drivers/mfd/max8997-irq.c           | 387 ------------------------------------
 drivers/mfd/max8997.c               | 245 +++++++++++++++--------
 drivers/power/max8997_charger.c     |  33 +--
 drivers/regulator/max8997.c         |  87 ++++----
 drivers/rtc/rtc-max8997.c           |  58 +++---
 include/linux/mfd/max8997-private.h |  82 ++++++--
 11 files changed, 381 insertions(+), 629 deletions(-)
 delete mode 100644 drivers/mfd/max8997-irq.c

-- 
1.9.1
