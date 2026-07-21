Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7BC47DD6B;
	Tue, 21 Jul 2026 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628972; cv=none; b=Z/1OwHUxo/KQahuWhISOxoctgK1I3CBco//HJqWOKvJqAzoNQrAxs9wxMmXTpQpT/AUnWuP6ldaB9ubSYoMIunb50DHnQcnWx5mmKcgPc8oIzZXZ7yTUw5eXit5v864q79C/1G88ZCxW2SjIS1zY8RhOaPrCCEBDal8eKa4E1og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628972; c=relaxed/simple;
	bh=8sCEQHrPXe5hQPo9MToa2PG4jZF/1GldSEDg8o5rO6g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S8r0EC7vhNRS+hK2GlZfG8Kyn7TymjKCq23ZCQfsPQXVqfMsPkCfr2EUG73i4v4aYi7yMCBch9GZogjHjBPtJoo0FL0JO9Rgrgj5Ohc3xSP5Re2p62lHLRnq8MXHIPqr/aOcCcFJjRJilWguiW5kHaeuQVfpEAbKuLIn41gS70A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jY/M8mKz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jY/M8mKz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFA11F000E9;
	Tue, 21 Jul 2026 10:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784628965;
	bh=AcLp4dFPvCOoi0raae187qIUWOlRMREIetvj+OZGgrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jY/M8mKzenS+CiM/rElvjBp6r7bxkvdeqY36pgTTpoJ+kGDa1WzXS3pvRDOpVKozG
	 71y6pFdxLmdwaoUy1cM3NbBzSND3faUUx4V+N6x5OykrIi/qOlTQS4yyslJr/ypK8/
	 wINNyvZwDGmJHagUq+B+xPH6EQnCjPvBt+UajHB+8spzmZNiIK7T8i+ZoIEP9xvu23
	 XgUdBjlqLX9W951AuilAjo8T3nLVaAkxvUZGXSeZtffvkJYjnIpUCrNJPhDCnUprYC
	 +BiuA2fiX6qeYr0fUN/e8E+O952/jRjkU2ltGd4WBx9CQCHddEgc7Es/jguPLmEZQU
	 IwRTNJFWM4MyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/6] dt-bindings: mfd: motorola-cpcap: document
 Mapphone and Mot CPCAP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, lee@kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260721095654.429346-5-clamor95@gmail.com>
References: <20260721095654.429346-1-clamor95@gmail.com>
 <20260721095654.429346-5-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 10:16:04 +0000
Message-Id: <20260721101605.5BFA11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The new compatible strings are defined as standalone enums witho=
ut a generic fallback, causing drivers to fail to probe.
- [Low] The commit message description starts with a lowercase letter, viol=
ating MFD subsystem guidelines.
--

--- Patch [4]: [PATCH v7 4/6] dt-bindings: mfd: motorola-cpcap: document Ma=
pphone and Mot CPCAP ---
commit d9f93935d00aa3510052461fef588d4ce3014eed
Author: Svyatoslav Ryhel <clamor95@gmail.com>

dt-bindings: mfd: motorola-cpcap: document Mapphone and Mot CPCAP

Add compatibles for Mapphone and Mot CPCAP subdevice compositions. Both
variations cannot use st,6556002 fallback since they may be based on
different controllers.

> dt-bindings: mfd: motorola-cpcap: document Mapphone and Mot CPCAP

[Severity: Low]
This isn't a bug, but should the description part of the commit message be
capitalized? The MFD subsystem guidelines typically expect a capitalized
description after the subsystem prefix.

> diff --git a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml b/=
Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> index 76705ea56805a..da7abe2ec9126 100644
> --- a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> +++ b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> @@ -14,9 +14,14 @@ allOf:
> =20
>  properties:
>    compatible:
> -    items:
> -      - const: motorola,cpcap
> -      - const: st,6556002
> +    oneOf:
> +      - enum:
> +          - motorola,mapphone-cpcap
> +          - motorola,mot-cpcap

[Severity: Medium]
Since these new compatible strings are defined as standalone enums without a
generic fallback, will the core driver fail to probe these devices?=20

Looking at drivers/mfd/motorola-cpcap.c, cpcap_of_match[] lacks a match for
these specific strings:

static const struct of_device_id cpcap_of_match[] =3D {
	{ .compatible =3D "motorola,cpcap", },
	{ .compatible =3D "st,6556002", },
	{},
};

Are there plans to update the driver's match table to recognize these new
standalone compatibles, or could a generic fallback like "motorola,cpcap" be
added to the bindings?

> +
> +      - items:
> +          - const: motorola,cpcap
> +          - const: st,6556002

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721095654.4293=
46-1-clamor95@gmail.com?part=3D4
