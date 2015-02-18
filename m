From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH] HID: hid-lg4ff: Fix "undefined reference" build issue with CONFIG_USB disabled.
Date: Wed, 18 Feb 2015 22:49:33 +0100
Message-ID: <1424296173-22718-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
List-Id: linux-input@vger.kernel.org

=46ix "undefined reference" build issue with CONFIG_USB disabled.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/hid-lg4ff.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 854982b..1232210 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -569,19 +569,20 @@ static const struct lg4ff_compat_mode_switch *lg4=
ff_get_mode_switch_command(cons
=20
 static int lg4ff_switch_compatibility_mode(struct hid_device *hid, con=
st struct lg4ff_compat_mode_switch *s)
 {
-	struct usb_device *usbdev =3D hid_to_usb_dev(hid);
-	struct usbhid_device *usbhid =3D hid->driver_data;
+	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
+	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
+	__s32 *value =3D report->field[0]->value;
 	u8 i;
=20
 	for (i =3D 0; i < s->cmd_count; i++) {
-		int xferd, ret;
-		u8 data[7];
+		u8 j;
=20
-		memcpy(data, s->cmd + (7*i), 7);
-		ret =3D usb_interrupt_msg(usbdev, usbhid->urbout->pipe, data, 7, &xf=
erd, USB_CTRL_SET_TIMEOUT);
-		if (ret)
-			return ret;
+		for (j =3D 0; j < 7; j++)
+			value[j] =3D s->cmd[j + (7*i)];
+
+		hid_hw_request(hid, report, HID_REQ_SET_REPORT);
 	}
+	hid_hw_wait(hid);
 	return 0;
 }
=20
--=20
2.3.0
