From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hid-logitech-hidpp: add NULL check on devm_kmemdup()
 return value
Date: Thu, 20 Jul 2017 15:46:18 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1707201546030.4705@cbobk.fhfr.pm>
References: <20170707051213.GA6074@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42504 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934130AbdGTNqU (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 20 Jul 2017 09:46:20 -0400
In-Reply-To: <20170707051213.GA6074@embeddedgus>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jikos@jikos.cz>

On Fri, 7 Jul 2017, Gustavo A. R. Silva wrote:

> Check return value from call to devm_kmemdup()
> in order to prevent a NULL pointer dereference.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
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

Applied to for-4.13/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

