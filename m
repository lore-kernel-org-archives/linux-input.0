From: Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] HID: uhid: prevent uhid_char_write() under KERNEL_DS
Date: Wed, 14 Nov 2018 10:02:17 -0800
Message-ID: <20181114180217.195917-1-ebiggers@kernel.org>
References: <20181114171447.GA87768@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181114171447.GA87768@gmail.com>
Sender: stable-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, Dmitry Torokhov <dtor@google.com>, syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com, stable@vger.kernel.org, Jann Horn <jannh@google.com>
List-Id: linux-input@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

When a UHID_CREATE command is written to the uhid char device, a
copy_from_user() is done from a user pointer embedded in the command.
When the address limit is KERNEL_DS, e.g. as is the case during
sendfile(), this can read from kernel memory.  Therefore, UHID_CREATE
must not be allowed in this case.

For consistency and to make sure all current and future uhid commands
are covered, apply the restriction to uhid_char_write() as a whole
rather than to UHID_CREATE specifically.

Thanks to Dmitry Vyukov for adding uhid definitions to syzkaller and to
Jann Horn for commit 9da3f2b740544 ("x86/fault: BUG() when uaccess
helpers fault on kernel addresses"), allowing this bug to be found.

Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
Fixes: d365c6cfd337 ("HID: uhid: add UHID_CREATE and UHID_DESTROY events")
Cc: <stable@vger.kernel.org> # v3.6+
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/hid/uhid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 3c55073136064..e94c5e248b56e 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -705,6 +705,12 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
 	int ret;
 	size_t len;
 
+	if (uaccess_kernel()) { /* payload may contain a __user pointer */
+		pr_err_once("%s: process %d (%s) called from kernel context, this is not allowed.\n",
+			    __func__, task_tgid_vnr(current), current->comm);
+		return -EACCES;
+	}
+
 	/* we need at least the "type" member of uhid_event */
 	if (count < sizeof(__u32))
 		return -EINVAL;
-- 
2.19.1.930.g4563a0d9d0-goog
