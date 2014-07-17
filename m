From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH] HID: rmi: only bind the hid-rmi driver to the mouse interface of composite USB devices
Date: Thu, 17 Jul 2014 16:14:45 -0700
Message-ID: <1405638885-8014-2-git-send-email-aduggan@synaptics.com>
References: <1405638885-8014-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405638885-8014-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On composite HID devices there may be multiple HID devices on separate interfaces, but hid-rmi
should only bind to the mouse interface. One example is the Dell Venue 11 Pro's keyboard dock
which contains a composite USB device with a HID touchpad and HID keyboard on separate intefaces.
Since the USB Vendor ID is Synaptic's, hid-core is currently trying to bind hid-rmi to all\of
the HID devices. This patch ensures that hid-rmi only binds to the mouse interface.

related bug:
https://bugzilla.kernel.org/show_bug.cgi?id=80091

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/hid/hid-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8ed66fd..f10e768 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -783,7 +783,9 @@ static int hid_scan_report(struct hid_device *hid)
 	* Vendor specific handlings
 	*/
 	if ((hid->vendor == USB_VENDOR_ID_SYNAPTICS) &&
-	    (hid->group == HID_GROUP_GENERIC))
+	    (hid->group == HID_GROUP_GENERIC) &&
+	    /* only bind to the mouse interface of composite USB devices */
+	    (hid->bus != BUS_USB || hid->type == HID_TYPE_USBMOUSE))
 		/* hid-rmi should take care of them, not hid-generic */
 		hid->group = HID_GROUP_RMI;
 
-- 
1.9.1
