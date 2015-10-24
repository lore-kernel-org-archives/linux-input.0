From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: usbhid: Add a quirk for Xin-Mo Dual Arcade
Date: Sat, 24 Oct 2015 22:11:18 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1510242210360.21100@pobox.suse.cz>
References: <1445701499-13748-1-git-send-email-michele@acksyn.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49232 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752538AbbJXULT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Oct 2015 16:11:19 -0400
In-Reply-To: <1445701499-13748-1-git-send-email-michele@acksyn.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michele Baldessari <michele@acksyn.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Olivier Scherler <oscherler@ithink.ch>

On Sat, 24 Oct 2015, Michele Baldessari wrote:

> The Xin-Mo Dual Arcade controller (16c0:05e1) needs this quirk in order
> to have the two distinct joysticks working.
> 
> Before the change:
> $ jstest /dev/input/js0
> Joystick (Xin-Mo Xin-Mo Dual Arcade) has 2 axes (X, Y)
> ...
> $ jstest /dev/input/js1
> jstest: No such file or directory
> 
> After the change:
> $ jstest /dev/input/js0
> Joystick (Xin-Mo Xin-Mo Dual Arcade) has 2 axes (X, Y)
> ...
> $ jstest /dev/input/js1
> Joystick (Xin-Mo Xin-Mo Dual Arcade) has 2 axes (X, Y)
> ...
> 
> Signed-off-by: Michele Baldessari <michele@acksyn.org>

Adding Oliver to CC.

Oliver, how come that you didn't need this while working on the inigial 
Xin-Mo Dual Arcade support?

Thanks.

> ---
>  drivers/hid/usbhid/hid-quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index 1dff8f0015ba..f69049314a2c 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -150,6 +150,7 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_MULTIPLE_1781, USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD, HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES, HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES, HID_QUIRK_MULTI_INPUT },
> +	{ USB_VENDOR_ID_XIN_MO, USB_DEVICE_ID_XIN_MO_DUAL_ARCADE, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
>  
>  	{ 0, 0 }
>  };
> -- 
> 2.5.0
> 

-- 
Jiri Kosina
SUSE Labs

