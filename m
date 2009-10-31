From: James Mastros <james@mastros.biz>
Subject: [rfc] xbox360 Big-button controller support for xpad.c, take 3
Date: Sat, 31 Oct 2009 20:05:38 +0000
Message-ID: <abc933c50910311305t20da8da8p46d1a0692f914a9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:61390 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933202AbZJaUFe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Oct 2009 16:05:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, free60-devel@vger.kernel.org

Third time's the charm; I've now included the patch inline, rather
then as an attachment, as I've been advised is the preference on the
vger.kernel.org lists.  I've also added free60-devel@vger.kernel.org
to the to list.

Hello, all,

The attached (RFC!) patch adds support for the xbox 360 big-button
controllers to xpad.c.  These seem to be a set of four large CIR
remote controls, with a USB receiver that speaks a modified version of
the normal xbox360 usb remote protocol.

http://en.wikipedia.org/wiki/Xbox_360_accessories#Big_Button_Pad has a
decent image.  You can get a set for about 12GBP, including a game
disk for Scene It (which I haven't even removed the shrink-wrap for,
since I don't actually own a 360).  The reverse-engeneering work is
original here, but it's not terribly complicated -- each input packet
is the constant bytes 0x00 05, followed by a single byte controller
number (0..3), and the button status in two bytes.

There are, however, a few complications that I'd like advice on:

1. Like most CIR sorts of thing, it never gives an all-buttons-off
report, and will give multiple reports for the same combinations of
buttons.

The buttons are all non-overlaping bitmaps, and I see no reason,
other then the physical impossibility of pressing the left and right
buttons at the same time without removing parts of the controller, for
multiple button-presses not to work.

That means that a naive implementation will never generate key-up
events.  Currently, each of the native repeats generates a key down
followed by a key-up, which isn't really ideal either.  Ideally, it'd
create a key-down when the first report happens, and then create a
key-up when a report with a different set comes in, or the next
expected repeat fails to happen.

I did find some code that I could copy-and-paste to implement that in
drivers/input/misc/winbond-cir.c - wbcir_keyup, but it feels to me
like it should be somewhere generic / libraryish.  Is it there,
somewhere I couldn't find it, or should I just copy-and-paste?

2. Another niggle is that the current code simply ignores the "which
controller is this report for" field, so userspace can't tell which of
the four controllers is pressing the button.

This rather mucks up both the origional point, and my use-case, where
each controller (which is a different colour so you can tell them
apart) belongs to a different user.  The right way to do that is to
present them to the input layer as four different devices each of
which has the same set of buttons, but that'd require, I think, some
fairly large changes to the xpad.c infrastructure.

Does the wisdom of the list think I should just abandon xpad.c, and
split this off into it's own driver?  I'm not sure how well that'd
mesh with the way detection is done, but then again, I'm not really
sure how detection is done generally.

  Thank you for your advice,
  -=- James Mastros

CUT

 diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 79e3edc..17e71e2 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -94,6 +94,7 @@
 #define XTYPE_XBOX360     1
 #define XTYPE_XBOX360W    2
 #define XTYPE_UNKNOWN     3
+#define XTYPE_XBOX360BB   4

 static int dpad_to_buttons;
 module_param(dpad_to_buttons, bool, S_IRUGO);
@@ -147,6 +148,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x028e, "Microsoft X-Box 360 pad", MAP_DPAD_TO_AXES,
XTYPE_XBOX360 },
 	{ 0x1bad, 0x0003, "Harmonix Rock Band Drumkit", MAP_DPAD_TO_BUTTONS,
XTYPE_XBOX360 },
 	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", MAP_DPAD_TO_AXES,
XTYPE_XBOX },
+	{ 0x045e, 0x02a0, "Microsoft X-Box 360 Big Button IR reciever",
MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360BB },
 	{ 0x0000, 0x0000, "Generic X-Box pad", MAP_DPAD_UNKNOWN, XTYPE_UNKNOWN }
 };

@@ -192,7 +194,9 @@ static const signed short xpad_abs_pad[] = {
 /* Xbox 360 has a vendor-specific class, so we cannot match it with only
  * USB_INTERFACE_INFO (also specifically refused by USB subsystem), so we
  * match against vendor id as well. Wired Xbox 360 devices have protocol 1,
- * wireless controllers have protocol 129. */
+ * wireless controllers have protocol 129, and big button controllers
+ * have protocol 4.
+ */
 #define XPAD_XBOX360_VENDOR_PROTOCOL(vend,pr) \
 	.match_flags = USB_DEVICE_ID_MATCH_VENDOR | USB_DEVICE_ID_MATCH_INT_INFO, \
 	.idVendor = (vend), \
@@ -201,7 +205,8 @@ static const signed short xpad_abs_pad[] = {
 	.bInterfaceProtocol = (pr)
 #define XPAD_XBOX360_VENDOR(vend) \
 	{ XPAD_XBOX360_VENDOR_PROTOCOL(vend,1) }, \
-	{ XPAD_XBOX360_VENDOR_PROTOCOL(vend,129) }
+	{ XPAD_XBOX360_VENDOR_PROTOCOL(vend,129) },	\
+	{ XPAD_XBOX360_VENDOR_PROTOCOL(vend,4) }

 static struct usb_device_id xpad_table [] = {
 	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* X-Box USB-IF not approved class */
@@ -407,6 +412,98 @@ static void xpad360w_process_packet(struct
usb_xpad *xpad, u16 cmd, unsigned cha
 	xpad360_process_packet(xpad, cmd, &data[4]);
 }

+/* xpad360bb_momentary_press
+ *
+ * Just a little utility routine, to momentarily press a button.
+ */
+static void xpad360bb_momentary_press(struct input_dev *dev, int
button, int val) {
+	input_report_key(dev, button, val);
+	if (val) {
+		input_report_key(dev, button, 0);
+	}
+}
+
+/*
+ * xpad360bb_process_packet
+ *
+ * Completes a request by converting the data into events for the
+ * input subsystem.  It is a version for the xbox 360 big-button
+ * controller, as shipped with the Scene It series of games.
+ *
+ * This is original reverse-engeneering work.
+ */
+
+static void xpad360bb_process_packet(struct usb_xpad *xpad,
+				     u16 cmd, unsigned char *data) {
+	struct input_dev *dev = xpad->dev;
+	
+	printk("cmd=%d, data=%x %x %x %x %x\n", cmd,
+	       data[0], data[1], data[2], data[3], data[4]);
+	/* Protocol is as follows:
+	 * cmd=0, data=0 5 ct ab cd
+	 * 0 and 5 seem to be constant.  It might specify the length
+	 * of the report.
+	 * ct specifies what controller, 0=green, 1=red, 2=blue, 3=yellow
+	 * ab is serveral keys for that controller:
+         * 0x01: up.
+	 * 0x02: down.
+	 * 0x04: left.
+	 * 0x08: right.
+	 * 0x10: start.
+	 * 0x20: back.
+	 * cd is several more:
+	 * 0x08: centre (buzzer)
+	 * 0x04: big x (logo, mode)
+	 * 0x10: A
+	 * 0x20: B
+	 * 0x40: X
+	 * 0x80: Y
+	 *
+	 * ...and that's all the buttons there are.
+	 *
+	 * Only presses are reported, not releases -- that is, there
+	 * will never be a report with all zeroes.  OTOH, it will
+	 * report multiple times if you hold down a button.  Ideally,
+	 * we'd have some sort of timeout mechanism such that we
+	 * notice that the next repeat event doesn't happen, and thus
+	 * the key must have been released (or we went out of range).
+	 * Instead, for now, we just report everything as a press
+	 * followed immediately by a release, and let the native
+	 * repeat repeat.
+	 */
+
+	/* The code below doesn't allow userspace to tell which
+	 * controler is being used.  FIXME! */
+	
+	/* dpad as four buttons... */
+	xpad360bb_momentary_press(dev, BTN_LEFT,  data[3] & 0x04);
+	xpad360bb_momentary_press(dev, BTN_RIGHT, data[3] & 0x08);
+	xpad360bb_momentary_press(dev, BTN_0,     data[3] & 0x01); /* up */
+	xpad360bb_momentary_press(dev, BTN_1,     data[3] & 0x02); /* down */
+	
+	/* This is the only button that is rather novel vs the normal
+	 * controller.  The corsponding bit for the normal controllers
+	 * isn't used, as far as I can see.  It's like the thumb
+	 * buttons, so call it the right one, randomly.
+	 * (Normally the thumb button goes with an analog stick, not a dpad.)
+	 */
+	xpad360bb_momentary_press(dev, BTN_THUMBR,    data[4] & 0x08);
+
+	/* start/back buttons */
+	xpad360bb_momentary_press(dev, BTN_START, data[3] & 0x10);
+	xpad360bb_momentary_press(dev, BTN_BACK,  data[3] & 0x20);
+
+	/* buttons A,B,X,Y,TL,TR and MODE */
+	xpad360bb_momentary_press(dev, BTN_A,	 data[4] & 0x10);
+	xpad360bb_momentary_press(dev, BTN_B,	 data[4] & 0x20);
+	xpad360bb_momentary_press(dev, BTN_X,	 data[4] & 0x40);
+	xpad360bb_momentary_press(dev, BTN_Y,	 data[4] & 0x80);
+	xpad360bb_momentary_press(dev, BTN_MODE, data[4] & 0x04);
+
+	
+	input_sync(dev);
+}
+
 static void xpad_irq_in(struct urb *urb)
 {
 	struct usb_xpad *xpad = urb->context;
@@ -438,6 +535,9 @@ static void xpad_irq_in(struct urb *urb)
 	case XTYPE_XBOX360W:
 		xpad360w_process_packet(xpad, 0, xpad->idata);
 		break;
+	case XTYPE_XBOX360BB:
+		xpad360bb_process_packet(xpad, 0, xpad->idata);
+		break;
 	default:
 		xpad_process_packet(xpad, 0, xpad->idata);
 	}
@@ -728,6 +828,11 @@ static int xpad_probe(struct usb_interface *intf,
const struct usb_device_id *id
 	int i;
 	int error = -ENOMEM;

+	printk("xpad_probe vendor=0x%x, product=0x%x\n",
+	       le16_to_cpu(udev->descriptor.idVendor),
+	       le16_to_cpu(udev->descriptor.idProduct)
+		);
+
 	for (i = 0; xpad_device[i].idVendor; i++) {
 		if ((le16_to_cpu(udev->descriptor.idVendor) == xpad_device[i].idVendor) &&
 		    (le16_to_cpu(udev->descriptor.idProduct) == xpad_device[i].idProduct))
