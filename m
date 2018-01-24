From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH 1/2] input: usbtouchscreen: fix deadlock in autosuspend
Date: Wed, 24 Jan 2018 16:47:12 +0100
Message-ID: <20180124154713.28962-1-marcus.folkesson@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

usb_autopm_get_interface() that is called in usbtouch_open() does an
autoresume if the device is suspended.

input_dev->mutex used in usbtouch_resume() is in this case already
taken by the input subsystem and will cause a deadlock.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/input/touchscreen/usbtouchscreen.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 2c41107240de..e964658203d8 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -54,6 +54,7 @@
 #include <linux/usb.h>
 #include <linux/usb/input.h>
 #include <linux/hid.h>
+#include <linux/mutex.h>
 
 
 #define DRIVER_VERSION		"v0.6"
@@ -112,6 +113,7 @@ struct usbtouch_usb {
 	struct usb_interface *interface;
 	struct input_dev *input;
 	struct usbtouch_device_info *type;
+	struct mutex pm_mutex;  /* serialize access to open/suspend */
 	char name[128];
 	char phys[64];
 	void *priv;
@@ -1455,6 +1457,7 @@ static int usbtouch_open(struct input_dev *input)
 	if (r < 0)
 		goto out;
 
+	mutex_lock(&usbtouch->pm_mutex);
 	if (!usbtouch->type->irq_always) {
 		if (usb_submit_urb(usbtouch->irq, GFP_KERNEL)) {
 			r = -EIO;
@@ -1464,6 +1467,7 @@ static int usbtouch_open(struct input_dev *input)
 
 	usbtouch->interface->needs_remote_wakeup = 1;
 out_put:
+	mutex_unlock(&usbtouch->pm_mutex);
 	usb_autopm_put_interface(usbtouch->interface);
 out:
 	return r;
@@ -1474,8 +1478,11 @@ static void usbtouch_close(struct input_dev *input)
 	struct usbtouch_usb *usbtouch = input_get_drvdata(input);
 	int r;
 
+	mutex_lock(&usbtouch->pm_mutex);
 	if (!usbtouch->type->irq_always)
 		usb_kill_urb(usbtouch->irq);
+	mutex_lock(&usbtouch->pm_mutex);
+
 	r = usb_autopm_get_interface(usbtouch->interface);
 	usbtouch->interface->needs_remote_wakeup = 0;
 	if (!r)
@@ -1498,10 +1505,10 @@ static int usbtouch_resume(struct usb_interface *intf)
 	struct input_dev *input = usbtouch->input;
 	int result = 0;
 
-	mutex_lock(&input->mutex);
+	mutex_lock(&usbtouch->pm_mutex);
 	if (input->users || usbtouch->type->irq_always)
 		result = usb_submit_urb(usbtouch->irq, GFP_NOIO);
-	mutex_unlock(&input->mutex);
+	mutex_unlock(&usbtouch->pm_mutex);
 
 	return result;
 }
@@ -1524,10 +1531,10 @@ static int usbtouch_reset_resume(struct usb_interface *intf)
 	}
 
 	/* restart IO if needed */
-	mutex_lock(&input->mutex);
+	mutex_lock(&usbtouch->pm_mutex);
 	if (input->users)
 		err = usb_submit_urb(usbtouch->irq, GFP_NOIO);
-	mutex_unlock(&input->mutex);
+	mutex_unlock(&usbtouch->pm_mutex);
 
 	return err;
 }
-- 
2.15.1
