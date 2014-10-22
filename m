From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Subject: Re: [PATCH v7 0/6] mfd: AXP20x: Add support for AXP202
 and AXP209
Date: Wed, 22 Oct 2014 08:28:42 +0200
Message-ID: <20141022082842.58578191@pluto.restena.lu>
References: <1404066237-20234-1-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDCZ5GUK4UNRBIM5TWRAKGQEWGLVCDY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1404066237-20234-1-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, 29 Jun 2014 20:23:51 +0200 Carlo Caione wrote:
> During the merging of v6 several patches were left out. This v7 comprises
> all the patches that are still pending.

Any progress on this or reason why these are stuck?

> //--
> 
> AXP209 and AXP202 are the PMUs (Power Management Unit) used by A10, A13
> and A20 SoCs and developed by X-Powers, a sister company of Allwinner.
> AXP20x comprises an adaptive USB-Compatible PWM charger, 2 BUCK DC-DC
> converters, 5 LDOs, multiple 12-bit ADCs of voltage, current and temperature
> as well as 4 configurable GPIOs. 
> 
> This set of patches introduces the core driver and support for two different
> subsystems:
> 	- Regulators
> 	- PEK (Power Enable Key)
> 
> Changes since v1:
> 
> 	- Added a new standalone patch for defconfig
> 
> 	- MFD core:
> 	  * Removed axp,system-power-controller property
> 
> 	- Bindings documentation:
> 	  * Corrected description for dcdc-workmode property
> 	  * Removed unused axp20x-pek compatible
> 
> 	- Input misc PEK driver:
> 	  * Fixed seconds in lower case
> 
> 	- Regulators subsystem:
> 	  * Fixed axp20x_set_suspend_voltage()
> 	  * Switched to using multi-bit control for regulators
> 	  * When "regulators" node is not found driver doesn't quit
> 	  * Driver is now using devm_regulator_register()
> 	  * Added module_platform_driver() instead of subsys_initcall()
> 
> 	- DT:
> 	  * Added new DTSI for AXP209
> 	  * Added support for cubietruck and olinuxino-micro
> 
> Changes since v2:
> 
> 	- Added a new patch for multi_v7_defconfig to enable MFD core
> 	  and subsystems
> 
> 	- DT:
> 	  * Dropped axp,system-power-controller property from DTS
> 	  * Moved compatible and interrupt-related properties from the
> 	    DTSI file to the DTS board files
> 
> 	- Regulators subsystem:
> 	  * Deleted useless struct axp20x_regulators
> 	  * Added a warning when out of specs values are used for the
> 	    dcdc frequency
> 
> 	- MFD core:
> 	  * Fixed coding style
> 	  * Removed IDs from device table for i2c
> 
> 	- Bindings documentation:
> 	  * Several corrections and fixes
> 
> Changes since v3:
> 
> 	- Removed x-powers-axp209.dtsi file
> 	- Rewritten bindings document
> 
> 	- MFD core:
> 	  * Fixed casting
> 	  * Better comments / documentation
> 
> 	- Input misc PEK driver:
> 	  * Timings are now expressed in ms and the sysfs appies the
> 	    closest possible value
> 	  * No more useless pretty-printing
> 	  * Removed devm_request_threaded_irq in favour of
> 	    devm_request_any_context_irq
> 	  * Moved from input attributes to platform device attributes
> 
> 	- Regulators subsystem:
> 	  * Removed suspend mode (axp20x_set_suspend_voltage)
> 	  * Added regulators input supply
> 
> 	- DT:
> 	  * DTs doesn't include anymore the dtsi
> 	  * Added input supplies for regulators
> 
> Changes since v4:
> 
> 	- Removed regulator patches already applied / acked by Mark Brown
> 
> 	- Input misc PEK driver:
> 	  * Don't print anymore the "us" unit
> 	  * Added cleanup for attributes when unbindind the device
> 	  * Fixed error code returned when device_create_file() fails
> 
> 	- DT:
> 	  * Enable all the regulators on at boot-time
>        	  * Removed min and max microvolts for all the regulators but DCDC2
> 	  * Moved the axp_ipsout regulator outside the MFD node
> 	  
> 	- MFD core:
> 	  * The supply regulators are now specified in the MFD driver using
> 	    regulator_bulk_register_supply_alias() and the .parent_supplies
> 	    in the MFD cell
> 
> Changes since v5:
> 	- Added ACKs
> 	- Fixed compilation warning (reported by Hans De Goede)
> 	- Vendor-prefixes are now sorted
> 	- Removed DT patch
> 
> 
> Carlo Caione (6):
>   mfd: AXP20x: Add bindings documentation
>   dt-bindings: add vendor-prefix for X-Powers
>   input: misc: Add driver for AXP20x Power Enable Key
>   input: misc: Add ABI docs for AXP20x PEK
>   ARM: sunxi: Add AXP20x support in defconfig
>   ARM: sunxi: Add AXP20x support multi_v7_defconfig
> 
>  .../ABI/testing/sysfs-driver-input-axp-pek         |  11 +
>  Documentation/devicetree/bindings/mfd/axp20x.txt   |  93 +++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  arch/arm/configs/multi_v7_defconfig                |   3 +
>  arch/arm/configs/sunxi_defconfig                   |   3 +
>  drivers/input/misc/Kconfig                         |  11 +
>  drivers/input/misc/Makefile                        |   1 +
>  drivers/input/misc/axp20x-pek.c                    | 281 +++++++++++++++++++++
>  8 files changed, 404 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-input-axp-pek
>  create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
>  create mode 100644 drivers/input/misc/axp20x-pek.c
> 
