From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 3/3] Add 3G rfkill sysfs file
Date: Mon, 18 Oct 2010 08:54:38 -0600
Message-ID: <4CBCFA5E020000230002210B@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: carlos@strangeworlds.co.uk
Cc: corentin.chary@gmail.com, dmitry.torokhov@gmail.com, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi Carlos,=20

=E6=96=BC =E6=97=A5=EF=BC=8C2010-10-17 =E6=96=BC 22:53 -0600=EF=BC=8CJo=
ey Lee =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi Carlos,=20
>=20
> First, Thank's for your kindly review my patches.

> > >  /*
> > >   * Rfkill devices
> > >   */
> > > @@ -1020,6 +1089,13 @@ static void acer_rfkill_update(struct work=
_struct
> > > *ignored) rfkill_set_sw_state(bluetooth_rfkill, !state);
> > >  	}
> > >=20
> > > +	if (has_cap(ACER_CAP_BLUETOOTH) && wmi_has_guid(WMID_GUID3)) {
> > > +		status =3D acer_wmi_get_device_status(&state,
> > > +				ACER_WMID_GUID3_GDS_THREEG);
> > > +		if (ACPI_SUCCESS(status))
> > > +			rfkill_set_sw_state(bluetooth_rfkill, !state);
> > >=20

Sorry, I found a bug that is I check wrong capability
ACER_CAP_BLUETOOTH.
=46ixed it:

>From cf4d295c2d31c8868e75da3f37dbffb44ea93598 Mon Sep 17 00:00:00 2001
=46rom: Lee, Chun-Yi <jlee@novell.com>
Date: Mon, 18 Oct 2010 22:34:14 +0800
Subject: [PATCH 3/3] Add 3G rfkill sysfs file

Add 3G rfkill sysfs file for provide userland to control 3G device
on/off by using WMI method.

Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
---
 drivers/platform/x86/acer-wmi.c |   99
++++++++++++++++++++++++++++++++++++++-
 1 files changed, 98 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c
b/drivers/platform/x86/acer-wmi.c
index 0e233dc..7a17ebe 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -136,6 +136,24 @@ struct lm_return_value {
 } __attribute__((packed));
=20
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
=20
 static struct rfkill *wireless_rfkill;
 static struct rfkill *bluetooth_rfkill;
+static struct rfkill *threeg_rfkill;
=20
 /* Each low-level interface must define at least some of the following
*/
 struct wmi_interface {
@@ -1000,6 +1019,54 @@ static void acer_backlight_exit(void)
 	backlight_device_unregister(acer_backlight_device);
 }
=20
+static acpi_status wmid3_get_device_status(u32 *value, u16 device)
+{
+	struct wmid3_gds_return_value return_value;
+	acpi_status status;
+	union acpi_object *obj;
+	struct wmid3_gds_input_param params =3D {
+		.function_num =3D 0x1,
+		.hotkey_number =3D 0x01,
+		.devices =3D device,
+	};
+	struct acpi_buffer input =3D {
+		sizeof(struct wmid3_gds_input_param),
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
+	return_value =3D *((struct wmid3_gds_return_value
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
@@ -1020,6 +1087,13 @@ static void acer_rfkill_update(struct work_struc=
t
*ignored)
 			rfkill_set_sw_state(bluetooth_rfkill, !state);
 	}
=20
+	if (has_cap(ACER_CAP_THREEG) && wmi_has_guid(WMID_GUID3)) {
+		status =3D wmid3_get_device_status(&state,
+				ACER_WMID3_GDS_THREEG);
+		if (ACPI_SUCCESS(status))
+			rfkill_set_sw_state(threeg_rfkill, !state);
+	}
+
 	schedule_delayed_work(&acer_rfkill_work, round_jiffies_relative(HZ));
 }
=20
@@ -1076,6 +1150,19 @@ static int acer_rfkill_init(struct device *dev)
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
=20
@@ -1102,7 +1194,12 @@ static ssize_t show_bool_threeg(struct device
*dev,
 	struct device_attribute *attr, char *buf)
 {
 	u32 result; \
-	acpi_status status =3D get_u32(&result, ACER_CAP_THREEG);
+	acpi_status status;
+	if (wmi_has_guid(WMID_GUID3))
+		status =3D wmid3_get_device_status(&result,
+				ACER_WMID3_GDS_THREEG);
+	else
+		status =3D get_u32(&result, ACER_CAP_THREEG);
 	if (ACPI_SUCCESS(status))
 		return sprintf(buf, "%u\n", result);
 	return sprintf(buf, "Read error\n");
--=20
1.6.0.2



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
