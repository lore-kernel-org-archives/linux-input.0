From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 6/9] Staging/iio/adc/touchscreen/MXS: add interrupt driven touch detection
Date: Tue, 1 Oct 2013 11:28:38 +0200
Message-ID: <201310011128.38928.jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <1379946998-23041-7-git-send-email-jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379946998-23041-7-git-send-email-jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Disposition: inline
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Jonathan,

On Tuesday 01 October 2013 11:25:46 Jonathan Cameron wrote:
> a couple of the patch descriptions say that they are untested on i.MX=
28.

On Monday 23 September 2013 16:36:35 Juergen Beisert wrote:
> For battery driven systems it is a very bad idea to collect the touch=
screen
> data within a kernel busy loop.
>
> This change uses the features of the hardware to delay and accumulate
> samples in hardware to avoid a high interrupt and CPU load.
>
> Note: this is only tested on an i.MX23 SoC yet.

This note is no longer true. Marek tested it on his M28EVK, Lothar on h=
is TX28=20
and myself also on an i.MX28EVK.

=46or the IIO part of the driver I tested on my i.MX23 based ChumbyOne =
and some=20
customer hardware and it seems still to work (I can only guess if the v=
alues I=20
read from the sysfs entries are correct, sorry).

Regards,
Juergen

--=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
Linux Solutions for Science and Industry =A0 =A0 =A0| http://www.pengut=
ronix.de/  |
