Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344B3B6C15;
	Tue, 16 Jun 2026 10:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605118; cv=none; b=EQvE6X4uLtJU2lSIXXyhc7uyZmliDEiHnd7B7X/UMVaCWCvI9ncp1lC168O2/ILMxuZux6N9R+ijoaVh49++zVuO9hdrnfS74suHIO1Bh9nVlybftFLU/2BdXVZivO6HC1EZD2xbOCh7c5ufPwU8rK7qgFtoTaKa3XP/rb5QV5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605118; c=relaxed/simple;
	bh=EvqhXb5ZtKQ8x2jVua++swOMh2ks/O7DgQKl97pFV3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aKMlExYJat/TWJKpkMaAQJZ8xoGA5EF4cRw/ehBWOD1rFJmW/73t6z+NcWtKGiAG01Rc0r41UM4iV1oShr5QSfOCERuFxSXG9TBx3JbX23+KRgVRYXBxSZ97XJXeY+/vCeMPNHTRyuVzsq12lHiGsafq5gzeYYIuRbvjZlchG78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoMUWR8l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoMUWR8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D027B1F000E9;
	Tue, 16 Jun 2026 10:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781605117;
	bh=aszBkk4m1aU9hy/ludtjWxZlJ1n041DGRt7Lx5WET7U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YoMUWR8l6wmlD70X0OU+op99mUPZnfz9Wa/RIQ12XxiFNxYsDi9k60GDsnEZguwTN
	 FF7bsrSajlEqcihvUydUpO7XEqoreNcUwmYz5Acp+rfyzXDyNh6F16tpKrT0UyI7r+
	 euX9FcQ/vJfKm92eOLgJ6N/VABCZtoSJjcZSruxzwCyPFkEDZHZb8+t/rv4L63V34Z
	 Ao41RcFdA/85MikumVNF+vd3wCD5OskYQqPA7fdrZEEAa71xY8oFktiLfro2DYsdPi
	 nUfUh2VKwYgmrRaIEvw+eIvNBPn9GdzGW3GgwAixiwjEolCDShjcF5aC90Rp3rc6GA
	 IyzN3Yz4wXOdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: input: Add binding for Qualcomm SPMI
 PMIC haptics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260616-qcom-spmi-haptics-v1-1-d24e422de6b4@oss.qualcomm.com>
References: <20260616-qcom-spmi-haptics-v1-1-d24e422de6b4@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 10:18:36 +0000
Message-Id: <20260616101836.D027B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The device tree binding description contains Linux-specific driver =
implementation details, violating the OS-agnostic principle.
- [Low] Stale reference to an undefined property 'qcom,wf-play-rate' in the=
 binding description.
--

commit 24bf9f2257f4052d27a53163621c8f5173fe1da8
Author: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

dt-bindings: input: Add binding for Qualcomm SPMI PMIC haptics

Add binding document for the haptics module inside Qualcomm PMIH010X.

> diff --git a/Documentation/devicetree/bindings/input/qcom,spmi-haptics.ya=
ml b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
> new file mode 100644
> index 0000000000000..0e26d68563dcd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml

[ ... ]

> +      In FIFO streaming mode, hardware-based LRA auto-resonance tracking=
 is
> +      disabled by default.  Because this mode is intended to drive arbit=
rary
> +      waveforms that may not follow the resonant frequency, autonomous h=
ardware
> +      resonance correction would interfere with the intended output.
> +
> +      In the driver, FIFO streaming is implemented using an FF_PERIODIC =
effect
> +      with an FF_CUSTOM waveform.  The expected custom data layout is:

[Severity: Low]
Are these Linux-specific driver implementation details, such as FF_PERIODIC
and FF_CUSTOM, appropriate for this binding document?

Device tree bindings are typically expected to be strictly OS-agnostic
hardware descriptions. Should the documentation for the driver's ioctl payl=
oad
and custom_data memory layout be moved to the Linux driver documentation
instead?

> +        custom_data[0]   =3D play rate code (see qcom,wf-play-rate value=
s below)

[Severity: Low]
Is there a missing property definition for qcom,wf-play-rate?

This line references qcom,wf-play-rate values, but the property doesn't app=
ear
to be defined anywhere in the schema's properties section. Does this need to
be added, or is this a stale reference that should be removed?

> +        custom_data[1]   =3D vmax in mV; 0 =3D use device default (qcom,=
vmax-mv)
> +        custom_data[2..] =3D signed 8-bit PCM samples (at least one requ=
ired)
> +
> +properties:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616-qcom-spmi-=
haptics-v1-0-d24e422de6b4@oss.qualcomm.com?part=3D1
