From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 3/3] Add 3G rfkill sysfs file
Date: Wed, 13 Oct 2010 00:25:43 -0600
Message-ID: <4CB5EB970200002300021C0D@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com, dmitry.torokhov@gmail.com, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi all,=20

=E6=96=BC =E4=B8=89=EF=BC=8C2010-10-13 =E6=96=BC 11:47 +0800=EF=BC=8CLe=
e, Chun-Yi =E6=8F=90=E5=88=B0=EF=BC=9A
> Add 3G rfkill sysfs file for provide userland to control 3G device
> on/off by using WMI method.
>  /*
>   * Rfkill devices
>   */
> @@ -1020,6 +1089,13 @@ static void acer_rfkill_update(struct work_str=
uct *ignored)
>  			rfkill_set_sw_state(bluetooth_rfkill, !state);
>  	}
> =20
> +	if (has_cap(ACER_CAP_BLUETOOTH) && wmi_has_guid(WMID_GUID3)) {
> +		status =3D acer_wmi_get_device_status(&state,
> +				ACER_WMID_GUID3_GDS_THREEG);
> +		if (ACPI_SUCCESS(status))
> +			rfkill_set_sw_state(bluetooth_rfkill, !state);
> +	}

Sorry, I found a bug that was update wrong rfkill file. Fixed it to
update threeg_rfkill state:

>From fa8b5f9f1127a74e9b9ddd79d6eb1561b76b34b2 Mon Sep 17 00:00:00 2001
=46rom: Lee, Chun-Yi <jlee@novell.com>
Date: Wed, 13 Oct 2010 14:17:47 +0800
Subject: [PATCH 3/3] Add 3G rfkill sysfs file

Add 3G rfkill sysfs file for provide userland to control 3G device
on/off by using WMI method.

Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
---
 drivers/platform/x86/acer-wmi.c |  101
++++++++++++++++++++++++++++++++++++++-
 1 files changed, 100 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c
b/drivers/platform/x86/acer-wmi.c
index a28a775..97fad8a 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -136,6 +136,26 @@ struct lm_return_value {
 } __attribute__((packed));
=20
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
=20
 static struct rfkill *wireless_rfkill;
 static struct rfkill *bluetooth_rfkill;
+static struct rfkill *threeg_rfkill;
=20
 /* Each low-level interface must define at least some of the following
*/
 struct wmi_interface {
@@ -1000,6 +1021,54 @@ static void acer_backlight_exit(void)
 	backlight_device_unregister(acer_backlight_device);
 }
=20
+static acpi_status acer_wmi_get_device_status(u32 *value, u16 device)
+{
+	struct guid3_gds_return_value return_value;
+	acpi_status status;
+	union acpi_object *obj;
+	struct guid3_gds_input_param params =3D {
+		.function_num =3D 0x1,
+		.hotkey_number =3D 0x01,
+		.devices =3D device,
+	};
+	struct acpi_buffer input =3D {
+		sizeof(struct guid3_gds_input_param),
+		&params
+	};
+	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
+
+	status =3D wmi_evaluate_method(WMID_GUID3, 0, 0x2, &input, &output);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	obj =3D output.pointer;
+
+	if (!obj)
+		return -EINVAL;
+	else if (obj->type !=3D ACPI_TYPE_BUFFER) {
+		kfree(obj);
+		return -EINVAL;
+	}
+	if (obj->buffer.length !=3D 8) {
+		printk(ACER_WARNING "Unknown buffer length %d\n",
+			obj->buffer.length);
+		kfree(obj);
+		return -EINVAL;
+	}
+
+	return_value =3D *((struct guid3_gds_return_value
*)obj->buffer.pointer);
+	kfree(obj);
+
+	if (return_value.error_code || return_value.ec_return_value)
+		printk(ACER_WARNING "Get Device Status failed: "
+			"0x%x - 0x%x\n", return_value.error_code,
+			return_value.ec_return_value);
+	else
+		*value =3D !!(return_value.devices & device);
+
+	return status;
+}
+
 /*
  * Rfkill devices
  */
@@ -1020,6 +1089,13 @@ static void acer_rfkill_update(struct work_struc=
t
*ignored)
 			rfkill_set_sw_state(bluetooth_rfkill, !state);
 	}
=20
+	if (has_cap(ACER_CAP_BLUETOOTH) && wmi_has_guid(WMID_GUID3)) {
+		status =3D acer_wmi_get_device_status(&state,
+				ACER_WMID_GUID3_GDS_THREEG);
+		if (ACPI_SUCCESS(status))
+			rfkill_set_sw_state(threeg_rfkill, !state);
+	}
+
 	schedule_delayed_work(&acer_rfkill_work, round_jiffies_relative(HZ));
 }
=20
@@ -1076,6 +1152,19 @@ static int acer_rfkill_init(struct device *dev)
 		}
 	}
=20
+	if (has_cap(ACER_CAP_THREEG)) {
+		threeg_rfkill =3D acer_rfkill_register(dev,
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
=20
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
=20
@@ -1102,7 +1196,12 @@ static ssize_t show_bool_threeg(struct device
*dev,
 	struct device_attribute *attr, char *buf)
 {
 	u32 result; \
-	acpi_status status =3D get_u32(&result, ACER_CAP_THREEG);
+	acpi_status status;
+	if (wmi_has_guid(WMID_GUID3))
+		status =3D acer_wmi_get_device_status(&result,
+				ACER_WMID_GUID3_GDS_THREEG);
+	else
+		status =3D get_u32(&result, ACER_CAP_THREEG);
 	if (ACPI_SUCCESS(status))
 		return sprintf(buf, "%u\n", result);
 	return sprintf(buf, "Read error\n");
--=20
1.6.0.2
