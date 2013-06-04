From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 14/19] Documentation/DT bindings: add info for TI TSC
 ADC
Date: Tue, 4 Jun 2013 12:24:17 +0200
Message-ID: <20130604102417.GD1151@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-15-git-send-email-bigeasy@linutronix.de>
 <51AB8568.9050104@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51AB8568.9050104-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

* Jonathan Cameron | 2013-06-02 18:48:24 [+0100]:

>On 05/27/2013 08:12 PM, Sebastian Andrzej Siewior wrote:
>> The platform data structs are killed here because there are no users in
>> tree (nobody sets the structs up, the RO usage is beeing removed) and the
>> documentation about the parameters is saved here.
>The platform data removal has nothing to do with the rest of the patch.
>Please review the whole series to cleanup the patch divisions.

Well, I removed the platform data and moved the documentation .dts but
okay, I will add this along with the DT part.

Sebastian
