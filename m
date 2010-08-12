From: Chris Ball <cjb@laptop.org>
Subject: [PATCH RESEND] USB HID: Protect against disconnect/NULL-dereference race
Date: Thu, 12 Aug 2010 19:07:40 -0400
Message-ID: <m3lj8b8m6b.fsf@pullcord.laptop.org>
References: <m3y6ee62gp.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41021 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752911Ab0HLXJf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Aug 2010 19:09:35 -0400
In-Reply-To: <m3y6ee62gp.fsf@pullcord.laptop.org> (Chris Ball's message of
	"Wed, 16 Jun 2010 18:24:06 -0400")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

One of our users reports consistently hitting a NULL dereference that
resolves to the "hid_to_usb_dev(hid);" call in hiddev_ioctl(), when
disconnecting a Lego WeDo USB HID device from an OLPC XO running
Scratch software.  There's a FIXME comment and a guard against the
dereference, but that happens farther down the function than the
initial dereference does.

This patch moves the call to be below the guard, and the user reports
that it fixes the problem for him.  OLPC bug report:
http://dev.laptop.org/ticket/10174

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/hid/usbhid/hiddev.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index c24d2fa..7ec009a 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -593,7 +593,7 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct hiddev_list *list = file->private_data;
 	struct hiddev *hiddev = list->hiddev;
 	struct hid_device *hid = hiddev->hid;
-	struct usb_device *dev = hid_to_usb_dev(hid);
+	struct usb_device *dev;
 	struct hiddev_collection_info cinfo;
 	struct hiddev_report_info rinfo;
 	struct hiddev_field_info finfo;
@@ -607,9 +607,11 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	/* Called without BKL by compat methods so no BKL taken */
 
 	/* FIXME: Who or what stop this racing with a disconnect ?? */
-	if (!hiddev->exist)
+	if (!hiddev->exist || !hid)
 		return -EIO;
 
+	dev = hid_to_usb_dev(hid);
+
 	switch (cmd) {
 
 	case HIDIOCGVERSION:
-- 
1.7.0.1

-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
