From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v2 08/15] HID: hid-lg4ff: Make lg4ff_wheel_data a separate structure stored within lg4ff_device_entry. Adjust the initialization process accordingly.
Date: Wed,  8 Apr 2015 22:56:46 +0200
Message-ID: <1428526613-24239-9-git-send-email-madcatxster@devoid-pointer.net>
References: <1428526613-24239-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from imap.devoid-pointer.net ([31.31.77.140]:33010 "EHLO
	smtp.devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597AbbDHU52 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Apr 2015 16:57:28 -0400
In-Reply-To: <1428526613-24239-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.or, elias.vds@gmail.com, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>

Make lg4ff_wheel_data a separate structure stored within lg4ff_device_e=
ntry.
Adjust the initialization process accordingly.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/hid-lg4ff.c | 166 +++++++++++++++++++++++++---------------=
--------
 1 file changed, 88 insertions(+), 78 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 04822fb..0f8d726 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -71,7 +71,7 @@
 static void lg4ff_set_range_dfp(struct hid_device *hid, u16 range);
 static void lg4ff_set_range_g25(struct hid_device *hid, u16 range);
=20
-struct lg4ff_device_entry {
+struct lg4ff_wheel_data {
 	u32 product_id;
 	u16 range;
 	u16 min_range;
@@ -84,9 +84,14 @@ struct lg4ff_device_entry {
 	const char *real_tag;
 	const char *real_name;
 	u16 real_product_id;
+
 	void (*set_range)(struct hid_device *hid, u16 range);
 };
=20
+struct lg4ff_device_entry {
+	struct lg4ff_wheel_data wdata;
+};
+
 static const signed short lg4ff_wheel_effects[] =3D {
 	FF_CONSTANT,
 	FF_AUTOCENTER,
@@ -278,11 +283,11 @@ int lg4ff_adjust_input_event(struct hid_device *h=
id, struct hid_field *field,
 		return 0;
 	}
=20
-	switch (entry->product_id) {
+	switch (entry->wdata.product_id) {
 	case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
 		switch (usage->code) {
 		case ABS_X:
-			new_value =3D lg4ff_adjust_dfp_x_axis(value, entry->range);
+			new_value =3D lg4ff_adjust_dfp_x_axis(value, entry->wdata.range);
 			input_event(field->hidinput->input, usage->type, usage->code, new_v=
alue);
 			return 1;
 		default:
@@ -383,7 +388,7 @@ static void lg4ff_set_autocenter_default(struct inp=
ut_dev *dev, u16 magnitude)
 	}
=20
 	/* Adjust for non-MOMO wheels */
-	switch (entry->product_id) {
+	switch (entry->wdata.product_id) {
 	case USB_DEVICE_ID_LOGITECH_MOMO_WHEEL:
 	case USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2:
 		break;
@@ -605,23 +610,23 @@ static ssize_t lg4ff_alternate_modes_show(struct =
device *dev, struct device_attr
 		return 0;
 	}
=20
-	if (!entry->real_name) {
+	if (!entry->wdata.real_name) {
 		hid_err(hid, "NULL pointer to string\n");
 		return 0;
 	}
=20
 	for (i =3D 0; i < LG4FF_MODE_MAX_IDX; i++) {
-		if (entry->alternate_modes & BIT(i)) {
+		if (entry->wdata.alternate_modes & BIT(i)) {
 			/* Print tag and full name */
 			count +=3D scnprintf(buf + count, PAGE_SIZE - count, "%s: %s",
 					   lg4ff_alternate_modes[i].tag,
-					   !lg4ff_alternate_modes[i].product_id ? entry->real_name : lg4f=
f_alternate_modes[i].name);
+					   !lg4ff_alternate_modes[i].product_id ? entry->wdata.real_name =
: lg4ff_alternate_modes[i].name);
 			if (count >=3D PAGE_SIZE - 1)
 				return count;
=20
 			/* Mark the currently active mode with an asterisk */
-			if (lg4ff_alternate_modes[i].product_id =3D=3D entry->product_id ||
-			    (lg4ff_alternate_modes[i].product_id =3D=3D 0 && entry->product=
_id =3D=3D entry->real_product_id))
+			if (lg4ff_alternate_modes[i].product_id =3D=3D entry->wdata.product=
_id ||
+			    (lg4ff_alternate_modes[i].product_id =3D=3D 0 && entry->wdata.p=
roduct_id =3D=3D entry->wdata.real_product_id))
 				count +=3D scnprintf(buf + count, PAGE_SIZE - count, " *\n");
 			else
 				count +=3D scnprintf(buf + count, PAGE_SIZE - count, "\n");
@@ -674,10 +679,10 @@ static ssize_t lg4ff_alternate_modes_store(struct=
 device *dev, struct device_att
 		const u16 mode_product_id =3D lg4ff_alternate_modes[i].product_id;
 		const char *tag =3D lg4ff_alternate_modes[i].tag;
=20
-		if (entry->alternate_modes & BIT(i)) {
+		if (entry->wdata.alternate_modes & BIT(i)) {
 			if (!strcmp(tag, lbuf)) {
 				if (!mode_product_id)
-					target_product_id =3D entry->real_product_id;
+					target_product_id =3D entry->wdata.real_product_id;
 				else
 					target_product_id =3D mode_product_id;
 				break;
@@ -692,24 +697,24 @@ static ssize_t lg4ff_alternate_modes_store(struct=
 device *dev, struct device_att
 	}
 	kfree(lbuf); /* Not needed anymore */
=20
-	if (target_product_id =3D=3D entry->product_id) /* Nothing to do */
+	if (target_product_id =3D=3D entry->wdata.product_id) /* Nothing to d=
o */
 		return count;
=20
 	/* Automatic switching has to be disabled for the switch to DF-EX mod=
e to work correctly */
 	if (target_product_id =3D=3D USB_DEVICE_ID_LOGITECH_WHEEL && !lg4ff_n=
o_autoswitch) {
 		hid_info(hid, "\"%s\" cannot be switched to \"DF-EX\" mode. Load the=
 \"hid_logitech\" module with \"lg4ff_no_autoswitch=3D1\" parameter set=
 and try again\n",
-			 entry->real_name);
+			 entry->wdata.real_name);
 		return -EINVAL;
 	}
=20
 	/* Take care of hardware limitations */
-	if ((entry->real_product_id =3D=3D USB_DEVICE_ID_LOGITECH_DFP_WHEEL |=
| entry->real_product_id =3D=3D USB_DEVICE_ID_LOGITECH_G25_WHEEL) &&
-	    entry->product_id > target_product_id) {
-		hid_info(hid, "\"%s\" cannot be switched back into \"%s\" mode\n", e=
ntry->real_name, lg4ff_alternate_modes[i].name);
+	if ((entry->wdata.real_product_id =3D=3D USB_DEVICE_ID_LOGITECH_DFP_W=
HEEL || entry->wdata.real_product_id =3D=3D USB_DEVICE_ID_LOGITECH_G25_=
WHEEL) &&
+	    entry->wdata.product_id > target_product_id) {
+		hid_info(hid, "\"%s\" cannot be switched back into \"%s\" mode\n", e=
ntry->wdata.real_name, lg4ff_alternate_modes[i].name);
 		return -EINVAL;
 	}
=20
-	s =3D lg4ff_get_mode_switch_command(entry->real_product_id, target_pr=
oduct_id);
+	s =3D lg4ff_get_mode_switch_command(entry->wdata.real_product_id, tar=
get_product_id);
 	if (!s) {
 		hid_err(hid, "Invalid target product ID %X\n", target_product_id);
 		return -EINVAL;
@@ -741,7 +746,7 @@ static ssize_t lg4ff_range_show(struct device *dev,=
 struct device_attribute *att
 		return 0;
 	}
=20
-	count =3D scnprintf(buf, PAGE_SIZE, "%u\n", entry->range);
+	count =3D scnprintf(buf, PAGE_SIZE, "%u\n", entry->wdata.range);
 	return count;
 }
=20
@@ -768,13 +773,13 @@ static ssize_t lg4ff_range_store(struct device *d=
ev, struct device_attribute *at
 	}
=20
 	if (range =3D=3D 0)
-		range =3D entry->max_range;
+		range =3D entry->wdata.max_range;
=20
 	/* Check if the wheel supports range setting
 	 * and that the range is within limits for the wheel */
-	if (entry->set_range !=3D NULL && range >=3D entry->min_range && rang=
e <=3D entry->max_range) {
-		entry->set_range(hid, range);
-		entry->range =3D range;
+	if (entry->wdata.set_range && range >=3D entry->wdata.min_range && ra=
nge <=3D entry->wdata.max_range) {
+		entry->wdata.set_range(hid, range);
+		entry->wdata.range =3D range;
 	}
=20
 	return count;
@@ -800,12 +805,12 @@ static ssize_t lg4ff_real_id_show(struct device *=
dev, struct device_attribute *a
 		return 0;
 	}
=20
-	if (!entry->real_tag || !entry->real_name) {
+	if (!entry->wdata.real_tag || !entry->wdata.real_name) {
 		hid_err(hid, "NULL pointer to string\n");
 		return 0;
 	}
=20
-	count =3D scnprintf(buf, PAGE_SIZE, "%s: %s\n", entry->real_tag, entr=
y->real_name);
+	count =3D scnprintf(buf, PAGE_SIZE, "%s: %s\n", entry->wdata.real_tag=
, entry->wdata.real_name);
 	return count;
 }
=20
@@ -855,15 +860,15 @@ static void lg4ff_led_set_brightness(struct led_c=
lassdev *led_cdev,
 	}
=20
 	for (i =3D 0; i < 5; i++) {
-		if (led_cdev !=3D entry->led[i])
+		if (led_cdev !=3D entry->wdata.led[i])
 			continue;
-		state =3D (entry->led_state >> i) & 1;
+		state =3D (entry->wdata.led_state >> i) & 1;
 		if (value =3D=3D LED_OFF && state) {
-			entry->led_state &=3D ~(1 << i);
-			lg4ff_set_leds(hid, entry->led_state);
+			entry->wdata.led_state &=3D ~(1 << i);
+			lg4ff_set_leds(hid, entry->wdata.led_state);
 		} else if (value !=3D LED_OFF && !state) {
-			entry->led_state |=3D 1 << i;
-			lg4ff_set_leds(hid, entry->led_state);
+			entry->wdata.led_state |=3D 1 << i;
+			lg4ff_set_leds(hid, entry->wdata.led_state);
 		}
 		break;
 	}
@@ -890,8 +895,8 @@ static enum led_brightness lg4ff_led_get_brightness=
(struct led_classdev *led_cde
 	}
=20
 	for (i =3D 0; i < 5; i++)
-		if (led_cdev =3D=3D entry->led[i]) {
-			value =3D (entry->led_state >> i) & 1;
+		if (led_cdev =3D=3D entry->wdata.led[i]) {
+			value =3D (entry->wdata.led_state >> i) & 1;
 			break;
 		}
=20
@@ -1002,6 +1007,16 @@ int lg4ff_init(struct hid_device *hid)
 	if (!hid_validate_values(hid, HID_OUTPUT_REPORT, 0, 0, 7))
 		return -1;
=20
+	drv_data =3D hid_get_drvdata(hid);
+	if (!drv_data) {
+		hid_err(hid, "Cannot add device, private driver data not allocated\n=
");
+		return -1;
+	}
+	entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+	drv_data->device_props =3D entry;
+
 	/* Check if a multimode wheel has been connected and
 	 * handle it appropriately */
 	mmode_ret =3D lg4ff_handle_multimode_wheel(hid, &real_product_id, bcd=
Device);
@@ -1011,6 +1026,11 @@ int lg4ff_init(struct hid_device *hid)
 	 */
 	if (mmode_ret =3D=3D LG4FF_MMODE_SWITCHED)
 		return 0;
+	else if (mmode_ret < 0) {
+		hid_err(hid, "Unable to switch device mode during initialization, er=
rno %d\n", mmode_ret);
+		error =3D mmode_ret;
+		goto err_init;
+	}
=20
 	/* Check what wheel has been connected */
 	for (i =3D 0; i < ARRAY_SIZE(lg4ff_devices); i++) {
@@ -1024,7 +1044,8 @@ int lg4ff_init(struct hid_device *hid)
 		hid_err(hid, "This device is flagged to be handled by the lg4ff modu=
le but this module does not know how to handle it. "
 			     "Please report this as a bug to LKML, Simon Wood <simon@mungew=
ell.org> or "
 			     "Michal Maly <madcatxster@devoid-pointer.net>\n");
-		return -1;
+		error =3D -1;
+		goto err_init;
 	}
=20
 	if (mmode_ret =3D=3D LG4FF_MMODE_IS_MULTIMODE) {
@@ -1035,7 +1056,8 @@ int lg4ff_init(struct hid_device *hid)
=20
 		if (mmode_idx =3D=3D ARRAY_SIZE(lg4ff_multimode_wheels)) {
 			hid_err(hid, "Device product ID %X is not listed as a multimode whe=
el", real_product_id);
-			return -1;
+			error =3D -1;
+			goto err_init;
 		}
 	}
=20
@@ -1046,33 +1068,18 @@ int lg4ff_init(struct hid_device *hid)
 	error =3D input_ff_create_memless(dev, NULL, lg4ff_play);
=20
 	if (error)
-		return error;
-
-	/* Get private driver data */
-	drv_data =3D hid_get_drvdata(hid);
-	if (!drv_data) {
-		hid_err(hid, "Cannot add device, private driver data not allocated\n=
");
-		return -1;
-	}
+		goto err_init;
=20
-	/* Initialize device properties */
-	entry =3D kzalloc(sizeof(struct lg4ff_device_entry), GFP_KERNEL);
-	if (!entry) {
-		hid_err(hid, "Cannot add device, insufficient memory to allocate dev=
ice properties.\n");
-		return -ENOMEM;
-	}
-	drv_data->device_props =3D entry;
-
-	entry->product_id =3D lg4ff_devices[i].product_id;
-	entry->real_product_id =3D real_product_id;
-	entry->min_range =3D lg4ff_devices[i].min_range;
-	entry->max_range =3D lg4ff_devices[i].max_range;
-	entry->set_range =3D lg4ff_devices[i].set_range;
+	entry->wdata.product_id =3D lg4ff_devices[i].product_id;
+	entry->wdata.real_product_id =3D real_product_id;
+	entry->wdata.min_range =3D lg4ff_devices[i].min_range;
+	entry->wdata.max_range =3D lg4ff_devices[i].max_range;
+	entry->wdata.set_range =3D lg4ff_devices[i].set_range;
 	if (mmode_ret =3D=3D LG4FF_MMODE_IS_MULTIMODE) {
 		BUG_ON(mmode_idx =3D=3D -1);
-		entry->alternate_modes =3D lg4ff_multimode_wheels[mmode_idx].alterna=
te_modes;
-		entry->real_tag =3D lg4ff_multimode_wheels[mmode_idx].real_tag;
-		entry->real_name =3D lg4ff_multimode_wheels[mmode_idx].real_name;
+		entry->wdata.alternate_modes =3D lg4ff_multimode_wheels[mmode_idx].a=
lternate_modes;
+		entry->wdata.real_tag =3D lg4ff_multimode_wheels[mmode_idx].real_tag=
;
+		entry->wdata.real_name =3D lg4ff_multimode_wheels[mmode_idx].real_na=
me;
 	}
=20
 	/* Check if autocentering is available and
@@ -1091,27 +1098,28 @@ int lg4ff_init(struct hid_device *hid)
 	/* Create sysfs interface */
 	error =3D device_create_file(&hid->dev, &dev_attr_range);
 	if (error)
-		return error;
+		goto err_init;
 	if (mmode_ret =3D=3D LG4FF_MMODE_IS_MULTIMODE) {
 		error =3D device_create_file(&hid->dev, &dev_attr_real_id);
 		if (error)
-			return error;
+			goto err_init;
+
 		error =3D device_create_file(&hid->dev, &dev_attr_alternate_modes);
 		if (error)
-			return error;
+			goto err_init;
 	}
 	dbg_hid("sysfs interface created\n");
=20
 	/* Set the maximum range to start with */
-	entry->range =3D entry->max_range;
-	if (entry->set_range !=3D NULL)
-		entry->set_range(hid, entry->range);
+	entry->wdata.range =3D entry->wdata.max_range;
+	if (entry->wdata.set_range)
+		entry->wdata.set_range(hid, entry->wdata.range);
=20
 #ifdef CONFIG_LEDS_CLASS
 	/* register led subsystem - G27 only */
-	entry->led_state =3D 0;
+	entry->wdata.led_state =3D 0;
 	for (j =3D 0; j < 5; j++)
-		entry->led[j] =3D NULL;
+		entry->wdata.led[j] =3D NULL;
=20
 	if (lg4ff_devices[i].product_id =3D=3D USB_DEVICE_ID_LOGITECH_G27_WHE=
EL) {
 		struct led_classdev *led;
@@ -1126,7 +1134,7 @@ int lg4ff_init(struct hid_device *hid)
 			led =3D kzalloc(sizeof(struct led_classdev)+name_sz, GFP_KERNEL);
 			if (!led) {
 				hid_err(hid, "can't allocate memory for LED %d\n", j);
-				goto err;
+				goto err_leds;
 			}
=20
 			name =3D (void *)(&led[1]);
@@ -1137,16 +1145,16 @@ int lg4ff_init(struct hid_device *hid)
 			led->brightness_get =3D lg4ff_led_get_brightness;
 			led->brightness_set =3D lg4ff_led_set_brightness;
=20
-			entry->led[j] =3D led;
+			entry->wdata.led[j] =3D led;
 			error =3D led_classdev_register(&hid->dev, led);
=20
 			if (error) {
 				hid_err(hid, "failed to register LED %d. Aborting.\n", j);
-err:
+err_leds:
 				/* Deregister LEDs (if any) */
 				for (j =3D 0; j < 5; j++) {
-					led =3D entry->led[j];
-					entry->led[j] =3D NULL;
+					led =3D entry->wdata.led[j];
+					entry->wdata.led[j] =3D NULL;
 					if (!led)
 						continue;
 					led_classdev_unregister(led);
@@ -1160,6 +1168,11 @@ out:
 #endif
 	hid_info(hid, "Force feedback support for Logitech Gaming Wheels\n");
 	return 0;
+
+err_init:
+	drv_data->device_props =3D NULL;
+	kfree(entry);
+	return error;
 }
=20
 int lg4ff_deinit(struct hid_device *hid)
@@ -1176,14 +1189,13 @@ int lg4ff_deinit(struct hid_device *hid)
 	if (!entry)
 		goto out; /* Nothing more to do */
=20
-	device_remove_file(&hid->dev, &dev_attr_range);
-
 	/* Multimode devices will have at least the "MODE_NATIVE" bit set */
-	if (entry->alternate_modes) {
+	if (entry->wdata.alternate_modes) {
 		device_remove_file(&hid->dev, &dev_attr_real_id);
 		device_remove_file(&hid->dev, &dev_attr_alternate_modes);
 	}
=20
+	device_remove_file(&hid->dev, &dev_attr_range);
 #ifdef CONFIG_LEDS_CLASS
 	{
 		int j;
@@ -1192,8 +1204,8 @@ int lg4ff_deinit(struct hid_device *hid)
 		/* Deregister LEDs (if any) */
 		for (j =3D 0; j < 5; j++) {
=20
-			led =3D entry->led[j];
-			entry->led[j] =3D NULL;
+			led =3D entry->wdata.led[j];
+			entry->wdata.led[j] =3D NULL;
 			if (!led)
 				continue;
 			led_classdev_unregister(led);
@@ -1202,9 +1214,7 @@ int lg4ff_deinit(struct hid_device *hid)
 	}
 #endif
=20
-	/* Deallocate memory */
 	kfree(entry);
-
 out:
 	dbg_hid("Device successfully unregistered\n");
 	return 0;
--=20
2.3.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
