From: David Rivshin <drivshin-WHIoityCHfoAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] input: matrix_keypad: add option to drive inactive columns
Date: Wed, 22 Mar 2017 16:16:50 -0400
Message-ID: <20170322201650.9072-1-drivshin@awxrd.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

From: David Rivshin <DRivshin-5fOYsn7Fw8lBDgjK7y7TUQ@public.gmane.org>

The gpio-matrix-keypad driver normally sets inactive columns as inputs
while scanning. This does not work for all hardware, which may require
the inactive columns to be actively driven in order to overcome any
pull-ups/downs on the columns.

Signed-off-by: David Rivshin <drivshin-5fOYsn7Fw8lBDgjK7y7TUQ@public.gmane.org>
---
 .../devicetree/bindings/input/gpio-matrix-keypad.txt        |  2 ++
 drivers/input/keyboard/matrix_keypad.c                      | 13 +++++++++----
 include/linux/input/matrix_keypad.h                         |  3 +++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
index d0ea09b..570dc10 100644
--- a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
+++ b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
@@ -24,6 +24,8 @@ Optional Properties:
 - debounce-delay-ms:	debounce interval in milliseconds
 - col-scan-delay-us:	delay, measured in microseconds, that is needed
 			before we can scan keypad after activating column gpio
+- drive-inactive-cols:	drive inactive columns during scan,
+			default is to turn inactive columns into inputs.
 
 Example:
 	matrix-keypad {
diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 18839cd..1f316d6 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -42,9 +42,10 @@ struct matrix_keypad {
 };
 
 /*
- * NOTE: normally the GPIO has to be put into HiZ when de-activated to cause
- * minmal side effect when scanning other columns, here it is configured to
- * be input, and it should work on most platforms.
+ * NOTE: If drive_inactive_cols is false, then the GPIO has to be put into
+ * HiZ when de-activated to cause minmal side effect when scanning other
+ * columns. In that case it is configured here to be input, otherwise it is
+ * driven with the inactive value.
  */
 static void __activate_col(const struct matrix_keypad_platform_data *pdata,
 			   int col, bool on)
@@ -55,7 +56,8 @@ static void __activate_col(const struct matrix_keypad_platform_data *pdata,
 		gpio_direction_output(pdata->col_gpios[col], level_on);
 	} else {
 		gpio_set_value_cansleep(pdata->col_gpios[col], !level_on);
-		gpio_direction_input(pdata->col_gpios[col]);
+		if (!pdata->drive_inactive_cols)
+			gpio_direction_input(pdata->col_gpios[col]);
 	}
 }
 
@@ -432,6 +434,9 @@ matrix_keypad_parse_dt(struct device *dev)
 	if (of_get_property(np, "gpio-activelow", NULL))
 		pdata->active_low = true;
 
+	pdata->drive_inactive_cols =
+		of_property_read_bool(np, "drive-inactive-cols");
+
 	of_property_read_u32(np, "debounce-delay-ms", &pdata->debounce_ms);
 	of_property_read_u32(np, "col-scan-delay-us",
 						&pdata->col_scan_delay_us);
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index 37b04a0..6174733 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -49,6 +49,8 @@ struct matrix_keymap_data {
  * @wakeup: controls whether the device should be set up as wakeup
  *	source
  * @no_autorepeat: disable key autorepeat
+ * @drive_inactive_cols: drive inactive columns during scan, rather than
+ *	making them inputs.
  *
  * This structure represents platform-specific data that use used by
  * matrix_keypad driver to perform proper initialization.
@@ -73,6 +75,7 @@ struct matrix_keypad_platform_data {
 	bool		active_low;
 	bool		wakeup;
 	bool		no_autorepeat;
+	bool		drive_inactive_cols;
 };
 
 int matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
-- 
2.9.3

base-commit: c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
