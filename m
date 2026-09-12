Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A32382292;
	Sat, 12 Sep 2026 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789249303; cv=none; b=P2yn+NuEgX+1UDui5D1GIcw/qzYUnn4cB1OG83SfCIAcvGW0JBnSn7dF1BB8wysgLs3RtD25ViikEEZTTr+TGLdfKAsGo9EY5u8KxUjL3zBUxJ/8DPAsM5b/3FHzZWMFMnZPkG2EVdMNNkkuLhedNAF7iqv7NK28vB7kveTtfRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789249303; c=relaxed/simple;
	bh=V7Un7INUrJKyt2gNSvvuJH0UgVG/Hq/b7NpRLaiQ8gE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ufsoae0z5bT2eDDW51KCpXOGkLrAX4vtJwC64VCQigP3RwAKH7QNEthEdjypPqw8muSE7NRqlz9nRNUsti5vNnS12kZxV+y7kkIk7LfgXakNVEFZWi/sG1q9KpWQdhpLgePwi5lsSQHFSNXb7+/SGeAfKPSrt1iPXKR/cMJKWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhrG3hdC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhrG3hdC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DC61F00899;
	Sat, 12 Sep 2026 21:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789249302;
	bh=GcaqpxDK0cRHL0ftV8m2Gc/pv3ybatU9dCBhjNZHZAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fhrG3hdCYemgVi1zypbDSwtv04tDMs/R2nml0SKIowU0pKhGmgIqfu7KMNnhHqQ7z
	 3PaT81B4FbtiLwJz+fjb+17aDESXK4SkgbhvovlnGgkKyOJ2sV9V+oEMaj3sfiH4z2
	 p9mxTcXnK99308/pkYFvesY1vIXR9IjvCdLd89lfPOoImteKrHxQEc7D+14g1iiQKc
	 HNTFmoPdK8/D8PlmiwO9u2fnA7QF3tiT6aMscT7OBw5IX6rzakMPSedmY4W2RAtD2Y
	 v5BLkij4XqnIwixzEG0/b6sEdRWR/0KlP/bosmvPXHXqQ29ZAOzOgkUXJYKw6hXodI
	 0m2NSSoOnn0JA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: input: gpio-keys: add pinctrl states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kendall Willis" <k-willis@ti.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260912-upstream-gpio-wakeup-v1-1-f0e12484b836@ti.com>
References: <20260912-upstream-gpio-wakeup-v1-0-f0e12484b836@ti.com>
 <20260912-upstream-gpio-wakeup-v1-1-f0e12484b836@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 21:41:41 +0000
Message-Id: <20260912214142.26DC61F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Schema constraint on `pinctrl-names` breaks validation for exist=
ing device trees using standard PM states.
--

commit 7cccd8c7baf951e7fe028bb369bca736764010d5
Author: Kendall Willis <k-willis@ti.com>

dt-bindings: input: gpio-keys: add pinctrl states

This patch adds pinctrl-0, pinctrl-1, and pinctrl-names properties to the
gpio-keys device tree binding to document the default and wakeup pin
configurations.

> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Doc=
umentation/devicetree/bindings/input/gpio-keys.yaml
> index cc78c21529213..b554933e93412 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
> +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
[ ... ]
> +  pinctrl-names:
> +    description:
> +      When present should contain at least "default" describing the defa=
ult pin
> +      states. The second state called "wakeup" describes the pins in the=
ir
> +      wakeup configuration required to exit sleep states.
> +    minItems: 1
> +    items:
> +      - const: default
> +      - const: wakeup

[Severity: Medium]
Does this strict schema constraint break validation for existing device tre=
es?

By explicitly restricting the pinctrl-names items to exactly "default" and
"wakeup" in Documentation/devicetree/bindings/input/gpio-keys.yaml, this
generic binding will now cause device tree validation (make dtbs_check) to
fail for existing upstream boards.=20

Many boards correctly use standard pinctrl power management states like "sl=
eep"
(for example, pinctrl-names =3D "default", "sleep";) which are now rejected=
 by
this schema.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-upstream-g=
pio-wakeup-v1-0-f0e12484b836@ti.com?part=3D1
