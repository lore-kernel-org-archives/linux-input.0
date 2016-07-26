From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] i2c: cros-ec-tunnel: Fix usage of cros_ec_cmd_xfer()
Date: Tue, 26 Jul 2016 11:14:33 +0200
Message-ID: <20160726091433.GC2433@ulmo.ba.sec>
References: <1469470451-111822-1-git-send-email-briannorris@chromium.org>
 <1469470451-111822-2-git-send-email-briannorris@chromium.org>
 <20160725204313.GA1698@katana>
 <20160725204825.GA144142@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160725204825.GA144142@google.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Olof Johansson <olof@lixom.net>, Brian Norris <computersforpeace@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Shawn Nematbakhsh <shawnn@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 25, 2016 at 01:48:25PM -0700, Brian Norris wrote:
> On Mon, Jul 25, 2016 at 10:43:13PM +0200, Wolfram Sang wrote:
> > On Mon, Jul 25, 2016 at 11:14:10AM -0700, Brian Norris wrote:
> > > cros_ec_cmd_xfer returns success status if the command transport
> > > completes successfully, but the execution result is incorrectly ignor=
ed.
> > > In many cases, the execution result is assumed to be successful, lead=
ing
> > > to ignored errors and operating on uninitialized data.
> > >=20
> > > We've recently introduced the cros_ec_cmd_xfer_status() helper to avo=
id these
> > > problems. Let's use it.
> > >=20
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> >=20
> > I agree with Dmitry about Thierry pushing the patch. So:
> >=20
> > Acked-by: Wolfram Sang <wsa@the-dreams.de>
>=20
> Fine with me, as long as Thierry is up for it.
>=20
> BTW, I think the dependency is on target for v4.8-rc1, so if Thierry
> misses this, then you should be able to apply this yourself after the
> merge window.

Why the rush? The behaviour of the cros_ec_cmd_xfer() function has not
changed in at least a year, so this can't be very urgent. I merged the
original patch because it is a dependency for another patch, but given
the above I think it's fine if we wait until after v4.8-rc1 and let
subsystem maintainers pick them up individually.

On another note, the commit message makes it sound like this might fix
potential bugs. Since it's been like that for a couple of releases, do
we need to Cc: stable@vger.kernel.org?

Thierry

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXlyn3AAoJEN0jrNd/PrOhg+sP/0vk3yToqKkpjduhElpFOT9f
4JkfxT2aLBOusav+UoZhojTFFt/5HEKY5fQw37EgdDr1B8PL8OzG0QHzBEtr3Kqd
dkjChewtUZY3F4rM/NhHv0/2oo5/kcZTNachVyGjek2MpquFnUNZT70P2TJzvMg6
mwBbSMxf3fOCVCkVmaW3T97xZJBlltW0wVbQ5yO9xXrBrPVwfVvgWKqasFKd/u8R
jgh6PfAi4GU8eZpNYuZQVBcQGA/AQUvMHS1+kPzo4pbCBQHowary2w4JlDiINV1J
99U0EGEQpl/1NACsVORxpPODbsT/FuRxAz8JKhjtQ3KencN1iZz8WnCl06f9Sd4Y
fR7Ha55hapZ8SgiUqfAp4exp+BAkXbXhRBwXPCekB3xSDWEgmi1xYjQ5sAqasz5W
tbAWjSxtLHb3dFhVjRGAbHlbhAIirwqKf/YK8jfmhClNrGcLtZCCfY4Mp/ZhThXg
yeKPZLiLRLhXW0ae/Jzy0TEDROsQkPRO71BMjCD0As9Pi5XLsa5403hsFJjH9J0q
qtTO45WpgcllVNIEV+G+WcsHzycOlTGWnuHWYx5M+ZlyWcaOMIL7w7cc19E4Yf2/
kxmjz0fb5y7AH6qqOpu2Edq8tJ4+uKwJIKyUzamt2IdXaF3tW4h1Nny8m93XIzLn
EU4I6OWgUPT3yV3tkgjh
=rie1
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
