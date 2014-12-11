From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/4] HID: logitech-hidpp: check name retrieval return code
Date: Thu, 11 Dec 2014 10:23:30 -0500
Message-ID: <20141211152330.GD29747@mail.corp.redhat.com>
References: <1418302280-14794-1-git-send-email-peter@lekensteyn.nl>
 <1418302280-14794-3-git-send-email-peter@lekensteyn.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47747 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933278AbaLKPXl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Dec 2014 10:23:41 -0500
Content-Disposition: inline
In-Reply-To: <1418302280-14794-3-git-send-email-peter@lekensteyn.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Wu <peter@lekensteyn.nl>
Cc: Jiri Kosina <jkosina@suse.cz>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Dec 11 2014 or thereabouts, Peter Wu wrote:
> hidpp_devicenametype_get_device_name() may return a negative value on
> protocol errors (for example, when the device is powered off).
> Explicitly check this condition to avoid a long-running loop.
> 
> (0 cannot be returned as __name_length - index > 0, but check for it
> anyway as it would otherwise result in an infinite loop.)
> 
> Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> ---

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/hid-logitech-hidpp.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 5066df8..4d72c20 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -484,10 +484,16 @@ static char *hidpp_get_device_name(struct hidpp_device *hidpp)
>  	if (!name)
>  		return NULL;
>  
> -	while (index < __name_length)
> -		index += hidpp_devicenametype_get_device_name(hidpp,
> +	while (index < __name_length) {
> +		ret = hidpp_devicenametype_get_device_name(hidpp,
>  			feature_index, index, name + index,
>  			__name_length - index);
> +		if (ret <= 0) {
> +			kfree(name);
> +			return NULL;
> +		}
> +		index += ret;
> +	}
>  
>  	return name;
>  }
> -- 
> 2.1.3
> 
