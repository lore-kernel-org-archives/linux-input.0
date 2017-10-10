From: Aaron Durbin <adurbin@chromium.org>
Subject: Re: [PATCH] Input: elan_i2c - do not clobber interrupt trigger on x86
Date: Tue, 10 Oct 2017 09:00:31 -0600
Message-ID: <CAE2855sUw6NDHxF7krFHzEq4_7vVZBjdxmQtBUE-=p=1=XvdGA@mail.gmail.com>
References: <20170928170902.GA18201@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170928170902.GA18201@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, KT Liao <kt.liao@emc.com.tw>, Guenter Roeck <linux@roeck-us.net>, Craig Bergstrom <craigb@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Sep 28, 2017 at 11:09 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On x86 we historically used falling edge interrupts in the driver
> because that's how first Chrome devices were configured. They also
> did not use ACPI to enumerate I2C devices (because back then there
> was no kernel support for that), so trigger was hard-coded in the
> driver. However the controller behavior is much more reliable if
> we use level triggers, and that is how we configured ARM devices,
> and how want to configure newer x86 devices as well. All newer
> x86 boxes have their I2C devices enumerated in ACPI.
>
> Let's see if platform code (ACPI, DT) described interrupt and
> specified particular trigger type, and if so, let's use it instead
> of always clobbering trigger with IRQF_TRIGGER_FALLING. We will
> still use this trigger type as a fallback if platform code left
> interrupt trigger unconfigured.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=196761
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/mouse/elan_i2c_core.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index a2d2077303cb..c33f2cce6ba9 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -26,6 +26,7 @@
>  #include <linux/init.h>
>  #include <linux/input/mt.h>
>  #include <linux/interrupt.h>
> +#include <linux/irq.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/kernel.h>
> @@ -1141,10 +1142,13 @@ static int elan_probe(struct i2c_client *client,
>                 return error;
>
>         /*
> -        * Systems using device tree should set up interrupt via DTS,
> -        * the rest will use the default falling edge interrupts.
> +        * Platform code (ACPI, DTS) should normally set up interrupt
> +        * for us, but in case it did not let's fall back to using falling
> +        * edge to be compatible with older Chromebooks.
>          */
> -       irqflags = dev->of_node ? 0 : IRQF_TRIGGER_FALLING;
> +       irqflags = irq_get_trigger_type(client->irq);
> +       if (!irqflags)
> +               irqflags = IRQF_TRIGGER_FALLING;
>
>         error = devm_request_threaded_irq(dev, client->irq, NULL, elan_isr,
>                                           irqflags | IRQF_ONESHOT,
> --
> 2.14.2.822.g60be5d43e6-goog

Reviewed-by: Aaron Durbin <adurbin@chromium.org>
