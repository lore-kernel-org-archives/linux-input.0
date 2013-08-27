From: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] HID: uhid: add devname module alias
Date: Mon, 26 Aug 2013 22:07:42 -0700
Message-ID: <1377580062-14346-1-git-send-email-marcel@holtmann.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from s15283307.onlinehome-server.info ([87.106.208.187]:41525 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165Ab3H0FHu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Aug 2013 01:07:50 -0400
Received: from localhost.localdomain (S010620c9d099deff.vc.shawcable.net [24.84.124.211])
	by mail.holtmann.org (Postfix) with ESMTPSA id 575E98B343
	for <linux-input@vger.kernel.org>; Tue, 27 Aug 2013 07:07:47 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

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

