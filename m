From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v8 3/4] i2c: i801: add support of Host Notify
Date: Thu, 23 Jun 2016 23:46:55 +0200
Message-ID: <20160623214654.GA3707@katana>
References: <1465484030-28838-1-git-send-email-benjamin.tissoires@redhat.com>
 <1465484030-28838-4-git-send-email-benjamin.tissoires@redhat.com>
 <20160615081247.GQ24234@mail.corp.redhat.com>
 <20160616060942.GA1403@tetsubishi>
 <20160623205552.GO32561@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160623205552.GO32561@dtor-ws>
Sender: linux-doc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 23, 2016 at 01:55:52PM -0700, Dmitry Torokhov wrote:
> On Thu, Jun 16, 2016 at 08:09:42AM +0200, Wolfram Sang wrote:
> > > > - removed the .resume hook as upstream changed suspend/resume hooks=
 and there
> > > >   is no need in the end to re-enable host notify on resume (tested =
on Lenovo
> > > >   t440 and t450).
> > >=20
> > > Actually, this hook seemed to be required on the Lenovo T440 (Haswell)
> > > but not on the T450 (Broadwell) laptop I have now here.
> > >=20
> > > Wolfram, I can resend the whole series or a follow-up patch to re-ena=
ble
> > > after resume Host Notify. How do you prefer I deal with that?
> >=20
> > That depends a little how we want to handle patch 4. I am going to apply
> > patches 1+2 today to my tree. Then you can just resend patch 3 which I
> > hope will get some review soon, but I will pick it up for 4.8 later
> > nonetheless. If it is not causing too much dependency hassle, I'd prefer
> > that patch 4 goes via Dmitry's input tree.
>=20
> Any chance I could get a stable branch with these 2 patches based on 4.6
> so that I can pull it and merge the #4? This way we do not need to wait
> for 2 releases to merge everything...

Sure.

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/host-notify

Thanks,

   Wolfram


--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXbFjOAAoJEBQN5MwUoCm2mPUP/RYr+Q37qzjjGCsbQG2OGZ8E
qZ7K97tSNr42r/UdGPD97IZLmjaoI0eGsb5E8BpJQjhIZ9uhg0r4+mT0VLaTRvpE
OjDYNueUe3DCoH3s0oZxtrXBE9N7cAhbx0PDqKMJnF73v7/8Rjf6aiHiXn++WFxH
fyNJdgoDdkbfAtymcTQTUoJwK5WnVuJmEPgwA0ppRuCQpnFwPVoJrdKxfolCQE9j
GcPgimzr9cXxP+pU0KjSeExi+SnzMJBHWlBKR8vPSi76hXF1cabIn3eFdQJ0o/gH
dwzmNYRPLbQU9LJmU02gEwKCv0wp3ewvGIlA0pwRiUkraIt2c3+7HlCnmJww/uN0
x7K6YKzldiwZT6K1RFlgMYaN33pcYYT6hzM1qN/53ZWtJ5BH4tohwPHSNhiro4nr
37+lS5xtwwrHQ7bryE03Ad9bMzpEph/wNwDdvrneGst4xT2x4BDZ/tD3edIQDjYQ
ntdNtTLA1SCCm98lGumOe7oxStEgceUSJFhsJFmU6Qtwhv8PFWReDE8cJB00Yc94
VKzD2co9ji0XsgfiOEvrPoP5QtHqyIo+3dXbGaAGRYCnbtQU5ZHABNZDOet6N3oc
qYX2KsnO1fUI6KJy7C5nVj5RkuXxrewdk+q00+MJGI3IP7XIV0FBqFteHUmlKHlN
KpVrF7QO6+RMB5lA3CnO
=J9te
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
