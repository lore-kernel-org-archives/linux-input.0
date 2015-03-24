From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: input: Fix NULL pointer dereference when
 power_supply_register fails
Date: Tue, 24 Mar 2015 12:02:41 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1503241200220.6781@pobox.suse.cz>
References: <1427124891-30540-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39965 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148AbbCXLCp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Mar 2015 07:02:45 -0400
In-Reply-To: <1427124891-30540-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Carpenter <dan.carpenter@oracle.com>

On Mon, 23 Mar 2015, Krzysztof Kozlowski wrote:

> Do not call power_supply_powers() if power_supply_register() failed
> earlier. This fixes possible NULL pointer dereference by
> power_supply_powers() in such case.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> ---
> 
> The patch was prepared on top of next-20150323. It depends on changes in
> power supply core (battery-2.6.git) so probably it should be applied to
> the battery tree.

Acked-by: Jiri Kosina <jkosina@suse.cz>

for the merge through battery-2.6.git. Thanks.

> ---
>  drivers/hid/hid-input.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index a70fa4d7f8f9..008e89bf6f3c 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -452,10 +452,10 @@ static bool hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
>  		kfree(psy_desc->name);
>  		kfree(psy_desc);
>  		dev->battery = NULL;
> +	} else {
> +		power_supply_powers(dev->battery, &dev->dev);
>  	}
>  
> -	power_supply_powers(dev->battery, &dev->dev);
> -
>  out:
>  	return true;
>  }

-- 
Jiri Kosina
SUSE Labs
