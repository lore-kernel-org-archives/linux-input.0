From: Bogicevic Sasa <brutallesale@gmail.com>
Subject: [PATCH] drivers:hid:usbhid Fix ERROR: "foo * bar" should be "foo *bar"
Date: Tue, 17 Nov 2015 17:33:40 +0100
Message-ID: <1447778020-16494-1-git-send-email-brutallesale@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Bogicevic Sasa <brutallesale@gmail.com>
List-Id: linux-input@vger.kernel.org

This fixes all errors from checkpatch.pl about that
"foo * bar" should be "foo *bar"

Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>
---
 drivers/hid/usbhid/hiddev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 2f1ddca..c781d1d 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -234,7 +234,7 @@ static int hiddev_fasync(int fd, struct file *file, int on)
 /*
  * release file op
  */
-static int hiddev_release(struct inode * inode, struct file * file)
+static int hiddev_release(struct inode *inode, struct file *file)
 {
 	struct hiddev_list *list = file->private_data;
 	unsigned long flags;
@@ -330,7 +330,7 @@ bail:
 /*
  * "write" file op
  */
-static ssize_t hiddev_write(struct file * file, const char __user * buffer, size_t count, loff_t *ppos)
+static ssize_t hiddev_write(struct file *file, const char __user *buffer, size_t count, loff_t *ppos)
 {
 	return -EINVAL;
 }
@@ -338,7 +338,7 @@ static ssize_t hiddev_write(struct file * file, const char __user * buffer, size
 /*
  * "read" file op
  */
-static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t count, loff_t *ppos)
+static ssize_t hiddev_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
 {
 	DEFINE_WAIT(wait);
 	struct hiddev_list *list = file->private_data;
-- 
2.1.4
