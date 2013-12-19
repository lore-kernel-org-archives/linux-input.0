From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/5] mfd: ti_am335x: drop am335x_tsc_se_update() from
 resume path
Date: Thu, 19 Dec 2013 09:00:40 +0000
Message-ID: <20131219090040.GH2621@lee--X1>
References: <1387385577-24447-1-git-send-email-bigeasy@linutronix.de>
 <1387385577-24447-5-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1387385577-24447-5-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

> The update of the SE register in MFD doesn't look right as it has
> nothing to do with it. The better place to do it is in TSC driver (wh=
ich
> is already doint it) and in the ADC driver which needs this only in t=
he
> continues mode.

When you resubmit the patch-set complete with Acks, please ensure you
spell check and proof read _all_ of your commit logs.

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 2 ++
>  drivers/mfd/ti_am335x_tscadc.c  | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)

=46or the MFD part:
  Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

It's probably best that we suck these changes up through the MFD tree,
so once the review comments have been satisfied and we have all
relevant Acks I can take them in and create an immutable branch for
you guys to pull from if you like.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
