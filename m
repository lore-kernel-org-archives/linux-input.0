From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] Input: ar1021-i2c - fix too long name in driver's device
 table
Date: Tue, 13 Dec 2016 06:58:17 +0100
Message-ID: <20161213055816.GA2125@katana>
References: <20161212235702.GA10843@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161212235702.GA10843@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, m.frohiky@gmail.com, Christian Gmeiner <christian.gmeiner@gmail.com>
List-Id: linux-input@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2016 at 03:57:02PM -0800, Dmitry Torokhov wrote:
> The name field in structure i2c_device_id is 20 characters, and we
> expect it to be NULL-terminated, however we are trying to stuff it with
> 21 bytes and thus NULL-terminator is lost. This causes issues when one
> creates device with name "MICROCHIP_AR1021_I2C" as i2c core cuts off the
> last "C", and automatic module loading by alias does not work as result.
>=20
> The -I2C suffix in the device name is superfluous, we know what bus we
> are dealing with, so let's drop it.
>=20
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D116211
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYT434AAoJEBQN5MwUoCm2ta4QAITW7dN7lA7XsdYIE8yHOgTL
KDQ+y3XHt0TpZmsziAZPPIhvS9EaXRCDg1CHf8X4+k6+6yS1CSYJeCDl0LhrcLkc
dZtGk4fGShbiOAAc3T5jIe3aCn5Tq6G93B8FQUOvFjgPDSoCQ6i1k33EatC4gnG4
zQqbY0xbFtLNlAZBLnhFuL1jgte3+F8cLPvB6zvXn8wB1byuFJ3nJXSEOwOXNCOw
+kTXC6Zo91U4p8LLSekh2a02SOQxkZysb6W6LwqPh6y5dpgWV76M/kdjZ/jDSGsd
BJdYM/hunoMMt3YD+DfM+hd7pyNjDnWrMlIlED+1bjZl305WKLnyKyq6ooL20OIC
+hDHef+6LPTwvX0yaFfvaLHMUBbdD/+g6Z6V35tYpWqC/Od6Eob57GJRmdIGi2Zu
vKIzzVKyWTbwXE9330VOwVVuUzENwjeo3sO8R3VTpbyBc7WbCOB587h+pPCtkxJb
SATBipVyI54B/6RgeVqUDF1CooXZQyX4gauSfi+8swepMOtskx7FNEEvmc9MFbv3
Gc2jJHYeFKPd9yUa0IzX2TWJCF1WHC/ZpzMsWby50EsuFmiK1zpIz5EfiY4r7VeX
fW8oTl5HsHXHXhDtoiB8Hms9iu0I2RIlgo+I04wKS37sCrZJDEw7hzKnudzbCAGh
tj7qWzboQnsOVLkYyW7w
=LD5M
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
