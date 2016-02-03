From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 2/3] Input: rotary-encoder - move configuration data
 to driver data
Date: Wed, 3 Feb 2016 10:35:27 +0100
Message-ID: <20160203093527.GD13664@pengutronix.de>
References: <1454408678-6011-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1454408678-6011-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <56B09CAB.5020600@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56B09CAB.5020600-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Cc: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sylvain Rochet <sylvain.rochet-ETtyaVkrhkNWk0Htik3J/w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hello,

On Tue, Feb 02, 2016 at 01:10:19PM +0100, Daniel Mack wrote:
> On 02/02/2016 11:24 AM, Uwe Kleine-K=F6nig wrote:
> > This is a preparation for the next patche. There is no change in
> > behaviour intended.
>=20
> This one looks good to me, but it clashes with Dmitry's latest patch
> sets (which I haven't found the time to test yet, sorry!).

There is nothing in next-20160203, so I assume Dmitry either fixes this
up when applying my patches or tells me when I should rebase.

> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>=20
>  Acked-by: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
