From: "Gerecke, Jason" <killertofu@gmail.com>
Subject: [PATCH 1/3] HID: wacom: Send BTN_TOUCH in response to INTUOSP2_BT eraser contact
Date: Tue,  7 May 2019 11:53:20 -0700
Message-ID: <20190507185322.7168-1-jason.gerecke@wacom.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Aaron Armstrong Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, stable@vger.kernel.org, Aaron Skomra <aaron.skomra@wacom.com>
List-Id: linux-input@vger.kernel.org

From: Jason Gerecke <jason.gerecke@wacom.com>

The Bluetooth reports from the 2nd-gen Intuos Pro have separate bits for
indicating if the tip or eraser is in contact with the tablet. At the
moment, only the tip contact bit controls the state of the BTN_TOUCH
event. This prevents the eraser from working as expected. This commit
changes the driver to send BTN_TOUCH whenever either the tip or eraser
contact bit is set.

Fixes: 4922cd26f0 ("HID: wacom: Support 2nd-gen Intuos Pro's Bluetooth classic interface")
Cc: <stable@vger.kernel.org> # 4.11+
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Aaron Skomra <aaron.skomra@wacom.com>
---
 drivers/hid/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 613342bb9d6b..af62a630fee9 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1301,7 +1301,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 						 range ? frame[7] : wacom->features.distance_max);
 			}
 
-			input_report_key(pen_input, BTN_TOUCH, frame[0] & 0x01);
+			input_report_key(pen_input, BTN_TOUCH, frame[0] & 0x09);
 			input_report_key(pen_input, BTN_STYLUS, frame[0] & 0x02);
 			input_report_key(pen_input, BTN_STYLUS2, frame[0] & 0x04);
 
-- 
2.21.0
