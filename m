From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 17/19] mfd / iio: ti_am335x_adc: rename device from
 tiadc to TI-adc
Date: Tue, 4 Jun 2013 12:28:44 +0200
Message-ID: <20130604102844.GF1151@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-18-git-send-email-bigeasy@linutronix.de>
 <51AB85DB.2000305@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51AB85DB.2000305-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

* Jonathan Cameron | 2013-06-02 18:50:19 [+0100]:

>On 05/27/2013 08:12 PM, Sebastian Andrzej Siewior wrote:
>> TI-adc reads a little better compared to tiadc.
>> While here add an alias so the driver is loaded on demand.
>> 
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
>Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
>but you'll be wanting a few more acks on a name change...

It is a name change of a driver in tree (two to be exact) which can not
be used as of now and has no users. I can't imagine why someone should
complain.

Thanks for the review.

Sebatian
