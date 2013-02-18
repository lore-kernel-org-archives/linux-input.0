From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] HID: wiimote: fix nunchuck button parser
Date: Mon, 18 Feb 2013 01:47:15 +0100
Message-ID: <1361148435-25567-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Victor Quicksilver <victor.quicksilver@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The buttons of the Wii Remote Nunchuck extension are actually active low.
Fix the parser to forward the inverted values. The comment in the function
always said "0 == pressed" but the implementation was wrong from the
beginning.

Cc: stable@vger.kernel.org
Reported-by: Victor Quicksilver <victor.quicksilver@gmail.com>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-ext.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-wiimote-ext.c b/drivers/hid/hid-wiimote-ext.c
index 38ae877..0472191 100644
--- a/drivers/hid/hid-wiimote-ext.c
+++ b/drivers/hid/hid-wiimote-ext.c
@@ -403,14 +403,14 @@ static void handler_nunchuck(struct wiimote_ext *ext, const __u8 *payload)
 
 	if (ext->motionp) {
 		input_report_key(ext->input,
-			wiiext_keymap[WIIEXT_KEY_Z], !!(payload[5] & 0x04));
+			wiiext_keymap[WIIEXT_KEY_Z], !(payload[5] & 0x04));
 		input_report_key(ext->input,
-			wiiext_keymap[WIIEXT_KEY_C], !!(payload[5] & 0x08));
+			wiiext_keymap[WIIEXT_KEY_C], !(payload[5] & 0x08));
 	} else {
 		input_report_key(ext->input,
-			wiiext_keymap[WIIEXT_KEY_Z], !!(payload[5] & 0x01));
+			wiiext_keymap[WIIEXT_KEY_Z], !(payload[5] & 0x01));
 		input_report_key(ext->input,
-			wiiext_keymap[WIIEXT_KEY_C], !!(payload[5] & 0x02));
+			wiiext_keymap[WIIEXT_KEY_C], !(payload[5] & 0x02));
 	}
 
 	input_sync(ext->input);
-- 
1.8.1.3
