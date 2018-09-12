From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 02/17] compat_ioctl: move drivers to
 generic_compat_ioctl_ptrarg
Date: Wed, 12 Sep 2018 17:01:03 +0200
Message-ID: <20180912150142.157913-2-arnd@arndb.de>
References: <20180912150142.157913-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180912150142.157913-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: viro@zeniv.linux.org.uk
Cc: kvm@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, virtualization@lists.linux-foundation.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-mtd@lists.infradead.org, Peter Huewe <peterhuewe@gmx.de>, linux1394-devel@lists.sourceforge.net, devel@driverdev.osuosl.org, Jason Gunthorpe <jgg@ziepe.ca>, Marek Vasut <marek.vasut@gmail.com>, linux-input@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>, Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <jikos@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Artem Bityutskiy <dedekind1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stefan Richter <stefanr@s5r6.in-berlin.d>
List-Id: linux-input@vger.kernel.org

Each of these drivers has a copy of the same trivial helper function to
convert the pointer argument and then call the native ioctl handler.

We now have a generic implementation of that, so use it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/ppdev.c              | 12 +---------
 drivers/char/tpm/tpm_vtpm_proxy.c | 12 +---------
 drivers/firewire/core-cdev.c      | 12 +---------
 drivers/hid/usbhid/hiddev.c       | 11 +--------
 drivers/hwtracing/stm/core.c      | 12 +---------
 drivers/misc/mei/main.c           | 22 +----------------
 drivers/mtd/ubi/cdev.c            | 36 +++-------------------------
 drivers/net/tap.c                 | 12 +---------
 drivers/staging/pi433/pi433_if.c  | 12 +---------
 drivers/usb/core/devio.c          | 16 +------------
 drivers/vfio/vfio.c               | 39 +++----------------------------
 drivers/vhost/net.c               | 12 +---------
 drivers/vhost/scsi.c              | 12 +---------
 drivers/vhost/test.c              | 12 +---------
 drivers/vhost/vsock.c             | 12 +---------
 fs/fat/file.c                     | 13 +----------
 16 files changed, 20 insertions(+), 237 deletions(-)

diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index 1ae77b41050a..c38a62457cf0 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -674,14 +674,6 @@ static long pp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
-static long pp_compat_ioctl(struct file *file, unsigned int cmd,
-			    unsigned long arg)
-{
-	return pp_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
-}
-#endif
-
 static int pp_open(struct inode *inode, struct file *file)
 {
 	unsigned int minor = iminor(inode);
@@ -790,9 +782,7 @@ static const struct file_operations pp_fops = {
 	.write		= pp_write,
 	.poll		= pp_poll,
 	.unlocked_ioctl	= pp_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl   = pp_compat_ioctl,
-#endif
+	.compat_ioctl   = generic_compat_ioctl_ptrarg,
 	.open		= pp_open,
 	.release	= pp_release,
 };
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 87a0ce47f201..a170f5ca7416 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -678,20 +678,10 @@ static long vtpmx_fops_ioctl(struct file *f, unsigned int ioctl,
 	}
 }
 
-#ifdef CONFIG_COMPAT
-static long vtpmx_fops_compat_ioctl(struct file *f, unsigned int ioctl,
-					  unsigned long arg)
-{
-	return vtpmx_fops_ioctl(f, ioctl, (unsigned long)compat_ptr(arg));
-}
-#endif
-
 static const struct file_operations vtpmx_fops = {
 	.owner = THIS_MODULE,
 	.unlocked_ioctl = vtpmx_fops_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl = vtpmx_fops_compat_ioctl,
-#endif
+	.compat_ioctl = generic_compat_ioctl_ptrarg,
 	.llseek = noop_llseek,
 };
 
diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index d8e185582642..2acc0c9ddf94 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -1659,14 +1659,6 @@ static long fw_device_op_ioctl(struct file *file,
 	return dispatch_ioctl(file->private_data, cmd, (void __user *)arg);
 }
 
-#ifdef CONFIG_COMPAT
-static long fw_device_op_compat_ioctl(struct file *file,
-				      unsigned int cmd, unsigned long arg)
-{
-	return dispatch_ioctl(file->private_data, cmd, compat_ptr(arg));
-}
-#endif
-
 static int fw_device_op_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct client *client = file->private_data;
@@ -1808,7 +1800,5 @@ const struct file_operations fw_device_ops = {
 	.mmap		= fw_device_op_mmap,
 	.release	= fw_device_op_release,
 	.poll		= fw_device_op_poll,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= fw_device_op_compat_ioctl,
-#endif
+	.compat_ioctl	= generic_compat_ioctl_ptrarg,
 };
diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 23872d08308c..73a168f97024 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -845,13 +845,6 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return r;
 }
 
-#ifdef CONFIG_COMPAT
-static long hiddev_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	return hiddev_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
-}
-#endif
-
 static const struct file_operations hiddev_fops = {
 	.owner =	THIS_MODULE,
 	.read =		hiddev_read,
@@ -861,9 +854,7 @@ static const struct file_operations hiddev_fops = {
 	.release =	hiddev_release,
 	.unlocked_ioctl =	hiddev_ioctl,
 	.fasync =	hiddev_fasync,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= hiddev_compat_ioctl,
-#endif
+	.compat_ioctl	= generic_compat_ioctl_ptrarg,
 	.llseek		= noop_llseek,
 };
 
diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 10bcb5d73f90..3f5cbb948781 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -651,23 +651,13 @@ stm_char_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return err;
 }
 
-#ifdef CONFIG_COMPAT
-static long
-stm_char_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	return stm_char_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
-}
-#else
-#define stm_char_compat_ioctl	NULL
-#endif
-
 static const struct file_operations stm_fops = {
 	.open		= stm_char_open,
 	.release	= stm_char_release,
 	.write		= stm_char_write,
 	.mmap		= stm_char_mmap,
 	.unlocked_ioctl	= stm_char_ioctl,
-	.compat_ioctl	= stm_char_compat_ioctl,
+	.compat_ioctl	= generic_compat_ioctl_ptrarg,
 	.llseek		= no_llseek,
 };
 
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 4d77a6ae183a..a26b645e432f 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -535,24 +535,6 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 	return rets;
 }
 
-/**
- * mei_compat_ioctl - the compat IOCTL function
- *
- * @file: pointer to file structure
- * @cmd: ioctl command
- * @data: pointer to mei message structure
- *
- * Return: 0 on success , <0 on error
- */
-#ifdef CONFIG_COMPAT
-static long mei_compat_ioctl(struct file *file,
-			unsigned int cmd, unsigned long data)
-{
-	return mei_ioctl(file, cmd, (unsigned long)compat_ptr(data));
-}
-#endif
-
-
 /**
  * mei_poll - the poll function
  *
@@ -855,9 +837,7 @@ static const struct file_operations mei_fops = {
 	.owner = THIS_MODULE,
 	.read = mei_read,
 	.unlocked_ioctl = mei_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl = mei_compat_ioctl,
-#endif
+	.compat_ioctl = generic_compat_ioctl_ptrarg,
 	.open = mei_open,
 	.release = mei_release,
 	.write = mei_write,
diff --git a/drivers/mtd/ubi/cdev.c b/drivers/mtd/ubi/cdev.c
index 22547d7a84ea..2aad1da86acc 100644
--- a/drivers/mtd/ubi/cdev.c
+++ b/drivers/mtd/ubi/cdev.c
@@ -1061,36 +1061,6 @@ static long ctrl_cdev_ioctl(struct file *file, unsigned int cmd,
 	return err;
 }
 
-#ifdef CONFIG_COMPAT
-static long vol_cdev_compat_ioctl(struct file *file, unsigned int cmd,
-				  unsigned long arg)
-{
-	unsigned long translated_arg = (unsigned long)compat_ptr(arg);
-
-	return vol_cdev_ioctl(file, cmd, translated_arg);
-}
-
-static long ubi_cdev_compat_ioctl(struct file *file, unsigned int cmd,
-				  unsigned long arg)
-{
-	unsigned long translated_arg = (unsigned long)compat_ptr(arg);
-
-	return ubi_cdev_ioctl(file, cmd, translated_arg);
-}
-
-static long ctrl_cdev_compat_ioctl(struct file *file, unsigned int cmd,
-				   unsigned long arg)
-{
-	unsigned long translated_arg = (unsigned long)compat_ptr(arg);
-
-	return ctrl_cdev_ioctl(file, cmd, translated_arg);
-}
-#else
-#define vol_cdev_compat_ioctl  NULL
-#define ubi_cdev_compat_ioctl  NULL
-#define ctrl_cdev_compat_ioctl NULL
-#endif
-
 /* UBI volume character device operations */
 const struct file_operations ubi_vol_cdev_operations = {
 	.owner          = THIS_MODULE,
@@ -1101,7 +1071,7 @@ const struct file_operations ubi_vol_cdev_operations = {
 	.write          = vol_cdev_write,
 	.fsync		= vol_cdev_fsync,
 	.unlocked_ioctl = vol_cdev_ioctl,
-	.compat_ioctl   = vol_cdev_compat_ioctl,
+	.compat_ioctl   = generic_compat_ioctl_ptrarg,
 };
 
 /* UBI character device operations */
@@ -1109,13 +1079,13 @@ const struct file_operations ubi_cdev_operations = {
 	.owner          = THIS_MODULE,
 	.llseek         = no_llseek,
 	.unlocked_ioctl = ubi_cdev_ioctl,
-	.compat_ioctl   = ubi_cdev_compat_ioctl,
+	.compat_ioctl   = generic_compat_ioctl_ptrarg,
 };
 
 /* UBI control character device operations */
 const struct file_operations ubi_ctrl_cdev_operations = {
 	.owner          = THIS_MODULE,
 	.unlocked_ioctl = ctrl_cdev_ioctl,
-	.compat_ioctl   = ctrl_cdev_compat_ioctl,
+	.compat_ioctl   = generic_compat_ioctl_ptrarg,
 	.llseek		= no_llseek,
 };
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index f0f7cd977667..720deb07f2b4 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1124,14 +1124,6 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 	}
 }
 
-#ifdef CONFIG_COMPAT
-static long tap_compat_ioctl(struct file *file, unsigned int cmd,
-			     unsigned long arg)
-{
-	return tap_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
-}
-#endif
-
 static const struct file_operations tap_fops = {
 	.owner		= THIS_MODULE,
 	.open		= tap_open,
@@ -1141,9 +1133,7 @@ static const struct file_operations tap_fops = {
 	.poll		= tap_poll,
 	.llseek		= no_llseek,
 	.unlocked_ioctl	= tap_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= tap_compat_ioctl,
-#endif
+	.compat_ioctl	= generic_compat_ioctl_ptrarg,
 };
 
 static int tap_sendmsg(struct socket *sock, struct msghdr *m,
diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index c85a805a1243..9e4caf7ad384 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -945,16 +945,6 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	return retval;
 }
 
-#ifdef CONFIG_COMPAT
-static long
-pi433_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
-{
-	return pi433_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
-}
-#else
-#define pi433_compat_ioctl NULL
-#endif /* CONFIG_COMPAT */
-
 /*-------------------------------------------------------------------------*/
 
 static int pi433_open(struct inode *inode, struct file *filp)
@@ -1111,7 +1101,7 @@ static const struct file_operations pi433_fops = {
 	.write =	pi433_write,
 	.read =		pi433_read,
 	.unlocked_ioctl = pi433_ioctl,
-	.compat_ioctl = pi433_compat_ioctl,
+	.compat_ioctl = generic_compat_ioctl_ptrarg,
 	.open =		pi433_open,
 	.release =	pi433_release,
 	.llseek =	no_llseek,
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 6ce77b33da61..269e0befba2d 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -2553,18 +2553,6 @@ static long usbdev_ioctl(struct file *file, unsigned int cmd,
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
-static long usbdev_compat_ioctl(struct file *file, unsigned int cmd,
-			unsigned long arg)
-{
-	int ret;
-
-	ret = usbdev_do_ioctl(file, cmd, compat_ptr(arg));
-
-	return ret;
-}
-#endif
-
 /* No kernel lock - fine */
 static __poll_t usbdev_poll(struct file *file,
 				struct poll_table_struct *wait)
@@ -2588,9 +2576,7 @@ const struct file_operations usbdev_file_operations = {
 	.read =		  usbdev_read,
 	.poll =		  usbdev_poll,
 	.unlocked_ioctl = usbdev_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl =   usbdev_compat_ioctl,
-#endif
+	.compat_ioctl =   generic_compat_ioctl_ptrarg,
 	.mmap =           usbdev_mmap,
 	.open =		  usbdev_open,
 	.release =	  usbdev_release,
diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 64833879f75d..79f08a99602d 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1200,15 +1200,6 @@ static long vfio_fops_unl_ioctl(struct file *filep,
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
-static long vfio_fops_compat_ioctl(struct file *filep,
-				   unsigned int cmd, unsigned long arg)
-{
-	arg = (unsigned long)compat_ptr(arg);
-	return vfio_fops_unl_ioctl(filep, cmd, arg);
-}
-#endif	/* CONFIG_COMPAT */
-
 static int vfio_fops_open(struct inode *inode, struct file *filep)
 {
 	struct vfio_container *container;
@@ -1291,9 +1282,7 @@ static const struct file_operations vfio_fops = {
 	.read		= vfio_fops_read,
 	.write		= vfio_fops_write,
 	.unlocked_ioctl	= vfio_fops_unl_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= vfio_fops_compat_ioctl,
-#endif
+	.compat_ioctl	= generic_compat_ioctl_ptrarg,
 	.mmap		= vfio_fops_mmap,
 };
 
@@ -1572,15 +1561,6 @@ static long vfio_group_fops_unl_ioctl(struct file *filep,
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
-static long vfio_group_fops_compat_ioctl(struct file *filep,
-					 unsigned int cmd, unsigned long arg)
-{
-	arg = (unsigned long)compat_ptr(arg);
-	return vfio_group_fops_unl_ioctl(filep, cmd, arg);
-}
-#endif	/* CONFIG_COMPAT */
-
 static int vfio_group_fops_open(struct inode *inode, struct file *filep)
 {
 	struct vfio_group *group;
@@ -1636,9 +1616,7 @@ static int vfio_group_fops_release(struct inode *inode, struct file *filep)
 static const struct file_operations vfio_group_fops = {
 	.owner		= THIS_MODULE,
 	.unlocked_ioctl	= vfio_group_fops_unl_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= vfio_group_fops_compat_ioctl,
-#endif
+	.compat_ioctl	= generic_compat_ioctl_ptrarg,
 	.open		= vfio_group_fops_open,
 	.release	= vfio_group_fops_release,
 };
@@ -1703,24 +1681,13 @@ static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
 	return device->ops->mmap(device->device_data, vma);
 }
 
-#ifdef CONFIG_COMPAT
-static long vfio_device_fops_compat_ioctl(struct file *filep,
-					  unsigned int cmd, unsigned long arg)
-{
-	arg = (unsigned long)compat_ptr(arg);
-	return vfio_device_fops_unl_ioctl(filep, cmd, arg);
-}
-#endif	/* CONFIG_COMPAT */
-
 static const struct file_operations vfio_device_fops = {
 	.owner		= THIS_MODULE,
 	.release	= vfio_device_fops_release,
 	.read		= vfio_device_fops_read,
 	.write		= vfio_device_fops_write,
 	.unlocked_ioctl	= vfio_device_fops_unl_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= vfio_device_fops_compat_ioctl,
-#endif
+	.compat_ioctl	= generic_compat_ioctl_ptrarg,
 	.mmap		= vfio_device_fops_mmap,
 };
 
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 4e656f89cb22..e9624350f6a5 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1535,14 +1535,6 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 	}
 }
 
-#ifdef CONFIG_COMPAT
-static long vhost_net_compat_ioctl(struct file *f, unsigned int ioctl,
-				   unsigned long arg)
-{
-	return vhost_net_ioctl(f, ioctl, (unsigned long)compat_ptr(arg));
-}
-#endif
-
 static ssize_t vhost_net_chr_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct file *file = iocb->ki_filp;
@@ -1578,9 +1570,7 @@ static const struct file_operations vhost_net_fops = {
 	.write_iter     = vhost_net_chr_write_iter,
 	.poll           = vhost_net_chr_poll,
 	.unlocked_ioctl = vhost_net_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl   = vhost_net_compat_ioctl,
-#endif
+	.compat_ioctl   = generic_compat_ioctl_ptrarg,
 	.open           = vhost_net_open,
 	.llseek		= noop_llseek,
 };
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index c24bb690680b..9180d38de353 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1495,21 +1495,11 @@ vhost_scsi_ioctl(struct file *f,
 	}
 }
 
-#ifdef CONFIG_COMPAT
-static long vhost_scsi_compat_ioctl(struct file *f, unsigned int ioctl,
-				unsigned long arg)
-{
-	return vhost_scsi_ioctl(f, ioctl, (unsigned long)compat_ptr(arg));
-}
-#endif
-
 static const struct file_operations vhost_scsi_fops = {
 	.owner          = THIS_MODULE,
 	.release        = vhost_scsi_release,
 	.unlocked_ioctl = vhost_scsi_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= vhost_scsi_compat_ioctl,
-#endif
+	.compat_ioctl	= generic_compat_ioctl_ptrarg,
 	.open           = vhost_scsi_open,
 	.llseek		= noop_llseek,
 };
diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 40589850eb33..0b185b4712fb 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -298,21 +298,11 @@ static long vhost_test_ioctl(struct file *f, unsigned int ioctl,
 	}
 }
 
-#ifdef CONFIG_COMPAT
-static long vhost_test_compat_ioctl(struct file *f, unsigned int ioctl,
-				   unsigned long arg)
-{
-	return vhost_test_ioctl(f, ioctl, (unsigned long)compat_ptr(arg));
-}
-#endif
-
 static const struct file_operations vhost_test_fops = {
 	.owner          = THIS_MODULE,
 	.release        = vhost_test_release,
 	.unlocked_ioctl = vhost_test_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl   = vhost_test_compat_ioctl,
-#endif
+	.compat_ioctl   = generic_compat_ioctl_ptrarg,
 	.open           = vhost_test_open,
 	.llseek		= noop_llseek,
 };
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 34bc3ab40c6d..83c60f3a9c09 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -699,23 +699,13 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
 	}
 }
 
-#ifdef CONFIG_COMPAT
-static long vhost_vsock_dev_compat_ioctl(struct file *f, unsigned int ioctl,
-					 unsigned long arg)
-{
-	return vhost_vsock_dev_ioctl(f, ioctl, (unsigned long)compat_ptr(arg));
-}
-#endif
-
 static const struct file_operations vhost_vsock_fops = {
 	.owner          = THIS_MODULE,
 	.open           = vhost_vsock_dev_open,
 	.release        = vhost_vsock_dev_release,
 	.llseek		= noop_llseek,
 	.unlocked_ioctl = vhost_vsock_dev_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl   = vhost_vsock_dev_compat_ioctl,
-#endif
+	.compat_ioctl   = generic_compat_ioctl_ptrarg,
 };
 
 static struct miscdevice vhost_vsock_misc = {
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 4f3d72fb1e60..c52c9e9ca36b 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -171,15 +171,6 @@ long fat_generic_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	}
 }
 
-#ifdef CONFIG_COMPAT
-static long fat_generic_compat_ioctl(struct file *filp, unsigned int cmd,
-				      unsigned long arg)
-
-{
-	return fat_generic_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
-}
-#endif
-
 static int fat_file_release(struct inode *inode, struct file *filp)
 {
 	if ((filp->f_mode & FMODE_WRITE) &&
@@ -209,9 +200,7 @@ const struct file_operations fat_file_operations = {
 	.mmap		= generic_file_mmap,
 	.release	= fat_file_release,
 	.unlocked_ioctl	= fat_generic_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= fat_generic_compat_ioctl,
-#endif
+	.compat_ioctl	= generic_compat_ioctl_ptrarg,
 	.fsync		= fat_file_fsync,
 	.splice_read	= generic_file_splice_read,
 	.fallocate	= fat_fallocate,
-- 
2.18.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
