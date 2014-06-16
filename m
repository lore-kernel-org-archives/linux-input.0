From: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 1/6] mfd: fsl imx25 Touchscreen ADC driver
Date: Mon, 16 Jun 2014 17:55:31 +0200
Message-ID: <539F1373.9090006@eukrea.com>
References: <1402910933-20534-1-git-send-email-denis@eukrea.com> <20140616112649.GQ14323@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140616112649.GQ14323@lee--X1>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 06/16/2014 01:26 PM, Lee Jones wrote:
>
>> +static void mx25_tsadc_nop(struct irq_data *d)
>> +{
>> +}
>
> Err, no, this is not required.  Just don't populate the call-backs.
>
>> +static int mx25_tsadc_set_wake_nop(struct irq_data *d, unsigned int state)
>> +{
>> +	return 0;
>> +}
>> +
>> +static struct irq_chip mx25_tsadc_irq_chip = {
>> +	.name = "mx25-tsadc",
>> +	.irq_ack = mx25_tsadc_nop,
>> +	.irq_mask = mx25_tsadc_nop,
>> +	.irq_unmask = mx25_tsadc_nop,
>
> No need to do this.

I can avoid all callbacks but the irq_mask/irq_unmask ones:
Even if I add some flags to prevent it to be called during probe, it 
can't be avoided to be called when an IRQ arrives.

It's called by handle_level_irq, which is setup as handler in 
mx25_tsadc_domain_map. I don't think it's a good idea to rewrite it not 
to depend on irq_mask/irq_unmask.

Here's what happens when an IRQ arrives (Shortened version):
[<c005391c>] (handle_level_irq)
[<c0050930>] (generic_handle_irq)
[<c02dc544>] (mx25_tsadc_irq_handler)
[<c0050930>] (generic_handle_irq)
[<c0009e64>] (handle_IRQ)
[<c0008710>] (avic_handle_irq)
[...]

Then handle_level_irq it runs mask_ack_irq inconditionally.
mask_ack_irq in turn will try to executes irq_mask_ack or else irq_mask 
(without checking if it's NULL) and then will provoke the NULL pointer.

Instead when I look in drivers/mfd/ I see the following drivers which 
have some dummy handlers:
wm8994-irq.c, ucb1x00-core.c, tc6393xb.c, htc-egpio.c, arizona-irq.c

So I wonder if dummy callbacks are allowed or if it's an old practice 
that has been deprecated.

Else I wonder how to avoid them:
- By setting some flags (which ones?).
- Or by re-architecting the IRQ handling between the MFD and its 
sub-devices in a way that the mfd driver is responsible for enabling and 
disabling the IRQs (instead of its subdevices). That would be done 
inside .irq_enable() and a .irq_disable().
Most of the mfd drivers that handle an IRQ controller have theses callbacks.

In the later case, how the subdevice would enable the interrupts, would 
it be done automatically? or would it have to enable the parent mfd's 
interrupts trough explicit callbacks or wrapper functions that will call 
the callbacks(irq_enable and so on, with the irq taken from the mfd's 
private struct).

I've fixed the rest of the concerns but I'll wait for an answer before 
resending so I can fix this issue too.

Denis.
