From: Daniel Nicoletti <dantti12@gmail.com>
Subject: Re: [Patch] Add Apple wireless keyboard to the quirk list
Date: Wed, 4 Jul 2012 10:40:34 -0300
Message-ID: <CACo8zOd77ZJNNzmwNWTJGM4H9U3F5Je90ADcO+PiK=jqESQixQ@mail.gmail.com>
References: <CACo8zOc24xxmfT4F2nfrMreL28OBXw+HF6=or4vVVMZv90MYDw@mail.gmail.com>
	<alpine.LNX.2.00.1206051136140.5478@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60134 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140Ab2GDNkf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Jul 2012 09:40:35 -0400
Received: by pbbrp8 with SMTP id rp8so11056664pbb.19
        for <linux-input@vger.kernel.org>; Wed, 04 Jul 2012 06:40:35 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1206051136140.5478@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>, Jeremy Fitzhardinge <jeremy@goop.org>

2012/6/5 Jiri Kosina <jkosina@suse.cz>
> > I've tested and with this, it works just fine, thanks.
>
> Thanks for the patch. It's however missing your Signed-off-by: line, could
> you please resend the patch including it, so that I could apply it?
Ok sorry for the delay (too much stuff),
I'm used to have commit access on the stuff I contribute so
I didn't know this git format-patch thing, which someone pointed out to me.
Should I use git send-email too?

Thanks.

>From cc0225ce44f037f7ce9ecb876e65b5e8079d5665 Mon Sep 17 00:00:00 2001
From: Daniel Nicoletti <dantti12@gmail.com>
Date: Wed, 4 Jul 2012 10:20:31 -0300
Subject: [PATCH 1/1] hid-input: Add Apple's Wireless keyboard
 (USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI), to the quirk
 list since it report wrong feature type and wrong
 percentage range.


Signed-off-by: Daniel Nicoletti <dantti12@gmail.com>
---
 drivers/hid/hid-input.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 132b001..33d88d1 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -301,6 +301,9 @@ static const struct hid_device_id hid_battery_quirks[] = {
        { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
                               USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ANSI),
          HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
+       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
+                              USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI),
+         HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
        {}
 };

-- 
1.7.9.5
