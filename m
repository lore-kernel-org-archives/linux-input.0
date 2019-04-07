From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH] Input: i8042 - disable KBD port on Late-2016 Razer Blade Stealth
Date: Sun,  7 Apr 2019 17:37:34 -0400
Message-ID: <20190407213735.10658-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The late 2016 model of the Razer Blade Stealth has a built-in USB
keyboard, but for some reason the BIOS exposes an i8042 controller with
a connected KBD port. While this fake AT Keyboard device doesn't appear
to report any events, attempting to change the state of the caps lock
LED on it from on to off causes the entire system to hang.

So, introduce a quirk table for disabling keyboard probing by default,
i8042_dmi_nokbd_table, and add this specific model of Razer laptop to
that table.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/input/serio/i8042-x86ia64io.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 136f6e7bf797..888f5f6feebf 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -884,6 +884,22 @@ static const struct dmi_system_id __initconst i8042_dmi_kbdreset_table[] = {
 	{ }
 };
 
+static const struct dmi_system_id i8042_dmi_nokbd_table[] __initconst = {
+	{
+		/*
+		 * Razer Blade Stealth (Late 2016 model) - Keyboard is on USB
+		 * but the system exposes a fake AT keyboard that crashes the
+		 * system if the caps lock LED is changed
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Razer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Blade Stealth"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "2.04"),
+		},
+	},
+	{ }
+};
+
 #endif /* CONFIG_X86 */
 
 #ifdef CONFIG_PNP
@@ -1040,6 +1056,9 @@ static int __init i8042_pnp_init(void)
 #ifdef CONFIG_X86
 	if (dmi_check_system(i8042_dmi_nopnp_table))
 		i8042_nopnp = true;
+
+	if (dmi_check_system(i8042_dmi_nokbd_table))
+		i8042_nokbd = true;
 #endif
 
 	if (i8042_nopnp) {
-- 
2.20.1
