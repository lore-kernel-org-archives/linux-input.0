From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [patch] HID: hiddev: potential info leak in hiddev_ioctl()
Date: Fri, 23 Sep 2011 09:21:13 +0300
Message-ID: <20110923062113.GE4387@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Smatch has a new check for Rosenberg type information leaks where
structs are copied to the user with uninitialized stack data in them.

In this case, the hiddev_devinfo struct has a two byte hole.

struct hiddev_devinfo {
        __u32                      bustype;              /*     0     4 */
        __u32                      busnum;               /*     4     4 */
        __u32                      devnum;               /*     8     4 */
        __u32                      ifnum;                /*    12     4 */
        __s16                      vendor;               /*    16     2 */
        __s16                      product;              /*    18     2 */
        __s16                      version;              /*    20     2 */

        /* XXX 2 bytes hole, try to pack */

        __u32                      num_applications;     /*    24     4 */

Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 7c1188b..4ef02b2 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -641,6 +641,8 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			struct usb_device *dev = hid_to_usb_dev(hid);
 			struct usbhid_device *usbhid = hid->driver_data;
 
+			memset(&dinfo, 0, sizeof(dinfo));
+
 			dinfo.bustype = BUS_USB;
 			dinfo.busnum = dev->bus->busnum;
 			dinfo.devnum = dev->devnum;
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
