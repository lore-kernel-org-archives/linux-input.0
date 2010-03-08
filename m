From: mickib1@gmail.com
Subject: [PATCH 3/7] HID: N-trig MTM Driver fix And cleanup patch 3
Date: Mon,  8 Mar 2010 23:13:43 +0200
Message-ID: <1268082827-2680-3-git-send-email-micki@n-trig.com>
References: <1268082827-2680-1-git-send-email-micki@n-trig.com>
 <1268082827-2680-2-git-send-email-micki@n-trig.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1268082827-2680-2-git-send-email-micki@n-trig.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz, rafi@seas.upenn.edu, chatty@enac.fr, peterhuewe@gmx.de, micki@n-trig.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

=46rom: micki <micki@micki-laptop.(none)>

Change ntrig_input_mapped function to support EV_MSC events.
Support pen button left/right

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
 drivers/hid/hid-ntrig.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 3602cd0..8130c3c 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -16,6 +16,7 @@
  *	1.1 - N-trig - Add Change Log and defines of MTM firmware.
  *		Add debug Paramater change Driver name in hid_driver structure
  *	1.2 - N-trig - Change ntrig_input_mapping
+ *	1.3 - N-trig - Change ntrig_input_mapped
  */
=20
 /*
@@ -182,14 +183,23 @@ static int ntrig_input_mapped(struct hid_device *=
hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	/* No special mappings needed for the pen and single touch */
-	if (field->physical)
-		return 0;
-
-	if (usage->type =3D=3D EV_KEY || usage->type =3D=3D EV_REL
-			|| usage->type =3D=3D EV_ABS)
-		clear_bit(usage->code, *bit);
-
+       /*
+	* Maps Key For Pen And Touch events
+	* MSC events used to transfer information about finger status
+	* In cureent Frame
+	* todo: Maybe later transfer to mt proctol
+	* if there will be relevant events
+	*/
+	struct input_dev *input =3D hi->input;
+	set_bit(BTN_LEFT, input->keybit);
+	set_bit(BTN_RIGHT, input->keybit);
+	set_bit(EV_MSC, input->evbit);
+	set_bit(MSC_PULSELED, input->mscbit);
+	set_bit(MSC_SERIAL, input->mscbit);
+	set_bit(MSC_SCAN, input->mscbit);
+
+	input_set_abs_params(hi->input, ABS_PRESSURE,
+			0/*Min*/, 255 /*Max*/, 0, 0);
 	return 0;
 }
=20
--=20
1.6.3.3
