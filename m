From: Daniel Nicoletti <dantti12@gmail.com>
Subject: Re: [PATCH RFC] hid-input: add support for HID devices reporting
 Battery Strength
Date: Fri, 2 Dec 2011 03:52:22 -0200
Message-ID: <CACo8zOd45i3EnCVMyJoDPP4bx2AnD9mEjDiC=bJKvmX=TWfXGg@mail.gmail.com>
References: <4EC75224.7070207@goop.org>
	<alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz>
	<4EC820F8.4070900@goop.org>
	<alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz>
	<4ECA7E7D.80207@goop.org>
	<alpine.LNX.2.00.1111220028130.28728@pobox.suse.cz>
	<4ECAE019.4000409@goop.org>
	<alpine.LNX.2.00.1111220049470.28728@pobox.suse.cz>
	<4ECCB38A.8000503@goop.org>
	<alpine.LNX.2.00.1111281111510.15446@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62498 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab1LBFwY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Dec 2011 00:52:24 -0500
Received: by iage36 with SMTP id e36so3641630iag.19
        for <linux-input@vger.kernel.org>; Thu, 01 Dec 2011 21:52:24 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1111281111510.15446@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Jiri Kosina <jkosina@suse.cz>, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>

I've sent an email earlier asking for help with a GetFeature code, and =
now I
have a second patch on top of Jeremy's to provide the battery functiona=
lity
for devices that support reporting it.

If I understood correctly when talking to Jeremy he said his device
never actually
reported the status as an input event (sorry if I didn't understand it
correctly), and
after reading HID specs I believe it's really because it was meant to b=
e probed,
I have an Apple Keyboard and Magic Trackpad both bluetooth batteries op=
erated,
so using PacketLogger I saw that Mac OSX always ask the battery status =
using
the so called GetFeature.

What my patch does is basically:
- store the report id that matches the battery_strength
- setup the battery if 0x6.0x20 is found, even if that is reported as a=
 feature
  (as it was meant to be but only the MagicTrackpad does)
- when upower or someone access /sys/class/power_supply/hid-*/capacity =
it
  will probe the device and return it's status.

It works great for both devices, but I have two concerns:
- the report_features function has a duplicated code
- it would be nice if it was possible for specific drivers to provide t=
heir own
  probe as there might be some strange devices... (but maybe it's
already possible)

I've talked to the upower dev and he fixed it to be able to show the
right percentage.

Here how the uevent file (in /sys/class/power_supply/hid-*/) looks like=
:
POWER_SUPPLY_NAME=3Dhid-00:22:41:D9:18:E7-battery
POWER_SUPPLY_PRESENT=3D1
POWER_SUPPLY_ONLINE=3D1
POWER_SUPPLY_CAPACITY=3D66
POWER_SUPPLY_MODEL_NAME=3DMacAdmin=92s keyboard
POWER_SUPPLY_STATUS=3DDischarging

POWER_SUPPLY_NAME=3Dhid-70:CD:60:F5:FF:3F-battery
POWER_SUPPLY_PRESENT=3D1
POWER_SUPPLY_ONLINE=3D1
POWER_SUPPLY_CAPACITY=3D62
POWER_SUPPLY_MODEL_NAME=3Dnexx=92s Trackpad
POWER_SUPPLY_STATUS=3DDischarging

and the patch (note that this is my first kernel patch so sorry if
formatting is not ok, should I attach it?):
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index b9b8c75..8fac47c 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -277,6 +277,7 @@ static enum power_supply_property
hidinput_battery_props[] =3D {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_STATUS
 };

 static int hidinput_get_battery_property(struct power_supply *psy,
@@ -285,6 +286,9 @@ static int hidinput_get_battery_property(struct
power_supply *psy,
 {
 	struct hid_device *dev =3D container_of(psy, struct hid_device, batte=
ry);
 	int ret =3D 0;
+	int ret_rep;
+	__u8 *buf =3D NULL;
+	unsigned char report_number =3D dev->battery_report_id;

 	switch (prop) {
 	case POWER_SUPPLY_PROP_PRESENT:
@@ -293,28 +297,45 @@ static int hidinput_get_battery_property(struct
power_supply *psy,
 		break;

 	case POWER_SUPPLY_PROP_CAPACITY:
-		if (dev->battery_min < dev->battery_max &&
-		    dev->battery_val >=3D dev->battery_min &&
-		    dev->battery_val <=3D dev->battery_max)
-			val->intval =3D (100 * (dev->battery_val - dev->battery_min)) /
-				(dev->battery_max - dev->battery_min);
-		else
+		buf =3D kmalloc(2 * sizeof(__u8), GFP_KERNEL);
+		if (!buf) {
+			ret =3D -ENOMEM;
+			break;
+		}
+
+		memset(buf, 0, sizeof(buf));
+		ret_rep =3D dev->hid_get_raw_report(dev, report_number, buf,
sizeof(buf), HID_FEATURE_REPORT);
+		if (ret_rep !=3D 2) {
 			ret =3D -EINVAL;
+			break;
+		}
+
+		/* store the returned value */
+		/* I'm not calculating this using the logical_minimum and maximum */
+		/* because my device returns 0-100 even though the min and max are 0=
-255 */
+		val->intval =3D buf[1];
 		break;

 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval =3D dev->name;
 		break;

+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+
 	default:
 		ret =3D -EINVAL;
 		break;
 	}

+	if (buf) {
+		kfree(buf);
+	}
 	return ret;
 }

-static void hidinput_setup_battery(struct hid_device *dev, s32 min, s3=
2 max)
+static void hidinput_setup_battery(struct hid_device *dev, unsigned
id, s32 min, s32 max)
 {
 	struct power_supply *battery =3D &dev->battery;
 	int ret;
@@ -326,7 +347,7 @@ static void hidinput_setup_battery(struct
hid_device *dev, s32 min, s32 max)
 	if (battery->name =3D=3D NULL)
 		return;

-	battery->type =3D POWER_SUPPLY_TYPE_BATTERY;
+	battery->type =3D POWER_SUPPLY_TYPE_USB;
 	battery->properties =3D hidinput_battery_props;
 	battery->num_properties =3D ARRAY_SIZE(hidinput_battery_props);
 	battery->use_for_apm =3D 0;
@@ -334,6 +355,7 @@ static void hidinput_setup_battery(struct
hid_device *dev, s32 min, s32 max)

 	dev->battery_min =3D min;
 	dev->battery_max =3D max;
+	dev->battery_report_id =3D id;

 	ret =3D power_supply_register(&dev->dev, battery);
 	if (ret !=3D 0) {
@@ -353,7 +375,7 @@ static void hidinput_cleanup_battery(struct hid_dev=
ice *dev)
 	dev->battery.name =3D NULL;
 }
 #else  /* !CONFIG_HID_BATTERY_STRENGTH */
-static void hidinput_setup_battery(struct hid_device *dev, s32 min, s3=
2 max)
+static void hidinput_setup_battery(struct hid_device *dev, unsigned
id, s32 min, s32 max)
 {
 }

@@ -723,6 +745,7 @@ static void hidinput_configure_usage(struct
hid_input *hidinput, struct hid_fiel
 	case HID_UP_GENDEVCTRLS:
 		if ((usage->hid & HID_USAGE) =3D=3D 0x20) {	/* Battery Strength */
 			hidinput_setup_battery(device,
+					       field->report->id,
 					       field->logical_minimum,
 					       field->logical_maximum);
 			goto ignore;
@@ -997,15 +1020,23 @@ static void report_features(struct hid_device *h=
id)
 	struct hid_report *rep;
 	int i, j;

-	if (!drv->feature_mapping)
-		return;
-
 	rep_enum =3D &hid->report_enum[HID_FEATURE_REPORT];
 	list_for_each_entry(rep, &rep_enum->report_list, list)
 		for (i =3D 0; i < rep->maxfield; i++)
-			for (j =3D 0; j < rep->field[i]->maxusage; j++)
-				drv->feature_mapping(hid, rep->field[i],
-						     rep->field[i]->usage + j);
+			for (j =3D 0; j < rep->field[i]->maxusage; j++) {
+				/* Verify if Battery Strength feature is available */
+				if (((rep->field[i]->usage + j)->hid & HID_USAGE_PAGE) =3D=3D
HID_UP_GENDEVCTRLS &&
+					((rep->field[i]->usage + j)->hid & HID_USAGE) =3D=3D 0x20) {
+					hidinput_setup_battery(hid,
+							       rep->id,
+							       rep->field[i]->logical_minimum,
+							       rep->field[i]->logical_maximum);
+				}
+
+				if (drv->feature_mapping)
+					drv->feature_mapping(hid, rep->field[i],
+							     rep->field[i]->usage + j);
+			}
 }

 /*
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 7f344c3..b5df198 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -496,6 +496,7 @@ struct hid_device {							/* device report descript=
or */
 	__s32 battery_min;
 	__s32 battery_max;
 	__s32 battery_val;
+	__s32 battery_report_id;
 #endif

 	unsigned int status;						/* see STAT flags above */
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
