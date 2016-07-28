From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] i2c: cros-ec-tunnel: Fix usage of cros_ec_cmd_xfer()
Date: Thu, 28 Jul 2016 16:15:51 +0200
Message-ID: <20160728141551.GC28342@ulmo.ba.sec>
References: <1469470451-111822-1-git-send-email-briannorris@chromium.org>
 <1469470451-111822-2-git-send-email-briannorris@chromium.org>
 <20160725204313.GA1698@katana>
 <20160725204825.GA144142@google.com>
 <20160726091433.GC2433@ulmo.ba.sec>
 <20160726183819.GA9660@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34004 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758585AbcG1OP4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2016 10:15:56 -0400
Content-Disposition: inline
In-Reply-To: <20160726183819.GA9660@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Olof Johansson <olof@lixom.net>, Brian Norris <computersforpeace@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Shawn Nematbakhsh <shawnn@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 26, 2016 at 11:38:20AM -0700, Brian Norris wrote:
> Hi Thierry,
>=20
> On Tue, Jul 26, 2016 at 11:14:33AM +0200, Thierry Reding wrote:
> > On Mon, Jul 25, 2016 at 01:48:25PM -0700, Brian Norris wrote:
> > > On Mon, Jul 25, 2016 at 10:43:13PM +0200, Wolfram Sang wrote:
> > > > On Mon, Jul 25, 2016 at 11:14:10AM -0700, Brian Norris wrote:
> > > > > cros_ec_cmd_xfer returns success status if the command transport
> > > > > completes successfully, but the execution result is incorrectly i=
gnored.
> > > > > In many cases, the execution result is assumed to be successful, =
leading
> > > > > to ignored errors and operating on uninitialized data.
> > > > >=20
> > > > > We've recently introduced the cros_ec_cmd_xfer_status() helper to=
 avoid these
> > > > > problems. Let's use it.
> > > > >=20
> > > > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > >=20
> > > > I agree with Dmitry about Thierry pushing the patch. So:
> > > >=20
> > > > Acked-by: Wolfram Sang <wsa@the-dreams.de>
> > >=20
> > > Fine with me, as long as Thierry is up for it.
> > >=20
> > > BTW, I think the dependency is on target for v4.8-rc1, so if Thierry
> > > misses this, then you should be able to apply this yourself after the
> > > merge window.
> >=20
> > Why the rush? The behaviour of the cros_ec_cmd_xfer() function has not
> > changed in at least a year, so this can't be very urgent. I merged the
> > original patch because it is a dependency for another patch, but given
> > the above I think it's fine if we wait until after v4.8-rc1 and let
> > subsystem maintainers pick them up individually.
>=20
> I wasn't personally suggesting it was a rush -- actually, the contrary.
> I was just informing Wolfram and Dmitry that the dependency only was
> relevant *if* they were rushing to have the patches applied.

Okay, I'll let Wolfram and Dmitry pick these up after v4.8-rc1 then.

> > On another note, the commit message makes it sound like this might fix
> > potential bugs. Since it's been like that for a couple of releases, do
> > we need to Cc: stable@vger.kernel.org?
>=20
> It does potentially fix bugs. I suspect those bugs would probably occur
> mostly in cases of poorly-configured software (e.g., using the wrong EC
> protocol) or prototype hardware, but it's certainly possible this could
> head off in-the-field bugs. Perhaps Gwendal or Shawn could elaborate.
>=20
> At any rate, if you Cc: stable@vger.kernel.org, you'll want to include
> the dependency in the commit message. I think the format is something
> like this:
>=20
> Fixes: SHA ("i2c: wherever this driver was introduced")
> Cc: <stable@vger.kernel.org> # 9798ac6d32c1 mfd: cros_ec: Add cros_ec_cmd=
_xfer_status() helper

That's information you're supposed to add to your patch as the author,
so as a courtesy to upstream maintainers, perhaps resend these two
patches with a complete set of tags once v4.8-rc1 has been released?

Thierry

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXmhOXAAoJEN0jrNd/PrOh18IP/3FYunhvuJZAGkbXFZxc3a8W
vshi3WGN7SfTz4kJJiJViZNFJnuXFsEWd5mhmLyh3VPdS2X1Ko/22/TgecOw1tAe
MyAUNnBITMv3g+6YG4v3rXUadveJaIBngQJR4zQ5RPUeyWXka8y0mADr3rtYhLd6
5CrVngJVbSmLLoZy00z9FSWB0yCiRTVMbQbRmyADr7HaxZeMonQ3kE92NfyCOrzd
9qTplgU6veHQReXQ7xZ0IHqBAxakRV2OtiN98D/OpxDlPperd/Ew4w3QhUsAKa+B
J55euvbVQal7/ZKUkBez9QDz4p/akbfc8C1N/Jd3C749XspWq8Rs141mBycDrcV4
lFXrBa8YkSnWsu3d7ngxTz7JTdB0LAysR156yEaoLfXN67p+lfsQWgM7fw9ge4KG
ohmdygmhUbyN9k4dPm3xxtPwIrABHqyTmeFQqOx+3yVutsfK4l/j5Uf5HIKBovY1
C3/MAy5xL9HSFI8mVHYKfkUthI8vY4ylX9UA2Gg1YFSmsdAI9dsTw3CIgZopEtHS
sBeTabXswtyO5KKqJPqe2OSWomiiDCONqzyehU+S5YGdZELQSESmRpae9yctafr1
mfKS5wL7H8AgLc/gktrlCjkvPK3a5RCJKoTE/kuWdzjLCqasIUzr0z7sOujH70I/
xLZHzKsBPL02BH6k2VPf
=FgKz
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
