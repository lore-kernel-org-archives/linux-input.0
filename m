From: Willy Tarreau <w@1wt.eu>
Subject: [PATCH 2.6.32 32/38] [PATCH 32/38] HID: core: Avoid uninitialized buffer access
Date: Sun, 29 Nov 2015 22:47:34 +0100
Message-ID: <20151129214704.247076071@1wt.eu>
References: <8acf8256ccc72771a80b7851061027bc@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8acf8256ccc72771a80b7851061027bc@local>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Darren Hart <dvhart@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Ben Hutchings <ben@decadent.org.uk>, Willy Tarreau <w@1wt.eu>
List-Id: linux-input@vger.kernel.org

2.6.32-longterm review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
(cherry picked from commit 604bfd00358e3d7fce8dc789fe52d2f2be0fa4c7)

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e7e28b5..644ab4d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1235,7 +1235,7 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 		"Multi-Axis Controller"
 	};
 	const char *type, *bus;
-	char buf[64];
+	char buf[64] = "";
 	unsigned int i;
 	int len;
 
-- 
1.7.12.2.21.g234cd45.dirty
