From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH 19/19 v2] mfd/ti_am335x_tscadc: add private lock/unlock
 function for regmap read/write
Date: Wed, 29 May 2013 13:25:39 +0200
Message-ID: <51A5E5B3.80201@metafoo.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de> <1369681926-22185-20-git-send-email-bigeasy@linutronix.de> <20130529084642.GA18273@linutronix.de> <20130529111253.GR3660@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130529111253.GR3660-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 05/29/2013 01:12 PM, Mark Brown wrote:
> On Wed, May 29, 2013 at 10:46:42AM +0200, Sebastian Andrzej Siewior wrote:
>> Without this, devm_regmap_init_mmio() creates & uses a simple
>> spin_lock() and this should be enough. Within the probe function the
>> registers are read and written in process context. Later they are
>> accessed from the ISR and lockdep complains because now the lock is
>> taken suddenly with IRQs enabled. Currently I don't see any other way to
>> keep lockdep quiet than doing this.
> 
> This is not a good place to make this change, there's nothing specific
> to the device here and in actual fact there's already a change in the
> works from Lars-Peter Clausen converting the spinlock to always use
> spin_lock_irqsave() so it should be resolved soon.  The thread was on
> lkml in the past few days.

Yes, this patch shouldn't be necessary in next/master anymore. For the
record the patch can be found here: https://patchwork.kernel.org/patch/2609721/

- Lars
