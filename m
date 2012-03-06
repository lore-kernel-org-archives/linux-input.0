From: Olivier Sobrie <olivier@sobrie.be>
Subject: Re: [PATCH] ili210x: Add support for Ilitek ILI210x based
 touchscreens
Date: Tue, 6 Mar 2012 14:20:47 +0100
Message-ID: <20120306132047.GA7687@hposo>
References: <1330954816-18098-1-git-send-email-olivier@sobrie.be>
 <20120305164838.GA11317@polaris.bitmath.org>
 <20120306075721.GA32325@hposo>
 <20120306092502.GA26689@polaris.bitmath.org>
Reply-To: Olivier Sobrie <olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34733 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758398Ab2CFNU4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Mar 2012 08:20:56 -0500
Received: by bkcik5 with SMTP id ik5so4169296bkc.19
        for <linux-input@vger.kernel.org>; Tue, 06 Mar 2012 05:20:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120306092502.GA26689@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jan Paesmans <jan.paesmans@gmail.com>

On Tue, Mar 06, 2012 at 10:25:02AM +0100, Henrik Rydberg wrote:
> > > > +static irqreturn_t ili210x_irq(int irq, void *irq_data)
> > > > +{
> > > > +	struct ili210x *priv = irq_data;
> > > > +	struct i2c_client *client = priv->client;
> > > > +	struct input_dev *input = priv->input;
> > > > +	struct device *dev = &client->dev;
> > > > +	struct touchdata touchdata;
> > > > +	int rc;
> > > > +
> > > > +	do {
> > > > +		rc = ili210x_read_reg(client, REG_TOUCHDATA, &touchdata,
> > > > +				      sizeof(touchdata));
> > > > +		if (rc < 0) {
> > > > +			dev_err(dev, "Unable to get touchdata, err = %d\n",
> > > > +				rc);
> > > > +			goto end;
> > > > +		}
> > > > +
> > > > +		ili210x_report_events(input, &touchdata);
> > > > +
> > > > +		usleep_range(100, 1000);
> > > > +		mod_timer(&priv->timer, jiffies + TS_PEN_UP_TIMEOUT);
> > > > +	} while (get_pendown_state(priv) && !priv->stopped);
> > > 
> > > It looks odd to loop in an irq handler, even if it is threaded. What
> > > is the pdata->get_pendown_state() doing?
> > I agree. The reason of the loop is for edge triggered interrupt.
> > 
> > On my hardware I don't have support for level triggered irq. I'm working
> > with edge triggered interrupts.
> > In the pdata structure I give to the driver it set irq_flags to
> > IRQF_TRIGGER_FALLING and the get_pendown_state function implemented is the
> > following:
> > 	static int get_pendown_state(void)
> > 	{
> > 		return gpio_get_value(GPIO_TOUCHSCREEN_IRQ) ? 0 : 1;
> > 	}
> > The get_pendown_state() function will look at the irq line to see if it's
> > still low meaning there is a finger on the screen.
> > If it is the case, we loop, otherwise we exit from the thread and the timer
> > will fire after TS_PEN_UP_TIMEOUT.
> > 
> > On the contrary if working with a level triggered interrupt, i.e. with
> > irqflags set to IRQF_TRIGGER_LOW, there is no need to add the
> > get_pendown_state function and the thread will exit after each touch read.
> > In this case the usleep_range() is even not needed...
> > 
> > I agree it's maybe not the best solution... Do I've to use something else
> > like a workqueue or something else?
> 
> I see, tricky. From the code, it looks like you could skip the loop
> and start a workqueue there instead. The work function could then poll
> touch frames until the gpio line goes high again. This would also give
> you a predictable frame rate without the usleep(). The polldev
> implementation might be a good template.
> 
> Regarding timer vs workqueue, I am not sure how much could be run in
> interrupt context here. You could probably skip the threaded irq
> either way, if it is only there to start a poll. Dmitry?

I propose to change the handling of the interrupt by the code below.

#define POLL_PERIOD	msecs_to_jiffies(1)

static void ili210x_work(struct work_struct *work)
{
	struct ili210x *priv = container_of(work, struct ili210x,
					    dwork.work);
	struct input_dev *input = priv->input;
	struct i2c_client *client = priv->client;
	struct device *dev = &client->dev;
	struct touchdata touchdata;
	int rc;

	rc = ili210x_read_reg(client, REG_TOUCHDATA, &touchdata,
			      sizeof(touchdata));
	if (rc < 0) {
		dev_err(dev, "Unable to get touchdata, err = %d\n",
			rc);
		return;
	}

	ili210x_report_events(input, &touchdata);

	if ((touchdata.status & 0xf3) || get_pendown_state(priv))
		schedule_delayed_work(&priv->dwork, POLL_PERIOD);
}

static irqreturn_t ili210x_irq(int irq, void *irq_data)
{
	struct ili210x *priv = irq_data;

	schedule_delayed_work(&priv->dwork, 0);

	return IRQ_HANDLED;
}

It removes the timer and handle the case of level triggered and edge
triggered interrupts.
What do you think about that ?

Thanks,

-- 
Olivier Sobrie
