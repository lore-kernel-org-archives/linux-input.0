From: Joseph Chen <chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v7 00/12] rk808: Add RK805 support
Date: Fri, 21 Jul 2017 19:14:29 +0800
Message-ID: <1500635681-12477-1-git-send-email-chenjh@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, tony.xie-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wdc-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.egorov-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joseph Chen <chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

change in v7:
PATCH V7 1/12: NO change in V7
PATCH V7 2/12: NO change in V7
PATCH V7 3/12: fix missing: Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
PATCH V7 4/12: NO change in V7
PATCH V7 5/12: NO change in V7
PATCH V7 6/12: NO change in V7
PATCH V7 7/12: fix missing: Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
PATCH V7 8/12: abandon drivers/gpio/gpio-rk805.c and add drivers/pinctrl/pinctrl-rk805.c
PATCH V7 9/12: reset author and signed off with my english name
	       reset MODULE_AUTHOR() with my english name
	       replace devm_request_threaded_irq() with devm_request_any_context_irq()
PATCH V7 10/12: replace 'gpio-rk805' with 'pinctrl-rk805' in struct mfd_cell rk805s[]
PATCH V7 11/12: NO change in V7
PATCH V7 12/12: dt-bindings: abandon gpio-rk805.txt and add pinctrl-rk805.txt

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

Joseph Chen (5):
  pinctrl: Add pinctrl driver for the RK805 PMIC
  Input: Add power key driver for Rockchip RK805 PMIC
  mfd: rk808: Add RK805 pinctrl support
  mfd: rk808: Add RK805 power key support
  pinctrl: dt-bindings: add bindings for Rockchip RK805 PMIC

 Documentation/devicetree/bindings/mfd/rk808.txt    |  22 +-
 .../devicetree/bindings/pinctrl/pinctrl-rk805.txt  |  63 +++
 drivers/clk/Kconfig                                |   4 +-
 drivers/input/misc/Kconfig                         |   6 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/rk805-pwrkey.c                  | 111 +++++
 drivers/mfd/Kconfig                                |   4 +-
 drivers/mfd/rk808.c                                | 147 +++++-
 drivers/pinctrl/Kconfig                            |   8 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-rk805.c                    | 496 +++++++++++++++++++++
 drivers/regulator/Kconfig                          |   4 +-
 drivers/regulator/rk808-regulator.c                | 130 ++++++
 drivers/rtc/Kconfig                                |   4 +-
 include/linux/mfd/rk808.h                          | 121 +++++
 15 files changed, 1107 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt
 create mode 100644 drivers/input/misc/rk805-pwrkey.c
 create mode 100644 drivers/pinctrl/pinctrl-rk805.c

-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
