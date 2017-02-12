From: Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - use dev_driver_string when
 registering interrupt
Date: Sun, 12 Feb 2017 15:17:17 -0800
Message-ID: <CAFXsbZoRdCqHTS4DvtZuZi6N+GhN1X=WQDM=BqN1h9W7AmoHZQ@mail.gmail.com>
References: <1486941088-3730-1-git-send-email-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36034 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdBLXRT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 12 Feb 2017 18:17:19 -0500
Received: by mail-it0-f66.google.com with SMTP id f200so10278983itf.3
        for <linux-input@vger.kernel.org>; Sun, 12 Feb 2017 15:17:18 -0800 (PST)
In-Reply-To: <1486941088-3730-1-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org

Tested on a custom ARM platform with both the S7300 and S7817
Synaptics controllers.  Both provide the "rmi4_i2c" string now.

Tested-by: Chris Healy <cphealy@gmail.com>


On Sun, Feb 12, 2017 at 3:11 PM, Nick Dyer <nick@shmanahar.org> wrote:
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
> index 23d705b..e3a6c7c 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -252,7 +252,7 @@ static int rmi_irq_init(struct rmi_device *rmi_dev)
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
