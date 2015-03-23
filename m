From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] mfd: stmpe: move platform data into mfd driver
Date: Mon, 23 Mar 2015 16:29:13 +0100
Message-ID: <1427124553-27551-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-input@vger.kernel.org

The STMPE platform data is only populated from the device tree
in all existing users, so push the struct and make the OF case
the norm.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/stmpe.c       | 41 ++++++++++++++++++++++++++++++-----------
 include/linux/mfd/stmpe.h | 23 +----------------------
 2 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 2d7fae94c861..cb5f19749442 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -23,6 +23,27 @@
 #include <linux/regulator/consumer.h>
 #include "stmpe.h"
 
+/**
+ * struct stmpe_platform_data - STMPE platform data
+ * @id: device id to distinguish between multiple STMPEs on the same board
+ * @blocks: bitmask of blocks to enable (use STMPE_BLOCK_*)
+ * @irq_trigger: IRQ trigger to use for the interrupt to the host
+ * @autosleep: bool to enable/disable stmpe autosleep
+ * @autosleep_timeout: inactivity timeout in milliseconds for autosleep
+ * @irq_over_gpio: true if gpio is used to get irq
+ * @irq_gpio: gpio number over which irq will be requested (significant only if
+ *	      irq_over_gpio is true)
+ */
+struct stmpe_platform_data {
+	int id;
+	unsigned int blocks;
+	unsigned int irq_trigger;
+	bool autosleep;
+	bool irq_over_gpio;
+	int irq_gpio;
+	int autosleep_timeout;
+};
+
 static int __stmpe_enable(struct stmpe *stmpe, unsigned int blocks)
 {
 	return stmpe->variant->enable(stmpe, blocks, true);
@@ -1158,24 +1179,22 @@ static void stmpe_of_probe(struct stmpe_platform_data *pdata,
 /* Called from client specific probe routines */
 int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum)
 {
-	struct stmpe_platform_data *pdata = dev_get_platdata(ci->dev);
+	struct stmpe_platform_data *pdata;
 	struct device_node *np = ci->dev->of_node;
 	struct stmpe *stmpe;
 	int ret;
 
-	if (!pdata) {
-		if (!np)
-			return -EINVAL;
+	if (!np)
+		return -EINVAL;
 
-		pdata = devm_kzalloc(ci->dev, sizeof(*pdata), GFP_KERNEL);
-		if (!pdata)
-			return -ENOMEM;
+	pdata = devm_kzalloc(ci->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
 
-		stmpe_of_probe(pdata, np);
+	stmpe_of_probe(pdata, np);
 
-		if (of_find_property(np, "interrupts", NULL) == NULL)
-			ci->irq = -1;
-	}
+	if (of_find_property(np, "interrupts", NULL) == NULL)
+		ci->irq = -1;
 
 	stmpe = devm_kzalloc(ci->dev, sizeof(struct stmpe), GFP_KERNEL);
 	if (!stmpe)
diff --git a/include/linux/mfd/stmpe.h b/include/linux/mfd/stmpe.h
index 93e62ae32906..de748bc7525e 100644
--- a/include/linux/mfd/stmpe.h
+++ b/include/linux/mfd/stmpe.h
@@ -62,6 +62,7 @@ enum {
 
 struct stmpe_variant_info;
 struct stmpe_client_info;
+struct stmpe_platform_data;
 
 /**
  * struct stmpe - STMPE MFD structure
@@ -117,26 +118,4 @@ extern int stmpe_disable(struct stmpe *stmpe, unsigned int blocks);
 
 #define STMPE_GPIO_NOREQ_811_TOUCH	(0xf0)
 
-
-/**
- * struct stmpe_platform_data - STMPE platform data
- * @id: device id to distinguish between multiple STMPEs on the same board
- * @blocks: bitmask of blocks to enable (use STMPE_BLOCK_*)
- * @irq_trigger: IRQ trigger to use for the interrupt to the host
- * @autosleep: bool to enable/disable stmpe autosleep
- * @autosleep_timeout: inactivity timeout in milliseconds for autosleep
- * @irq_over_gpio: true if gpio is used to get irq
- * @irq_gpio: gpio number over which irq will be requested (significant only if
- *	      irq_over_gpio is true)
- */
-struct stmpe_platform_data {
-	int id;
-	unsigned int blocks;
-	unsigned int irq_trigger;
-	bool autosleep;
-	bool irq_over_gpio;
-	int irq_gpio;
-	int autosleep_timeout;
-};
-
 #endif
-- 
1.9.3
