From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 3/6] thinkpad_acpi: Add adaptive_kbd_mode sysfs attr
Date: Wed, 18 Feb 2015 21:53:44 +0100
Message-ID: <1424292824.32581.47.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/platform/x86/thinkpad_acpi.c | 71 +++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index a6dd017..562d958 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2917,6 +2917,59 @@ static void hotkey_wakeup_hotunplug_complete_notify_change(void)
 		     "wakeup_hotunplug_complete");
 }
 
+/* sysfs adaptive kbd mode --------------------------------------------- */
+
+static int adaptive_keyboard_get_mode(void);
+static int adaptive_keyboard_set_mode(int new_mode);
+
+enum ADAPTIVE_KEY_MODE {
+	HOME_MODE,
+	WEB_BROWSER_MODE,
+	WEB_CONFERENCE_MODE,
+	FUNCTION_MODE,
+	LAYFLAT_MODE
+};
+
+static ssize_t adaptive_kbd_mode_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	u32 current_mode;
+
+	current_mode = adaptive_keyboard_get_mode();
+	if (current_mode < 0)
+		return current_mode;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", current_mode);
+}
+
+static ssize_t adaptive_kbd_mode_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	unsigned long t;
+	int res;
+
+	if (parse_strtoul(buf, LAYFLAT_MODE, &t))
+		return -EINVAL;
+
+	res = adaptive_keyboard_set_mode(t);
+	return (res < 0) ? res : count;
+}
+
+static struct device_attribute dev_attr_adaptive_kbd_mode =
+	__ATTR(adaptive_kbd_mode, S_IWUSR | S_IRUGO,
+		adaptive_kbd_mode_show, adaptive_kbd_mode_store);
+
+static struct attribute *adaptive_kbd_attributes[] = {
+	&dev_attr_adaptive_kbd_mode.attr,
+	NULL
+};
+
+static const struct attribute_group adaptive_kbd_attr_group = {
+	.attrs = adaptive_kbd_attributes,
+};
+
 /* --------------------------------------------------------------------- */
 
 static struct attribute *hotkey_attributes[] __initdata = {
@@ -3230,8 +3283,13 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	/* does it have an adaptive keyboard, like
 	 * the Lenovo Carbon X1 2014 (2nd gen) */
 	if (acpi_evalf(hkey_handle, &hkeyv, "MHKV", "qd")) {
-		if ((hkeyv >> 8) == 2)
+		if ((hkeyv >> 8) == 2) {
 			tp_features.has_adaptive_kbd = true;
+			res = sysfs_create_group(&tpacpi_pdev->dev.kobj,
+					&adaptive_kbd_attr_group);
+			if (res)
+				goto err_exit;
+		}
 	}
 
 	quirks = tpacpi_check_quirks(tpacpi_hotkey_qtable,
@@ -3444,6 +3502,9 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
 err_exit:
 	delete_attr_set(hotkey_dev_attributes, &tpacpi_pdev->dev.kobj);
+	sysfs_remove_group(&tpacpi_pdev->dev.kobj,
+			&adaptive_kbd_attr_group);
+
 	hotkey_dev_attributes = NULL;
 
 	return (res < 0) ? res : 1;
@@ -3456,14 +3517,6 @@ err_exit:
  * Will consider support rest of modes in future.
  *
  */
-enum ADAPTIVE_KEY_MODE {
-	HOME_MODE,
-	WEB_BROWSER_MODE,
-	WEB_CONFERENCE_MODE,
-	FUNCTION_MODE,
-	LAYFLAT_MODE
-};
-
 const int adaptive_keyboard_modes[] = {
 	HOME_MODE,
 /*	WEB_BROWSER_MODE = 2,
-- 
2.1.0
