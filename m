From: Chris Ball <cjb@laptop.org>
Subject: [PATCH RESEND] USB HID: Add ID for eGalax Multitouch used in JooJoo tablet
Date: Thu, 12 Aug 2010 19:10:50 -0400
Message-ID: <m3hbiz8m11.fsf@pullcord.laptop.org>
References: <m339wl2ug6.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36005 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191Ab0HLXMw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Aug 2010 19:12:52 -0400
In-Reply-To: <m339wl2ug6.fsf@pullcord.laptop.org> (Chris Ball's message of
	"Thu, 17 Jun 2010 17:57:45 -0400")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>

The JooJoo tablet (http://thejoojoo.com/) contains an "eGalax Inc. USB
TouchController", and this patch hooks it up to the egalax-touch driver.
Without the patch we don't get any cursor motion, since it comes through
Z/RX rather than X/Y.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/hid/hid-egalax.c |    2 ++
 drivers/hid/hid-ids.h    |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-egalax.c b/drivers/hid/hid-egalax.c
index f44bdc0..22e3b35 100644
--- a/drivers/hid/hid-egalax.c
+++ b/drivers/hid/hid-egalax.c
@@ -246,6 +246,8 @@ static void egalax_remove(struct hid_device *hdev)
 static const struct hid_device_id egalax_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH1) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, egalax_devices);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 6af77ed..01c3009 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -185,6 +185,7 @@
 #define USB_VENDOR_ID_DWAV		0x0eef
 #define USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER	0x0001
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH	0x480d
+#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH1	0x720c
 
 #define USB_VENDOR_ID_ELO		0x04E7
 #define USB_DEVICE_ID_ELO_TS2700	0x0020
-- 
1.6.6.1

-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
