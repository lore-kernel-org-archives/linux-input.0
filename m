From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 2/6] thinkpad_acpi: Factor out get/set adaptive kbd mode
Date: Wed, 18 Feb 2015 21:53:35 +0100
Message-ID: <1424292815.32581.46.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/platform/x86/thinkpad_acpi.c | 61 ++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 80db3ce..a6dd017 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3480,6 +3480,32 @@ const int adaptive_keyboard_modes[] = {
 static bool adaptive_keyboard_mode_is_saved;
 static int adaptive_keyboard_prev_mode;
 
+static int adaptive_keyboard_get_mode(void)
+{
+	u32 mode = 0;
+
+	if (!acpi_evalf(hkey_handle, &mode, "GTRW", "dd", 0)) {
+		pr_err("Cannot read adaptive keyboard mode\n");
+		return -EIO;
+	}
+
+	return mode;
+}
+
+static int adaptive_keyboard_set_mode(int new_mode)
+{
+	if (new_mode < 0 ||
+		new_mode > LAYFLAT_MODE)
+		return -EINVAL;
+
+	if (!acpi_evalf(hkey_handle, NULL, "STRW", "vd", new_mode)) {
+		pr_err("Cannot set adaptive keyboard mode\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int adaptive_keyboard_get_next_mode(int mode)
 {
 	size_t i;
@@ -3509,39 +3535,28 @@ static bool adaptive_keyboard_hotkey_notify_hotkey(unsigned int scancode)
 			new_mode = adaptive_keyboard_prev_mode;
 			adaptive_keyboard_mode_is_saved = false;
 		} else {
-			if (!acpi_evalf(
-					hkey_handle, &current_mode,
-					"GTRW", "dd", 0)) {
-				pr_err("Cannot read adaptive keyboard mode\n");
+			current_mode = adaptive_keyboard_get_mode();
+			if (current_mode < 0)
 				return false;
-			} else {
-				new_mode = adaptive_keyboard_get_next_mode(
-						current_mode);
-			}
+			new_mode = adaptive_keyboard_get_next_mode(
+					current_mode);
 		}
 
-		if (!acpi_evalf(hkey_handle, NULL, "STRW", "vd", new_mode)) {
-			pr_err("Cannot set adaptive keyboard mode\n");
+		if (adaptive_keyboard_set_mode(new_mode) < 0)
 			return false;
-		}
 
 		return true;
 
 	case DFR_SHOW_QUICKVIEW_ROW:
-		if (!acpi_evalf(hkey_handle,
-				&adaptive_keyboard_prev_mode,
-				"GTRW", "dd", 0)) {
-			pr_err("Cannot read adaptive keyboard mode\n");
+		current_mode = adaptive_keyboard_get_mode();
+		if (current_mode < 0)
 			return false;
-		} else {
-			adaptive_keyboard_mode_is_saved = true;
 
-			if (!acpi_evalf(hkey_handle,
-					NULL, "STRW", "vd", FUNCTION_MODE)) {
-				pr_err("Cannot set adaptive keyboard mode\n");
-				return false;
-			}
-		}
+		adaptive_keyboard_prev_mode = current_mode;
+		adaptive_keyboard_mode_is_saved = true;
+
+		if (adaptive_keyboard_set_mode (FUNCTION_MODE) < 0)
+			return false;
 		return true;
 
 	default:
-- 
2.1.0
