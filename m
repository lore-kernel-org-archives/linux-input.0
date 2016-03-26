From: Florian Euchner <florian.euchner@gmail.com>
Subject: [PATCH] Input: CM109: Fix handling of volume and mute buttons
Date: Sat, 26 Mar 2016 21:23:17 +0100
Message-ID: <1459023797-6418-1-git-send-email-florian.euchner@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34335 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615AbcCZUX0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Mar 2016 16:23:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Euchner <florian.euchner@gmail.com>

The CM109 driver reported key press events of volume up / down and
record / playback mute buttons, but release events only as soon as
another button was pressed. Track state of volume buttons in order to
report press and release events properly. For the record and playback
mute buttons, only presses are registered by the CM109, therefore
simulate press-n-release. This fixes the volume control buttons of
various USB headsets.

Signed-off-by: Florian Euchner <florian.euchner@gmail.com>
---

The CM109 datasheet states that bit 0 and 1 of HID_IR0 indicate if
volume up / down have been pressed (1) or released (0). Bits 2 and 3
indicate a press-n-release for playback / record mute, there is no way
to determine when the mute buttons were released.

I contacted Alfred E. Heggestad, the original author of this driver,
but he understandably couldn't comment on this issue as he didn't work
with the CM109 for quite some time. I cannot test this patch with the
original USB phones the CM109 driver was intended for, I don't own one of
those and the CM109 ones (at least those mentioned in the driver) have
become harder to obtain, but I'd be very surprised if this patch didn't
also work with those.

 drivers/input/misc/cm109.c | 69 ++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 24 deletions(-)

diff --git a/drivers/input/misc/cm109.c b/drivers/input/misc/cm109.c
index 9365535..e2c1a80 100644
--- a/drivers/input/misc/cm109.c
+++ b/drivers/input/misc/cm109.c
@@ -76,8 +76,8 @@ enum {
 
 	BUZZER_ON = 1 << 5,
 
-	/* up to 256 normal keys, up to 16 special keys */
-	KEYMAP_SIZE = 256 + 16,
+	/* up to 256 keys on the normal keymap */
+	KEYMAP_SIZE = 256,
 };
 
 /* CM109 protocol packet */
@@ -129,25 +129,14 @@ struct cm109_dev {
 	int key_code;		/* last reported key */
 	int keybit;		/* 0=new scan  1,2,4,8=scan columns  */
 	u8 gpi;			/* Cached value of GPI (high nibble) */
+	bool volup_cached;	/* Cached state of volume up button */
+	bool voldown_cached;	/* Cached state of volume down button */
 };
 
 /******************************************************************************
  * CM109 key interface
  *****************************************************************************/
 
-static unsigned short special_keymap(int code)
-{
-	if (code > 0xff) {
-		switch (code - 0xff) {
-		case RECORD_MUTE:	return KEY_MUTE;
-		case PLAYBACK_MUTE:	return KEY_MUTE;
-		case VOLUME_DOWN:	return KEY_VOLUMEDOWN;
-		case VOLUME_UP:		return KEY_VOLUMEUP;
-		}
-	}
-	return KEY_RESERVED;
-}
-
 /* Map device buttons to internal key events.
  *
  * The "up" and "down" keys, are symbolised by arrows on the button.
@@ -191,7 +180,7 @@ static unsigned short keymap_kip1000(int scancode)
 	case 0x48: return KEY_ESC;			/*   hangup     */
 	case 0x28: return KEY_LEFT;			/*   IN         */
 	case 0x18: return KEY_RIGHT;			/*   OUT        */
-	default:   return special_keymap(scancode);
+	default:   return KEY_RESERVED;
 	}
 }
 
@@ -224,7 +213,7 @@ static unsigned short keymap_gtalk(int scancode)
 	case 0x28: return KEY_ESC;		/* End (red handset) */
 	case 0x48: return KEY_UP;		/* Menu up (rocker switch) */
 	case 0x88: return KEY_DOWN;		/* Menu down (rocker switch) */
-	default:   return special_keymap(scancode);
+	default:   return KEY_RESERVED;
 	}
 }
 
@@ -253,7 +242,7 @@ static unsigned short keymap_usbph01(int scancode)
 	case 0x28: return KEY_ESC;			/*   hangup     */
 	case 0x48: return KEY_LEFT;			/*   IN         */
 	case 0x88: return KEY_RIGHT;			/*   OUT        */
-	default:   return special_keymap(scancode);
+	default:   return KEY_RESERVED;
 	}
 }
 
@@ -284,7 +273,7 @@ static unsigned short keymap_atcom(int scancode)
 	case 0x28: return KEY_ESC;			/*   hangup     */
 	case 0x48: return KEY_LEFT;			/* left arrow   */
 	case 0x88: return KEY_RIGHT;			/* right arrow  */
-	default:   return special_keymap(scancode);
+	default:   return KEY_RESERVED;
 	}
 }
 
@@ -338,9 +327,13 @@ static void cm109_submit_buzz_toggle(struct cm109_dev *dev)
 static void cm109_urb_irq_callback(struct urb *urb)
 {
 	struct cm109_dev *dev = urb->context;
+	struct input_dev *idev = dev->idev;
 	const int status = urb->status;
 	int error;
 
+	bool volup_pressed = !!(dev->irq_data->byte[HID_IR0] & VOLUME_UP);
+	bool voldown_pressed = !!(dev->irq_data->byte[HID_IR0] & VOLUME_DOWN);
+
 	dev_dbg(&dev->intf->dev, "### URB IRQ: [0x%02x 0x%02x 0x%02x 0x%02x] keybit=0x%02x\n",
 	     dev->irq_data->byte[0],
 	     dev->irq_data->byte[1],
@@ -356,13 +349,35 @@ static void cm109_urb_irq_callback(struct urb *urb)
 		goto out;
 	}
 
-	/* Special keys */
-	if (dev->irq_data->byte[HID_IR0] & 0x0f) {
-		const int code = (dev->irq_data->byte[HID_IR0] & 0x0f);
-		report_key(dev, dev->keymap[0xff + code]);
+	/* Report volume up / down button changes */
+	if (volup_pressed != dev->volup_cached) {
+		input_report_key(idev, KEY_VOLUMEUP, volup_pressed);
+		input_sync(idev);
+		dev->volup_cached = volup_pressed;
 	}
 
-	/* Scan key column */
+	if (voldown_pressed != dev->voldown_cached) {
+		input_report_key(idev, KEY_VOLUMEDOWN, voldown_pressed);
+		input_sync(idev);
+		dev->voldown_cached = voldown_pressed;
+	}
+
+	/* Playback / record mute buttons: simulate press-n-release */
+	if (dev->irq_data->byte[HID_IR0] & PLAYBACK_MUTE) {
+		input_report_key(idev, KEY_MUTE, 1);
+		input_sync(idev);
+		input_report_key(idev, KEY_MUTE, 0);
+		input_sync(idev);
+	}
+
+	if (dev->irq_data->byte[HID_IR0] & RECORD_MUTE) {
+		input_report_key(idev, KEY_MICMUTE, 1);
+		input_sync(idev);
+		input_report_key(idev, KEY_MICMUTE, 0);
+		input_sync(idev);
+	}
+
+	/* Normal keymap: Scan key column */
 	if (dev->keybit == 0xf) {
 
 		/* Any changes ? */
@@ -778,6 +793,12 @@ static int cm109_usb_probe(struct usb_interface *intf,
 	}
 	__clear_bit(KEY_RESERVED, input_dev->keybit);
 
+	/* register available special key events */
+	__set_bit(KEY_VOLUMEUP, input_dev->keybit);
+	__set_bit(KEY_VOLUMEDOWN, input_dev->keybit);
+	__set_bit(KEY_MUTE, input_dev->keybit);
+	__set_bit(KEY_MICMUTE, input_dev->keybit);
+
 	error = input_register_device(dev->idev);
 	if (error)
 		goto err_out;
-- 
2.7.4

