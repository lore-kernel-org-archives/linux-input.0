Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B35542466D;
	Sun, 11 Oct 2026 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742982; cv=none; b=rmh0sBtzI65L8k98PEI969KYRx0YqoQwZ18c/TGqlvDy2DMM7wthh4N77zHuuf73XYG9rLdwT+BXSayLmmkhNon4jqU19/I69qrcSXuz5rPcdnddH6zSYdE7MhZASJIblRKuW7OycC33ArLgxoD3bGptDTcyLOlaDseXKMK/PaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742982; c=relaxed/simple;
	bh=ppXtYHsgPlJ1sIoT+Pbw8O6fzxMhVKyxr4K8XdQ4pgk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ACeH7ii79HvzwRRCGZFxdxLDKDbpya+LOJtSwueH51S/ARNjO3trJQisuuxn2eJBAtbplibFUcTrXiPUFqU+/JNEyWNYjamkQdBLMlePhIGLFy0qHvLsgKgY1hiU0rs/+x6//9DdfLqgHiB7uUBaMe6xYV29tR3Aw72o340BbhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv8UoURg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv8UoURg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCC31F0089B;
	Sun, 11 Oct 2026 18:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791742980;
	bh=MbZlRZ5d1KuTM26ioAORlWTvWGmU8puL7CZPt7nrL8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hv8UoURg5/cwcrtPnvx2e0No+mCt+/nYRJVx3JdbvmCGgbkc6AqNx56kNKWYsZ2bJ
	 bhdNPsbrS5QhF/2FgfWBRvuGpb1qF0yNqDQRevHftS7dRDtKy/LbNMVNNHp9zaXV4y
	 6UH/If+5HILlrThcRt8pCO3Ed1j9Tdy/T+7rm8dhG+ys+dhW/uSt+aaIOU2ClTMEYU
	 GlCjq2RvqiCQ3fqHeOWEGs8JlVnBVDckDTj/pQAK9i+ET1inBI6MZE8qsVkONkvkrZ
	 OnKQnKsosUSZSdaxR5cRu7sUinR04OnR6H9trwWAVrXLDqG1Yzh8DH4lAdcksNggpp
	 VvW+QzntPD5xw==
Message-ID: <sashiko-outbox-167375@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: input: Add Himax HX83102J
 touchscreen
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWljaGHFgiBLb3BlxIc=?= <michal@nozomi.space>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261011181633.1778969-2-michal@nozomi.space>
References: <20261011181633.1778969-1-michal@nozomi.space>
 <20261011181633.1778969-2-michal@nozomi.space>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 18:23:00 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] dt-bindings: Redundant required shared resources for TDDI chip
- [Low] dt-bindings: Missing maxItems constraint on firmware-name
--

commit 08e7a44d4b27dca463d90889398954bf0cfaff49
Author: Micha=C5=82 Kope=C4=87 <michal@nozomi.space>

dt-bindings: input: Add Himax HX83102J touchscreen

This commit adds the device tree binding for the touch function of the
Himax HX83102J, a TDDI controller. The display and touch functions share
analog supplies and reset lines, which power up together with the panel.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/himax,hx=
83102j.yaml b/Documentation/devicetree/bindings/input/touchscreen/himax,hx8=
3102j.yaml
> new file mode 100644
> index 0000000000000..f0aca7a6662c9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.=
yaml
[ ... ]
> +  display-reset-gpios:
> +    maxItems: 1
> +    description:
> +      Reset of the display function, usually driven by the panel. Assert=
ing
> +      it also resets the touch function.
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  firmware-name:
> +    description: Specify the file name for firmware loading.

[Severity: Low]
Should this include a maxItems constraint? Since dtschema implicitly
evaluates this property as a string array, omitting a constraint like
maxItems: 1 allows device trees providing an array of multiple strings
for the firmware name to silently pass dt_binding_check.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - reset-gpios
> +  - panel
> +  - vccd-supply
> +  - vsn-supply
> +  - vsp-supply
> +  - display-reset-gpios

[Severity: Medium]
Since this is a TDDI chip and the driver utilizes the drm_panel_follower API
to coordinate power and reset with the panel, do we need to strictly require
vsn-supply, vsp-supply, and display-reset-gpios in the touchscreen node?

Requiring these alongside the panel phandle forces device tree authors to
duplicate the physical resource definitions (the exact same physical pins
and regulators) in both the panel and touch nodes, which might lead to probe
failures (-EBUSY) if drivers attempt to parse them natively.

Would it be better to remove these shared resources from the required list =
or
make them optional, deferring resource management entirely to the panel nod=
e?

> +
> +unevaluatedProperties: false
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011181633.1778=
969-1-michal@nozomi.space?part=3D1
