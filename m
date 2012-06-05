From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] drivers/input/mouse: Fix a "make randconfig" warning at
 MOUSE_APPLETOUCH dependency with USB_SUPPORT and USB_ARCH_HAS_HCD
Date: Tue, 5 Jun 2012 11:41:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1206051140540.5478@pobox.suse.cz>
References: <1337037329-23618-1-git-send-email-devendra.aaru@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44376 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757898Ab2FEJlc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Jun 2012 05:41:32 -0400
In-Reply-To: <1337037329-23618-1-git-send-email-devendra.aaru@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Devendra Naga <devendra.aaru@gmail.com>
Cc: Paul Parsons <lost.distance@yahoo.com>, Jan Steinhoff <mail@jan-steinhoff.de>, linux-input@vger.kernel.org

On Tue, 15 May 2012, Devendra Naga wrote:

> From: Devendra Naga <devendra@devendra.(none)>
> 
> when ran make randconfig got the warning
> 
> "MOUSE_APPLETOUCH selects USB which has unmet direct dependencies (USB_SUPPORT && USB_ARCH_HAS_HCD)"
> 
> Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
> ---
>  drivers/input/mouse/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
> index cd6268c..044378f 100644
> --- a/drivers/input/mouse/Kconfig
> +++ b/drivers/input/mouse/Kconfig
> @@ -152,7 +152,7 @@ config MOUSE_SERIAL
>  config MOUSE_APPLETOUCH
>  	tristate "Apple USB Touchpad support"
>  	depends on USB_ARCH_HAS_HCD
> -	select USB
> +	select USB if USB_SUPPORT && USB_ARCH_HAS_HCD

Depending on USB_ARCH_HAS_HCD and then having it as a part of 'if' 
condition seems odd.

Thanks,

-- 
Jiri Kosina
SUSE Labs
