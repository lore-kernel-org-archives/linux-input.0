From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] ili210x: Add support for Ilitek ILI210x based
 touchscreens
Date: Tue, 6 Mar 2012 14:42:52 +0100
Message-ID: <20120306134252.GA28547@polaris.bitmath.org>
References: <1330954816-18098-1-git-send-email-olivier@sobrie.be>
 <20120305164838.GA11317@polaris.bitmath.org>
 <20120306075721.GA32325@hposo>
 <20120306092502.GA26689@polaris.bitmath.org>
 <20120306132047.GA7687@hposo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:55435 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757800Ab2CFNlr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Mar 2012 08:41:47 -0500
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id A01A9DDA8
	for <linux-input@vger.kernel.org>; Tue,  6 Mar 2012 14:41:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120306132047.GA7687@hposo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Olivier Sobrie <olivier@sobrie.be>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jan Paesmans <jan.paesmans@gmail.com>

> I propose to change the handling of the interrupt by the code below.
> 
> #define POLL_PERIOD	msecs_to_jiffies(1)
> 
> static void ili210x_work(struct work_struct *work)
> {
> 	struct ili210x *priv = container_of(work, struct ili210x,
> 					    dwork.work);
> 	struct input_dev *input = priv->input;
> 	struct i2c_client *client = priv->client;
> 	struct device *dev = &client->dev;
> 	struct touchdata touchdata;
> 	int rc;
> 
> 	rc = ili210x_read_reg(client, REG_TOUCHDATA, &touchdata,
> 			      sizeof(touchdata));
> 	if (rc < 0) {
> 		dev_err(dev, "Unable to get touchdata, err = %d\n",
> 			rc);
> 		return;
> 	}
> 
> 	ili210x_report_events(input, &touchdata);
> 
> 	if ((touchdata.status & 0xf3) || get_pendown_state(priv))
> 		schedule_delayed_work(&priv->dwork, POLL_PERIOD);
> }
> 
> static irqreturn_t ili210x_irq(int irq, void *irq_data)
> {
> 	struct ili210x *priv = irq_data;
> 
> 	schedule_delayed_work(&priv->dwork, 0);
> 
> 	return IRQ_HANDLED;
> }
> 
> It removes the timer and handle the case of level triggered and edge
> triggered interrupts.
> What do you think about that ?

Looks a lot nicer, thank you!

Henrik
