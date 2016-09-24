From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/5] input: touchscreen: support Allwinner SoCs'
 touchscreen
Date: Sat, 24 Sep 2016 11:39:54 -0700
Message-ID: <20160924183954.GE40187@dtor-ws>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-5-git-send-email-quentin.schulz@free-electrons.com>
 <20160720172532.GE25655@dtor-ws>
 <ca39a2e7-6116-6f6e-3f61-78abfdefcbb7@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ca39a2e7-6116-6f6e-3f61-78abfdefcbb7-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Quentin,

On Sat, Sep 24, 2016 at 08:26:08PM +0200, Quentin Schulz wrote:
> Hi Dimitry,
> 
> Sorry for the (long) delay, I did not have time to work on it. I'll
> mainly work in my free time now.
> 
> On 20/07/2016 19:25, Dmitry Torokhov wrote:
> > Hi Quentin,
> > 
> > On Wed, Jul 20, 2016 at 10:29:10AM +0200, Quentin Schulz wrote:
> >> This adds support for Allwinner SoCs' (A10, A13 and A31) resistive
> >> touchscreen. This driver is probed by the MFD sunxi-gpadc-mfd.
> >>
> >> This driver uses ADC channels exposed through the IIO framework by
> >> sunxi-gpadc-iio to get its data. When opening this input device, it will
> >> start buffering in the ADC driver and enable a TP_UP_PENDING irq. The ADC
> >> driver will fill in a buffer with all data and call the callback the input
> >> device associated with this buffer. The input device will then read the
> >> buffer two by two and send X and Y coordinates to the input framework based
> >> on what it received from the ADC's buffer. When closing this input device,
> >> the buffering is stopped.
> >>
> >> Note that locations in the first received buffer after an TP_UP_PENDING irq
> >> occurred are unreliable, thus dropped.
> >>
> >> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >> ---
> [...]
> >> +	info->buffer = iio_channel_get_all_cb(&pdev->dev,
> >> +					      &sunxi_gpadc_ts_callback,
> >> +					      (void *)info);
> > 
> > Any chance we could introduce devm-variant here? If you do not want to
> > wait for IIO to add it you can temporarily add call
> > devm_add_action_or_reset() after getting channels and remove it when IIO
> > API catches up.
> > 
> 
> Something like:
> 
> release_iio_channels(void* data)
> {
> 	struct sunxi_gpadc_ts *info = data;
> 	iio_channel_release_all_cb(info->buffer);
> }
> 
> [...]
> 	info->buffer = iio_channel_get_all_cb(&pdev->dev,
> 					      &sunxi_gpadc_ts_callback,
> 					      (void *)info);
> 	ret = devm_add_action_or_reset(&pdev->dev,
> 				       release_iio_channels,
> 				       (void *)info);
> 	if (ret)
> 		return ret;
> 
> ?
> 
> May I know why you prefer that way instead of explicit removing in
> remove function of the platform device? I understand for devm-variant
> already in the framework but I am curious for this one.

So that you release all resources in the same order they were allocated.
When mixing devm and non-devm allocation/release order is often
incorrect.

> 
> [...]
> >> +static int sunxi_gpadc_ts_remove(struct platform_device *pdev)
> >> +{
> >> +	struct sunxi_gpadc_ts *info = platform_get_drvdata(pdev);
> >> +
> >> +	iio_channel_stop_all_cb(info->buffer);
> >> +	iio_channel_release_all_cb(info->buffer);
> >> +
> >> +	disable_irq(info->tp_up_irq);
> > 
> > You are mixing devm and non-devm so your unwind order is completely out
> > of wack. If input device is opened while you are unloading (or
> > unbinding) the dirver, then you'll release channels, then input device's
> > close() will be called, which will try to stop the IIO channels again
> > and disable IRQ yet again.
> > 
> 
> Do you mean that I should be using exclusively devm or non-devm functions?

Yes. Sometimes you can get away with mixing style (you have all devm
resources allocated first, then non-devm), but it is much clearer and
safer if you use one style or another exclusively.

> Do you mean input device's close will always be called when
> unloading/unbinding the driver?

If ->open() has been called() then input core will ensure that ->close()
is called as part of input_unregister_device(). If ->open() has not been
called, then ->close() will not be called either.

Thanks.

-- 
Dmitry
