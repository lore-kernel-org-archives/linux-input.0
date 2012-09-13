From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] HID: lenovo-tpkbd: Fix memory leak in tpkbd_remove_tp()
Date: Thu, 13 Sep 2012 13:25:12 +0800
Message-ID: <1347513912.3319.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37076 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412Ab2IMFZU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 01:25:20 -0400
Received: by obbuo13 with SMTP id uo13so3929798obb.19
        for <linux-input@vger.kernel.org>; Wed, 12 Sep 2012 22:25:20 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Bernhard Seibold <mail@bernhard-seibold.de>, linux-input@vger.kernel.org

We need to kfree names for led_mute and led_micmute in tpkbd_remove_tp().

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hid/hid-lenovo-tpkbd.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-lenovo-tpkbd.c b/drivers/hid/hid-lenovo-tpkbd.c
index 77d2df0..60c4e1e 100644
--- a/drivers/hid/hid-lenovo-tpkbd.c
+++ b/drivers/hid/hid-lenovo-tpkbd.c
@@ -519,6 +519,8 @@ static void tpkbd_remove_tp(struct hid_device *hdev)
 	led_classdev_unregister(&data_pointer->led_mute);
 
 	hid_set_drvdata(hdev, NULL);
+	kfree(data_pointer->led_micmute.name);
+	kfree(data_pointer->led_mute.name);
 	kfree(data_pointer);
 }
 
-- 
1.7.9.5



