From: Luis Henriques <luis.henriques@canonical.com>
Subject: [3.16.y-ckt stable] Patch "HID: core: Avoid uninitialized buffer
 access" has been added to staging queue
Date: Mon, 30 Nov 2015 12:31:41 +0000
Message-ID: <1448886701-13285-1-git-send-email-luis.henriques@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-team-bounces@lists.ubuntu.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/options/kernel-team>,
 <mailto:kernel-team-request@lists.ubuntu.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/kernel-team>
List-Post: <mailto:kernel-team@lists.ubuntu.com>
List-Help: <mailto:kernel-team-request@lists.ubuntu.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/kernel-team>,
 <mailto:kernel-team-request@lists.ubuntu.com?subject=subscribe>
Errors-To: kernel-team-bounces@lists.ubuntu.com
Sender: kernel-team-bounces@lists.ubuntu.com
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Darren Hart <dvhart@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, kernel-team@lists.ubuntu.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This is a note to let you know that I have just added a patch titled

    HID: core: Avoid uninitialized buffer access

to the linux-3.16.y-queue branch of the 3.16.y-ckt extended stable tree 
which can be found at:

    http://kernel.ubuntu.com/git/ubuntu/linux.git/log/?h=linux-3.16.y-queue

This patch is scheduled to be released in version 3.16.7-ckt21.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.16.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------

>From 2cbc310d70eb6aeb2c8289291f939e612ea5a830 Mon Sep 17 00:00:00 2001
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
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 5ed3a7b91b4c..fb16c812816a 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1561,7 +1561,7 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 		"Multi-Axis Controller"
 	};
 	const char *type, *bus;
-	char buf[64];
+	char buf[64] = "";
 	unsigned int i;
 	int len;
 	int ret;
