From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v3 00/10] mfd: AXP20x: Add support for AXP202
 and AXP209
Date: Thu, 27 Mar 2014 22:29:14 +0100
Message-ID: <1395955764-18103-1-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDWJTUUC5UCBBZVP2KMQKGQES7MQZPY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
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

This patchset depends on patchsets:
	irq: sun4i IRQ 0 / ENMI fixes (Hans de Goede)
	ARM: sun7i/sun6i: irqchip: Irqchip driver for NMI controller (Carlo Caione)
	regulator: helpers: Modify helpers enabling multi-bit control (Carlo Caione)

Changes since v1:

	- Added a new standalone patch for defconfig

	- MFD core:
	  * Removed axp,system-power-controller property

	- Bindings documentation:
	  * Corrected description for dcdc-workmode property
	  * Removed unused axp20x-pek compatible

	- Input misc PEK driver:
	  * Fixed seconds in lower case

	- Regulators subsystem:
	  * Fixed axp20x_set_suspend_voltage()
	  * Switched to using multi-bit control for regulators
	  * When "regulators" node is not found driver doesn't quit
	  * Driver is now using devm_regulator_register()
	  * Added module_platform_driver() instead of subsys_initcall()

	- DT:
	  * Added new DTSI for AXP209
	  * Added support for cubietruck and olinuxino-micro

Changes since v2:

	- Added a new patch for multi_v7_defconfig to enable MFD core
	  and subsystems

	- DT:
	  * Dropped axp,system-power-controller property from DTS
	  * Moved compatible and interrupt-related properties from the
	    DTSI file to the DTS board files

	- Regulators subsystem:
	  * Deleted useless struct axp20x_regulators
	  * Added a warning when out of specs values are used for the
	    dcdc frequency

	- MFD core:
	  * Fixed coding style
	  * Removed IDs from device table for i2c

	- Bindings documentation:
	  * Several corrections and fixes

Carlo Caione (10):
  mfd: AXP20x: Add mfd driver for AXP20x PMIC
  dt-bindings: add vendor-prefix for X-Powers
  mfd: AXP20x: Add bindings documentation
  input: misc: Add driver for AXP20x Power Enable Key
  input: misc: Add ABI docs for AXP20x PEK
  regulator: AXP20x: Add support for regulators subsystem
  ARM: sunxi: dt: Add x-powers-axp209.dtsi file
  ARM: sun7i/sun4i: dt: Add AXP209 support to various boards
  ARM: sunxi: Add AXP20x support in defconfig
  ARM: sunxi: Add AXP20x support multi_v7_defconfig

 .../ABI/testing/sysfs-driver-input-axp-pek         |  11 +
 Documentation/devicetree/bindings/mfd/axp20x.txt   |  83 ++++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/sun4i-a10-a1000.dts              |  13 +
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         |  13 +
 arch/arm/boot/dts/sun4i-a10-hackberry.dts          |  19 ++
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts          |  13 +
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts         |  19 ++
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts     |  19 ++
 arch/arm/boot/dts/sun4i-a10-pcduino.dts            |  13 +
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |  14 ++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |  15 ++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |  14 ++
 arch/arm/boot/dts/x-powers-axp209.dtsi             |  54 ++++
 arch/arm/configs/multi_v7_defconfig                |   3 +
 arch/arm/configs/sunxi_defconfig                   |   4 +
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/axp20x-pek.c                    | 260 +++++++++++++++++++
 drivers/mfd/Kconfig                                |  12 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/axp20x.c                               | 240 ++++++++++++++++++
 drivers/regulator/Kconfig                          |   7 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/axp20x-regulator.c               | 280 +++++++++++++++++++++
 include/linux/mfd/axp20x.h                         | 180 +++++++++++++
 26 files changed, 1301 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-input-axp-pek
 create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
 create mode 100644 arch/arm/boot/dts/x-powers-axp209.dtsi
 create mode 100644 drivers/input/misc/axp20x-pek.c
 create mode 100644 drivers/mfd/axp20x.c
 create mode 100644 drivers/regulator/axp20x-regulator.c
 create mode 100644 include/linux/mfd/axp20x.h

-- 
1.8.3.2
