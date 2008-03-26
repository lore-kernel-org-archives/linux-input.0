From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [PATCH] Touch screen driver for the SuperH MigoR board
Date: Wed, 26 Mar 2008 13:03:09 +0900
Message-ID: <aec7e5c30803252103x1534e43dv3f31a3bc731fc9bf@mail.gmail.com>
References: <20080321111630.13138.14500.sendpatchset@rx1.opensource.se>
	 <20080321155515.bb9f945e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20080321155515.bb9f945e.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-input@vger.kernel.org, lethal@linux-sh.org, dmitry.torokhov@gmail.com, linux-sh@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Mar 22, 2008 at 7:55 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Fri, 21 Mar 2008 20:16:30 +0900
>  Magnus Damm <magnus.damm@gmail.com> wrote:
>
>  > This patch adds a touch screen driver for the MigoR board. The chip we
>  > interface to is unfortunately a custom designed microcontroller speaking
>  > some undocumented protocol over i2c.

[snip]

>  > +static irqreturn_t migor_ts_isr(int irq, void *dev_id)
>  > +{
>  > +     struct migor_ts_priv *priv = dev_id;
>  > +
>  > +     disable_irq_nosync(irq);
>  > +     schedule_delayed_work(&priv->work, HZ / 20);
>  > +     return IRQ_HANDLED;
>  > +}
>
>  eww.  Doing a disable_irq() on each interrupt and reenabling interrupts
>  later isn't very nice.  And it might cause havoc if that interrupt is
>  shared.
>
>  Why is this code like this?

The code is more or less doing the same thing as the ads7846 driver,
except this one is communicating over i2c instead of spi. This means
is because of great hardware design with interrupts that needs to be
acked over an extremely slow serial bus. So we just disable the
interrupt and handle everything from a different context. Apart from
avoiding serious latency issues, doing things from interrupt context
simply won't work since the i2c bus driver may be interrupt driven and
may sleep while waiting for the serial bus data to be sent.

And you are right, this won't work with shared interrupts.

>  No, don't answer that question.  If I wanted to know this when reading
>  the code, then others will want to know it also.  It needs to be fully
>  explained in code comments, please.

Yeah, having a comment in there would certainly help.

>  Can we not pull the data out of the hardware at interrupt time and then
>  queue that data up for the keventd processing?

No can do, the serial bus is too slow.

>  > +static int migor_ts_remove(struct i2c_client *client)
>  > +{
>  > +     struct migor_ts_priv *priv = dev_get_drvdata(&client->dev);
>  > +
>  > +     /* disable controller */
>  > +     i2c_master_send(client, migor_ts_dis_seq, sizeof(migor_ts_dis_seq));
>  > +
>  > +     free_irq(priv->irq, priv);
>  > +     input_unregister_device(priv->input);
>  > +     kfree(priv);
>  > +     return 0;
>  > +}
>
>  Might a delayed work still be scheduled when we run this?  A
>  cancel_delayed_work_sync() would set minds at rest.

Good catch. I'll fix this up and repost.

Thanks!

/ magnus
