From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wacom - Export battery scope
Date: Tue, 15 Oct 2013 23:36:04 -0700
Message-ID: <20131016063604.GC4282@core.coreip.homeip.net>
References: <1381693762.21482.2.camel@nuvo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:50110 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500Ab3JPGgI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Oct 2013 02:36:08 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so481670pab.22
        for <linux-input@vger.kernel.org>; Tue, 15 Oct 2013 23:36:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1381693762.21482.2.camel@nuvo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, peter.hutterer@who-t.net, chris@cnpbagwell.com, killertofu@gmail.com

On Sun, Oct 13, 2013 at 09:49:22PM +0200, Bastien Nocera wrote:
> 
> This will stop UPower from detecting the tablet as a power supply,
> and using its battery status to hibernate or switch off the machine.
> 
> https://bugs.freedesktop.org/show_bug.cgi?id=70321
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>


Applied, thank you.

> ---
>  drivers/input/tablet/wacom_sys.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
> index 79b69ea..e53416a 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -1031,6 +1031,7 @@ static void wacom_destroy_leds(struct wacom *wacom)
>  }
>  
>  static enum power_supply_property wacom_battery_props[] = {
> +	POWER_SUPPLY_PROP_SCOPE,
>  	POWER_SUPPLY_PROP_CAPACITY
>  };
>  
> @@ -1042,6 +1043,9 @@ static int wacom_battery_get_property(struct power_supply *psy,
>  	int ret = 0;
>  
>  	switch (psp) {
> +		case POWER_SUPPLY_PROP_SCOPE:
> +			val->intval = POWER_SUPPLY_SCOPE_DEVICE;
> +			break;
>  		case POWER_SUPPLY_PROP_CAPACITY:
>  			val->intval =
>  				wacom->wacom_wac.battery_capacity * 100 / 31;
> -- 
> 1.8.3.1
> 
> 

-- 
Dmitry
