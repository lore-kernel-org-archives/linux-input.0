From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Patch 08/10] input: Touchscreen driver for the PCAP
Date: Thu, 10 Jul 2008 10:23:20 -0400
Message-ID: <20080710142320.GB3125@anvil.corenet.prv>
References: <20080707184000.411913919@datenfreihafen.org> <20080707184131.286622542@datenfreihafen.org> <20080707161212.ZZRA012@mailhub.coreip.homeip.net> <20080708202622.GE18479@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:23933 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754675AbYGJOYP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Jul 2008 10:24:15 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1074517yxm.1
        for <linux-input@vger.kernel.org>; Thu, 10 Jul 2008 07:24:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080708202622.GE18479@datenfreihafen.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org, Daniel Ribeiro <wyrm@openezx.org>

Hi Stefan,

On Tue, Jul 08, 2008 at 10:26:22PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On Mon, 2008-07-07 at 16:13, Dmitry Torokhov wrote:
> > 
> > On Mon, Jul 07, 2008 at 08:40:08PM +0200, stefan@datenfreihafen.org wrote:
> > > +
> > > +	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> > > +	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> > > +	input_set_abs_params(input_dev, ABS_X, X_AXIS_MIN, X_AXIS_MAX, 0, 0);
> > > +	input_set_abs_params(input_dev, ABS_Y, Y_AXIS_MIN, Y_AXIS_MAX, 0, 0);
> > > +	input_set_abs_params(input_dev, ABS_PRESSURE, PRESSURE_MIN,
> > > +			     PRESSURE_MAX, 0, 0);
> > > +
> > > +	input_register_device(pcap_ts->input);
> > 
> > Please add error handling here, otherwise looks good.
> 
> Added, how about this one?
> 
> 

Looks better, more comments though.

> +static int __init ezxts_probe(struct platform_device *pdev)

This should be __devinit.

> +{
> +	struct pcap_ts *pcap_ts;
> +	struct input_dev *input_dev;
> +	int err = -ENOMEM;
> +
> +	pcap_ts = kzalloc(sizeof(*pcap_ts), GFP_KERNEL);
> +	input_dev = input_allocate_device();
> +	if (!pcap_ts || !input_dev)
> +		goto fail;
> +
> +	pcap_ts->irq_xy = platform_get_irq(pdev, 0);
> +	if (pcap_ts->irq_xy < 0) {
> +		err = pcap_ts->irq_xy;
> +		goto fail;
> +	}
> +
> +	pcap_ts->irq_touch = platform_get_irq(pdev, 1);
> +	if (pcap_ts->irq_touch < 0) {
> +		err = pcap_ts->irq_touch;
> +		goto fail;
> +	}
> +
> +	ezx_pcap_write(PCAP_REG_ADC, 0);
> +	ezx_pcap_write(PCAP_REG_ADR, 0);
> +	pcap_ts_mode(pcap_ts, STANDBY_MODE);
> +

OK, so if I understand this correctly we make the hardware fully ready
here...

> +	err = request_irq(pcap_ts->irq_xy, pcap_ts_irq_xy, IRQF_DISABLED,
> +			  "pcap-ts X/Y", pcap_ts);
> +	if (err < 0) {
> +		printk(KERN_ERR "pcap_ts: can't grab xy irq %d: %d\n",
> +		       pcap_ts->irq_xy, err);
> +		goto fail;
> +	}
> +
> +	err = request_irq(pcap_ts->irq_touch, pcap_ts_irq_touch, IRQF_DISABLED,
> +			  "pcap-ts touch", pcap_ts);
> +	if (err < 0) {
> +		printk(KERN_ERR "pcap_ts: can't grab touch irq %d: %d\n",
> +		       pcap_ts->irq_touch, err);
> +		goto fail_xy;
> +	}
> +

And request IRQ.. At this point in time IRQ may come up if pen is
touching the screen...

> +	pcap_ts->input = input_dev;
> +	init_timer(&pcap_ts->timer);
> +	pcap_ts->timer.data = (unsigned long) pcap_ts;
> +	pcap_ts->timer.function = &pcap_ts_timer_fn;

But the timer is not setup yet... This may cause problems.

> +
> +static int ezxts_remove(struct platform_device *pdev)
> +{

__devexit?

> +	struct pcap_ts *pcap_ts = platform_get_drvdata(pdev);
> +
> +	del_timer_sync(&pcap_ts->timer);
> +

We delete the timer but if IRQ comes up right here we'll reactivate it
again. Is there a way to disable the hardware? Something like putting it
into low power mode like you do in suspend to make sure it does not
generate IRQs? I guess you can just disable_irq before trying to delete
the timer.

> +	free_irq(pcap_ts->irq_touch, pcap_ts);
> +	free_irq(pcap_ts->irq_xy, pcap_ts);
> +
> +	input_unregister_device(pcap_ts->input);
> +	kfree(pcap_ts);
> +
> +	return 0;
> +}
> +

> +static int ezxts_suspend(struct platform_device *dev, pm_message_t state)
> +static int ezxts_resume(struct platform_device *dev)

Guard with CONFIG_PM?

> +static struct platform_driver ezxts_driver = {
> +	.probe		= ezxts_probe,
> +	.remove		= ezxts_remove,

__devexit_p()

> +	.suspend	= ezxts_suspend,
> +	.resume		= ezxts_resume,

Guard with CONFIG_PM here as well.

> +	.driver		= {
> +		.name	= "pcap-ts",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +

-- 
Dmitry
