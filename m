Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793220383;
	b=vpDrSLHKNH8EeySAWOb72IgxLU40+zpIyh6y8yt1yArmwaoMA9aJIC30heSXGayWv9+c
	 y+Y4H4wesuq5qI2HBwpVYjQDPnBACCIWF4DReLnX98nKL/cOppW/KQvvJL659Jd3dZGnI
	 WyQIZMpZ5+afVam1aQK7qK2usXgZpQy9gLCs3DBSG8+cJiP5QuPzKbgm2e9MJacKL/n94
	 0urQCJQsA9wpiVKBXAXPUtn0fNIW/YW45a3vnE8ypOgWf5l0eyknzXLQpIjaHmIJL9cJ/
	 P2656xYBU3hvqeeOZvxPDshsEa7VvYfGzWOChptmj7wijxt35P9ik6yJC04+2EHCO6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220383;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bYZ0TmgU82LafTD+FJa7ZW97haFvOFiK4ELeE2u5l8k=;
	b=wP1ec0zu0TiDgrNmnpJNa66kocr5TVFFdVoAKEfzPU/mvhTo0lWbYPiReLkxhRK8Enqp
	 8jRKlp3He3ILUIeqxczxn8QKelIF23oNuxI4wn1oUSa4c4Thf+6QIvI7WwWOuNEq+GPlo
	 Z9QsxGMjVQXx7DMmnV4PMs/qb8LDFE8GqOlRdw0K7hleBuWO7DcV7e/hP98uF+fvJVcAu
	 VqbiF1N6W5dn0QQbbSdZYCXQAFG/vighqH02vMq0wSuHQVjPW0EBwitPZMt51xtx2vdDl
	 6CrY5DCXWcZAAptbm2jgVE7azhkFAOuPnJxZxhoCuiKMKZz4eQonHe6KDnnIcj88coQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PoODtIcY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C9B606A31D;
	Wed, 28 Oct 2026 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PoODtIcY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DE71F01825;
	Wed, 28 Oct 2026 20:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793220383;
	bh=bYZ0TmgU82LafTD+FJa7ZW97haFvOFiK4ELeE2u5l8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PoODtIcYfqAI0XtO0iN5FCWJFVwUKwyO63ywIY6RyG1bKYWiJxspnGJoiOgn+mr93
	 qERt7qrmYTyBCWwxaNNI6Lfaj1Vx9fFsOhv9wCxVLGrp3DBV9a1LOYZohRR9ywOO+y
	 1gvlSQMrSiQBb/kKb2K+XUMIqhsO9b3fTdrYXXRTnqw8ccqw7A6ojnbbAU6u+hSfPq
	 sBJtuwyeeAdeh/WKasgT5IWiclrOUhp7JRXE4/bdvDV7ExMWyQ9gg1ZF5ydXdZFOQU
	 tyMK0Wr2JsQyMGuZUGs0gnuAgZm9GFmDk6MEa4yZGg9ThoLnFrMUMwbZ8X1Qf/HJuw
	 xied03HLibqdg==
Message-ID: <sashiko-outbox-188445@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm7325-motorola-dubai: Add
 vibrator support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gergo Koteles" <soyer@irl.hu>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <89f7e6e9988c8744be37093777b0bc065a0e2ab8.1793218514.git.soyer@irl.hu>
References: <cover.1793218514.git.soyer@irl.hu>
 <89f7e6e9988c8744be37093777b0bc065a0e2ab8.1793218514.git.soyer@irl.hu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 20:46:22 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] arm64: dts: qcom: missing aw86224_reset_default in vibrator@58 p=
inctrl-0
--

commit 0c4fc157858ecc13c8cc7fb55e5af412993c27bd
Author: Gergo Koteles <soyer@irl.hu>

arm64: dts: qcom: sm7325-motorola-dubai: Add vibrator support

This commit adds the device tree node for the Awinic AW86224 haptic
controller on sm7325-motorola-dubai boards.

> diff --git a/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi b=
/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi
> index 3860ab8508a09..df2cb58e95d06 100644
> --- a/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi
> @@ -721,6 +721,17 @@ fsa4480_sbu_mux: endpoint {
>  			};
>  		};
>  	};
> +
> +	vibrator@58 {
> +		compatible =3D "awinic,aw86224";
> +		reg =3D <0x58>;
> +
> +		interrupts-extended =3D <&tlmm 47 IRQ_TYPE_EDGE_FALLING>;
> +		reset-gpios =3D <&tlmm 46 GPIO_ACTIVE_LOW>;
> +
> +		pinctrl-0 =3D <&aw86224_int_default>;
> +		pinctrl-names =3D "default";

[Severity: Medium]
Should pinctrl-0 in vibrator@58 also include &aw86224_reset_default?

The node consumes gpio46 via reset-gpios, and &tlmm in
arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi defines a dedica=
ted
pin configuration state for it:

	aw86224_reset_default: aw86224-reset-default-state {
		pins =3D "gpio46";
		function =3D "gpio";
		drive-strength =3D <2>;
		bias-pull-down;
	};

Without &aw86224_reset_default in pinctrl-0, this pinctrl node remains
unreferenced and the pinmux, drive-strength, and pull-down bias for gpio46
are not applied when the device probes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793218514.gi=
t.soyer@irl.hu?part=3D3
