From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 1/3] HID: wiimote: use unique battery names
Date: Tue,  2 Apr 2013 19:58:34 +0200
Message-ID: <1364925516-5724-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:48512 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757797Ab3DBR7I (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Apr 2013 13:59:08 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm2so358081bkc.2
        for <linux-input@vger.kernel.org>; Tue, 02 Apr 2013 10:59:06 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

Battery device names must be unique, otherwise registration fails if
multiple Wii Remotes are connected.

This breaks the sysfs API, but there is no known application that uses the
Wii Remote battery that I know of so we should go ahead and apply this.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 84e2fbe..c73bc80 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1160,6 +1160,7 @@ static void wiimote_destroy(struct wiimote_data *wdata)
 	wiimote_leds_destroy(wdata);
 
 	power_supply_unregister(&wdata->battery);
+	kfree(wdata->battery.name);
 	input_unregister_device(wdata->accel);
 	input_unregister_device(wdata->ir);
 	input_unregister_device(wdata->input);
@@ -1216,9 +1217,14 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 	wdata->battery.properties = wiimote_battery_props;
 	wdata->battery.num_properties = ARRAY_SIZE(wiimote_battery_props);
 	wdata->battery.get_property = wiimote_battery_get_property;
-	wdata->battery.name = "wiimote_battery";
 	wdata->battery.type = POWER_SUPPLY_TYPE_BATTERY;
 	wdata->battery.use_for_apm = 0;
+	wdata->battery.name = kasprintf(GFP_KERNEL, "wiimote_battery_%s",
+					wdata->hdev->uniq);
+	if (!wdata->battery.name) {
+		ret = -ENOMEM;
+		goto err_battery_name;
+	}
 
 	ret = power_supply_register(&wdata->hdev->dev, &wdata->battery);
 	if (ret) {
@@ -1254,6 +1260,8 @@ err_free:
 	return ret;
 
 err_battery:
+	kfree(wdata->battery.name);
+err_battery_name:
 	input_unregister_device(wdata->input);
 	wdata->input = NULL;
 err_input:
-- 
1.8.2

