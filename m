From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch]aggessive autosuspend for HID devices (resent due to corruption)
Date: Wed, 29 Oct 2008 16:25:20 +0100
Message-ID: <200810291625.21763.oliver@neukum.org>
References: <200810271042.37365.oliver@neukum.org> <alpine.LNX.1.10.0810291425400.12928@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:39284 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbYJ2PZY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Oct 2008 11:25:24 -0400
In-Reply-To: <alpine.LNX.1.10.0810291425400.12928@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, "Yang, Yi Y" <yi.y.yang@intel.com>, Jiri Slaby <jslaby@suse.cz>

Am Mittwoch, 29. Oktober 2008 14:28:12 schrieb Jiri Kosina:
> On Mon, 27 Oct 2008, Oliver Neukum wrote:
> 
> > This uses the USB busy mechanism for aggessive autosuspend of USB HID 
> > devices. It autosuspends all opened devices supporting remote wakeup 
> > after a timeout unless
> > 
> > - output is being done to the device
> > - a key is being held down (remote wakeup isn't triggered upon key release)
> > - LED(s) are lit
> > - hiddev is opened
> 
> Hi Oliver,
> 
> doesn't hidraw (the generic transport-independent variant of 
> USB-specific hiddev) need also some handling?

Hi,

it seems to me to fix this I first need to look at the open method.
As open needs to sleep hidraw was wrong to call it with a spinlock held.
Furthermore, open can of course fail which needs to be handled.

So I changed the spinlock into a mutex, adjusted locking accordingly and
added error checking.
Comments?

	Regards
		Oliver

Signed-off-by: Oliver Neukum <oneukum@suse.de>

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 894d52e..7685ae6 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -38,7 +38,7 @@ static int hidraw_major;
 static struct cdev hidraw_cdev;
 static struct class *hidraw_class;
 static struct hidraw *hidraw_table[HIDRAW_MAX_DEVICES];
-static DEFINE_SPINLOCK(minors_lock);
+static DEFINE_MUTEX(minors_lock);
 
 static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
 {
@@ -159,13 +159,13 @@ static int hidraw_open(struct inode *inode, struct file *file)
 	struct hidraw_list *list;
 	int err = 0;
 
-	lock_kernel();
 	if (!(list = kzalloc(sizeof(struct hidraw_list), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	spin_lock(&minors_lock);
+	lock_kernel();
+	mutex_lock(&minors_lock);
 	if (!hidraw_table[minor]) {
 		printk(KERN_EMERG "hidraw device with minor %d doesn't exist\n",
 				minor);
@@ -180,13 +180,16 @@ static int hidraw_open(struct inode *inode, struct file *file)
 	file->private_data = list;
 
 	dev = hidraw_table[minor];
-	if (!dev->open++)
-		dev->hid->ll_driver->open(dev->hid);
+	if (!dev->open++) {
+		err = dev->hid->ll_driver->open(dev->hid);
+		if (err < 0)
+			dev->open--;
+	}
 
 out_unlock:
-	spin_unlock(&minors_lock);
-out:
+	mutex_unlock(&minors_lock);
 	unlock_kernel();
+out:
 	return err;
 
 }
@@ -310,7 +313,7 @@ int hidraw_connect(struct hid_device *hid)
 
 	result = -EINVAL;
 
-	spin_lock(&minors_lock);
+	mutex_lock(&minors_lock);
 
 	for (minor = 0; minor < HIDRAW_MAX_DEVICES; minor++) {
 		if (hidraw_table[minor])
@@ -320,9 +323,8 @@ int hidraw_connect(struct hid_device *hid)
 		break;
 	}
 
-	spin_unlock(&minors_lock);
-
 	if (result) {
+		mutex_unlock(&minors_lock);
 		kfree(dev);
 		goto out;
 	}
@@ -331,14 +333,14 @@ int hidraw_connect(struct hid_device *hid)
 				 NULL, "%s%d", "hidraw", minor);
 
 	if (IS_ERR(dev->dev)) {
-		spin_lock(&minors_lock);
 		hidraw_table[minor] = NULL;
-		spin_unlock(&minors_lock);
+		mutex_unlock(&minors_lock);
 		result = PTR_ERR(dev->dev);
 		kfree(dev);
 		goto out;
 	}
 
+	mutex_unlock(&minors_lock);
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->list);
 
@@ -360,9 +362,9 @@ void hidraw_disconnect(struct hid_device *hid)
 
 	hidraw->exist = 0;
 
-	spin_lock(&minors_lock);
+	mutex_lock(&minors_lock);
 	hidraw_table[hidraw->minor] = NULL;
-	spin_unlock(&minors_lock);
+	mutex_unlock(&minors_lock);
 
 	device_destroy(hidraw_class, MKDEV(hidraw_major, hidraw->minor));
 


