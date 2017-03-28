From: Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH 1/3] Input: synaptics-rmi4 - use dev_driver_string when
 registering interrupt
Date: Mon, 27 Mar 2017 17:49:13 -0700
Message-ID: <CAFXsbZqd+595UqMyvH3XVrD_eCwLa5hRBLt8pBM7NNetLXztJg@mail.gmail.com>
References: <1490403540-31425-1-git-send-email-nick@shmanahar.org> <1490403540-31425-2-git-send-email-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:32940 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753630AbdC1Ato (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 20:49:44 -0400
Received: by mail-it0-f65.google.com with SMTP id 76so499290itj.0
        for <linux-input@vger.kernel.org>; Mon, 27 Mar 2017 17:49:24 -0700 (PDT)
In-Reply-To: <1490403540-31425-2-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>

On Fri, Mar 24, 2017 at 5:58 PM, Nick Dyer <nick@shmanahar.org> wrote:
> When IRQ handling was moved to rmi_driver in 3aeed5b the naming of the
> interrupt changed from "rmi4_i2c" to "2-0020" (or similar). This patch restores
> the previous behaviour and makes the interrupt easier to identify in
> /proc/interrupts.
>
> Signed-off-by: Nick Dyer <nick@shmanahar.org>
> ---
>  drivers/input/rmi4/rmi_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index d64fc92..5b7350f 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -251,7 +251,7 @@ static int rmi_irq_init(struct rmi_device *rmi_dev)
>
>         ret = devm_request_threaded_irq(&rmi_dev->dev, pdata->irq, NULL,
>                                         rmi_irq_fn, irq_flags | IRQF_ONESHOT,
> -                                       dev_name(rmi_dev->xport->dev),
> +                                       dev_driver_string(rmi_dev->xport->dev),
>                                         rmi_dev);
>         if (ret < 0) {
>                 dev_err(&rmi_dev->dev, "Failed to register interrupt %d\n",
> --
> 2.7.4
>

Tested with both S7300 and S7817 HW.

Tested-by: Chris Healy <cphealy@gmail.com>
