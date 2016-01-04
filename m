From: Kamal Mostafa <kamal@canonical.com>
Subject: [4.2.y-ckt stable] Patch "HID: core: Avoid uninitialized buffer access" has been added to staging queue
Date: Mon,  4 Jan 2016 15:21:07 -0800
Message-ID: <1451949667-23359-1-git-send-email-kamal@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:33148 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbcADXVN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jan 2016 18:21:13 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Darren Hart <dvhart@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Kamal Mostafa <kamal@canonical.com>, kernel-team@lists.ubuntu.com

This is a note to let you know that I have just added a patch titled

    HID: core: Avoid uninitialized buffer access

to the linux-4.2.y-queue branch of the 4.2.y-ckt extended stable tree 
which can be found at:

    http://kernel.ubuntu.com/git/ubuntu/linux.git/log/?h=linux-4.2.y-queue

This patch is scheduled to be released in version 4.2.8-ckt1.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 4.2.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Kamal

------

>From 00a4aacb192878d413d7097b17fa58b599a70990 Mon Sep 17 00:00:00 2001
From: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Fri, 18 Sep 2015 16:31:33 -0700
Subject: HID: core: Avoid uninitialized buffer access

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
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e6fce23..e3edddd 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1591,7 +1591,7 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 		"Multi-Axis Controller"
 	};
 	const char *type, *bus;
-	char buf[64];
+	char buf[64] = "";
 	unsigned int i;
 	int len;
 	int ret;
--
1.9.1

