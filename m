From: Jianhong Chen <chenjh@rock-chips.com>
Subject: [PATCH v6 00/12] rk808: Add RK805 support
Date: Thu,  8 Jun 2017 15:12:27 +0800
Message-ID: <1496905959-29202-1-git-send-email-chenjh@rock-chips.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.136]:55296 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbdFHHOF (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Jun 2017 03:14:05 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, huangtao@rock-chips.com, tony.xie@rock-chips.com, zhangqing@rock-chips.com, devicetree@vger.kernel.org, w.egorov@phytec.de, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, chenjh <chenjh@rock-chips.com>

From: chenjh <chenjh@rock-chips.com>

change in v6:
patch1~7 no changed in V6.
add patch 8~12 for gpio and powerkey func for rk805.

change in v5:
PATCH V5 1/7: NO change in V5
PATCH V5 2/7: fix the rk805 reg addr in numerical order
PATCH V5 3/7: NO change in V5
PATCH V5 4/7: fix up the rk805_device_shutdown func
PATCH V5 5/7: NO change in V5
PATCH V5 6/7: NO change in V5
PATCH V5 7/7: fix up the description of the rk805

change in v4:
PATCH V4 1/7: NO change in V4
PATCH V4 2/7: rename the commit message
PATCH V4 3/7: NO change in V4
PATCH V4 4/7: Split this patch up into subsystems patch 5/7 6/7
PATCH V4 5/7: new added
PATCH V4 6/7: new added
PATCH V4 7/7: NO change in V4


change in V3:
PATCH V3 1/5: NO change in V3
PATCH V3 2/5: add rk805 RTC INT MASK define
PATCH V3 3/5: RK805 set suspend enable and disable is different from rk808
              use rk805_regs_ops and rk805_switch_ops
PATCH V3 4/5: fix up the shutdown func
              use pm_shutdown_prepare_fn to prepare shutdown
              and pm_pwroff_fn pull down gpio to shut down rk805
              it will update in the future(after rk808 support gpio func)
PATCH V3 5/5: NO change in V3

change in V2:
PATCH V2 1/5: NO change in V2
PATCH V2 2/5: add rk805 BUCK ILMAX define
PATCH V2 3/5: NO change in V2
PATCH V2 4/5: setting RK805 BUCK ILMAX in pre init
PATCH V2 5/5: Add RK805 device tree bindings document

Elaine Zhang (7):
  mfd: rk808: fix up the chip id get failed
  mfd: rk808: add rk805 regs addr and ID
  regulator: rk808: Add regulator driver for RK805
  mfd: rk808: Add RK805 support
  clk: Kconfig: Name RK805 in Kconfig for COMMON_CLK_RK808
  rtc: Kconfig: Name RK805 in Kconfig for RTC_DRV_RK808
  mfd: dt-bindings: Add RK805 device tree bindings document

chenjh (5):
  gpio: Add GPIO driver for the RK805 PMIC
  Input: Add power key driver for Rockchip RK805 PMIC
  mfd: rk808: Add RK805 gpio support
  mfd: rk808: Add RK805 power key support
  gpio: dt-bindings: add bindings for Rockchip RK805 PMIC

 .../devicetree/bindings/gpio/gpio-rk805.txt        |  37 ++++
 Documentation/devicetree/bindings/mfd/rk808.txt    |  22 +-
 drivers/clk/Kconfig                                |   4 +-
 drivers/gpio/Kconfig                               |   6 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-rk805.c                          | 234 +++++++++++++++++++++
 drivers/input/misc/Kconfig                         |   6 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/rk805-pwrkey.c                  | 111 ++++++++++
 drivers/mfd/Kconfig                                |   4 +-
 drivers/mfd/rk808.c                                | 147 ++++++++++++-
 drivers/regulator/Kconfig                          |   4 +-
 drivers/regulator/rk808-regulator.c                | 130 ++++++++++++
 drivers/rtc/Kconfig                                |   4 +-
 include/linux/mfd/rk808.h                          | 121 +++++++++++
 15 files changed, 817 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-rk805.txt
 create mode 100644 drivers/gpio/gpio-rk805.c
 create mode 100644 drivers/input/misc/rk805-pwrkey.c

-- 
1.9.1


