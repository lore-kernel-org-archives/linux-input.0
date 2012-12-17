From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [RFC PATCH] hid-sony: fix troubles with Sony remote clones
Date: Mon, 17 Dec 2012 12:17:45 -0200
Message-ID: <20121217121745.3aeee8c3@redhat.com>
References: <20121214205734.7d1ab9d8@redhat.com>
	<alpine.LNX.2.00.1212162136250.27319@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42036 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557Ab2LQOSt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Dec 2012 09:18:49 -0500
In-Reply-To: <alpine.LNX.2.00.1212162136250.27319@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Marcelo Leitner <mleitner@redhat.com>

Hi Jiri,

Em Sun, 16 Dec 2012 21:37:07 +0100 (CET)
Jiri Kosina <jkosina@suse.cz> escreveu:

> On Fri, 14 Dec 2012, Mauro Carvalho Chehab wrote:
> 
> > There are some Sony clone gamepads that are incompatible
> > with PS3 since firmware 3.50, as they decided to prevent those
> > devices to work, without any good technical reason. I was one of those
> > 'blessed' people affected by their niceness with their customers.
> > 
> > Marcelo also has another device with a similar problem.
> > 
> > Perhaps due to Sony's way to block the device, damaging the device's
> > eeprom, or perhaps because they just have a different, broken Report 
> > descriptor, there are 3 buttons that don't work on both devices
> > (the ones equivalent to square, round and X).
> > 
> > What it happens is that the descriptor generate weird EV_ABS events
> > to those buttons, instead of EV_MSC/EV_KEY.
> > 
> > A fix that seems to be enough for them is to return the original
> > sixaxis table instead of the broken one. That's what this patch
> > does. 
> > 
> > Yet, there are some missing entries at the used keytable. On my
> > tests, all keys are now producing the right events, but the reported
> > keycodes look weird:
> > 
> > "square" key: (Button.0010 = 1)
> > 
> > 1355524363.460835: event type EV_MSC(0x04): scancode = 0x90010
> > 1355524363.460835: event type EV_KEY(0x01) key_up: BTN_DEAD(0x0001)
> > 
> > "round" key: (Button.000e = 1)
> > 
> > 1355524410.908705: event type EV_MSC(0x04): scancode = 0x9000e
> > 1355524410.908705: event type EV_KEY(0x01) key_down: (0x0001)
> > 1355524410.971788: event type EV_MSC(0x04): scancode = 0x9000e
> > 1355524410.971788: event type EV_KEY(0x01) key_up: (0x0001)
> > 
> > "X" key: (Button.000f = 1)
> > 1355524384.880813: event type EV_MSC(0x04): scancode = 0x9000f
> > 1355524384.880813: event type EV_KEY(0x01) key_down: (0x0001)
> > 1355524384.979815: event type EV_MSC(0x04): scancode = 0x9000f
> > 1355524384.979815: event type EV_KEY(0x01) key_up: (0x0001)
> > 
> > The rationale is likely due to those entries at rdesc table, where the
> > Kernel were not likely able to parse:
> > 
> > Button.000d ---> Key.?
> > Button.000e ---> Key.?
> > Button.000f ---> Key.?
> > Button.0010 ---> Key.BtnDead
> > Button.0011 ---> Key.?
> > Button.0012 ---> Key.?
> > Button.0013 ---> Key.?
> > 
> > As a reference, this is the rdisc used on my clone (a Mad Catz
> > model 8846):
> > 
> > 05 01 09 04 a1 01 a1 02 85 01 75 08 95 01 15 00 26 ff 00 81 03 75 01 95 0d 15 00 25 01 35 00 45 01 05 09 19 01 29 0d 81 02 75 01 95 03 06 00 ff 81 03 05 01 25 07 46 3b 01 75 04 95 01 65 14 09 39 81 42 65 00 75 01 95 0c 06 00 ff 81 03 15 00 26 ff 00 05 01 09 01 a1 00 75 08 95 04 15 00 15 00 15 00 35 00 35 00 46 ff 00 09 30 09 31 09 32 09 35 81 02 c0 05 01 75 08 95 27 09 01 81 02 75 08 95 30 09 01 91 02 75 08 95 30 09 01 b1 02 c0 a1 02 85 02 75 08 95 30 09 01 b1 02 c0 a1 02 85 ee 75 08 95 30 09 01 b1 02 c0 a1 02 85 ef 75 08 95 30 09 01 b1 02 c0 c0 
> > 
> > This is what's returned on Marcelo's device (not sure what is
> > the brand name of his device):
> > 
> > 05 01 09 04 a1 01 a1 02 85 01 75 08 95 01 15 00 26 ff 00 81 03 75 01 95 13 15 00 25 01 35 00 45 01 05 09 19 01 29 13 81 02 75 01 95 0d 06 00 ff 81 03 15 00 26 ff 00 05 01 09 01 a1 00 75 08 95 04 35 00 46 ff 00 09 30 09 31 09 32 09 35 81 02 c0 05 01 95 13 09 01 81 02 95 0c 81 01 75 10 95 04 26 ff 03 46 ff 03 09 01 81 02 c0 a1 02 85 02 75 08 95 30 09 01 b1 02 c0 a1 02 85 ee 75 08 95 30 09 01 b1 02 c0 a1 02 85 ef 75 08 95 30 09 01 b1 02 c0 c0 
> > 
> > Reported-by: Marcelo Leitner <mleitner@redhat.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
> 
> Yeah, this is the way I'd like to have it fixed.
> 
> Waiting for Marcelo's Tested-by: before merging it.

Thanks for reviewing! Marcelo only saw it today. He is promising to
test it this night.

There's one thing that still bothers me: the default keymapping for this
remote is really weird. Worse than that, it is also different than
the one used by hid-ps3remote.c.

While I think it would be better to add specific buttons for
keys square, round, circle, cross, it doesn't make sense to have it
different than the one defined on ps3remote HID.

The enclosed patch should fix it, adding the same mapping found at
ps3remote (except for scancode 0x14 - that doesn't seem to exist on
sixaxis).

Regards,
Mauro

-
From: Mauro Carvalho Chehab <mchehab@redhat.com>

[PATCH] hid-sony: add a keymap for Sony 6-axis remote

The keymap there matches the one defined by hid-ps3remote. This way,
similar keypad controllers will use similar keys.

Tested with an original PS3 6-axis remote and with a wireless clone
(MadCatz Dualforce3).

Signed-off-by: Mauro Carvalho Chehab <mchehab@redhat.com>

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 16df4d8..7eb1870 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -27,6 +27,26 @@
 #define SIXAXIS_CONTROLLER_USB  (1 << 1)
 #define SIXAXIS_CONTROLLER_BT   (1 << 2)
 
+static const unsigned int ps3remote_keymap_joypad_buttons[] = {
+	[0x01] = KEY_SELECT,
+	[0x02] = BTN_THUMBL,		/* L3 */
+	[0x03] = BTN_THUMBR,		/* R3 */
+	[0x04] = BTN_START,
+	[0x05] = KEY_UP,
+	[0x06] = KEY_RIGHT,
+	[0x07] = KEY_DOWN,
+	[0x08] = KEY_LEFT,
+	[0x09] = BTN_TL2,		/* L2 */
+	[0x0a] = BTN_TR2,		/* R2 */
+	[0x0b] = BTN_TL,		/* L1 */
+	[0x0c] = BTN_TR,		/* R1 */
+	[0x0d] = KEY_OPTION,		/* options/triangle */
+	[0x0e] = KEY_BACK,		/* back/circle */
+	[0x0f] = BTN_0,			/* cross */
+	[0x10] = KEY_SCREEN,		/* view/square */
+	[0x11] = KEY_HOMEPAGE,		/* PS button */
+};
+
 static const u8 sixaxis_rdesc_fixup[] = {
 	0x95, 0x13, 0x09, 0x01, 0x81, 0x02, 0x95, 0x0C,
 	0x81, 0x01, 0x75, 0x10, 0x95, 0x04, 0x26, 0xFF,
@@ -182,6 +202,29 @@ static int sixaxis_set_operational_bt(struct hid_device *hdev)
 	return hdev->hid_output_raw_report(hdev, buf, sizeof(buf), HID_FEATURE_REPORT);
 }
 
+static int sony_mapping(struct hid_device *hdev, struct hid_input *hi,
+			     struct hid_field *field, struct hid_usage *usage,
+			     unsigned long **bit, int *max)
+{
+	unsigned int key = usage->hid;
+
+	/* Remaps buttons only */
+	if ((key & ~0xff) != 0x90000)
+		return 0;
+
+	key &= 0xff;
+	if (key >= ARRAY_SIZE(ps3remote_keymap_joypad_buttons))
+		return -1;
+
+	key = ps3remote_keymap_joypad_buttons[key];
+	if (!key)
+		return -1;
+
+	hid_map_usage_clear(hi, usage, bit, max, EV_KEY, key);
+	return 1;
+}
+
+
 static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
@@ -255,7 +298,8 @@ static struct hid_driver sony_driver = {
 	.probe = sony_probe,
 	.remove = sony_remove,
 	.report_fixup = sony_report_fixup,
-	.raw_event = sony_raw_event
+	.raw_event = sony_raw_event,
+	.input_mapping = sony_mapping,
 };
 
 static int __init sony_init(void)
