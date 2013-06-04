From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 1/5] drivers/iio: am335x_adc: cleanup on missing DT
 nodes
Date: Tue, 4 Jun 2013 12:38:09 +0200
Message-ID: <20130604103809.GG1151@linutronix.de>
References: <1369847397-27451-1-git-send-email-bigeasy@linutronix.de>
 <1369847397-27451-2-git-send-email-bigeasy@linutronix.de>
 <51AB8758.5010705@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51AB8758.5010705-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-input@vger.kernel.org

* Jonathan Cameron | 2013-06-02 18:56:40 [+0100]:

>On 05/29/2013 06:09 PM, Sebastian Andrzej Siewior wrote:
>> Currently we leak indio_dev() if the DT has no "adc" node in it.
>> 
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
>Given you are going to end up rerolling the original series
>(and it hasn't been taken by anyone yet) this wants to go
>in a new version of that not as a separate patch.

Yes, why not.

Sebastian
