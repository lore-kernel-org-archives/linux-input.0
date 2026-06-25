Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3F01E32A2;
	Thu, 25 Jun 2026 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376080; cv=none; b=em218E3ztUm5OC8mdrIksCNVIaDMrAvTJ1aOB1/zM3bBMjm31In4DVURgeL9ZQnGpFdGn/mrW9VK96fd4MFriKlaFf82iSujPblirPrFL77YIJI1f95iBmow5dOxhGuRIKcL496Yynuupfdp9iWkNXG736vOabq90i/v7H4E1UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376080; c=relaxed/simple;
	bh=+coBmhYgyURRGwX3T53+GmiUvimHziGcSd7913hosSs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JgEX+fcRQecp3Fq4dci+Hq+PGzOVbmD9xihLDDIqbbwZefHxOCJUG6Q9eKvBecceYeFDWp+q7RUDTQPT2lNztyeCNKbUUTHh4Op+oCwggRddCeIVYkOIqNmyziWiZGGMzLQS5s7Y/kWnJQoZSIRhtv4595EEviSuhQvsOfa4sNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiOF2Yqa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiOF2Yqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6CB1F000E9;
	Thu, 25 Jun 2026 08:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782376079;
	bh=D8agqbFKmtG4ZzlbSngzHpX9UjemAREGvQYvUlIKYmg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RiOF2YqagWxXV8sPBAW4o1LQ3VA3/8QsVQkIRdKTL7n6MbwxCREl8B7vxq5jhOOnR
	 YpHx4kvhZO4nGrDCAFEjGMxSzejGlWVwa/XuM256QAf1eHeSn28nKhFhQqXjP15x+L
	 rb0+GaB285ijiSVgqFxaf5CyTLRb5BV7vgGalj1fktP5nA3i1RsvIpCojh4DaEFucN
	 tKq2RQnPCo1GfoODZoRSRJ4uQnwxJCSaj9oF9bnQ7gBKerMnZyNv3YiMzNI0eEYIMs
	 ArWux3N4Kq/6f3HfjyEB+hckwcdogdNFeS1Xlws53eHkdKLXhdsnAfx1u/WV0xUJzp
	 6WWckhQa21sMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/6 RESEND] dt-bindings: mfd: motorola-cpcap:
 document Mapphone and Mot CPCAP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, lee@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20260625081812.33474-5-clamor95@gmail.com>
References: <20260625081812.33474-1-clamor95@gmail.com>
 <20260625081812.33474-5-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 08:27:58 +0000
Message-Id: <20260625082758.8E6CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added device tree compatible strings `motorola,mapphone-=
cpcap` and `motorola,mot-cpcap` are defined as a standalone enum without a =
fallback, forcing device trees to either break schema validation or break O=
MAP platform initialization.
--

commit 6926040210bec2501eaa0528dd29bde0ac318c6c
Author: Svyatoslav Ryhel <clamor95@gmail.com>

dt-bindings: mfd: motorola-cpcap: document Mapphone and Mot CPCAP

Add compatibles for Mapphone and Mot CPCAP subdevice compositions. Both
variations cannot use st,6556002 fallback since they may be based on
different controllers.

> diff --git a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml b/=
Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> --- a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> +++ b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
[ ... ]
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

[Severity: High]
Will this schema change break OMAP platform initialization for devices=20
using these new variants?

The schema defines the new compatibles as a standalone enum. However, the
OMAP platform initialization code explicitly relies on finding a node with =
the
generic motorola,cpcap compatible to configure the PMIC:

arch/arm/mach-omap2/pmic-cpcap.c:omap4_cpcap_init() {
	...
	if (!of_find_compatible_node(NULL, NULL, "motorola,cpcap"))
		return -ENODEV;
	...
}

If a device tree conforms to this new schema (using only the specific varia=
nt
compatible), the platform code will fail to find the node, breaking PMIC se=
tup
and CPU voltage scaling.=20

Conversely, if a device tree defines an items array using motorola,cpcap as=
 a
fallback to successfully initialize the platform code, it will fail schema
validation because this oneOf block expects either a standalone enum or the
specific ["motorola,cpcap", "st,6556002"] items list.

Should the new variants include motorola,cpcap as a fallback in an items
array, or does the OMAP platform code need an update to recognize these
new standalone compatibles?

> +
> +      - items:
> +          - const: motorola,cpcap
> +          - const: st,6556002
> =20
>    reg:
>      maxItems: 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625081812.3347=
4-1-clamor95@gmail.com?part=3D4
