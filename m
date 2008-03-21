From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Touch screen driver for the SuperH MigoR board
Date: Fri, 21 Mar 2008 15:55:15 -0700
Message-ID: <20080321155515.bb9f945e.akpm@linux-foundation.org>
References: <20080321111630.13138.14500.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20080321111630.13138.14500.sendpatchset@rx1.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
Cc: linux-input@vger.kernel.org, magnus.damm@gmail.com, lethal@linux-sh.org, dmitry.torokhov@gmail.com, linux-sh@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 21 Mar 2008 20:16:30 +0900
Magnus Damm <magnus.damm@gmail.com> wrote:

> This patch adds a touch screen driver for the MigoR board. The chip we
> interface to is unfortunately a custom designed microcontroller speaking
> some undocumented protocol over i2c.
> 
> The board specific code is expected to register this device as an i2c
> chip using struct i2c_board_info [] and i2c_register_board_info().
> 
> ...
>
> +static void migor_ts_poscheck(struct work_struct *work)
> +{
> +	struct migor_ts_priv *priv = container_of(work,
> +						  struct migor_ts_priv,
> +						  work.work);
> +	unsigned short xpos, ypos;
> +	unsigned char event;
> +	u_int8_t buf[16];
> +
> +	memset(buf, 0, sizeof(buf));
> +
> +	/* Set Index 0 */
> +	buf[0] = 0;
> +	if (i2c_master_send(priv->client, buf, 1) != 1) {
> +		dev_err(&priv->client->dev, "Unable to write i2c index\n");
> +		goto out;
> +	}
> +
> +	/* Now do Page Read */
> +	if (i2c_master_recv(priv->client, buf, sizeof(buf)) != sizeof(buf)) {
> +		dev_err(&priv->client->dev, "Unable to read i2c page\n");
> +		goto out;
> +	}
> +
> +	ypos = ((buf[9] & 0x03) << 8 | buf[8]);
> +	xpos = ((buf[11] & 0x03) << 8 | buf[10]);
> +	event = buf[12];
> +
> +	if ((event == EVENT_PENDOWN) || (event == EVENT_REPEAT)) {
> +		input_report_key(priv->input, BTN_TOUCH, 1);
> +		input_report_abs(priv->input, ABS_X, ypos); /*X-Y swap*/
> +		input_report_abs(priv->input, ABS_Y, xpos);
> +		input_report_abs(priv->input, ABS_PRESSURE, 120);
> +		input_sync(priv->input);
> +	} else if (event == EVENT_PENUP) {
> +		input_report_abs(priv->input, ABS_PRESSURE, 0);
> +		input_sync(priv->input);
> +	}
> + out:
> +	enable_irq(priv->irq);
> +}
> +
> +static irqreturn_t migor_ts_isr(int irq, void *dev_id)
> +{
> +	struct migor_ts_priv *priv = dev_id;
> +
> +	disable_irq_nosync(irq);
> +	schedule_delayed_work(&priv->work, HZ / 20);
> +	return IRQ_HANDLED;
> +}

eww.  Doing a disable_irq() on each interrupt and reenabling interrupts
later isn't very nice.  And it might cause havoc if that interrupt is
shared.

Why is this code like this?

No, don't answer that question.  If I wanted to know this when reading
the code, then others will want to know it also.  It needs to be fully
explained in code comments, please.

Can we not pull the data out of the hardware at interrupt time and then
queue that data up for the keventd processing? 

> +static int migor_ts_remove(struct i2c_client *client)
> +{
> +	struct migor_ts_priv *priv = dev_get_drvdata(&client->dev);
> +
> +	/* disable controller */
> +	i2c_master_send(client, migor_ts_dis_seq, sizeof(migor_ts_dis_seq));
> +
> +	free_irq(priv->irq, priv);
> +	input_unregister_device(priv->input);
> +	kfree(priv);
> +	return 0;
> +}

Might a delayed work still be scheduled when we run this?  A
cancel_delayed_work_sync() would set minds at rest.


