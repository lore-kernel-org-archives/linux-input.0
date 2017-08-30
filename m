From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2 1/2] HID: wacom: Properly report negative values from Intuos Pro 2 Bluetooth
Date: Wed, 30 Aug 2017 15:13:25 -0700
Message-ID: <20170830221326.15877-1-killertofu@gmail.com>
References: <CANRwn3Qt4wr4dSi2=diw_5Yh2w67TpW6zxgUY+csZLzykgqGXA@mail.gmail.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CANRwn3Qt4wr4dSi2=diw_5Yh2w67TpW6zxgUY+csZLzykgqGXA@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>
Cc: stable@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>
List-Id: linux-input@vger.kernel.org

The wacom driver's IRQ handler for Bluetooth reports from the 2nd-gen
Intuos Pro does not correctly process negative numbers. Values for
tilt and rotation (which can go negative) are instead interpreted as
unsigned and so jump to very large values when the data should be
negative. This commit properly casts the data to ensure we report
negative numbers when necessary.

Fixes: 4922cd2 ("HID: wacom: Support 2nd-gen Intuos Pro's Bluetooth classic interface")
Cc: stable@vger.kernel.org # v4.11
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
Changes from v1:
  * Patch introduced.

 drivers/hid/wacom_wac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index bb17d7bbefd3..d7ca1eb9d559 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1229,9 +1229,9 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 		if (range) {
 			input_report_abs(pen_input, ABS_X, get_unaligned_le16(&frame[1]));
 			input_report_abs(pen_input, ABS_Y, get_unaligned_le16(&frame[3]));
-			input_report_abs(pen_input, ABS_TILT_X, frame[7]);
-			input_report_abs(pen_input, ABS_TILT_Y, frame[8]);
-			input_report_abs(pen_input, ABS_Z, get_unaligned_le16(&frame[9]));
+			input_report_abs(pen_input, ABS_TILT_X, (char)frame[7]);
+			input_report_abs(pen_input, ABS_TILT_Y, (char)frame[8]);
+			input_report_abs(pen_input, ABS_Z, (int16_t)get_unaligned_le16(&frame[9]));
 			input_report_abs(pen_input, ABS_WHEEL, get_unaligned_le16(&frame[11]));
 		}
 		input_report_abs(pen_input, ABS_PRESSURE, get_unaligned_le16(&frame[5]));
-- 
2.14.1
