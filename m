From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 3/3] Input: joydev - ignore accelerometer devices
Date: Thu, 17 Aug 2017 19:01:56 -0700
Message-ID: <20170818020156.23390-4-roderick@gaikai.com>
References: <20170818020156.23390-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:36104 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753857AbdHRCCM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Aug 2017 22:02:12 -0400
Received: by mail-qt0-f175.google.com with SMTP id v29so47259626qtv.3
        for <linux-input@vger.kernel.org>; Thu, 17 Aug 2017 19:02:12 -0700 (PDT)
In-Reply-To: <20170818020156.23390-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Gamepads like DualShock 3 / 4 as of 4.12 started reporting motion
sensors on a separate evdev node. Joydev is picking these devices
up as well, but they don't make sense for the joydev interface.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/input/joydev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 29d677c..9b70fe0 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -819,6 +819,11 @@ static bool joydev_match(struct input_handler *handler, struct input_dev *dev)
 	if (joydev_dev_is_absolute_mouse(dev))
 		return false;
 
+	/* Avoid accelerometers on composite devices. */
+	if (test_bit(INPUT_PROP_ACCELEROMETER, dev->propbit) &&
+	    test_bit(INPUT_PROP_COMPOSITE, dev->propbit))
+		return false;
+
 	return true;
 }
 
-- 
2.9.4

