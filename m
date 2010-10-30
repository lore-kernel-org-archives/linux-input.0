From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH 4/4] Detect the WiFi/Bluetooth/3G devices available
Date: Sun, 31 Oct 2010 00:36:33 +0800
Message-ID: <1288456593-6868-4-git-send-email-jlee@novell.com>
References: <1288456593-6868-1-git-send-email-jlee@novell.com>
 <1288456593-6868-2-git-send-email-jlee@novell.com>
 <1288456593-6868-3-git-send-email-jlee@novell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53875 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754813Ab0J3Qhv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Oct 2010 12:37:51 -0400
In-Reply-To: <1288456593-6868-3-git-send-email-jlee@novell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: linux-input@vger.kernel.org, carlos@strangeworlds.co.uk, corentin.chary@gmail.com, dmitry.torokhov@gmail.com, tiwai@novell.com, trenn@novell.com, mjg59@srcf.ucam.org, jbenc@suse.cz, "Lee, Chun-Yi" <jlee@novell.com>

Check the Acer OEM-specific Type AA to detect the WiFi/Bluetooth/3G
devices available or not, and set the devices capability flag.

Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
---
 drivers/platform/x86/acer-wmi.c |   50 ++++++++++++++++++++++++++++++++------
 1 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 9656464..0247a70 100644
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
-#define ACER_WMID3_GDS_THREEG		(1<<6)	/* 3G */
+#define ACER_WMID3_GDS_WIRELESS           (1<<0)  /* WiFi */
+#define ACER_WMID3_GDS_THREEG             (1<<6)  /* 3G */
+#define ACER_WMID3_GDS_BLUETOOTH          (1<<11) /* BT */
 
 struct wmid3_gds_input_param {	/* Get Device Status input parameter */
 	u8 function_num;	/* Function Number */
@@ -153,6 +156,15 @@ struct wmid3_gds_return_value {	/* Get Device Status return value*/
 	u32 reserved;
 } __attribute__((packed));
 
+#define ACER_DMI_DEV_TYPE_AA		170
+
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
@@ -184,6 +196,7 @@ static int brightness = -1;
 static int threeg = -1;
 static int force_series;
 static bool ec_raw_mode;
+static struct hotkey_function_type_aa *type_aa;
 
 module_param(mailled, int, 0444);
 module_param(brightness, int, 0444);
@@ -824,6 +837,18 @@ static acpi_status WMID_set_u32(u32 value, u32 cap, struct wmi_interface *iface)
 	return WMI_execute_u32(method_id, (u32)value, NULL);
 }
 
+static void type_aa_dmi_decode(const struct dmi_header *header, void *dummy)
+{
+	/* We are looking for OEM-specific Type Aah */
+	if (header->type != ACER_DMI_DEV_TYPE_AA)
+		return;
+
+	type_aa = (struct hotkey_function_type_aa *) header;
+
+	printk(ACER_INFO "Function biti map for Communication Button: 0x%x\n",
+		type_aa->commun_func_bitmap);
+}
+
 static acpi_status WMID_set_capabilities(void)
 {
 	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
@@ -844,16 +869,24 @@ static acpi_status WMID_set_capabilities(void)
 		return AE_ERROR;
 	}
 
-	/* Not sure on the meaning of the relevant bits yet to detect these */
-	interface->capability |= ACER_CAP_WIRELESS;
-	interface->capability |= ACER_CAP_THREEG;
+	dmi_walk(type_aa_dmi_decode, NULL);
+	if (type_aa) {
+		if (type_aa->commun_func_bitmap & ACER_WMID3_GDS_WIRELESS)
+			interface->capability |= ACER_CAP_WIRELESS;
+		if (type_aa->commun_func_bitmap & ACER_WMID3_GDS_THREEG)
+			interface->capability |= ACER_CAP_THREEG;
+		if (type_aa->commun_func_bitmap & ACER_WMID3_GDS_BLUETOOTH)
+			interface->capability |= ACER_CAP_BLUETOOTH;
+	} else {
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
 
@@ -932,7 +965,8 @@ static void __init acer_commandline_init(void)
 	 * capability isn't available on the given interface
 	 */
 	set_u32(mailled, ACER_CAP_MAILLED);
-	set_u32(threeg, ACER_CAP_THREEG);
+	if (!type_aa)
+		set_u32(threeg, ACER_CAP_THREEG);
 	set_u32(brightness, ACER_CAP_BRIGHTNESS);
 }
 
-- 
1.6.0.2

