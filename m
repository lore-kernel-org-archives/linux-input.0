From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?=
        <sebastien.szymanski@armadeus.com>
Subject: [PATCH v2 3/3] HID: cp2112: fix broken gpio_direction_input callback
Date: Fri, 10 Nov 2017 10:01:43 +0100
Message-ID: <1510304503-30830-1-git-send-email-sebastien.szymanski@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:36951 "EHLO
        9.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdKJMJJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Nov 2017 07:09:09 -0500
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id CA8F2F3679
        for <linux-input@vger.kernel.org>; Fri, 10 Nov 2017 10:42:26 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Julien Boibessot <julien.boibessot@armadeus.com>, =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>

When everything goes smoothly, ret is set to 0 which makes the function
to return EIO error.

Fixes: 8e9faa15469e ("HID: cp2112: fix gpio-callback error handling")
Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
Changes in v2:
 - rework error handling to have only one exit path as suggested by
   Benjamin Tissoires <benjamin.tissoires@redhat.com>

 drivers/hid/hid-cp2112.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 28e3c18..68cdc96 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -196,6 +196,8 @@ static int cp2112_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 				 HID_REQ_GET_REPORT);
 	if (ret != CP2112_GPIO_CONFIG_LENGTH) {
 		hid_err(hdev, "error requesting GPIO config: %d\n", ret);
+		if (ret >= 0)
+			ret = -EIO;
 		goto exit;
 	}
 
@@ -205,8 +207,10 @@ static int cp2112_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 	ret = hid_hw_raw_request(hdev, CP2112_GPIO_CONFIG, buf,
 				 CP2112_GPIO_CONFIG_LENGTH, HID_FEATURE_REPORT,
 				 HID_REQ_SET_REPORT);
-	if (ret < 0) {
+	if (ret != CP2112_GPIO_CONFIG_LENGTH) {
 		hid_err(hdev, "error setting GPIO config: %d\n", ret);
+		if (ret >= 0)
+			ret = -EIO;
 		goto exit;
 	}
 
@@ -214,7 +218,7 @@ static int cp2112_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 
 exit:
 	mutex_unlock(&dev->lock);
-	return ret < 0 ? ret : -EIO;
+	return ret;
 }
 
 static void cp2112_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
-- 
2.7.3

