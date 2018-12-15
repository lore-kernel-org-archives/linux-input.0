From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v5] Input: i8042 add i8042_is_mr_coffee() helper to avoid refconut leak
Date: Sat, 15 Dec 2018 04:08:46 -0500
Message-ID: <20181215090846.28009-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: tiny.windzz@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

of_find_node_by_path() acquires a reference to the node returned by
it and that reference needs to be dropped by its caller. Add
i8042_is_mr_coffee() helper to avoid refconut leak.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
changes in v5:
-fix typo

changes in v4:
-fix typo

changes in v3:
-add i8042_is_mr_coffee
---
 drivers/input/serio/i8042-sparcio.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index 796289846204..9e9e512bc432 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -106,11 +106,23 @@ static struct platform_driver sparc_i8042_driver = {
 	.remove		= sparc_i8042_remove,
 };
 
+static inline bool i8042_is_mr_coffee(void)
+{
+	struct device_node *root;
+	bool is_mr_coffee;
+
+	root = of_find_node_by_path("/");
+	is_mr_coffee = !strcmp(root->name, "SUNW,JavaStation-1");
+	of_node_put(root);
+
+	return is_mr_coffee;
+}
+
 static int __init i8042_platform_init(void)
 {
-	struct device_node *root = of_find_node_by_path("/");
+	bool match = i8042_is_mr_coffee();
 
-	if (!strcmp(root->name, "SUNW,JavaStation-1")) {
+	if (match) {
 		/* Hardcoded values for MrCoffee.  */
 		i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
 		kbd_iobase = ioremap(0x71300060, 8);
@@ -138,9 +150,9 @@ static int __init i8042_platform_init(void)
 
 static inline void i8042_platform_exit(void)
 {
-	struct device_node *root = of_find_node_by_path("/");
+	bool match = i8042_is_mr_coffee();
 
-	if (strcmp(root->name, "SUNW,JavaStation-1"))
+	if (!match)
 		platform_driver_unregister(&sparc_i8042_driver);
 }
 
-- 
2.17.0
