Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8120A44C645;
	Tue, 21 Jul 2026 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628383; cv=none; b=iGyRymYXmsUlcApeMLjRmFI96eP7KZa852AKREPVci1vzFNg3/jnB/WiEnmYx13JlbJlXVMP5BPEYLVXJqeVDgueCrzp5b95edHywG4KDCCpL0OH7MSiZLNonrhnza0JSBJjU+SYNJBFzyJDbSkFJLl3+NWQ0j4y0OqurqhqJ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628383; c=relaxed/simple;
	bh=e9emev741HJIAfX6L1IduIcEjovm3kd229dSSsYBV3A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YV6vvbWYaPchn7BlhP3H1PYNIBCY5N8xTSuuB2hainsAlgvlKFPa5kN1zuj1qJJtwZVZL25/Ik7SLm1oZXtffDom9nbmWZ5irbJiYBdxe3NcVi0pzTlr4MLOTRYuPcgcGPZutXsDRCGgwUl8gN3T2dhq5GiRiyWrlZN/6fOVgfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6MGWuIA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6MGWuIA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5EB1F000E9;
	Tue, 21 Jul 2026 10:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784628382;
	bh=avpWQ8YTk8yIcRdLCTyrYBkMvLFsO+SMTcSwNcsIGxw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M6MGWuIAxIVH9A7qt35+B5NDeCJg8dy8UwKTVMbw9fUe6rLBj4kwYWoZvo5DK5EBp
	 Wbo4O8FDSHh4NZIrtqCfKdD3UFABYtQ96JwMgd/LedJ0PLqa8dLV9+P3PILJAo1e8T
	 I+cwCPtOvdfetWRsNTw+7dOZ/olFWgX4iIPt+WgYJcMjRQC0mjDPgPom6GUOPTGxPU
	 cn65r9+Q1sZ8g8yPMC9CyrBDo2tJms7QUm9AmetZe2IIQaggi8HnbmtCpuCP5BAX/2
	 saSwj+OrsWhvVcLGIEWSJkS42hk+HT/JmlNZ/LLEl3Yg03eDpmd5LfsjObkSoVVz1i
	 pIFxEmszEgNqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/6] dt-bindings: leds: leds-cpcap: convert to DT
 schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: lee@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, linux-leds@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260721095654.429346-2-clamor95@gmail.com>
References: <20260721095654.429346-1-clamor95@gmail.com>
 <20260721095654.429346-2-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 10:06:21 +0000
Message-Id: <20260721100621.EB5EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] The commit message description following the subsystem prefix is no=
t capitalized.
- [Low] The newly added YAML binding points to a non-existent MFD schema, a=
nd the parent MFD binding still points to the deleted text file.
- [Low] The YAML binding conversion omitted the `examples` block.
--

--- Patch [1]: [PATCH v7 1/6] dt-bindings: leds: leds-cpcap: convert to DT =
schema ---
commit 42a8d75469150373ffb675f9ae6fccd8e3d482d6
Author: Svyatoslav Ryhel <clamor95@gmail.com>

dt-bindings: leds: leds-cpcap: convert to DT schema

Convert LEDs devicetree bindings for the Motorola CPCAP MFD from TXT to
YAML format. This patch does not change any functionality; the bindings
remain the same.

> dt-bindings: leds: leds-cpcap: convert to DT schema

[Severity: Low]
This isn't a bug, but should the description following the subsystem prefix
be capitalized? The LED subsystem conventions typically expect a capitalized
description, such as "Convert to DT schema".

> diff --git a/Documentation/devicetree/bindings/leds/motorola,cpcap-leds.y=
aml b/Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
> new file mode 100644
> index 0000000000000..c8e7b88a05ccf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml

[ ... ]

> +description:
> +  This module is part of the Motorola CPCAP MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. LEDs are
> +  represented as sub-nodes of the PMIC node on the device tree.

[Severity: Low]
Does motorola,cpcap.yaml exist yet? It looks like this references a
non-existent MFD schema. Additionally, the parent MFD binding in
Documentation/devicetree/bindings/mfd/motorola-cpcap.txt wasn't updated
to reflect the deletion of the old leds-cpcap.txt file.

[ ... ]

> +required:
> +  - compatible
> +  - label
> +  - vdd-supply
> +
> +unevaluatedProperties: false
> +
> +...

[Severity: Low]
Should this YAML file include an examples block? The YAML conversion
drops the original usage example from the .txt file.=20

Running dt_binding_check on standalone schemas that lack an examples section
can result in warnings or incomplete schema validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721095654.4293=
46-1-clamor95@gmail.com?part=3D1
