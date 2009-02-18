From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: lockdep report at resume
Date: Wed, 18 Feb 2009 14:17:15 +0100
Message-ID: <1234963035.4023.7.camel@johannes.local>
References: <1234022517.4175.107.camel@johannes.local>
	 <alpine.LRH.1.10.0902111246040.22097@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DrvBaKL9AXzAJqp1cdyB"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:57012 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbZBROVh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2009 09:21:37 -0500
In-Reply-To: <alpine.LRH.1.10.0902111246040.22097@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>


--=-DrvBaKL9AXzAJqp1cdyB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-02-11 at 13:03 +0100, Jiri Kosina wrote:

> OK, so we are calling usb_reset_device() from hid_reset() workqueue. You=20
> have a composite device, mouse interface being handled by bcm5974 driver,=
=20
> and keyboard interface being handled by usbhid driver.
>=20
> bcm5974 driver doesn't have _pre_reset() and _post_reset() callbacks, so=20
> full unbind/bind cycle is performed by USB core. bcm5974_disconnect()=20
> calls input_unregister_device(), which creates reset_work ->=20
> input_dev->mutex dependency.
>=20
> Unfortunately I don't seem to see from the lockdep dumps where does the=20
> input_dev->mutex -> reset_work dependency come from, am I just completely=
=20
> blind?

Any news on this? I just got it again on -rc5, entirely the same report,
though it seems I need to have a mouse plugged in, then hibernate,  then
unplug mouse and finally resume to get this report. IOW it doesn't seem
to happen if I don't change the hid devices during hibernate.

johannes

--=-DrvBaKL9AXzAJqp1cdyB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJnApYAAoJEKVg1VMiehFYDcIQALQTYjXivL+r7aCMrQM8rTN6
zGBN9GNX4YjAu4QjnbQfB5Ze44WIRYyafxX81zN5azkainjQ2ROc8aeRS3aVZljt
yPCPs6xs5aM9MNjAUzb3A/EbwI0NXdnJOhE0Vl5sl/EvOOEknk6p6zabB946wNDW
IQRUb3vjmsjoPFlTrbCFDKSvMOAmXhof66t0GFD8e/RIxMOWbpmnEVXDJLLs4hY6
Cks5/M9Vw2kju/GBj4XaeZ9z2vDdpFNxCDBrVhwyzUcWnq2luJI+8x/JB+AoObMj
e0qPxrNr6NGIra98B4/Wu6drEMKP/jG+5W5JgxVkiCiMH3/55wdJWwByIxyFyCHc
aqa09GdsoQjYFSFeU9idZZvQ9Ozi0zbA5rGxVcenT+wrmlXSkJYE/sPKUZ3UfPL+
m/VFDoCvezedR291QEVvPyHdru8KWoum6eBQvdkE+h1vT0kz4aAvD0EGdqiMVroA
Q8xl5m5qAM1H5ZNN88NrX51XupPMzjhExv1tiyZOF7gH60rQYi8K6u3/S904DTe+
CqBHI0H7zWcqKF1gfFHk1yKzeb8oK/ZCOyT6vFICzzzRFARCQxfK84DHFY1+oz1g
xQABGbXPgD6wWm7wY+Wq+HMcRWFvd5+Gy6t/1JXEyHlaTcJK11SrNd2yJ6gSQIQG
ZdyvwKyulhkJuIsPS3RA
=+HKh
-----END PGP SIGNATURE-----

--=-DrvBaKL9AXzAJqp1cdyB--

