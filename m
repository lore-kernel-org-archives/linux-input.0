From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] Input: Add driver for Cypress Generation 5
 touchscreen
Date: Wed, 7 Jun 2017 11:16:23 +0200
Message-ID: <20170607091623.ot5qbsrrsf5ktgen@flea.lan>
References: <20170529144538.29187-1-mylene.josserand@free-electrons.com>
 <20170529144538.29187-2-mylene.josserand@free-electrons.com>
 <20170530080225.rgvy5too2cy5m2zp@flea.lan>
 <c732ffe4-e0fb-16d7-c27a-d18a1995c360@free-electrons.com>
 <20170606120400.ekfbbaai7myscitu@flea.lan>
 <0232a641-c741-1f95-9086-840b31f5d055@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="chb7mygfr7ml42e7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0232a641-c741-1f95-9086-840b31f5d055-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mylene Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, fery-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org


--chb7mygfr7ml42e7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2017 at 04:32:46PM +0200, Mylene Josserand wrote:
> > > Notice that the DT parsing uses a sysinfo's variable (si->num_btns)
> > > which is retrieved in the startup function (thanks to
> > > get_sysinfo). So, currently, it is not possible to move the startup
> > > function after the DT parsing.
> >=20
> > Can't that be made the other way around? You parse the number of
> > buttons in the DT, and check the consistency with the hardware?
>=20
> It could be possible but currently, it was designed to enable every button
> from hardware's configuration and DT binding was just a way to customize
> button's keycode (default is KEY_RESERVED).
> If I base it on the DT, it means that some buttons could never be reported
> (such as deactivated) because they will not be present in the DT. I am not
> sure if it is the behavior we want. What do you think?

I don't really know. Both look reasonable, and it seems to be more a
matter of policy. Dmitry?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--chb7mygfr7ml42e7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZN8RnAAoJEBx+YmzsjxAgSjsP/RF000JaCdJpyj50L4feWBc0
L8ARPUg/Fm06ZeZOwl6tLp4JHDTFNWiinsIsksNjLm2mxfy08pJCWLiJh28MbxoW
tSfGhz39Ukc4MgdnjzWObx/YgmwiEc2C1GBypPxp/vR+sYa5eECU+UMW8BQPJI0A
U8V7/ZM1wGt6e2a/IqR0olGl7vL2zLrkZcOE7sgmxcvBbjpZyO4038GRkOw3lv/y
1gDO1lqFJZ81C7cWCnnHWhjbmQ1IK//uooTl2HjBJSrYHKIrAoIHmUxLBxd5N4MM
MQNzpOtJEpqWOA96r29cAEPmAENkQV9zA0ddbghVNZ5nkDmfzL+FgDYA0ADxYuRj
fnoqc2C1aF4fEEz0P/wP18rFYLzuxmO/IVvx3ZnP2JI1qhRMOnWAbytc08UkKcOp
3LGi+gBkLrwp8XTw4x82mTZa6e9a+2x8h7Ol0QJ9d8cRuIide91jZRykZCe9E4TL
CeT0k3sdlVTSPh84GdFszJXTQtlvFcEPZ1g5frxDSMVl+A28IrRLFA9ZlbeJqtJs
auyFJqHahAp/TJmoyM+PKYbDUys7qdEEcVqUfQ0UBU3y5e3riY1x3w32O096wH2O
XJ6nHz2Ik5VsRk4tsfV+UkX0FiCzZaQei+H97IcyA/fvbddGYyRy1L5F0fx7y2OY
wAKx3gs7Cv5EUz5AjGIA
=AujU
-----END PGP SIGNATURE-----

--chb7mygfr7ml42e7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
