Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E6D36167D;
	Wed, 28 Jan 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769612825; cv=none; b=JXmlrQaTpVAn09lvpxgBH6EBPDkNt0+LMPhb98nycYe07tuqp382bFGtTayHJcW0W9SIh65c8U5AzSiuAhHBLjB+xVUJpwKXD0GLzJl2grRWBrjRAlUlQtJqMP88mi8GljI24iQCPZpjbAY2VNJLYUqAsEWz9FC6aqQrHxYfNq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769612825; c=relaxed/simple;
	bh=4+Bd/BA2bIwfk/ICQhR8hSgPiwgzJSwgE8pAKiT4amU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVspy5CySd/3DrCmA5bF8iSQkKDsS7N3BlPiYPYHG3o4BCsCcXD1peEARA1O/ZI6iZ9f+lrmctxcGZ+Ee3Y7lx5+x6OlGEZELYd+WUwGUoYcr6LzYo6jkqyimPT0rkHQ/5tmVYmtGa8Cu8pWn3SE+jVdivtHDUcPbemWLe8KgKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C84sDqh9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C84sDqh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27D0C4CEF1;
	Wed, 28 Jan 2026 15:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769612824;
	bh=4+Bd/BA2bIwfk/ICQhR8hSgPiwgzJSwgE8pAKiT4amU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C84sDqh9jKrZjCQRScQ/rs8J/VwnvAHVaR+sd8+IjH/NLIAyI3ECn2kzsjs8mlmre
	 E7TES1IOLRBmgbS7U+FM6AUrQecvX7b/jWAcW7WIRHQ8V6MeccbLjLyjFaNdp7MXwk
	 8TIb+Kc08kuwb69MioP6QV93fSnzaUKVR3lAcfaG8dRRp2ZCITfBlVpCvLwP2WebCP
	 Asf7G7vlSwowpfUlUOmAEiVSe1s26ZuGAFz1HUQC43qOz0gHMMKxB4e/j7KBpUOW4z
	 OAtIU96UxjJZkOF7Oh/FcuJi17US4nhN6rMI0HHiZjf5dpy9MSJunOwCnYyvS0TKT7
	 DTc/DXEigTDJA==
Date: Wed, 28 Jan 2026 15:06:58 +0000
From: Conor Dooley <conor@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Danny Kaehn <danny.kaehn@plexus.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Ethan Twardy <ethan.twardy@plexus.com>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, Leo Huang <leohu@nvidia.com>,
	Arun D Patil <arundp@nvidia.com>, Willie Thai <wthai@nvidia.com>,
	Ting-Kai Chen <tingkaic@nvidia.com>
Subject: Re: [PATCH v13 1/3] dt-bindings: i2c: Add CP2112 HID USB to SMBus
 Bridge
Message-ID: <20260128-pelican-silenced-cd6a5bf69672@spud>
References: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
 <20260127-cp2112-dt-v13-1-6448ddd4bf22@plexus.com>
 <20260127160217.GA3776731@LNDCL34533.neenah.na.plexus.com>
 <20260128-magnificent-faithful-otter-c4f900@quoll>
 <aXoF4zi4SZrXaku5@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bpOAQqhnQbizHtBL"
Content-Disposition: inline
In-Reply-To: <aXoF4zi4SZrXaku5@smile.fi.intel.com>


--bpOAQqhnQbizHtBL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 02:49:39PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 28, 2026 at 11:35:25AM +0100, Krzysztof Kozlowski wrote:
> > On Tue, Jan 27, 2026 at 10:02:17AM -0600, Danny Kaehn wrote:
> > > On Tue, Jan 27, 2026 at 08:47:48AM -0600, Danny Kaehn wrote:
> > > > This is a USB HID device which includes an I2C controller and 8 GPI=
O pins.
> > > >=20
> > > > The binding allows describing the chip's gpio and i2c controller in=
 DT,
> > > > with the i2c controller being bound to a subnode named "i2c". This =
is
> > > > intended to be used in configurations where the CP2112 is permanent=
ly
> > > > connected in hardware.
> > > >=20
> > > > Signed-off-by: Danny Kaehn <danny.kaehn@plexus.com>
> > > > ---
> > >=20
> > > Hi Folks (Intended for Rob or Krzysztof),
> > >=20
> > > Wasn't sure the best way to go about this, but trying to see the best
> > > way to get a message in front of you regarding an ask from Andy S.
> > >=20
> > > In [1], Rob H initially directed that the gpio chip share a node with
> > > the CP2112 itself, rather than having a subnode named 'gpio'.
> > >=20
> > > Initially, I did the same thing for both DT and ACPI, but Andy S.
> > > directed that ACPI should not have the node be shared in that way.
> > >=20
> > > With the last revision of this patch, Andy S. asked that I try to get=
 a
> > > rationalle from Rob (or other DT expert presumably) on why the gpio n=
ode
> > > should be combined with the parent, rather than being a named subnode
> > > [2].
> >=20
> > Because it is explicitly asked in writing bindings. Please read it.
> >=20
> > Because we do not want Linux driver model affecting design of bindings
> > and DTS, by subnodes present only to instantiate Linux drivers. I do not
> > care about driver model in this review and I do not see any reason it
> > should make DTS less obvious or readable.
> >=20
> > That's actually rule communicated many times, also documented in writing
> > bindings and in recent talks.
>=20
> Does DT represents HW in this case? Shouldn't I=B2C controller be the sam=
e node?
> Why not? This is inconsistent for the device that is multi-functional. An=
d from
> my understanding the firmware description (DT, ACPI, you-name-it) must fo=
llow
> the HW. I don't see how it's done in this case.

The i2c controller should probably be in the same node too, unless it
would cause conflicts between function (e.g. inability to figure out if
a child is a hog or a i2c device). I would like a rationale provided for
why the i2c controller is in a subnode.

--bpOAQqhnQbizHtBL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaXomEgAKCRB4tDGHoIJi
0gyjAQDUBw26qDbXJlE2uJALcz1YCTh6ZCxLcS2VBrbZDMkg1gD9Fc8xi3MLZIar
82GXJjQcBxOsWrBYPqkblpECUrG5ngw=
=Vctq
-----END PGP SIGNATURE-----

--bpOAQqhnQbizHtBL--
