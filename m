From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] hiddev: compat_ptr() returns a void *
Date: Wed, 31 Oct 2007 14:51:53 +1100
Message-ID: <20071031145153.30f9d3dd.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: linux-input@atrey.karlin.mff.cuni.cz, linux-usb-devel@lists.sourceforge.net
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

so cast it to unsigned long before passing it to hiddev_ioctl.

This gets rid of:

drivers/hid/usbhid/hiddev.c: In function 'hiddev_compat_ioctl':
drivers/hid/usbhid/hiddev.c:746: warning: passing argument 4 of 'hiddev_ioctl' makes integer from pointer without a cast

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/hid/usbhid/hiddev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 9837adc..5fc4019 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -743,7 +743,7 @@ inval:
 static long hiddev_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file->f_path.dentry->d_inode;
-	return hiddev_ioctl(inode, file, cmd, compat_ptr(arg));
+	return hiddev_ioctl(inode, file, cmd, (unsigned long)compat_ptr(arg));
 }
 #endif
 
-- 
1.5.3.4


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
