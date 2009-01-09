From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: second race in hiddev
Date: Fri, 9 Jan 2009 11:21:55 +0100
Message-ID: <200901091121.56576.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

upon further thought this code is still racy.

	retval = usb_register_dev(usbhid->intf, &hiddev_class);

here you open a window during which open can happen

	if (retval) {
		err_hid("Not able to get a minor for this device.");
		hid->hiddev = NULL;
		kfree(hiddev);
		return -1;
	} else {
		hid->minor = usbhid->intf->minor;
		hiddev_table[usbhid->intf->minor - HIDDEV_MINOR_BASE] = hiddev;

and will fail because hiddev_table hasn't been updated
	}

The obvious fix of using a mutex to guard hiddev_table doesn't work because
usb_open() and usb_register_dev() take minor_rwsem and we'd have an AB-BA
deadlock. We need a lock usb_open() also takes in the right order and that leaves
only one option, BKL. I don't like it but I see no alternative.

	Regards
		Oliver

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>

---

@@ -878,16 +878,19 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
 	hiddev->hid = hid;
 	hiddev->exist = 1;
 
+	lock_kernel();
 	retval = usb_register_dev(usbhid->intf, &hiddev_class);
 	if (retval) {
 		err_hid("Not able to get a minor for this device.");
 		hid->hiddev = NULL;
+		unlock_kernel();
 		kfree(hiddev);
 		return -1;
 	} else {
 		hid->minor = usbhid->intf->minor;
 		hiddev_table[usbhid->intf->minor - HIDDEV_MINOR_BASE] = hiddev;
 	}
+	unlock_kernel();
 
 	return 0;
 }
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
