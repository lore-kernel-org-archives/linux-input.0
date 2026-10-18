Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E372D7D3A
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792320812; cv=none; b=ZM7HX87uCV/531F6uHShE2yewGn+auQT56qouPQEUnUuGAgRHnXROc8Z41gJbrrxCTbHh6ObHa56gWmNslC3SjpPI8m79GrcjuZO8rFt6mMqpFKxVVklGTog6GJ4wiw/GoQ3160EYcar85W1LxrccONklUyoYwoyjR+yLQnhqrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792320812; c=relaxed/simple;
	bh=hvQnurBs+0T/m++zU4tfd6BqvfRRXDuFqv4CZ2gziQw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ks3eC0zYPKpThOkLQEUBu0gpuKjW5StKdcWmMu41W6ssWymweFzoaMR5AQTt3gJz2vkAqpuOXyM6BKN1M0l16UisDWQxFyvWn8Rhxa56Hx5LmqGHxiH8dxFImEpS824yU+P74bFa9CmxwsNPPxDp91sVD5hS5RBJbTY9p/aRNY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAzxi9WI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAzxi9WI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2321F000C4;
	Sun, 18 Oct 2026 10:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792320810;
	bh=4dH+fr2pF4B5GBrsiE0E+m2G6xxs0EUhPrqJUnEm8ck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eAzxi9WIy8mTi2feVHkIWkLyMU32T735Idf1y8Nmnf/dxISZtPryh2alSEV8/Se6E
	 wXNPh6IMrKhySCbDPGqYSlEfvMP+jyfCNVX4d886u+kgYV/FrrOUuDKJMGKpYuok4h
	 rc/3a1A4gKe2H8lADTE9KSy5gc7h+CPCq2arswvnP00/J6myyhYf0CVPc1by0By8nl
	 kCJldoJHISidCtk3H4OJuSjZjFZE5djmW8z4Zho30+LLkgoPKhZbfJslDavwcH277u
	 UuHcQypqtNJLDl1/RfMErzzuQ61uNSGgFCgWu3BM55SJ06/I9yFENtgjm/n3sT6oCG
	 02kl4T3UGPA+A==
Message-ID: <sashiko-outbox-176060@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] HID: wacom: check the input devices in the
 legacy irq handlers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinmo Yang" <jinmo44.yang@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261018104617.743771-3-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018104617.743771-1-jinmo44.yang@gmail.com>
 <20261018104617.743771-3-jinmo44.yang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 10:53:29 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] HID: wacom: requiring pad_input in wacom_dtus_irq() breaks DTUSX p=
en input
--

commit 1918eedc787a6887650a12d8f1032a28643191fc
Author: Jinmo Yang <jinmo44.yang@gmail.com>

HID: wacom: check the input devices in the legacy irq handlers

This commit adds NULL checks for wacom->pen_input and wacom->pad_input at
the entry of six legacy Wacom interrupt handlers to prevent NULL pointer
dereferences when an interface only initializes a subset of the input
devices.

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 567b01882eb1e..aa08afb3c5ef0 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c

[ ... ]

> @@ -293,6 +317,13 @@ static int wacom_dtus_irq(struct wacom_wac *wacom)
>  	struct input_dev *input =3D wacom->pen_input;
>  	unsigned short prox, pressure =3D 0;
> =20
> +	if (!input || !wacom->pad_input) {
> +		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
> +			      "%s: expected pen and pad input devices\n",
> +			      __func__);
> +		return 0;
> +	}

[Severity: High]
Does requiring wacom->pad_input at the start of wacom_dtus_irq() break pen
input on Wacom DTU-1031X (DTUSX) tablets?

In drivers/hid/wacom_wac.c, wacom_wac_irq() dispatches both DTUS and DTUSX
devices to wacom_dtus_irq():

	case DTUS:
	case DTUSX:
		sync =3D wacom_dtus_irq(wacom_wac);
		break;

Unlike DTUS tablets, the Wacom DTU-1031X (wacom_features_0x32F, with type
DTUSX) is pen-only and has 0 numbered buttons:

static const struct wacom_features wacom_features_0x32F =3D
	{ "Wacom DTU1031X", 22672, 12928, 511, 0,
	  DTUSX, WACOM_INTUOS_RES, WACOM_INTUOS_RES, 0,
	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET,
	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };

During probe, wacom_setup_device_quirks() only sets WACOM_DEVICETYPE_PAD
for DTUS, not DTUSX:

	if (features->type =3D=3D GRAPHIRE_BT || features->type =3D=3D WACOM_G4 ||
	    features->type =3D=3D DTUS ||
	    (features->type >=3D INTUOS3S && features->type <=3D WACOM_MO)) {
		if (features->device_type & WACOM_DEVICETYPE_PEN)
			features->device_type |=3D WACOM_DEVICETYPE_PAD;
	}

And wacom_setup_pad_input_capabilities() returns -ENODEV for DTUSX, which
causes wacom_setup_inputs() to free pad_input and leave wacom->pad_input
as NULL.

When WACOM_REPORT_DTUS pen reports arrive from a DTUSX tablet, won't this
new check always trigger and drop all pen events? Should wacom->pad_input
only be required when features->type !=3D DTUSX (with a check in the
WACOM_REPORT_DTUSPAD branch), or checked specifically when handling
WACOM_REPORT_DTUSPAD reports?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018104617.7437=
71-1-jinmo44.yang@gmail.com?part=3D2
