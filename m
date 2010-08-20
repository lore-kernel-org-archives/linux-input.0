From: Dan Carpenter <error27-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: re: HID: hiddev: protect against disconnect/NULL-dereference race
Date: Fri, 20 Aug 2010 23:24:14 +0200
Message-ID: <20100820212413.GE6674@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

The patch 7032269e87a "HID: hiddev: protect against
disconnect/NULL-dereference race" added a check to make sure that "hid"
was non-NULL.  The problem is that it added the check after "hid" had
already been dereferenced.

drivers/hid/usbhid/hiddev.c +606 hiddev_ioctl(19)
	warn: variable dereferenced before check 'hid'

   599          struct usbhid_device *usbhid = hid->driver_data;
                                               ^^^^^^^^^^^^^^^^
	dereferenced here.

   600          void __user *user_arg = (void __user *)arg;
   601          int i, r;
   602          
   603          /* Called without BKL by compat methods so no BKL taken */
   604  
   605          /* FIXME: Who or what stop this racing with a disconnect ?? */
   606          if (!hiddev->exist || !hid)
                                      ^^^^
	new check added here.

   607                  return -EIO;

So obviously in hind-sight this patch didn't fix the user's problem.  
Also the user reported a NULL dereference, yes, but the stack dump which
says: "BUG: unable to handle kernel paging request at 6b6b6b6b" is a use
after free bug and that isn't addressed by adding a check for NULL.

I am just looking at this because it showed up with my static checker
and I'm not very familiar with this code.  I think we need to take 
"hiddev->existancelock" and make sure that exist is true before we 
dereference hiddev in the ioctl function?  Also it seems like there
should probably be some locking in hiddev_release().

regards,
dan carpenter

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
