From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 16/19] mfd / input: ti_am335x_tsc: rename device from
 tsc to TI-tsc
Date: Tue, 4 Jun 2013 19:29:20 +0200
Message-ID: <20130604172920.GA15142@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-17-git-send-email-bigeasy@linutronix.de>
 <20130604165035.GE26400@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130604165035.GE26400-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

* Dmitry Torokhov | 2013-06-04 09:50:35 [-0700]:

>> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
>> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
>> @@ -543,11 +543,12 @@ static struct platform_driver ti_tsc_driver = {
>>  	.probe	= titsc_probe,
>>  	.remove	= titsc_remove,
>>  	.driver	= {
>> -		.name   = "tsc",
>> +		.name   = "TI-tsc",
>
>Still quite generic... Why not call it "TI-am335x-tsc"?
TI-am335x-tsc it is. In that case I make a similar change to adc node.

>Thanks.

Sebastian
