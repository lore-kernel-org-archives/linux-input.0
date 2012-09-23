From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: [PATCH 3/4] HID: hid-lg4ff: Set absolute axes parametes on DFP
Date: Mon, 24 Sep 2012 01:10:53 +0200
Message-ID: <2440225.unlQaQNVo7@qosmio-x300>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:53579 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601Ab2IWXK4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Sep 2012 19:10:56 -0400
Received: by wibhq12 with SMTP id hq12so1136219wib.1
        for <linux-input@vger.kernel.org>; Sun, 23 Sep 2012 16:10:55 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, simon@mungewell.org

The lg4ff driver doesn't fill the "input_absinfo" struct so it is left
with default values. Applications with rely on information in this stru=
ct
therefore do not work correctly with the wheel.

Other Logitech wheels probably need this fix too, but again I do not ha=
ve
enough information to write it.

Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>
---
=46rom e7fdafab7b67ae62e46f4323cbca646cd46a7266 Mon Sep 17 00:00:00 200=
1
=46rom: =3D?UTF-8?q?Michal=3D20Mal=3DC3=3DBD?=3D <madcatxster@gmail.com=
>
Date: Sun, 23 Sep 2012 23:56:39 +0200
Subject: [PATCH 3/4] Set absolute axes parameters manually on DFP.

---
 drivers/hid/hid-lg4ff.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index fe15b3b..7007a12 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -43,6 +43,11 @@
 #define G27_REV_MAJ 0x12
 #define G27_REV_MIN 0x38
=20
+#define DFP_X_MIN 0
+#define DFP_X_MAX 16383
+#define DFP_PEDAL_MIN 0
+#define DFP_PEDAL_MAX 255
+
 #define to_hid_device(pdev) container_of(pdev, struct hid_device, dev)
=20
 static void hid_lg4ff_set_range_dfp(struct hid_device *hid, u16 range)=
;
@@ -593,6 +598,18 @@ int lg4ff_init(struct hid_device *hid)
 		return error;
 	dbg_hid("sysfs interface created\n");
=20
+	/* Set default axes parameters */
+	switch (lg4ff_devices[i].product_id) {
+	case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
+		dbg_hid("Setting axes parameters for Driving Force Pro\n");
+		input_set_abs_params(dev, ABS_X, DFP_X_MIN, DFP_X_MAX, 0, 0);
+		input_set_abs_params(dev, ABS_Y, DFP_PEDAL_MIN, DFP_PEDAL_MAX, 0, 0)=
;
+		input_set_abs_params(dev, ABS_RZ, DFP_PEDAL_MIN, DFP_PEDAL_MAX, 0, 0=
);
+		break;
+	default:
+		break; /* Should never happen */
+	}
+
 	/* Set the maximum range to start with */
 	entry->range =3D entry->max_range;
 	if (entry->set_range !=3D NULL)
--=20
1.7.12.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
