From: Benson Leung <bleung@google.com>
Subject: Re: [PATCH] Input: cros_ec_keyb: mask out extra flags in event_type
Date: Fri, 14 Jun 2019 12:09:57 -0700
Message-ID: <20190614190957.GA243443@google.com>
References: <20190614065438.142867-1-phoenixshen@chromium.org>
 <CAPR809sASD=MrQkJULVBgc_iqiPKE2xr8eUR0d4qymQkLUYRaw@mail.gmail.com>
 <20190614185533.GA142889@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190614185533.GA142889@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Enrico Granata <egranata@google.com>, Ting Shen <phoenixshen@chromium.org>, LKML <linux-kernel@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Pi-Hsun Shih <pihsun@chromium.org>, Enrico Granata <egranata@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Heiko Stuebner <heiko@sntech.de>, Guenter Roeck <groeck@chromium.org>, Brian Norris <briannorris@chromium.org>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, gwendal@chromium.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-input@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Fri, Jun 14, 2019 at 11:55:33AM -0700, Dmitry Torokhov wrote:
> On Fri, Jun 14, 2019 at 11:27:03AM -0700, Enrico Granata wrote:
> > On Thu, Jun 13, 2019 at 11:54 PM Ting Shen <phoenixshen@chromium.org> w=
rote:
> > >
> > > http://crosreview.com/1341159 added a EC_MKBP_HAS_MORE_EVENTS flag to
> > > the event_type field, the receiver side should mask out this extra bi=
t when
> > > processing the event.
> > >
> > > Signed-off-by: Ting Shen <phoenixshen@chromium.org>
> >=20
> > Reviewed-by: Enrico Granata <egranata@google.com>
>=20
> EC_MKBP_EVENT_TYPE_MASK is not in Linus' tree. It would be better to
> merge this path through whatever tree that is bringing in that
> definition.
>=20
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Yup, this looks like it's coming in through Lee's MFD tree, a series from
Gwendal to update cros_ec_commands.h.

784dd15c930f mfd: cros_ec: Fix event processing API

That commit is in the immutable branch for v5.3 here:
 git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-cros-v5.3

I'd recommend the chrome-platform tree since we'll be pulling in that IB too
for some other refactoring Enric is working on.

Thanks,
Benson

>=20
> Thanks.
>=20
> --=20
> Dmitry

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXQPxBQAKCRBzbaomhzOw
wjbnAP9f8fuB3qp/BLcnKIDCaVJuUkXv7kRFVev0gUsyOwWh+gD9GYkTyM0et9Iq
t823F3GYAzo2PQLkdpuRbESWLoCW1wU=
=Lfmp
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
