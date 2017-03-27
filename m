From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 08/19] HID: logitech-hidpp: rework hidpp_connect_event()
Date: Mon, 27 Mar 2017 16:59:28 +0200
Message-ID: <20170327145939.29824-9-benjamin.tissoires@redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Looks like all users don't care about a disconnect.
Simplify the various variant_connect() and put the connect state check
at the beginning.

For delayed input devices, make sure we go through all other connect
values (protocol, battery) before bailing out.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v3:
- moved up in the series

new in v2
---
 drivers/hid/hid-logitech-hidpp.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index b0d2fea..81ebded 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1884,9 +1884,6 @@ static int wtp_connect(struct hid_device *hdev, bool connected)
 	struct wtp_data *wd = hidpp->private_data;
 	int ret;
 
-	if (!connected)
-		return 0;
-
 	if (!wd->x_size) {
 		ret = wtp_get_config(hidpp);
 		if (ret) {
@@ -1954,9 +1951,6 @@ static int m560_send_config_command(struct hid_device *hdev, bool connected)
 
 	hidpp_dev = hid_get_drvdata(hdev);
 
-	if (!connected)
-		return -ENODEV;
-
 	return hidpp_send_rap_command_sync(
 		hidpp_dev,
 		REPORT_ID_HIDPP_SHORT,
@@ -2160,9 +2154,6 @@ static int k400_connect(struct hid_device *hdev, bool connected)
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 
-	if (!connected)
-		return 0;
-
 	if (!disable_tap_to_click)
 		return 0;
 
@@ -2414,6 +2405,9 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	struct input_dev *input;
 	char *name, *devm_name;
 
+	if (!connected)
+		return;
+
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
 		ret = wtp_connect(hdev, connected);
 		if (ret)
@@ -2428,9 +2422,6 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 			return;
 	}
 
-	if (!connected || hidpp->delayed_input)
-		return;
-
 	/* the device is already connected, we can ask for its name and
 	 * protocol */
 	if (!hidpp->protocol_major) {
@@ -2461,8 +2452,8 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 
 	hidpp_initialize_battery(hidpp);
 
-	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT))
-		/* if HID created the input nodes for us, we can stop now */
+	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT) || hidpp->delayed_input)
+		/* if the input nodes are already created, we can stop now */
 		return;
 
 	input = hidpp_allocate_input(hdev);
-- 
2.9.3
