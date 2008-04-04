From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: multi-input quirk and skip output reports quirk
Date: Fri, 4 Apr 2008 16:37:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804041629030.26562@twin.jikos.cz>
References: <47F21BA7.8030306@gmail.com> <Pine.LNX.4.64.0804011610450.5541@jikos.suse.cz>
 <47F2437C.6060203@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:38200 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755712AbYDDOhL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Apr 2008 10:37:11 -0400
In-Reply-To: <47F2437C.6060203@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Tue, 1 Apr 2008, Anssi Hannula wrote:

> >> I've encountered another multi-input device that needs the skip output
> >> reports quirk (as it contains force feedback output reports), 0925:8866.
> >> However, maybe we should use another approach, dropping
> >> HID_QUIRK_SKIP_OUTPUT_REPORTS. Why not just *not* register the input
> >> device for that report in case the report didn't contain anything that
> >> was mapped by hidinput_configure_usage(), in hidinput_connect()?
> > as long as we still have the possibility to see the coming data in debug 
> > mode, I don't have objection to that.
> Okay.
> > Are you going to make that patch?
> Not right now, maybe in a few weeks.

I will meanwhile queue the patch below, ok? After the hidinput_connect() 
is refactored to ignore devices for which the mappings haven't been 
established, we could then remove all the devices for which we have 
HID_QUIRK_SKIP_OUTPUT_REPORTS altogether.

BTW, do you happen to have any idea whether the Quad joypad needs this 
quirk too?

Thanks.


From: Jiri Kosina <jkosina@suse.cz>
Subject: HID: WiseGroup 866 Dual Joypad needs output reports quirk

WiseGroup Ltd, MP-8866 Dual Joypad needs to skip output reports,
as it contains force-feedback output reports.

Reported-by: Anssi Hannula <anssi.hannula@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>

diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index a104d1e..ff6fadc 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -606,7 +606,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_KEYBOARD, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_DUAL_USB_JOYPAD, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_DUAL_USB_JOYPAD, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT | HID_QUIRK_SKIP_OUTPUT_REPORTS },
 	{ USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_QUAD_USB_JOYPAD, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
 
 	{ USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SMARTJOY_DUAL_PLUS, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },

