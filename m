Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660663BB12B;
	Thu, 30 Jul 2026 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441391; cv=none; b=VeloBzbgp3p0FRcFgEv/NiI+czgatKvEYq03mlb+Cab3jnV3DR7smFxoZIwIFYDj1hxW+sGNzRw77PKagq3o6xbRvTten8cfC1iudYsuycX52wsm+AkBggNJ03NMZa81C+16AxCquDAWauZPKnB5aTNvLlMfqVcmG+xaw8yZhv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441391; c=relaxed/simple;
	bh=MjweQq5tF7+aV2H92HbS+alyy3INR+JelS68rSdVffo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mQkk//7xz9a+YSV2Rv2BIKAwOpwglbof6y5gdrSyE+zHRqTsKM+0kMqfEscojnnk7P+5i+CzgT7o+AxzFYL4QDhrIZBvJVV9Zfy5AwQdL4hDoozZ20EaqwL5MYVlkFyDQ3oQ8oXLNQ10+GUVK/MCZyCn9gPFUeRCaaA2CG/WVsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNtFZvHm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNtFZvHm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A364B1F00ACF;
	Thu, 30 Jul 2026 19:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785441390;
	bh=PgXoFcswMRVXVADSDN8S4WQLEM5txMyGsLMFiguvwPc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LNtFZvHmzZ6xChtojVnPyORy0OmZzmEhqk7W6BMTqUrjYAs20aRoocSuPIohQAp9g
	 nVz53k8vaqzkvb/PDE0AfTskJ34eIQ9dx90FdLvXYz67qraKVar/4CbqpK3NM+phx0
	 NxR+UvKJqOj07OtcT+DC0W13aKYr8iDD9TehYSRrc+IdWaQFezoOK52m7fIMKw4NXl
	 4NLKbaGTfbIHe9503lxWogEm8IHinM/wBcrIELD8EHsKOWoiDnQcHP8CEEmXhfpcn5
	 VUAaNiEkQG7s6uPIH8MBJnC98Wze7WTvxhAqBZ0vl62iL0hKA+hEsT2Lu6S1bfrHH2
	 TrDcWoitS1hJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: input/ts/zinitix: document mode 0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: linux-input@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260731-zinitix-modes-v2-4-ffe2ec9a9031@disroot.org>
References: <20260731-zinitix-modes-v2-0-ffe2ec9a9031@disroot.org>
 <20260731-zinitix-modes-v2-4-ffe2ec9a9031@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 19:56:29 +0000
Message-Id: <20260730195629.A364B1F00ACF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition during probe where the input device is registered b=
efore device properties are fully read, leading to a state mismatch and a N=
ULL pointer dereference crash.
--

--- Patch [4]: [PATCH v2 4/5] dt-bindings: input/ts/zinitix: document mode =
0 ---
commit 68cae6b2efa127f7ca443fe7f4819ab411c887fb
Author: Kaustabh Chakraborty <kauschluss@disroot.org>

dt-bindings: input/ts/zinitix: document mode 0

Zinitix touchscreens support three modes, numbered 0 to 2. This commit
adds mode 0 to the devicetree schema as it was previously unmentioned.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/zinitix,=
bt400.yaml b/Documentation/devicetree/bindings/input/touchscreen/zinitix,bt=
400.yaml
> index f1ce837b16dfa..9b51212ea9b97 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/zinitix,bt400.y=
aml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/zinitix,bt400.y=
aml
> @@ -76,9 +76,9 @@ properties:
>    zinitix,mode:
>      description: Mode of reporting touch points. Some modes may not work
>        with a particular ts firmware for unknown reasons. Available modes=
 are
> -      1 and 2. Mode 2 is the default and preferred.
> +      0, 1, and 2. Mode 2 is the default and preferred.
>      $ref: /schemas/types.yaml#/definitions/uint32
> -    enum: [1, 2]
> +    enum: [0, 1, 2]

[Severity: High]
This is a pre-existing issue, but does adding mode 0 highlight a race=20
condition in the driver's initialization sequence?

Looking at drivers/input/touchscreen/zinitix.c, the input device is=20
registered before the properties are read:

drivers/input/touchscreen/zinitix.c:zinitix_ts_probe() {
        error =3D zinitix_init_input_dev(bt541);
        if (error) {
                ...
        }

        error =3D device_property_read_u32(&client->dev, "zinitix,mode",
                                         &bt541->zinitix_mode);
        ...
        switch (bt541->zinitix_mode) {
        case 0:
                bt541->read_point_status =3D zinitix_read_point_status_mode=
0;
                break;
        ...
        }
}

If userspace rapidly opens the device (e.g., via udevd) right after
zinitix_init_input_dev() is called, zinitix_start() will run and call=20
enable_irq().=20

If an interrupt fires before probe() reaches the switch statement and assig=
ns
the bt541->read_point_status function pointer, could this result in a NULL=
=20
pointer dereference in the interrupt handler?

drivers/input/touchscreen/zinitix.c:zinitix_ts_irq_handler() {
        ...
        error =3D bt541->read_point_status(bt541, &touch_event);
        ...
}

Should the property reading and function pointer initialization be moved
before the input device is registered to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-zinitix-mo=
des-v2-0-ffe2ec9a9031@disroot.org?part=3D4
