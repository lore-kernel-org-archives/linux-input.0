From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: plantronics: fix Kconfig default
Date: Mon, 16 Mar 2015 16:16:51 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1503161616310.25438@pobox.suse.cz>
References: <20150201204204.76467dec@kant>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150201204204.76467dec@kant>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 1 Feb 2015, Stefan Richter wrote:

> This driver didn't exist until before v3.19.
> Why would suddenly everybody want to build it?
> 
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> ---
>  drivers/hid/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -628,7 +628,6 @@ config HID_PICOLCD_CIR
>  
>  config HID_PLANTRONICS
>  	tristate "Plantronics USB HID Driver"
> -	default !EXPERT
>  	depends on HID
>  	---help---
>  	Provides HID support for Plantronics telephony devices.

That was probably copy/paste kind of bug which I overlooked. Applied to 
for-4.1/upstream, thanks.

-- 
Jiri Kosina
SUSE Labs
