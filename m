From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v3 4/4] HID: hid-lg4ff: Allow switching of Logitech gaming wheels between available compatibility modes through sysfs. This only applies to multimode wheels.
Date: Wed, 18 Feb 2015 17:59:23 +0100
Message-ID: <1424278763-29072-5-git-send-email-madcatxster@devoid-pointer.net>
References: <1424278763-29072-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424278763-29072-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, simon@mungewell.org, elias.vds@gmail.com, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
List-Id: linux-input@vger.kernel.org

Allow switching of Logitech gaming wheels between available compatibili=
ty modes
through sysfs. This only applies to multimode wheels.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 v2: Fix a misleading error message regarding unsupported wheel mode

 .../ABI/testing/sysfs-driver-hid-logitech-lg4ff    |  27 ++-
 drivers/hid/hid-lg4ff.c                            | 204 +++++++++++++=
+++++---
 2 files changed, 201 insertions(+), 30 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff =
b/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff
index 60f24a1..b3f6a2a 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff
+++ b/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff
@@ -15,7 +15,32 @@ Description:	Displays a set of alternate modes suppo=
rted by a wheel. Each
 		  Tag: Mode Name
 		Currently active mode is marked with an asterisk. List also
 		contains an abstract item "native" which always denotes the
-		native mode of the wheel.
+		native mode of the wheel. Echoing the mode tag switches the
+		wheel into the corresponding mode. Depending on the exact model
+		of the wheel not all listed modes might always be selectable.
+		If a wheel cannot be switched into the desired mode, -EINVAL
+		is returned accompanied with an explanatory message in the
+		kernel log.
+		This entry is not created for devices that have only one mode.
+
+		Currently supported mode switches:
+		Driving Force Pro:
+		  DF-EX --> DFP
+
+		G25:
+		  DF-EX --> DFP --> G25
+
+		G27:
+		  DF-EX <*> DFP <-> G25 <-> G27
+		  DF-EX <*--------> G25 <-> G27
+		  DF-EX <*----------------> G27
+
+		DFGT:
+		  DF-EX <*> DFP <-> DFGT
+		  DF-EX <*--------> DFGT
+
+		* hid_logitech module must be loaded with lg4ff_no_autoswitch=3D1
+		  parameter set in order for the switch to DF-EX mode to work.
=20
 What:		/sys/bus/hid/drivers/logitech/<dev>/real_id
 Date:		Feb 2015
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index dd30772..854982b 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -201,26 +201,47 @@ static const struct lg4ff_wheel_ident_checklist l=
g4ff_main_checklist =3D {
 };
=20
 /* Compatibility mode switching commands */
-static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_dfp =3D=
 {
-	1,
-	{0xf8, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00}
+/* EXT_CMD9 - Understood by G27 and DFGT */
+static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_ext09_d=
fex =3D {
+	2,
+	{0xf8, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00,	/* Revert mode upon USB re=
set */
+	 0xf8, 0x09, 0x00, 0x01, 0x00, 0x00, 0x00}	/* Switch mode to DF-EX wi=
th detach */
 };
=20
-static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_dfgt =3D=
 {
+static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_ext09_d=
fp =3D {
 	2,
-	{0xf8, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00,	/* 1st command */
-	 0xf8, 0x09, 0x03, 0x01, 0x00, 0x00, 0x00}	/* 2nd command */
+	{0xf8, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00,	/* Revert mode upon USB re=
set */
+	 0xf8, 0x09, 0x01, 0x01, 0x00, 0x00, 0x00}	/* Switch mode to DFP with=
 detach */
 };
=20
-static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_g25 =3D=
 {
-	1,
-	{0xf8, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00}
+static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_ext09_g=
25 =3D {
+	2,
+	{0xf8, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00,	/* Revert mode upon USB re=
set */
+	 0xf8, 0x09, 0x02, 0x01, 0x00, 0x00, 0x00}	/* Switch mode to G25 with=
 detach */
 };
=20
-static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_g27 =3D=
 {
+static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_ext09_d=
fgt =3D {
 	2,
-	{0xf8, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00,	/* 1st command */
-	 0xf8, 0x09, 0x04, 0x01, 0x00, 0x00, 0x00}	/* 2nd command */
+	{0xf8, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00,	/* Revert mode upon USB re=
set */
+	 0xf8, 0x09, 0x03, 0x01, 0x00, 0x00, 0x00}	/* Switch mode to DFGT wit=
h detach */
+};
+
+static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_ext09_g=
27 =3D {
+	2,
+	{0xf8, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00,	/* Revert mode upon USB re=
set */
+	 0xf8, 0x09, 0x04, 0x01, 0x00, 0x00, 0x00}	/* Switch mode to G27 with=
 detach */
+};
+
+/* EXT_CMD1 - Understood by DFP, G25, G27 and DFGT */
+static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_ext01_d=
fp =3D {
+	1,
+	{0xf8, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00}
+};
+
+/* EXT_CMD16 - Understood by G25 and G27 */
+static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_ext16_g=
25 =3D {
+	1,
+	{0xf8, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00}
 };
=20
 /* Recalculates X axis value accordingly to currently selected range *=
/
@@ -489,6 +510,63 @@ static void hid_lg4ff_set_range_dfp(struct hid_dev=
ice *hid, __u16 range)
 	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
 }
=20
+static const struct lg4ff_compat_mode_switch *lg4ff_get_mode_switch_co=
mmand(const u16 real_product_id, const u16 target_product_id)
+{
+	switch (real_product_id) {
+	case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
+		switch (target_product_id) {
+		case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
+			return &lg4ff_mode_switch_ext01_dfp;
+		/* DFP can only be switched to its native mode */
+		default:
+			return NULL;
+		}
+		break;
+	case USB_DEVICE_ID_LOGITECH_G25_WHEEL:
+		switch (target_product_id) {
+		case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
+			return &lg4ff_mode_switch_ext01_dfp;
+		case USB_DEVICE_ID_LOGITECH_G25_WHEEL:
+			return &lg4ff_mode_switch_ext16_g25;
+		/* G25 can only be switched to DFP mode or its native mode */
+		default:
+			return NULL;
+		}
+		break;
+	case USB_DEVICE_ID_LOGITECH_G27_WHEEL:
+		switch (target_product_id) {
+		case USB_DEVICE_ID_LOGITECH_WHEEL:
+			return &lg4ff_mode_switch_ext09_dfex;
+		case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
+			return &lg4ff_mode_switch_ext09_dfp;
+		case USB_DEVICE_ID_LOGITECH_G25_WHEEL:
+			return &lg4ff_mode_switch_ext09_g25;
+		case USB_DEVICE_ID_LOGITECH_G27_WHEEL:
+			return &lg4ff_mode_switch_ext09_g27;
+		/* G27 can only be switched to DF-EX, DFP, G25 or its native mode */
+		default:
+			return NULL;
+		}
+		break;
+	case USB_DEVICE_ID_LOGITECH_DFGT_WHEEL:
+		switch (target_product_id) {
+		case USB_DEVICE_ID_LOGITECH_WHEEL:
+			return &lg4ff_mode_switch_ext09_dfex;
+		case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
+			return &lg4ff_mode_switch_ext09_dfp;
+		case USB_DEVICE_ID_LOGITECH_DFGT_WHEEL:
+			return &lg4ff_mode_switch_ext09_dfgt;
+		/* DFGT can only be switched to DF-EX, DFP or its native mode */
+		default:
+			return NULL;
+		}
+		break;
+	/* No other wheels have multiple modes */
+	default:
+		return NULL;
+	}
+}
+
 static int lg4ff_switch_compatibility_mode(struct hid_device *hid, con=
st struct lg4ff_compat_mode_switch *s)
 {
 	struct usb_device *usbdev =3D hid_to_usb_dev(hid);
@@ -558,7 +636,87 @@ static ssize_t lg4ff_alternate_modes_show(struct d=
evice *dev, struct device_attr
=20
 static ssize_t lg4ff_alternate_modes_store(struct device *dev, struct =
device_attribute *attr, const char *buf, size_t count)
 {
-	return -ENOSYS;
+	struct hid_device *hid =3D to_hid_device(dev);
+	struct lg4ff_device_entry *entry;
+	struct lg_drv_data *drv_data;
+	const struct lg4ff_compat_mode_switch *s;
+	u16 target_product_id =3D 0;
+	int i, ret;
+	char *lbuf;
+
+	drv_data =3D hid_get_drvdata(hid);
+	if (!drv_data) {
+		hid_err(hid, "Private driver data not found!\n");
+		return -EINVAL;
+	}
+
+	entry =3D drv_data->device_props;
+	if (!entry) {
+		hid_err(hid, "Device properties not found!\n");
+		return -EINVAL;
+	}
+
+	/* Allow \n at the end of the input parameter */
+	lbuf =3D kasprintf(GFP_KERNEL, "%s", buf);
+	if (!lbuf)
+		return -ENOMEM;
+
+	i =3D strlen(lbuf);
+	if (lbuf[i-1] =3D=3D '\n') {
+		if (i =3D=3D 1) {
+			kfree(lbuf);
+			return -EINVAL;
+		}
+		lbuf[i-1] =3D '\0';
+	}
+
+	for (i =3D 0; i < LG4FF_MODE_MAX_IDX; i++) {
+		const u16 mode_product_id =3D lg4ff_alternate_modes[i].product_id;
+		const char *tag =3D lg4ff_alternate_modes[i].tag;
+
+		if (entry->alternate_modes & BIT(i)) {
+			if (!strcmp(tag, lbuf)) {
+				if (!mode_product_id)
+					target_product_id =3D entry->real_product_id;
+				else
+					target_product_id =3D mode_product_id;
+				break;
+			}
+		}
+	}
+
+	if (i =3D=3D LG4FF_MODE_MAX_IDX) {
+		hid_info(hid, "Requested mode \"%s\" is not supported by the device\=
n", lbuf);
+		kfree(lbuf);
+		return -EINVAL;
+	}
+	kfree(lbuf); /* Not needed anymore */
+
+	if (target_product_id =3D=3D entry->product_id) /* Nothing to do */
+		return count;
+
+	/* Automatic switching has to be disabled for the switch to DF-EX mod=
e to work correctly */
+	if (target_product_id =3D=3D USB_DEVICE_ID_LOGITECH_WHEEL && !lg4ff_n=
o_autoswitch) {
+		hid_info(hid, "\"%s\" cannot be switched to \"DF-EX\" mode. Load the=
 \"hid_logitech\" module with \"lg4ff_no_autoswitch=3D1\" parameter set=
 and try again\n",
+			 entry->real_name);
+		return -EINVAL;
+	}
+
+	/* Take care of hardware limitations */
+	if ((entry->real_product_id =3D=3D USB_DEVICE_ID_LOGITECH_DFP_WHEEL |=
| entry->real_product_id =3D=3D USB_DEVICE_ID_LOGITECH_G25_WHEEL) &&
+	    entry->product_id > target_product_id) {
+		hid_info(hid, "\"%s\" cannot be switched back into \"%s\" mode\n", e=
ntry->real_name, lg4ff_alternate_modes[i].name);
+		return -EINVAL;
+	}
+
+	s =3D lg4ff_get_mode_switch_command(entry->real_product_id, target_pr=
oduct_id);
+	if (!s) {
+		hid_err(hid, "Invalid target product ID %X\n", target_product_id);
+		return -EINVAL;
+	}
+
+	ret =3D lg4ff_switch_compatibility_mode(hid, s);
+	return (ret =3D=3D 0 ? count : ret);
 }
 static DEVICE_ATTR(alternate_modes, S_IRUSR | S_IWUSR | S_IRGRP | S_IW=
GRP | S_IROTH, lg4ff_alternate_modes_show, lg4ff_alternate_modes_store)=
;
=20
@@ -783,7 +941,8 @@ static u16 lg4ff_identify_multimode_wheel(struct hi=
d_device *hid, const u16 repo
 		}
 	}
=20
-	/* No match found. This is an unknown wheel model, do not touch it */
+	/* No match found. This is either Driving Force or an unknown
+	 * wheel model, do not touch it */
 	dbg_hid("Wheel with bcdDevice %X was not recognized as multimode whee=
l, leaving in its current mode\n", bcdDevice);
 	return 0;
 }
@@ -806,22 +965,9 @@ static int lg4ff_handle_multimode_wheel(struct hid=
_device *hid, u16 *real_produc
 	if (reported_product_id =3D=3D USB_DEVICE_ID_LOGITECH_WHEEL &&
 	    reported_product_id !=3D *real_product_id &&
 	    !lg4ff_no_autoswitch) {
-		const struct lg4ff_compat_mode_switch *s;
+		const struct lg4ff_compat_mode_switch *s =3D lg4ff_get_mode_switch_c=
ommand(*real_product_id, *real_product_id);
=20
-		switch (*real_product_id) {
-		case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
-			s =3D &lg4ff_mode_switch_dfp;
-			break;
-		case USB_DEVICE_ID_LOGITECH_G25_WHEEL:
-			s =3D &lg4ff_mode_switch_g25;
-			break;
-		case USB_DEVICE_ID_LOGITECH_G27_WHEEL:
-			s =3D &lg4ff_mode_switch_g27;
-			break;
-		case USB_DEVICE_ID_LOGITECH_DFGT_WHEEL:
-			s =3D &lg4ff_mode_switch_dfgt;
-			break;
-		default:
+		if (!s) {
 			hid_err(hid, "Invalid product id %X\n", *real_product_id);
 			return LG4FF_MMODE_NOT_MULTIMODE;
 		}
--=20
2.3.0
