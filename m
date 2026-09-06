Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63442050;
	Sun,  6 Sep 2026 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788712818; cv=none; b=L1gwlLeEXkzUTLHijfi7pxNouuJ1TY07BzNIDk8UyCxS1TgNXg83YWvd9+cdIKdCgcsj5ogPa9FVOiWbvVj5Ya169hV/rgzz/wie26IQ7p7m+bDtLjiJTNIWjAd5pk9ebS0xAgN1VWOVD400CTc8zjqMIbQ8ViUJs7eX7sr0pAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788712818; c=relaxed/simple;
	bh=1RDC8MiDuWlDVtP3Wl9kRmhLbpPHePMfXsv6FLzgaZM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z7EgNNn6+xTaPAhUdVvC0S00oNVKuHdCW5IIiRZfQKGRI1v4c22rV2CFVmkOJ6uIO1aPjN7ilmIdDjW0CanwhSr92sCYfI/GVR4blsPSR+Plb3MILr/SDOOw85dMyFW57jw/VHXIVOkYwlmPZRGDAphU5MWaa17vVxInjbHZByI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbNLuNdA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbNLuNdA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773C01F00A3A;
	Sun,  6 Sep 2026 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788712816;
	bh=dOvuXSvEQ99KCUSNpMpy7ppcwksXVk1XhoRxAKsBHdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QbNLuNdA1DzCTUbEF1cbQgSrx476jXjAHt+On/tKc46KXi79Gq6V/BJrXXESQVw96
	 159zYkgzjDbL6Rx+15cxjLABECLvZfgIGo0rfnEvjPdrWobRMZUaRNWjtKv3/d9zOU
	 jIVOVxHBokF01u1DHgrTU3GMbYGBDybSgpUSroW0TMShY2YzyZp2pJU7WeiFzVrAQ0
	 ob76Cb7LIJdpT8kF4DXjANY8BeDMmHpu1pRVY3CR+I1NJTjM/7rXYN3h87OdhKtEu5
	 SAzhQK10AVoPUIy8nd/C/zg/ClM3pNg6aRb44wo6quDmoCF8qg6IewBVFETbd0JXKF
	 GrG/MbLr6g6xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: input: touchscreen: st,stmfts:
 Introduce STM FTS5
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Heidelberg" <david@ixit.cz>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260906-stmfts5-v6-1-50fbf6af8718@ixit.cz>
References: <20260906-stmfts5-v6-0-50fbf6af8718@ixit.cz>
 <20260906-stmfts5-v6-1-50fbf6af8718@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 16:40:16 +0000
Message-Id: <20260906164016.773C01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `if` condition matching the `compatible` property against `s=
t,stmfts5` incorrectly uses `const` instead of `contains: const`, breaking =
the conditional logic and improperly forbidding `mode-switch-gpios` for the=
 new variant.
- [Medium] The patch contains undocumented modifications to the existing `s=
t,stmfts` device tree example and file structure.
--

commit b15460ebf5a9b2a2c1695b3d9fb6f5007a3c46e1
Author: David Heidelberg <david@ixit.cz>

dt-bindings: input: touchscreen: st,stmfts: Introduce STM FTS5
   =20
Introduce more recent STM FTS5 touchscreen support.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/st,stmft=
s.yaml b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
> index 64c4f24ea3dd0..3de4bc5cd3f78 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
[ ... ]
> @@ -51,6 +54,17 @@ required:
>    - interrupts
>    - vdd-supply
> =20
> +allOf:
> +  - $ref: touchscreen.yaml#
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            const: st,stmfts5

[Severity: Medium]
In Device Tree json-schema representation, the compatible property evaluates
as an array of strings. Does this use of const: instead of contains: const:
incorrectly compare the array to a single string?

Since the comparison would always evaluate to false, the not condition nega=
tes
this to true, which means the then clause is always applied. This appears to
incorrectly enforce mode-switch-gpios: false for all devices, breaking the
schema validation for the new st,stmfts5 variant.

> +    then:
> +      properties:
> +        mode-switch-gpios: false
> +
>  unevaluatedProperties: false
> =20
>  examples:
> @@ -64,10 +78,9 @@ examples:
>          touchscreen@49 {
>              compatible =3D "st,stmfts";
>              reg =3D <0x49>;
> -            interrupt-parent =3D <&gpa1>;
> -            interrupts =3D <1 IRQ_TYPE_LEVEL_LOW>;
> -            touchscreen-size-x =3D <1599>;
> -            touchscreen-size-y =3D <2559>;
> +            interrupts-extended =3D <&gpa1 1 IRQ_TYPE_LEVEL_LOW>;
> +            touchscreen-size-x =3D <1600>;
> +            touchscreen-size-y =3D <2560>;

[Severity: Medium]
Are these modifications to the existing st,stmfts example and the earlier
restructuring of the allOf block missing from the commit message?

The commit message explicitly states only that it introduces STM FTS5
touchscreen support. While migrating to interrupts-extended and changing the
touchscreen size might be valid cleanups, they are undocumented side-effects
and likely should be explicitly mentioned in the commit message to justify
the changes.

>              touch-key-connected;
>              avdd-supply =3D <&ldo30_reg>;
>              vdd-supply =3D <&ldo31_reg>;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-stmfts5-v6=
-0-50fbf6af8718@ixit.cz?part=3D1
