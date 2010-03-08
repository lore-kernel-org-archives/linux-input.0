From: mickib1@gmail.com
Subject: [PATCH 5/7] HID: N-trig MTM Driver fix And cleanup patch 5
Date: Mon,  8 Mar 2010 23:13:45 +0200
Message-ID: <1268082827-2680-5-git-send-email-micki@n-trig.com>
References: <1268082827-2680-1-git-send-email-micki@n-trig.com>
 <1268082827-2680-2-git-send-email-micki@n-trig.com>
 <1268082827-2680-3-git-send-email-micki@n-trig.com>
 <1268082827-2680-4-git-send-email-micki@n-trig.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:62249 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755537Ab0CHVOJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Mar 2010 16:14:09 -0500
In-Reply-To: <1268082827-2680-4-git-send-email-micki@n-trig.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, rafi@seas.upenn.edu, chatty@enac.fr, peterhuewe@gmx.de, micki@n-trig.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

=46rom: micki <micki@micki-laptop.(none)>

udpate ntrig_probe - add call to ntrig_send_report function
to initialize firmware to switch to Multi-touch mode.
Delete input-name our driver don't distinguish pen and touch.
Will be inserted in next version.

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
 drivers/hid/hid-ntrig.c |   41 ++++++---------------------------------=
--
 1 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 8cdb3c2..8bf796c 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -19,6 +19,8 @@
  *	1.3 - N-trig - Change ntrig_input_mapped
  *	1.4 - N-trig - Add ntrig_send_report function
  *		send set feature command to firmware
+ *	1.5 - N-trig udpate ntrig_probe
+ *		add call to ntrig_send_report function
  */
=20
 /*
@@ -415,11 +417,6 @@ static int ntrig_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
 {
 	int ret;
 	struct ntrig_data *nd;
-	struct hid_input *hidinput;
-	struct input_dev *input;
-
-	if (id->driver_data)
-		hdev->quirks |=3D HID_QUIRK_MULTI_INPUT;
=20
 	nd =3D kmalloc(sizeof(struct ntrig_data), GFP_KERNEL);
 	if (!nd) {
@@ -427,7 +424,6 @@ static int ntrig_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
 		return -ENOMEM;
 	}
=20
-	nd->reading_mt =3D 0;
 	hid_set_drvdata(hdev, nd);
=20
 	ret =3D hid_parse(hdev);
@@ -442,35 +438,10 @@ static int ntrig_probe(struct hid_device *hdev, c=
onst struct hid_device_id *id)
 		goto err_free;
 	}
=20
-
-	list_for_each_entry(hidinput, &hdev->inputs, list) {
-		input =3D hidinput->input;
-		switch (hidinput->report->field[0]->application) {
-		case HID_DG_PEN:
-			input->name =3D "N-Trig Pen";
-			break;
-		case HID_DG_TOUCHSCREEN:
-			__clear_bit(BTN_TOOL_PEN, input->keybit);
-			/*
-			 * A little something special to enable
-			 * two and three finger taps.
-			 */
-			__set_bit(BTN_TOOL_DOUBLETAP, input->keybit);
-			__set_bit(BTN_TOOL_TRIPLETAP, input->keybit);
-			__set_bit(BTN_TOOL_QUADTAP, input->keybit);
-			/*
-			 * The physical touchscreen (single touch)
-			 * input has a value for physical, whereas
-			 * the multitouch only has logical input
-			 * fields.
-			 */
-			input->name =3D
-				(hidinput->report->field[0]
-				 ->physical) ?
-				"N-Trig Touchscreen" :
-				"N-Trig MultiTouch";
-			break;
-		}
+	ret =3D ntrig_send_report(hdev);
+	if (ret) {
+		dev_err(&hdev->dev, "send set feature failed\n");
+		goto err_free;
 	}
=20
 	return 0;
--=20
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
