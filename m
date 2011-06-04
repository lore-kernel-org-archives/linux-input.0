From: Simon Wood <simon@mungewell.org>
Subject: [PATCHv4 3/3] sony_ff_bluetooth
Date: Sat,  4 Jun 2011 02:32:37 -0700
Message-ID: <1307179957-24458-3-git-send-email-simon@mungewell.org>
References: <1307179957-24458-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1307179957-24458-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Michael Bauer <michael@m-bauer.org>, Marcin Tolysz <tolysz@gmail.com>, Simon Wood <simon@mungewell.org>, Antonio Ospite <ospite@studenti.unina.it>
List-Id: linux-input@vger.kernel.org

Add support for patching the HID descriptor when Sixaxis is connect
via Bluetooth. In this mode the desciptor contains a trailing '0x00'.

Patch suggested by Antonio

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-sony.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index f219746..5d37f97 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -49,8 +49,11 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		hid_info(hdev, "Fixing up Sony Vaio VGX report descriptor\n");
 		rdesc[55] = 0x06;
 	}
-	if ((sc->quirks & SIXAXIS_CONTROLLER_USB) &&
-			*rsize == 148 && rdesc[83] == 0x75) {
+
+	/* The HID descriptor exposed over BT has a trailing zero byte */
+	if ((((sc->quirks & SIXAXIS_CONTROLLER_USB) && *rsize == 148) ||
+			((sc->quirks & SIXAXIS_CONTROLLER_BT)  && *rsize == 149 )) &&
+			rdesc[83] == 0x75) {
 		hid_info(hdev, "Fixing up Sony Sixaxis report descriptor\n");
 		memcpy((void *)&rdesc[83], (void *) &sixaxis_rdesc_fixup, sizeof(sixaxis_rdesc_fixup));
 	}
@@ -64,7 +67,7 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report, __
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
-	if ((sc->quirks & SIXAXIS_CONTROLLER_USB) &&
+	if ((sc->quirks & (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)) &&
 			rd[0] == 0x01 && size == 49) {
 		swap(rd[41], rd[42]);
 		swap(rd[43], rd[44]);
-- 
1.7.4.1
