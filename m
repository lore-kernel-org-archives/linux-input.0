From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/5] USB: HID: SRW-S1 Gaming Wheel Driver
Date: Thu, 31 Jan 2013 16:23:24 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1301311622430.23853@pobox.suse.cz>
References: <alpine.LNX.2.00.1301291057170.23853@pobox.suse.cz> <1359644830-3274-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43413 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754501Ab3AaPXc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Jan 2013 10:23:32 -0500
In-Reply-To: <1359644830-3274-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rosegardener@freeode.co.uk

On Thu, 31 Jan 2013, Simon Wood wrote:

> Add support the SRW-S1 by patching HID descriptor to read axis
> as Generic Desktop X, Y and Z (rather than Usage page being
> 'Simulation').
> 
> Signed-off-by: Simon Wood <simon@mungewell.org>
> Tested-by: John Murphy <rosegardener@freeode.co.uk>
> ---
>  drivers/hid/Kconfig                 |    6 ++++
>  drivers/hid/Makefile                |    1 +
>  drivers/hid/hid-core.c              |    1 +
>  drivers/hid/hid-ids.h               |    3 ++
>  drivers/hid/hid-steelseries-srws1.c |   58 +++++++++++++++++++++++++++++++++++
>  5 files changed, 69 insertions(+)
>  create mode 100644 drivers/hid/hid-steelseries-srws1.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index e7d6a13..37df92f 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -596,6 +596,12 @@ config HID_SPEEDLINK
>  	---help---
>  	Support for Speedlink Vicious and Divine Cezanne mouse.
>  
> +config HID_STEELSERIES_SRWS1
> +	tristate "Steelseries SRW-S1 steering wheel support"
> +	depends on USB_HID
> +	---help---
> +	Support for Steelseries SRW-S1 steering wheel
> +
>  config HID_SUNPLUS
>  	tristate "Sunplus wireless desktop"
>  	depends on USB_HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index b622157..bbebe0a 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -101,6 +101,7 @@ obj-$(CONFIG_HID_SAMSUNG)	+= hid-samsung.o
>  obj-$(CONFIG_HID_SMARTJOYPLUS)	+= hid-sjoy.o
>  obj-$(CONFIG_HID_SONY)		+= hid-sony.o
>  obj-$(CONFIG_HID_SPEEDLINK)	+= hid-speedlink.o
> +obj-$(CONFIG_HID_STEELSERIES_SRWS1)    	+= hid-steelseries-srws1.o

Simon,

thanks for respin of the patchset.

I thought we converged to hid-steelseries name in the end originally?

If you agree, I'll change it and apply.

-- 
Jiri Kosina
SUSE Labs
