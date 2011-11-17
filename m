From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 1/3] HID: usbhid: remove LED_ON
Date: Thu, 17 Nov 2011 19:23:48 +0800
Message-ID: <1321529030-7845-2-git-send-email-djkurtz@chromium.org>
References: <1321529030-7845-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1321529030-7845-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz, oneukum@suse.de, bleung@chromium.org
Cc: stern@rowland.harvard.edu, olofj@chromium.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-input@vger.kernel.org

LED_ON was defined in the original version of the hid-core autosuspend patch.
However, during review, the setting and clearing of it was redone
using ledcount.  The test was left in accidentally.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/hid/usbhid/hid-core.c |   10 ----------
 drivers/hid/usbhid/usbhid.h   |    1 -
 2 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index b403fce..6606134 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1367,16 +1367,6 @@ static int hid_suspend(struct usb_interface *intf, pm_message_t message)
 			return -EIO;
 	}
 
-	if (!ignoreled && PMSG_IS_AUTO(message)) {
-		spin_lock_irq(&usbhid->lock);
-		if (test_bit(HID_LED_ON, &usbhid->iofl)) {
-			spin_unlock_irq(&usbhid->lock);
-			usbhid_mark_busy(usbhid);
-			return -EBUSY;
-		}
-		spin_unlock_irq(&usbhid->lock);
-	}
-
 	hid_cancel_delayed_stuff(usbhid);
 	hid_cease_io(usbhid);
 
diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
index 1673cac..2d8957c 100644
--- a/drivers/hid/usbhid/usbhid.h
+++ b/drivers/hid/usbhid/usbhid.h
@@ -55,7 +55,6 @@ struct usb_interface *usbhid_find_interface(int minor);
 #define HID_STARTED		8
 #define HID_REPORTED_IDLE	9
 #define HID_KEYS_PRESSED	10
-#define HID_LED_ON		11
 
 /*
  * USB-specific HID struct, to be pointed to
-- 
1.7.3.1
