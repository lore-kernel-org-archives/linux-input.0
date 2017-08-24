From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 4/4] Input: joydev - ignore devices which don't want joydev
Date: Thu, 24 Aug 2017 16:11:53 -0700
Message-ID: <20170824231153.8809-5-roderick@gaikai.com>
References: <20170824231153.8809-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36694 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754095AbdHXXMG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 24 Aug 2017 19:12:06 -0400
Received: by mail-qk0-f176.google.com with SMTP id o63so4663905qkb.3
        for <linux-input@vger.kernel.org>; Thu, 24 Aug 2017 16:12:05 -0700 (PDT)
In-Reply-To: <20170824231153.8809-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Gamepads like DualShock 3 / 4 as of 4.12 started reporting motion
sensors on a separate evdev node. Joydev is picking these devices
up as well, but they don't make sense for the joydev interface.
This patch leverages INPUT_PROP_JOYDEV_IGNORE to not create joydev
devices for devices, which don't want them.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/input/joydev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 29d677c..a60cfb3 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -819,6 +819,10 @@ static bool joydev_match(struct input_handler *handler, struct input_dev *dev)
 	if (joydev_dev_is_absolute_mouse(dev))
 		return false;
 
+	/* Avoid devices, which don't want to be reported by joydev. */
+	if (test_bit(INPUT_PROP_JOYDEV_IGNORE, dev->propbit))
+		return false;
+
 	return true;
 }
 
-- 
2.9.4

