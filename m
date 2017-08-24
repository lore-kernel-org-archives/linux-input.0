From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 2/4] HID: sony: Set INPUT_PROP_JOYDEV_IGNORE flag for motion sensors.
Date: Thu, 24 Aug 2017 16:11:51 -0700
Message-ID: <20170824231153.8809-3-roderick@gaikai.com>
References: <20170824231153.8809-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:37779 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754095AbdHXXMC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 24 Aug 2017 19:12:02 -0400
Received: by mail-qk0-f180.google.com with SMTP id k126so4649980qkb.4
        for <linux-input@vger.kernel.org>; Thu, 24 Aug 2017 16:12:02 -0700 (PDT)
In-Reply-To: <20170824231153.8809-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Configure the motion sensor sub device with the INPUT_PROP_JOYDEV_IGNORE
flag to prevent joydev from picking it up.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index d03203a..6c290c6 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1375,6 +1375,7 @@ static int sony_register_sensors(struct sony_sc *sc)
 	}
 
 	__set_bit(INPUT_PROP_ACCELEROMETER, sc->sensor_dev->propbit);
+	__set_bit(INPUT_PROP_JOYDEV_IGNORE, sc->sensor_dev->propbit);
 
 	ret = input_register_device(sc->sensor_dev);
 	if (ret < 0)
-- 
2.9.4

