From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 4/4] iio: ti_am335x_adc: Add continuous sampling and
 trigger support
Date: Fri, 16 Aug 2013 12:07:02 +0200
Message-ID: <20130816100702.GD26895@linutronix.de>
References: <1376424303-22740-1-git-send-email-zubair.lutfullah@gmail.com>
 <1376424303-22740-5-git-send-email-zubair.lutfullah@gmail.com>
 <520CBEC6.8010400@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <520CBEC6.8010400-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Russ.Dill-l0cyMroinI0@public.gmane.org
List-Id: linux-input@vger.kernel.org

* Jonathan Cameron | 2013-08-15 12:43:02 [+0100]:

>Hi,
Hi Jonathan,

>Whilst the below review is based on what we have here, I tried to appl=
y it
>to the latest iio.git togreg branch (which for this driver should be
>much the same as staging-next and hence linux-next).  It's not even
>close and I can't immediately spot where some of the changes came
>from.  Have I missed a precursor patch or is this based on an
>older version of this driver?

I took the four patches, checkout iio/fixes-togreg and then

|git am -3 iio.mbox
|Applying: input: ti_am335x_tsc: correct step mask update after IRQ
|Applying: input: ti_am335x_tsc: Increase sequencer delay time
|Applying: input: ti_am335x_tsc: Enable shared IRQ for TSC, add overrun=
 and underflow checks
|Applying: iio: ti_am335x_adc: Add continuous sampling and trigger supp=
ort

It did apply with no trouble here.
Let me look at your comments=E2=80=A6

Sebastian
