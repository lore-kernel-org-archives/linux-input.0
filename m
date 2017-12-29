From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 11/14] iio: adc: at91-sama5d2_adc: optimize scan index
 for diff channels
Date: Fri, 29 Dec 2017 16:24:36 +0000
Message-ID: <20171229162436.5fe18421@archlinux>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
        <1513955241-10985-12-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1513955241-10985-12-git-send-email-eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eugen Hristev <eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, 22 Dec 2017 17:07:18 +0200
Eugen Hristev <eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org> wrote:

> Optimize the scan index for the differential channels. Before, it
> was single channel count + index of the first single channel
> number of the differential pair. (e.g. 11+0, +2, +4, etc.)
> Divide that number by two (since it's always even), and add it up
> as a scan index to have consecutive numbered channels in the
> index.
Why?  This is odd as it stands, but that isn't a strong enough reason
to fix it.

This is making a userspace ABI change.  We need a very strong
argument for why it is necessary and also why existing userspace
won't care.

> 
> Signed-off-by: Eugen Hristev <eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 7b9febc..9610393 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -209,7 +209,7 @@
>  		.channel = num,						\
>  		.channel2 = num2,					\
>  		.address = addr,					\
> -		.scan_index = num + AT91_SAMA5D2_SINGLE_CHAN_CNT,	\
> +		.scan_index = (num >> 1) + AT91_SAMA5D2_SINGLE_CHAN_CNT,\
>  		.scan_type = {						\
>  			.sign = 's',					\
>  			.realbits = 12,					\
