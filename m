From: Darren Hart <dvhart@infradead.org>
Subject: [PATCH] hid-core: Avoid uninitialized buffer access
Date: Fri, 18 Sep 2015 16:31:33 -0700
Message-ID: <d1f3f51b2808c78266fec8b786514288defc23a8.1442619093.git.dvhart@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55340 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811AbbIRXbv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Sep 2015 19:31:51 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, stable@vger.kernel.org, Darren Hart <dvhart@linux.intel.com>

From: Richard Purdie <richard.purdie@linuxfoundation.org>

hid_connect adds various strings to the buffer but they're all
conditional. You can find circumstances where nothing would be written
to it but the kernel will still print the supposedly empty buffer with
printk. This leads to corruption on the console/in the logs.

Ensure buf is initialized to an empty string.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
[dvhart: Initialize string to "" rather than assign buf[0] = NULL;]
Cc: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Darren Hart <dvhart@linux.intel.com>
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 70a11ac..c0fbf4e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1611,7 +1611,7 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 		"Multi-Axis Controller"
 	};
 	const char *type, *bus;
-	char buf[64];
+	char buf[64] = "";
 	unsigned int i;
 	int len;
 	int ret;
-- 
2.1.4

