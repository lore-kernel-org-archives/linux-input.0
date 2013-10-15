From: Forest Bond <forest@forestbond.com>
Subject: Fixing 0eef:0001 (eGalax) driver binding
Date: Tue, 15 Oct 2013 14:27:01 -0400
Message-ID: <20131015182701.GD14822@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from storm.alittletooquiet.net ([67.23.28.199]:44184 "EHLO
	storm.alittletooquiet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757481Ab3JOSsw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Oct 2013 14:48:52 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Sebastian =?iso-8859-1?Q?Dalfu=DF?= <sd@sedf.de>, Jiri Kosina <jkosina@suse.cz>, Daniel Ritz <daniel.ritz@gmx.ch>, Max Weninger <max.weninger@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Christian Engelmayer <christian.engelmayer@frequentis.com>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

[If you're Cc'd it's because I thought you would be interested=E2=80=94exce=
pt for Max!
Max, I was hoping for some quick help if you still have that eGalax touch s=
creen
you reported about back in 2009.]


To review, these are devices with vendor ID 0eef and product ID 0001 (or 00=
02,
which I've never actually seen myself) with varying interfaces class, subcl=
ass,
and protocol.  Different devices have worked with different mainline driver=
s to
varying degrees over the years.  It has never been entirely clear how to
(automatically) select a driver to bind to a particular device.

There is some history to this situation that I will not describe in detail =
here
as I think it is most beneficial to focus on the present situation.  To that
end, here are the relevant points of interest (to the best of my knowledge):

1. Devices with vendor specific class and protocol apparently work fine with
   usbtouchscreen, which is where they are bound.  Nice!

2. Devices with class HID, protocol Mouse apparently work fine with usbhid,
   which is where they are bound.  Woo hoo!

3. Some devices with class HID, protocol None work fine with usbtouchscreen,
   which is where they are currently bound.  Okay!

   Some of these also work with usbhid (using quirks=3D0x20000048 to preven=
t it
   from being ignored).  All of the ones I have here are like this.  I'm not
   sure if there is a reason to prefer one driver over the other (dual touc=
h?).

   Others reportedly do *not* work with usbhid (this is Max):

   https://lkml.org/lkml/2009/1/25/127

4. Some devices with class HID, protocol None do *not* work with usbtouchsc=
reen,
   which is where they are currently bound.  No bueno.  Here's one (this is
   Sebastian):

   http://comments.gmane.org/gmane.linux.kernel.input/31710

   I suspect these are all multitouch devices, but I am not sure.

So we need to figure out the device driver mapping that supports the most
devices (or regresses the fewest, although I think we've messed this up eno=
ugh
for that to be a secondary concern).


What I'm hoping is that the report in #3 that led to class HID, protocol No=
ne
devices being bound to usbtouchscreen is no longer accurate and these devic=
es
work fine with current usbhid.

Max, can you test this for us?  I.e. does your touch screen work with curre=
nt
usbhid using quirks=3D0x20000048?  The following modprobe snippet might be
helpful:

options usbhid quirks=3D0x0eef:0x0001:0x40000048
install usbtouchscreen /bin/false

If Max's touch screen works with current usbhid, I think we can drop the sp=
ecial
case that binds it to usbtouchscreen and we're done!  If not, things will be
more complicated (e.g. we may have to consider whether a device is multitou=
ch to
decide if we should bind usbhid or usbtouchscreen).


Hope we can get it sorted.  Thanks for your help and input.

Regards,
Forest
--=20
Forest Bond
http://www.forestbond.com/
http://www.rapidrollout.com/

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlJdiPUACgkQRO4fQQdv5AwozwCfftoMhCKtPHuzOUjHiBSv31nd
2xkAoKUxh3nE2pUtX0M+SRPz7DJ27Ku2
=qjL7
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
