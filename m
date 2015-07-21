From: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Subject: Re: [PATCH v2 3/4] touchscreen: colibri-vf50-ts: Add touchscreen
 support for Colibri VF50
Date: Tue, 21 Jul 2015 16:43:36 +0200
Message-ID: <40d7c372e64c7f25b7df3e48930386de@agner.ch>
References: <cover.1437058481.git.maitysanchayan@gmail.com>
 <26748bd9a7bde7c2304b6b971f1150bb575e4938.1437058481.git.maitysanchayan@gmail.com>
 <20150717234242.GJ39282@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150717234242.GJ39282@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

As the original author of the driver I have some remarks to your review

On 2015-07-18 01:42, Dmitry Torokhov wrote:
>> +		/*
>> +		 * If touch pressure is too low, stop measuring and reenable
>> +		 * touch detection
>> +		 */
>> +		if (val_p < min_pressure || val_p > 2000)
>> +			break;

This is where the modules touch pressure is used to stop the measurement
process and switch back to interrupt mode. See my remarks at the end.

>> +
>> +		/*
>> +		 * The pressure may not be enough for the first x and the
>> +		 * second y measurement, but, the pressure is ok when the
>> +		 * driver is doing the third and fourth measurement. To
>> +		 * take care of this, we drop the first measurement always.
>> +		 */
>> +		if (discard_val_on_start) {
>> +			discard_val_on_start = false;
>> +		} else {
>> +			/*
>> +			 * Report touch position and sleep for
>> +			 * next measurement
>> +			 */
>> +			input_report_abs(vf50_ts->ts_input,
>> +					ABS_X, VF_ADC_MAX - val_x);
>> +			input_report_abs(vf50_ts->ts_input,
>> +					ABS_Y, VF_ADC_MAX - val_y);
>> +			input_report_abs(vf50_ts->ts_input,
>> +					ABS_PRESSURE, val_p);
>> +			input_report_key(vf50_ts->ts_input, BTN_TOUCH, 1);
>> +			input_sync(vf50_ts->ts_input);
>> +		}
>> +
>> +		msleep(10);
>> +	}
>> +
>> +	/* Report no more touch, reenable touch detection */
>> +	input_report_abs(vf50_ts->ts_input, ABS_PRESSURE, 0);
>> +	input_report_key(vf50_ts->ts_input, BTN_TOUCH, 0);
>> +	input_sync(vf50_ts->ts_input);
>> +
>> +	vf50_ts_enable_touch_detection(vf50_ts);
>> +
>> +	/* Wait for the pull-up to be stable on high */
>> +	msleep(10);
>> +
>> +	/* Reenable IRQ to detect touch */
>> +	enable_irq(vf50_ts->pen_irq);
>> +
>> +	dev_dbg(dev, "Reenabled touch detection interrupt\n");
>> +}
>> +
>> +static irqreturn_t vf50_ts_touched(int irq, void *dev_id)
>> +{
>> +	struct vf50_touch_device *vf50_ts = (struct vf50_touch_device *)dev_id;
>> +	struct device *dev = &vf50_ts->pdev->dev;
>> +
>> +	dev_dbg(dev, "Touch detected, start worker thread\n");
>> +
>> +	disable_irq_nosync(irq);
>> +
>> +	/* Disable the touch detection plates */
>> +	gpiod_set_value(vf50_ts->gpio_ym, 0);
>> +
>> +	/* Let the platform mux to default state in order to mux as ADC */
>> +	pinctrl_pm_select_default_state(dev);
>> +
>> +	queue_work(vf50_ts->ts_workqueue, &vf50_ts->ts_work);
> 
> If you convert this to a threaded interrupt you won't need to
> disable/reenable interrupt or queue work. You should also be able to use
> gpiod_set_value_cansleep() extending the range of ways the controller
> could be connected to systems.
> 

I'm not sure if a threaded interrupt is the right thing here. While the
pen is on the touchscreen (which can be for several seconds)
measurements have to be made in a continuous loop. Is it ok for a
threaded interrupt to run that long?

I'm also not sure if it is really safe to _not_ disable the pen down
GPIO interrupt. If we get a interrupt while measuring, we should ignore
that interrupt.

On resistive touch screens the pen down works by relying on the high
resistance between the two plates while not being touched. The X-Plate
will be pulled high, the Y-Plate is strong GND. We measure on the
X-Plate (XM) which is high too. As soon as the plate is touched, XM will
be GND (since the resistance over the two plates is way lower then the
pull-up resistance). An interrupt on falling edge will trigger.

Now the measuring takes place, X, Y and pressure by using different
measuring methods.

While Y-Plate measurement the same GPIO interupt pin is used for ADC
measurement! The voltage on that pin will at that point depend on the
Y-Position of the pen position... Is it guaranteed that the GPIO
interrupt is not fired? I guess because we muxed to ADC at that point,
it won't lead to a second (spurious) interrupt... However this is a
thing which needs to be checked before removing interrupt enable/disable
calls.

>> +};
>> +
>> +module_platform_driver(vf50_touch_driver);
>> +
>> +module_param(min_pressure, int, 0600);
>> +MODULE_PARM_DESC(min_pressure, "Minimum pressure for touch detection");
> 
> I'd rather let userspace figure out what it recognizes as valid touch.
> 

This is value is used as the termination condition for the measurement
loop. It essentially defines at which pressure level we stop measuring
X/Y values. Depending on the size and resistance of the plates. However,
it is not safe to measure even at low/no pressure, since then we would
only get maximum X/Y values. Hence it is crucial that this value is
choosen properly, otherwise the driver will report "wrong" X/Y values.

Since we use the value for measurement termination, we need it in kernel
space. As far as I know we do not get such a value from user space.

--
Stefan

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
