From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [PATCH] Touch screen driver for the SuperH MigoR board V2
Date: Fri, 4 Apr 2008 17:21:48 +0900
Message-ID: <aec7e5c30804040121k584a0ae5o909b48fbd970245d@mail.gmail.com>
References: <20080328095101.8825.48353.sendpatchset@rx1.opensource.se>
	 <20080402060819.GB14189@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:50751 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758420AbYDDIVt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Apr 2008 04:21:49 -0400
Received: by yw-out-2324.google.com with SMTP id 5so510736ywb.1
        for <linux-input@vger.kernel.org>; Fri, 04 Apr 2008 01:21:48 -0700 (PDT)
In-Reply-To: <20080402060819.GB14189@anvil.corenet.prv>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-sh@vger.kernel.org, lethal@linux-sh.org, broonie@sirena.org.uk, akpm@linux-foundation.org

Hi Dmitry,

On Wed, Apr 2, 2008 at 3:08 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>  On Fri, Mar 28, 2008 at 06:51:01PM +0900, Magnus Damm wrote:
>  > This is V2 of the MigoR touch screen driver. The chip we interface to
>  > is unfortunately a custom designed microcontroller speaking some
>  > undocumented protocol over i2c.
>
>  Thank you for the patch, I just have a couple of comments below...

Your comments are much appreciated.

>  > +     if ((event == EVENT_PENDOWN) || (event == EVENT_REPEAT)) {
>  > +             input_report_key(priv->input, BTN_TOUCH, 1);
>  > +             input_report_abs(priv->input, ABS_X, ypos); /*X-Y swap*/
>  > +             input_report_abs(priv->input, ABS_Y, xpos);
>  > +             input_report_abs(priv->input, ABS_PRESSURE, 120);
>  > +             input_sync(priv->input);
>  > +     } else if (event == EVENT_PENUP) {
>  > +             input_report_abs(priv->input, ABS_PRESSURE, 0);
>
>  Don't you need to signal BTN_TOUCH release here?

Yes, you are correct. It is missing.

>  > +     input_set_abs_params(priv->input, ABS_X, 95, 955, 0, 0);
>  > +     input_set_abs_params(priv->input, ABS_Y, 85, 935, 0, 0);
>  > +     input_set_abs_params(priv->input, ABS_PRESSURE, 0, 0, 0, 0);
>
>  The device does not support pressure reporting so don't pretend
>  to send one. If this was done because of tslib please fix tslib
>  instead.

Right, there is no need to pretend.

>  > +     priv->input->name = client->driver_name;
>  > +     priv->input->phys = "input/event0";
>
>  Normally we encode bus slot or port in phys. If this data
>  is unavailable it is better to omit phys altogether.
>
>  What we can and should do is properly set up input device in
>  sysfs hierarchy by parenting it to the i2c client:
>
>         input->dev.parent = &client->dev;

Much better, thank you.

>  > +     priv->input->id.bustype = BUS_ISA;
>
>  Not BUS_i2C?

Yes please, BUS_I2C. =)

>  > +     if (request_irq(priv->irq, migor_ts_isr, IRQF_TRIGGER_LOW,
>  > +                     client->driver_name, priv)) {
>  > +             dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
>  > +             res = -EBUSY;
>  > +             goto err2;
>  > +     }
>  > +
>  > +     /* enable controller */
>  > +     if (i2c_master_send(client, migor_ts_ena_seq, sizeof(migor_ts_ena_seq))
>  > +         == sizeof(migor_ts_ena_seq))
>  > +             return 0;
>  > +
>  > +     dev_err(&client->dev, "Unable to enable touchscreen.\n");
>  > +
>
>  Since you are not setting res here you will signal success the module
>  loader and bad things will happen.

Yeah. Good catch.

>  I tried implementing my suggestions in the patch below, please let me
>  know if it still works for you and I will apply it.

I just tested using latest sh-2.6 git with evtest. Everything seems to
work well. The patch is much cleaner now. Please apply.

Thank you!

/ magnus
