From: Dan Carpenter <error27-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [patch 1/2] usbhid: use after free
Date: Thu, 26 May 2011 11:49:16 +0300
Message-ID: <20110526084916.GD14591@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

There are a couple use after free bugs here.

Signed-off-by: Dan Carpenter <error27-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Compile tested only.  Please review carefully.

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index ff3c644..b2f9a3a 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -248,12 +248,15 @@ static int hiddev_release(struct inode * inode, struct file * file)
 			usbhid_close(list->hiddev->hid);
 			usbhid_put_power(list->hiddev->hid);
 		} else {
+			mutex_unlock(&list->hiddev->existancelock);
 			kfree(list->hiddev);
+			kfree(list);
+			return 0;
 		}
 	}
 
-	kfree(list);
 	mutex_unlock(&list->hiddev->existancelock);
+	kfree(list);
 
 	return 0;
 }
@@ -926,7 +929,9 @@ void hiddev_disconnect(struct hid_device *hid)
 		usbhid_close(hiddev->hid);
 		wake_up_interruptible(&hiddev->wait);
 	} else {
+		mutex_unlock(&hiddev->existancelock);
 		kfree(hiddev);
+		return;
 	}
 	mutex_unlock(&hiddev->existancelock);
 }
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
