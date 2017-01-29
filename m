From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH v13 2/5] iio: adc: mxs-lradc: Add support for adc driver
Date: Mon, 30 Jan 2017 00:35:14 +0100 (CET)
Message-ID: <1356490394.76350.1485732914272@email.1und1.de>
References: <cover.1485711797.git.ksenija.stanojevic@gmail.com>
 <7ceea639e53d0517a3073229989f4f4ef0b17b84.1485711797.git.ksenija.stanojevic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7ceea639e53d0517a3073229989f4f4ef0b17b84.1485711797.git.ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Ksenija,

> Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> hat am 29. Januar 2017 um 19:04 geschrieben:
> 
> 
> Add support for sixteen-channel 12-bit resolution ADC and its functions,
> which include general-purpose ADC readings, battery voltage measurement,
> and die temperature measurement.
> 
> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Reviewed-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> ---
> ...
> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> new file mode 100644
> index 0000000..cc8d6af
> --- /dev/null
> +++ b/drivers/iio/adc/mxs-lradc-adc.c
> @@ -0,0 +1,843 @@
> ...
> +
> +#define SHOW_SCALE_AVAILABLE_ATTR(ch)					\
> +static IIO_DEVICE_ATTR(in_voltage##ch##_scale_available, S_IRUGO,	\
> +		       mxs_lradc_adc_show_scale_avail, NULL, ch)
> +

checkpatch complains here:

ERROR: Macros with complex values should be enclosed in parentheses
#498: FILE: drivers/iio/adc/mxs-lradc-adc.c:343:
+#define SHOW_SCALE_AVAILABLE_ATTR(ch)					\
+static IIO_DEVICE_ATTR(in_voltage##ch##_scale_available, S_IRUGO,	\
+		       mxs_lradc_adc_show_scale_avail, NULL, ch)

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
#499: FILE: drivers/iio/adc/mxs-lradc-adc.c:344:
+static IIO_DEVICE_ATTR(in_voltage##ch##_scale_available, S_IRUGO,	\

total: 1 errors, 2 warnings, 869 lines checked

But the iio values on Olinuxino Maxi looks good.

Tested-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
