Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E7B47A0C2;
	Mon, 21 Sep 2026 23:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033651; cv=none; b=l54o5egCX2W/dyXrfVYMSd8QKCM9wM9vcoRYOlJ+EjujHiVfbmESLPuyZ8f6yErjvQTkY2q6y/yVl1avOByLDYwAj3B2vVDqrb3vALulUWb5ZQT9+rXzY/aiQH/NkTLbQziqNXn9S3PFSfygb/BN2pSFTXtYnNDtirNBnXL/FWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033651; c=relaxed/simple;
	bh=Ha1OQO0526bWzARjTWY8y3Hd9/O3KFTc4t2x23gt3Pk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uOjKEdh3rQPDiNiPMAIy3xIcjjYAbM7y1EGNUwmKuq9L3ADUedw1OMN56LRybGhMhLaZsZitYAGA3jqcfN/T1Jxk7nNveEtF3L3zuhixOwZvDAjdITzHCNlsXe4wGi8yYxh+kJ5pNp2I7ki0/HEq18TYHlVU/PfY1HO1TkrYf/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2br+mps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2br+mps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EF71F00893;
	Mon, 21 Sep 2026 23:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790033647;
	bh=1BFn8GqNkw37IiE1B2IBnFYdAimU4i2QJPXyOFIr3ZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b2br+mpsbLb6cAoT/qRNU8NciazvNdfQIkoHrkGwMzazyKQRcrnvNz4rDYKypZ+gB
	 bRnu4bFbDiclsAFwkK889MX84je+wZGbGtFR1KGKmIdJf4H+QQDD7ydGKSr2GSGldN
	 ilu3SOthhwovph6Cb1LsrcS5VVsOcHdowWmPJms2uzlPAIm0Ykme4Bb+2UF355x2M7
	 rGo+ZW13j5Hgg15LG+3vbbQhIzQZaKZc7AKAhulArWgmFhNLJvhBnWw0WCvHG6VsNS
	 rN3riiiLhQUrgKZbh7E+vnKjke7CY7ybf4AX/UHr+9+O6nC6LMu7BtuKt2tNXTVaDV
	 HzsEbrZVeFXxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: input: syna,rmi4: Allow incell supply
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260921232738.3135429-1-robh@kernel.org>
References: <20260921232738.3135429-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 23:34:06 +0000
Message-Id: <20260921233407.17EF71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: legitimize OS-specific fw_devlink hack in hardware =
schema
--

commit 18108c1337c210aa2101238d8a2bf5d5648f3f22
Author: Rob Herring (Arm) <robh@kernel.org>

dt-bindings: input: syna,rmi4: Allow incell supply

This commit adds the incell-supply property to the Synaptics RMI4 touch
controller device tree binding. It is intended to allow existing Sony Xperia
Tama board device tree nodes to pass schema validation.

> diff --git a/Documentation/devicetree/bindings/input/syna,rmi4.yaml b/Doc=
umentation/devicetree/bindings/input/syna,rmi4.yaml
> index fb4804ac3544d..464c83ece4186 100644
> --- a/Documentation/devicetree/bindings/input/syna,rmi4.yaml
> +++ b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
> @@ -56,6 +56,7 @@ properties:
> =20
>    vdd-supply: true
>    vio-supply: true
> +  incell-supply: true

[Severity: Medium]
Does adding this property to the generic hardware schema violate device tree
design principles by formalizing an OS-specific software workaround?

Device tree bindings are typically expected to strictly describe actual
hardware. The user of this property is the Sony Xperia Tama board
configuration, which acknowledges it as a workaround:

arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi:
        /*
         * This is a blatant abuse of OF, but the panel driver *needs*
         * to probe first, as the power/gpio switching needs to be precisely
         * timed in order for both the display and touch panel to function =
properly.
         */
        incell-supply =3D <&panel>;

Since the device tree source explicitly documents this as a mechanism to fo=
rce
fw_devlink probe ordering between the panel and the touch controller, should
we avoid spoofing a fake hardware property in the official schema?

Would it be better to address the probe sequence dependency properly instead
of institutionalizing this workaround into the formal hardware schema?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921232738.3135=
429-1-robh@kernel.org?part=3D1
