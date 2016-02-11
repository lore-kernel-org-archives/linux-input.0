From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 50/64] HID: core: Avoid uninitialized buffer access
Date: Thu, 11 Feb 2016 14:59:26 +0100
Message-ID: <a258401dd98e0f6968f014bf3410a091c3785ad4.1455198893.git.jslaby@suse.cz>
References: <74c0820133f1dada0d70c74bc70a9530b2697f86.1455198893.git.jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <74c0820133f1dada0d70c74bc70a9530b2697f86.1455198893.git.jslaby@suse.cz>
In-Reply-To: <cover.1455198893.git.jslaby@suse.cz>
References: <cover.1455198893.git.jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Richard Purdie <richard.purdie@linuxfoundation.org>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Darren Hart <dvhart@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-input@vger.kernel.org

From: Richard Purdie <richard.purdie@linuxfoundation.org>

3.12-stable review patch.  If anyone has any objections, please let me know.

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
2.7.1
