From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] This adds support for keyboards on mid-2011 MacBook Airs
Date: Wed, 5 Oct 2011 19:28:57 +0200
Message-ID: <20111005172857.GA2195@polaris.bitmath.org>
References: <efc66984043a292faa31fee381945d18@jefferai.org>
 <20111005090735.GA6840@polaris.bitmath.org>
 <alpine.LNX.2.00.1110051103140.31654@pobox.suse.cz>
 <20111005094851.GA7261@polaris.bitmath.org>
 <alpine.LNX.2.00.1110051212320.31654@pobox.suse.cz>
 <4E8C66C2.6010503@jefferai.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:56793 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934962Ab1JERWx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Oct 2011 13:22:53 -0400
Received: from iph1.telenor.se (iph1.telenor.se [195.54.127.132])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 33F63EB119
	for <linux-input@vger.kernel.org>; Wed,  5 Oct 2011 19:22:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E8C66C2.6010503@jefferai.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeff Mitchell <jeff@jefferai.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, jvdillon@gmail.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

> Great.
> 
> To clear up an earlier point: AFAIK the new MBAs have the same keyboard
> layout as normal MacBooks and hence uses the same table. An earlier
> patch that was floating around added another table for the new MBAs but
> if you looked at the mappings it was the exact same table as the normal
> MacBook one.

I see. The current tree actually contains two identical tables. Yikes.
Using your patch would have prevented this, but it might be too late
now. If so, the (untested) patch below might fix things up. Does it
still work for you?

Thanks,
Henrik

>From deed345085e90505c4534116cc58e0bee98a431f Mon Sep 17 00:00:00 2001
From: Henrik Rydberg <rydberg@euromail.se>
Date: Wed, 5 Oct 2011 19:27:27 +0200
Subject: [PATCH] hid-apple: Remove duplicate key table

Commit d762cc290 introduced keyboard support for the WELLSPRING6A
devices, but the added key table is actually identical to the default
one. This patch removes the duplicate.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hid/hid-apple.c |   25 -------------------------
 1 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 2bab9ab..9bc7b03 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -82,28 +82,6 @@ static const struct apple_key_translation macbookair_fn_keys[] = {
 	{ }
 };
 
-static const struct apple_key_translation macbookair4_fn_keys[] = {
-	{ KEY_BACKSPACE, KEY_DELETE },
-	{ KEY_ENTER,	KEY_INSERT },
-	{ KEY_F1,	KEY_BRIGHTNESSDOWN, APPLE_FLAG_FKEY },
-	{ KEY_F2,	KEY_BRIGHTNESSUP,   APPLE_FLAG_FKEY },
-	{ KEY_F3,	KEY_SCALE,          APPLE_FLAG_FKEY },
-	{ KEY_F4,	KEY_DASHBOARD,      APPLE_FLAG_FKEY },
-	{ KEY_F5,	KEY_KBDILLUMDOWN,   APPLE_FLAG_FKEY },
-	{ KEY_F6,	KEY_KBDILLUMUP,     APPLE_FLAG_FKEY },
-	{ KEY_F7,	KEY_PREVIOUSSONG,   APPLE_FLAG_FKEY },
-	{ KEY_F8,	KEY_PLAYPAUSE,      APPLE_FLAG_FKEY },
-	{ KEY_F9,	KEY_NEXTSONG,       APPLE_FLAG_FKEY },
-	{ KEY_F10,	KEY_MUTE,           APPLE_FLAG_FKEY },
-	{ KEY_F11,	KEY_VOLUMEDOWN,     APPLE_FLAG_FKEY },
-	{ KEY_F12,	KEY_VOLUMEUP,       APPLE_FLAG_FKEY },
-	{ KEY_UP,	KEY_PAGEUP },
-	{ KEY_DOWN,	KEY_PAGEDOWN },
-	{ KEY_LEFT,	KEY_HOME },
-	{ KEY_RIGHT,	KEY_END },
-	{ }
-};
-
 static const struct apple_key_translation apple_fn_keys[] = {
 	{ KEY_BACKSPACE, KEY_DELETE },
 	{ KEY_ENTER,	KEY_INSERT },
@@ -208,9 +186,6 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 		else if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING6_ANSI &&
 				hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING6_JIS)
 			table = macbookair_fn_keys;
-		else if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING6A_ANSI &&
-				hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING6A_JIS)
-			table = macbookair4_fn_keys;
 		else if (hid->product < 0x21d || hid->product >= 0x300)
 			table = powerbook_fn_keys;
 		else
-- 
1.7.6.4

