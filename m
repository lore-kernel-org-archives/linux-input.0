From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 3.2 04/52] HID: core: Avoid uninitialized buffer access
Date: Tue, 24 Nov 2015 22:33:59 +0000
Message-ID: <lsq.1448404439.99794969@decadent.org.uk>
References: <lsq.1448404438.351251660@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <lsq.1448404438.351251660@decadent.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: akpm@linux-foundation.org, Jiri Kosina <jikos@kernel.org>, Jiri Kosina <jkosina@suse.cz>, Richard Purdie <richard.purdie@linuxfoundation.org>, Darren Hart <dvhart@linux.intel.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

3.2.74-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Purdie <richard.purdie@linuxfoundation.org>

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
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1295,7 +1295,7 @@ int hid_connect(struct hid_device *hdev,
 		"Multi-Axis Controller"
 	};
 	const char *type, *bus;
-	char buf[64];
+	char buf[64] = "";
 	unsigned int i;
 	int len;
 	int ret;
