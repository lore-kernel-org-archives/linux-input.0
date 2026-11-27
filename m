Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783575;
	b=CirEnS1lWVjjvqE4fVVpVdcoaCkcR2EMTmqcQHoIYRaJ8Pq0S3fOEHLv89WUDj6BYfmX
	 9mtsyEehvZSY32RZqM5FpJyKJIOb8WieDFpXGvoelJnr0h6ko8K+rHSB8Sh0A07Ae/MTx
	 xjwmFGMPciEqzVQtOpRhs5964RGf49FHk3mb/U3inL9mnxGDq7iOwJMHtQi4IOHj9JOpx
	 SY2finaKwSYdc6+6kyBxe4fdJDWHZ4Gd9eRzD1WI/7LDCQB7WL1BcCvFHXDYL90OVevy4
	 hrHytMVozyo4MCGzLcKuIEIIh01Q4t+ErWA5+mSoQQTDGBR28I7NuAT7jgcw4MboJaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783575;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:User-Agent:MIME-Version;
	bh=Tccfpf3qqlZdBx+ZX8QyDCcTglwgYFd/jXCzKtywApg=;
	b=RZF+Id0xscmtzQNP8i8znEwUwpUk1g8mIA3sGPFK8xEjlncc921X66z5LDuzWNqpXjNY
	 uNbt7yS5v0z6thc5qNXuLMdcPl6Y4yEzTOme1UAi/+ERejkpuPEWTbr+zwCAF+8YlkT/9
	 OLk68jtNBNn5U2T7v3332C2ZV6tMqGOIMzDBC0Vfmk8XuC2LlTAb5APk/zUcrCiEX+jYx
	 /gV+MfNQIGLt5CLRfMxxWcsDZ9vx1pbh075HQGT4n7yXfactN+JRAGYKoKi9Yrw74dGxk
	 4QmwUy5RTGtqbrnFckH+qIy0AUZJ3s/Shk2E34VaQ3RL+Yo74e0AExtN5OxoIiTzPBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codeweavers.com;
	spf=pass smtp.mailfrom=codeweavers.com;
	dkim=pass header.d=codeweavers.com header.i=@codeweavers.com header.a=rsa-sha256 header.s=fm2 header.b=QcuCvbyo;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=C5U3XJkm;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD00606A31F
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 12:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CD00606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeweavers.com header.i=@codeweavers.com header.a=rsa-sha256 header.s=fm2 header.b=QcuCvbyo;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=C5U3XJkm
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C2E37A02EE
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 07:46:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 27 Nov 2026 07:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codeweavers.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1795783573; x=
	1795869973; bh=Tccfpf3qqlZdBx+ZX8QyDCcTglwgYFd/jXCzKtywApg=; b=Q
	cuCvbyovY1DAPjrMlB1dzE2nU++4VyaU55ySTjp4eha1050FG6NSDBf5YCVIOkxS
	lufwYyaRFJ3tj6lJ+TN5DzGx2+4HvSarNzlJ4fKG2qFzHpzVy40Sn4GSjHK5Bt7e
	lWlM4Swz48A/Sxgrc1WnWKVL+eg+s+g41d+t2p2qDWGoBdRxYMFVvOmRX4OMJuk0
	RhmAwIU3DvW1pHOt51igliNHAyiK7Mvn3rRp5mccypOtisHCfF7l5R/AXVqKXr1S
	bJIeRfWxp40d3JycnlJ+fuRiXINgrqwEk3XoiTJMC7lJH4wkIMdSsBuQnAvWrTsW
	ujhY3umCArQoPBSbZgsGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795783573; x=1795869973; bh=Tccfpf3qqlZdBx+ZX8QyDCcTglwgYFd/jXC
	zKtywApg=; b=C5U3XJkm80R1TYJvXqOVIiOeGNOYdbEXZee7iyDbGvtgTnsnkiB
	MYPCSKL131t1XyZIjZNrCarBasJ9KUlFtW2on3dRm/D6GeyBL6tRlFau4DRdl/U1
	DMhpkVtm8Ho4hHSjhYX4vriLoaokQXLNq3i5LI6Q2DjhRMGKpEbWVeGEhf1U1IhY
	bKTCCJzT0ivr5xWS5ZkBAP5YvbAKPVhxmhjmPjN3oMI4B02jV/+3mhJ/3QsEpOwE
	KHGg6icQPDaFugz95n3E8bKTqLWu3O7w5k8XLCWVwVifhR2X6gsjv2RVJ8aQzgJE
	frMWlSA6odfneVeqw08Ng527gICXRCuhJqg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=codeweavers.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795783573; d=codeweavers.com;
	mf=PG1icnVuaUBjb2Rld2VhdmVycy5jb20+;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:c/kSyFP3we0h5p/yc/eAJmRfAYQPfg5WEC+jwVmRc1CKC4J
	O8NLnyYodQcbkwTVcGg2QxQPFdTXgA5YwbmkHrCSrAaNZMgY/zTwRCqwV4QassFK
	yoMZATNeUf7/I0F6tandTubLAQ35ehDQh2irAgtpfbimjmJC5Z8mMUScCjseA+cK
	Ri5dVQOiaN7CzHwgQKWcku3iwjxqbIawtbpGYMywz87U3nmrv6MaPrn9Z7kgFWqv
	lFlVtv3VLR4t1JgbSg2Ack5j/oy8vteF/sI0K04Q2E5BXAh2QbgexRZQTIAZodPM
	4zAxY69mY0vIhqoHpyusGuvSTA+miKoNfqNU5xA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:qpRz6hqu6KkowndsF+/qdcLkT0TVVnXwtix8Qn8PA8E=:spdkKAzFwzOK/TvwkNGG5SqH/r1Xruft7e3Y8C6WDbs=;
X-ME-Sender: <xms:lXsJa0W1O40TSgAcigpy2qQYTPn_p1NJcvGCPZzQLebkrcAY90vmVQ>
    <xme:lXsJawAktmqUzP6UPqvBdOSXjl760kL-3wMCSdUEAzp2j4N6HfmkXi-1U2s2bHgmW
    zlrTZAoVfOIewTVeJ7W2pk6L3F3uVUv3PDjv7b7HsTU2bGR07ZqrEgw>
X-ME-Received: <xmr:lXsJa1xcY3icjK7yEOO9TszLQ5N2wdfNEfHNUz47it5lGLiGAfE4y7wuBzVBqYQdY32W>
X-ME-Proxy-Cause: dmFkZTGE9lPQuD0qbXPd39Y5sMe7XIB+b0Vf63jmYvDtiqBzCqqi4Q+C/msONGnPRIYE5W
    c5XIHV/UCHOWWSvFTJTPeV9tTSq00ljpBgn1+Uia1+HlMH2zvW9zJ7xZG3JcNkSkrT0bO4
    wWAQT1CRNcnb3d2tFc/Gaxh42Hxp9pMkwr4NG4x+f+Ollghe01GjUUXpBa4KVfkTDbWgc/
    6XoyU+0T/P5QkjgDInlZeNdA+gOVk7O4YrAPaYKpsU8bS8g5pGkRrJmjCeVKoQhChA/Foe
    gzSoXR+hOHJrnqTtsXHa/4M/si+Ja9o/0y3QbBYrf0JIbRxViSAkTi7qQLSqj8NCEOeCly
    v1LVvadvpy6AlyYFOX3yUhYpAFCxMAEQXdyuzLSRgW4WwRkZU5pydw5mqTLH2xgtOR8L8E
    xrz5EF/b6lfAFlFPIlStr5LNrJNYAGUmank4v0TFqZ7QVDOrkgdXHf4O3pQvMfKhnHr9Ru
    mHlw+C/LV//pEMfhZzK+HPwm5IgwTt4ZxYMz3okSZKyvTsl5Tg0R0PcrAGdbsIqtjBYxrO
    7Dda5xt3IQc/TCML45DHCzF3QIPh2z1aAXbztzQJea5qbFN80hdfHfWAZYn1hilxIjWRDh
    /4g98waSHRc26OjJWd0v3+IXi9i8gyrizgl02TP6AnZnZ5hiRDnj6ixG23vA
X-ME-Proxy: <xmx:lXsJa9B-41xue-0RIepMDzl364XovRrY_SHsQLYPz6I8Kxs7iPUsbA>
    <xmx:lXsJayZa7aKWO9p5DNbr0XoPosnzevekqv_wbV56Q0RKul00DKqGCg>
    <xmx:lXsJa1gHp7cDbFwyR8_jvP7fVZImunM3MASUHcqn8gR_jxMyR981jw>
    <xmx:lXsJa046qsVojwjEFVViddxLduVDVoMRYjxVPQ0iGZhrJzFe33LhpQ>
    <xmx:lXsJa1UIG8Qwppr-YNuxxDyuroWREeMKj-wnOOhyr0V3FM4cePcbwfHf>
Feedback-ID: i09464b71:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 07:46:12 -0500 (EST)
Message-ID: <388d3d6e5a4f988f4a4be2c436cdd2ee652336f8.camel@codeweavers.com>
Subject: Re: [PATCH 1/2] HID: core: include product version in the uevent
From: Matteo Bruni <mbruni@codeweavers.com>
To: sashiko-bot@kernel.org
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Date: Fri, 27 Nov 2026 13:46:03 +0100
In-Reply-To: <sashiko-outbox-235847@kernel.org>
References: <20261126153925.9488-1-mbruni@codeweavers.com>
	 <sashiko-outbox-235847@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-m1E9NV9TU3eL0vfsPiFi"
User-Agent: Evolution 3.60.2 
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


--=-m1E9NV9TU3eL0vfsPiFi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-11-26 at 15:50 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] HID: core: redundant unprefixed PRODUCT uevent in
>   hid_uevent()
> --
>=20
> commit f1a7bbe068e7bfcbcd219202f30241d7b9e0e8bc
> Author: Matteo Bruni <mbruni@codeweavers.com>
>=20
> HID: core: include product version in the uevent
>=20
> This commit adds a PRODUCT variable containing the bus, vendor, product,
> and version fields to the HID device uevent environment.
>=20
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index 64ac7606927ca..6b71104aa3319 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -3003,6 +3003,10 @@ static int hid_uevent(const struct device *dev, =
struct kobj_uevent_env *env)
> >  			return -ENOMEM;
> >  	}
> > =20
> > +	if (add_uevent_var(env, "PRODUCT=3D%x/%x/%x/%x",
> > +			   hdev->bus, hdev->vendor, hdev->product, hdev->version))
> > +		return -ENOMEM;
>=20
> [Severity: Medium]
> Does adding an unprefixed four-field PRODUCT variable to hid_uevent()
> conflict with the parent USB device's PRODUCT uevent while duplicating
> existing HID sysfs and uevent attributes?
>=20
> For USB HID devices, usb_uevent() on the parent USB node emits a
> three-field PRODUCT=3D%x/%x/%x (idVendor/idProduct/bcdDevice), whereas
> usbhid_parse() sets hid->version to hdesc->bcdHID (the HID specification
> version) before the HID device uevent is emitted.  Consumers or udev rule=
s
> walking up parent devices from hidraw looking for USB's three-field
> PRODUCT variable will hit this four-field bus/vendor/product/bcdHID value
> on the child HID device first and misparse the fields.

I suspect this might be a fair concern. FWIW, I picked the four-field
PRODUCT=3D line "schema" from input devices, which is what is used by
Wine for non-hidraw devices. Using the same format for hidraw
(including UHID) devices seemed pretty natural and makes the required
Wine change very small.

> In addition, other variables in hid_uevent() use the HID_ prefix (with
> HID_ID already exporting bus, vendor, and product), and commit
> cdf826a94e0f ("HID: core: Expose id attributes in sysfs") already exposes
> hdev->version for all HID and UHID devices via the id/version sysfs
> attribute.

That's a relatively recent addition to the kernel and one I wasn't
aware of. I have a WIP Wine patch to directly read
<sys_path>/id/version to get to the version info. It's quite a bit
unfortunate that this is effectively the only case in that component
where we can't use the udev API to retrieve the information we want.
I'm not entirely sure if it's going to be considered acceptable
upstream.

--=-m1E9NV9TU3eL0vfsPiFi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQFnBAABCABRFiEEOG64GdkEb/jz3VACyR3CIymyYlMFAmsJe4sbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyFxxtYnJ1bmlAY29kZXdlYXZlcnMuY29tAAoJEMkd
wiMpsmJTm/UH/2eM9hSFjRdQtd3ZsBiFfktzkbLrSGH1qAXGorQK+mqQuxW0w7Ei
eUTYxGoIZXo4+qGKvdK4cUsl24SpWJ8P6L/A148f+4uYm5aWzSmr0iJy4FAz910R
xQofK1GizeHRwY0l20vW46ndpGMhM4X2RQDhB1q6x2dbBmlMuJozpvflgSVoosFo
w1o50NlNOsKRbzLgL49KdHByaT717gfrdOt3a9FvbzosjIdASAXNlrZdFtWXYOLY
OTM4sMtvBsXh9ILQ7QjAN0iWOZ/czrZEB2OTrVu4IR7I8jBFPIjFT5tff67YftvE
HszU/3rCsIFfagAWj3m051A4z2XNSjVBEFk=
=eTHe
-----END PGP SIGNATURE-----

--=-m1E9NV9TU3eL0vfsPiFi--
