From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 19/19 v2] mfd/ti_am335x_tscadc: add private lock/unlock
 function for regmap read/write
Date: Wed, 29 May 2013 16:31:19 +0200
Message-ID: <51A61137.7060408@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de> <1369681926-22185-20-git-send-email-bigeasy@linutronix.de> <20130529084642.GA18273@linutronix.de> <20130529111253.GR3660@sirena.org.uk> <51A5E5B3.80201@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51A5E5B3.80201-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 05/29/2013 01:25 PM, Lars-Peter Clausen wrote:
>> This is not a good place to make this change, there's nothing specific
>> to the device here and in actual fact there's already a change in the
>> works from Lars-Peter Clausen converting the spinlock to always use
>> spin_lock_irqsave() so it should be resolved soon.  The thread was on
>> lkml in the past few days.
> 
> Yes, this patch shouldn't be necessary in next/master anymore. For the
> record the patch can be found here: https://patchwork.kernel.org/patch/2609721/

Ah good good good. So this one can dropped. Thank you.

> - Lars

Sebastian
