From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] iio: exynos-adc: add experimental touchscreen support
Date: Tue, 22 Jul 2014 19:59:58 +0530
Message-ID: <53CE7566.8020906@gmail.com>
References: <5068889.1KfVx3ksNo@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5068889.1KfVx3ksNo@wuerfel>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, heiko.stuebner-K3U4GQvHnyU@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org


On Tuesday 22 July 2014 06:33 PM, Arnd Bergmann wrote:

(...)

>   
> +static int exynos_read_s3c64xx_ts(struct iio_dev *indio_dev, int *x, int *y)
> +{
> +	struct exynos_adc *info = iio_priv(indio_dev);
> +	unsigned long timeout;
> +	int ret;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	info->read_ts = true;
> +
> +	reinit_completion(&info->completion);
> +
> +	writel(ADC_S3C2410_TSC_PULL_UP_DISABLE | ADC_TSC_AUTOPST,
> +	       ADC_V1_TSC(info->regs));
> +
> +	/* Select the ts channel to be used and Trigger conversion */
> +	info->data->start_conv(info, ADC_S3C2410_MUX_TS);
> +
> +	timeout = wait_for_completion_timeout
> +			(&info->completion, EXYNOS_ADC_TIMEOUT);

Should be properly aligned:

	wait_for_completion_timeout(&info->completion,
				    EXYNOS_ADC_TIMEOUT);

-- 
Regards,
Varka Bhadram
