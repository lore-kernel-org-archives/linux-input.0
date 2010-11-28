From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Researching An Experimental Touchscreen Driver
Date: Sat, 27 Nov 2010 22:38:30 -0800
Message-ID: <20101128063829.GB14499@core.coreip.homeip.net>
References: <1290614820.3294.37.camel@bathysphere>
 <20101127235133.GB29981@core.coreip.homeip.net>
 <1290911010.1932.9.camel@bathysphere>
 <20101128030729.GA4795@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f194.google.com ([209.85.214.194]:45335 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947Ab0K1Gih (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Nov 2010 01:38:37 -0500
Received: by iwn7 with SMTP id 7so621409iwn.1
        for <linux-input@vger.kernel.org>; Sat, 27 Nov 2010 22:38:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101128030729.GA4795@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Moles <jeremy@emperorlinux.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Sat, Nov 27, 2010 at 07:07:29PM -0800, Dmitry Torokhov wrote:
> 
> You need to make sure you are adding entry to
> 
> drivers/hid/hid-core.c:static const struct hid_device_id hid_blacklist[]
> 
> and not to
> 
> drivers/hid/usbhid/hid-quirks.c:static const struct hid_blacklist
> 
> Hmm, I wonder if we should rename the first one to something different,
> like hid_has_custom_driver. Jiri?
> 

Something like this one I guess...

-- 
Dmitry


HID: hid-core - rename hid_blacklist to hid_have_special_driver

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

To avoid confusion with hid_blacklist describing various quirks in
usbhid code, let's rename this one.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/hid/hid-core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b133d47..8b421e6 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1230,7 +1230,7 @@ void hid_disconnect(struct hid_device *hdev)
 EXPORT_SYMBOL_GPL(hid_disconnect);
 
 /* a list of devices for which there is a specialized driver on HID bus */
-static const struct hid_device_id hid_blacklist[] = {
+static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_3M, USB_DEVICE_ID_3M1968) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_3M, USB_DEVICE_ID_3M2256) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU) },
@@ -1493,9 +1493,9 @@ static int hid_bus_match(struct device *dev, struct device_driver *drv)
 	if (!hid_match_device(hdev, hdrv))
 		return 0;
 
-	/* generic wants all non-blacklisted */
+	/* generic wants all that don't have specialized driver */
 	if (!strncmp(hdrv->name, "generic-", 8))
-		return !hid_match_id(hdev, hid_blacklist);
+		return !hid_match_id(hdev, hid_have_special_driver);
 
 	return 1;
 }
