From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH 3/4] acer-wmi: Add 3G rfkill sysfs file
Date: Tue,  7 Dec 2010 10:29:22 +0800
Message-ID: <1291688963-23232-4-git-send-email-jlee@novell.com>
References: <1291688963-23232-1-git-send-email-jlee@novell.com>
 <1291688963-23232-2-git-send-email-jlee@novell.com>
 <1291688963-23232-3-git-send-email-jlee@novell.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1291688963-23232-3-git-send-email-jlee@novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: dmitry.torokhov@gmail.com, corentin.chary@gmail.com, corentincj@iksaif.net, tiwai@novell.com, carlos@strangeworlds.co.uk, jbenc@suse.cz, jdelvare@suse.de, trenn@suse.de, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, "Lee, Chun-Yi" <jlee@novell.com>
List-Id: linux-input@vger.kernel.org

Add 3G rfkill sysfs file for provide userland to control 3G device
on/off by using WMI method.

Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
Acked-by: Thomas Renninger <trenn@suse.de>
Acked-by: Jiri Benc <jbenc@suse.cz>
Acked-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Carlos Corbaho <carlos@strangeworlds.co.uk>
Cc: Corentin Chary <corentincj@iksaif.net> 
---
 drivers/platform/x86/acer-wmi.c |   99 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 98 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 1568721..6ac4656 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -136,6 +136,24 @@ struct lm_return_value {
 } __attribute__((packed));
 
 /*
+ * GUID3 Get Device Status device flags
+ */
+#define ACER_WMID3_GDS_THREEG		(1<<6)	/* 3G */
+
+struct wmid3_gds_input_param {	/* Get Device Status input parameter */
+	u8 function_num;	/* Function Number */
+	u8 hotkey_number;	/* Hotkey Number */
+	u16 devices;		/* Get Device */
+} __attribute__((packed));
+
+struct wmid3_gds_return_value {	/* Get Device Status return value*/
+	u8 error_code;		/* Error Code */
+	u8 ec_return_value;	/* EC Return Value */
+	u16 devices;		/* Current Device Status */
+	u32 reserved;
+} __attribute__((packed));
+
+/*
  * Interface capability flags
  */
 #define ACER_CAP_MAILLED		(1<<0)
@@ -192,6 +210,7 @@ struct acer_debug {
 
 static struct rfkill *wireless_rfkill;
 static struct rfkill *bluetooth_rfkill;
+static struct rfkill *threeg_rfkill;
 
 /* Each low-level interface must define at least some of the following */
 struct wmi_interface {
@@ -1000,6 +1019,54 @@ static void acer_backlight_exit(void)
 	backlight_device_unregister(acer_backlight_device);
 }
 
+static acpi_status wmid3_get_device_status(u32 *value, u16 device)
+{
+	struct wmid3_gds_return_value return_value;
+	acpi_status status;
+	union acpi_object *obj;
+	struct wmid3_gds_input_param params = {
+		.function_num = 0x1,
+		.hotkey_number = 0x01,
+		.devices = device,
+	};
+	struct acpi_buffer input = {
+		sizeof(struct wmid3_gds_input_param),
+		&params
+	};
+	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
+
+	status = wmi_evaluate_method(WMID_GUID3, 0, 0x2, &input, &output);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	obj = output.pointer;
+
+	if (!obj)
+		return AE_ERROR;
+	else if (obj->type != ACPI_TYPE_BUFFER) {
+		kfree(obj);
+		return AE_ERROR;
+	}
+	if (obj->buffer.length != 8) {
+		printk(ACER_WARNING "Unknown buffer length %d\n",
+			obj->buffer.length);
+		kfree(obj);
+		return AE_ERROR;
+	}
+
+	return_value = *((struct wmid3_gds_return_value *)obj->buffer.pointer);
+	kfree(obj);
+
+	if (return_value.error_code || return_value.ec_return_value)
+		printk(ACER_WARNING "Get Device Status failed: "
+			"0x%x - 0x%x\n", return_value.error_code,
+			return_value.ec_return_value);
+	else
+		*value = !!(return_value.devices & device);
+
+	return status;
+}
+
 /*
  * Rfkill devices
  */
@@ -1020,6 +1087,13 @@ static void acer_rfkill_update(struct work_struct *ignored)
 			rfkill_set_sw_state(bluetooth_rfkill, !state);
 	}
 
+	if (has_cap(ACER_CAP_THREEG) && wmi_has_guid(WMID_GUID3)) {
+		status = wmid3_get_device_status(&state,
+				ACER_WMID3_GDS_THREEG);
+		if (ACPI_SUCCESS(status))
+			rfkill_set_sw_state(threeg_rfkill, !state);
+	}
+
 	schedule_delayed_work(&acer_rfkill_work, round_jiffies_relative(HZ));
 }
 
@@ -1076,6 +1150,19 @@ static int acer_rfkill_init(struct device *dev)
 		}
 	}
 
+	if (has_cap(ACER_CAP_THREEG)) {
+		threeg_rfkill = acer_rfkill_register(dev,
+			RFKILL_TYPE_WWAN, "acer-threeg",
+			ACER_CAP_THREEG);
+		if (IS_ERR(threeg_rfkill)) {
+			rfkill_unregister(wireless_rfkill);
+			rfkill_destroy(wireless_rfkill);
+			rfkill_unregister(bluetooth_rfkill);
+			rfkill_destroy(bluetooth_rfkill);
+			return PTR_ERR(threeg_rfkill);
+		}
+	}
+
 	schedule_delayed_work(&acer_rfkill_work, round_jiffies_relative(HZ));
 
 	return 0;
@@ -1092,6 +1179,11 @@ static void acer_rfkill_exit(void)
 		rfkill_unregister(bluetooth_rfkill);
 		rfkill_destroy(bluetooth_rfkill);
 	}
+
+	if (has_cap(ACER_CAP_THREEG)) {
+		rfkill_unregister(threeg_rfkill);
+		rfkill_destroy(threeg_rfkill);
+	}
 	return;
 }
 
@@ -1102,7 +1194,12 @@ static ssize_t show_bool_threeg(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	u32 result; \
-	acpi_status status = get_u32(&result, ACER_CAP_THREEG);
+	acpi_status status;
+	if (wmi_has_guid(WMID_GUID3))
+		status = wmid3_get_device_status(&result,
+				ACER_WMID3_GDS_THREEG);
+	else
+		status = get_u32(&result, ACER_CAP_THREEG);
 	if (ACPI_SUCCESS(status))
 		return sprintf(buf, "%u\n", result);
 	return sprintf(buf, "Read error\n");
-- 
1.6.0.2
