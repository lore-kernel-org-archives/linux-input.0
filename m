Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8AC44C678;
	Tue, 21 Jul 2026 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628002; cv=none; b=Zx7xZZIyUvVeM/GnPEKHZtHoCyvKGVK0Eg9pgVk9rygC1hscfJ7pslNUHKxBLti3w0CrHF5KzcyzT9/Gkw6hjimS9xJ+9tTVBDH9zOPVYRI9QimYq90wB4Ercp8dLTrHMvwcE3gsbFtymmMvUIKS0dhg6y00fBfsXIldaMTcBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628002; c=relaxed/simple;
	bh=m/EjmerojyihGjkP71VFjD0OxRXvlszvaFTICzVS4ew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MQnjt0pTXBMjYg5Z9GGmuy8Zkoc9HCTFJmXwEoxxVBFZpASUcprYLsMT6f1tEPnXVqdDP5NA8Hsfg9G9ctBidpMAhJmWURJfq/yO+N/NAittag1SH5lzClGeQDmda6/+pwTQMqeHqlPZ+pgrsRv9ZQ0y9N5TC7MJyAxXx4sUy4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5s3ht6n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5s3ht6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73861F000E9;
	Tue, 21 Jul 2026 09:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784627999;
	bh=JF40Nlo6LaXclhZsFY0RMKnbuUb31iGjjMhSLn+YNCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S5s3ht6nAnog+3hxyTheB5IQiMF2aF6X9Jy061Ov8uaQqXtTrg8YcoSClNgFpeQqC
	 fzYp68f40tuO+9O+5/jmwjT+lZ33ys8DWXoV0z4hABUpq6G/CifVamTgHRZyp/lSbj
	 cHc/DdBc4EOAWbeYJlu6T4Ep61xpBBUmIy3ONcYv+9djAdlUqPjRBWPkJo6YPhLSK0
	 IbhzRYEHilVOzSsgQbnutJw+xw4Mk3ceE3ObbxEvgg4gA4UITQAJjOW2g9GfRll/la
	 JPj7x5qNs4aobMn631Uszj8pdK7zialoIzVLfmkHyNewoVCokKePqE+GTRcHaNOPqE
	 +GeI47+Yz8b0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/7] dt-bindings: embedded-controller: document ASUS
 Transformer EC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-leds@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260721095233.420823-2-clamor95@gmail.com>
References: <20260721095233.420823-1-clamor95@gmail.com>
 <20260721095233.420823-2-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 09:59:58 +0000
Message-Id: <20260721095958.C73861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `reg` property lacks a `maxItems` constraint or explicit `items=
` list, which will cause a meta-schema validation failure.
--

--- Patch [1]: [PATCH v10 1/7] dt-bindings: embedded-controller: document A=
SUS Transformer EC ---
commit 9a8d6db220adffb6b7bdbf5fea9059f76a4c94f3
Author: Svyatoslav Ryhel <clamor95@gmail.com>

dt-bindings: embedded-controller: document ASUS Transformer EC

This commit documents the embedded controller used in the ASUS Transformer
device series. It adds a new YAML binding describing the Nuvoton-based
controllers attached to an I2C bus.

> diff --git a/Documentation/devicetree/bindings/embedded-controller/asus,t=
f201-ec-pad.yaml b/Documentation/devicetree/bindings/embedded-controller/as=
us,tf201-ec-pad.yaml
> new file mode 100644
> index 0000000000000..60b6375864aaf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec=
-pad.yaml

[ ... ]

> +  reg:
> +    description:
> +      The ASUS Transformer EC has a main I2C address and an associated
> +      DockRAM device, which provides power-related functions for the
> +      embedded controller. Both addresses are required for operation.
> +    minItems: 2

[Severity: Low]
Does this reg property also need a maxItems constraint or an explicit items
array list? The device tree meta-schema requires standard array properties =
to
be fully bounded to avoid implicitly unbounded arrays, which will likely
trigger a failure during make dt_binding_check.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721095233.4208=
23-1-clamor95@gmail.com?part=3D1
