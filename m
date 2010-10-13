From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH 3/3] Add 3G rfkill sysfs file
Date: Wed, 13 Oct 2010 11:47:42 +0800
Message-ID: <1286941662-9774-3-git-send-email-jlee@novell.com>
References: <1286941662-9774-1-git-send-email-jlee@novell.com>
 <1286941662-9774-2-git-send-email-jlee@novell.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1286941662-9774-2-git-send-email-jlee@novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, tiwai@novell.com, trenn@novell.com, jbenc@suse.cz, corentin.chary@gmail.com, "Lee, Chun-Yi" <jlee@novell.com>
List-Id: linux-input@vger.kernel.org

Add 3G rfkill sysfs file for provide userland to control 3G device
on/off by using WMI method.

Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
---
 drivers/platform/x86/acer-wmi.c |  101 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 100 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index a28a775..150e0e3 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -136,6 +136,26 @@ struct lm_return_value {
 } __attribute__((packed));
 
 /*
+ * GUID3 Get Device Status device flags
+ */
+#define ACER_WMID_GUID3_GDS_WIRELESS		(1<<0)	/* WiFi */
+#define ACER_WMID_GUID3_GDS_THREEG		(1<<6)	/* 3G */
+#define ACER_WMID_GUID3_GDS_BLUETOOTH		(1<<11)	/* BT */
+
+struct guid3_gds_input_param {	/* Get Device Status input parameter */
+	u8 function_num;	/* Function Number */
+	u8 hotkey_number;	/* Hotkey Number */
+	u16 devices;		/* Get Device */
+} __attribute__((packed));
+
+struct guid3_gds_return_value {	/* Get Device Status return value*/
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
@@ -192,6 +212,7 @@ struct acer_debug {
 
 static struct rfkill *wireless_rfkill;
 static struct rfkill *bluetooth_rfkill;
+static struct rfkill *threeg_rfkill;
 
 /* Each low-level interface must define at least some of the following */
 struct wmi_interface {
@@ -1000,6 +1021,54 @@ static void acer_backlight_exit(void)
 	backlight_device_unregister(acer_backlight_device);
 }
 
+static acpi_status acer_wmi_get_device_status(u32 *value, u16 device)
+{
+	struct guid3_gds_return_value return_value;
+	acpi_status status;
+	union acpi_object *obj;
+	struct guid3_gds_input_param params = {
+		.function_num = 0x1,
+		.hotkey_number = 0x01,
+		.devices = device,
+	};
+	struct acpi_buffer input = {
+		sizeof(struct guid3_gds_input_param),
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
+		return -EINVAL;
+	else if (obj->type != ACPI_TYPE_BUFFER) {
+		kfree(obj);
+		return -EINVAL;
+	}
+	if (obj->buffer.length != 8) {
+		printk(ACER_WARNING "Unknown buffer length %d\n",
+			obj->buffer.length);
+		kfree(obj);
+		return -EINVAL;
+	}
+
+	return_value = *((struct guid3_gds_return_value *)obj->buffer.pointer);
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
@@ -1020,6 +1089,13 @@ static void acer_rfkill_update(struct work_struct *ignored)
 			rfkill_set_sw_state(bluetooth_rfkill, !state);
 	}
 
+	if (has_cap(ACER_CAP_BLUETOOTH) && wmi_has_guid(WMID_GUID3)) {
+		status = acer_wmi_get_device_status(&state,
+				ACER_WMID_GUID3_GDS_THREEG);
+		if (ACPI_SUCCESS(status))
+			rfkill_set_sw_state(bluetooth_rfkill, !state);
+	}
+
 	schedule_delayed_work(&acer_rfkill_work, round_jiffies_relative(HZ));
 }
 
@@ -1076,6 +1152,19 @@ static int acer_rfkill_init(struct device *dev)
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
@@ -1092,6 +1181,11 @@ static void acer_rfkill_exit(void)
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
 
@@ -1102,7 +1196,12 @@ static ssize_t show_bool_threeg(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	u32 result; \
-	acpi_status status = get_u32(&result, ACER_CAP_THREEG);
+	acpi_status status;
+	if (wmi_has_guid(WMID_GUID3))
+		status = acer_wmi_get_device_status(&result,
+				ACER_WMID_GUID3_GDS_THREEG);
+	else
+		status = get_u32(&result, ACER_CAP_THREEG);
 	if (ACPI_SUCCESS(status))
 		return sprintf(buf, "%u\n", result);
 	return sprintf(buf, "Read error\n");
-- 
1.6.0.2
