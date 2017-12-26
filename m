From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] Fix reporting of touch toggle (WACOM_HID_WD_MUTE_DEVICE) events
Date: Tue, 26 Dec 2017 14:53:55 -0800
Message-ID: <20171226225355.27785-1-killertofu@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <binjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Armstrong Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>
List-Id: linux-input@vger.kernel.org

Touch toggle softkeys send a '1' while pressed and a '0' while released,
requring the kernel to keep track of wether touch should be enabled or
disabled. The code does not handle the state transitions properly,
however. If the key is pressed repeatedly, the following four states
of states are cycled through (assuming touch starts out enabled):

Press:   shared->is_touch_on => 0, SW_MUTE_DEVICE => 1
Release: shared->is_touch_on => 0, SW_MUTE_DEVICE => 1
Press:   shared->is_touch_on => 1, SW_MUTE_DEVICE => 0
Release: shared->is_touch_on => 1, SW_MUTE_DEVICE => 1

The hardware always properly enables/disables touch when the key is
pressed but applications that listen for SW_MUTE_DEVICE events to provide
feedback about the state will only ever show touch as being enabled while
the key is held, and only every-other time. This sequence occurs because
the fallthrough WACOM_HID_WD_TOUCHONOFF case is always handled, and it
uses the value of the *local* is_touch_on variable as the value to
report to userspace. The local value is equal to the shared value when
the button is pressed, but equal to zero when the button is released.

Reporting the shared value to userspace fixes this problem, but the
fallthrough case needs to update the shared value in an incompatible
way (which is why the local variable was introduced in the first place).
To work around this, we just handle both cases in a single block of code
and update the shared variable as appropriate.

Fixes: d793ff8187 ("HID: wacom: generic: support touch on/off softkey")
Cc: <stable@vger.kernel.org> # v4.12+
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Aaron Skomra <aaron.skomra@wacom.com>
Tested-by: Aaron Skomra <aaron.skomra@wacom.com>
---
 drivers/hid/wacom_wac.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 16af6886e828..7dbff253c05c 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1924,7 +1924,6 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 	struct wacom_features *features = &wacom_wac->features;
 	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
 	int i;
-	bool is_touch_on = value;
 	bool do_report = false;
 
 	/*
@@ -1969,16 +1968,17 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 		break;
 
 	case WACOM_HID_WD_MUTE_DEVICE:
-		if (wacom_wac->shared->touch_input && value) {
-			wacom_wac->shared->is_touch_on = !wacom_wac->shared->is_touch_on;
-			is_touch_on = wacom_wac->shared->is_touch_on;
-		}
-
-		/* fall through*/
 	case WACOM_HID_WD_TOUCHONOFF:
 		if (wacom_wac->shared->touch_input) {
+			bool *is_touch_on = &wacom_wac->shared->is_touch_on;
+
+			if (equivalent_usage == WACOM_HID_WD_MUTE_DEVICE && value)
+				*is_touch_on = !(*is_touch_on);
+			else if (equivalent_usage == WACOM_HID_WD_TOUCHONOFF)
+				*is_touch_on = value;
+
 			input_report_switch(wacom_wac->shared->touch_input,
-					    SW_MUTE_DEVICE, !is_touch_on);
+					    SW_MUTE_DEVICE, !(*is_touch_on));
 			input_sync(wacom_wac->shared->touch_input);
 		}
 		break;
-- 
2.15.1
