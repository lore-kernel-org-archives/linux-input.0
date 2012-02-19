From: Przemo Firszt <przemo@firszt.eu>
Subject: [PATCH] HID: wacom: fix proximity tool release
Date: Sun, 19 Feb 2012 20:20:29 +0000
Message-ID: <1329682829-24347-1-git-send-email-przemo@firszt.eu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: aris@redhat.com, jkosina@suse.cz
Cc: pinglinux@gmail.com, linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Przemo Firszt <przemo@firszt.eu>
List-Id: linux-input@vger.kernel.org

Don't zero the current tool before reporting its release to the input
subsystem.

Signed-off-by: Aristeu Rozanski <aris@redhat.com>
Tested-by: Przemo Firszt <przemo@firszt.eu>
---
 drivers/hid/hid-wacom.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 0621047..696b907 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -322,10 +322,10 @@ static void wacom_i4_parse_pen_report(struct wacom_data *wdata,
 
 	switch (data[1]) {
 	case 0x80: /* Out of proximity report */
-		wdata->tool = 0;
 		input_report_key(input, BTN_TOUCH, 0);
 		input_report_abs(input, ABS_PRESSURE, 0);
 		input_report_key(input, wdata->tool, 0);
+		wdata->tool = 0;
 		input_sync(input);
 		break;
 	case 0xC2: /* Tool report */
-- 
1.7.6.4
