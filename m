From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: [RFC PATCH] hid-sony: fix troubles with Sony remote clones
Date: Fri, 14 Dec 2012 20:57:34 -0200
Message-ID: <20121214205734.7d1ab9d8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50250 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756766Ab2LNW6e (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Dec 2012 17:58:34 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Marcelo Leitner <mleitner@redhat.com>

There are some Sony clone gamepads that are incompatible
with PS3 since firmware 3.50, as they decided to prevent those
devices to work, without any good technical reason. I was one of those
'blessed' people affected by their niceness with their customers.

Marcelo also has another device with a similar problem.

Perhaps due to Sony's way to block the device, damaging the device's
eeprom, or perhaps because they just have a different, broken Report 
descriptor, there are 3 buttons that don't work on both devices
(the ones equivalent to square, round and X).

What it happens is that the descriptor generate weird EV_ABS events
to those buttons, instead of EV_MSC/EV_KEY.

A fix that seems to be enough for them is to return the original
sixaxis table instead of the broken one. That's what this patch
does. 

Yet, there are some missing entries at the used keytable. On my
tests, all keys are now producing the right events, but the reported
keycodes look weird:

"square" key: (Button.0010 = 1)

1355524363.460835: event type EV_MSC(0x04): scancode = 0x90010
1355524363.460835: event type EV_KEY(0x01) key_up: BTN_DEAD(0x0001)

"round" key: (Button.000e = 1)

1355524410.908705: event type EV_MSC(0x04): scancode = 0x9000e
1355524410.908705: event type EV_KEY(0x01) key_down: (0x0001)
1355524410.971788: event type EV_MSC(0x04): scancode = 0x9000e
1355524410.971788: event type EV_KEY(0x01) key_up: (0x0001)

"X" key: (Button.000f = 1)
1355524384.880813: event type EV_MSC(0x04): scancode = 0x9000f
1355524384.880813: event type EV_KEY(0x01) key_down: (0x0001)
1355524384.979815: event type EV_MSC(0x04): scancode = 0x9000f
1355524384.979815: event type EV_KEY(0x01) key_up: (0x0001)

The rationale is likely due to those entries at rdesc table, where the
Kernel were not likely able to parse:

Button.000d ---> Key.?
Button.000e ---> Key.?
Button.000f ---> Key.?
Button.0010 ---> Key.BtnDead
Button.0011 ---> Key.?
Button.0012 ---> Key.?
Button.0013 ---> Key.?

As a reference, this is the rdisc used on my clone (a Mad Catz
model 8846):

05 01 09 04 a1 01 a1 02 85 01 75 08 95 01 15 00 26 ff 00 81 03 75 01 95 0d 15 00 25 01 35 00 45 01 05 09 19 01 29 0d 81 02 75 01 95 03 06 00 ff 81 03 05 01 25 07 46 3b 01 75 04 95 01 65 14 09 39 81 42 65 00 75 01 95 0c 06 00 ff 81 03 15 00 26 ff 00 05 01 09 01 a1 00 75 08 95 04 15 00 15 00 15 00 35 00 35 00 46 ff 00 09 30 09 31 09 32 09 35 81 02 c0 05 01 75 08 95 27 09 01 81 02 75 08 95 30 09 01 91 02 75 08 95 30 09 01 b1 02 c0 a1 02 85 02 75 08 95 30 09 01 b1 02 c0 a1 02 85 ee 75 08 95 30 09 01 b1 02 c0 a1 02 85 ef 75 08 95 30 09 01 b1 02 c0 c0 

This is what's returned on Marcelo's device (not sure what is
the brand name of his device):

05 01 09 04 a1 01 a1 02 85 01 75 08 95 01 15 00 26 ff 00 81 03 75 01 95 13 15 00 25 01 35 00 45 01 05 09 19 01 29 13 81 02 75 01 95 0d 06 00 ff 81 03 15 00 26 ff 00 05 01 09 01 a1 00 75 08 95 04 35 00 46 ff 00 09 30 09 31 09 32 09 35 81 02 c0 05 01 95 13 09 01 81 02 95 0c 81 01 75 10 95 04 26 ff 03 46 ff 03 09 01 81 02 c0 a1 02 85 02 75 08 95 30 09 01 b1 02 c0 a1 02 85 ee 75 08 95 30 09 01 b1 02 c0 a1 02 85 ef 75 08 95 30 09 01 b1 02 c0 c0 

Reported-by: Marcelo Leitner <mleitner@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>

-

Marcelo,

Could you please test this patch?

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 7f33ebf..16df4d8 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -33,6 +33,28 @@ static const u8 sixaxis_rdesc_fixup[] = {
 	0x03, 0x46, 0xFF, 0x03, 0x09, 0x01, 0x81, 0x02
 };
 
+static const u8 sixaxis_rdesc_fixup2[] = {
+	0x05, 0x01, 0x09, 0x04, 0xa1, 0x01, 0xa1, 0x02,
+	0x85, 0x01, 0x75, 0x08, 0x95, 0x01, 0x15, 0x00,
+	0x26, 0xff, 0x00, 0x81, 0x03, 0x75, 0x01, 0x95,
+	0x13, 0x15, 0x00, 0x25, 0x01, 0x35, 0x00, 0x45,
+	0x01, 0x05, 0x09, 0x19, 0x01, 0x29, 0x13, 0x81,
+	0x02, 0x75, 0x01, 0x95, 0x0d, 0x06, 0x00, 0xff,
+	0x81, 0x03, 0x15, 0x00, 0x26, 0xff, 0x00, 0x05,
+	0x01, 0x09, 0x01, 0xa1, 0x00, 0x75, 0x08, 0x95,
+	0x04, 0x35, 0x00, 0x46, 0xff, 0x00, 0x09, 0x30,
+	0x09, 0x31, 0x09, 0x32, 0x09, 0x35, 0x81, 0x02,
+	0xc0, 0x05, 0x01, 0x95, 0x13, 0x09, 0x01, 0x81,
+	0x02, 0x95, 0x0c, 0x81, 0x01, 0x75, 0x10, 0x95,
+	0x04, 0x26, 0xff, 0x03, 0x46, 0xff, 0x03, 0x09,
+	0x01, 0x81, 0x02, 0xc0, 0xa1, 0x02, 0x85, 0x02,
+	0x75, 0x08, 0x95, 0x30, 0x09, 0x01, 0xb1, 0x02,
+	0xc0, 0xa1, 0x02, 0x85, 0xee, 0x75, 0x08, 0x95,
+	0x30, 0x09, 0x01, 0xb1, 0x02, 0xc0, 0xa1, 0x02,
+	0x85, 0xef, 0x75, 0x08, 0x95, 0x30, 0x09, 0x01,
+	0xb1, 0x02, 0xc0, 0xc0,
+};
+
 struct sony_sc {
 	unsigned long quirks;
 };
@@ -56,6 +78,12 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		hid_info(hdev, "Fixing up Sony Sixaxis report descriptor\n");
 		memcpy((void *)&rdesc[83], (void *)&sixaxis_rdesc_fixup,
 			sizeof(sixaxis_rdesc_fixup));
+	} else if (sc->quirks & SIXAXIS_CONTROLLER_USB &&
+		   *rsize > sizeof(sixaxis_rdesc_fixup2)) {
+		hid_info(hdev, "Sony Sixaxis clone detected. Using original report descriptor (size: %d clone; %d new)\n",
+			 *rsize, (int)sizeof(sixaxis_rdesc_fixup2));
+		*rsize = sizeof(sixaxis_rdesc_fixup2);
+		memcpy(rdesc, &sixaxis_rdesc_fixup2, *rsize);
 	}
 	return rdesc;
 }
