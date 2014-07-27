From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v2] iio: exynos-adc: add experimental touchscreen support
Date: Sun, 27 Jul 2014 23:50:51 +0200
Message-ID: <1743122.0WWLup698P@diego>
References: <5068889.1KfVx3ksNo@wuerfel> <53D56ABD.8080808@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53D56ABD.8080808-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Am Sonntag, 27. Juli 2014, 23:10:21 schrieb Hartmut Knaack:
> Arnd Bergmann schrieb:
> > @@ -205,6 +217,9 @@ static void exynos_adc_v1_init_hw(struct exynos=
_adc
> > *info)>=20
> >  	/* Enable 12-bit ADC resolution */
> >  	con1 |=3D ADC_V1_CON_RES;
> >  	writel(con1, ADC_V1_CON(info->regs));
> >=20
> > +
> > +	/* set default touchscreen delay */
>=20
> Any information about how many =B5s/ms it is actually set with this v=
alue?

"ADC conversion is delayed by counting this value. Counting clock is pc=
lk."
So, I guess here 10000 pclk ticks.


Heiko

>=20
> > +	writel(10000, ADC_V1_DLY(info->regs));
> >=20
> >  }
> > =20
