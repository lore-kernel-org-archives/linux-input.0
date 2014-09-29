From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 2/5] i2c: i2c-cros-ec-tunnel: Set retries to 3
Date: Mon, 29 Sep 2014 11:19:44 +0200
Message-ID: <20140929091944.GA1559@katana>
References: <1411053538-17237-1-git-send-email-javier.martinez@collabora.co.uk>
 <1411053538-17237-3-git-send-email-javier.martinez@collabora.co.uk>
 <20140929074940.GB5985@lee--X1>
 <20140929075014.GC5985@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140929075014.GC5985@lee--X1>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Gwendal Grignou <gwendal@google.com>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2014 at 08:50:14AM +0100, Lee Jones wrote:
> On Mon, 29 Sep 2014, Lee Jones wrote:
>=20
> > On Thu, 18 Sep 2014, Javier Martinez Canillas wrote:
> >=20
> > > From: Derek Basehore <dbasehore@chromium.org>
> > >=20
> > > Since the i2c bus can get wedged on the EC sometimes, set the number =
of retries
> > > to 3. Since we un-wedge the bus immediately after the wedge happens, =
this is the
> > > correct fix since only one transfer will fail.
> > >=20
> > > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > > Reviewed-by: Doug Anderson <dianders@chromium.org>
> > > Acked-by: Wolfram Sang <wsa@the-dreams.de>
> > > Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co=
=2Euk>
> > > ---
> > >  drivers/i2c/busses/i2c-cros-ec-tunnel.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> >=20
> > Applied, thanks.
>=20
> Wolfram,
>=20
> Do you want a pull-request?

Nope. All fine, there shouldn't be any conflict.


--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKSQwAAoJEBQN5MwUoCm2tugQAIknXzS653aexPP7CD6uhrgE
XRBsZ6vFOBgu4522tCrzRIV3hygVfyTBz8tj+vCaGDoLMSNNKvgB0eA6zv5bJJ1l
3GqL3HiyAf0vo6i6tLxaI5YsGl/VgN0/NfJU/9gO6rNvyL23rTpKQnOSfeeC/lIs
mzP9K7L69f95unJuu2u+ZjEoBsVPSAp+JVhNSNdVRlJGYnp5U1/kaxwisATziO4w
om5SJTRPViWmW8u8ZC6soCepfS3ZXKZm92wfmS1jWLLgCUsMc9LNVtQS5nsyrxLd
nD/r3Wy2bu1G/n7Ar1E12WN5bW4SBkXMqFuupxI6bN4vsIWtMTaxo7mCifBLzNg5
ZA9/Lz88OcHJaNVQjz9kHViyVpIu2fOp16q5/YRIpbGNjbc2Tl1IolAozgf6GucZ
TF0sm6HZuYvARF0MbUsV9LQZzC97FwrPQ0TL/HJCQjU/01pyKY68fbwht5HcWIMR
Clwgh52vCmnd6gVBghUr68Ul9SwZpgzo1+5v19e2QqFIlz/xYYQUhKD4F2hFZ3HN
ov5JOEXomj5Obt8U/re8llmotLaaBwJvXr3J3LteukRMlzdvTSUo8e3tRj0+IeTM
9e/zHqeTK/2OdO3oj5yyhuAEm6vVuTyRjqiapBHt+zGGkuJMP+FpeAXgW0xSS3WQ
n2IWkjwfIHWbTlQwYSpA
=RZUZ
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
