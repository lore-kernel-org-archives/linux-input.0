From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH] Revert "Input: wacom - add 0xE5 (MT device) support"
Date: Thu, 14 Jun 2012 16:23:35 -0500
Message-ID: <20120614212335.GA4210@burratino>
References: <1335402856-11256-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:39998 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab2FNVXo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jun 2012 17:23:44 -0400
Received: by ghrr11 with SMTP id r11so1804230ghr.19
        for <linux-input@vger.kernel.org>; Thu, 14 Jun 2012 14:23:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1335402856-11256-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: dmitry.torokhov@gmail.com, =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>, linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>, Ping Cheng <pingc@wacom.com>

This reverts commit 1963518b9b1b8019d33b4b08deee6f873ffa2730.

It was supposed to just add support for new MTSCREEN devices, but
instead it significantly changed the code handling TABLETPC2FG and
BAMBOO_PT.  That destroys debugability.  Back to the drawing board.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

Ping Cheng wrote:

> Main part of patch is adding support for a new Wacom MT touch
> packet and labels these devices using MTSCREEN type.
>
> Other items of interest:

Agh!

A patch adding new hardware support should not touch existing support
for other devices at the same time.  Especially not cosmetic changes.

[1] has an analysis by Bj=C3=B8rn of why those unrelated changes are
probably buggy, but I don't really care about that at the moment.  If
it were a separate patch with a description explaining what it was
supposed to do, the normal review process would take care of those
things.  Piggy-backing onto another patch is just not a good idea.

How about this patch (untested)?

Thanks,
Jonathan

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=3D55;bug=3D677164

 drivers/input/tablet/wacom.h     |    4 +-
 drivers/input/tablet/wacom_sys.c |   91 +++++++++++++++---------------=
-----
 drivers/input/tablet/wacom_wac.c |   99 ++----------------------------=
--------
 drivers/input/tablet/wacom_wac.h |    8 ---
 4 files changed, 45 insertions(+), 157 deletions(-)

diff --git a/drivers/input/tablet/wacom.h b/drivers/input/tablet/wacom.=
h
index b79d45198d82..b4842d0e61dd 100644
--- a/drivers/input/tablet/wacom.h
+++ b/drivers/input/tablet/wacom.h
@@ -135,6 +135,6 @@ extern const struct usb_device_id wacom_ids[];
=20
 void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len);
 void wacom_setup_device_quirks(struct wacom_features *features);
-int wacom_setup_input_capabilities(struct input_dev *input_dev,
-				   struct wacom_wac *wacom_wac);
+void wacom_setup_input_capabilities(struct input_dev *input_dev,
+				    struct wacom_wac *wacom_wac);
 #endif
diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wa=
com_sys.c
index cad5602d3ce4..a0cc46e5f13c 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -320,10 +320,6 @@ static int wacom_parse_hid(struct usb_interface *i=
ntf,
 							/* need to reset back */
 							features->pktlen =3D WACOM_PKGLEN_TPC2FG;
 						}
-
-						if (features->type =3D=3D MTSCREEN)
-							features->pktlen =3D WACOM_PKGLEN_MTOUCH;
-
 						if (features->type =3D=3D BAMBOO_PT) {
 							/* need to reset back */
 							features->pktlen =3D WACOM_PKGLEN_BBTOUCH;
@@ -356,15 +352,18 @@ static int wacom_parse_hid(struct usb_interface *=
intf,
 			case HID_USAGE_Y:
 				if (usage =3D=3D WCM_DESKTOP) {
 					if (finger) {
-						int type =3D features->type;
-
-						if (type =3D=3D TABLETPC2FG || type =3D=3D MTSCREEN) {
+						features->device_type =3D BTN_TOOL_FINGER;
+						if (features->type =3D=3D TABLETPC2FG) {
+							/* need to reset back */
+							features->pktlen =3D WACOM_PKGLEN_TPC2FG;
 							features->y_max =3D
 								get_unaligned_le16(&report[i + 3]);
 							features->y_phy =3D
 								get_unaligned_le16(&report[i + 6]);
 							i +=3D 7;
-						} else if (type =3D=3D BAMBOO_PT) {
+						} else if (features->type =3D=3D BAMBOO_PT) {
+							/* need to reset back */
+							features->pktlen =3D WACOM_PKGLEN_BBTOUCH;
 							features->y_phy =3D
 								get_unaligned_le16(&report[i + 3]);
 							features->y_max =3D
@@ -378,6 +377,10 @@ static int wacom_parse_hid(struct usb_interface *i=
ntf,
 							i +=3D 4;
 						}
 					} else if (pen) {
+						/* penabled only accepts exact bytes of data */
+						if (features->type =3D=3D TABLETPC2FG)
+							features->pktlen =3D WACOM_PKGLEN_GRAPHIRE;
+						features->device_type =3D BTN_TOOL_PEN;
 						features->y_max =3D
 							get_unaligned_le16(&report[i + 3]);
 						i +=3D 4;
@@ -440,29 +443,22 @@ static int wacom_query_tablet_data(struct usb_int=
erface *intf, struct wacom_feat
 	if (!rep_data)
 		return error;
=20
-	/* ask to report Wacom data */
-	if (features->device_type =3D=3D BTN_TOOL_FINGER) {
-		/* if it is an MT Tablet PC touch */
-		if (features->type =3D=3D TABLETPC2FG ||
-		    features->type =3D=3D MTSCREEN) {
-			do {
-				rep_data[0] =3D 3;
-				rep_data[1] =3D 4;
-				rep_data[2] =3D 0;
-				rep_data[3] =3D 0;
-				report_id =3D 3;
-				error =3D wacom_set_report(intf,
-							 WAC_HID_FEATURE_REPORT,
-							 report_id,
-							 rep_data, 4, 1);
-				if (error >=3D 0)
-					error =3D wacom_get_report(intf,
-							WAC_HID_FEATURE_REPORT,
-							report_id,
-							rep_data, 4, 1);
-			} while ((error < 0 || rep_data[1] !=3D 4) &&
-				 limit++ < WAC_MSG_RETRIES);
-		}
+	/* ask to report tablet data if it is MT Tablet PC or
+	 * not a Tablet PC */
+	if (features->type =3D=3D TABLETPC2FG) {
+		do {
+			rep_data[0] =3D 3;
+			rep_data[1] =3D 4;
+			rep_data[2] =3D 0;
+			rep_data[3] =3D 0;
+			report_id =3D 3;
+			error =3D wacom_set_report(intf, WAC_HID_FEATURE_REPORT,
+						 report_id, rep_data, 4, 1);
+			if (error >=3D 0)
+				error =3D wacom_get_report(intf,
+						WAC_HID_FEATURE_REPORT,
+						report_id, rep_data, 4, 1);
+		} while ((error < 0 || rep_data[1] !=3D 4) && limit++ < WAC_MSG_RETR=
IES);
 	} else if (features->type !=3D TABLETPC &&
 		   features->type !=3D WIRELESS &&
 		   features->device_type =3D=3D BTN_TOOL_PEN) {
@@ -484,7 +480,7 @@ static int wacom_query_tablet_data(struct usb_inter=
face *intf, struct wacom_feat
 }
=20
 static int wacom_retrieve_hid_descriptor(struct usb_interface *intf,
-					 struct wacom_features *features)
+		struct wacom_features *features)
 {
 	int error =3D 0;
 	struct usb_host_interface *interface =3D intf->cur_altsetting;
@@ -512,13 +508,10 @@ static int wacom_retrieve_hid_descriptor(struct u=
sb_interface *intf,
 		}
 	}
=20
-	/* only devices that support touch need to retrieve the info */
-	if (features->type !=3D TABLETPC &&
-	    features->type !=3D TABLETPC2FG &&
-	    features->type !=3D BAMBOO_PT &&
-	    features->type !=3D MTSCREEN) {
+	/* only Tablet PCs and Bamboo P&T need to retrieve the info */
+	if ((features->type !=3D TABLETPC) && (features->type !=3D TABLETPC2F=
G) &&
+	    (features->type !=3D BAMBOO_PT))
 		goto out;
-	}
=20
 	error =3D usb_get_extra_descriptor(interface, HID_DEVICET_HID, &hid_d=
esc);
 	if (error) {
@@ -990,10 +983,8 @@ static int wacom_register_input(struct wacom *waco=
m)
 	int error;
=20
 	input_dev =3D input_allocate_device();
-	if (!input_dev) {
-		error =3D -ENOMEM;
-		goto fail1;
-	}
+	if (!input_dev)
+		return -ENOMEM;
=20
 	input_dev->name =3D wacom_wac->name;
 	input_dev->dev.parent =3D &intf->dev;
@@ -1003,20 +994,14 @@ static int wacom_register_input(struct wacom *wa=
com)
 	input_set_drvdata(input_dev, wacom);
=20
 	wacom_wac->input =3D input_dev;
-	error =3D wacom_setup_input_capabilities(input_dev, wacom_wac);
-	if (error)
-		goto fail1;
+	wacom_setup_input_capabilities(input_dev, wacom_wac);
=20
 	error =3D input_register_device(input_dev);
-	if (error)
-		goto fail2;
+	if (error) {
+		input_free_device(input_dev);
+		wacom_wac->input =3D NULL;
+	}
=20
-	return 0;
-
-fail2:
-	input_free_device(input_dev);
-	wacom_wac->input =3D NULL;
-fail1:
 	return error;
 }
=20
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wa=
com_wac.c
index 004bc1bb1544..5b31418b416b 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -776,72 +776,6 @@ static int wacom_intuos_irq(struct wacom_wac *waco=
m)
 	return 1;
 }
=20
-static int find_slot_from_contactid(struct wacom_wac *wacom, int conta=
ctid)
-{
-	int touch_max =3D wacom->features.touch_max;
-	int i;
-
-	if (!wacom->slots)
-		return -1;
-
-	for (i =3D 0; i < touch_max; ++i) {
-		if (wacom->slots[i] =3D=3D contactid)
-			return i;
-	}
-	for (i =3D 0; i < touch_max; ++i) {
-		if (wacom->slots[i] =3D=3D -1)
-			return i;
-	}
-	return -1;
-}
-
-static int wacom_mt_touch(struct wacom_wac *wacom)
-{
-	struct input_dev *input =3D wacom->input;
-	char *data =3D wacom->data;
-	int i;
-	int current_num_contacts =3D data[2];
-	int contacts_to_send =3D 0;
-
-	/*
-	 * First packet resets the counter since only the first
-	 * packet in series will have non-zero current_num_contacts.
-	 */
-	if (current_num_contacts)
-		wacom->num_contacts_left =3D current_num_contacts;
-
-	/* There are at most 5 contacts per packet */
-	contacts_to_send =3D min(5, wacom->num_contacts_left);
-
-	for (i =3D 0; i < contacts_to_send; i++) {
-		int offset =3D (WACOM_BYTES_PER_MT_PACKET * i) + 3;
-		bool touch =3D data[offset] & 0x1;
-		int id =3D le16_to_cpup((__le16 *)&data[offset + 1]);
-		int slot =3D find_slot_from_contactid(wacom, id);
-
-		if (slot < 0)
-			continue;
-
-		input_mt_slot(input, slot);
-		input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
-		if (touch) {
-			int x =3D le16_to_cpup((__le16 *)&data[offset + 7]);
-			int y =3D le16_to_cpup((__le16 *)&data[offset + 9]);
-			input_report_abs(input, ABS_MT_POSITION_X, x);
-			input_report_abs(input, ABS_MT_POSITION_Y, y);
-		}
-		wacom->slots[slot] =3D touch ? id : -1;
-	}
-
-	input_mt_report_pointer_emulation(input, true);
-
-	wacom->num_contacts_left -=3D contacts_to_send;
-	if (wacom->num_contacts_left < 0)
-		wacom->num_contacts_left =3D 0;
-
-	return 1;
-}
-
 static int wacom_tpc_mt_touch(struct wacom_wac *wacom)
 {
 	struct input_dev *input =3D wacom->input;
@@ -880,9 +814,6 @@ static int wacom_tpc_single_touch(struct wacom_wac =
*wacom, size_t len)
 	bool prox;
 	int x =3D 0, y =3D 0;
=20
-	if (wacom->features.touch_max > 1 || len > WACOM_PKGLEN_TPC2FG)
-		return 0;
-
 	if (!wacom->shared->stylus_in_proximity) {
 		if (len =3D=3D WACOM_PKGLEN_TPC1FG) {
 			prox =3D data[0] & 0x01;
@@ -951,10 +882,10 @@ static int wacom_tpc_irq(struct wacom_wac *wacom,=
 size_t len)
=20
 	switch (len) {
 	case WACOM_PKGLEN_TPC1FG:
-		return wacom_tpc_single_touch(wacom, len);
+		 return wacom_tpc_single_touch(wacom, len);
=20
 	case WACOM_PKGLEN_TPC2FG:
-		return wacom_tpc_mt_touch(wacom);
+ 		return wacom_tpc_mt_touch(wacom);
=20
 	default:
 		switch (data[0]) {
@@ -963,9 +894,6 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, s=
ize_t len)
 		case WACOM_REPORT_TPCST:
 			return wacom_tpc_single_touch(wacom, len);
=20
-		case WACOM_REPORT_TPCMT:
-			return wacom_mt_touch(wacom);
-
 		case WACOM_REPORT_PENABLED:
 			return wacom_tpc_pen(wacom);
 		}
@@ -1245,7 +1173,6 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, s=
ize_t len)
=20
 	case TABLETPC:
 	case TABLETPC2FG:
-	case MTSCREEN:
 		sync =3D wacom_tpc_irq(wacom_wac, len);
 		break;
=20
@@ -1319,8 +1246,7 @@ void wacom_setup_device_quirks(struct wacom_featu=
res *features)
 	/* these device have multiple inputs */
 	if (features->type =3D=3D TABLETPC || features->type =3D=3D TABLETPC2=
=46G ||
 	    features->type =3D=3D BAMBOO_PT || features->type =3D=3D WIRELESS=
 ||
-	    (features->type >=3D INTUOS5S && features->type <=3D INTUOS5L) ||
-	    features->type =3D=3D MTSCREEN)
+	    (features->type >=3D INTUOS5S && features->type <=3D INTUOS5L))
 		features->quirks |=3D WACOM_QUIRK_MULTI_INPUT;
=20
 	/* quirk for bamboo touch with 2 low res touches */
@@ -1351,8 +1277,8 @@ static unsigned int wacom_calculate_touch_res(uns=
igned int logical_max,
        return (logical_max * 100) / physical_max;
 }
=20
-int wacom_setup_input_capabilities(struct input_dev *input_dev,
-				   struct wacom_wac *wacom_wac)
+void wacom_setup_input_capabilities(struct input_dev *input_dev,
+				    struct wacom_wac *wacom_wac)
 {
 	struct wacom_features *features =3D &wacom_wac->features;
 	int i;
@@ -1548,18 +1474,8 @@ int wacom_setup_input_capabilities(struct input_=
dev *input_dev,
 		break;
=20
 	case TABLETPC2FG:
-	case MTSCREEN:
 		if (features->device_type =3D=3D BTN_TOOL_FINGER) {
=20
-			wacom_wac->slots =3D kmalloc(features->touch_max *
-							sizeof(int),
-						   GFP_KERNEL);
-			if (!wacom_wac->slots)
-				return -ENOMEM;
-
-			for (i =3D 0; i < features->touch_max; i++)
-				wacom_wac->slots[i] =3D -1;
-
 			input_mt_init_slots(input_dev, features->touch_max);
 			input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE,
 					0, MT_TOOL_MAX, 0, 0);
@@ -1645,7 +1561,6 @@ int wacom_setup_input_capabilities(struct input_d=
ev *input_dev,
 		}
 		break;
 	}
-	return 0;
 }
=20
 static const struct wacom_features wacom_features_0x00 =3D
@@ -1878,9 +1793,6 @@ static const struct wacom_features wacom_features=
_0xE3 =3D
 	{ "Wacom ISDv4 E3",       WACOM_PKGLEN_TPC2FG,    26202, 16325,  255,
 	  0, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
 	  .touch_max =3D 2 };
-static const struct wacom_features wacom_features_0xE5 =3D
-	{ "Wacom ISDv4 E5",       WACOM_PKGLEN_MTOUCH,    26202, 16325,  255,
-	  0, MTSCREEN, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xE6 =3D
 	{ "Wacom ISDv4 E6",       WACOM_PKGLEN_TPC2FG,    27760, 15694,  255,
 	  0, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
@@ -2059,7 +1971,6 @@ const struct usb_device_id wacom_ids[] =3D {
 	{ USB_DEVICE_WACOM(0x9F) },
 	{ USB_DEVICE_WACOM(0xE2) },
 	{ USB_DEVICE_WACOM(0xE3) },
-	{ USB_DEVICE_WACOM(0xE5) },
 	{ USB_DEVICE_WACOM(0xE6) },
 	{ USB_DEVICE_WACOM(0xEC) },
 	{ USB_DEVICE_WACOM(0x47) },
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wa=
com_wac.h
index 78fbd3f42009..321269c1ac4c 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -25,10 +25,6 @@
 #define WACOM_PKGLEN_BBTOUCH3	64
 #define WACOM_PKGLEN_BBPEN	10
 #define WACOM_PKGLEN_WIRELESS	32
-#define WACOM_PKGLEN_MTOUCH	62
-
-/* wacom data size per MT contact */
-#define WACOM_BYTES_PER_MT_PACKET	11
=20
 /* device IDs */
 #define STYLUS_DEVICE_ID	0x02
@@ -45,7 +41,6 @@
 #define WACOM_REPORT_INTUOS5PAD		3
 #define WACOM_REPORT_TPC1FG		6
 #define WACOM_REPORT_TPC2FG		13
-#define WACOM_REPORT_TPCMT		13
 #define WACOM_REPORT_TPCHID		15
 #define WACOM_REPORT_TPCST		16
=20
@@ -81,7 +76,6 @@ enum {
 	WACOM_MO,
 	TABLETPC,
 	TABLETPC2FG,
-	MTSCREEN,
 	MAX_TYPE
 };
=20
@@ -124,8 +118,6 @@ struct wacom_wac {
 	struct input_dev *input;
 	int pid;
 	int battery_capacity;
-	int num_contacts_left;
-	int *slots;
 };
=20
 #endif
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
