From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 3/4] thinkpad_acpi: Add adaptive_kbd_mode sysfs attr
Date: Mon, 02 Mar 2015 14:45:27 +0100
Message-ID: <1425303927.16791.34.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

Add a sysfs attribute to allow privileged users to change the keyboard
mode. This could be used by desktop environments to change the keyboard
mode depending on the application focused, as the Windows application
does.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 Documentation/laptops/thinkpad-acpi.txt | 18 +++++++++
 drivers/platform/x86/thinkpad_acpi.c    | 69 ++++++++++++++++++++++++++++-----
 2 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index fc04c14..72a150d 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1355,6 +1355,24 @@ Sysfs notes:
 	rfkill controller switch "tpacpi_uwb_sw": refer to
 	Documentation/rfkill.txt for details.
 
+Adaptive keyboard
+-----------------
+
+sysfs device attribute: adaptive_kbd_mode
+
+This sysfs attribute controls the keyboard "face" that will be shown on the
+Lenovo X1 Carbon 2nd gen (2014)'s adaptive keyboard. The value can be read
+and set.
+
+1 = Home mode
+2 = Web-browser mode
+3 = Web-conference mode
+4 = Function mode
+5 = Layflat mode
+
+For more details about which buttons will appear depending on the mode, please
+review the laptop's user guide:
+http://www.lenovo.com/shop/americas/content/user_guides/x1carbon_2_ug_en.pdf
 
 Multiple Commands, Module Parameters
 ------------------------------------
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 5dea4c2..ae528cf 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2918,6 +2918,57 @@ static void hotkey_wakeup_hotunplug_complete_notify_change(void)
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
+static DEVICE_ATTR_RW(adaptive_kbd_mode);
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
@@ -3233,8 +3284,13 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	 * Lenovo Carbon X1 2014 (2nd Gen).
 	 */
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
@@ -3447,6 +3503,9 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
 err_exit:
 	delete_attr_set(hotkey_dev_attributes, &tpacpi_pdev->dev.kobj);
+	sysfs_remove_group(&tpacpi_pdev->dev.kobj,
+			&adaptive_kbd_attr_group);
+
 	hotkey_dev_attributes = NULL;
 
 	return (res < 0) ? res : 1;
@@ -3459,14 +3518,6 @@ err_exit:
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
 static const int adaptive_keyboard_modes[] = {
 	HOME_MODE,
 /*	WEB_BROWSER_MODE = 2,
-- 
2.1.0
