From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/4] HID: lg4ff: Remove unnecessary casts of void pointers
Date: Thu, 13 Sep 2012 14:09:33 +0800
Message-ID: <1347516573.3319.3.camel@phoenix>
References: <1347516512.3319.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:33903 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab2IMGJi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 02:09:38 -0400
Received: by oago6 with SMTP id o6so1616929oag.19
        for <linux-input@vger.kernel.org>; Wed, 12 Sep 2012 23:09:38 -0700 (PDT)
In-Reply-To: <1347516512.3319.2.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Simon Wood <simon@mungewell.org>, Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>, linux-input@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hid/hid-lg4ff.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index f3390ee..da23c6b 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -360,7 +360,7 @@ static void lg4ff_led_set_brightness(struct led_classdev *led_cdev,
 {
 	struct device *dev = led_cdev->dev->parent;
 	struct hid_device *hid = container_of(dev, struct hid_device, dev);
-	struct lg_drv_data *drv_data = (struct lg_drv_data *)hid_get_drvdata(hid);
+	struct lg_drv_data *drv_data = hid_get_drvdata(hid);
 	struct lg4ff_device_entry *entry;
 	int i, state = 0;
 
@@ -395,7 +395,7 @@ static enum led_brightness lg4ff_led_get_brightness(struct led_classdev *led_cde
 {
 	struct device *dev = led_cdev->dev->parent;
 	struct hid_device *hid = container_of(dev, struct hid_device, dev);
-	struct lg_drv_data *drv_data = (struct lg_drv_data *)hid_get_drvdata(hid);
+	struct lg_drv_data *drv_data = hid_get_drvdata(hid);
 	struct lg4ff_device_entry *entry;
 	int i, value = 0;
 
-- 
1.7.9.5



