From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 1/2] HID: wacom: Fix error path of power-supply initialization
Date: Mon,  5 Sep 2011 18:45:28 +0200
Message-ID: <1315241129-3889-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:48710 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605Ab1IEQpp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Sep 2011 12:45:45 -0400
Received: by ewy4 with SMTP id 4so2295924ewy.19
        for <linux-input@vger.kernel.org>; Mon, 05 Sep 2011 09:45:44 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

power_supply_unregister() must not be called if power_supply_register() failed.
The wdata->psy.dev pointer may point to invalid memory after a failed
power_supply_register() and hence wacom_remove() will fail while calling
power_supply_unregister().

This changes the wacom_probe function to fail if it cannot register the
power_supply devices. If we would want to keep the previous behaviour we had to
keep some flag about the power_supply state and check it on wacom_remove, but
this seems inappropriate here. Hence, we simply fail, too, if
power_supply_register fails.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wacom.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 0688832..f66a597 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -353,11 +353,7 @@ static int wacom_probe(struct hid_device *hdev,
 	if (ret) {
 		hid_warn(hdev, "can't create sysfs battery attribute, err: %d\n",
 			 ret);
-		/*
-		 * battery attribute is not critical for the tablet, but if it
-		 * failed then there is no need to create ac attribute
-		 */
-		goto move_on;
+		goto err_battery;
 	}
 
 	wdata->ac.properties = wacom_ac_props;
@@ -371,14 +367,8 @@ static int wacom_probe(struct hid_device *hdev,
 	if (ret) {
 		hid_warn(hdev,
 			 "can't create ac battery attribute, err: %d\n", ret);
-		/*
-		 * ac attribute is not critical for the tablet, but if it
-		 * failed then we don't want to battery attribute to exist
-		 */
-		power_supply_unregister(&wdata->battery);
+		goto err_ac;
 	}
-
-move_on:
 #endif
 	hidinput = list_entry(hdev->inputs.next, struct hid_input, list);
 	input = hidinput->input;
@@ -416,6 +406,13 @@ move_on:
 
 	return 0;
 
+#ifdef CONFIG_HID_WACOM_POWER_SUPPLY
+err_ac:
+	power_supply_unregister(&wdata->battery);
+err_battery:
+	device_remove_file(&hdev->dev, &dev_attr_speed);
+	hid_hw_stop(hdev);
+#endif
 err_free:
 	kfree(wdata);
 	return ret;
-- 
1.7.6.1

