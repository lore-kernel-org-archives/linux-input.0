From: Jesper Juhl <jesper.juhl@gmail.com>
Subject: [PATCH][hid] Fix a NULL pointer dereference when we fail to allocate memory
Date: Sun, 22 Jul 2007 00:06:20 +0200
Message-ID: <200707220006.20359.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Haboustak <mike-@cinci.rr.com>, Andreas Gal <gal@uci.edu>, Vojtech Pavlik <vojtech@suse.cz>, Greg Kroah-Hartman <greg@kroah.com>, linux-input@atrey.karlin.mff.cuni.cz, Jesper Juhl <jesper.juhl@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi,

If, in usb_hid_configure(), we fail to allocate storage for 'usbhid', 
 "if (!(usbhid = kzalloc(sizeof(struct usbhid_device), GFP_KERNEL)))", 
then we'll jump to the 'fail:' label where we have this code:
        usb_free_urb(usbhid->urbin);
        usb_free_urb(usbhid->urbout);
        usb_free_urb(usbhid->urbctrl);
Since we got here because we couldn't allocate storage for 'usbhid', 
what we have here is a NULL pointer dereference - ouch...

This patch solves that little problem by adding a new 
'fail_no_usbhid:' label after the problematic calls to 
usb_free_urb() and jumps to that one instead, in the problem case.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/hid/usbhid/hid-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index b2baeae..3ff7468 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -743,7 +743,7 @@ static struct hid_device *usb_hid_configure(struct usb_interface *intf)
 	hid->quirks = quirks;
 
 	if (!(usbhid = kzalloc(sizeof(struct usbhid_device), GFP_KERNEL)))
-		goto fail;
+		goto fail_no_usbhid;
 
 	hid->driver_data = usbhid;
 	usbhid->hid = hid;
@@ -877,6 +877,7 @@ fail:
 	usb_free_urb(usbhid->urbin);
 	usb_free_urb(usbhid->urbout);
 	usb_free_urb(usbhid->urbctrl);
+fail_no_usbhid:
 	hid_free_buffers(dev, hid);
 	hid_free_device(hid);
 
