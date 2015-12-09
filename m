From: Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 3.16.y-ckt 015/126] HID: core: Avoid uninitialized buffer
 access
Date: Wed,  9 Dec 2015 09:36:25 +0000
Message-ID: <1449653896-5236-16-git-send-email-luis.henriques@canonical.com>
References: <1449653896-5236-1-git-send-email-luis.henriques@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-team-bounces@lists.ubuntu.com>
In-Reply-To: <1449653896-5236-1-git-send-email-luis.henriques@canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/options/kernel-team>,
 <mailto:kernel-team-request@lists.ubuntu.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/kernel-team>
List-Post: <mailto:kernel-team@lists.ubuntu.com>
List-Help: <mailto:kernel-team-request@lists.ubuntu.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/kernel-team>,
 <mailto:kernel-team-request@lists.ubuntu.com?subject=subscribe>
Errors-To: kernel-team-bounces@lists.ubuntu.com
Sender: kernel-team-bounces@lists.ubuntu.com
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@lists.ubuntu.com
Cc: Jiri Kosina <jkosina@suse.cz>, Darren Hart <dvhart@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, Richard Purdie <richard.purdie@linuxfoundation.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

3.16.7-ckt21 -stable review patch.  If anyone has any objections, please let me know.

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
