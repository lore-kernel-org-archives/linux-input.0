From: Avraham Shukron <avraham.shukron-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] hid: usbhid: usbkbd: fix checkpatch.pl issues
Date: Tue, 21 Feb 2017 19:26:50 +0200
Message-ID: <48d55583-6f2d-cfda-c6dd-0e789f4bf6f1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

- Broke long lines
- Added spaces where needed
- Removed unnecessary / trailing whitespaces
- Extracted assignments outside of 'if' statements

Signed-off-by: Avraham Shukron <avraham.shukron-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/hid/usbhid/usbkbd.c | 121 ++++++++++++++++++++++++++------------------
 1 file changed, 72 insertions(+), 49 deletions(-)

diff --git a/drivers/hid/usbhid/usbkbd.c b/drivers/hid/usbhid/usbkbd.c
index 7fb2d1e..ae40b0d 100644
--- a/drivers/hid/usbhid/usbkbd.c
+++ b/drivers/hid/usbhid/usbkbd.c
@@ -45,22 +45,24 @@ MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");

 static const unsigned char usb_kbd_keycode[256] = {
-	  0,  0,  0,  0, 30, 48, 46, 32, 18, 33, 34, 35, 23, 36, 37, 38,
-	 50, 49, 24, 25, 16, 19, 31, 20, 22, 47, 17, 45, 21, 44,  2,  3,
-	  4,  5,  6,  7,  8,  9, 10, 11, 28,  1, 14, 15, 57, 12, 13, 26,
-	 27, 43, 43, 39, 40, 41, 51, 52, 53, 58, 59, 60, 61, 62, 63, 64,
-	 65, 66, 67, 68, 87, 88, 99, 70,119,110,102,104,111,107,109,106,
-	105,108,103, 69, 98, 55, 74, 78, 96, 79, 80, 81, 75, 76, 77, 71,
-	 72, 73, 82, 83, 86,127,116,117,183,184,185,186,187,188,189,190,
-	191,192,193,194,134,138,130,132,128,129,131,137,133,135,136,113,
-	115,114,  0,  0,  0,121,  0, 89, 93,124, 92, 94, 95,  0,  0,  0,
-	122,123, 90, 91, 85,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	 29, 42, 56,125, 97, 54,100,126,164,166,165,163,161,115,114,113,
-	150,158,159,128,136,177,178,176,142,152,173,140
+	  0,   0,   0,   0,  30,  48,  46,  32,  18,  33,  34,  35,  23,  36,
+	 37,  38,  50,  49,  24,  25,  16,  19,  31,  20,  22,  47,  17,  45,
+	 21,  44,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  28,   1,
+	 14,  15,  57,  12,  13,  26,  27,  43,  43,  39,  40,  41,  51,  52,
+	 53,  58,  59,  60,  61,  62,  63,  64,  65,  66,  67,  68,  87,  88,
+	 99,  70, 119, 110, 102, 104, 111, 107, 109, 106, 105, 108, 103,  69,
+	 98,  55,  74,  78,  96,  79,  80,  81,  75,  76,  77,  71,  72,  73,
+	 82,  83,  86, 127, 116, 117, 183, 184, 185, 186, 187, 188, 189, 190,
+	191, 192, 193, 194, 134, 138, 130, 132, 128, 129, 131, 137, 133, 135,
+	136, 113, 115, 114,   0,   0,   0, 121,   0,  89,  93, 124,  92,  94,
+	 95,   0,   0,   0, 122, 123,  90,  91,  85,   0,   0,   0,   0,   0,
+	  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
+	  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
+	  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
+	  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
+	  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
+	 29,  42,  56, 125,  97,  54, 100, 126, 164, 166, 165, 163, 161, 115,
+	114, 113, 150, 158, 159, 128, 136, 177, 178, 176, 142, 152, 173, 140
 };


@@ -75,7 +77,7 @@ static const unsigned char usb_kbd_keycode[256] = {
  *		new key is pressed or a key that was pressed is released.
  * @led:	URB for sending LEDs (e.g. numlock, ...)
  * @newleds:	data that will be sent with the @led URB representing which LEDs
- 		should be on
+ *		should be on
  * @name:	Name of the keyboard. @dev's name field points to this buffer
  * @phys:	Physical path of the keyboard. @dev's phys field points to this
  *		buffer
@@ -103,7 +105,7 @@ struct usb_kbd {
 	unsigned char *leds;
 	dma_addr_t new_dma;
 	dma_addr_t leds_dma;
-	
+
 	spinlock_t leds_lock;
 	bool led_urb_submitted;

@@ -127,22 +129,30 @@ static void usb_kbd_irq(struct urb *urb)
 	}

 	for (i = 0; i < 8; i++)
-		input_report_key(kbd->dev, usb_kbd_keycode[i + 224], (kbd->new[0] >> i) & 1);
+		input_report_key(kbd->dev,
+			usb_kbd_keycode[i + 224],
+			(kbd->new[0] >> i) & 1);

 	for (i = 2; i < 8; i++) {

-		if (kbd->old[i] > 3 && memscan(kbd->new + 2, kbd->old[i], 6) == kbd->new + 8) {
+		if (kbd->old[i] > 3 &&
+		    memscan(kbd->new + 2, kbd->old[i], 6) == kbd->new + 8) {
 			if (usb_kbd_keycode[kbd->old[i]])
-				input_report_key(kbd->dev, usb_kbd_keycode[kbd->old[i]], 0);
+				input_report_key(
+					kbd->dev,
+					usb_kbd_keycode[kbd->old[i]], 0
+				);
 			else
 				hid_info(urb->dev,
 					 "Unknown key (scancode %#x) released.\n",
 					 kbd->old[i]);
 		}

-		if (kbd->new[i] > 3 && memscan(kbd->old + 2, kbd->new[i], 6) == kbd->old + 8) {
+		if (kbd->new[i] > 3 &&
+		    memscan(kbd->old + 2, kbd->new[i], 6) == kbd->old + 8) {
 			if (usb_kbd_keycode[kbd->new[i]])
-				input_report_key(kbd->dev, usb_kbd_keycode[kbd->new[i]], 1);
+				input_report_key(kbd->dev,
+					usb_kbd_keycode[kbd->new[i]], 1);
 			else
 				hid_info(urb->dev,
 					 "Unknown key (scancode %#x) pressed.\n",
@@ -155,9 +165,10 @@ static void usb_kbd_irq(struct urb *urb)
 	memcpy(kbd->old, kbd->new, 8);

 resubmit:
-	i = usb_submit_urb (urb, GFP_ATOMIC);
+	i = usb_submit_urb(urb, GFP_ATOMIC);
 	if (i)
-		hid_err(urb->dev, "can't resubmit intr, %s-%s/input0, status %d",
+		hid_err(urb->dev,
+			"can't resubmit intr, %s-%s/input0, status %d",
 			kbd->usbdev->bus->bus_name,
 			kbd->usbdev->devpath, i);
 }
@@ -172,30 +183,32 @@ static int usb_kbd_event(struct input_dev *dev, unsigned int type,
 		return -1;

 	spin_lock_irqsave(&kbd->leds_lock, flags);
-	kbd->newleds = (!!test_bit(LED_KANA,    dev->led) << 3) | (!!test_bit(LED_COMPOSE, dev->led) << 3) |
-		       (!!test_bit(LED_SCROLLL, dev->led) << 2) | (!!test_bit(LED_CAPSL,   dev->led) << 1) |
-		       (!!test_bit(LED_NUML,    dev->led));
+	kbd->newleds =	(!!test_bit(LED_KANA,    dev->led) << 3) |
+			(!!test_bit(LED_COMPOSE, dev->led) << 3) |
+			(!!test_bit(LED_SCROLLL, dev->led) << 2) |
+			(!!test_bit(LED_CAPSL,   dev->led) << 1) |
+			(!!test_bit(LED_NUML,    dev->led));

-	if (kbd->led_urb_submitted){
+	if (kbd->led_urb_submitted) {
 		spin_unlock_irqrestore(&kbd->leds_lock, flags);
 		return 0;
 	}

-	if (*(kbd->leds) == kbd->newleds){
+	if (*(kbd->leds) == kbd->newleds) {
 		spin_unlock_irqrestore(&kbd->leds_lock, flags);
 		return 0;
 	}

 	*(kbd->leds) = kbd->newleds;
-	
+
 	kbd->led->dev = kbd->usbdev;
 	if (usb_submit_urb(kbd->led, GFP_ATOMIC))
 		pr_err("usb_submit_urb(leds) failed\n");
 	else
 		kbd->led_urb_submitted = true;
-	
+
 	spin_unlock_irqrestore(&kbd->leds_lock, flags);
-	
+
 	return 0;
 }

@@ -210,21 +223,21 @@ static void usb_kbd_led(struct urb *urb)

 	spin_lock_irqsave(&kbd->leds_lock, flags);

-	if (*(kbd->leds) == kbd->newleds){
+	if (*(kbd->leds) == kbd->newleds) {
 		kbd->led_urb_submitted = false;
 		spin_unlock_irqrestore(&kbd->leds_lock, flags);
 		return;
 	}

 	*(kbd->leds) = kbd->newleds;
-	
+
 	kbd->led->dev = kbd->usbdev;
-	if (usb_submit_urb(kbd->led, GFP_ATOMIC)){
+	if (usb_submit_urb(kbd->led, GFP_ATOMIC)) {
 		hid_err(urb->dev, "usb_submit_urb(leds) failed\n");
 		kbd->led_urb_submitted = false;
 	}
 	spin_unlock_irqrestore(&kbd->leds_lock, flags);
-	
+
 }

 static int usb_kbd_open(struct input_dev *dev)
@@ -247,15 +260,24 @@ static void usb_kbd_close(struct input_dev *dev)

 static int usb_kbd_alloc_mem(struct usb_device *dev, struct usb_kbd *kbd)
 {
-	if (!(kbd->irq = usb_alloc_urb(0, GFP_KERNEL)))
+	kbd->irq = usb_alloc_urb(0, GFP_KERNEL);
+	if (!(kbd->irq))
 		return -1;
-	if (!(kbd->led = usb_alloc_urb(0, GFP_KERNEL)))
+
+	kbd->led = usb_alloc_urb(0, GFP_KERNEL);
+	if (!(kbd->led))
 		return -1;
-	if (!(kbd->new = usb_alloc_coherent(dev, 8, GFP_ATOMIC, &kbd->new_dma)))
+
+	kbd->new = usb_alloc_coherent(dev, 8, GFP_ATOMIC, &kbd->new_dma);
+	if (!(kbd->new))
 		return -1;
-	if (!(kbd->cr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_KERNEL)))
+
+	kbd->cr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_KERNEL);
+	if (!(kbd->cr))
 		return -1;
-	if (!(kbd->leds = usb_alloc_coherent(dev, 1, GFP_ATOMIC, &kbd->leds_dma)))
+
+	kbd->leds = usb_alloc_coherent(dev, 1, GFP_ATOMIC, &kbd->leds_dma);
+	if (!(kbd->leds))
 		return -1;

 	return 0;
@@ -370,9 +392,9 @@ static int usb_kbd_probe(struct usb_interface *iface,
 	device_set_wakeup_enable(&dev->dev, 1);
 	return 0;

-fail2:	
+fail2:
 	usb_kbd_free_mem(dev, kbd);
-fail1:	
+fail1:
 	input_free_device(input_dev);
 	kfree(kbd);
 	return error;
@@ -380,7 +402,7 @@ static int usb_kbd_probe(struct usb_interface *iface,

 static void usb_kbd_disconnect(struct usb_interface *intf)
 {
-	struct usb_kbd *kbd = usb_get_intfdata (intf);
+	struct usb_kbd *kbd = usb_get_intfdata(intf);

 	usb_set_intfdata(intf, NULL);
 	if (kbd) {
@@ -392,13 +414,14 @@ static void usb_kbd_disconnect(struct usb_interface *intf)
 	}
 }

-static struct usb_device_id usb_kbd_id_table [] = {
-	{ USB_INTERFACE_INFO(USB_INTERFACE_CLASS_HID, USB_INTERFACE_SUBCLASS_BOOT,
+static struct usb_device_id usb_kbd_id_table[] = {
+	{ USB_INTERFACE_INFO(USB_INTERFACE_CLASS_HID,
+		USB_INTERFACE_SUBCLASS_BOOT,
 		USB_INTERFACE_PROTOCOL_KEYBOARD) },
-	{ }						/* Terminating entry */
+	{ }		/* Terminating entry */
 };

-MODULE_DEVICE_TABLE (usb, usb_kbd_id_table);
+MODULE_DEVICE_TABLE(usb, usb_kbd_id_table);

 static struct usb_driver usb_kbd_driver = {
 	.name =		"usbkbd",
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
