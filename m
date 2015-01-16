From: Dudley Du <dudl@cypress.com>
Subject: [PATCH v18 12/12] input: cyapa: add acpi device id support
Date: Fri, 16 Jan 2015 14:34:15 +0800
Message-ID: <1421390055-32760-13-git-send-email-dudl@cypress.com>
References: <1421390055-32760-1-git-send-email-dudl@cypress.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421390055-32760-1-git-send-email-dudl@cypress.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, jmmahler@gmail.com, rydberg@euromail.se
Cc: Dudley Du <dudl@cypress.com>, bleung@google.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add acpi device tree support.
acpi device id "CYAP0000" is for old gen3 trackpad devices.
acpi device id "CYAP0001" is for new gen5 trackpad devices.
TEST=test on Chromebooks.

Signed-off-by: Dudley Du <dudl@cypress.com>
---
 drivers/input/mouse/cyapa.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 5f9b24a..9dc9f65 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/pm_runtime.h>
+#include <linux/acpi.h>
 #include "cyapa.h"
 
 
@@ -1356,11 +1357,23 @@ static const struct i2c_device_id cyapa_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cyapa_id_table);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id cyapa_acpi_id[] = {
+	{ "CYAP0000", 0 },  /* Gen3 trackpad with 0x67 I2C address. */
+	{ "CYAP0001", 0 },  /* Gen5 trackpad with 0x24 I2C address. */
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cyapa_acpi_id);
+#endif
+
 static struct i2c_driver cyapa_driver = {
 	.driver = {
 		.name = "cyapa",
 		.owner = THIS_MODULE,
 		.pm = &cyapa_pm_ops,
+#ifdef CONFIG_ACPI
+		.acpi_match_table = ACPI_PTR(cyapa_acpi_id),
+#endif
 	},
 
 	.probe = cyapa_probe,
-- 
1.9.1
