From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ACPI / PMIC: Add opregion driver for Intel Dollar Cove TI PMIC
Date: Tue, 22 Aug 2017 07:57:10 +0200
Message-ID: <20170822055710.26515-4-tiwai@suse.de>
References: <20170822055710.26515-1-tiwai@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170822055710.26515-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, linux-input@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This patch adds the opregion driver for Dollar Cove TI PMIC on Intel
Cherry Trail devices.  The patch is based on the original work by
Intel, found at:
      https://github.com/01org/ProductionKernelQuilts
with many cleanups and rewrites.

The driver is currently provided only as built-in to follow other
PMIC opregion drivers convention.

The re-enumeration of devices at probe is required for fixing the
issues on HP x2 210 G2.  See bug#195689.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193891
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195689
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/acpi/Kconfig                 |   6 ++
 drivers/acpi/Makefile                |   1 +
 drivers/acpi/pmic/intel_pmic_dc_ti.c | 135 +++++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100644 drivers/acpi/pmic/intel_pmic_dc_ti.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1ce52f84dc23..9da8dcefde7b 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -521,6 +521,12 @@ config CHT_WC_PMIC_OPREGION
 	help
 	  This config adds ACPI operation region support for CHT Whiskey Cove PMIC.
 
+config DC_TI_PMIC_OPREGION
+	bool "ACPI operation region support for Dollar Cove TI PMIC"
+	depends on INTEL_SOC_PMIC_DC_TI
+	help
+	  This config adds ACPI operation region support for Dollar Cove TI PMIC.
+
 endif
 
 config ACPI_CONFIGFS
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index b1aacfc62b1f..0a9008b971af 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
 obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
 obj-$(CONFIG_BXT_WC_PMIC_OPREGION) += pmic/intel_pmic_bxtwc.o
 obj-$(CONFIG_CHT_WC_PMIC_OPREGION) += pmic/intel_pmic_chtwc.o
+obj-$(CONFIG_DC_TI_PMIC_OPREGION) += pmic/intel_pmic_dc_ti.o
 
 obj-$(CONFIG_ACPI_CONFIGFS)	+= acpi_configfs.o
 
diff --git a/drivers/acpi/pmic/intel_pmic_dc_ti.c b/drivers/acpi/pmic/intel_pmic_dc_ti.c
new file mode 100644
index 000000000000..236ff31c5a79
--- /dev/null
+++ b/drivers/acpi/pmic/intel_pmic_dc_ti.c
@@ -0,0 +1,135 @@
+/*
+ * intel_pmic_dc_ti.c - TI Dollar Cove PMIC operation region driver
+ * Copyright (C) 2014 Intel Corporation. All rights reserved.
+ *
+ * Rewritten and cleaned up
+ * Copyright (C) 2017 Takashi Iwai <tiwai@suse.de>
+ */
+
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/intel_soc_pmic.h>
+#include "intel_pmic.h"
+
+#define TI_DC_PMICTEMP_LOW	0x57
+#define TI_DC_BATTEMP_LOW	0x59
+#define TI_DC_GPADC_LOW		0x5b
+
+static struct pmic_table dc_ti_power_table[] = {
+	{ .address = 0x00, .reg = 0x41 },
+	{ .address = 0x04, .reg = 0x42 },
+	{ .address = 0x08, .reg = 0x43 },
+	{ .address = 0x0c, .reg = 0x45 },
+	{ .address = 0x10, .reg = 0x46 },
+	{ .address = 0x14, .reg = 0x47 },
+	{ .address = 0x18, .reg = 0x48 },
+	{ .address = 0x1c, .reg = 0x49 },
+	{ .address = 0x20, .reg = 0x4a },
+	{ .address = 0x24, .reg = 0x4b },
+	{ .address = 0x28, .reg = 0x4c },
+	{ .address = 0x2c, .reg = 0x4d },
+	{ .address = 0x30, .reg = 0x4e },
+};
+
+static struct pmic_table dc_ti_thermal_table[] = {
+	{
+		.address = 0x00,
+		.reg = TI_DC_GPADC_LOW
+	},
+	{
+		.address = 0x0c,
+		.reg = TI_DC_GPADC_LOW
+	},
+	/* TMP2 -> SYSTEMP */
+	{
+		.address = 0x18,
+		.reg = TI_DC_GPADC_LOW
+	},
+	/* TMP3 -> BATTEMP */
+	{
+		.address = 0x24,
+		.reg = TI_DC_BATTEMP_LOW
+	},
+	{
+		.address = 0x30,
+		.reg = TI_DC_GPADC_LOW
+	},
+	/* TMP5 -> PMICTEMP */
+	{
+		.address = 0x3c,
+		.reg = TI_DC_PMICTEMP_LOW
+	},
+};
+
+static int dc_ti_pmic_get_power(struct regmap *regmap, int reg, int bit,
+				u64 *value)
+{
+	int data;
+
+	if (regmap_read(regmap, reg, &data))
+		return -EIO;
+
+	*value = data & 1;
+	return 0;
+}
+
+static int dc_ti_pmic_update_power(struct regmap *regmap, int reg, int bit,
+				   bool on)
+{
+	return regmap_update_bits(regmap, reg, 1, on);
+}
+
+static int dc_ti_pmic_get_raw_temp(struct regmap *regmap, int reg)
+{
+	int temp_l, temp_h;
+
+	if (regmap_read(regmap, reg, &temp_l) ||
+	    regmap_read(regmap, reg - 1, &temp_h))
+		return -EIO;
+
+	return temp_l | (temp_h & 0x3) << 8;
+}
+
+static struct intel_pmic_opregion_data dc_ti_pmic_opregion_data = {
+	.get_power = dc_ti_pmic_get_power,
+	.update_power = dc_ti_pmic_update_power,
+	.get_raw_temp = dc_ti_pmic_get_raw_temp,
+	.power_table = dc_ti_power_table,
+	.power_table_count = ARRAY_SIZE(dc_ti_power_table),
+	.thermal_table = dc_ti_thermal_table,
+	.thermal_table_count = ARRAY_SIZE(dc_ti_thermal_table),
+};
+
+static int dc_ti_pmic_opregion_probe(struct platform_device *pdev)
+{
+	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
+	int err;
+
+	err = intel_pmic_install_opregion_handler(&pdev->dev,
+			ACPI_HANDLE(pdev->dev.parent), pmic->regmap,
+			&dc_ti_pmic_opregion_data);
+	if (err < 0)
+		return err;
+
+	/* Re-enumerate devices depending on PMIC */
+	acpi_walk_dep_device_list(ACPI_HANDLE(pdev->dev.parent));
+	return 0;
+}
+
+static struct platform_device_id dc_ti_pmic_opregion_id_table[] = {
+	{ .name = "dc_ti_region" },
+	{},
+};
+
+static struct platform_driver dc_ti_pmic_opregion_driver = {
+	.probe = dc_ti_pmic_opregion_probe,
+	.driver = {
+		.name = "dollar_cove_ti_pmic",
+	},
+	.id_table = dc_ti_pmic_opregion_id_table,
+};
+module_platform_driver(dc_ti_pmic_opregion_driver);
+
+MODULE_DESCRIPTION("Dollar Cove TI PMIC opregion driver");
+MODULE_LICENSE("GPLv2");
-- 
2.14.0
