From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH v12 4/5] Input: goodix - fix reset sequence
Date: Thu, 27 Oct 2016 15:44:36 +0200
Message-ID: <1477575876.2458.23.camel@hadess.net>
References: <1473530257-7495-1-git-send-email-irina.tirdea@intel.com>
         <1473530257-7495-5-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473530257-7495-5-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, 2016-09-10 at 20:57 +0300, Irina Tirdea wrote:
> According to the Goodix datasheet, the reset sequence will leave
> the reset line set to output high. To end the selection of the I2C
> address, we just need to set the input line to low for at least
> 50 ms and then set it to input floating (already implemented by
> goodix_int_sync).
> 
> Remove setting the reset line to input from the reset sequence,
> since that is not reflected in the datasheet.
> 
> This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
> driver gt9xx.c for Android (publicly available in Android kernel
> trees for various devices).
> 
> Suggested-by: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
> Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Code looks fine. Again, would be nice to know on which devices this was
tested.

> ---
>  drivers/input/touchscreen/goodix.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c
> b/drivers/input/touchscreen/goodix.c
> index 182ff9c..6fba804 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -454,10 +454,6 @@ static int goodix_reset(struct goodix_ts_data
> *ts)
>  	usleep_range(6000, 10000);		/* T4: > 5ms */
>  
>  	/* end select I2C slave addr */
> -	error = gpiod_direction_input(ts->gpiod_rst);
> -	if (error)
> -		return error;
> -
>  	error = goodix_int_sync(ts);
>  	if (error)
>  		return error;
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
