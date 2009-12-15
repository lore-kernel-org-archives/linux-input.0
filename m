From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] [input] add mc13783 touchscreen driver
Date: Tue, 15 Dec 2009 08:45:57 -0800
Message-ID: <20091215164557.GA21995@core.coreip.homeip.net>
References: <20091212074214.GB2956@core.coreip.homeip.net> <1260871828-358-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932594AbZLOQqR@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1260871828-358-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-input@vger.kernel.org

Hi Uwe,

On Tue, Dec 15, 2009 at 11:10:28AM +0100, Uwe Kleine-K=F6nig wrote:
> Hi Dmitry,
>=20
> I squashed your changes into this patch, restored my indention style =
and
> simplified error handling in mc13783_ts_probe to assign ret =3D -ENOM=
EM=20
> once at the start of the function instead of each error branch.

I prefer to have error defined right before we jump because it allows
reader to see explicitely set error condition instead of having to
verify if earlier code set it properly; it also forces you to set error
conditions on every error branch properly (if you forget while adding a
new one compiler will warn you about uninitialized variable), but I
won't insist.

>=20
> In the meantime the changes to mc13783-core are merged in Linus' tree=
,
> so it can go via your's.
>=20

It settled then.

--=20
Dmitry
