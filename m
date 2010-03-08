From: mickib1@gmail.com
Subject: [PATCH 6/7] HID: N-trig MTM Driver fix And cleanup patch 6
Date: Mon,  8 Mar 2010 23:13:46 +0200
Message-ID: <1268082827-2680-6-git-send-email-micki@n-trig.com>
References: <1268082827-2680-1-git-send-email-micki@n-trig.com>
 <1268082827-2680-2-git-send-email-micki@n-trig.com>
 <1268082827-2680-3-git-send-email-micki@n-trig.com>
 <1268082827-2680-4-git-send-email-micki@n-trig.com>
 <1268082827-2680-5-git-send-email-micki@n-trig.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:34719 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755941Ab0CHVOM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Mar 2010 16:14:12 -0500
In-Reply-To: <1268082827-2680-5-git-send-email-micki@n-trig.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, rafi@seas.upenn.edu, chatty@enac.fr, peterhuewe@gmx.de, micki@n-trig.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

=46rom: micki <micki@micki-laptop.(none)>

Update struct hid_driver ntrig_driver. add debug module parameters

N-trig is changing the way people interact with computers by providing =
a dual-mode pen and true multi-touch input device, specifically designe=
d for today's advanced computing world.
N-trig DuoSense=C2=AE solution provides a real Hands-on computing=C2=AE=
 experience, and sets the stage for OEMs and ISVs to introduce innovati=
ve computer products and applications for an intuitive, Hands-on=C2=AE =
experience directly onscreen.
DuoSense digitizers are easily integrated into existing technologies, s=
upport all LCDs, keep devices slim and light, and can be implemented in=
 a broad range of products, ranging from small notebooks to large LCDs.
N-trig has offices in Israel, the US, Taiwan and Japan.

Signed-off-by: Micki Balanga <micki@n-trig.com>
---
 drivers/hid/hid-ntrig.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 8bf796c..f88533e 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -21,6 +21,9 @@
  *		send set feature command to firmware
  *	1.5 - N-trig udpate ntrig_probe
  *		add call to ntrig_send_report function
+ *	1.6 - N-trig Update ntrig_init print version number
+ *		update struct hid_driver
+ *		update struct hid_device_id
  */
=20
 /*
@@ -458,15 +461,11 @@ static void ntrig_remove(struct hid_device *hdev)
=20
 static const struct hid_device_id ntrig_devices[] =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREE=
N),
-		.driver_data =3D NTRIG_DUPLICATE_USAGES },
+		.driver_data =3D NTRIG_USB_DEVICE_ID },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, ntrig_devices);
=20
-static const struct hid_usage_id ntrig_grabbed_usages[] =3D {
-	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
-	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1 }
-};
=20
 static struct hid_driver ntrig_driver =3D {
 	.name =3D MODULE_NAME,
@@ -475,12 +474,12 @@ static struct hid_driver ntrig_driver =3D {
 	.remove =3D ntrig_remove,
 	.input_mapping =3D ntrig_input_mapping,
 	.input_mapped =3D ntrig_input_mapped,
-	.usage_table =3D ntrig_grabbed_usages,
 	.event =3D ntrig_event,
 };
=20
 static int __init ntrig_init(void)
 {
+	info("N-trig Driver Version 1.6\n");
 	return hid_register_driver(&ntrig_driver);
 }
=20
--=20
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
