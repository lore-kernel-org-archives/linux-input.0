From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] hid: flesh out support for tivo slide remote
Date: Mon, 6 Feb 2012 17:37:50 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1202061737110.24127@pobox.suse.cz>
References: <alpine.LNX.2.00.1110141942290.14768@pobox.suse.cz> <1318625862-26833-1-git-send-email-jarod@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51612 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754671Ab2BFQhv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 6 Feb 2012 11:37:51 -0500
In-Reply-To: <1318625862-26833-1-git-send-email-jarod@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarod Wilson <jarod@redhat.com>
Cc: linux-input@vger.kernel.org

On Fri, 14 Oct 2011, Jarod Wilson wrote:

> +config HID_TIVO_SLIDE
> +	tristate "TiVo Slide Bluetooth remote control support"
> +	depends on USB_HID
> +	---help---
> +	Say Y if you have a TiVo Slide Bluetooth remote control.
> +
>  config HID_TOPSEED
>  	tristate "TopSeed Cyberlink, BTC Emprex, Conceptronic remote control support"
>  	depends on USB_HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 0a0a38e..3610001 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_HID_SPEEDLINK)	+= hid-speedlink.o
>  obj-$(CONFIG_HID_SUNPLUS)	+= hid-sunplus.o
>  obj-$(CONFIG_HID_GREENASIA)	+= hid-gaff.o
>  obj-$(CONFIG_HID_THRUSTMASTER)	+= hid-tmff.o
> +obj-$(CONFIG_HID_TIVO)		+= hid-tivo.o

I have fixed the mismatching names (_TIVO vs. _TIVO_SLIDE) and applied.

-- 
Jiri Kosina
SUSE Labs
