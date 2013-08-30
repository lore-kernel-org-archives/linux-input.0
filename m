From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: hid: egalax 0x0eef:0x0001 no longer detected by hid-multitouch
Date: Fri, 30 Aug 2013 14:45:02 -0400
Message-ID: <20130830184502.GH13685@alittletooquiet.net>
References: <20130830175946.GA17584@sedf.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from storm.alittletooquiet.net ([67.23.28.199]:39068 "EHLO
	storm.alittletooquiet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab3H3THZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Aug 2013 15:07:25 -0400
Content-Disposition: inline
In-Reply-To: <20130830175946.GA17584@sedf.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian =?iso-8859-1?Q?Dalfu=DF?= <sd@sedf.de>
Cc: linux-input@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On Fri, Aug 30, 2013 at 07:59:46PM +0200, Sebastian Dalfu=DF wrote:
> In 3.6.x the egalax touch panel (Vendor: 0eef, Dev: 0001) worked=20
> perfectly well with hid-multitouch, right out of the box. In 3.9 and=20
> 3.10 it doesn't; the panel doesn't show up in /proc/bus/input/devices .
> If the module usbtouchscreen is present, 3.9/3.10 wrongly try to use=20
> that one (flipped y-axis, wrong scale, get's stuck) instead of=20
> hid-multitouch(worked previously perfectly well, no need for=20
> calibration, quirks, configuration). If usbtouchscreen isn't present,=20
> the panel isn't detected, even if hid-multitouch gets poked with appropri=
ate
> parameters in /sys/module/hid_multitouch/drivers/hid\:hid-multitouch/new_=
id .
> In an desperate attempt, I manually added the device/vendor id to
> hid-multitouch.c, which didn't yield any improvement. It seems that the h=
id
> subsystem doesn't even recognize that this device is indeed a hid=20
> touchpanel.

That's probably this:

commit 729b814acec20db66fc891b5392cb653ad6598ef
Author: Forest Bond <forest.bond@rapidrollout.com>
Date:   Tue Nov 6 13:41:22 2012 -0500

    HID: Ignore D-WAV/eGalax devices handled by usbtouchscreen
   =20
    Previously, both usbhid and usbtouchscreen would bind to D-WAV devices
    with class HID and protocol None, so they would be claimed by whichever
    driver was loaded first.  Some of these devices do in fact work with
    usbhid, but not all of them do.  OTOH they all work with usbtouchscreen
    as of commit 037a833ed05a86d01ea27a2c32043b86c549be1b ("Input:
    usbtouchscreen - initialize eGalax devices").  So we ignore them in
    usbhid to prevent getting in the way of usbtouchscreen and claiming an
    interface that we may not be able to do anything useful with.
   =20
    Signed-off-by: Forest Bond <forest.bond@rapidrollout.com>
    Signed-off-by: Jiri Kosina <jkosina@suse.cz>

The primary issue is that 0eef:0001 has been repeatedly re-used for a wide
variety of devices and as such cannot be meaningfully used on its own to se=
lect
a driver.  Some of these devices have class HID and worked fine with
usbtouchscreen.  When usbhid was introduced they stopped working because th=
ey
don't actually work with the HID driver.

Historically this is dealt with by submitting a patch that regresses everyo=
ne
else's screens but makes yours work better. ;)

So we need to figure out how to handle these devices.  I need to dig out the
screen I have that did not work with the HID driver and test it again.  Mig=
ht
take some time for me to get to this.

> Is there a way to force hid to take care of that vendor/device-id, as a
> temporary workaround?

For now look at hid_ignore in hid-core.c.  You can probably set
HID_QUIRK_NO_IGNORE to work around the problem.  You'll probably also want =
to
blacklist usbtouchscreen.

Hope this helps.

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlIg6C4ACgkQRO4fQQdv5AzndgCg25muo1rsCkEQRXCmhnGQM7vP
CwoAn1WEU1RCrwRtYLhdyhtNHjoBaeY7
=RPeQ
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
