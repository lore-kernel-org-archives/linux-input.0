From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 3/4] touchscreen: colibri-vf50-ts: Add touchscreen
 support for Colibri VF50
Date: Mon, 3 Aug 2015 14:04:09 -0700
Message-ID: <20150803210409.GG38878@dtor-ws>
References: <cover.1437058481.git.maitysanchayan@gmail.com>
 <26748bd9a7bde7c2304b6b971f1150bb575e4938.1437058481.git.maitysanchayan@gmail.com>
 <20150717234242.GJ39282@dtor-ws>
 <40d7c372e64c7f25b7df3e48930386de@agner.ch>
 <20150721172044.GC39076@dtor-ws>
 <20150803152544.GA9716@Sanchayan-Arch.toradex.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150803152544.GA9716@Sanchayan-Arch.toradex.int>
Sender: linux-kernel-owner@vger.kernel.org
To: maitysanchayan@gmail.com
Cc: Stefan Agner <stefan@agner.ch>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, kernel@pengutronix.de, galak@codeaurora.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Hi Sanchayan,

On Mon, Aug 03, 2015 at 08:55:44PM +0530, maitysanchayan@gmail.com wrote:
> Hello Dmitry,
> 
> On 15-07-21 10:20:44, Dmitry Torokhov wrote:
> > Hi Stefan,
> > 
> > On Tue, Jul 21, 2015 at 04:43:36PM +0200, Stefan Agner wrote:
> > > Hi Dmitry,
> > > 
> > > As the original author of the driver I have some remarks to your review
> > > 
> > > On 2015-07-18 01:42, Dmitry Torokhov wrote:
> > > >> +		/*
> > > >> +		 * If touch pressure is too low, stop measuring and reenable
> > > >> +		 * touch detection
> > > >> +		 */
> > > >> +		if (val_p < min_pressure || val_p > 2000)
> > > >> +			break;
> > > 
> > > This is where the modules touch pressure is used to stop the measurement
> > > process and switch back to interrupt mode. See my remarks at the end.
> > > 
> > > >> +
> > > >> +		/*
> > > >> +		 * The pressure may not be enough for the first x and the
> > > >> +		 * second y measurement, but, the pressure is ok when the
> > > >> +		 * driver is doing the third and fourth measurement. To
> > > >> +		 * take care of this, we drop the first measurement always.
> > > >> +		 */
> > > >> +		if (discard_val_on_start) {
> > > >> +			discard_val_on_start = false;
> > > >> +		} else {
> > > >> +			/*
> > > >> +			 * Report touch position and sleep for
> > > >> +			 * next measurement
> > > >> +			 */
> > > >> +			input_report_abs(vf50_ts->ts_input,
> > > >> +					ABS_X, VF_ADC_MAX - val_x);
> > > >> +			input_report_abs(vf50_ts->ts_input,
> > > >> +					ABS_Y, VF_ADC_MAX - val_y);
> > > >> +			input_report_abs(vf50_ts->ts_input,
> > > >> +					ABS_PRESSURE, val_p);
> > > >> +			input_report_key(vf50_ts->ts_input, BTN_TOUCH, 1);
> > > >> +			input_sync(vf50_ts->ts_input);
> > > >> +		}
> > > >> +
> > > >> +		msleep(10);
> > > >> +	}
> > > >> +
> > > >> +	/* Report no more touch, reenable touch detection */
> > > >> +	input_report_abs(vf50_ts->ts_input, ABS_PRESSURE, 0);
> > > >> +	input_report_key(vf50_ts->ts_input, BTN_TOUCH, 0);
> > > >> +	input_sync(vf50_ts->ts_input);
> > > >> +
> > > >> +	vf50_ts_enable_touch_detection(vf50_ts);
> > > >> +
> > > >> +	/* Wait for the pull-up to be stable on high */
> > > >> +	msleep(10);
> > > >> +
> > > >> +	/* Reenable IRQ to detect touch */
> > > >> +	enable_irq(vf50_ts->pen_irq);
> > > >> +
> > > >> +	dev_dbg(dev, "Reenabled touch detection interrupt\n");
> > > >> +}
> > > >> +
> > > >> +static irqreturn_t vf50_ts_touched(int irq, void *dev_id)
> > > >> +{
> > > >> +	struct vf50_touch_device *vf50_ts = (struct vf50_touch_device *)dev_id;
> > > >> +	struct device *dev = &vf50_ts->pdev->dev;
> > > >> +
> > > >> +	dev_dbg(dev, "Touch detected, start worker thread\n");
> > > >> +
> > > >> +	disable_irq_nosync(irq);
> > > >> +
> > > >> +	/* Disable the touch detection plates */
> > > >> +	gpiod_set_value(vf50_ts->gpio_ym, 0);
> > > >> +
> > > >> +	/* Let the platform mux to default state in order to mux as ADC */
> > > >> +	pinctrl_pm_select_default_state(dev);
> > > >> +
> > > >> +	queue_work(vf50_ts->ts_workqueue, &vf50_ts->ts_work);
> > > > 
> > > > If you convert this to a threaded interrupt you won't need to
> > > > disable/reenable interrupt or queue work. You should also be able to use
> > > > gpiod_set_value_cansleep() extending the range of ways the controller
> > > > could be connected to systems.
> > > > 
> > > 
> > > I'm not sure if a threaded interrupt is the right thing here. While the
> > > pen is on the touchscreen (which can be for several seconds)
> > > measurements have to be made in a continuous loop. Is it ok for a
> > > threaded interrupt to run that long?
> > 
> > Yes, why not? Threaded interrupt is simply a kernel thread that is woken
> > when hard interrupt handler tells it to wake up. Very similar to
> > interrupt + work queue, except that the kernel manages interactions
> > properly for you. There are several drivers in kernel that do that, for
> > example auo-pixcir-ts.c or tsc2007.c
> > 
> > > 
> > > I'm also not sure if it is really safe to _not_ disable the pen down
> > > GPIO interrupt. If we get a interrupt while measuring, we should ignore
> > > that interrupt.
> > 
> > The interrupt management core (you'll have to annotate it as
> > IRQF_ONESHOT) will make sure it stays masked properly until the threaded
> > handler completes so you do not need to disable it explicitly.
> 
> After working some more on threaded irq implementation, if IRQ_ONESHOT
> flag is used while requesting threaded irq, on entering the IRQ handler
> the vf610_gpio_irq_mask is not called and vf610_gpio_irq_unmask is not
> called on exiting the thread function, not something we expected.
> 
> In contrast, using explicit disable_irq_nosync and enable_irq in the IRQ
> handler and thread respectively results in the respective mask and unmask
> function being called.
> 
> The vf610_gpio_irq_*mask functions are in the gpio driver for Vybrid in
> drivers/gpio/gpio-vf610.c.

Well, for edge interrupts we normally do not mask/unmask IRQ as we
expect the controller to latch onto the state and not re-raise intil
interrupt is acked and I believe goes through edge condition again.
For level-triggered IRQs we do mask the interrupt line. See
kernel/irq/handle.c::handle_level_irq() and handle_edge_irq().

Thanks.

-- 
Dmitry
