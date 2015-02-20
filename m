From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 1/7] thinkpad_acpi: Remember adaptive kbd presence
Date: Fri, 20 Feb 2015 15:44:10 +0100
Message-ID: <1424443450.22910.13.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

Rather than checking on each suspend and resume whether the laptop
has an adaptive keyboard, check when the driver is initialised.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/platform/x86/thinkpad_acpi.c | 37 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index c3d11fa..c1f4daf 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -318,6 +318,7 @@ static struct {
 	u32 sensors_pdrv_attrs_registered:1;
 	u32 sensors_pdev_attrs_registered:1;
 	u32 hotkey_poll_active:1;
+	u32 has_adaptive_kbd:1;
 } tp_features;
 
 static struct {
@@ -3226,6 +3227,15 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	if (!tp_features.hotkey)
 		return 1;
 
+	/*
+	 * Check if we have an adaptive keyboard, like on the
+	 * Lenovo Carbon X1 2014 (2nd Gen).
+	 */
+	if (acpi_evalf(hkey_handle, &hkeyv, "MHKV", "qd")) {
+		if ((hkeyv >> 8) == 2)
+			tp_features.has_adaptive_kbd = true;
+	}
+
 	quirks = tpacpi_check_quirks(tpacpi_hotkey_qtable,
 				     ARRAY_SIZE(tpacpi_hotkey_qtable));
 
@@ -3834,28 +3844,21 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 
 static void hotkey_suspend(void)
 {
-	int hkeyv;
-
 	/* Do these on suspend, we get the events on early resume! */
 	hotkey_wakeup_reason = TP_ACPI_WAKEUP_NONE;
 	hotkey_autosleep_ack = 0;
 
 	/* save previous mode of adaptive keyboard of X1 Carbon */
-	if (acpi_evalf(hkey_handle, &hkeyv, "MHKV", "qd")) {
-		if ((hkeyv >> 8) == 2) {
-			if (!acpi_evalf(hkey_handle,
-						&adaptive_keyboard_prev_mode,
-						"GTRW", "dd", 0)) {
-				pr_err("Cannot read adaptive keyboard mode.\n");
-			}
+	if (tp_features.has_adaptive_kbd) {
+		if (!acpi_evalf(hkey_handle, &adaptive_keyboard_prev_mode,
+					"GTRW", "dd", 0)) {
+			pr_err("Cannot read adaptive keyboard mode.\n");
 		}
 	}
 }
 
 static void hotkey_resume(void)
 {
-	int hkeyv;
-
 	tpacpi_disable_brightness_delay();
 
 	if (hotkey_status_set(true) < 0 ||
@@ -3870,14 +3873,10 @@ static void hotkey_resume(void)
 	hotkey_poll_setup_safe(false);
 
 	/* restore previous mode of adapive keyboard of X1 Carbon */
-	if (acpi_evalf(hkey_handle, &hkeyv, "MHKV", "qd")) {
-		if ((hkeyv >> 8) == 2) {
-			if (!acpi_evalf(hkey_handle,
-						NULL,
-						"STRW", "vd",
-						adaptive_keyboard_prev_mode)) {
-				pr_err("Cannot set adaptive keyboard mode.\n");
-			}
+	if (tp_features.has_adaptive_kbd) {
+		if (!acpi_evalf(hkey_handle, NULL, "STRW", "vd",
+					adaptive_keyboard_prev_mode)) {
+			pr_err("Cannot set adaptive keyboard mode.\n");
 		}
 	}
 }
-- 
2.1.0
