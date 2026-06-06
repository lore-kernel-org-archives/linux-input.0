Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6024A21771B;
	Sat,  6 Jun 2026 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780759121; cv=none; b=fLV6PWP9BiBe6vhww1r/hs998DAfwtXLNeSoSV22D9xDYSg/lNJTlpz2EZNJOV67mzm+8rqtb0L3SSteV8/s6ZrCse09uLZhKD0dA4yK7VTTMYVXNG7qUOsltm6FslqgbDCzXVt1ZC5Mm8X41uHbCdYMHlXmscB2WeifzhwLF18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780759121; c=relaxed/simple;
	bh=BR/xYD6Mxi9Rnr1LPZKgQmmKm6jer8bZTOXBlAA3xUk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eNL2RWGt5FC25gqXIdHJ0XY+fi6UBL0GEWBMcWDcoCia/l0Z0/1bFeUZ3Et+0WBcoFvFuBFLC8RqKGdzHaeZJiypAJiGej40EwMr/+L0v/v3Ip3fikKLcOf6QqEdwa92Id1rBYclDnOh/yx4tIZeQ3+gvMxyvt5ldietHGHQQig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oh8G9WFU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oh8G9WFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD0D1F00893;
	Sat,  6 Jun 2026 15:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780759119;
	bh=BQnpeUOH/PksNRv3lbZC4/WlT4O3tEKfqARDxVFsGig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oh8G9WFUQQcsHuk5lMT87cetbbyZsRtPZSb837RhnTrfbE/96VeFrhn7+yB4+cKI/
	 Ecp/VKVzmL3+SUtwN3oxELBBW+cgP98J/W/1DKOv4IFn30tS3HopT5K915AqBEqmhe
	 v1QC6Vmwj6sd6uWdHmcZgmCqrVGIn7GffV0mLj093IOa7Y+D3hMOsmGIuD9iSfEjn+
	 XMRjqyhAy5fheVErnFvxliZPfQDuN2xNWLqnxgEs5s9+elaEVBavy+gbWfcw1Cocly
	 Jek9cCypi9LjiPtNcke9jKA2D1budFhpcKBMKVZ9bEi8kgHjjmyzYOQZuwfpUev7QZ
	 zyxlMKzcEjDng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] dt-bindings: input: microchip,cap11xx: Add
 reset-gpios property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jun Yan" <jerrysteve1101@gmail.com>
Cc: conor+dt@kernel.org, linux-input@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260606150458.250606-5-jerrysteve1101@gmail.com>
References: <20260606150458.250606-5-jerrysteve1101@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 15:18:39 +0000
Message-Id: <20260606151839.7CD0D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver fails to probe when a Device Tree fallback compatible s=
tring is used because it rigidly requires an exact I2C device ID match.
--

commit 804bdcc3e4e43cb8aa1a476f171c69be30e83854
Author: Jun Yan <jerrysteve1101@gmail.com>

dt-bindings: input: microchip,cap11xx: Add reset-gpios property

Add support for the optional reset-gpios property to describe
the active-high reset pin for CAP1126/CAP1188 devices.
Driving the GPIO high asserts reset and deep sleep, while driving
it low releases reset for normal operation.

Restrict this property to be available only on CAP1126 and CAP1188
chips, as other CAP11xx variants do not have a hardware reset pin.

> diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.ya=
ml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> index 99d00f572a2d9..e307628350c24 100644
> --- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> +++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but since we are updating
bindings for this hardware, is the I2C ID matching in the driver too
strict for standard Device Tree fallback compatibles?

Looking at cap11xx_i2c_probe() in drivers/input/keyboard/cap11xx.c:

	id =3D i2c_client_get_device_id(i2c_client);
	cap =3D i2c_get_match_data(i2c_client);
	if (!id || !cap || !cap->num_channels) {
		dev_err(dev, "Invalid device configuration\n");
		return -EINVAL;
	}

When a device is instantiated from a Device Tree using a fallback compatible
string (e.g., compatible =3D "vendor,custom-board", "microchip,cap1188"), t=
he
I2C core sets client->name to the local string without the vendor prefix.

Because this local name is not present in the cap11xx_i2c_ids table,
i2c_client_get_device_id() evaluates to NULL and completely aborts the prob=
e.

Could this early exit be updated so that valid I2C clients instantiated via
fallback compatibles are not erroneously rejected?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606150458.2506=
06-1-jerrysteve1101@gmail.com?part=3D4
