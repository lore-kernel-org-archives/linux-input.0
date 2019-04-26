From: "Gerecke, Jason" <killertofu@gmail.com>
Subject: [PATCH 1/2] HID: wacom: Don't set tool type until we're in range
Date: Fri, 26 Apr 2019 09:34:08 -0700
Message-ID: <20190426163408.9676-1-jason.gerecke@wacom.com>
References: <20190426033328.GB17719@sasha-vm>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190426033328.GB17719@sasha-vm>
Sender: stable-owner@vger.kernel.org
To: "# v3.17+" <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Armstrong Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Aaron Armstrong Skomra <aaron.skomra@wacom.com>
List-Id: linux-input@vger.kernel.org

From: Jason Gerecke <jason.gerecke@wacom.com>

The serial number and tool type information that is reported by the tablet
while a pen is merely "in prox" instead of fully "in range" can be stale
and cause us to report incorrect tool information. Serial number, tool
type, and other information is only valid once the pen comes fully in range
so we should be careful to not use this information until that point.

In particular, this issue may cause the driver to incorectly report
BTN_TOOL_RUBBER after switching from the eraser tool back to the pen.

Fixes: a48324de6d ("HID: wacom: Bluetooth IRQ for Intuos Pro should handle prox/range")
Cc: <stable@vger.kernel.org> # 4.11+
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
---
Version of patch specifically targeted to stable v4.14.113

 drivers/hid/wacom_wac.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 4c72e68637c2..03b04bc742dd 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1225,13 +1225,13 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 		/* Add back in missing bits of ID for non-USI pens */
 		wacom->id[0] |= (wacom->serial[0] >> 32) & 0xFFFFF;
 	}
-	wacom->tool[0]   = wacom_intuos_get_tool_type(wacom_intuos_id_mangle(wacom->id[0]));
 
 	for (i = 0; i < pen_frames; i++) {
 		unsigned char *frame = &data[i*pen_frame_len + 1];
 		bool valid = frame[0] & 0x80;
 		bool prox = frame[0] & 0x40;
 		bool range = frame[0] & 0x20;
+		bool invert = frame[0] & 0x10;
 
 		if (!valid)
 			continue;
@@ -1240,9 +1240,24 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 			wacom->shared->stylus_in_proximity = false;
 			wacom_exit_report(wacom);
 			input_sync(pen_input);
+
+			wacom->tool[0] = 0;
+			wacom->id[0] = 0;
+			wacom->serial[0] = 0;
 			return;
 		}
+
 		if (range) {
+			if (!wacom->tool[0]) { /* first in range */
+				/* Going into range select tool */
+				if (invert)
+					wacom->tool[0] = BTN_TOOL_RUBBER;
+				else if (wacom->id[0])
+					wacom->tool[0] = wacom_intuos_get_tool_type(wacom->id[0]);
+				else
+					wacom->tool[0] = BTN_TOOL_PEN;
+			}
+
 			/* Fix rotation alignment: userspace expects zero at left */
 			int16_t rotation = (int16_t)get_unaligned_le16(&frame[9]);
 			rotation += 1800/4;
-- 
2.21.0
