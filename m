Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919647;
	b=Rq74KiY+WdoHqKh5hbC0Ym8bpwgcJingupdA2SuKzmRRygmQqyISUw9zWDSHvBUkZOcJ
	 3N4fXT6y/ZO0n7RzHbSvEbFPsvurWmf4rNJhEsrnl/L7aS3bShM1AqAPR5ogs29Piatm0
	 9cXHA6JcKlCzPIZOlK4bZy7cfYPkPhrRRQ+lm+HB2A3gZVr4whwD0+mQYsPxkYXH8xxIn
	 DEMh6mvLKGfeXYaBgeZqFkKU1XpmzM7K2PSGuTzw2gLw1o/8GaBg1L2nEQpZzX5eOonwI
	 uSvCx4T8hVhLI6KQKj/aCgHzkSU5ASq5ct22nNe/PU+rNWOQ3gsc1sbN2o0MB+7jBgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919647;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L4CuJ/U6jBRxqbp2KP8YKiaenuPUuuIlyYrCtnXO1z0=;
	b=JKi8SiA9wNYqyjXQXCd1TrfJnaa36Osk58AOoUW0msUUIaBRQfss2iWtsL/Wb7B8jFIz
	 aPUEO3D/2l3CCd0lz8fpm6NadKfUdEvWy8K0y9ioWGei2vJZj3WusnAlcy7KQLuI2tqBf
	 NOCq7VRPau/2ptqegRhiV/6rXdueW9xH7xxWN1DLxipTNTZ735Kv04wou4WWBwCofIFD+
	 5GMSk2ePgE27AHatsO2zUv6x0bl6hQ8s5VlWQZD15jd5yTrP0qo3FTx+Zwv8Gsnhyt3PA
	 jrlvI149sqFdZnFh20skgC3pjs9euo2M3U91kDEORenpkUcwwS/qzWKBX94hAFhIaDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bYC/PfWG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D828A606A339;
	Tue, 17 Nov 2026 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYC/PfWG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33B11F000C8;
	Tue, 17 Nov 2026 12:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794919647;
	bh=L4CuJ/U6jBRxqbp2KP8YKiaenuPUuuIlyYrCtnXO1z0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bYC/PfWGXJucbpdFYe0lMasv9xm6Wmw8RNzAp8HSd33c5FZt7mId33boPRthhHcb2
	 dGerJ1LFGRqOvDlvjN5evjMuEkp+mC32EgFMAWqJnmf1SVrUXVJcQrcLiTLT697lJQ
	 0apwHitK/o7u0okcXHRGL/8rnOQ+QQb0uDQcRDkLUruvzl29g16tnGZeQUQaY4CgVQ
	 AEvnSMVF4sdX7ZpkdAqJyMrK5CQVdXTfS4hGuUHrIBdOP7IFohABGz6LQA3O/npHCf
	 uBzgpbd8nQrZ+bN/9ARvQRBGus9ePC7bFAVIr7GXMMozwTro1kBDbywIy7rjXKVFSk
	 lKVXSnYQ5R1Vg==
Message-ID: <sashiko-outbox-218789@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 01/11] dt-bindings: arm: qcom: add LG V60 ThinQ 5G
 (timelm)
Reply-To: sashiko-reviews@lists.linux.dev
To: rofikkerneldev <rofikcoga@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117123946.668557-2-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
 <20261117123946.668557-2-rofikcoga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 12:47:24 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] dt-bindings: arm: qcom: username in Signed-off-by instead of
  real name
- [Low] dt-bindings: arm: qcom: duplicate lge vendor prefix instead of
  lg
--

commit 3057431969983ea736dadadbf8f06be7752765b6
Author: rofikkerneldev <rofikcoga@gmail.com>

> dt-bindings: arm: qcom: add LG V60 ThinQ 5G (timelm)
>
> Document the compatible for the LG V60 ThinQ 5G (timelm), based on
> SM8250, and register the LG Electronics vendor prefix.
>
> Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>

[Severity: High]
The Author header and Signed-off-by trailer use a handle (rofikkerneldev)
instead of a known real human name, which is required by the Developer's
Certificate of Origin in Documentation/process/submitting-patches.rst.

> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentat=
ion/devicetree/bindings/arm/qcom.yaml
> index 121ca557ce1ef..f8b34109171d0 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -1139,6 +1139,7 @@ properties:
> =20
>        - items:
>            - enum:
> +              - lge,timelm
>                - qcom,qrb5165-rb5
>                - qcom,sm8250-hdk
>                - qcom,sm8250-mtp
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 5471a06f93f10..fa50a81880f0b 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -971,6 +971,8 @@ patternProperties:
>      description: Lenovo Group Ltd.
>    "^lg,.*":
>      description: LG Corporation
> +  "^lge,.*":
> +    description: LG Electronics
>    "^lgphilips,.*":
>      description: LG Display
>    "^libretech,.*":

[Severity: Low]
Should this use the existing "lg" vendor prefix (lg,timelm) instead of
adding a duplicate "lge" prefix?

Documentation/devicetree/bindings/vendor-prefixes.yaml already defines
"^lg,.*" for LG Corporation, and commit 5e4aac2caf12 ("dt-bindings: arm:
qcom: rename vendor of apq8026-lenok") replaced "lge" with "lg" in
Documentation/devicetree/bindings/arm/qcom.yaml to avoid separate vendor
prefixes for internal divisions of LG.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117123946.6685=
57-1-rofikcoga@gmail.com?part=3D1
