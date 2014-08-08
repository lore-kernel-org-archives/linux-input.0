From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/2] Input: atmel_mxt_ts - Get IRQ edge/level flags on
 DT booting
Date: Fri, 08 Aug 2014 15:24:29 +0200
Message-ID: <53E4CF8D.7080302@collabora.co.uk>
References: <1407372486-25881-1-git-send-email-javier.martinez@collabora.co.uk> <53E2D2F8.7010606@gmail.com> <53E2DAAC.1060602@collabora.co.uk> <20140807060926.GA651@core.coreip.homeip.net> <53E32F9D.2080705@collabora.co.uk> <20140807164725.GA22421@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140807164725.GA22421@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Nick Dyer <nick.dyer@itdev.co.uk>, Stephen Warren <swarren@nvidia.com>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello,

On 08/07/2014 06:47 PM, Dmitry Torokhov wrote:
> 
> Actually, I take this back. In mainline everything as it should: if
> pdata does not specify particular trigger the flags requested end up
> being IRQF_ONESHOT, which should preserve trigger bits previously set up
> by the board or OF code. In Chrome kernel we have:
> 

In theory it should work as Dmitry and Nick said since if no trigger flags are
set then whatever was set before (by OF, platform code, ACPI) should be used.

I also verified what Tomasz mentioned that the IRQ trigger type is parsed and
set correctly by OF:

irq_of_parse_and_map()
	 irq_create_of_mapping()
		irq_set_irq_type()
			__irq_set_trigger()
				chip->irq_set_type()
					exynos_irq_set_type()

But for some reason it doesn't work for me unless I set the trigger type in the
flags passed to request_threaded_irq().

I found that what makes it to work is the logic in __setup_irq() [0] that Nick
pointed out on a previous email:

		/* Setup the type (level, edge polarity) if configured: */
		if (new->flags & IRQF_TRIGGER_MASK) {
			ret = __irq_set_trigger(desc, irq,
					new->flags & IRQF_TRIGGER_MASK);

			if (ret)
				goto out_mask;
		}

So __irq_set_trigger() is only executed if the struct irqaction flags has a
trigger flag which makes sense since this shouldn't be necessary with DT due
__irq_set_trigger() being called from irq_create_of_mapping() before when the
"interrupts" property is parsed.

But for some reason it is necessary for me... I checked that struct irq_data
state_use_accessors value is correct and even tried setting that value to
new->flags after the mentioned code block but it makes no difference. Input
events are not reported by evtest and AFAICT interrupts are not being generated.

It works though if the trigger type is passed to request_threaded_irq() like
$subject does or if new->flags are set before the new->flags & IRQF_TRIGGER_MASK
conditional.

For example, with the following changes interrupts are fired correctly:

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 3dc6a61..2d8adbb 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1169,6 +1169,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc,
struct irqaction *new)

                init_waitqueue_head(&desc->wait_for_threads);

+               if (!(new->flags & IRQF_TRIGGER_MASK))
+                       new->flags |= irqd_get_trigger_type(desc);
+
                /* Setup the type (level, edge polarity) if configured: */
                if (new->flags & IRQF_TRIGGER_MASK) {
                        ret = __irq_set_trigger(desc, irq,

Any ideas what could be wrong here?
				
> 	/* Default to falling edge if no platform data provided */
> 	irqflags = data->pdata ? data->pdata->irqflags : IRQF_TRIGGER_FALLING;
> 	error = request_threaded_irq(client->irq, NULL, mxt_interrupt,
> 				     irqflags | IRQF_ONESHOT,
> 				     client->name, data);
>

Exactly, that's how I found the issue. When I compared both drivers I noticed
that the Chrome OS driver did that and since all the supported platforms are DT
based, the above is equivalent to just IRQF_TRIGGER_FALLING | IRQF_ONESHOT.

So according to my explanation, new->flags & IRQF_TRIGGER_MASK is true so
__irq_set_trigger() is executed and that's why it works with the Chrome OS driver.

In fact the Chrome OS DTS does not set a trigger type in the "interrupts" property:

trackpad@4b {
	reg=<0x4b>;
	compatible="atmel,atmel_mxt_tp";
	interrupts=<1 0>;
	interrupt-parent=<&gpx1>;
	wakeup-source;
};


> which I believe should go away. If it is needed on ACPI systems we need
> to figure out how to do things we can do with OF there.
> 

The above code should not be related to ACPI systems since whatever code that
parses an ACPI table should just call irq_set_irq_type() like is made by OF, so
request_threaded_irq() should just work with ACPI too.

I agree it should go away but first I want to understand why is needed in the
first place. Unfortunately commit:

031f136 ("Input: atmel_mxt_ts - Set default irqflags when there is no pdata")

from the Chrome OS 3.8 does not explain why this is needed, instead of adding
this information in the DTS (e.g: interrupts=<1 IRQ_TYPE_EDGE_FALLING>).

> Thanks.
>

Best regards,
Javier

[0]: http://lxr.free-electrons.com/source/kernel/irq/manage.c#L1172
