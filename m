From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 1/7] Input: pwm-beeper - remove calls to legacy
 pwm_request API
Date: Fri, 20 Jan 2017 11:08:54 +0100
Message-ID: <20170120100854.GA3824@ulmo.ba.sec>
References: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>, Frieder Schrempf <frieder.schrempf@exceet.de>
List-Id: linux-input@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2017 at 02:40:51PM -0800, Dmitry Torokhov wrote:
> There are no more users of pwm-beeper driver in mainline relying on
> this legacy API, so let's remove it and simplify the driver code.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/misc/pwm-beeper.c | 6 ------
>  1 file changed, 6 deletions(-)

Very neat. Thanks for that!

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliB4bMACgkQ3SOs138+
s6EqSA//XuMdFxLAb5BZ0Gce6ZZAgAZILZZLUxcLuV2fGjc/651U/fKlpc6Tu3Og
vCazuQgX6O6rNtUgRTGbsBCKTPxkqn4IHsfAA9IHE717xGUYL1PHKRV1F79JzmXL
QIZdDgJ3BupTdQtLJn1rX0txBpEYtCtilq5mVwtrxqlHDVE7oHtRuDD5d6frl0pr
nipwUS7sJj/14qYemW+cKB2m1AZ8qea8B8l4u+u8vD6AvaDCEehXxwk425mPnb9j
Gq0xB8cbnb/YVc+LVlD6TqMFxZrTRjLwi4NzajMFNzFNpmgl4JaRqScO0u3zUYod
wwYR76d9k/Wk7JATRBCNKOPEdGyC9JvMFgMATABgqzQT76i3f6d8f9nO5v/cMIXY
3X9guci66Z0T94YdCG8EulYftpCskPwkkpwcqz5jlofmlEEuqrI1dmzihfgG6nkD
lBTujwnuYFSJQ41aoZuXy2P1hRulmCeT0FcqHCyNkre31YitpLq2Yxy73k6H31l2
eDH0JfRMePYwOmRCFrj+JvlMG933c5tbXDQ+dFThS2Q4ZbbhS1rnKYwXRMIUZPvC
RaYT885est4MgBfOT+7bfUQbH/kkIFHW6P7vN/2OgiQ6QhqPakT6BV68vqx4eb6s
yk96AiYnxZQsXsHhaDU82gR9pxtzFRS7GIXLOcQT3kxLzFTrTAg=
=KuJo
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
