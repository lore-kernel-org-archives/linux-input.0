From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v5 0/8] mfd: AXP20x: Add support for AXP202 and AXP209
Date: Thu,  1 May 2014 14:29:26 +0200
Message-ID: <1398947374-3115-1-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDWJTUUC5UCBBOX4RCNQKGQEX46VHGQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
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

Changes since v3:

	- Removed x-powers-axp209.dtsi file
	- Rewritten bindings document

	- MFD core:
	  * Fixed casting
	  * Better comments / documentation

	- Input misc PEK driver:
	  * Timings are now expressed in ms and the sysfs appies the
	    closest possible value
	  * No more useless pretty-printing
	  * Removed devm_request_threaded_irq in favour of
	    devm_request_any_context_irq
	  * Moved from input attributes to platform device attributes

	- Regulators subsystem:
	  * Removed suspend mode (axp20x_set_suspend_voltage)
	  * Added regulators input supply

	- DT:
	  * DTs doesn't include anymore the dtsi
	  * Added input supplies for regulators

Changes since v4:

	- Removed regulator patches already applied / acked by Mark Brown

	- Input misc PEK driver:
	  * Don't print anymore the "us" unit
	  * Added cleanup for attributes when unbindind the device
	  * Fixed error code returned when device_create_file() fails

	- DT:
	  * Enable all the regulators on at boot-time
       	  * Removed min and max microvolts for all the regulators but DCDC2
	  * Moved the axp_ipsout regulator outside the MFD node
	  
	- MFD core:
	  * The supply regulators are now specified in the MFD driver using
	    regulator_bulk_register_supply_alias() and the .parent_supplies
	    in the MFD cell

Carlo Caione (8):
  mfd: AXP20x: Add mfd driver for AXP20x PMIC
  dt-bindings: add vendor-prefix for X-Powers
  mfd: AXP20x: Add bindings documentation
  input: misc: Add driver for AXP20x Power Enable Key
  input: misc: Add ABI docs for AXP20x PEK
  ARM: sunxi: Add AXP20x support in defconfig
  ARM: sunxi: Add AXP20x support multi_v7_defconfig
  ARM: sun7i/sun4i: dt: Add AXP209 support to various boards

 .../ABI/testing/sysfs-driver-input-axp-pek         |  11 +
 Documentation/devicetree/bindings/mfd/axp20x.txt   |  93 +++++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/sun4i-a10-a1000.dts              |  58 +++++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         |  58 +++++
 arch/arm/boot/dts/sun4i-a10-hackberry.dts          |  64 +++++
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts          |  58 +++++
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts         |  65 +++++
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts     |  64 +++++
 arch/arm/boot/dts/sun4i-a10-pcduino.dts            |  58 +++++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |  59 +++++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |  59 +++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |  59 +++++
 arch/arm/configs/multi_v7_defconfig                |   3 +
 arch/arm/configs/sunxi_defconfig                   |   4 +
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/axp20x-pek.c                    | 281 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |  12 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/axp20x.c                               | 258 +++++++++++++++++++
 include/linux/mfd/axp20x.h                         | 180 +++++++++++++
 22 files changed, 1458 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-input-axp-pek
 create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
 create mode 100644 drivers/input/misc/axp20x-pek.c
 create mode 100644 drivers/mfd/axp20x.c
 create mode 100644 include/linux/mfd/axp20x.h

-- 
1.8.3.2
