From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH v5 2/2] hid-sony: fix endiannes of Sixaxis accel/gyro values
Date: Fri, 10 Jun 2011 12:00:27 +0200
Message-ID: <1307700027-10657-2-git-send-email-ospite@studenti.unina.it>
References: <1b0af21baa09ca623bbe62ee253f5d36.squirrel@host171.canaca.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:43612 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941Ab1FJKAe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jun 2011 06:00:34 -0400
In-Reply-To: <1b0af21baa09ca623bbe62ee253f5d36.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Simon Wood <simon@mungewell.org>, Jiri Kosina <jkosina@suse.cz>, Marcin Tolysz <tolysz@gmail.com>, Michael Bauer <michael@m-bauer.org>, Antonio Ospite <ospite@studenti.unina.it>

From: Simon Wood <simon@mungewell.org>

The accelerometers/gyro on the Sixaxis are reported in the wrong
endianness (ie. not compatible with HID), so this patch intercepts
the report and swaps the appropriate bytes over.

Accelerometers are scaled with a nominal value of +/-4000 = 1G,
maximum value would be around +/-32768 = 8G.

Gyro on my device always reports -32768, might need some calibration
set within the controller.

Fix extracted from previous patch submission:
https://patchwork.kernel.org/patch/95212/

Signed-off-by: Marcin Tolysz <tolysz@gmail.com>
Signed-off-by: Simon Wood <simon@mungewell.org>
Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

Changes since v4:
 - Adjusted the short commit message
 - Wrapped the sony_raw_event() definition to stay in 80 chars

The patch has been tested and it is checkpatch.pl clean.

Thanks,
   Antonio

 drivers/hid/hid-sony.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 60b4257..5d8a200 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -61,6 +61,25 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	return rdesc;
 }
 
+static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
+		__u8 *rd, int size)
+{
+	struct sony_sc *sc = hid_get_drvdata(hdev);
+
+	/* Sixaxis HID report has acclerometers/gyro with MSByte first, this
+	 * has to be BYTE_SWAPPED before passing up to joystick interface
+	 */
+	if ((sc->quirks & (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)) &&
+			rd[0] == 0x01 && size == 49) {
+		swap(rd[41], rd[42]);
+		swap(rd[43], rd[44]);
+		swap(rd[45], rd[46]);
+		swap(rd[47], rd[48]);
+	}
+
+	return 0;
+}
+
 /*
  * The Sony Sixaxis does not handle HID Output Reports on the Interrupt EP
  * like it should according to usbhid/hid-core.c::usbhid_output_raw_report()
@@ -190,6 +209,7 @@ static struct hid_driver sony_driver = {
 	.probe = sony_probe,
 	.remove = sony_remove,
 	.report_fixup = sony_report_fixup,
+	.raw_event = sony_raw_event
 };
 
 static int __init sony_init(void)
-- 
1.7.5.3

