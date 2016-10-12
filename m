From: lizf@kernel.org
Subject: [PATCH 3.4 014/125] HID: core: Avoid uninitialized buffer access
Date: Wed, 12 Oct 2016 20:32:10 +0800
Message-ID: <1476275641-4697-14-git-send-email-lizf@kernel.org>
References: <1476275600-4626-1-git-send-email-lizf@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1476275600-4626-1-git-send-email-lizf@kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Richard Purdie <richard.purdie@linuxfoundation.org>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Darren Hart <dvhart@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Zefan Li <lizefan@huawei.com>
List-Id: linux-input@vger.kernel.org

From: Richard Purdie <richard.purdie@linuxfoundation.org>

3.4.113-rc1 review patch.  If anyone has any objections, please let me know.

------------------


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
Signed-off-by: Zefan Li <lizefan@huawei.com>
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 75fa2e7..b8ad132 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1301,7 +1301,7 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
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
