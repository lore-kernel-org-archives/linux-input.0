From: akpm@linux-foundation.org
Subject: [patch 1/3] ati_remote: add some missing devices from lirc_atiusb
Date: Tue, 27 Apr 2010 14:12:37 -0700
Message-ID: <201004272112.o3RLCciJ020082@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32796 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756142Ab0D0VRJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Apr 2010 17:17:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, jarod@redhat.com, nm127@freemail.hu

From: Jarod Wilson <jarod@redhat.com>

The (out-of-tree) lirc_atiusb driver has a much longer list of devices it
supports.  Some of them look like they may just be guesses at possible
device IDs, but a few are definitely confirmed devices.  This adds the
nVidia-branded RF receiver and the X10 Lola Wireless Video Sender device
(which contains an RF receiver) to the list of devices in ati_remote.

Signed-off-by: Jarod Wilson <jarod@redhat.com>
Cc: <nm127@freemail.hu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/misc/ati_remote.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff -puN drivers/input/misc/ati_remote.c~ati_remote-add-some-missing-devices-from-lirc_atiusb drivers/input/misc/ati_remote.c
--- a/drivers/input/misc/ati_remote.c~ati_remote-add-some-missing-devices-from-lirc_atiusb
+++ a/drivers/input/misc/ati_remote.c
@@ -98,10 +98,12 @@
  * Module and Version Information, Module Parameters
  */
 
-#define ATI_REMOTE_VENDOR_ID	0x0bc7
-#define ATI_REMOTE_PRODUCT_ID	0x004
-#define LOLA_REMOTE_PRODUCT_ID	0x002
-#define MEDION_REMOTE_PRODUCT_ID 0x006
+#define ATI_REMOTE_VENDOR_ID		0x0bc7
+#define LOLA_REMOTE_PRODUCT_ID		0x0002
+#define LOLA2_REMOTE_PRODUCT_ID		0x0003
+#define ATI_REMOTE_PRODUCT_ID		0x0004
+#define NVIDIA_REMOTE_PRODUCT_ID	0x0005
+#define MEDION_REMOTE_PRODUCT_ID	0x0006
 
 #define DRIVER_VERSION	        "2.2.1"
 #define DRIVER_AUTHOR           "Torrey Hoffman <thoffman@arnor.net>"
@@ -142,8 +144,10 @@ MODULE_PARM_DESC(repeat_delay, "Delay be
 #define err(format, arg...) printk(KERN_ERR format , ## arg)
 
 static struct usb_device_id ati_remote_table[] = {
-	{ USB_DEVICE(ATI_REMOTE_VENDOR_ID, ATI_REMOTE_PRODUCT_ID) },
 	{ USB_DEVICE(ATI_REMOTE_VENDOR_ID, LOLA_REMOTE_PRODUCT_ID) },
+	{ USB_DEVICE(ATI_REMOTE_VENDOR_ID, LOLA2_REMOTE_PRODUCT_ID) },
+	{ USB_DEVICE(ATI_REMOTE_VENDOR_ID, ATI_REMOTE_PRODUCT_ID) },
+	{ USB_DEVICE(ATI_REMOTE_VENDOR_ID, NVIDIA_REMOTE_PRODUCT_ID) },
 	{ USB_DEVICE(ATI_REMOTE_VENDOR_ID, MEDION_REMOTE_PRODUCT_ID) },
 	{}	/* Terminating entry */
 };
_
