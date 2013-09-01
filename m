From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] hid: uhid: improve uhid example client
Date: Sun,  1 Sep 2013 23:45:18 +0200
Message-ID: <1378071918-1152-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:55517 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100Ab3IAVps (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Sep 2013 17:45:48 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so1982792eak.32
        for <linux-input@vger.kernel.org>; Sun, 01 Sep 2013 14:45:47 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Anderson Lizardo <anderson.lizardo@openbossa.org>, David Herrmann <dh.herrmann@gmail.com>

This extends the uhid example client. It properly documents the built-in
report-descriptor an adds explicit report-numbers.

Furthermore, LED output reports are added to utilize the new UHID output
reports of the kernel. Support for 3 basic LEDs is added and a small
report-parser to print debug messages if output reports were received.

To test this, simply write the EV_LED+LED_CAPSL+1 event to the evdev
device-node of the uhid-device and the kernel will forward it to your uhid
client.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
Hi Jiri

This is actually the first time that I wrote an HID report-descriptor. The old
3-button mouse was just copied from a real mouse. My descriptor works perfectly
well but I am kind of scared I am no longer allowed to make fun of firmware
authors..

Anyway, I extended the example to have a test-case for uhid output reports and
it all works as expected. I got asked for some help on this so I wrote up this
patch to push it mainline.

Cheers
David

#include <assert.h>
#include <linux/input.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
        int fd, r;
        struct input_event ev;

        assert(argc >= 3);

        fd = open(argv[1], O_RDWR | O_CLOEXEC);
        assert(fd >= 0);

        memset(&ev, 0, sizeof(ev));
        ev.type = EV_LED;
        ev.code = LED_CAPSL;
        ev.value = atoi(argv[2]);

        r = write(fd, &ev, sizeof(ev));
        assert(r == sizeof(ev));

        close(fd);

        return 0;
}

 samples/uhid/uhid-example.c | 123 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 103 insertions(+), 20 deletions(-)

diff --git a/samples/uhid/uhid-example.c b/samples/uhid/uhid-example.c
index 03ce3c0..7d58a4b 100644
--- a/samples/uhid/uhid-example.c
+++ b/samples/uhid/uhid-example.c
@@ -1,14 +1,15 @@
 /*
  * UHID Example
  *
- * Copyright (c) 2012 David Herrmann <dh.herrmann@googlemail.com>
+ * Copyright (c) 2012-2013 David Herrmann <dh.herrmann@gmail.com>
  *
  * The code may be used by anyone for any purpose,
  * and can serve as a starting point for developing
  * applications using uhid.
  */
 
-/* UHID Example
+/*
+ * UHID Example
  * This example emulates a basic 3 buttons mouse with wheel over UHID. Run this
  * program as root and then use the following keys to control the mouse:
  *   q: Quit the application
@@ -22,6 +23,11 @@
  *   r: Move wheel up
  *   f: Move wheel down
  *
+ * Additionally to 3 button mouse, 3 keyboard LEDs are also supported (LED_NUML,
+ * LED_CAPSL and LED_SCROLLL). The device doesn't generate any related keyboard
+ * events, though. You need to manually write the EV_LED/LED_XY/1 activation
+ * input event to the evdev device to see it being sent to this device.
+ *
  * If uhid is not available as /dev/uhid, then you can pass a different path as
  * first argument.
  * If <linux/uhid.h> is not installed in /usr, then compile this with:
@@ -41,11 +47,12 @@
 #include <unistd.h>
 #include <linux/uhid.h>
 
-/* HID Report Desciptor
- * We emulate a basic 3 button mouse with wheel. This is the report-descriptor
- * as the kernel will parse it:
+/*
+ * HID Report Desciptor
+ * We emulate a basic 3 button mouse with wheel and 3 keyboard LEDs. This is
+ * the report-descriptor as the kernel will parse it:
  *
- * INPUT[INPUT]
+ * INPUT(1)[INPUT]
  *   Field(0)
  *     Physical(GenericDesktop.Pointer)
  *     Application(GenericDesktop.Mouse)
@@ -72,6 +79,19 @@
  *     Report Count(3)
  *     Report Offset(8)
  *     Flags( Variable Relative )
+ * OUTPUT(2)[OUTPUT]
+ *   Field(0)
+ *     Application(GenericDesktop.Keyboard)
+ *     Usage(3)
+ *       LED.NumLock
+ *       LED.CapsLock
+ *       LED.ScrollLock
+ *     Logical Minimum(0)
+ *     Logical Maximum(1)
+ *     Report Size(1)
+ *     Report Count(3)
+ *     Report Offset(0)
+ *     Flags( Variable Absolute )
  *
  * This is the mapping that we expect:
  *   Button.0001 ---> Key.LeftBtn
@@ -80,19 +100,59 @@
  *   GenericDesktop.X ---> Relative.X
  *   GenericDesktop.Y ---> Relative.Y
  *   GenericDesktop.Wheel ---> Relative.Wheel
+ *   LED.NumLock ---> LED.NumLock
+ *   LED.CapsLock ---> LED.CapsLock
+ *   LED.ScrollLock ---> LED.ScrollLock
  *
  * This information can be verified by reading /sys/kernel/debug/hid/<dev>/rdesc
  * This file should print the same information as showed above.
  */
 
 static unsigned char rdesc[] = {
-	0x05, 0x01, 0x09, 0x02, 0xa1, 0x01, 0x09, 0x01,
-	0xa1, 0x00, 0x05, 0x09, 0x19, 0x01, 0x29, 0x03,
-	0x15, 0x00, 0x25, 0x01, 0x95, 0x03, 0x75, 0x01,
-	0x81, 0x02, 0x95, 0x01, 0x75, 0x05, 0x81, 0x01,
-	0x05, 0x01, 0x09, 0x30, 0x09, 0x31, 0x09, 0x38,
-	0x15, 0x80, 0x25, 0x7f, 0x75, 0x08, 0x95, 0x03,
-	0x81, 0x06, 0xc0, 0xc0,
+	0x05, 0x01,	/* USAGE_PAGE (Generic Desktop) */
+	0x09, 0x02,	/* USAGE (Mouse) */
+	0xa1, 0x01,	/* COLLECTION (Application) */
+	0x09, 0x01,		/* USAGE (Pointer) */
+	0xa1, 0x00,		/* COLLECTION (Physical) */
+	0x85, 0x01,			/* REPORT_ID (1) */
+	0x05, 0x09,			/* USAGE_PAGE (Button) */
+	0x19, 0x01,			/* USAGE_MINIMUM (Button 1) */
+	0x29, 0x03,			/* USAGE_MAXIMUM (Button 3) */
+	0x15, 0x00,			/* LOGICAL_MINIMUM (0) */
+	0x25, 0x01,			/* LOGICAL_MAXIMUM (1) */
+	0x95, 0x03,			/* REPORT_COUNT (3) */
+	0x75, 0x01,			/* REPORT_SIZE (1) */
+	0x81, 0x02,			/* INPUT (Data,Var,Abs) */
+	0x95, 0x01,			/* REPORT_COUNT (1) */
+	0x75, 0x05,			/* REPORT_SIZE (5) */
+	0x81, 0x01,			/* INPUT (Cnst,Var,Abs) */
+	0x05, 0x01,			/* USAGE_PAGE (Generic Desktop) */
+	0x09, 0x30,			/* USAGE (X) */
+	0x09, 0x31,			/* USAGE (Y) */
+	0x09, 0x38,			/* USAGE (WHEEL) */
+	0x15, 0x81,			/* LOGICAL_MINIMUM (-127) */
+	0x25, 0x7f,			/* LOGICAL_MAXIMUM (127) */
+	0x75, 0x08,			/* REPORT_SIZE (8) */
+	0x95, 0x03,			/* REPORT_COUNT (3) */
+	0x81, 0x06,			/* INPUT (Data,Var,Rel) */
+	0xc0,			/* END_COLLECTION */
+	0xc0,		/* END_COLLECTION */
+	0x05, 0x01,	/* USAGE_PAGE (Generic Desktop) */
+	0x09, 0x06,	/* USAGE (Keyboard) */
+	0xa1, 0x01,	/* COLLECTION (Application) */
+	0x85, 0x02,		/* REPORT_ID (2) */
+	0x05, 0x08,		/* USAGE_PAGE (Led) */
+	0x19, 0x01,		/* USAGE_MINIMUM (1) */
+	0x29, 0x03,		/* USAGE_MAXIMUM (3) */
+	0x15, 0x00,		/* LOGICAL_MINIMUM (0) */
+	0x25, 0x01,		/* LOGICAL_MAXIMUM (1) */
+	0x95, 0x03,		/* REPORT_COUNT (3) */
+	0x75, 0x01,		/* REPORT_SIZE (1) */
+	0x91, 0x02,		/* Output (Data,Var,Abs) */
+	0x95, 0x01,		/* REPORT_COUNT (1) */
+	0x75, 0x05,		/* REPORT_SIZE (5) */
+	0x91, 0x01,		/* Output (Cnst,Var,Abs) */
+	0xc0,		/* END_COLLECTION */
 };
 
 static int uhid_write(int fd, const struct uhid_event *ev)
@@ -140,6 +200,27 @@ static void destroy(int fd)
 	uhid_write(fd, &ev);
 }
 
+/* This parses raw output reports sent by the kernel to the device. A normal
+ * uhid program shouldn't do this but instead just forward the raw report.
+ * However, for ducomentational purposes, we try to detect LED events here and
+ * print debug messages for it. */
+static void handle_output(struct uhid_event *ev)
+{
+	/* LED messages are adverised via OUTPUT reports; ignore the rest */
+	if (ev->u.output.rtype != UHID_OUTPUT_REPORT)
+		return;
+	/* LED reports have length 2 bytes */
+	if (ev->u.output.size != 2)
+		return;
+	/* first byte is report-id which is 0x02 for LEDs in our rdesc */
+	if (ev->u.output.data[0] != 0x2)
+		return;
+
+	/* print flags payload */
+	fprintf(stderr, "LED output report received with flags %x\n",
+		ev->u.output.data[1]);
+}
+
 static int event(int fd)
 {
 	struct uhid_event ev;
@@ -174,6 +255,7 @@ static int event(int fd)
 		break;
 	case UHID_OUTPUT:
 		fprintf(stderr, "UHID_OUTPUT from uhid-dev\n");
+		handle_output(&ev);
 		break;
 	case UHID_OUTPUT_EV:
 		fprintf(stderr, "UHID_OUTPUT_EV from uhid-dev\n");
@@ -198,18 +280,19 @@ static int send_event(int fd)
 
 	memset(&ev, 0, sizeof(ev));
 	ev.type = UHID_INPUT;
-	ev.u.input.size = 4;
+	ev.u.input.size = 5;
 
+	ev.u.input.data[0] = 0x1;
 	if (btn1_down)
-		ev.u.input.data[0] |= 0x1;
+		ev.u.input.data[1] |= 0x1;
 	if (btn2_down)
-		ev.u.input.data[0] |= 0x2;
+		ev.u.input.data[1] |= 0x2;
 	if (btn3_down)
-		ev.u.input.data[0] |= 0x4;
+		ev.u.input.data[1] |= 0x4;
 
-	ev.u.input.data[1] = abs_hor;
-	ev.u.input.data[2] = abs_ver;
-	ev.u.input.data[3] = wheel;
+	ev.u.input.data[2] = abs_hor;
+	ev.u.input.data[3] = abs_ver;
+	ev.u.input.data[4] = wheel;
 
 	return uhid_write(fd, &ev);
 }
-- 
1.8.4

