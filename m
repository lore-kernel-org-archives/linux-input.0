From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: core: Allow the driver to override the default
 i2c_bus match behavior
Date: Mon, 14 Aug 2017 23:21:15 +0200
Message-ID: <20170814212115.GA5142@katana>
References: <20170722185537.12696-1-hdegoede@redhat.com>
 <de6bf483-9ef4-522b-507d-272f736bcabc@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:50376 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752275AbdHNVVR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 14 Aug 2017 17:21:17 -0400
Content-Disposition: inline
In-Reply-To: <de6bf483-9ef4-522b-507d-272f736bcabc@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2017 at 10:13:23PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 22-07-17 20:55, Hans de Goede wrote:
> >Some ACPI devices report multiple ids for a single i2c_client, while not
> >really implementing the hw-interface asociated with some of these ids.
> >
> >For some of these devices calling probe and having probe fail with
> >-ENODEV is a problem in itself as this causes the device to be
> >powered-up and down again (causes its PS0 and PS3 ACPI methods to be
> >executed) which puts some devices in an unusable state.
> >
> >This commit adds a match callback to i2c_driver, allowing drivers to
> >override the default i2c_bus match behavior and tell the core they
> >are not the right driver for the device, avoiding i2c_bus_type.probe
> >getting called, avoiding the undesirable power up / down cycle.
> >
> >Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>=20
> What is the status of this series ? I thought there was agreement
> on merging this through the i2c (wsa/linux.git) tree ?

Yes, but I need to review the I2C core changes first.


--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmSFEcACgkQFA3kzBSg
KbZRXg/7BJuQgjl1XSMgZ4IjKAl3MgLMhUql4jgvOlV4Pl2NgIhqx2W4L4lMitfM
RylBdPL4y4F/NBt/85zhu7Jh63oEfWdp16OBxspu0LyIIOgqYSuJnigyPTKA1EQB
PqE9+1ZVoZdrqa4QmQbm8LmhHlrYS8PSK5NQ+LAv0kglfSJf9biKs1I4GkgdW6pO
xfgH0WESpjOeWqCh9SNoWK5kEkP2rLbGTEpr5PkhhH5jrL/50Of1jzzC5w4XqniS
Vp+mZM1+gixiyVLZtaFVst9a42/LzH3JdgYfpcZNZlZmyFozJxQ6mb7WUxZl+4ua
dhejx3VgpDFz6tUs+ret92MEbjLXEPOiutJSreqe+uMiEF7mKpLpd2uA7oS640FK
IqfkM8F4X8mipk4m2IS7AqX9Q7XlE0KIs6Du+DrGM51g+OSDSbPI4oDNDKtZmr3O
X7Q7l/5B6ldvrdiLwSVajSel5nghrzYffEGiCHjB5FAvEOkGF7Ecs362NcYLNR+H
/hzri8S2Z1NGwipKhekSe2KWXjHGX4qAYI3wqf7c35B2RwTWEckQne1YuuaNI/OG
l1jpOLi92OUrWhbtwEbj6u+0dvd/n33O6ofoETO9u5C7PKk75o+cQnSUQlrLs9/O
xWB6u60W4nTqqrTdDEl3kodenWCzUhPXxU+zsIEZCs0CdyMpH4Y=
=Cnez
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
