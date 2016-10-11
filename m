From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/5] Input: add driver for Ilitek ili2139
 touch IC
Date: Tue, 11 Oct 2016 11:51:14 -0700
Message-ID: <20161011185114.GB8841@dtor-ws>
References: <20161011003359.26079-1-icenowy@aosc.xyz>
 <20161011003359.26079-3-icenowy@aosc.xyz>
 <20161011174046.GA27925@dtor-ws>
 <220181476210841@web5j.yandex.ru>
Reply-To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDP6N55ZUYDRBJXJ6S7QKGQEA3VO6PA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <220181476210841-OHkeJ68Zrv9uio3avFS2gg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Henrik Rydberg <rydberg-FFUHeuDi6mxAfugRpC6u6w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jarkko Sakkinen <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Rask Ingemann Lambertsen <ccc94453-1EA3ORoCGBhoJ7GROcy7lA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Damien Riegel <damien.riegel-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jeffrey Lin <jeffrey.lin-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org>, Javier
List-Id: linux-input@vger.kernel.org

On Wed, Oct 12, 2016 at 02:34:01AM +0800, Icenowy Zheng wrote:
>=20
>=20
> 12.10.2016, 01:40, "Dmitry Torokhov" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> > Hi Icenowy,
> >
> > On Tue, Oct 11, 2016 at 08:33:57AM +0800, Icenowy Zheng wrote:
> >> =C2=A0This driver adds support for Ilitek ili2139 touch IC, which is u=
sed in
> >> =C2=A0several Colorfly tablets (for example, Colorfly E708 Q1, which i=
s an
> >> =C2=A0Allwinner A31s tablet with mainline kernel support).
> >>
> >> =C2=A0Theortically it may support more Ilitek touch ICs, however, only=
 ili2139
> >> =C2=A0is used in any mainlined device.
> >>
> >> =C2=A0It supports device tree enumeration, with screen resolution and =
axis
> >> =C2=A0quirks configurable.
> >>
> >> =C2=A0Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
> >
> > Please extend ili210x.c instead of adding brand new driver, they look
> > very similar.
> >
> > Thanks.
>=20
> The driver is too old, lack of maintaince and needs some platform data ha=
cks.
> (At least makes it not capable to be used on current ARM devices, as they=
're
> described with device tree)

There are many drivers that can do both platform and dt-setup.

>=20
> Maybe I will rename the new driver modified by me to ili210x, add support=
 for
> the old protocol (but I have no chips to test it), and drop the old ili21=
0x.
> (This driver is capable of dt probing, and uses devm_ functions)

You can add "racy on removal" to the list (you need to take care your
work is canceled at right times, and canceling it before interrupt is
freed is not the right time as interrupt might fire and the work get
scheduled again). Also I think your driver is essentially working in
polling mode because you always reschedule the delayed work.

No, like I said, please work with existing driver, adding DT support and
support for the newer version of the protocol.

Thanks.

--=20
Dmitry

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
