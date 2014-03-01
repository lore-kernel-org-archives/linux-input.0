From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/7] mfd: AXP20x: Add support for AXP202 and AXP209
Date: Sat,  1 Mar 2014 17:45:45 +0100
Message-ID: <1393692352-10839-1-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDWJTUUC5UCBBLM5ZCMAKGQEQVC63KI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

AXP209 and AXP202 are the PMUs (Power Management Unit) used by A10, A13
and A20 SoCs and developed by X-Powers, a sister company of Allwinner.
AXP20x comprises an adaptive USB-Compatible PWM charger, 2 BUCK DC-DC
converters, 5 LDOs, multiple 12-bit ADCs of voltage, current and temperature
as well as 4 configurable GPIOs. 

This set of patches introduces the core driver and support for two different
subsystems:
	- Regulators
	- PEK (Power Enable Key)

Support for AXP209 in Cubieboard2 is also added.

Carlo Caione (7):
  mfd: AXP20x: Add mfd driver for AXP20x PMIC
  mfd: AXP20x: Add bindings documentation
  ARM: dts: cubieboard2: Add AXP209 support
  input: misc: Add driver for AXP20x Power Enable Key
  input: misc: Add ABI docs for AXP20x PEK
  regulator: AXP20x: Add support for regulators subsystem
  ARM: dts: Cubieboard2: Add support for AXP209 regulators

 .../ABI/testing/sysfs-driver-input-axp-pek         |  11 +
 Documentation/devicetree/bindings/mfd/axp20x.txt   |  93 ++++++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |  58 ++++
 arch/arm/configs/sunxi_defconfig                   |   4 +
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/axp20x-pek.c                    | 265 ++++++++++++++++
 drivers/mfd/Kconfig                                |  12 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/axp20x.c                               | 250 +++++++++++++++
 drivers/regulator/Kconfig                          |   7 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/axp20x-regulator.c               | 349 +++++++++++++++++++++
 include/linux/mfd/axp20x.h                         | 180 +++++++++++
 14 files changed, 1243 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-input-axp-pek
 create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
 create mode 100644 drivers/input/misc/axp20x-pek.c
 create mode 100644 drivers/mfd/axp20x.c
 create mode 100644 drivers/regulator/axp20x-regulator.c
 create mode 100644 include/linux/mfd/axp20x.h

-- 
1.8.3.2
