From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] HID: ACRUX - fix enabling force feedback support
Date: Thu, 4 Aug 2011 15:26:39 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1108041526230.32288@pobox.suse.cz>
References: <1312442757-31241-1-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46641 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753989Ab1HDN0l (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 4 Aug 2011 09:26:41 -0400
In-Reply-To: <1312442757-31241-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Sergei Kolzun <x0r@dv-life.ru>

On Thu, 4 Aug 2011, Dmitry Torokhov wrote:

> From: Sergei Kolzun <x0r@dv-life.ru>
> 
> The config option needs to be a 'bool' and not a tristate, otheriwse
> force feedback support never makes it into the module.
> 
> Signed-off-by: Sergei Kolzun <x0r@dv-life.ru>
> Cc: stable@kernel.org
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>  drivers/hid/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 36ca465..a1f3c0d 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -69,7 +69,7 @@ config HID_ACRUX
>  	Say Y here if you want to enable support for ACRUX game controllers.
>  
>  config HID_ACRUX_FF
> -	tristate "ACRUX force feedback support"
> +	bool "ACRUX force feedback support"
>  	depends on HID_ACRUX
>  	select INPUT_FF_MEMLESS
>  	---help---

I have applied both patches, thanks Dmitry and Sergei!

-- 
Jiri Kosina
SUSE Labs
