Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663164;
	b=kk1zHlxKG/7Z9l9mULOIGBeB5DlaE5r0psOH2sWoVSB4puGlT2qw5BzMQ9T/fdlPL2Ga
	 9Mfx/xCeUEi82ZypqD45cx0u0ZeALzyPWTMcjUzkR2Ed/U7YK2wcmbxR/CA0yX7zgOWSP
	 BcYz1L+P+MWUX6lB4FcupaI9ldPvDzVQs4RXfrljhFOMI+mh+c7ViHZSWDCITQRjNtraF
	 unJiGcb7YD3HXLrGvc1ZYX1OolLqpPLOGdrrf/CuKmKD8z/hMnm7LhqvJGMAftwEojHt6
	 8Ec4wsL6HZBt3C82fJ2MbX8UwM45axAgfaljFIPlLwphipeCkixf3zSCpHmCLn3PVWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663164;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/LoPiQCUGfG3yrwonqTVIhmD3CZlxk4fMzhSbc/fjQ0=;
	b=0Q7+cwp65rTrD83xPo3AvCYzhkt54KJHDQPxtAGvZ3tKMJg3YUHQwIjudLVuvNYmQgN+
	 ZSrWZcr0bQP//m01q/Ls+erS2JsnUSFux/CeTNzlme0+LOXAdTL1bMOQiAdcP/TKzzufF
	 Ae8Y4j73zKnFhNHhgiU4gL/rrW6MqaE5InkuTT5kf4srMrQ+3llZSUj0f4PmPl4agaXW0
	 bHsV68OkSwCHR9CWuF/MJLnOuO7loQZXVT8Elm5MdBDrOYmdWZEvQrmRw1Nm95SKNXaeV
	 uT3V8gVzf0uJqwNl1b1OCe4GDqpt0A/ECdmPV6n+UrqUN6/9fU7jrJSeR+eLHitDNsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KzieFDRu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73184606A319;
	Thu, 22 Oct 2026 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KzieFDRu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C941F000C1;
	Thu, 22 Oct 2026 09:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792663164;
	bh=/LoPiQCUGfG3yrwonqTVIhmD3CZlxk4fMzhSbc/fjQ0=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=KzieFDRu1brJbuoVFhIks1Rmoyr3OuEMQEyWC0Os40zYD3NaxiAgUQ5yUK0qGdAp5
	 obgkOSrq3EwZDAVjdtt2UAQOpEtSD6InrrjMO1QtbxXzMWcnngTtBM8hlVP80DBlYr
	 2Tv1d9uD7DF6zX0toafEQNIIZ/154zlr9Bcn7vPpsTA3Ytji194F0WcO1kmLWoBlet
	 qdItToxxAesR10jLYT6ebCFSKsAeLnhUkMgxX4XgWEfYH6sEDhY2iaWpWpqgn5xFuO
	 ZSmFFZvo7N5X9LF5HCpEl5EZpbRcwrFtoUkczd4AeOXZ7MqnDOufE6LBUkZlRMpDDU
	 WhtcNx6rk+/iA==
Date: Thu, 22 Oct 2026 11:59:16 +0200
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] USB: add usb_make_subpath() for formatted device
 subpaths
Message-ID: <atneGH0t_T-75WmE@debian>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261021123146.17202-2-shlomojune6@gmail.com>
 <ati7RlrVvmzMjzNr@debian>
 <tlemhufl7x3zatbf7ygcfnshinyz4bunroyhegmyxutgooqbcc@wtpqkldesosb>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rh5ndjbw7hffc73s"
Content-Disposition: inline
In-Reply-To: <tlemhufl7x3zatbf7ygcfnshinyz4bunroyhegmyxutgooqbcc@wtpqkldesosb>


--rh5ndjbw7hffc73s
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] USB: add usb_make_subpath() for formatted device
 subpaths
Message-ID: <atneGH0t_T-75WmE@debian>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261021123146.17202-2-shlomojune6@gmail.com>
 <ati7RlrVvmzMjzNr@debian>
 <tlemhufl7x3zatbf7ygcfnshinyz4bunroyhegmyxutgooqbcc@wtpqkldesosb>
MIME-Version: 1.0
In-Reply-To: <tlemhufl7x3zatbf7ygcfnshinyz4bunroyhegmyxutgooqbcc@wtpqkldesosb>

Hi Shihuang,

> Date: 2026-10-22 15:08:58+0800
> From: Shihuang Liu <shlomojune6@gmail.com>
>
> On Wed, Oct 21, 2026 at 03:17:56PM +0200, Alejandro Colomar wrote:
> > Hi Shihuang,
> >=20
> > > Date: 2026-10-21 20:31:41+0800
> > > From: Shihuang Liu <shlomojune6@gmail.com>
> > >
> > > USB drivers often build device paths by calling usb_make_path() :and
> > > then appending a subpath. Several callers use the deprecated strlcat()
> > > API for this.
> > >=20
> > > In preparation for removing the deprecated strlcat() API[1], add
> > > usb_make_subpath() to format the USB device path.
> > >=20
> > > Link: https://github.com/KSPP/linux/issues/370 [1]
> > > Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> > > ---
> > >  include/linux/usb.h | 29 +++++++++++++++++++++++++++++
> > >  1 file changed, 29 insertions(+)
> > >=20
> > > diff --git a/include/linux/usb.h b/include/linux/usb.h
> > > index 1da4ad1610bca..c90ccea0cdbf6 100644
> > > --- a/include/linux/usb.h
> > > +++ b/include/linux/usb.h
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/errno.h>        /* for -ENODEV */
> > >  #include <linux/delay.h>	/* for mdelay() */
> > >  #include <linux/interrupt.h>	/* for in_interrupt() */
> > > +#include <linux/stdarg.h>	/* for va_list */
> > >  #include <linux/list.h>		/* for struct list_head */
> > >  #include <linux/kref.h>		/* for struct kref */
> > >  #include <linux/device.h>	/* for struct device */
> > > @@ -987,6 +988,34 @@ static inline int usb_make_path(struct usb_devic=
e *dev, char *buf, size_t size)
> > >  	return (actual >=3D (int)size) ? -1 : actual;
> > >  }
> > > =20
> > > +/**
> > > + * usb_make_subpath - returns a stable device path and formatted sub=
path
> > > + * @dev: the device whose path is being constructed
> > > + * @buf: where to put the string
> > > + * @size: how big is "buf"?
> > > + * @fmt: format string for the subpath, without the leading slash
> > > + * @...: arguments for @fmt
> > > + *
> > > + * Return: Length of the string (> 0) or negative if size was too sm=
all.
> > > + */
> > > +static inline __printf(4, 5)
> > > +int usb_make_subpath(struct usb_device *dev, char *buf, size_t size,
> > > +		     const char *fmt, ...)
> > > +{
> > > +	struct va_format vaf;
> > > +	va_list args;
> > > +	int actual;
> > > +
> > > +	va_start(args, fmt);
> > > +	vaf.fmt =3D fmt;
> > > +	vaf.va =3D &args;
> > > +	actual =3D snprintf(buf, size, "usb-%s-%s/%pV", dev->bus->bus_name,
> > > +			  dev->devpath, &vaf);
> > > +	va_end(args);
> > > +
> > > +	return (actual >=3D (int)size) ? -1 : actual;
> >=20
> > Why are you open-coding usb_make_path() here instead of calling it?
> >=20
> >=20
> > Have a lovely day!
> > Alex
> >=20
> Hi, Alex
>=20
> With open-coding, a single snprintf() is enough, so we don't need to
> call usb_make_path() and then another function to append the suffix.

The number of function calls should be negligible compared to all the
work done by this function.  The readability and robustness is way more
important.


Have a lovely day!
Alex

>=20
> Thanks,
> Shihuang
> > > +}
> > > +
> > >  /*------------------------------------------------------------------=
-------*/
> > > =20
> > >  #define USB_DEVICE_ID_MATCH_DEVICE \
> > > --=20
> > > 2.43.0
> > >=20
> > >=20
> >=20
> > --=20
> > <https://www.alejandro-colomar.es>

--=20
<https://www.alejandro-colomar.es>

--rh5ndjbw7hffc73s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrZ3nQACgkQ64mZXMKQ
wqn0Fw//SGjH8HrquKq8O/0rj1F203YqVKSK5lxEgPM01cGShGSTDVpddlf/c6Vn
aJOVaMCAqgKIgY5Co6GyffjnZNUhgFrtgA0mOhUfpAhHAOvtkdfDBNosBjwt87+C
lNAWL8N8cMFmnfHnTjYTCjFIGht8T+TPeD0nObxkzwlAHItvC3QaOOvQvkZyrUv+
zcAz+O4TdWC1TJK2g6yzSnX5rGED3ubgLD6x7Fho4uth0b8yJjY9nLCEMpj6MYWB
YoJvFgrhealZ2sdfoux5XEbg/SvxOZXZKWg8BrN/tp4PiFDrvKCc9sxJsg2Q5TuS
2gM4aDdfX7DYKonIhD4jzYCu1mRnKcMGNETPep172HucDC51ASkuWdbgShjeZ2sk
avMKJKnaZxnWcGykOI6wFBBgfSyOZyp1LxHb/CPors+cVwEnZ23n3pfpTDVoh6Gn
CZFnljF51vv+WEbh27dTO4Wcfg4eMK9K2qlFm/eP6lAMgnl5Q02NXKqfXlVNOxPe
IV8RFbXyLtKQoADC0grMw2eZ89WS8bHrpsedoG0QFf0TkVx8tPng858KsgSdtOdd
lcp8qZHEne0MMasUbm80VCvEKmyQohr+f74fqbXm2uvPiJuzxOEDavs8T/u7cXBz
5AGAaH5C7ZDqtcsT+ZMeg7YJPM7ykhlr64+wtJlHxwHIt1Qoyyw=
=Z9XF
-----END PGP SIGNATURE-----

--rh5ndjbw7hffc73s--
