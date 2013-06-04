From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 07/19] iio: adc: am335x: Add DT support
Date: Tue, 4 Jun 2013 12:12:02 +0200
Message-ID: <20130604101202.GA1151@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-8-git-send-email-bigeasy@linutronix.de>
 <51AB79CE.2000001@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51AB79CE.2000001-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-input@vger.kernel.org

* Jonathan Cameron | 2013-06-02 17:58:54 [+0100]:

>On 05/27/2013 08:11 PM, Sebastian Andrzej Siewior wrote:
>> From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
>> 
>> Add DT support for client ADC driver.
>> 
>> [ panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org : use of_get_child_by_name
>> 	instead of of_find_node_by_name ]
>> 
>> Signed-off-by: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
>> Signed-off-by: Patil, Rachna <rachna-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>> [bigeasy: shift the code to the left]
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
>Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
>I would take this directly but then I'd imagine that will cause havoc
>when the later patches are applied and touch both iio and mfd.

Yeah, I have no idea what to do here since it would be best to grab the
series in one go. The fact that I hear nothing from input/mfd does not
make it easier :)

Sebastian
