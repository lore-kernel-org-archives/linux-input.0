From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH] Input: joydev - ignore accelerometer devices
Date: Fri,  9 Jun 2017 13:35:47 -0700
Message-ID: <20170609203547.17691-2-roderick@gaikai.com>
References: <20170609203547.17691-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:35261 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751536AbdFIUfx (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 9 Jun 2017 16:35:53 -0400
Received: by mail-qt0-f177.google.com with SMTP id w1so88597103qtg.2
        for <linux-input@vger.kernel.org>; Fri, 09 Jun 2017 13:35:52 -0700 (PDT)
In-Reply-To: <20170609203547.17691-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Gamepads like DualShock 3 / 4 as of 4.12 started reporting motion
sensors on a separate evdev node. Joydev is picking these devices
up as well, but they don't make sense for the joydev interface.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/input/joydev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 29d677c..a5ceaaf 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -819,6 +819,10 @@ static bool joydev_match(struct input_handler *handler, struct input_dev *dev)
 	if (joydev_dev_is_absolute_mouse(dev))
 		return false;
 
+	/* Avoid accelerometers */
+	if (test_bit(INPUT_PROP_ACCELEROMETER, dev->propbit))
+		return false;
+
 	return true;
 }
 
-- 
2.9.3

