From: Dan Carpenter <error27@gmail.com>
Subject: [patch] hid: check for kmalloc() failure
Date: Mon, 24 Jan 2011 21:32:13 +0300
Message-ID: <20110124183213.GA2721@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48255 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab1AXSc2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Jan 2011 13:32:28 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, erazor_de@users.sourceforge.net
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

Return -ENOMEM if kmalloc() fails.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index 1608c8d..c27bc91 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -220,6 +220,10 @@ static int koneplus_get_startup_profile(struct usb_device *usb_dev)
 	int retval;
 
 	buf = kmalloc(sizeof(struct koneplus_startup_profile), GFP_KERNEL);
+	if (!buf) {
+		retval = -ENOMEM;
+		goto out;
+	}
 
 	retval = koneplus_receive(usb_dev, KONEPLUS_USB_COMMAND_STARTUP_PROFILE,
 			buf, sizeof(struct koneplus_startup_profile));
