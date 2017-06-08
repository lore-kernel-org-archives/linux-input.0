From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 2/2] Input: pm8941-pwrkey: Introduce reboot mode support
Date: Thu, 8 Jun 2017 18:32:43 +0200
Message-ID: <20170608163243.j4dfpa6swoz27ofd@earth>
References: <20170527065130.3456-1-bjorn.andersson@linaro.org>
 <20170527065130.3456-2-bjorn.andersson@linaro.org>
 <20170530025324.GD32841@dtor-ws>
 <20170530044711.GP12920@tuxbook>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s7xcpngy7hpx6lxz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170530044711.GP12920@tuxbook>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, John Stultz <john.stultz@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--s7xcpngy7hpx6lxz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 29, 2017 at 09:47:11PM -0700, Bjorn Andersson wrote:
> On Mon 29 May 19:53 PDT 2017, Dmitry Torokhov wrote:
>=20
> > On Fri, May 26, 2017 at 11:51:30PM -0700, Bjorn Andersson wrote:
> > > In some Qualcomm platforms the magic for informing LK which mode to
> > > reboot into is stored in the PON_SOFT_RB_SPARE register. Register with
> > > the reboot mode helpers to expose this to the user.
> >=20
> > Hmm, is the power key driver the best place to have this? WHy isn't this
> > a driver in its own right?
> >=20
>=20
> The functionality is part of the "PON" block in the Qualcomm PMICs,
> other functionality from this block relates to configuration and
> handling related to power-key and reset-key.
>=20
> Several of these properties are intermingled, so I do believe it's best
> to handle them in a single driver; that said, it might no longer be
> correct to name the driver "pwrkey" or that it is a "misc input" driver.

I merged patch 1 and provided an immutable branch, so
that this could go through the input subsystem.

To me it doesn't look that intermingled, though. I think
the reboot and reboot-mode parts could go into their own
driver in drivers/power/reset.

-- Sebastian

--s7xcpngy7hpx6lxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk5fCsACgkQ2O7X88g7
+pr4Gw/+MeFLNe4U3KbjZ+pG8yIyixHyk8KK9lX/FIlKW40kyJOi2dJi0LD7xrLo
hRcTjKL44opiCjl/cooBDu9ke/vO5YjMvc8MsUSEiX7mUTtuPsqWTE2/D2jNOiUy
hTqi9Jx4Ot2gv/Mf9z2EeDOSeei6MA8ooZI2YLunwSAtiRgPkY3I6eN3D1ID4WVg
/JoZQdbQPkkm35pxh0G8gpOYh477W1kIExS1to1Da0FG8lT0Zlp36pZSDNoxq/B4
Dw9b9chYGXtEVm99nJUoTBFPA1NcIlWme/om0EujtpZL24zGXtfd+LidASxCINOX
cTNmjUuO6XmRSTw7yM4KpxiD9rUy6oZPFIGF6M2eE6Mfev155Lnm7kMdADSD7m5p
GZ4PLApmnuN8JlcnkWYybXKgTXHWsyveaP34VO2TcOVQzZ6Z6K2wnQYiVpXEJ32k
bDep+eVClqskliX9bDGrbjE/PjnJeFl1f4TK7WBJpHTK8RW8aGGzNu7J97A6MZOv
kJLEs+AhbN1MXIfPoCDJi+BMMaZzjLW13MvCV3QUThcMtsIPavjdVDkkggbGHYQn
xCxVSAT9d4SjBTy+ZTLdwuYXq3uwDeb1MIpTttvsWTX0bnlAJS++zocD/Aqm9dT7
45GS61fb+iLPq1cHjaT8fRS+imbZ+WLCAIfYU2LcGPHIRDd8Jwo=
=R9tb
-----END PGP SIGNATURE-----

--s7xcpngy7hpx6lxz--
