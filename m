From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 9/9] Staging/iio: add TODO reminder
Date: Tue, 01 Oct 2013 12:14:48 +0100
Message-ID: <524AAEA8.4090106@kernel.org>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <1379946998-23041-10-git-send-email-jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379946998-23041-10-git-send-email-jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 09/23/13 15:36, Juergen Beisert wrote:
> Some things have still to be done to the LRADC driver.
> 
> Signed-off-by: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> CC: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> CC: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> CC: devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org
> CC: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> CC: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Applied to the togreg branch of iio.git

Thanks.

Please check over the entire series as it was more than a little
fiddly to apply and I may well have messed it up!

Jonathan
> ---
>  drivers/staging/iio/TODO | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
> index 04c2326..c22a0ed 100644
> --- a/drivers/staging/iio/TODO
> +++ b/drivers/staging/iio/TODO
> @@ -13,6 +13,17 @@ Would be nice
>  3) Expand device set. Lots of other maxim adc's have very
>     similar interfaces.
>  
> +MXS LRADC driver:
> +This is a classic MFD device as it combines the following subdevices
> + - touchscreen controller (input subsystem related device)
> + - general purpose ADC channels
> + - battery voltage monitor (power subsystem related device)
> + - die temperature monitor (thermal management)
> +
> +At least the battery voltage and die temperature feature is required in-kernel
> +by a driver of the SoC's battery charging unit to avoid any damage to the
> +silicon and the battery.
> +
>  TSL2561
>  Would be nice
>  1) Open question of userspace vs kernel space balance when
> 
