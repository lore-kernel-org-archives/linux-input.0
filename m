Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD941E511;
	Wed, 28 Jan 2026 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769621070; cv=none; b=NYfsbSnzAfUVL2qRFkMu0VVZxREb6QVhdyJX9TEqUZ/H+S/gLcO+X2KRjk8MXbffJlVuXMrZE91BNwYdvqXvOmEL2nKim4cIKDBY78ikVxenZj9L9VyOzemQaa5U7jfaOGYbKadLfBVDcRJ3HcYvq46441dK0ZK1bJvuKo38EM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769621070; c=relaxed/simple;
	bh=qsTK90imvUggzkgr0qY97dt5TxW+eT/iHwvC7ES+sBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDgvm3l1U7RQyH8yYLKZdahaX9+312KLvXRgoL9IAOBGp+8a4h9YkTAOb+XPoiJHi7fe+L3Gvjl2TgsJUucafUF4Xmqj0aJ7QSg/v6f3aypRv2KpUs6oWUC5TpPRGOhJiBIebKUy3mkj0GgfdVaeU0p8+OUuAeBhUf25kgmHr5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5w2YDZE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5w2YDZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB42C4CEF7;
	Wed, 28 Jan 2026 17:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769621070;
	bh=qsTK90imvUggzkgr0qY97dt5TxW+eT/iHwvC7ES+sBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5w2YDZEQLkjxTDGcF2tRpFscp9eOXLP4KHiGaUwoGkHTMNGgCt3HbkGY1Lbsy+Kh
	 JVD8tQ3nsJMlRZfo/RU3V0Bau+qJG6Ut8EduizXdK8GehwJQmPpI/Syy4z42AwMRsw
	 j5Bh8dBmSC9Ut0NKXls8jA8CfOJ6WuxLJnQzYywKzwmFZ+MKNqPsWfwQwruLVmPGXV
	 D1QIZD+94oOdA2cSUztjhk3Ng8AT1mr7tXXVvnQ21IEGMW6CGFWAd5qMqKROzn+8tE
	 IjI1VXZIMaM5vBVz7Hycjpdvycbx0paWcKzBpakrXc/RAPl0EPts9ZQLSXhH2aBfxz
	 IZqfxydUEVFtw==
Date: Wed, 28 Jan 2026 17:24:24 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <20260128-embezzle-deacon-74815f461fe9@spud>
References: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
 <20260127-cp2112-dt-v13-1-6448ddd4bf22@plexus.com>
 <20260127160217.GA3776731@LNDCL34533.neenah.na.plexus.com>
 <20260128-magnificent-faithful-otter-c4f900@quoll>
 <aXoF4zi4SZrXaku5@smile.fi.intel.com>
 <20260128-pelican-silenced-cd6a5bf69672@spud>
 <a579100b-6c38-4fd1-bab3-b1e7663ab412@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3t42j44j7XCiyLoM"
Content-Disposition: inline
In-Reply-To: <a579100b-6c38-4fd1-bab3-b1e7663ab412@kernel.org>


--3t42j44j7XCiyLoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 04:52:01PM +0100, Krzysztof Kozlowski wrote:
> On 28/01/2026 16:06, Conor Dooley wrote:
> > On Wed, Jan 28, 2026 at 02:49:39PM +0200, Andy Shevchenko wrote:
> >> On Wed, Jan 28, 2026 at 11:35:25AM +0100, Krzysztof Kozlowski wrote:
> >>> On Tue, Jan 27, 2026 at 10:02:17AM -0600, Danny Kaehn wrote:
> >>>> On Tue, Jan 27, 2026 at 08:47:48AM -0600, Danny Kaehn wrote:
> >>>>> This is a USB HID device which includes an I2C controller and 8 GPI=
O pins.
> >>>>>
> >>>>> The binding allows describing the chip's gpio and i2c controller in=
 DT,
> >>>>> with the i2c controller being bound to a subnode named "i2c". This =
is
> >>>>> intended to be used in configurations where the CP2112 is permanent=
ly
> >>>>> connected in hardware.
> >>>>>
> >>>>> Signed-off-by: Danny Kaehn <danny.kaehn@plexus.com>
> >>>>> ---
> >>>>
> >>>> Hi Folks (Intended for Rob or Krzysztof),
> >>>>
> >>>> Wasn't sure the best way to go about this, but trying to see the best
> >>>> way to get a message in front of you regarding an ask from Andy S.
> >>>>
> >>>> In [1], Rob H initially directed that the gpio chip share a node with
> >>>> the CP2112 itself, rather than having a subnode named 'gpio'.
> >>>>
> >>>> Initially, I did the same thing for both DT and ACPI, but Andy S.
> >>>> directed that ACPI should not have the node be shared in that way.
> >>>>
> >>>> With the last revision of this patch, Andy S. asked that I try to ge=
t a
> >>>> rationalle from Rob (or other DT expert presumably) on why the gpio =
node
> >>>> should be combined with the parent, rather than being a named subnode
> >>>> [2].
> >>>
> >>> Because it is explicitly asked in writing bindings. Please read it.
> >>>
> >>> Because we do not want Linux driver model affecting design of bindings
> >>> and DTS, by subnodes present only to instantiate Linux drivers. I do =
not
> >>> care about driver model in this review and I do not see any reason it
> >>> should make DTS less obvious or readable.
> >>>
> >>> That's actually rule communicated many times, also documented in writ=
ing
> >>> bindings and in recent talks.
> >>
> >> Does DT represents HW in this case? Shouldn't I=B2C controller be the =
same node?
> >> Why not? This is inconsistent for the device that is multi-functional.=
 And from
> >> my understanding the firmware description (DT, ACPI, you-name-it) must=
 follow
> >> the HW. I don't see how it's done in this case.
> >=20
> > The i2c controller should probably be in the same node too, unless it
> > would cause conflicts between function (e.g. inability to figure out if
>=20
> This one is the rationale.
>=20
> > a child is a hog or a i2c device). I would like a rationale provided for
> > why the i2c controller is in a subnode.

I guess it wasn't clear that I was trying to say that the rationale
should be provided by the submitter in their patch, and the first
portion of my comment was trying to mention what has to be considered.

> I2C controller will have children, because it is a bus, so moving it up
> one level would make the entire node I2C bus and that's not only problem
> for the kernel but actually for reading DT - we expect consistent choice
> for children, instead of mixing nodes with and without bus-addressing.
> What's more, if you have two buses you also need separate nodes to group
> them (obviously).



--3t42j44j7XCiyLoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaXpGSAAKCRB4tDGHoIJi
0soQAP94RgMAu6RjrAxCdXR4SFJqDk0BCec9Uzh3mtJH5I8sawD7BHDy8qaa2/HE
AyaKj5MWRRxV3km+nB3lCp0i5LZlogc=
=8zBE
-----END PGP SIGNATURE-----

--3t42j44j7XCiyLoM--
