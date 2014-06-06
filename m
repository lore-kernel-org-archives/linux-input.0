From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] elantech: Deal with clickpads reporting right button events
Date: Fri,  6 Jun 2014 16:08:15 +0200
Message-ID: <1402063695-20196-1-git-send-email-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Elder Marco <eldermarco@gmail.com>, linux-input@vger.kernel.org, stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-input@vger.kernel.org

At least the Dell Vostro 5470 elantech *clickpad* reports right button
clicks when clicked in the right bottom area:

https://bugzilla.redhat.com/show_bug.cgi?id=1103528

This is different from how (elantech) clickpads normally operate,
normally no matter where the user clicks on the pad the pad always reports
a left button event, since there is only 1 hardware button beneath the path.

It looks like Dell has put 2 buttons under the pad, one under each bottom
corner, causing this.

Since this however still clearly is a real clickpad hardware-wise, we still
want to report it as such to userspace, so that things like finger movement
in the bottom area can be properly ignored as it should be on clickpads.

So deal with this weirdness by simply mapping a right click to a left click
on elantech clickpads. As an added advantage this is something which we can
simply do on all elantech clickpads, so no need to add special quirks for
this weird model.

Reported-and-tested-by: Elder Marco <eldermarco@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/elantech.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 4d79821..846926d 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -473,8 +473,15 @@ static void elantech_report_absolute_v3(struct psmouse *psmouse,
 	input_report_key(dev, BTN_TOOL_FINGER, fingers == 1);
 	input_report_key(dev, BTN_TOOL_DOUBLETAP, fingers == 2);
 	input_report_key(dev, BTN_TOOL_TRIPLETAP, fingers == 3);
-	input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
-	input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
+
+	/* For clickpads map both buttons to BTN_LEFT */
+	if (etd->fw_version & 0x001000) {
+		input_report_key(dev, BTN_LEFT, packet[0] & 0x03);
+	} else {
+		input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
+		input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
+	}
+
 	input_report_abs(dev, ABS_PRESSURE, pres);
 	input_report_abs(dev, ABS_TOOL_WIDTH, width);
 
@@ -484,10 +491,17 @@ static void elantech_report_absolute_v3(struct psmouse *psmouse,
 static void elantech_input_sync_v4(struct psmouse *psmouse)
 {
 	struct input_dev *dev = psmouse->dev;
+	struct elantech_data *etd = psmouse->private;
 	unsigned char *packet = psmouse->packet;
 
-	input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
-	input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
+	/* For clickpads map both buttons to BTN_LEFT */
+	if (etd->fw_version & 0x001000) {
+		input_report_key(dev, BTN_LEFT, packet[0] & 0x03);
+	} else {
+		input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
+		input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
+	}
+
 	input_mt_report_pointer_emulation(dev, true);
 	input_sync(dev);
 }
-- 
2.0.0
