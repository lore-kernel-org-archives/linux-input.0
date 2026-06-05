Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6BB25228D
	for <linux-input@vger.kernel.org>; Fri,  5 Jun 2026 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780678483; cv=none; b=Bz8/7J8vyqDvGF9zJhRhclDhk07eum+kKvf07HH4FtSRJARSzvRaUGuycBMzCnTswvx67EoFtGRMMKG7Bu5haCRFtQiwf0LGxiNrRFqu/HuuIgTAZurWZ1JKtI6/dobnAsaz7bK1X2OiRX8VdO2F7M5kpnqpnonQtH6h7hcSG00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780678483; c=relaxed/simple;
	bh=r0hnWxL59nbWOWvL+gITZfucgE63BujELilv2tAhq8Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hKGCbiDKBXL3d1f7PCZTe97cJdobcix+EVMKPFDb0DmKjh73u8J1BucaJirqAkKVf0GkFSr6+12y1inukQ5+H3ms+KbmcLtE+pin/L1GVZ6ZjiBDcLkXRu4HygVKDQwHJpVrDZsKyhQhx+hbKTLd6L884Q2u3kfAb10o5wkrzcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyL8iYbB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyL8iYbB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E8B1F00893;
	Fri,  5 Jun 2026 16:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780678481;
	bh=4QiQXfPZZCJW4DoDhne685v2su5EN+HmpWhJVPD48U0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nyL8iYbBeQ2QTMPiOkTTaqtq4C23eGlLAikTFQjTb2F2aDFojQ/FrMlUnuiiqKZcO
	 fWdmr0WEmeb9hlKLhqSsA3viia/N4Y+wPtkHaYbCalZOcy0bovTxvD7SDi6gzzO0yO
	 5A27/tyat1Mpo24qdPQoDd04jFTfsL78V36ADTZ/U9b8/ZQkLa9azdj3BL9mvXjyCt
	 dmenlZGaX2JMUIVPuECK4Eh9SK9/ZV1IIWKfQwSfN5QHlDFLOOEhma0dnpfZ6x4HTQ
	 m+UBSe3jnI45+UJmwcC3tkVjMkfZoIT7DLD5qhf1HxcXbE4XfSz9L3qIoll5S2NKKx
	 HTKRP22wNHKfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9] HID: steelseries: Add MSI Raider A18 HX A9WJG RGB
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Glushkov" <david.glushkov@sntiq.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260605164133.14354-1-david.glushkov@sntiq.com>
References: <20260605164133.14354-1-david.glushkov@sntiq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 16:54:41 +0000
Message-Id: <20260605165441.B2E8B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential out-of-bounds read in `steelseries_is_vendor_usage_page`=
 when a malicious device provides a tiny report descriptor.
--

commit 45b36559149afdf0789fb9e7119bb71f74c98387
Author: David Glushkov <david.glushkov@sntiq.com>

HID: steelseries: Add MSI Raider A18 HX A9WJG RGB support

This commit adds DMI-gated support for the MSI Raider A18 HX A9WJG internal
SteelSeries USB HID devices for RGB lighting. It exposes them as multicolor
LED class devices and maps the ALC zones.

Closes: https://lore.kernel.org/oe-kbuild-all/202606010709.X0QYNjFZ-lkp@int=
el.com/

> diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
> index f98435631aa18..2eaa167455bba 100644
> --- a/drivers/hid/hid-steelseries.c
> +++ b/drivers/hid/hid-steelseries.c
[ ... ]
> @@ -528,6 +552,222 @@ static bool steelseries_is_vendor_usage_page(struct=
 hid_device *hdev, uint8_t us
>  		hdev->rdesc[2] =3D=3D 0xff;
>  }

[Severity: High]
This is a pre-existing issue, but can this read out of bounds if a malicious
device provides a tiny report descriptor?

The function steelseries_is_vendor_usage_page() unconditionally reads the
first 3 bytes of the report descriptor (hdev->rdesc[0..2]) when handling an
Arctis 9 device. The kernel's HID parsing logic allows report descriptors of
size 1 or 2.

If a malicious USB device supplies a 1- or 2-byte descriptor, the dynamical=
ly
allocated hdev->rdesc will be exactly that size. Reading hdev->rdesc[2]
accesses memory past the allocation, which could result in a
slab-out-of-bounds read and panic the kernel.

Could we add a check to verify hdev->rsize >=3D 3 before accessing the arra=
y?

> +
> +static const struct dmi_system_id steelseries_msi_rgb_dmi_table[] =3D {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605164133.1435=
4-1-david.glushkov@sntiq.com?part=3D1
