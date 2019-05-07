From: "Gerecke, Jason" <killertofu@gmail.com>
Subject: [PATCH 3/3] HID: wacom: Sync INTUOSP2_BT touch state after each frame if necessary
Date: Tue,  7 May 2019 11:53:22 -0700
Message-ID: <20190507185322.7168-3-jason.gerecke@wacom.com>
References: <20190507185322.7168-1-jason.gerecke@wacom.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190507185322.7168-1-jason.gerecke@wacom.com>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Aaron Armstrong Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Jason Gerecke <jason.gerecke@wacom.com>

The Bluetooth interface of the 2nd-gen Intuos Pro batches together four
independent "frames" of finger data into a single report. Each frame
is essentially equivalent to a single USB report, with the up-to-10
fingers worth of information being spread across two frames. At the
moment the driver only calls `input_sync` after processing all four
frames have been processed, which can result in the driver sending
multiple updates for a single slot within the same SYN_REPORT. This
can confuse userspace, so modify the driver to sync more often if
necessary (i.e., after reporting the state of all fingers).

Fixes: 4922cd26f0 ("HID: wacom: Support 2nd-gen Intuos Pro's Bluetooth classic interface")
Cc: <stable@vger.kernel.org> # 4.11+
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index e848445236d8..09b8e4aac82f 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1371,11 +1371,17 @@ static void wacom_intuos_pro2_bt_touch(struct wacom_wac *wacom)
 		if (wacom->num_contacts_left <= 0) {
 			wacom->num_contacts_left = 0;
 			wacom->shared->touch_down = wacom_wac_finger_count_touches(wacom);
+			input_sync(touch_input);
 		}
 	}
 
-	input_report_switch(touch_input, SW_MUTE_DEVICE, !(data[281] >> 7));
-	input_sync(touch_input);
+	if (wacom->num_contacts_left == 0) {
+		// Be careful that we don't accidentally call input_sync with
+		// only a partial set of fingers of processed
+		input_report_switch(touch_input, SW_MUTE_DEVICE, !(data[281] >> 7));
+		input_sync(touch_input);
+	}
+
 }
 
 static void wacom_intuos_pro2_bt_pad(struct wacom_wac *wacom)
-- 
2.21.0
