From: Rob Herring <robh@kernel.org>
Subject: [PATCH] Input: i8042 - Rework DT node name comparisons
Date: Wed, 13 Feb 2019 10:16:31 -0600
Message-ID: <20190213161631.17028-1-robh@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. For the root node on SUN DT, we need to retrieve the 'name'
property as it is the rare case where the 'name' property and node name
differ. With both changes, it removes direct access to the node name
pointer.

While at it, comvert the open coded loop to use
for_each_child_of_node().

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/input/serio/i8042-sparcio.h | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index 796289846204..fce76812843b 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -53,12 +53,11 @@ static struct resource *kbd_res;
 
 static int sparc_i8042_probe(struct platform_device *op)
 {
-	struct device_node *dp = op->dev.of_node;
+	struct device_node *dp;
 
-	dp = dp->child;
-	while (dp) {
-		if (!strcmp(dp->name, OBP_PS2KBD_NAME1) ||
-		    !strcmp(dp->name, OBP_PS2KBD_NAME2)) {
+	for_each_child_of_node(op->dev.of_node, dp) {
+		if (of_node_name_eq(dp, OBP_PS2KBD_NAME1) ||
+		    of_node_name_eq(dp, OBP_PS2KBD_NAME2)) {
 			struct platform_device *kbd = of_find_device_by_node(dp);
 			unsigned int irq = kbd->archdata.irqs[0];
 			if (irq == 0xffffffff)
@@ -67,16 +66,14 @@ static int sparc_i8042_probe(struct platform_device *op)
 			kbd_iobase = of_ioremap(&kbd->resource[0],
 						0, 8, "kbd");
 			kbd_res = &kbd->resource[0];
-		} else if (!strcmp(dp->name, OBP_PS2MS_NAME1) ||
-			   !strcmp(dp->name, OBP_PS2MS_NAME2)) {
+		} else if (of_node_name_eq(dp, OBP_PS2MS_NAME1) ||
+			   of_node_name_eq(dp, OBP_PS2MS_NAME2)) {
 			struct platform_device *ms = of_find_device_by_node(dp);
 			unsigned int irq = ms->archdata.irqs[0];
 			if (irq == 0xffffffff)
 				irq = op->archdata.irqs[0];
 			i8042_aux_irq = irq;
 		}
-
-		dp = dp->sibling;
 	}
 
 	return 0;
@@ -109,8 +106,9 @@ static struct platform_driver sparc_i8042_driver = {
 static int __init i8042_platform_init(void)
 {
 	struct device_node *root = of_find_node_by_path("/");
+	const char *name = of_get_property(root, "name", NULL);
 
-	if (!strcmp(root->name, "SUNW,JavaStation-1")) {
+	if (name && !strcmp(name, "SUNW,JavaStation-1")) {
 		/* Hardcoded values for MrCoffee.  */
 		i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
 		kbd_iobase = ioremap(0x71300060, 8);
@@ -139,8 +137,9 @@ static int __init i8042_platform_init(void)
 static inline void i8042_platform_exit(void)
 {
 	struct device_node *root = of_find_node_by_path("/");
+	const char *name = of_get_property(root, "name", NULL);
 
-	if (strcmp(root->name, "SUNW,JavaStation-1"))
+	if (!name || strcmp(name, "SUNW,JavaStation-1"))
 		platform_driver_unregister(&sparc_i8042_driver);
 }
 
-- 
2.19.1
