From: Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to 3.12-stable] HID: core: Avoid uninitialized buffer access
Date: Thu, 28 Jan 2016 11:52:21 +0100
Message-ID: <1453978346-20237-30-git-send-email-jslaby@suse.cz>
References: <1453978346-20237-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60526 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967343AbcA1Kwv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jan 2016 05:52:51 -0500
In-Reply-To: <1453978346-20237-1-git-send-email-jslaby@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: stable@vger.kernel.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Darren Hart <dvhart@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Jiri Slaby <jslaby@suse.cz>

From: Richard Purdie <richard.purdie@linuxfoundation.org>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

commit 79b568b9d0c7c5d81932f4486d50b38efdd6da6d upstream.

hid_connect adds various strings to the buffer but they're all
conditional. You can find circumstances where nothing would be written
to it but the kernel will still print the supposedly empty buffer with
printk. This leads to corruption on the console/in the logs.

Ensure buf is initialized to an empty string.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
[dvhart: Initialize string to "" rather than assign buf[0] = NULL;]
Cc: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org
Signed-off-by: Darren Hart <dvhart@linux.intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 85b0da8c33f4..7ca1b4a97a14 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1514,7 +1514,7 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 		"Multi-Axis Controller"
 	};
 	const char *type, *bus;
-	char buf[64];
+	char buf[64] = "";
 	unsigned int i;
 	int len;
 	int ret;
-- 
2.7.0

