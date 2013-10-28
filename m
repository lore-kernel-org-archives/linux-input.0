From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] HID: wiimote: fix inverted pro-controller axes
Date: Mon, 28 Oct 2013 17:47:53 +0100
Message-ID: <1382978873-802-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Rafael Brune <mail@rbrune.de>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The analog-stick vertical axes are inverted. Fix that! Otherwise, games
and other gamepad applications need to carry their own fixups (which they
thankfully haven't done, yet).

Cc: <stable@vger.kernel.org> # 3.11+
Reported-by: Rafael Brune <mail@rbrune.de>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-modules.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 71adf9e..e30567a 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -1656,9 +1656,9 @@ static void wiimod_pro_in_ext(struct wiimote_data *wdata, const __u8 *ext)
 	ry = (ext[6] & 0xff) | ((ext[7] & 0x0f) << 8);
 
 	input_report_abs(wdata->extension.input, ABS_X, lx - 0x800);
-	input_report_abs(wdata->extension.input, ABS_Y, ly - 0x800);
+	input_report_abs(wdata->extension.input, ABS_Y, 0x800 - ly);
 	input_report_abs(wdata->extension.input, ABS_RX, rx - 0x800);
-	input_report_abs(wdata->extension.input, ABS_RY, ry - 0x800);
+	input_report_abs(wdata->extension.input, ABS_RY, 0x800 - ry);
 
 	input_report_key(wdata->extension.input,
 			 wiimod_pro_map[WIIMOD_PRO_KEY_RIGHT],
-- 
1.8.4.1
