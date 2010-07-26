From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 29/36]  [Driver][Qualcomm 1070][EC_BRG] Correct new EC bridge driver Makefile and Kconfig
Date: Mon, 26 Jul 2010 16:30:38 +0800
Message-ID: <1280133045-25945-29-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54628 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036Ab0GZIdb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:33:31 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so4323235pwi.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:33:31 -0700 (PDT)
In-Reply-To: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: wayne <wayne.lin@quantatw.com>

From: wayne <wayne.lin@quantatw.com>

---
 drivers/hwmon/Kconfig  |  214 ++++++++++++++++++++++++++++--------------------
 drivers/hwmon/Makefile |   17 +++-
 2 files changed, 137 insertions(+), 94 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index f0c6d0f..3c46d75 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -28,6 +28,17 @@ config HWMON_VID
 	tristate
 	default n
 
+config HWMON_DEBUG_CHIP
+	bool "Hardware Monitoring Chip debugging messages"
+	default n
+	help
+	  Say Y here if you want the I2C chip drivers to produce a bunch of
+	  debug messages to the system log.  Select this if you are having
+	  a problem with I2C support and want to see more of what is going
+	  on.
+
+comment "Native drivers"
+
 config SENSORS_ABITUGURU
 	tristate "Abit uGuru (rev 1 & 2)"
 	depends on X86 && EXPERIMENTAL
@@ -248,18 +259,6 @@ config SENSORS_ASB100
 	  This driver can also be built as a module.  If so, the module
 	  will be called asb100.
 
-config SENSORS_ATK0110
-	tristate "ASUS ATK0110 ACPI hwmon"
-	depends on X86 && ACPI && EXPERIMENTAL
-	help
-	  If you say yes here you get support for the ACPI hardware
-	  monitoring interface found in many ASUS motherboards. This
-	  driver will provide readings of fans, voltages and temperatures
-	  through the system firmware.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called asus_atk0110.
-
 config SENSORS_ATXP1
 	tristate "Attansic ATXP1 VID controller"
 	depends on I2C && EXPERIMENTAL
@@ -326,34 +325,6 @@ config SENSORS_F75375S
 	  This driver can also be built as a module.  If so, the module
 	  will be called f75375s.
 
-config SENSORS_FSCHER
-	tristate "FSC Hermes (DEPRECATED)"
-	depends on X86 && I2C
-	help
-	  This driver is DEPRECATED please use the new merged fschmd
-	  ("FSC Poseidon, Scylla, Hermes, Heimdall and Heracles") driver
-	  instead.
-
-	  If you say yes here you get support for Fujitsu Siemens
-	  Computers Hermes sensor chips.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called fscher.
-
-config SENSORS_FSCPOS
-	tristate "FSC Poseidon (DEPRECATED)"
-	depends on X86 && I2C
-	help
-	  This driver is DEPRECATED please use the new merged fschmd
-	  ("FSC Poseidon, Scylla, Hermes, Heimdall and Heracles") driver
-	  instead.
-
-	  If you say yes here you get support for Fujitsu Siemens
-	  Computers Poseidon sensor chips.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called fscpos.
-
 config SENSORS_FSCHMD
 	tristate "Fujitsu Siemens Computers sensor chips"
 	depends on X86 && I2C
@@ -402,12 +373,12 @@ config SENSORS_GL520SM
 	  will be called gl520sm.
 
 config SENSORS_CORETEMP
-	tristate "Intel Core (2) Duo/Solo temperature sensor"
-	depends on X86 && EXPERIMENTAL
+	tristate "Intel Core/Core2/Atom temperature sensor"
+	depends on X86 && PCI && EXPERIMENTAL
 	help
 	  If you say yes here you get support for the temperature
-	  sensor inside your CPU. Supported all are all known variants
-	  of Intel Core family.
+	  sensor inside your CPU. Most of the family 6 CPUs
+	  are supported. Check documentation/driver for details.
 
 config SENSORS_IBMAEM
 	tristate "IBM Active Energy Manager temperature/power sensors and control"
@@ -702,6 +673,23 @@ config SENSORS_SHT15
 	  This driver can also be built as a module.  If so, the module
 	  will be called sht15.
 
+config SENSORS_S3C
+	tristate "S3C24XX/S3C64XX Inbuilt ADC"
+	depends on ARCH_S3C2410
+	help
+	  If you say yes here you get support for the on-board ADCs of
+	  the Samsung S3C24XX or S3C64XX series of SoC
+
+	  This driver can also be built as a module. If so, the module
+	  will be called s3c-hwmo.
+
+config SENSORS_S3C_RAW
+	bool "Include raw channel attributes in sysfs"
+	depends on SENSORS_S3C
+	help
+	  Say Y here if you want to include raw copies of all the ADC
+	  channels in sysfs.
+
 config SENSORS_SIS5595
 	tristate "Silicon Integrated Systems Corp. SiS5595"
 	depends on PCI
@@ -797,6 +785,16 @@ config SENSORS_TMP401
 	  This driver can also be built as a module.  If so, the module
 	  will be called tmp401.
 
+config SENSORS_TMP421
+	tristate "Texas Instruments TMP421 and compatible"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for Texas Instruments TMP421,
+	  TMP422 and TMP423 temperature sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called tmp421.
+
 config SENSORS_VIA686A
 	tristate "VIA686A"
 	depends on PCI
@@ -920,6 +918,27 @@ config SENSORS_W83627EHF
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83627ehf.
 
+config SENSORS_WM831X
+	tristate "WM831x PMICs"
+	depends on MFD_WM831X
+	help
+	  If you say yes here you get support for the hardware
+	  monitoring functionality of the Wolfson Microelectronics
+	  WM831x series of PMICs.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called wm831x-hwmon.
+
+config SENSORS_WM8350
+	tristate "Wolfson Microelectronics WM835x"
+	depends on MFD_WM8350
+	help
+	  If you say yes here you get support for the hardware
+	  monitoring features of the WM835x series of PMICs.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called wm8350-hwmon.
+
 config SENSORS_ULTRA45
 	tristate "Sun Ultra45 PIC16F747"
 	depends on SPARC64
@@ -947,34 +966,6 @@ config SENSORS_HDAPS
 	  Say Y here if you have an applicable laptop and want to experience
 	  the awesome power of hdaps.
 
-config SENSORS_LIS3LV02D
-	tristate "STMicroeletronics LIS3LV02Dx three-axis digital accelerometer"
-	depends on ACPI && INPUT
-	select INPUT_POLLDEV
-	select NEW_LEDS
-	select LEDS_CLASS
-	default n
-	help
-	  This driver provides support for the LIS3LV02Dx accelerometer. In
-	  particular, it can be found in a number of HP laptops, which have the
-	  "Mobile Data Protection System 3D" or "3D DriveGuard" feature. On such
-	  systems the driver should load automatically (via ACPI). The
-	  accelerometer might also be found in other systems, connected via SPI
-	  or I2C.  The accelerometer data is readable via
-	  /sys/devices/platform/lis3lv02d.
-
-	  This driver also provides an absolute input class device, allowing
-	  the laptop to act as a pinball machine-esque joystick. On HP laptops,
-	  if the led infrastructure is activated, support for a led indicating
-	  disk protection will be provided as hp:red:hddprotection.
-
-	  This driver can also be built as modules.  If so, the core module
-	  will be called lis3lv02d and a specific module for HP laptops will be
-	  called hp_accel.
-
-	  Say Y here if you have an applicable laptop and want to experience
-	  the awesome power of lis3lv02d.
-
 config SENSORS_LIS3_SPI
 	tristate "STMicroeletronics LIS3LV02Dx three-axis digital accelerometer (SPI)"
 	depends on !ACPI && SPI_MASTER && INPUT
@@ -1017,21 +1008,51 @@ config SENSORS_APPLESMC
 	  Say Y here if you have an applicable laptop and want to experience
 	  the awesome power of applesmc.
 
-config SENSORS_HMC5843
-        tristate "HMC5843 Compass Sensor Driver"
-        depends on I2C && ARCH_MSM_SCORPION
-        default n
-        help
-          HMC5843 Compass Sensor Driver implemented by Quanta.
+if ACPI
 
-config HWMON_DEBUG_CHIP
-	bool "Hardware Monitoring Chip debugging messages"
+comment "ACPI drivers"
+
+config SENSORS_ATK0110
+	tristate "ASUS ATK0110"
+	depends on X86 && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the ACPI hardware
+	  monitoring interface found in many ASUS motherboards. This
+	  driver will provide readings of fans, voltages and temperatures
+	  through the system firmware.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called asus_atk0110.
+
+config SENSORS_LIS3LV02D
+	tristate "STMicroeletronics LIS3LV02Dx three-axis digital accelerometer"
+	depends on INPUT
+	select INPUT_POLLDEV
+	select NEW_LEDS
+	select LEDS_CLASS
 	default n
 	help
-	  Say Y here if you want the I2C chip drivers to produce a bunch of
-	  debug messages to the system log.  Select this if you are having
-	  a problem with I2C support and want to see more of what is going
-	  on.
+	  This driver provides support for the LIS3LV02Dx accelerometer. In
+	  particular, it can be found in a number of HP laptops, which have the
+	  "Mobile Data Protection System 3D" or "3D DriveGuard" feature. On such
+	  systems the driver should load automatically (via ACPI). The
+	  accelerometer might also be found in other systems, connected via SPI
+	  or I2C.  The accelerometer data is readable via
+	  /sys/devices/platform/lis3lv02d.
+
+	  This driver also provides an absolute input class device, allowing
+	  the laptop to act as a pinball machine-esque joystick. On HP laptops,
+	  if the led infrastructure is activated, support for a led indicating
+	  disk protection will be provided as hp:red:hddprotection.
+
+	  This driver can also be built as modules.  If so, the core module
+	  will be called lis3lv02d and a specific module for HP laptops will be
+	  called hp_accel.
+
+	  Say Y here if you have an applicable laptop and want to experience
+	  the awesome power of lis3lv02d.
+
+endif # ACPI
 
 config SENSORS_ISL29011
         tristate "ISL29011 Light Sensor Driver"
@@ -1048,12 +1069,27 @@ config SENSORS_WPCE775X
 	  This driver provides support for the Winbond WPCE775XX Embedded
 	  Controller, which provides lcd backlight, LEDs, and Battery control.
 
+config SENSORS_HMC5843
+        tristate "HMC5843 Compass Sensor Driver"
+        depends on I2C && ARCH_MSM_SCORPION
+        default n
+        help
+          HMC5843 Compass Sensor Driver implemented by Quanta.
+
+config SENSORS_BOSCH_BMA150
+        tristate "SMB380/BMA150 acceleration sensor support"
+        depends on I2C
+        default n
+        help
+          If you say yes here you get support for Bosch Sensortec's
+          acceleration sensors SMB380/BMA150.
+
 config SENSORS_NPCE781X
-  	tristate "NuvoTon WPCE775X"
-  	depends on I2C
-  	default n
+        tristate "NuvoTon WPCE775X"
+        depends on I2C
+        default n
         help
-	  This driver provides support for the NuvoTon NPCE781X Embedded
-	  Controller, which provides lcd backlight, LEDs, and Battery control.
+          This driver provides support for the NuvoTon NPCE781X Embedded
+          Controller, which provides lcd backlight, LEDs, and Battery control.
 
 endif # HWMON
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 9793344..cdcd166 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -5,6 +5,10 @@
 obj-$(CONFIG_HWMON)		+= hwmon.o
 obj-$(CONFIG_HWMON_VID)		+= hwmon-vid.o
 
+# APCI drivers
+obj-$(CONFIG_SENSORS_ATK0110)	+= asus_atk0110.o
+
+# Native drivers
 # asb100, then w83781d go first, as they can override other drivers' addresses.
 obj-$(CONFIG_SENSORS_ASB100)	+= asb100.o
 obj-$(CONFIG_SENSORS_W83627HF)	+= w83627hf.o
@@ -29,10 +33,8 @@ obj-$(CONFIG_SENSORS_ADT7462)	+= adt7462.o
 obj-$(CONFIG_SENSORS_ADT7470)	+= adt7470.o
 obj-$(CONFIG_SENSORS_ADT7473)	+= adt7473.o
 obj-$(CONFIG_SENSORS_ADT7475)	+= adt7475.o
-
 obj-$(CONFIG_SENSORS_APPLESMC)	+= applesmc.o
 obj-$(CONFIG_SENSORS_AMS)	+= ams/
-obj-$(CONFIG_SENSORS_ATK0110)	+= asus_atk0110.o
 obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
 obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
 obj-$(CONFIG_SENSORS_DME1737)	+= dme1737.o
@@ -40,9 +42,7 @@ obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
 obj-$(CONFIG_SENSORS_F71805F)	+= f71805f.o
 obj-$(CONFIG_SENSORS_F71882FG)	+= f71882fg.o
 obj-$(CONFIG_SENSORS_F75375S)	+= f75375s.o
-obj-$(CONFIG_SENSORS_FSCHER)	+= fscher.o
 obj-$(CONFIG_SENSORS_FSCHMD)	+= fschmd.o
-obj-$(CONFIG_SENSORS_FSCPOS)	+= fscpos.o
 obj-$(CONFIG_SENSORS_G760A)	+= g760a.o
 obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
 obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
@@ -76,6 +76,7 @@ obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
+obj-$(CONFIG_SENSORS_S3C)	+= s3c-hwmon.o
 obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
 obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595.o
 obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
@@ -83,17 +84,23 @@ obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
 obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
 obj-$(CONFIG_SENSORS_TMP401)	+= tmp401.o
+obj-$(CONFIG_SENSORS_TMP421)	+= tmp421.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_VT1211)	+= vt1211.o
 obj-$(CONFIG_SENSORS_VT8231)	+= vt8231.o
 obj-$(CONFIG_SENSORS_W83627EHF)	+= w83627ehf.o
 obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
 obj-$(CONFIG_SENSORS_W83L786NG)	+= w83l786ng.o
+obj-$(CONFIG_SENSORS_WM831X)	+= wm831x-hwmon.o
+obj-$(CONFIG_SENSORS_WM8350)	+= wm8350-hwmon.o
 obj-$(CONFIG_SENSORS_ISL29011)  += isl29011.o
-obj-$(CONFIG_SENSORS_HMC5843)   += hmc5843.o
 obj-$(CONFIG_SENSORS_WPCE775X)  += wpce775x.o
 obj-$(CONFIG_SENSORS_NPCE781X)  += npce781x.o
+obj-$(CONFIG_SENSORS_BOSCH_BMA150)      += bma150.o
+obj-$(CONFIG_SENSORS_HMC5843)   += hmc5843.o
 
 ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
 endif
+
+bma150-objs :=  bma150_driver.o smb380.o smb380calib.o
-- 
1.7.0.4

