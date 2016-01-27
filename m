From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.1 121/127] HID: core: Avoid uninitialized buffer access
Date: Wed, 27 Jan 2016 10:14:45 -0800
Message-ID: <20160127180811.904543184@linuxfoundation.org>
References: <20160127180805.624425994@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20160127180805.624425994@linuxfoundation.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Richard Purdie <richard.purdie@linuxfoundation.org>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Darren Hart <dvhart@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

4.1-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1589,7 +1589,7 @@ int hid_connect(struct hid_device *hdev,
 		"Multi-Axis Controller"
 	};
 	const char *type, *bus;
-	char buf[64];
+	char buf[64] = "";
 	unsigned int i;
 	int len;
 	int ret;
