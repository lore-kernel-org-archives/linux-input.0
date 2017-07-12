From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: hid-logitech-hidpp: add NULL check on
 devm_kmemdup() return value
Date: Wed, 12 Jul 2017 09:40:35 +0200
Message-ID: <20170712074035.GF22282@mail.corp.redhat.com>
References: <20170707051213.GA6074@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756657AbdGLHkk (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Jul 2017 03:40:40 -0400
Content-Disposition: inline
In-Reply-To: <20170707051213.GA6074@embeddedgus>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Jul 07 2017 or thereabouts, Gustavo A. R. Silva wrote:
> Check return value from call to devm_kmemdup()
> in order to prevent a NULL pointer dereference.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  drivers/hid/hid-logitech-hidpp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 41b3946..501e16a 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -2732,6 +2732,9 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
>  				     hidpp_battery_props,
>  				     sizeof(hidpp_battery_props),
>  				     GFP_KERNEL);
> +	if (!battery_props)
> +		return -ENOMEM;
> +
>  	num_battery_props = ARRAY_SIZE(hidpp_battery_props) - 2;
>  
>  	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_MILEAGE)
> -- 
> 2.5.0
> 
