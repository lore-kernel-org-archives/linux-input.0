From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH 4/4] Detect the WiFi/Bluetooth/3G devices available
Date: Sat,  4 Dec 2010 09:03:26 +0800
Message-ID: <1291424606-23383-5-git-send-email-jlee@novell.com>
References: <1291424606-23383-1-git-send-email-jlee@novell.com>
 <1291424606-23383-2-git-send-email-jlee@novell.com>
 <1291424606-23383-3-git-send-email-jlee@novell.com>
 <1291424606-23383-4-git-send-email-jlee@novell.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1291424606-23383-4-git-send-email-jlee@novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: mjg@redhat.com
Cc: carlos@strangeworlds.co.uk, corentin.chary@gmail.com, dmitry.torokhov@gmail.com, corentincj@iksaif.net, tiwai@novell.com, mjg59@srcf.ucam.org, jbenc@suse.cz, jdelvare@suse.de, trenn@suse.de, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, "Lee, Chun-Yi" <jlee@novell.com>
List-Id: linux-input@vger.kernel.org

Check the Acer OEM-specific Type AA to detect the WiFi/Bluetooth/3G
devices available or not, and set the devices capability flag.

Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Dmitry Torokhov <dtor@mail.ru>
Acked-by: Thomas Renninger <trenn@suse.de>
Acked-by: Jiri Benc <jbenc@suse.cz>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk> 
Cc: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/acer-wmi.c |   49 +++++++++++++++++++++++++++++++++-----
 1 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 6ac4656..dc23140 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -39,6 +39,7 @@
 #include <linux/slab.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
+#include <linux/dmi.h>
 
 #include <acpi/acpi_drivers.h>
 
@@ -138,7 +139,9 @@ struct lm_return_value {
 /*
  * GUID3 Get Device Status device flags
  */
+#define ACER_WMID3_GDS_WIRELESS		(1<<0)	/* WiFi */
 #define ACER_WMID3_GDS_THREEG		(1<<6)	/* 3G */
+#define ACER_WMID3_GDS_BLUETOOTH	(1<<11)	/* BT */
 
 struct wmid3_gds_input_param {	/* Get Device Status input parameter */
 	u8 function_num;	/* Function Number */
@@ -153,6 +156,13 @@ struct wmid3_gds_return_value {	/* Get Device Status return value*/
 	u32 reserved;
 } __attribute__((packed));
 
+struct hotkey_function_type_aa {
+	u8 type;
+	u8 length;
+	u16 handle;
+	u16 commun_func_bitmap;
+} __attribute__((packed));
+
 /*
  * Interface capability flags
  */
@@ -184,6 +194,7 @@ static int brightness = -1;
 static int threeg = -1;
 static int force_series;
 static bool ec_raw_mode;
+static bool has_type_aa;
 
 module_param(mailled, int, 0444);
 module_param(brightness, int, 0444);
@@ -824,6 +835,28 @@ static acpi_status WMID_set_u32(u32 value, u32 cap, struct wmi_interface *iface)
 	return WMI_execute_u32(method_id, (u32)value, NULL);
 }
 
+static void type_aa_dmi_decode(const struct dmi_header *header, void *dummy)
+{
+	struct hotkey_function_type_aa *type_aa;
+
+	/* We are looking for OEM-specific Type AAh */
+	if (header->type != 0xAA)
+		return;
+
+	has_type_aa = true;
+	type_aa = (struct hotkey_function_type_aa *) header;
+
+	printk(ACER_INFO "Function bitmap for Communication Button: 0x%x\n",
+		type_aa->commun_func_bitmap);
+
+	if (type_aa->commun_func_bitmap & ACER_WMID3_GDS_WIRELESS)
+		interface->capability |= ACER_CAP_WIRELESS;
+	if (type_aa->commun_func_bitmap & ACER_WMID3_GDS_THREEG)
+		interface->capability |= ACER_CAP_THREEG;
+	if (type_aa->commun_func_bitmap & ACER_WMID3_GDS_BLUETOOTH)
+		interface->capability |= ACER_CAP_BLUETOOTH;
+}
+
 static acpi_status WMID_set_capabilities(void)
 {
 	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
@@ -844,16 +877,17 @@ static acpi_status WMID_set_capabilities(void)
 		return AE_ERROR;
 	}
 
-	/* Not sure on the meaning of the relevant bits yet to detect these */
-	interface->capability |= ACER_CAP_WIRELESS;
-	interface->capability |= ACER_CAP_THREEG;
+	dmi_walk(type_aa_dmi_decode, NULL);
+	if (!has_type_aa) {
+		interface->capability |= ACER_CAP_WIRELESS;
+		interface->capability |= ACER_CAP_THREEG;
+		if (devices & 0x10)
+			interface->capability |= ACER_CAP_BLUETOOTH;
+	}
 
 	/* WMID always provides brightness methods */
 	interface->capability |= ACER_CAP_BRIGHTNESS;
 
-	if (devices & 0x10)
-		interface->capability |= ACER_CAP_BLUETOOTH;
-
 	if (!(devices & 0x20))
 		max_brightness = 0x9;
 
@@ -932,7 +966,8 @@ static void __init acer_commandline_init(void)
 	 * capability isn't available on the given interface
 	 */
 	set_u32(mailled, ACER_CAP_MAILLED);
-	set_u32(threeg, ACER_CAP_THREEG);
+	if (!has_type_aa)
+		set_u32(threeg, ACER_CAP_THREEG);
 	set_u32(brightness, ACER_CAP_BRIGHTNESS);
 }
 
-- 
1.6.0.2
