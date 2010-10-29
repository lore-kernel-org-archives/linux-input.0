From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Add Force Feedback support for EMS Trio Linker Plus II
Date: Fri, 29 Oct 2010 14:53:28 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010291451040.6879@pobox.suse.cz>
References: <4CC751B1.2010304@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:59005 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890Ab0J2Mxa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Oct 2010 08:53:30 -0400
In-Reply-To: <4CC751B1.2010304@gmx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ignaz Forster <ignaz.forster@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, 27 Oct 2010, Ignaz Forster wrote:

> This patch adds Force Feedback support for the EMS Trio Linker Plus II.
> 
> The device has connections for GameCube, PlayStation 2 and Dreamcast
> controllers, however Force Feedback is only supported for PS2 and GC
> controllers.
> When using a PS2 controller it may be necessary to press the "Analog"
> button to enable support for both motors (this behavior is identical to
> the Windows driver, I have found no way to avoid that).
> 
> Signed-off-by: Ignaz Forster <ignaz.forster@gmx.de>
> ---
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 3052e29..3134112 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -150,6 +150,22 @@ config DRAGONRISE_FF
>  	Say Y here if you want to enable force feedback support for DragonRise Inc.
>  	game controllers.
>  
> +config HID_EMS
> +	tristate "EMS Production Ltd. support"
> +	depends on USB_HID
> +	---help---
> +	Say Y here if you have EMS Production Ltd. game controllers.
> +
> +config EMS_FF
> +	bool "EMS Production Inc. force feedback support"
> +	depends on HID_EMS
> +	select INPUT_FF_MEMLESS
> +	---help---
> +	Say Y here if you want to enable force feedback support for devices by
> +	EMS Production Ltd.
> +	Currently the following devices are known to be supported:
> +	 - Trio Linker Plus II
> +

Why do we need both CONFIG_EMS and CONFIG_EMS_FF? There is no 'generic' 
EMS driver that would care for the device without FF support. So I'd say 
that introducing CONFIG_HID_EMS_FF solely should be enough (and build the 
driver only if this option is selected).


> diff --git a/drivers/hid/hid-emsff.c b/drivers/hid/hid-emsff.c
> index e69de29..c61b192 100644
> --- a/drivers/hid/hid-emsff.c
> +++ b/drivers/hid/hid-emsff.c

This is a little bit odd, as your patch should be creating a new file that 
didn't exist before, so it should rather look like

	diff --git a/drivers/hid/hid-emsff.c b/drivers/hid/hid-emsff.c
	new file mode 100644
	index 0000000..c61b192 100644
	--- /dev/null
	+++ b/drivers/hid/hid-emsff.c

otherise it couldn't be applied cleanly.

Apart from that, the driver looks fine, thanks for doing the work!

Could you please fix the issues mentioned above and re-send?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
