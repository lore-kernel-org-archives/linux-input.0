From: Daniel Nicoletti <dantti12@gmail.com>
Subject: [Patch] Add Apple wireless keyboard to the quirk list
Date: Mon, 28 May 2012 18:11:59 -0300
Message-ID: <CACo8zOc24xxmfT4F2nfrMreL28OBXw+HF6=or4vVVMZv90MYDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40499 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954Ab2E1VMA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 May 2012 17:12:00 -0400
Received: by obbtb18 with SMTP id tb18so5851674obb.19
        for <linux-input@vger.kernel.org>; Mon, 28 May 2012 14:11:59 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>, Jeremy Fitzhardinge <jeremy@goop.org>

Hi,
some time ago I sent the patch to probe the battery status of devices,
but Jeremy improved it to go to hid-input and created a quirk list,
at that time I was quite busy with other projects that I didn't had the
chance to put my model on that list, so, now that the patch got upstream
I'm having I/O errors when reading that...

I'd also suggest to include all the other keyboard models between his and
mine, but I don't know if doing this without testing is ok.

I've tested and with this, it works just fine, thanks.

Daniel.

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
