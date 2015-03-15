From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] hid: cp2112: support i2c_transfer() when num > 1
Date: Sun, 15 Mar 2015 15:27:59 +0100
Message-ID: <20150315142759.GA22313@katana>
References: <1426419798-25360-1-git-send-email-borneo.antonio@gmail.com>
 <20150315121020.GA14594@katana>
 <CAAj6DX0cXWHGV-=x0WfoSrXLVTEiNf+Vfj0HDOf4x4NC6Ny=tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33606 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752517AbbCOO1n (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Mar 2015 10:27:43 -0400
Content-Disposition: inline
In-Reply-To: <CAAj6DX0cXWHGV-=x0WfoSrXLVTEiNf+Vfj0HDOf4x4NC6Ny=tg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Borneo <borneo.antonio@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> 1) in few kernel drivers i2c_transfer() has been used to
> >> simplify the code by replacing a sequence of i2c_master_send()
> >> and i2c_master_recv(), e.g. in i2c-hid.c and iio subsystem.
> >> Those drivers will fail if used with current cp2112 driver.
> >
> > I see two options for those:
> >
> > 1) revert the simplifications and sacrifice a bit of performance
> >    to support the widest number of adapters
> > 2) use the quirk infrastructure from above to query the
> >    quirks of the adapter to chose between fast or compatible
>=20
> Could this be an extension of your quirks?
> I mean, moving in i2c-core the switch between fast or compatible?
> The caller should only state if combined transfer is strictly required
> by the device on I2C bus.

I'd first need some arguments that this is not micro-optimization :)

> I have check most of the I2C adapter drivers. At least for the 6
> drivers above, reading the code I don't see anything that implements
> the repeated start. But I do not have the HW to run a test.
> It's definitively possible I misread them.

I can't guarantee this in detail. The qup driver is quite new, so I am
quite sure I asked for that. However, I don't know for the USB drivers,
I have to trust the driver authors. puv3? Predates me, uh, let's not
talk about it... The main thing still stands: If they send stop after
each msg, this is a bug.

> >> To fix 1) and considering 2), rewrite i2c_transfer() in case
> >> of num > 1 as a loop of non-combined i2c transactions.
> >
> > For the above reasons, NAK.
>=20
> Ok, agree to drop this patch.

Thanks.

> > And why is this driver in hid? This is clearly an I2C master driver?
>=20
> Actually it should be a MFD, since it implements I2C/SMB master and GPIO.
> It uses HID over USB, that is probably the reason it is here.

Yup, from what I glimpsed, it should really be an MFD driver.


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBZbvAAoJEBQN5MwUoCm2PAIQAJ1qvcAoEAz6QCZeafCvazWQ
iftF058Gw67621a2gXxBkYS8zfZMYETqnQqhZK84RSst2lhOPeQW0mRF0eDRskAH
Q46rq1mjOEGAfStfjxLxuJGJaYWcrVt2xJR86zSZyczRyL8Dty3qC0r1+4YqlwSm
q81b9AoJUhuv7700CNHZUI16XbQtp1VZcHT3PMoZft+49MNCt++iFpamJdeALSob
7B3KiOxUThTc6NZb6wx523lph4Ysuk4lfDnH6L2A/EweXnPSrMHsxQ6ZPfYZZCuo
duEYjHHoBn2sTklhVBzLLa7RhG5qKZN48+6oQq+NjFTaTOjmuer921FByj77Uokv
9AVDcxTWIakHapyCnZJqTPTjRGqcSZXexDJVRBpO7rzxdVfPh4ocFs82pxd5gQTj
fIbh/ZYqhne0IzZaA4+qMMTFkLFF4uT6aFRKYAz5aEVT1M6V0UGRmj9EwJbfxqH+
v+FKzjTU9ndVwnJpnWGD8WvVeg7XggGl488Wrb0O230B7coNwX0RY87H4rAUZgL/
t6FwjGvyqt+2yzsV85greXOOwJ6MObuke/qptS1V0iXnVtE1EMv1+JfEvk3x0Lho
P8dWNQVZgq7Nk8voH7xiKCQhjhMQVXeZ9vDHw84XMrTx2CAY1mW5ZPT3xGWqB9WQ
DWjjHdcMoblXOsKPsxtj
=K67r
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
