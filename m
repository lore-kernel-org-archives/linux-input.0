From: "Gerecke, Jason" <killertofu@gmail.com>
Subject: [PATCH 2/2] HID: wacom: Don't report anything prior to the tool entering range
Date: Fri, 26 Apr 2019 09:35:31 -0700
Message-ID: <20190426163531.9782-1-jason.gerecke@wacom.com>
References: <CANRwn3Ru+7FGtsY=GaDa7pAJkuagdb6nFtvrFq1qhTWJR0rF9A@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CANRwn3Ru+7FGtsY=GaDa7pAJkuagdb6nFtvrFq1qhTWJR0rF9A@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: "# v3.17+" <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Armstrong Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Aaron Armstrong Skomra <aaron.skomra@wacom.com>
List-Id: linux-input@vger.kernel.org

From: Jason Gerecke <jason.gerecke@wacom.com>

If the tool spends some time in prox before entering range, a series of
events (e.g. ABS_DISTANCE, MSC_SERIAL) can be sent before we or userspace
have any clue about the pen whose data is being reported. We need to hold
off on reporting anything until the pen has entered range. Since we still
want to report events that occur "in prox" after the pen has *left* range
we use 'wacom-tool[0]' as the indicator that the pen did at one point
enter range and provide us/userspace with tool type and serial number
information.

Fixes: a48324de6d ("HID: wacom: Bluetooth IRQ for Intuos Pro should handle prox/range")
Cc: <stable@vger.kernel.org> # 4.11+
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
---
Version of patch specifically targeted to stable v4.14.113

 drivers/hid/wacom_wac.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 03b04bc742dd..e4aeffa56018 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1271,17 +1271,20 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 			input_report_abs(pen_input, ABS_Z, rotation);
 			input_report_abs(pen_input, ABS_WHEEL, get_unaligned_le16(&frame[11]));
 		}
-		input_report_abs(pen_input, ABS_PRESSURE, get_unaligned_le16(&frame[5]));
-		input_report_abs(pen_input, ABS_DISTANCE, range ? frame[13] : wacom->features.distance_max);
 
-		input_report_key(pen_input, BTN_TOUCH, frame[0] & 0x01);
-		input_report_key(pen_input, BTN_STYLUS, frame[0] & 0x02);
-		input_report_key(pen_input, BTN_STYLUS2, frame[0] & 0x04);
+		if (wacom->tool[0]) {
+			input_report_abs(pen_input, ABS_PRESSURE, get_unaligned_le16(&frame[5]));
+			input_report_abs(pen_input, ABS_DISTANCE, range ? frame[13] : wacom->features.distance_max);
 
-		input_report_key(pen_input, wacom->tool[0], prox);
-		input_event(pen_input, EV_MSC, MSC_SERIAL, wacom->serial[0]);
-		input_report_abs(pen_input, ABS_MISC,
-				 wacom_intuos_id_mangle(wacom->id[0])); /* report tool id */
+			input_report_key(pen_input, BTN_TOUCH, frame[0] & 0x01);
+			input_report_key(pen_input, BTN_STYLUS, frame[0] & 0x02);
+			input_report_key(pen_input, BTN_STYLUS2, frame[0] & 0x04);
+
+			input_report_key(pen_input, wacom->tool[0], prox);
+			input_event(pen_input, EV_MSC, MSC_SERIAL, wacom->serial[0]);
+			input_report_abs(pen_input, ABS_MISC,
+					 wacom_intuos_id_mangle(wacom->id[0])); /* report tool id */
+		}
 
 		wacom->shared->stylus_in_proximity = prox;
 
-- 
2.21.0
