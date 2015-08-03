From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] HID: hid-input: Fix accessing freed memory during
 device disconnect
Date: Mon, 3 Aug 2015 13:31:32 -0700
Message-ID: <20150803203132.GE38878@dtor-ws>
References: <1438581450-20728-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36206 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932251AbbHCUbh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2015 16:31:37 -0400
Content-Disposition: inline
In-Reply-To: <1438581450-20728-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Jiri Kosina <jkosina@suse.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, sre@kernel.org, linux-pm@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>, stable@vger.kernel.org

On Mon, Aug 03, 2015 at 02:57:30PM +0900, Krzysztof Kozlowski wrote:
> During unbinding the driver was dereferencing a pointer to memory
> already freed by power_supply_unregister().
> 
> Driver was freeing its internal description of battery through pointers
> stored in power_supply structure. However, because the core owns the
> power supply instance, after calling power_supply_unregister() this
> memory is freed and the driver cannot access these members.
> 
> Fix this by storing the pointer to internal description of battery in a
> local variable before calling power_supply_unregister(), so the pointer
> remains valid.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reported-by: H.J. Lu <hjl.tools@gmail.com>
> Fixes: 297d716f6260 ("power_supply: Change ownership from driver to core")
> Cc: <stable@vger.kernel.org>
> 

FWIW:

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> Changes since v2:
> 1. Add missing 'const'.
> 
> Changes since v1:
> 1. Re-work idea, use local variable instead of devm-like functions
>    (pointed out by Dmitry Torokhov).
> 2. Adjusted subject and commit message.
> ---
>  drivers/hid/hid-input.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 14aebe483219..53aeaf6252c7 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -462,12 +462,15 @@ out:
>  
>  static void hidinput_cleanup_battery(struct hid_device *dev)
>  {
> +	const struct power_supply_desc *psy_desc;
> +
>  	if (!dev->battery)
>  		return;
>  
> +	psy_desc = dev->battery->desc;
>  	power_supply_unregister(dev->battery);
> -	kfree(dev->battery->desc->name);
> -	kfree(dev->battery->desc);
> +	kfree(psy_desc->name);
> +	kfree(psy_desc);
>  	dev->battery = NULL;
>  }
>  #else  /* !CONFIG_HID_BATTERY_STRENGTH */
> -- 
> 1.9.1
> 

-- 
Dmitry
