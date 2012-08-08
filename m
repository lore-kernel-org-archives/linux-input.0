From: Scott Liu <scott.liu@emc.com.tw>
Subject: [PATCH] hid:hid-multitouch:  add mt_resume for ELAN's production
Date: Wed,  8 Aug 2012 09:40:33 +0800
Message-ID: <1344390033-14139-1-git-send-email-scott.liu@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:63697 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab2HHBjc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Aug 2012 21:39:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "benjamin.tissoires" <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, eleghost@gmail.com
Cc: Scott Liu <scott.liu@emc.com.tw>

Some of ELAN=E2=80=99s production need to issue set_idle when resume.

Signed-off-by: Scott Liu <scott.liu@emc.com.tw>
---
 drivers/hid/hid-ids.h        |    3 +++
 drivers/hid/hid-multitouch.c |   26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 41c34f2..703aaed 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -829,4 +829,7 @@
 #define USB_VENDOR_ID_PRIMAX	0x0461
 #define USB_DEVICE_ID_PRIMAX_KEYBOARD	0x4e05
=20
+#define USB_VENDOR_ID_ELAN	0x04f3
+#define USB_DEVICE_ID_ELAN_MOCCA	0x000a
+
 #endif
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.=
c
index 59c8b5c..a086a16 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -767,6 +767,31 @@ static int mt_reset_resume(struct hid_device *hdev=
)
 	mt_set_input_mode(hdev);
 	return 0;
 }
+
+static int mt_resume(struct hid_device *hdev)
+{
+	struct usb_interface *intf =3D to_usb_interface(hdev->dev.parent);
+	struct usb_host_interface *interface =3D intf->cur_altsetting;
+
+	struct usb_device *dev =3D hid_to_usb_dev(hdev);
+
+	if (hdev->vendor =3D=3D USB_VENDOR_ID_ELAN &&=20
+			hdev->product =3D=3D USB_DEVICE_ID_ELAN_MOCCA) {
+
+		usb_control_msg(dev,=20
+						usb_sndctrlpipe(dev, 0),					=09
+		                HID_REQ_SET_IDLE,=20
+						USB_TYPE_CLASS | USB_RECIP_INTERFACE,=20
+						0,
+		                interface->desc.bInterfaceNumber,=20
+						NULL,=20
+						0,=20
+						USB_CTRL_SET_TIMEOUT);
+	}
+
+	return 0;
+}
+
 #endif
=20
 static void mt_remove(struct hid_device *hdev)
@@ -1092,6 +1117,7 @@ static struct hid_driver mt_driver =3D {
 	.event =3D mt_event,
 #ifdef CONFIG_PM
 	.reset_resume =3D mt_reset_resume,
+	.resume=3Dmt_resume,
 #endif
 };
=20
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
