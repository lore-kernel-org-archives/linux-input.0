From: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] HID: uhid: add devname module alias
Date: Sun,  1 Sep 2013 11:02:46 -0700
Message-ID: <1378058566-5207-1-git-send-email-marcel@holtmann.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from s15283307.onlinehome-server.info ([87.106.208.187]:47008 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757842Ab3IASCy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Sep 2013 14:02:54 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dh.herrmann@googlemail.com, jkosina@suse.cz
Cc: linux-input@vger.kernel.org

For simple device node creation, add the devname module alias.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/hid/uhid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index fc307e0..9ab7dfc 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -659,3 +659,4 @@ module_exit(uhid_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Herrmann <dh.herrmann@gmail.com>");
 MODULE_DESCRIPTION("User-space I/O driver support for HID subsystem");
+MODULE_ALIAS("devname:" UHID_NAME);
-- 
1.8.3.1

