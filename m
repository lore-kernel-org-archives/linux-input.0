From: Thomas Ilnseher <illth@gmx.de>
Subject: [RFC][PATCH] correct some quirks for trust 15351 bluetooth mouse
Date: Fri, 30 May 2008 21:21:10 +0200
Message-ID: <1212175271.22054.19.camel@note.localnet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-FhogaqTRknCDB+Lcb8wR"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:42735 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751482AbYE3TVN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 30 May 2008 15:21:13 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: vojtech@ucw.cz, linux-input@vger.kernel.org


--=-FhogaqTRknCDB+Lcb8wR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I recently got a (trust 15351) bluetooth mouse.

when I hooked it up to my notebook, Only the Y-Axis did work,
not the X-Axis. with some help from peter hutterer, I could track the
problem down an hid->usage of 0006.0020 that got mapped to abs.misc,
which confused evdev.

There is also a Consumer.HWheel reported, which is not present on the
mouse, but is a further annoyance (it gets mapped to buttens 6/7,
that remaps the real buttons 6/7 to 8/9, and you have to use xmodmap).

I composed this patch to make the hid driver ignore these two "features"
of the mouse.

I'm not sure if this is the right way to do things.

Cheers,
Thomas
-- 
Thomas Ilnseher <illth@gmx.de>

--=-FhogaqTRknCDB+Lcb8wR
Content-Description: 
Content-Disposition: inline; filename=hid-quirk-trust15351.diff
Content-Type: text/x-patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

--- linux/drivers/hid/hid-input-quirks.c.orig	2008-04-17 04:49:44.000000000 +0200
+++ linux/drivers/hid/hid-input-quirks.c	2008-05-30 20:36:55.867668169 +0200
@@ -24,6 +24,18 @@
 #define map_abs_clear(c)        do { map_abs(c); clear_bit(c, *bit); } while (0)
 #define map_key_clear(c)        do { map_key(c); clear_bit(c, *bit); } while (0)
 
+static int quirk_trust15351_ignore_weird_axis(struct hid_usage *usage, struct input_dev *input,
+			      unsigned long **bit, int *max)
+{
+	/* 0006.0020 is some weird absolute axis that gets mapped to abs.misc */
+	if (usage->hid == 0x60020)
+		return 2;
+	/* consumer.hwheel (but the mouse has no hwheel) */
+	if (usage->hid == 0xc0238)
+		return 2;
+	return 0;
+}
+
 static int quirk_belkin_wkbd(struct hid_usage *usage, struct input_dev *input,
 			      unsigned long **bit, int *max)
 {
@@ -306,6 +318,9 @@
 #define VENDOR_ID_PETALYNX			0x18b1
 #define DEVICE_ID_PETALYNX_MAXTER_REMOTE	0x0037
 
+#define VENDOR_ID_TRUST				0x0a5c
+#define DEVICE_IS_13531_BT			0x0001
+
 static const struct hid_input_blacklist {
 	__u16 idVendor;
 	__u16 idProduct;
@@ -332,6 +346,8 @@
 	{ VENDOR_ID_MONTEREY, DEVICE_ID_GENIUS_KB29E, quirk_cherry_genius_29e },
 
 	{ VENDOR_ID_PETALYNX, DEVICE_ID_PETALYNX_MAXTER_REMOTE, quirk_petalynx_remote },
+
+	{ VENDOR_ID_TRUST, DEVICE_IS_13531_BT, quirk_trust15351_ignore_weird_axis },
 	
 	{ 0, 0, 0 }
 };
--- linux/drivers/hid/hid-input.c.orig	2008-05-30 20:18:43.000000000 +0200
+++ linux/drivers/hid/hid-input.c	2008-05-30 20:36:55.880256291 +0200
@@ -387,6 +387,8 @@
 
 	/* handle input mappings for quirky devices */
 	ret = hidinput_mapping_quirks(usage, input, &bit, &max);
+	if (ret == 2)
+		goto ignore;
 	if (ret)
 		goto mapped;

--=-FhogaqTRknCDB+Lcb8wR--

