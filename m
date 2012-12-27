From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/3 V2] iio: mxs: Implement support for touchscreen
Date: Thu, 27 Dec 2012 19:19:00 +0100
Message-ID: <201212271919.00794.marex@denx.de>
References: <1355449598-15980-1-git-send-email-marex@denx.de> <1355449598-15980-2-git-send-email-marex@denx.de> <50DC319B.1050607@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50DC319B.1050607-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Dear Jonathan Cameron,

> On 12/14/2012 01:46 AM, Marek Vasut wrote:
> > This patch implements support for sampling of a touchscreen into
> > the MXS LRADC driver. The LRADC block allows configuring some of
> > it's channels into special mode where they either output the drive
> > voltage or sample it, allowing it to operate a 4-wire or 5-wire
> > resistive touchscreen.
> > 
> > In case the touchscreen mode is enabled, the LRADC slot #7 is
> > reserved for touchscreen only, therefore it is not possible to
> > sample 8 LRADC channels at time, but only 7 channels.
> > 
> > The touchscreen controller is configured such that the PENDOWN event
> > disables touchscreen interrupts and triggers execution of worker
> > thread, which then polls the touchscreen controller for X, Y and
> > Pressure values. This reduces the overhead of interrupt-driven
> > operation. Upon the PENUP event, the worker thread re-enables the
> > PENDOWN detection interrupt and exits.
> 
> I still have a few reservations about this patch.  Firstly
> I would love to see a more generic approach to this as I outlined
> before.  Still we can't have everything we want sometimes :)
> Also, this is a lot of input related code in a driver that isn't
> in the input subsystem.  Really up to Dmitry on whether he is
> happy with this, or whether he insists on an mfd.
> 
> So all in all, with reservations I'll add this to the IIO tree
> IF Dmitry is happy with it and there are no other issues raised
> in the meantime.

Understood, I'll wait for Dmitry.

> Jonathan
> 
> p.s. If anyone has time, I'd also like to get this out of staging
> in the coming cycle.

[...]
