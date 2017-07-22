From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCHv4 3/4] dt-bindings: mfd: da9052: support TSI as ADC
Date: Sat, 22 Jul 2017 21:08:29 +0200
Message-ID: <20170722190828.agqsto5sbfmtwprz@earth>
References: <20170630143506.10541-1-sebastian.reichel@collabora.co.uk>
 <20170630143506.10541-4-sebastian.reichel@collabora.co.uk>
 <20170717104945.6qn6to7s3mlepxgj@dell>
 <20170717112711.eskydrt4pu32v74g@earth>
 <b0d58a26-d0b4-a6ec-811a-159bbb8b44d1@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u73op4dt6wvruqqd"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b0d58a26-d0b4-a6ec-811a-159bbb8b44d1-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--u73op4dt6wvruqqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 22, 2017 at 08:09:08AM -0700, Guenter Roeck wrote:
> Yes, but you dropped all the Acks in v6. That is supposed to mean that th=
ere
> was a substantial change to the patch, and that it needs to be re-reviewe=
d.
> For the hwmon patches, I ran a diff against v5 and noticed that there was=
 no
> change between v5 and v6, yet you dropped my Acks. Do you really expect us
> to do all that work on your behalf ?
>=20
> Sorry if I sound a bit annoyed. That is because I _am_ a bit annoyed.
> Please keep in mind that you are taking our time.

FWIW, I did not drop them, but forgot to add the ones I received in
PATCHv5. Mainly since I initially did not plan to resend the whole
patchset, but then decided otherwise.

Sorry anyways.

-- Sebastian

--u73op4dt6wvruqqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllzoqwACgkQ2O7X88g7
+ppWxw//WMWPq4/3a6QHa1omjPHwvUTNlLZQYDg2n7rhD9fObHMLJLenmFSRr2c7
c9jDCTe1knXjlvbvjnkaAIgRYLzCdYcweGnlIDaO872AncLSHyw3AiRG6SoqRzzU
Prnbe0FsGovJQiQAikuvIJMJjgCHWm5KwfrNrS43q5wi1lhasgYVfqk1Xh7ot046
3heU+StY2LlPCBJfeQKU/bUy6jxzDdcl6aj81Nq00UG7Hh4rDrbcIXfVAEFp/ceZ
XKh3vItvm9kCSmysAFsrsmCkgvPqd+D+LRzMFI3XhFwVGjdzQIptOlaMgZvqXIXt
sK3aAIwkalqHa12tT4WQY74d9K4kd8vdW65OTvNpgln5p7QX7mIh0+70Hlwf51rn
DLyf5Q91ckO5SHjAN8Nvv8mHZZZNi4CIs4veKojwWropsnQQsOcwKXveSZyh+7K4
eYoRzL2oZZc6ve9t1Plf6ydyMXcN1rlG8t04XjeYpqfbHL+hVkuZIpil9RjbSAWR
aHNkxW6VFVIZLTK6MPYjL6fL+kFSSgihypmmiN3Aht6NoE2wR740135u+NDJRj7b
Xwp3q9P/SkYs04kZGKISnY5bT0aTUWwyEWecqf5WFPtR8u9CinMPZo6AuglxvICz
pzKuJf3oPuxYCG87pS0B1Q3yKVGXSdq3OdjLViGhoyLyUQGCCEY=
=mAPT
-----END PGP SIGNATURE-----

--u73op4dt6wvruqqd--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
