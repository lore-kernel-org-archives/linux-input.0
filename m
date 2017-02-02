From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 15/15] HID: logitech-hidpp: rework hidpp_connect_event()
Date: Thu,  2 Feb 2017 15:12:29 +0100
Message-ID: <20170202141229.17322-16-benjamin.tissoires@redhat.com>
References: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Looks like all users don't care about a disconnect.
Simplify the various variant_connect() and put the connect state check
at the beginning.

For delayed input devices, make sure we go through all other connect
values (protocol, battery) before bailing out.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v2
---
 drivers/hid/hid-logitech-hidpp.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 28ce443..5aff454 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2120,9 +2120,6 @@ static int wtp_connect(struct hid_device *hdev, bool connected)
 	struct wtp_data *wd = hidpp->private_data;
 	int ret;
 
-	if (!connected)
-		return 0;
-
 	if (!wd->x_size) {
 		ret = wtp_get_config(hidpp);
 		if (ret) {
@@ -2190,9 +2187,6 @@ static int m560_send_config_command(struct hid_device *hdev, bool connected)
 
 	hidpp_dev = hid_get_drvdata(hdev);
 
-	if (!connected)
-		return -ENODEV;
-
 	return hidpp_send_rap_command_sync(
 		hidpp_dev,
 		REPORT_ID_HIDPP_SHORT,
@@ -2396,9 +2390,6 @@ static int k400_connect(struct hid_device *hdev, bool connected)
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 
-	if (!connected)
-		return 0;
-
 	if (!disable_tap_to_click)
 		return 0;
 
@@ -2715,6 +2706,9 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	struct input_dev *input;
 	char *name, *devm_name;
 
+	if (!connected)
+		return;
+
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
 		ret = wtp_connect(hdev, connected);
 		if (ret)
@@ -2729,9 +2723,6 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 			return;
 	}
 
-	if (!connected || hidpp->delayed_input)
-		return;
-
 	/* the device is already connected, we can ask for its name and
 	 * protocol */
 	if (!hidpp->protocol_major) {
@@ -2773,8 +2764,8 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	if (hidpp->battery.ps)
 		power_supply_changed(hidpp->battery.ps);
 
-	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT))
-		/* if HID created the input nodes for us, we can stop now */
+	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT) || hidpp->delayed_input)
+		/* if the input nodes are already created, we can stop now */
 		return;
 
 	input = hidpp_allocate_input(hdev);
-- 
2.9.3
