From: Jan Kratochvil <honza@jikos.cz>
Subject: [PATCH] [RFC] Added USB_DEVICE_INTERFACE_PROTOCOL
Date: Wed, 2 May 2007 17:03:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705021702040.13550@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Greg Kroah-Hartman <gregkh@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Jiri Kosina <jkosina@suse.cz>, linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The USB_DEVICE_INTERFACE_PROTOCOL will allow to match one interface
protocol of vendor specific device.
This macro is used in patch adding support for xbox360 to xpad.c

Signed-off-by: Jan Kratochvil <honza@jikos.cz>
---
 include/linux/usb.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/linux/usb.h b/include/linux/usb.h
index cfbd2bb..84e2330 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -729,6 +729,21 @@ static inline int usb_endpoint_is_isoc_out(const struct usb_endpoint_descriptor
 	.bcdDevice_lo = (lo), .bcdDevice_hi = (hi)
 
 /**
+ * USB_DEVICE_INTERFACE_PROTOCOL - macro used to describe a usb 
+ *		device with a specific interface protocol
+ * @vend: the 16 bit USB Vendor ID
+ * @prod: the 16 bit USB Product ID
+ * @pr: bInterfaceProtocol value
+ *
+ * This macro is used to create a struct usb_device_id that matches a
+ * specific interface protocol of devices.
+ */
+#define USB_DEVICE_INTERFACE_PROTOCOL(vend,prod,pr) \
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE | USB_DEVICE_ID_MATCH_INT_PROTOCOL, \
+	.idVendor = (vend), \
+	.idProduct = (prod), \
+	.bInterfaceProtocol = (pr)
+/**
  * USB_DEVICE_INFO - macro used to describe a class of usb devices
  * @cl: bDeviceClass value
  * @sc: bDeviceSubClass value
-- 
1.5.0.6



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
