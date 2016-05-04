From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 3/3] iio: mxs-lradc: disable only masked channels in
 mxs_lradc_hw_stop
Date: Wed, 4 May 2016 10:39:52 +0100
Message-ID: <240d09cb-8df3-01dd-ee84-6f5dd8cad64a@kernel.org>
References: <1461441479-23218-1-git-send-email-stefan.wahren@i2se.com>
 <1461441479-23218-4-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461441479-23218-4-git-send-email-stefan.wahren-eS4NqCHxEME@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Juergen Borleis <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 23/04/16 20:57, Stefan Wahren wrote:
> Disabling of the touchscreen IRQs should be done in
> mxs_lradc_disable_ts. So disable only the masked virtual channels
> in mxs_lradc_hw_stop and finally remove the unused function
> mxs_lradc_irq_en_mask.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
> Reviewed-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> Tested-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/adc/mxs-lradc.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
> index 90242ba..b84d37c 100644
> --- a/drivers/iio/adc/mxs-lradc.c
> +++ b/drivers/iio/adc/mxs-lradc.c
> @@ -373,13 +373,6 @@ static u32 mxs_lradc_plate_mask(struct mxs_lradc *lradc)
>  	return LRADC_CTRL0_MX28_PLATE_MASK;
>  }
>  
> -static u32 mxs_lradc_irq_en_mask(struct mxs_lradc *lradc)
> -{
> -	if (lradc->soc == IMX23_LRADC)
> -		return LRADC_CTRL1_MX23_LRADC_IRQ_EN_MASK;
> -	return LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK;
> -}
> -
>  static u32 mxs_lradc_irq_mask(struct mxs_lradc *lradc)
>  {
>  	if (lradc->soc == IMX23_LRADC)
> @@ -1496,7 +1489,9 @@ static void mxs_lradc_hw_stop(struct mxs_lradc *lradc)
>  {
>  	int i;
>  
> -	mxs_lradc_reg_clear(lradc, mxs_lradc_irq_en_mask(lradc), LRADC_CTRL1);
> +	mxs_lradc_reg_clear(lradc,
> +		lradc->buffer_vchans << LRADC_CTRL1_LRADC_IRQ_EN_OFFSET,
> +		LRADC_CTRL1);
>  
>  	for (i = 0; i < LRADC_MAX_DELAY_CHANS; i++)
>  		mxs_lradc_reg_wrt(lradc, 0, LRADC_DELAY(i));
> 
