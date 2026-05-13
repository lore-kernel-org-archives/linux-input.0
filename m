Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4854025B09F;
	Wed, 13 May 2026 20:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778703359; cv=none; b=A+8ALhQGCSyDTu83ep2Uww+pUeDOfXpoZzyMcEZwMilrvkxrZtC8P71aZFql8cDfEXVkk3QMzOC/TusJufcdXuRJyGtZBZXRTqqyVTC5KEdaoaXlzaHa761RPI8BmxMbYOHiqG3xrd5aRtTBjzy1Wxcu5hy1Q12q8DCpPMXjzTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778703359; c=relaxed/simple;
	bh=aHOn0bBj7mZeXRdPhK84nyvdj3SeN5l6Vd4SecW7ULA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IRYHudwG7UIVJp0MvQDy/VktutUrPD0YGiiBBvDk8BsEzWx17iGi2AITE7PXWJ+lKV63HWKEPdX9q9axLX38uGzqZD69g2ZwKHugvfRcphwzK3nEgk6Q6G72LnQYLc4d0lmwe261YDzMZKaogddBJGNjuGn/dCXBq4GRUFz7eKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oi668B8r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi668B8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808C4C19425;
	Wed, 13 May 2026 20:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778703358;
	bh=aHOn0bBj7mZeXRdPhK84nyvdj3SeN5l6Vd4SecW7ULA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oi668B8rAub7Now9tjX4dqNJeslMjopqsPJh+z/60aLsELNacbJekKkKQDof3yYKJ
	 lVqzaaLkKmkPSPmTaEVE0gK9DhCvL2BFnNW3Cmxzz2Aw5wXypqpv7cjVNfBgMuYqYU
	 mW26QJifOGJ0jf6NgYguk5uzSmt7EvlERFr4eGue7/5FmQcHn4ThmeX3JHlUh+2k5U
	 GZcqyZcqEW3WI7i2hvYLdljd36CF805SjxWt7Q2NvDiVssxL36KwJDnrOQNTSgXoYy
	 3EflnKEgYxbHFe+px6iiGSFVG+9+7ulGBOJt+/q40yIbikLtfSS+1CtEEqtQt7Bk5e
	 h5uL8f+EcyxJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: input: Document Imagis ISA1200
 haptic motor driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, krzk+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260512102445.55372-2-clamor95@gmail.com>
References: <20260512102445.55372-2-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 20:15:57 +0000
Message-Id: <20260513201558.808C4C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing scalar type definitions for `imagis,period-ns` and `imag=
is,duty-cycle-ns` cause schema bounds validation to be silently bypassed.
--

commit c2a7ef2ca3d62317c69bc5b6a450107172eeeac7
Author: Svyatoslav Ryhel <clamor95@gmail.com>

dt-bindings: input: Document Imagis ISA1200 haptic motor driver

This commit documents the Imagis ISA1200 haptic motor driver. It introduces
a new YAML binding schema for the driver, specifying properties like
control-gpios, clocks, and internal PWM configurations.

> diff --git a/Documentation/devicetree/bindings/input/imagis,isa1200.yaml =
b/Documentation/devicetree/bindings/input/imagis,isa1200.yaml
> new file mode 100644
> index 0000000000000..bbe6f99d39c19
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/imagis,isa1200.yaml
[ ... ]
> @@ -0,0 +1,140 @@
[ ... ]
> +  imagis,mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Defines the motor type isa1200 drives
> +      0 - LRA (Linear Resonant Actuator)
> +      1 - ERM (Eccentric Rotating Mass)
> +    enum: [0, 1]
> +    default: 0
> +
> +  imagis,period-ns:
> +    description:
> +      Period of the internal PWM channel in nanoseconds.
> +    minimum: 10000
> +    maximum: 30000
> +
> +  imagis,duty-cycle-ns:
> +    description:
> +      Duty cycle of the external/internal PWM channel in nanoseconds,
> +      defaults to 50% of the channel's period

Will the minimum and maximum bounds on imagis,period-ns be silently ignored
during validation?

The core property-units.yaml schema automatically assigns an array type to
properties ending in -ns. Without an explicit reference to
/schemas/types.yaml#/definitions/uint32, these properties are evaluated as
arrays rather than scalar integers.=20

In standard JSON Schema, numeric constraints like minimum and maximum are
ignored when applied to an array instance. Adding the uint32 type reference
for both imagis,period-ns and imagis,duty-cycle-ns would ensure the
constraints are properly enforced on a single scalar value.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512102445.5537=
2-1-clamor95@gmail.com?part=3D1
