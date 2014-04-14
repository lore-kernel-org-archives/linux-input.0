From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: [PATCH 4/4] HID: (thingm) add support for blink(1) mk2
Date: Mon, 14 Apr 2014 16:50:20 -0400
Message-ID: <1397508620-15244-5-git-send-email-vivien.didelot@savoirfairelinux.com>
References: <1397508620-15244-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1397508620-15244-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Sender: linux-leds-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, Jiri Kosina <jkosina@suse.cz>, linux-leds@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com
List-Id: linux-input@vger.kernel.org

The blink(1) mk2 is a new version of the blink(1) USB RGB LED. The new
generation has 2 individually-controllable RGB chips.

This patch adds support for this device to the thingm driver, which
registers 3 new standard LED class instances for the second RGB chip.

Note that the 'n' (set) command does not support setting a color for a
single RGB chip, so it was changed to 'c' (fade) with a timeout of 0.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/hid/hid-thingm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
index 0af0eb4..31de890 100644
--- a/drivers/hid/hid-thingm.c
+++ b/drivers/hid/hid-thingm.c
@@ -23,6 +23,7 @@
 
 /* Firmware major number of supported devices */
 #define THINGM_MAJOR_MK1	'1'
+#define THINGM_MAJOR_MK2	'2'
 
 struct thingm_fwinfo {
 	char major;
@@ -35,6 +36,10 @@ const struct thingm_fwinfo thingm_fwinfo[] = {
 		.major = THINGM_MAJOR_MK1,
 		.numrgb = 1,
 		.first = 0,
+	}, {
+		.major = THINGM_MAJOR_MK2,
+		.numrgb = 2,
+		.first = 1,
 	}
 };
 
@@ -117,7 +122,7 @@ static int thingm_version(struct thingm_device *tdev)
 
 static int thingm_write_color(struct thingm_rgb *rgb)
 {
-	u8 buf[REPORT_SIZE] = { REPORT_ID, 'n', 0, 0, 0, 0, 0, 0, 0 };
+	u8 buf[REPORT_SIZE] = { REPORT_ID, 'c', 0, 0, 0, 0, 0, rgb->num, 0 };
 
 	buf[2] = rgb->red.ldev.brightness;
 	buf[3] = rgb->green.ldev.brightness;
-- 
1.9.1
