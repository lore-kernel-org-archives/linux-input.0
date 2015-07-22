From: maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: Re: [PATCH v2 3/4] touchscreen: colibri-vf50-ts: Add touchscreen
 support for Colibri VF50
Date: Wed, 22 Jul 2015 11:20:16 +0530
Message-ID: <20150722055016.GA6495@Sanchayan-Arch.toradex.int>
References: <cover.1437058481.git.maitysanchayan@gmail.com>
 <26748bd9a7bde7c2304b6b971f1150bb575e4938.1437058481.git.maitysanchayan@gmail.com>
 <20150717234242.GJ39282@dtor-ws>
 <40d7c372e64c7f25b7df3e48930386de@agner.ch>
 <20150721172044.GC39076@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150721172044.GC39076@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 15-07-21 10:20:44, Dmitry Torokhov wrote:
> Hi Stefan,
> 
> On Tue, Jul 21, 2015 at 04:43:36PM +0200, Stefan Agner wrote:
> > Hi Dmitry,
> > 
> > As the original author of the driver I have some remarks to your review
> > 
> > On 2015-07-18 01:42, Dmitry Torokhov wrote:
> > >> +		/*
> > >> +		 * If touch pressure is too low, stop measuring and reenable
> > >> +		 * touch detection
> > >> +		 */
> > >> +		if (val_p < min_pressure || val_p > 2000)
> > >> +			break;
> > 
> > This is where the modules touch pressure is used to stop the measurement
> > process and switch back to interrupt mode. See my remarks at the end.
> > 
> > >> +
> > >> +		/*
> > >> +		 * The pressure may not be enough for the first x and the
> > >> +		 * second y measurement, but, the pressure is ok when the
> > >> +		 * driver is doing the third and fourth measurement. To
> > >> +		 * take care of this, we drop the first measurement always.
> > >> +		 */
> > >> +		if (discard_val_on_start) {
> > >> +			discard_val_on_start = false;
> > >> +		} else {
> > >> +			/*
> > >> +			 * Report touch position and sleep for
> > >> +			 * next measurement
> > >> +			 */
> > >> +			input_report_abs(vf50_ts->ts_input,
> > >> +					ABS_X, VF_ADC_MAX - val_x);
> > >> +			input_report_abs(vf50_ts->ts_input,
> > >> +					ABS_Y, VF_ADC_MAX - val_y);
> > >> +			input_report_abs(vf50_ts->ts_input,
> > >> +					ABS_PRESSURE, val_p);
> > >> +			input_report_key(vf50_ts->ts_input, BTN_TOUCH, 1);
> > >> +			input_sync(vf50_ts->ts_input);
> > >> +		}
> > >> +
> > >> +		msleep(10);
> > >> +	}
> > >> +
> > >> +	/* Report no more touch, reenable touch detection */
> > >> +	input_report_abs(vf50_ts->ts_input, ABS_PRESSURE, 0);
> > >> +	input_report_key(vf50_ts->ts_input, BTN_TOUCH, 0);
> > >> +	input_sync(vf50_ts->ts_input);
> > >> +
> > >> +	vf50_ts_enable_touch_detection(vf50_ts);
> > >> +
> > >> +	/* Wait for the pull-up to be stable on high */
> > >> +	msleep(10);
> > >> +
> > >> +	/* Reenable IRQ to detect touch */
> > >> +	enable_irq(vf50_ts->pen_irq);
> > >> +
> > >> +	dev_dbg(dev, "Reenabled touch detection interrupt\n");
> > >> +}
> > >> +
> > >> +static irqreturn_t vf50_ts_touched(int irq, void *dev_id)
> > >> +{
> > >> +	struct vf50_touch_device *vf50_ts = (struct vf50_touch_device *)dev_id;
> > >> +	struct device *dev = &vf50_ts->pdev->dev;
> > >> +
> > >> +	dev_dbg(dev, "Touch detected, start worker thread\n");
> > >> +
> > >> +	disable_irq_nosync(irq);
> > >> +
> > >> +	/* Disable the touch detection plates */
> > >> +	gpiod_set_value(vf50_ts->gpio_ym, 0);
> > >> +
> > >> +	/* Let the platform mux to default state in order to mux as ADC */
> > >> +	pinctrl_pm_select_default_state(dev);
> > >> +
> > >> +	queue_work(vf50_ts->ts_workqueue, &vf50_ts->ts_work);
> > > 
> > > If you convert this to a threaded interrupt you won't need to
> > > disable/reenable interrupt or queue work. You should also be able to use
> > > gpiod_set_value_cansleep() extending the range of ways the controller
> > > could be connected to systems.
> > > 
> > 
> > I'm not sure if a threaded interrupt is the right thing here. While the
> > pen is on the touchscreen (which can be for several seconds)
> > measurements have to be made in a continuous loop. Is it ok for a
> > threaded interrupt to run that long?
> 
> Yes, why not? Threaded interrupt is simply a kernel thread that is woken
> when hard interrupt handler tells it to wake up. Very similar to
> interrupt + work queue, except that the kernel manages interactions
> properly for you. There are several drivers in kernel that do that, for
> example auo-pixcir-ts.c or tsc2007.c
> 
> > 
> > I'm also not sure if it is really safe to _not_ disable the pen down
> > GPIO interrupt. If we get a interrupt while measuring, we should ignore
> > that interrupt.
> 
> The interrupt management core (you'll have to annotate it as
> IRQF_ONESHOT) will make sure it stays masked properly until the threaded
> handler completes so you do not need to disable it explicitly.

(snip)

I tried the IRQ threaded implementation. From your reply, I can see my first
implementation was wrong in the sense that I did not use the IRQF_ONESHOT flag.
The touch response time was not good in this case, however thats to be expected
in this case from what I understand now.

With the IRQF_ONESHOT specified the response time is much better compared to
what I was seeing above, but, I still feel it is not the same as with IRQ handler
plus workqueue approach. However I have no idea how to quantify this.

So I tried explicit enabling/disabling of IRQ and to me it seems the response
slightly improves compared to IRQF_ONESHOT and the touch handling is better
compared to the IRQF_ONESHOT approach. Again however I have no idea how to
quantify it.

Perhaps we go for a request threaded irq but keep the explicit enabling/disabling
of IRQ? Will that be acceptable?

- Sanchayan.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
