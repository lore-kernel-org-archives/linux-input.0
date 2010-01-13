From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: ignore afatech 9016
Date: Wed, 13 Jan 2010 21:44:49 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001132143550.30977@pobox.suse.cz>
References: <1263412773-23220-1-git-send-email-jslaby@suse.cz> <alpine.LNX.2.00.1001132111570.30977@pobox.suse.cz> <4B4E2E48.1000509@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:38490 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755411Ab0AMUou (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2010 15:44:50 -0500
In-Reply-To: <4B4E2E48.1000509@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, Pekka Sarnila <sarnila@adit.fi>

On Wed, 13 Jan 2010, Jiri Slaby wrote:

> >> --- a/drivers/hid/usbhid/hid-quirks.c
> >> +++ b/drivers/hid/usbhid/hid-quirks.c
> >> @@ -41,7 +41,7 @@ static const struct hid_blacklist {
> >>  	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, HID_QUIRK_BADPAD },
> >>  	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },
> >>  
> >> -	{ USB_VENDOR_ID_AFATECH, USB_DEVICE_ID_AFATECH_AF9016, HID_QUIRK_FULLSPEED_INTERVAL },
> >> +	{ USB_VENDOR_ID_AFATECH, USB_DEVICE_ID_AFATECH_AF9016, HID_QUIRK_IGNORE },
> > 
> > Hmm, why do we keep HID_QUIRK_IGNORE anyway, when we already have generic 
> > hid_ignore_list[]?
> 
> You returned it back because of dynamic quirks...

Right you are.

> > We don't set it for any device in the current codebase any more.
> 
> Oh yeah, it's hard for people who don't remember code they wrote :).

Oh, right ... happened to me as well, see a few lines above :)

> Will respin. Thanks for the reminder.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
