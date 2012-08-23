From: Matthias Kaehlcke <matthias.list-RprLehDfhQ3k1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 4/5] IIO : ADC: tiadc: Add support of TI's ADC driver
Date: Thu, 23 Aug 2012 21:02:39 +0200
Message-ID: <20120823190239.GF27787@darwin>
References: <1345719021-22835-1-git-send-email-rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1345719021-22835-1-git-send-email-rachna-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

El Thu, Aug 23, 2012 at 04:20:21PM +0530 Patil, Rachna ha dit:

> This patch adds support for TI's ADC driver.
> This is a multifunctional device.
> Analog input lines are provided on which
> voltage measurements can be carried out.
> You can have upto 8 input lines.
> 
> Signed-off-by: Patil, Rachna <rachna-l0cyMroinI0@public.gmane.org>
> ---
>
> diff --git a/drivers/iio/adc/ti_adc.c b/drivers/iio/adc/ti_adc.c
> ...
> +static int __devinit tiadc_probe(struct platform_device *pdev)
> +{
> +	struct iio_dev		*idev;
> +	int			err;
> +	struct adc_device	*adc_dev = NULL;
> +	struct ti_tscadc_dev	*tscadc_dev = pdev->dev.platform_data;
> +	struct mfd_tscadc_board	*board_data;
> +
> +	board_data = (struct mfd_tscadc_board *)tscadc_dev->dev->platform_data;
> +	if (!board_data) {
> +		dev_err(tscadc_dev->dev, "Could not find platform data\n");
> +		return -EINVAL;
> +	}
> +
> +	idev = iio_device_alloc(sizeof(struct adc_device));
> +	if (idev == NULL) {
> +		dev_err(&pdev->dev, "failed to allocate iio device.\n");
> +		err = -ENOMEM;
> +		goto err_ret;
> +	}
> +	adc_dev = iio_priv(idev);
> +
> +	tscadc_dev->adc = adc_dev;
> +	adc_dev->mfd_tscadc = tscadc_dev;
> +	adc_dev->idev = idev;
> +	adc_dev->adc_channels = board_data->adc_init->adc_channels;
> +
> +	idev->dev.parent = &pdev->dev;
> +	idev->name = dev_name(&pdev->dev);
> +	idev->modes = INDIO_DIRECT_MODE;
> +	idev->info = &tiadc_info;
> +
> +	adc_step_config(adc_dev);
> +
> +	err = tiadc_channel_init(idev, adc_dev);
> +	if (err < 0)
> +		goto err_fail;
> +
> +	err = iio_device_register(idev);
> +	if (err)
> +		goto err_free_channels;
> +
> +	dev_info(&pdev->dev, "attached adc driver\n");
> +	platform_set_drvdata(pdev, idev);
> +
> +	return 0;
> +
> +err_free_channels:
> +	tiadc_channel_remove(idev);
> +err_fail:
> +	iio_device_unregister(idev);
> +	iio_device_free(idev);
> +err_ret:
> +	platform_set_drvdata(pdev, NULL);

not necessary, the platform device doesn't exist anymore

> +	iio_device_free(idev);

already done some lines above and could be executed without having
allocated the iio device (when iio_device_alloc() fails)

> +static int __devexit tiadc_remove(struct platform_device *pdev)
> +{
> +	struct ti_tscadc_dev   *tscadc_dev = pdev->dev.platform_data;
> +	struct adc_device	*adc_dev = tscadc_dev->adc;
> +	struct iio_dev		*idev = adc_dev->idev;
> +
> +	iio_device_unregister(idev);
> +	tiadc_channel_remove(idev);
> +
> +	tscadc_dev->adc = NULL;
> +
> +	iio_device_free(idev);
> +	platform_set_drvdata(pdev, NULL);

see above

best regards

-- 
Matthias Kaehlcke
Embedded Linux Developer
Amsterdam

               If sharing a thing in no way diminishes it,
               it is not rightly owned if it is not shared
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
