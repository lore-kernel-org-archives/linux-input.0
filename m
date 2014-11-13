From: Benson Leung <bleung@chromium.org>
Subject: [PATCH v2] HID: usbhid: clear needs_remote_wakeup before usb_kill_urb
Date: Thu, 13 Nov 2014 13:25:17 -0800
Message-ID: <1415913917-15370-1-git-send-email-bleung@chromium.org>
References: <1415909806-23848-1-git-send-email-bleung@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415909806-23848-1-git-send-email-bleung@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, johan@kernel.org, jkosina@suse.cz, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: snanda@chromium.org, Benson Leung <bleung@chromium.org>
List-Id: linux-input@vger.kernel.org

usbhid->intf->needs_remote_wakeup is set when a device is
opened, and is cleared when a device is closed.

When a usbhid device that does not support remote wake
( i.e. !device_can_wakeup() ) is closed, we fail out of
autosuspend_check() because the autosuspend check is called
before the flag is cleared as a result of usb_kill_urb(usbhid->urbin);

The result is that a device that may otherwise autosuspend will
fail to enter suspend again after all handles to it are closed.

Clear the flag first before usb_kill_urb, which may result in a
autosuspend_check().

Signed-off-by: Benson Leung <bleung@chromium.org>
---
 drivers/hid/usbhid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 04e34b9..ca66ad7 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -734,8 +734,8 @@ void usbhid_close(struct hid_device *hid)
 		spin_unlock_irq(&usbhid->lock);
 		hid_cancel_delayed_stuff(usbhid);
 		if (!(hid->quirks & HID_QUIRK_ALWAYS_POLL)) {
-			usb_kill_urb(usbhid->urbin);
 			usbhid->intf->needs_remote_wakeup = 0;
+			usb_kill_urb(usbhid->urbin);
 		}
 	} else {
 		spin_unlock_irq(&usbhid->lock);
-- 
2.1.0.rc2.206.gedb03e5
