From: "johann deneux" <johann.deneux@gmail.com>
Subject: Re: [PATCH] iforce: Use usb_kill_urb instead of usb_unlink_urb.
Date: Mon, 19 Mar 2007 21:49:26 +0100
Message-ID: <38b3b7c0703191349s7d0cfa17yd8a2c55207f3dd14@mail.gmail.com>
References: <38b3b7c0703171439n10025a7bx55a588911eb765d6@mail.gmail.com>
	 <38b3b7c0703171443j2f50f913r76ab111ba7ed109f@mail.gmail.com>
	 <200703191218.40780.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_137408_10852671.1174337366175"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200703191218.40780.dtor@insightbb.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

------=_Part_137408_10852671.1174337366175
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

New attempt... Also attached it if the inlined patched gets corrupted.

commit 0ba8785483c2ee7f56e8f242e000f6cd17a7da40
Author: Johann Deneux <johann.deneux@gmail.com>
Date:   Sat Mar 17 22:23:44 2007 +0100

    iforce: Use usb_kill_urb instead of usb_unlink_urb.

    Using usb_unlink_urb can cause iforce_open to fail when called
soon after iforce_release.
    Also updated my email address and replaced calls to printk() by
dbg(), warn(), info(), err()...

    Signed-off-by: Johann Deneux <johann.deneux@gmail.com>

diff --git a/drivers/input/joystick/iforce/iforce-ff.c
b/drivers/input/joystick/iforce/iforce-ff.c
index 8fb0c19..f2a4381 100644
--- a/drivers/input/joystick/iforce/iforce-ff.c
+++ b/drivers/input/joystick/iforce/iforce-ff.c
@@ -2,7 +2,7 @@
  * $Id: iforce-ff.c,v 1.9 2002/02/02 19:28:35 jdeneux Exp $
  *
  *  Copyright (c) 2000-2002 Vojtech Pavlik <vojtech@ucw.cz>
- *  Copyright (c) 2001-2002 Johann Deneux <deneux@ifrance.com>
+ *  Copyright (c) 2001-2002, 2007 Johann Deneux <johann.deneux@gmail.com>
  *
  *  USB/RS232 I-Force joysticks and wheels.
  */
@@ -205,7 +205,7 @@ static int need_condition_modifier(struct
ff_effect *old, struct ff_effect *new)
 	int i;

 	if (new->type != FF_SPRING && new->type != FF_FRICTION) {
-		printk(KERN_WARNING "iforce.c: bad effect type in
need_condition_modifier\n");
+		warn("bad effect type in need_condition_modifier");
 		return 0;
 	}

@@ -227,7 +227,7 @@ static int need_condition_modifier(struct
ff_effect *old, struct ff_effect *new)
 static int need_magnitude_modifier(struct ff_effect *old, struct
ff_effect *effect)
 {
 	if (effect->type != FF_CONSTANT) {
-		printk(KERN_WARNING "iforce.c: bad effect type in need_envelope_modifier\n");
+		warn("bad effect type in need_envelope_modifier");
 		return 0;
 	}

@@ -258,7 +258,7 @@ static int need_envelope_modifier(struct ff_effect
*old, struct ff_effect *effec
 		break;

 	default:
-		printk(KERN_WARNING "iforce.c: bad effect type in need_envelope_modifier\n");
+		warn("bad effect type in need_envelope_modifier");
 	}

 	return 0;
@@ -271,7 +271,7 @@ static int need_envelope_modifier(struct ff_effect
*old, struct ff_effect *effec
 static int need_period_modifier(struct ff_effect *old, struct ff_effect *new)
 {
 	if (new->type != FF_PERIODIC) {
-		printk(KERN_WARNING "iforce.c: bad effect type in need_period_modifier\n");
+		warn("bad effect type in need_period_modifier");
 		return 0;
 	}
 	return (old->u.periodic.period != new->u.periodic.period
diff --git a/drivers/input/joystick/iforce/iforce-main.c
b/drivers/input/joystick/iforce/iforce-main.c
index 3393a37..bd5a6de 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -2,7 +2,7 @@
  * $Id: iforce-main.c,v 1.19 2002/07/07 10:22:50 jdeneux Exp $
  *
  *  Copyright (c) 2000-2002 Vojtech Pavlik <vojtech@ucw.cz>
- *  Copyright (c) 2001-2002 Johann Deneux <deneux@ifrance.com>
+ *  Copyright (c) 2001-2002, 2007 Johann Deneux <johann.deneux@gmail.com>
  *
  *  USB/RS232 I-Force joysticks and wheels.
  */
@@ -29,7 +29,7 @@

 #include "iforce.h"

-MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>, Johann Deneux
<deneux@ifrance.com>");
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>, Johann Deneux
<johann.deneux@gmail.com>");
 MODULE_DESCRIPTION("USB/RS232 I-Force joysticks and wheels driver");
 MODULE_LICENSE("GPL");

@@ -220,7 +220,7 @@ static void iforce_release(struct input_dev *dev)
 		/* Check: no effects should be present in memory */
 		for (i = 0; i < dev->ff->max_effects; i++) {
 			if (test_bit(FF_CORE_IS_USED, iforce->core_effects[i].flags)) {
-				printk(KERN_WARNING "iforce_release: Device still owns effects\n");
+				warn("iforce_release: Device still owns effects");
 				break;
 			}
 		}
@@ -232,7 +232,7 @@ static void iforce_release(struct input_dev *dev)
 	switch (iforce->bus) {
 #ifdef CONFIG_JOYSTICK_IFORCE_USB
 		case IFORCE_USB:
-			usb_unlink_urb(iforce->irq);
+			usb_kill_urb(iforce->irq);

 			/* The device was unplugged before the file
 			 * was released */
@@ -324,7 +324,7 @@ int iforce_init_device(struct iforce *iforce)
 			break;

 	if (i == 20) { /* 5 seconds */
-		printk(KERN_ERR "iforce-main.c: Timeout waiting for response from
device.\n");
+		err("Timeout waiting for response from device.");
 		error = -ENODEV;
 		goto fail;
 	}
@@ -336,26 +336,26 @@ int iforce_init_device(struct iforce *iforce)
 	if (!iforce_get_id_packet(iforce, "M"))
 		input_dev->id.vendor = (iforce->edata[2] << 8) | iforce->edata[1];
 	else
-		printk(KERN_WARNING "iforce-main.c: Device does not respond to id
packet M\n");
+		warn("Device does not respond to id packet M");

 	if (!iforce_get_id_packet(iforce, "P"))
 		input_dev->id.product = (iforce->edata[2] << 8) | iforce->edata[1];
 	else
-		printk(KERN_WARNING "iforce-main.c: Device does not respond to id
packet P\n");
+		warn("Device does not respond to id packet P");

 	if (!iforce_get_id_packet(iforce, "B"))
 		iforce->device_memory.end = (iforce->edata[2] << 8) | iforce->edata[1];
 	else
-		printk(KERN_WARNING "iforce-main.c: Device does not respond to id
packet B\n");
+		warn("Device does not respond to id packet B");

 	if (!iforce_get_id_packet(iforce, "N"))
 		ff_effects = iforce->edata[1];
 	else
-		printk(KERN_WARNING "iforce-main.c: Device does not respond to id
packet N\n");
+		warn("Device does not respond to id packet N");

 	/* Check if the device can store more effects than the driver can
really handle */
 	if (ff_effects > IFORCE_EFFECTS_MAX) {
-		printk(KERN_WARNING "iforce: Limiting number of effects to %d
(device reports %d)\n",
+		warn("Limiting number of effects to %d (device reports %d)",
 		       IFORCE_EFFECTS_MAX, ff_effects);
 		ff_effects = IFORCE_EFFECTS_MAX;
 	}
@@ -457,8 +457,6 @@ int iforce_init_device(struct iforce *iforce)
 	if (error)
 		goto fail;

-	printk(KERN_DEBUG "iforce->dev->open = %p\n", iforce->dev->open);
-
 	return 0;

  fail:	input_free_device(input_dev);
diff --git a/drivers/input/joystick/iforce/iforce-packets.c
b/drivers/input/joystick/iforce/iforce-packets.c
index 808f059..21c4e13 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -2,7 +2,7 @@
  * $Id: iforce-packets.c,v 1.16 2002/07/07 10:22:50 jdeneux Exp $
  *
  *  Copyright (c) 2000-2002 Vojtech Pavlik <vojtech@ucw.cz>
- *  Copyright (c) 2001-2002 Johann Deneux <deneux@ifrance.com>
+ *  Copyright (c) 2001-2002, 2007 Johann Deneux <johann.deneux@gmail.com>
  *
  *  USB/RS232 I-Force joysticks and wheels.
  */
@@ -39,10 +39,10 @@ void iforce_dump_packet(char *msg, u16 cmd,
unsigned char *data)
 {
 	int i;

-	printk(KERN_DEBUG "iforce.c: %s ( cmd = %04x, data = ", msg, cmd);
+	printk(KERN_DEBUG __FILE__ ": %s cmd = %04x, data = ", msg, cmd);
 	for (i = 0; i < LO(cmd); i++)
 		printk("%02x ", data[i]);
-	printk(")\n");
+	printk("\n");
 }

 /*
@@ -65,8 +65,9 @@ int iforce_send_packet(struct iforce *iforce, u16
cmd, unsigned char* data)
 	head = iforce->xmit.head;
 	tail = iforce->xmit.tail;

+
 	if (CIRC_SPACE(head, tail, XMIT_SIZE) < n+2) {
-		printk(KERN_WARNING "iforce.c: not enough space in xmit buffer to
send new packet\n");
+		warn("not enough space in xmit buffer to send new packet");
 		spin_unlock_irqrestore(&iforce->xmit_lock, flags);
 		return -1;
 	}
@@ -126,8 +127,6 @@ int iforce_control_playback(struct iforce* iforce,
u16 id, unsigned int value)
 {
 	unsigned char data[3];

-printk(KERN_DEBUG "iforce-packets.c: control_playback %d %d\n", id, value);
-
 	data[0] = LO(id);
 	data[1] = (value > 0) ? ((value > 1) ? 0x41 : 0x01) : 0;
 	data[2] = LO(value);
@@ -151,7 +150,7 @@ static int mark_core_as_ready(struct iforce
*iforce, unsigned short addr)
 			return 0;
 		}
 	}
-	printk(KERN_WARNING "iforce-packets.c: unused effect %04x updated
!!!\n", addr);
+	warn("unused effect %04x updated !!!", addr);
 	return -1;
 }

@@ -162,7 +161,7 @@ void iforce_process_packet(struct iforce *iforce,
u16 cmd, unsigned char *data)
 	static int being_used = 0;

 	if (being_used)
-		printk(KERN_WARNING "iforce-packets.c: re-entrant call to
iforce_process %d\n", being_used);
+		warn("re-entrant call to iforce_process %d", being_used);
 	being_used++;

 #ifdef CONFIG_JOYSTICK_IFORCE_232
@@ -266,7 +265,7 @@ int iforce_get_id_packet(struct iforce *iforce,
char *packet)
 			return -1;
 		}
 #else
-		printk(KERN_ERR "iforce_get_id_packet: iforce->bus = USB!\n");
+		err("iforce_get_id_packet: iforce->bus = USB!");
 #endif
 		break;

@@ -284,13 +283,12 @@ int iforce_get_id_packet(struct iforce *iforce,
char *packet)
 			return -1;
 		}
 #else
-		printk(KERN_ERR "iforce_get_id_packet: iforce->bus = SERIO!\n");
+		err("iforce_get_id_packet: iforce->bus = SERIO!");
 #endif
 		break;

 	default:
-		printk(KERN_ERR "iforce_get_id_packet: iforce->bus = %d\n",
-		       iforce->bus);
+		err("iforce_get_id_packet: iforce->bus = %d", iforce->bus);
 		break;
 	}

diff --git a/drivers/input/joystick/iforce/iforce-serio.c
b/drivers/input/joystick/iforce/iforce-serio.c
index ec4be53..7b4bc19 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -2,7 +2,7 @@
  * $Id: iforce-serio.c,v 1.4 2002/01/28 22:45:00 jdeneux Exp $
  *
  *  Copyright (c) 2000-2001 Vojtech Pavlik <vojtech@ucw.cz>
- *  Copyright (c) 2001 Johann Deneux <deneux@ifrance.com>
+ *  Copyright (c) 2001, 2007 Johann Deneux <johann.deneux@gmail.com>
  *
  *  USB/RS232 I-Force joysticks and wheels.
  */
diff --git a/drivers/input/joystick/iforce/iforce-usb.c
b/drivers/input/joystick/iforce/iforce-usb.c
index 80cdebc..750099d 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -2,7 +2,7 @@
  * $Id: iforce-usb.c,v 1.16 2002/06/09 11:08:04 jdeneux Exp $
  *
  *  Copyright (c) 2000-2002 Vojtech Pavlik <vojtech@ucw.cz>
- *  Copyright (c) 2001-2002 Johann Deneux <deneux@ifrance.com>
+ *  Copyright (c) 2001-2002, 2007 Johann Deneux <johann.deneux@gmail.com>
  *
  *  USB/RS232 I-Force joysticks and wheels.
  */
@@ -65,7 +65,7 @@ void iforce_usb_xmit(struct iforce *iforce)
 	XMIT_INC(iforce->xmit.tail, n);

 	if ( (n=usb_submit_urb(iforce->out, GFP_ATOMIC)) ) {
-		printk(KERN_WARNING "iforce-usb.c: iforce_usb_xmit: usb_submit_urb
failed %d\n", n);
+		warn("usb_submit_urb failed %d\n", n);
 	}

 	/* The IFORCE_XMIT_RUNNING bit is not cleared here. That's intended.
@@ -110,7 +110,7 @@ static void iforce_usb_out(struct urb *urb)
 	struct iforce *iforce = urb->context;

 	if (urb->status) {
-		printk(KERN_DEBUG "iforce_usb_out: urb->status %d, exiting", urb->status);
+		dbg("urb->status %d, exiting", urb->status);
 		return;
 	}

@@ -190,10 +190,9 @@ fail:
 /* Called by iforce_delete() */
 void iforce_usb_delete(struct iforce* iforce)
 {
-	usb_unlink_urb(iforce->irq);
-/* Is it ok to unlink those ? */
-	usb_unlink_urb(iforce->out);
-	usb_unlink_urb(iforce->ctrl);
+	usb_kill_urb(iforce->irq);
+	usb_kill_urb(iforce->out);
+	usb_kill_urb(iforce->ctrl);

 	usb_free_urb(iforce->irq);
 	usb_free_urb(iforce->out);
diff --git a/drivers/input/joystick/iforce/iforce.h
b/drivers/input/joystick/iforce/iforce.h
index ffaeaef..dadcf4f 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -2,7 +2,7 @@
  * $Id: iforce.h,v 1.13 2002/07/07 10:22:50 jdeneux Exp $
  *
  *  Copyright (c) 2000-2002 Vojtech Pavlik <vojtech@ucw.cz>
- *  Copyright (c) 2001-2002 Johann Deneux <deneux@ifrance.com>
+ *  Copyright (c) 2001-2002, 2007 Johann Deneux <johann.deneux@gmail.com>
  *
  *  USB/RS232 I-Force joysticks and wheels.
  */

------=_Part_137408_10852671.1174337366175
Content-Type: application/octet-stream; name=patch-2007-03-17
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ezhe3lbq
Content-Disposition: attachment; filename="patch-2007-03-17"

Y29tbWl0IDBiYTg3ODU0ODNjMmVlN2Y1NmU4ZjI0MmUwMDBmNmNkMTdhN2RhNDAKQXV0aG9yOiBK
b2hhbm4gRGVuZXV4IDxqb2hhbm4uZGVuZXV4QGdtYWlsLmNvbT4KRGF0ZTogICBTYXQgTWFyIDE3
IDIyOjIzOjQ0IDIwMDcgKzAxMDAKCiAgICBpZm9yY2U6IFVzZSB1c2Jfa2lsbF91cmIgaW5zdGVh
ZCBvZiB1c2JfdW5saW5rX3VyYi4KICAgIAogICAgVXNpbmcgdXNiX3VubGlua191cmIgY2FuIGNh
dXNlIGlmb3JjZV9vcGVuIHRvIGZhaWwgd2hlbiBjYWxsZWQgc29vbiBhZnRlciBpZm9yY2VfcmVs
ZWFzZS4KICAgIEFsc28gdXBkYXRlZCBteSBlbWFpbCBhZGRyZXNzIGFuZCByZXBsYWNlZCBjYWxs
cyB0byBwcmludGsoKSBieSBkYmcoKSwgd2FybigpLCBpbmZvKCksIGVycigpLi4uCiAgICAKICAg
IFNpZ25lZC1vZmYtYnk6IEpvaGFubiBEZW5ldXggPGpvaGFubi5kZW5ldXhAZ21haWwuY29tPgoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQvam95c3RpY2svaWZvcmNlL2lmb3JjZS1mZi5jIGIv
ZHJpdmVycy9pbnB1dC9qb3lzdGljay9pZm9yY2UvaWZvcmNlLWZmLmMKaW5kZXggOGZiMGMxOS4u
ZjJhNDM4MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9pbnB1dC9qb3lzdGljay9pZm9yY2UvaWZvcmNl
LWZmLmMKKysrIGIvZHJpdmVycy9pbnB1dC9qb3lzdGljay9pZm9yY2UvaWZvcmNlLWZmLmMKQEAg
LTIsNyArMiw3IEBACiAgKiAkSWQ6IGlmb3JjZS1mZi5jLHYgMS45IDIwMDIvMDIvMDIgMTk6Mjg6
MzUgamRlbmV1eCBFeHAgJAogICoKICAqICBDb3B5cmlnaHQgKGMpIDIwMDAtMjAwMiBWb2p0ZWNo
IFBhdmxpayA8dm9qdGVjaEB1Y3cuY3o+Ci0gKiAgQ29weXJpZ2h0IChjKSAyMDAxLTIwMDIgSm9o
YW5uIERlbmV1eCA8ZGVuZXV4QGlmcmFuY2UuY29tPgorICogIENvcHlyaWdodCAoYykgMjAwMS0y
MDAyLCAyMDA3IEpvaGFubiBEZW5ldXggPGpvaGFubi5kZW5ldXhAZ21haWwuY29tPgogICoKICAq
ICBVU0IvUlMyMzIgSS1Gb3JjZSBqb3lzdGlja3MgYW5kIHdoZWVscy4KICAqLwpAQCAtMjA1LDcg
KzIwNSw3IEBAIHN0YXRpYyBpbnQgbmVlZF9jb25kaXRpb25fbW9kaWZpZXIoc3RydWN0IGZmX2Vm
ZmVjdCAqb2xkLCBzdHJ1Y3QgZmZfZWZmZWN0ICpuZXcpCiAJaW50IGk7CiAKIAlpZiAobmV3LT50
eXBlICE9IEZGX1NQUklORyAmJiBuZXctPnR5cGUgIT0gRkZfRlJJQ1RJT04pIHsKLQkJcHJpbnRr
KEtFUk5fV0FSTklORyAiaWZvcmNlLmM6IGJhZCBlZmZlY3QgdHlwZSBpbiBuZWVkX2NvbmRpdGlv
bl9tb2RpZmllclxuIik7CisJCXdhcm4oImJhZCBlZmZlY3QgdHlwZSBpbiBuZWVkX2NvbmRpdGlv
bl9tb2RpZmllciIpOwogCQlyZXR1cm4gMDsKIAl9CiAKQEAgLTIyNyw3ICsyMjcsNyBAQCBzdGF0
aWMgaW50IG5lZWRfY29uZGl0aW9uX21vZGlmaWVyKHN0cnVjdCBmZl9lZmZlY3QgKm9sZCwgc3Ry
dWN0IGZmX2VmZmVjdCAqbmV3KQogc3RhdGljIGludCBuZWVkX21hZ25pdHVkZV9tb2RpZmllcihz
dHJ1Y3QgZmZfZWZmZWN0ICpvbGQsIHN0cnVjdCBmZl9lZmZlY3QgKmVmZmVjdCkKIHsKIAlpZiAo
ZWZmZWN0LT50eXBlICE9IEZGX0NPTlNUQU5UKSB7Ci0JCXByaW50ayhLRVJOX1dBUk5JTkcgImlm
b3JjZS5jOiBiYWQgZWZmZWN0IHR5cGUgaW4gbmVlZF9lbnZlbG9wZV9tb2RpZmllclxuIik7CisJ
CXdhcm4oImJhZCBlZmZlY3QgdHlwZSBpbiBuZWVkX2VudmVsb3BlX21vZGlmaWVyIik7CiAJCXJl
dHVybiAwOwogCX0KIApAQCAtMjU4LDcgKzI1OCw3IEBAIHN0YXRpYyBpbnQgbmVlZF9lbnZlbG9w
ZV9tb2RpZmllcihzdHJ1Y3QgZmZfZWZmZWN0ICpvbGQsIHN0cnVjdCBmZl9lZmZlY3QgKmVmZmVj
CiAJCWJyZWFrOwogCiAJZGVmYXVsdDoKLQkJcHJpbnRrKEtFUk5fV0FSTklORyAiaWZvcmNlLmM6
IGJhZCBlZmZlY3QgdHlwZSBpbiBuZWVkX2VudmVsb3BlX21vZGlmaWVyXG4iKTsKKwkJd2Fybigi
YmFkIGVmZmVjdCB0eXBlIGluIG5lZWRfZW52ZWxvcGVfbW9kaWZpZXIiKTsKIAl9CiAKIAlyZXR1
cm4gMDsKQEAgLTI3MSw3ICsyNzEsNyBAQCBzdGF0aWMgaW50IG5lZWRfZW52ZWxvcGVfbW9kaWZp
ZXIoc3RydWN0IGZmX2VmZmVjdCAqb2xkLCBzdHJ1Y3QgZmZfZWZmZWN0ICplZmZlYwogc3RhdGlj
IGludCBuZWVkX3BlcmlvZF9tb2RpZmllcihzdHJ1Y3QgZmZfZWZmZWN0ICpvbGQsIHN0cnVjdCBm
Zl9lZmZlY3QgKm5ldykKIHsKIAlpZiAobmV3LT50eXBlICE9IEZGX1BFUklPRElDKSB7Ci0JCXBy
aW50ayhLRVJOX1dBUk5JTkcgImlmb3JjZS5jOiBiYWQgZWZmZWN0IHR5cGUgaW4gbmVlZF9wZXJp
b2RfbW9kaWZpZXJcbiIpOworCQl3YXJuKCJiYWQgZWZmZWN0IHR5cGUgaW4gbmVlZF9wZXJpb2Rf
bW9kaWZpZXIiKTsKIAkJcmV0dXJuIDA7CiAJfQogCXJldHVybiAob2xkLT51LnBlcmlvZGljLnBl
cmlvZCAhPSBuZXctPnUucGVyaW9kaWMucGVyaW9kCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0
L2pveXN0aWNrL2lmb3JjZS9pZm9yY2UtbWFpbi5jIGIvZHJpdmVycy9pbnB1dC9qb3lzdGljay9p
Zm9yY2UvaWZvcmNlLW1haW4uYwppbmRleCAzMzkzYTM3Li5iZDVhNmRlIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2lucHV0L2pveXN0aWNrL2lmb3JjZS9pZm9yY2UtbWFpbi5jCisrKyBiL2RyaXZlcnMv
aW5wdXQvam95c3RpY2svaWZvcmNlL2lmb3JjZS1tYWluLmMKQEAgLTIsNyArMiw3IEBACiAgKiAk
SWQ6IGlmb3JjZS1tYWluLmMsdiAxLjE5IDIwMDIvMDcvMDcgMTA6MjI6NTAgamRlbmV1eCBFeHAg
JAogICoKICAqICBDb3B5cmlnaHQgKGMpIDIwMDAtMjAwMiBWb2p0ZWNoIFBhdmxpayA8dm9qdGVj
aEB1Y3cuY3o+Ci0gKiAgQ29weXJpZ2h0IChjKSAyMDAxLTIwMDIgSm9oYW5uIERlbmV1eCA8ZGVu
ZXV4QGlmcmFuY2UuY29tPgorICogIENvcHlyaWdodCAoYykgMjAwMS0yMDAyLCAyMDA3IEpvaGFu
biBEZW5ldXggPGpvaGFubi5kZW5ldXhAZ21haWwuY29tPgogICoKICAqICBVU0IvUlMyMzIgSS1G
b3JjZSBqb3lzdGlja3MgYW5kIHdoZWVscy4KICAqLwpAQCAtMjksNyArMjksNyBAQAogCiAjaW5j
bHVkZSAiaWZvcmNlLmgiCiAKLU1PRFVMRV9BVVRIT1IoIlZvanRlY2ggUGF2bGlrIDx2b2p0ZWNo
QHVjdy5jej4sIEpvaGFubiBEZW5ldXggPGRlbmV1eEBpZnJhbmNlLmNvbT4iKTsKK01PRFVMRV9B
VVRIT1IoIlZvanRlY2ggUGF2bGlrIDx2b2p0ZWNoQHVjdy5jej4sIEpvaGFubiBEZW5ldXggPGpv
aGFubi5kZW5ldXhAZ21haWwuY29tPiIpOwogTU9EVUxFX0RFU0NSSVBUSU9OKCJVU0IvUlMyMzIg
SS1Gb3JjZSBqb3lzdGlja3MgYW5kIHdoZWVscyBkcml2ZXIiKTsKIE1PRFVMRV9MSUNFTlNFKCJH
UEwiKTsKIApAQCAtMjIwLDcgKzIyMCw3IEBAIHN0YXRpYyB2b2lkIGlmb3JjZV9yZWxlYXNlKHN0
cnVjdCBpbnB1dF9kZXYgKmRldikKIAkJLyogQ2hlY2s6IG5vIGVmZmVjdHMgc2hvdWxkIGJlIHBy
ZXNlbnQgaW4gbWVtb3J5ICovCiAJCWZvciAoaSA9IDA7IGkgPCBkZXYtPmZmLT5tYXhfZWZmZWN0
czsgaSsrKSB7CiAJCQlpZiAodGVzdF9iaXQoRkZfQ09SRV9JU19VU0VELCBpZm9yY2UtPmNvcmVf
ZWZmZWN0c1tpXS5mbGFncykpIHsKLQkJCQlwcmludGsoS0VSTl9XQVJOSU5HICJpZm9yY2VfcmVs
ZWFzZTogRGV2aWNlIHN0aWxsIG93bnMgZWZmZWN0c1xuIik7CisJCQkJd2FybigiaWZvcmNlX3Jl
bGVhc2U6IERldmljZSBzdGlsbCBvd25zIGVmZmVjdHMiKTsKIAkJCQlicmVhazsKIAkJCX0KIAkJ
fQpAQCAtMjMyLDcgKzIzMiw3IEBAIHN0YXRpYyB2b2lkIGlmb3JjZV9yZWxlYXNlKHN0cnVjdCBp
bnB1dF9kZXYgKmRldikKIAlzd2l0Y2ggKGlmb3JjZS0+YnVzKSB7CiAjaWZkZWYgQ09ORklHX0pP
WVNUSUNLX0lGT1JDRV9VU0IKIAkJY2FzZSBJRk9SQ0VfVVNCOgotCQkJdXNiX3VubGlua191cmIo
aWZvcmNlLT5pcnEpOworCQkJdXNiX2tpbGxfdXJiKGlmb3JjZS0+aXJxKTsKIAogCQkJLyogVGhl
IGRldmljZSB3YXMgdW5wbHVnZ2VkIGJlZm9yZSB0aGUgZmlsZQogCQkJICogd2FzIHJlbGVhc2Vk
ICovCkBAIC0zMjQsNyArMzI0LDcgQEAgaW50IGlmb3JjZV9pbml0X2RldmljZShzdHJ1Y3QgaWZv
cmNlICppZm9yY2UpCiAJCQlicmVhazsKIAogCWlmIChpID09IDIwKSB7IC8qIDUgc2Vjb25kcyAq
LwotCQlwcmludGsoS0VSTl9FUlIgImlmb3JjZS1tYWluLmM6IFRpbWVvdXQgd2FpdGluZyBmb3Ig
cmVzcG9uc2UgZnJvbSBkZXZpY2UuXG4iKTsKKwkJZXJyKCJUaW1lb3V0IHdhaXRpbmcgZm9yIHJl
c3BvbnNlIGZyb20gZGV2aWNlLiIpOwogCQllcnJvciA9IC1FTk9ERVY7CiAJCWdvdG8gZmFpbDsK
IAl9CkBAIC0zMzYsMjYgKzMzNiwyNiBAQCBpbnQgaWZvcmNlX2luaXRfZGV2aWNlKHN0cnVjdCBp
Zm9yY2UgKmlmb3JjZSkKIAlpZiAoIWlmb3JjZV9nZXRfaWRfcGFja2V0KGlmb3JjZSwgIk0iKSkK
IAkJaW5wdXRfZGV2LT5pZC52ZW5kb3IgPSAoaWZvcmNlLT5lZGF0YVsyXSA8PCA4KSB8IGlmb3Jj
ZS0+ZWRhdGFbMV07CiAJZWxzZQotCQlwcmludGsoS0VSTl9XQVJOSU5HICJpZm9yY2UtbWFpbi5j
OiBEZXZpY2UgZG9lcyBub3QgcmVzcG9uZCB0byBpZCBwYWNrZXQgTVxuIik7CisJCXdhcm4oIkRl
dmljZSBkb2VzIG5vdCByZXNwb25kIHRvIGlkIHBhY2tldCBNIik7CiAKIAlpZiAoIWlmb3JjZV9n
ZXRfaWRfcGFja2V0KGlmb3JjZSwgIlAiKSkKIAkJaW5wdXRfZGV2LT5pZC5wcm9kdWN0ID0gKGlm
b3JjZS0+ZWRhdGFbMl0gPDwgOCkgfCBpZm9yY2UtPmVkYXRhWzFdOwogCWVsc2UKLQkJcHJpbnRr
KEtFUk5fV0FSTklORyAiaWZvcmNlLW1haW4uYzogRGV2aWNlIGRvZXMgbm90IHJlc3BvbmQgdG8g
aWQgcGFja2V0IFBcbiIpOworCQl3YXJuKCJEZXZpY2UgZG9lcyBub3QgcmVzcG9uZCB0byBpZCBw
YWNrZXQgUCIpOwogCiAJaWYgKCFpZm9yY2VfZ2V0X2lkX3BhY2tldChpZm9yY2UsICJCIikpCiAJ
CWlmb3JjZS0+ZGV2aWNlX21lbW9yeS5lbmQgPSAoaWZvcmNlLT5lZGF0YVsyXSA8PCA4KSB8IGlm
b3JjZS0+ZWRhdGFbMV07CiAJZWxzZQotCQlwcmludGsoS0VSTl9XQVJOSU5HICJpZm9yY2UtbWFp
bi5jOiBEZXZpY2UgZG9lcyBub3QgcmVzcG9uZCB0byBpZCBwYWNrZXQgQlxuIik7CisJCXdhcm4o
IkRldmljZSBkb2VzIG5vdCByZXNwb25kIHRvIGlkIHBhY2tldCBCIik7CiAKIAlpZiAoIWlmb3Jj
ZV9nZXRfaWRfcGFja2V0KGlmb3JjZSwgIk4iKSkKIAkJZmZfZWZmZWN0cyA9IGlmb3JjZS0+ZWRh
dGFbMV07CiAJZWxzZQotCQlwcmludGsoS0VSTl9XQVJOSU5HICJpZm9yY2UtbWFpbi5jOiBEZXZp
Y2UgZG9lcyBub3QgcmVzcG9uZCB0byBpZCBwYWNrZXQgTlxuIik7CisJCXdhcm4oIkRldmljZSBk
b2VzIG5vdCByZXNwb25kIHRvIGlkIHBhY2tldCBOIik7CiAKIAkvKiBDaGVjayBpZiB0aGUgZGV2
aWNlIGNhbiBzdG9yZSBtb3JlIGVmZmVjdHMgdGhhbiB0aGUgZHJpdmVyIGNhbiByZWFsbHkgaGFu
ZGxlICovCiAJaWYgKGZmX2VmZmVjdHMgPiBJRk9SQ0VfRUZGRUNUU19NQVgpIHsKLQkJcHJpbnRr
KEtFUk5fV0FSTklORyAiaWZvcmNlOiBMaW1pdGluZyBudW1iZXIgb2YgZWZmZWN0cyB0byAlZCAo
ZGV2aWNlIHJlcG9ydHMgJWQpXG4iLAorCQl3YXJuKCJMaW1pdGluZyBudW1iZXIgb2YgZWZmZWN0
cyB0byAlZCAoZGV2aWNlIHJlcG9ydHMgJWQpIiwKIAkJICAgICAgIElGT1JDRV9FRkZFQ1RTX01B
WCwgZmZfZWZmZWN0cyk7CiAJCWZmX2VmZmVjdHMgPSBJRk9SQ0VfRUZGRUNUU19NQVg7CiAJfQpA
QCAtNDU3LDggKzQ1Nyw2IEBAIGludCBpZm9yY2VfaW5pdF9kZXZpY2Uoc3RydWN0IGlmb3JjZSAq
aWZvcmNlKQogCWlmIChlcnJvcikKIAkJZ290byBmYWlsOwogCi0JcHJpbnRrKEtFUk5fREVCVUcg
Imlmb3JjZS0+ZGV2LT5vcGVuID0gJXBcbiIsIGlmb3JjZS0+ZGV2LT5vcGVuKTsKLQogCXJldHVy
biAwOwogCiAgZmFpbDoJaW5wdXRfZnJlZV9kZXZpY2UoaW5wdXRfZGV2KTsKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW5wdXQvam95c3RpY2svaWZvcmNlL2lmb3JjZS1wYWNrZXRzLmMgYi9kcml2ZXJz
L2lucHV0L2pveXN0aWNrL2lmb3JjZS9pZm9yY2UtcGFja2V0cy5jCmluZGV4IDgwOGYwNTkuLjIx
YzRlMTMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW5wdXQvam95c3RpY2svaWZvcmNlL2lmb3JjZS1w
YWNrZXRzLmMKKysrIGIvZHJpdmVycy9pbnB1dC9qb3lzdGljay9pZm9yY2UvaWZvcmNlLXBhY2tl
dHMuYwpAQCAtMiw3ICsyLDcgQEAKICAqICRJZDogaWZvcmNlLXBhY2tldHMuYyx2IDEuMTYgMjAw
Mi8wNy8wNyAxMDoyMjo1MCBqZGVuZXV4IEV4cCAkCiAgKgogICogIENvcHlyaWdodCAoYykgMjAw
MC0yMDAyIFZvanRlY2ggUGF2bGlrIDx2b2p0ZWNoQHVjdy5jej4KLSAqICBDb3B5cmlnaHQgKGMp
IDIwMDEtMjAwMiBKb2hhbm4gRGVuZXV4IDxkZW5ldXhAaWZyYW5jZS5jb20+CisgKiAgQ29weXJp
Z2h0IChjKSAyMDAxLTIwMDIsIDIwMDcgSm9oYW5uIERlbmV1eCA8am9oYW5uLmRlbmV1eEBnbWFp
bC5jb20+CiAgKgogICogIFVTQi9SUzIzMiBJLUZvcmNlIGpveXN0aWNrcyBhbmQgd2hlZWxzLgog
ICovCkBAIC0zOSwxMCArMzksMTAgQEAgdm9pZCBpZm9yY2VfZHVtcF9wYWNrZXQoY2hhciAqbXNn
LCB1MTYgY21kLCB1bnNpZ25lZCBjaGFyICpkYXRhKQogewogCWludCBpOwogCi0JcHJpbnRrKEtF
Uk5fREVCVUcgImlmb3JjZS5jOiAlcyAoIGNtZCA9ICUwNHgsIGRhdGEgPSAiLCBtc2csIGNtZCk7
CisJcHJpbnRrKEtFUk5fREVCVUcgX19GSUxFX18gIjogJXMgY21kID0gJTA0eCwgZGF0YSA9ICIs
IG1zZywgY21kKTsKIAlmb3IgKGkgPSAwOyBpIDwgTE8oY21kKTsgaSsrKQogCQlwcmludGsoIiUw
MnggIiwgZGF0YVtpXSk7Ci0JcHJpbnRrKCIpXG4iKTsKKwlwcmludGsoIlxuIik7CiB9CiAKIC8q
CkBAIC02NSw4ICs2NSw5IEBAIGludCBpZm9yY2Vfc2VuZF9wYWNrZXQoc3RydWN0IGlmb3JjZSAq
aWZvcmNlLCB1MTYgY21kLCB1bnNpZ25lZCBjaGFyKiBkYXRhKQogCWhlYWQgPSBpZm9yY2UtPnht
aXQuaGVhZDsKIAl0YWlsID0gaWZvcmNlLT54bWl0LnRhaWw7CiAKKwogCWlmIChDSVJDX1NQQUNF
KGhlYWQsIHRhaWwsIFhNSVRfU0laRSkgPCBuKzIpIHsKLQkJcHJpbnRrKEtFUk5fV0FSTklORyAi
aWZvcmNlLmM6IG5vdCBlbm91Z2ggc3BhY2UgaW4geG1pdCBidWZmZXIgdG8gc2VuZCBuZXcgcGFj
a2V0XG4iKTsKKwkJd2Fybigibm90IGVub3VnaCBzcGFjZSBpbiB4bWl0IGJ1ZmZlciB0byBzZW5k
IG5ldyBwYWNrZXQiKTsKIAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmaWZvcmNlLT54bWl0X2xv
Y2ssIGZsYWdzKTsKIAkJcmV0dXJuIC0xOwogCX0KQEAgLTEyNiw4ICsxMjcsNiBAQCBpbnQgaWZv
cmNlX2NvbnRyb2xfcGxheWJhY2soc3RydWN0IGlmb3JjZSogaWZvcmNlLCB1MTYgaWQsIHVuc2ln
bmVkIGludCB2YWx1ZSkKIHsKIAl1bnNpZ25lZCBjaGFyIGRhdGFbM107CiAKLXByaW50ayhLRVJO
X0RFQlVHICJpZm9yY2UtcGFja2V0cy5jOiBjb250cm9sX3BsYXliYWNrICVkICVkXG4iLCBpZCwg
dmFsdWUpOwotCiAJZGF0YVswXSA9IExPKGlkKTsKIAlkYXRhWzFdID0gKHZhbHVlID4gMCkgPyAo
KHZhbHVlID4gMSkgPyAweDQxIDogMHgwMSkgOiAwOwogCWRhdGFbMl0gPSBMTyh2YWx1ZSk7CkBA
IC0xNTEsNyArMTUwLDcgQEAgc3RhdGljIGludCBtYXJrX2NvcmVfYXNfcmVhZHkoc3RydWN0IGlm
b3JjZSAqaWZvcmNlLCB1bnNpZ25lZCBzaG9ydCBhZGRyKQogCQkJcmV0dXJuIDA7CiAJCX0KIAl9
Ci0JcHJpbnRrKEtFUk5fV0FSTklORyAiaWZvcmNlLXBhY2tldHMuYzogdW51c2VkIGVmZmVjdCAl
MDR4IHVwZGF0ZWQgISEhXG4iLCBhZGRyKTsKKwl3YXJuKCJ1bnVzZWQgZWZmZWN0ICUwNHggdXBk
YXRlZCAhISEiLCBhZGRyKTsKIAlyZXR1cm4gLTE7CiB9CiAKQEAgLTE2Miw3ICsxNjEsNyBAQCB2
b2lkIGlmb3JjZV9wcm9jZXNzX3BhY2tldChzdHJ1Y3QgaWZvcmNlICppZm9yY2UsIHUxNiBjbWQs
IHVuc2lnbmVkIGNoYXIgKmRhdGEpCiAJc3RhdGljIGludCBiZWluZ191c2VkID0gMDsKIAogCWlm
IChiZWluZ191c2VkKQotCQlwcmludGsoS0VSTl9XQVJOSU5HICJpZm9yY2UtcGFja2V0cy5jOiBy
ZS1lbnRyYW50IGNhbGwgdG8gaWZvcmNlX3Byb2Nlc3MgJWRcbiIsIGJlaW5nX3VzZWQpOworCQl3
YXJuKCJyZS1lbnRyYW50IGNhbGwgdG8gaWZvcmNlX3Byb2Nlc3MgJWQiLCBiZWluZ191c2VkKTsK
IAliZWluZ191c2VkKys7CiAKICNpZmRlZiBDT05GSUdfSk9ZU1RJQ0tfSUZPUkNFXzIzMgpAQCAt
MjY2LDcgKzI2NSw3IEBAIGludCBpZm9yY2VfZ2V0X2lkX3BhY2tldChzdHJ1Y3QgaWZvcmNlICpp
Zm9yY2UsIGNoYXIgKnBhY2tldCkKIAkJCXJldHVybiAtMTsKIAkJfQogI2Vsc2UKLQkJcHJpbnRr
KEtFUk5fRVJSICJpZm9yY2VfZ2V0X2lkX3BhY2tldDogaWZvcmNlLT5idXMgPSBVU0IhXG4iKTsK
KwkJZXJyKCJpZm9yY2VfZ2V0X2lkX3BhY2tldDogaWZvcmNlLT5idXMgPSBVU0IhIik7CiAjZW5k
aWYKIAkJYnJlYWs7CiAKQEAgLTI4NCwxMyArMjgzLDEyIEBAIGludCBpZm9yY2VfZ2V0X2lkX3Bh
Y2tldChzdHJ1Y3QgaWZvcmNlICppZm9yY2UsIGNoYXIgKnBhY2tldCkKIAkJCXJldHVybiAtMTsK
IAkJfQogI2Vsc2UKLQkJcHJpbnRrKEtFUk5fRVJSICJpZm9yY2VfZ2V0X2lkX3BhY2tldDogaWZv
cmNlLT5idXMgPSBTRVJJTyFcbiIpOworCQllcnIoImlmb3JjZV9nZXRfaWRfcGFja2V0OiBpZm9y
Y2UtPmJ1cyA9IFNFUklPISIpOwogI2VuZGlmCiAJCWJyZWFrOwogCiAJZGVmYXVsdDoKLQkJcHJp
bnRrKEtFUk5fRVJSICJpZm9yY2VfZ2V0X2lkX3BhY2tldDogaWZvcmNlLT5idXMgPSAlZFxuIiwK
LQkJICAgICAgIGlmb3JjZS0+YnVzKTsKKwkJZXJyKCJpZm9yY2VfZ2V0X2lkX3BhY2tldDogaWZv
cmNlLT5idXMgPSAlZCIsIGlmb3JjZS0+YnVzKTsKIAkJYnJlYWs7CiAJfQogCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2lucHV0L2pveXN0aWNrL2lmb3JjZS9pZm9yY2Utc2VyaW8uYyBiL2RyaXZlcnMv
aW5wdXQvam95c3RpY2svaWZvcmNlL2lmb3JjZS1zZXJpby5jCmluZGV4IGVjNGJlNTMuLjdiNGJj
MTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW5wdXQvam95c3RpY2svaWZvcmNlL2lmb3JjZS1zZXJp
by5jCisrKyBiL2RyaXZlcnMvaW5wdXQvam95c3RpY2svaWZvcmNlL2lmb3JjZS1zZXJpby5jCkBA
IC0yLDcgKzIsNyBAQAogICogJElkOiBpZm9yY2Utc2VyaW8uYyx2IDEuNCAyMDAyLzAxLzI4IDIy
OjQ1OjAwIGpkZW5ldXggRXhwICQKICAqCiAgKiAgQ29weXJpZ2h0IChjKSAyMDAwLTIwMDEgVm9q
dGVjaCBQYXZsaWsgPHZvanRlY2hAdWN3LmN6PgotICogIENvcHlyaWdodCAoYykgMjAwMSBKb2hh
bm4gRGVuZXV4IDxkZW5ldXhAaWZyYW5jZS5jb20+CisgKiAgQ29weXJpZ2h0IChjKSAyMDAxLCAy
MDA3IEpvaGFubiBEZW5ldXggPGpvaGFubi5kZW5ldXhAZ21haWwuY29tPgogICoKICAqICBVU0Iv
UlMyMzIgSS1Gb3JjZSBqb3lzdGlja3MgYW5kIHdoZWVscy4KICAqLwpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pbnB1dC9qb3lzdGljay9pZm9yY2UvaWZvcmNlLXVzYi5jIGIvZHJpdmVycy9pbnB1dC9q
b3lzdGljay9pZm9yY2UvaWZvcmNlLXVzYi5jCmluZGV4IDgwY2RlYmMuLjc1MDA5OWQgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvaW5wdXQvam95c3RpY2svaWZvcmNlL2lmb3JjZS11c2IuYworKysgYi9k
cml2ZXJzL2lucHV0L2pveXN0aWNrL2lmb3JjZS9pZm9yY2UtdXNiLmMKQEAgLTIsNyArMiw3IEBA
CiAgKiAkSWQ6IGlmb3JjZS11c2IuYyx2IDEuMTYgMjAwMi8wNi8wOSAxMTowODowNCBqZGVuZXV4
IEV4cCAkCiAgKgogICogIENvcHlyaWdodCAoYykgMjAwMC0yMDAyIFZvanRlY2ggUGF2bGlrIDx2
b2p0ZWNoQHVjdy5jej4KLSAqICBDb3B5cmlnaHQgKGMpIDIwMDEtMjAwMiBKb2hhbm4gRGVuZXV4
IDxkZW5ldXhAaWZyYW5jZS5jb20+CisgKiAgQ29weXJpZ2h0IChjKSAyMDAxLTIwMDIsIDIwMDcg
Sm9oYW5uIERlbmV1eCA8am9oYW5uLmRlbmV1eEBnbWFpbC5jb20+CiAgKgogICogIFVTQi9SUzIz
MiBJLUZvcmNlIGpveXN0aWNrcyBhbmQgd2hlZWxzLgogICovCkBAIC02NSw3ICs2NSw3IEBAIHZv
aWQgaWZvcmNlX3VzYl94bWl0KHN0cnVjdCBpZm9yY2UgKmlmb3JjZSkKIAlYTUlUX0lOQyhpZm9y
Y2UtPnhtaXQudGFpbCwgbik7CiAKIAlpZiAoIChuPXVzYl9zdWJtaXRfdXJiKGlmb3JjZS0+b3V0
LCBHRlBfQVRPTUlDKSkgKSB7Ci0JCXByaW50ayhLRVJOX1dBUk5JTkcgImlmb3JjZS11c2IuYzog
aWZvcmNlX3VzYl94bWl0OiB1c2Jfc3VibWl0X3VyYiBmYWlsZWQgJWRcbiIsIG4pOworCQl3YXJu
KCJ1c2Jfc3VibWl0X3VyYiBmYWlsZWQgJWRcbiIsIG4pOwogCX0KIAogCS8qIFRoZSBJRk9SQ0Vf
WE1JVF9SVU5OSU5HIGJpdCBpcyBub3QgY2xlYXJlZCBoZXJlLiBUaGF0J3MgaW50ZW5kZWQuCkBA
IC0xMTAsNyArMTEwLDcgQEAgc3RhdGljIHZvaWQgaWZvcmNlX3VzYl9vdXQoc3RydWN0IHVyYiAq
dXJiKQogCXN0cnVjdCBpZm9yY2UgKmlmb3JjZSA9IHVyYi0+Y29udGV4dDsKIAogCWlmICh1cmIt
PnN0YXR1cykgewotCQlwcmludGsoS0VSTl9ERUJVRyAiaWZvcmNlX3VzYl9vdXQ6IHVyYi0+c3Rh
dHVzICVkLCBleGl0aW5nIiwgdXJiLT5zdGF0dXMpOworCQlkYmcoInVyYi0+c3RhdHVzICVkLCBl
eGl0aW5nIiwgdXJiLT5zdGF0dXMpOwogCQlyZXR1cm47CiAJfQogCkBAIC0xOTAsMTAgKzE5MCw5
IEBAIGZhaWw6CiAvKiBDYWxsZWQgYnkgaWZvcmNlX2RlbGV0ZSgpICovCiB2b2lkIGlmb3JjZV91
c2JfZGVsZXRlKHN0cnVjdCBpZm9yY2UqIGlmb3JjZSkKIHsKLQl1c2JfdW5saW5rX3VyYihpZm9y
Y2UtPmlycSk7Ci0vKiBJcyBpdCBvayB0byB1bmxpbmsgdGhvc2UgPyAqLwotCXVzYl91bmxpbmtf
dXJiKGlmb3JjZS0+b3V0KTsKLQl1c2JfdW5saW5rX3VyYihpZm9yY2UtPmN0cmwpOworCXVzYl9r
aWxsX3VyYihpZm9yY2UtPmlycSk7CisJdXNiX2tpbGxfdXJiKGlmb3JjZS0+b3V0KTsKKwl1c2Jf
a2lsbF91cmIoaWZvcmNlLT5jdHJsKTsKIAogCXVzYl9mcmVlX3VyYihpZm9yY2UtPmlycSk7CiAJ
dXNiX2ZyZWVfdXJiKGlmb3JjZS0+b3V0KTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQvam95
c3RpY2svaWZvcmNlL2lmb3JjZS5oIGIvZHJpdmVycy9pbnB1dC9qb3lzdGljay9pZm9yY2UvaWZv
cmNlLmgKaW5kZXggZmZhZWFlZi4uZGFkY2Y0ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9pbnB1dC9q
b3lzdGljay9pZm9yY2UvaWZvcmNlLmgKKysrIGIvZHJpdmVycy9pbnB1dC9qb3lzdGljay9pZm9y
Y2UvaWZvcmNlLmgKQEAgLTIsNyArMiw3IEBACiAgKiAkSWQ6IGlmb3JjZS5oLHYgMS4xMyAyMDAy
LzA3LzA3IDEwOjIyOjUwIGpkZW5ldXggRXhwICQKICAqCiAgKiAgQ29weXJpZ2h0IChjKSAyMDAw
LTIwMDIgVm9qdGVjaCBQYXZsaWsgPHZvanRlY2hAdWN3LmN6PgotICogIENvcHlyaWdodCAoYykg
MjAwMS0yMDAyIEpvaGFubiBEZW5ldXggPGRlbmV1eEBpZnJhbmNlLmNvbT4KKyAqICBDb3B5cmln
aHQgKGMpIDIwMDEtMjAwMiwgMjAwNyBKb2hhbm4gRGVuZXV4IDxqb2hhbm4uZGVuZXV4QGdtYWls
LmNvbT4KICAqCiAgKiAgVVNCL1JTMjMyIEktRm9yY2Ugam95c3RpY2tzIGFuZCB3aGVlbHMuCiAg
Ki8K
------=_Part_137408_10852671.1174337366175--
