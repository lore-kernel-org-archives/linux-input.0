From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] HID: wacom: Fix wacom_probe error handling
Date: Mon, 17 Sep 2012 10:29:00 +0800
Message-ID: <1347848940.20002.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38116 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805Ab2IQC3J (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 16 Sep 2012 22:29:09 -0400
Received: by obbuo13 with SMTP id uo13so8411399obb.19
        for <linux-input@vger.kernel.org>; Sun, 16 Sep 2012 19:29:08 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Przemo Firszt <przemo@firszt.eu>, Ping Cheng <pingc@wacom.com>, linux-input@vger.kernel.org

In the case of goto destroy_leds, we also need to call hid_hw_stop(hdev) and
remove sysfs attribute files we created for speed and oleds.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hid/hid-wacom.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index a0fafac..fae7fd7 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -902,10 +902,18 @@ OLED_INIT(7);
 err_ac:
 	power_supply_unregister(&wdata->battery);
 err_battery:
-	device_remove_file(&hdev->dev, &dev_attr_speed);
-	hid_hw_stop(hdev);
 destroy_leds:
 	wacom_destroy_leds(hdev);
+	device_remove_file(&hdev->dev, &dev_attr_oled0_img);
+	device_remove_file(&hdev->dev, &dev_attr_oled1_img);
+	device_remove_file(&hdev->dev, &dev_attr_oled2_img);
+	device_remove_file(&hdev->dev, &dev_attr_oled3_img);
+	device_remove_file(&hdev->dev, &dev_attr_oled4_img);
+	device_remove_file(&hdev->dev, &dev_attr_oled5_img);
+	device_remove_file(&hdev->dev, &dev_attr_oled6_img);
+	device_remove_file(&hdev->dev, &dev_attr_oled7_img);
+	device_remove_file(&hdev->dev, &dev_attr_speed);
+	hid_hw_stop(hdev);
 err_free:
 	kfree(wdata);
 	return ret;
-- 
1.7.9.5



