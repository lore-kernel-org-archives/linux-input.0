From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Trouble with an HP stylus
Date: Tue, 29 Jul 2014 16:41:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1407291640280.16390@pobox.suse.cz>
References: <2325454.r4RE9vHMoF@romarin> <alpine.LNX.2.00.1407291147190.16390@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46488 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753928AbaG2Olp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 10:41:45 -0400
In-Reply-To: <alpine.LNX.2.00.1407291147190.16390@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?=C9ric_Brunet?= <Eric.Brunet@lps.ens.fr>
Cc: linux-input@vger.kernel.org

On Tue, 29 Jul 2014, Jiri Kosina wrote:

> Does the patch below fix the problem for you please?
> 
> 
> 
> 
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index 31e6727..d48574d 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -97,6 +97,7 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_SYMBOL, USB_DEVICE_ID_SYMBOL_SCANNER_2, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_TPV, USB_DEVICE_ID_TPV_OPTICAL_TOUCHSCREEN, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_KEYBOARD, HID_QUIRK_NOGET },
> +	{ 0x03EB, 0x840B, HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_PF1209, HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP4030U, HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_KNA5, HID_QUIRK_MULTI_INPUT },

Alternatively, if you don't want to recompile your kernel, you can achieve 
the equivalent result by modprobing the 'usbhid' module with 
'quirks=0x03EB:0x840B:0x40' module parameter.

-- 
Jiri Kosina
SUSE Labs
