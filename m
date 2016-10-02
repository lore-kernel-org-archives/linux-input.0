From: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v7 1/5] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Sun,  2 Oct 2016 16:15:45 +0200
Message-ID: <449aa536e2c0aa0365ff98400bad979570d4854f.1475416202.git.ksenija.stanojevic@gmail.com>
References: <cover.1475416202.git.ksenija.stanojevic@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1475416202.git.ksenija.stanojevic@gmail.com>
In-Reply-To: <cover.1475416202.git.ksenija.stanojevic@gmail.com>
References: <cover.1475416202.git.ksenija.stanojevic@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de, linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com, fabio.estevam@freescale.com, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
List-Id: linux-input@vger.kernel.org

Add core files for mxs-lradc MFD driver.

Note:  this patch won't compile in iio/testing without this patch:
a8f447be8056 ("mfd: Add resource managed APIs for mfd_add_devices")

Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
---
Changes in v7:
 - define macros ADC_CELL and TSC_CELL
 - remove one cell and dynamically set them in the switch()
 - fail in the touchscreen driver instead of mfd driver if 
   hardware doesn't contain a touchscreen

Changes in v6:
 - update copyright
 - add kernel-doc header for struct mxs-lradc
 - add error message
 - change EINVAL to ENODEV
 - use PLATFORM_DEVID_NONE instead -1
 - cosmetic fixes

Changes in v5:
 - use DEFINE_RES_MEM
 - don't pass ioreammaped adress to platform cells
 - move comment outside of struct mxs_lradc
 - change type of argument in mxs_lradc_reg_set, mxs_lradc_reg_clear,
   mxs_lradc_reg_wrt (struct mxs_lradc * -> void __iomem *)

Changes in v4:
 - update copyright
 - use DEFINE_RES_IRQ_NAMED
 - remove mxs_lradc_add_device function
 - use struct mfd_cell in static form
 - improve spacing
 - remove unnecessary comment
 - remove platform_get_irq
 - remove touch_ret and use ret instead
 - rename use_touchscreen to touchscreen_wire
 - use goto statements
 - remove irq[13], irq_count and irq_name from struct mxs_lradc
 - remove all defines from inside the struct definition

Changes in v3:
 - add note to commit message
 - move switch statement into if(touch_ret == 0) branch
 - add MODULE_AUTHOR

Changes in v2:
 - do not change spacing in Kconfig
 - make struct mfd_cell part of struct mxs_lradc
 - use switch instead of if in mxs_lradc_irq_mask
 - use only necessary header files in mxs_lradc.h
 - use devm_mfd_add_device
 - use separate function to register mfd device
 - change licence to GPL
 - add copyright

 drivers/mfd/Kconfig  | 17 +++++++++++++++++
 drivers/mfd/Makefile |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 2d1fb64..188c7d1 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -308,6 +308,23 @@ config MFD_MC13XXX_I2C
 	help
 	  Select this if your MC13xxx is connected via an I2C bus.
 
+config MFD_MXS_LRADC
+	tristate "Freescale i.MX23/i.MX28 LRADC"
+	depends on ARCH_MXS || COMPILE_TEST
+	select MFD_CORE
+	select STMP_DEVICE
+	help
+	  Say yes here to build support for the Low Resolution
+	  Analog-to-Digital Converter (LRADC) found on the i.MX23 and i.MX28
+	  processors. This driver provides common support for accessing the
+	  device, additional drivers must be enabled in order to use the
+	  functionality of the device:
+		mxs-lradc-adc for ADC readings
+		mxs-lradc-ts  for touchscreen support
+
+	  This driver can also be built as a module. If so, the module will be
+	  called mxs-lradc.
+
 config MFD_MX25_TSADC
 	tristate "Freescale i.MX25 integrated Touchscreen and ADC unit"
 	select REGMAP_MMIO
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 2ba3ba3..c9f9c80 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -207,3 +207,4 @@ obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
 obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
 
 obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
+obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
-- 
1.9.1
