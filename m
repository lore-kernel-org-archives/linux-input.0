From: Michele Baldessari <michele@acksyn.org>
Subject: Re: [PATCH] HID: usbhid: Add a quirk for Xin-Mo Dual Arcade
Date: Sun, 25 Oct 2015 17:34:27 +0100
Message-ID: <20151025163427.GB9266@palahniuk.int.rhx>
References: <1445701499-13748-1-git-send-email-michele@acksyn.org>
 <562C9DA5.9090800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from palahniuk.acksyn.org ([5.9.7.26]:48561 "EHLO
	palahniuk.acksyn.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbbJYQeb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Oct 2015 12:34:31 -0400
Content-Disposition: inline
In-Reply-To: <562C9DA5.9090800@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lars Melin <larsm17@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Oct 25, 2015 at 04:15:17PM +0700, Lars Melin wrote:
> On 2015-10-24 22:44, Michele Baldessari wrote:
> >The Xin-Mo Dual Arcade controller (16c0:05e1) needs this quirk in order
> >to have the two distinct joysticks working.
> >
> >Before the change:
> >$ jstest /dev/input/js0
> >Joystick (Xin-Mo Xin-Mo Dual Arcade) has 2 axes (X, Y)
> >...
> >$ jstest /dev/input/js1
> >jstest: No such file or directory
> >
> >After the change:
> >$ jstest /dev/input/js0
> >Joystick (Xin-Mo Xin-Mo Dual Arcade) has 2 axes (X, Y)
> >...
> >$ jstest /dev/input/js1
> >Joystick (Xin-Mo Xin-Mo Dual Arcade) has 2 axes (X, Y)
> >...
> >
> >Signed-off-by: Michele Baldessari <michele@acksyn.org>
> >---
> >  drivers/hid/usbhid/hid-quirks.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> >diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> >index 1dff8f0015ba..f69049314a2c 100644
> >--- a/drivers/hid/usbhid/hid-quirks.c
> >+++ b/drivers/hid/usbhid/hid-quirks.c
> >@@ -150,6 +150,7 @@ static const struct hid_blacklist {
> >  	{ USB_VENDOR_ID_MULTIPLE_1781, USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD, HID_QUIRK_MULTI_INPUT },
> >  	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES, HID_QUIRK_MULTI_INPUT },
> >  	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES, HID_QUIRK_MULTI_INPUT },
> >+	{ USB_VENDOR_ID_XIN_MO, USB_DEVICE_ID_XIN_MO_DUAL_ARCADE, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
> >
> >  	{ 0, 0 }
> >  };
> >
> 
> Sorry but I don't believe that XIN_MO is the owner of the 16c0 VID so should
> not be given that ownership in linux.

The "ownership" of 16c0 is a completely orthogonal issue to this patch.

16c0 was already defined (twice actually):
$ grep -i 0x16c0 drivers/hid/hid-ids.h | awk '{ print $2 }'
USB_VENDOR_ID_ATMEL_V_USB
USB_VENDOR_ID_XIN_MO

cheers,
Michele
-- 
Michele Baldessari            <michele@acksyn.org>
C2A5 9DA3 9961 4FFB E01B  D0BC DDD4 DCCB 7515 5C6D
