From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] HID: uhid: prevent splice(2)
Date: Wed, 14 Nov 2018 14:07:12 +0100
Message-ID: <20181114130712.21028-1-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com, David Herrmann <dh.herrmann@gmail.com>
List-Id: linux-input@vger.kernel.org

The kernel has a default implementation of splice(2) for writing from a
pipe into an arbitrary file. This behavior can be overriden by
providing an f_op.splice_write() callback.

Unfortunately, the default implementation of splice_write() takes page
by page from the source pipe, calls kmap() and passes the mapped page
as kernel-address to f_op.write(). Thus, it uses standard write(2) to
implement splice(2). However, since the page is kernel-mapped, they
have to `set_fs(get_ds())`. This is mostly fine, but UHID takes
command-streams through write(2), and thus it might interpret the data
taken as pointers. If called with KERNEL_DS, you can trick UHID to
allow kernel-space pointers as well.

As a simple fix, prevent splice(2) on UHID. It is unsecure, but it is
also non-functional. We need a linear mapping of the input in UHID, so
chunked input from splice(2) makes no sense, anyway.

Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/uhid.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 3c5507313606..fefedc0b4dc6 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -753,6 +753,15 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
 	return ret ? ret : count;
 }
 
+static ssize_t uhid_char_splice_write(struct pipe_inode_info *pipe,
+				      struct file *out,
+				      loff_t *ppos,
+				      size_t len,
+				      unsigned int flags)
+{
+	return -EOPNOTSUPP;
+}
+
 static __poll_t uhid_char_poll(struct file *file, poll_table *wait)
 {
 	struct uhid_device *uhid = file->private_data;
@@ -771,6 +780,7 @@ static const struct file_operations uhid_fops = {
 	.release	= uhid_char_release,
 	.read		= uhid_char_read,
 	.write		= uhid_char_write,
+	.splice_write	= uhid_char_splice_write,
 	.poll		= uhid_char_poll,
 	.llseek		= no_llseek,
 };
-- 
2.19.1
