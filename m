From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 3/4] HID: udraw-ps3: Set INPUT_PROP_JOYDEV_IGNORE for motion sensor
Date: Thu, 24 Aug 2017 16:11:52 -0700
Message-ID: <20170824231153.8809-4-roderick@gaikai.com>
References: <20170824231153.8809-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:37793 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754095AbdHXXMF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 24 Aug 2017 19:12:05 -0400
Received: by mail-qt0-f172.google.com with SMTP id d15so4510724qta.4
        for <linux-input@vger.kernel.org>; Thu, 24 Aug 2017 16:12:04 -0700 (PDT)
In-Reply-To: <20170824231153.8809-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Set the INPUT_PROP_JOYDEV_IGNORE flag for the motion sensor device,
so it won't get picked up by joydev.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-udraw-ps3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-udraw-ps3.c b/drivers/hid/hid-udraw-ps3.c
index 88ea390..7ea4066 100644
--- a/drivers/hid/hid-udraw-ps3.c
+++ b/drivers/hid/hid-udraw-ps3.c
@@ -379,6 +379,7 @@ static bool udraw_setup_accel(struct udraw *udraw,
 	input_set_abs_params(input_dev, ABS_Z, -512, 512, 0, 0);
 
 	set_bit(INPUT_PROP_ACCELEROMETER, input_dev->propbit);
+	set_bit(INPUT_PROP_JOYDEV_IGNORE, input_dev->propbit);
 
 	udraw->accel_input_dev = input_dev;
 
-- 
2.9.4

