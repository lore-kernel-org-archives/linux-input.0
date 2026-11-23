Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433159;
	b=YBPFLwSg8Bm6YDPI975vt33U+yoVHvrzahxQLsyQNu+OUT8mRCJnT4wcBNOQSlgkmOiq
	 oX4pS3E0XUhr/1dQDcn6XPFutLycZ7HNAvA3mZlQ4Qsa8yFAyS3EyYZthBQrHCcAh16vQ
	 BMiHXXJ5EmGdM40jm8aNQQaDXUIYEUo3LjTzeM6uHpYZM4zLuCQS0i4gwZ2TZZGaGVuA0
	 WMBbcLH1s32/Anvm2+C7M516MoMYU2KovIX/sj4rQm0v/XlBSdRvsBccn4125MB0zx4+u
	 NirEnSmxGa5AXUMPLXIZBZEALDSdBLLnfVPeiuY9vtJc0kH3PNvB+n0BrhY89Yin+7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433159;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BPsht/5iEQfOrJQkEqh/BYL6rcKpiFRPvBgpI9YBkWw=;
	b=OMvFswPRbRr15qnISMf79ErwU4XcRUdj6arhu0bqwnzJrfV1CSReTgETWvW3XDSFwMAt
	 XCwp40uSl5dlaM1c+/hW6C+u+GgVDvwmk+yIp6Stvv6WZKpK6+OmDTfAu3Jme2vnea6X7
	 dOU45r39qSyeQa7S++n2kJYfrHggv3WTlBdhglVe6AzcgcG6/dxQeiw29lQWBGHN6s9R3
	 ZoSJPNnnPh+Cid5uZdGuCtppfMv20kHokEOgTpxiywv3oA0P/+eJDyRPppwS3VxyLHQ1e
	 sDdAiKwhWpCY3dDWfcdmX+bEupBQZrDaQpx5XdenNWEhooaxe6vv9eJEdPfxNLpoEsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRMUncjP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49C5606A31E;
	Mon, 23 Nov 2026 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRMUncjP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038571F00A36;
	Mon, 23 Nov 2026 11:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795433159;
	bh=BPsht/5iEQfOrJQkEqh/BYL6rcKpiFRPvBgpI9YBkWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jRMUncjPzShYgUHPBOpyHICKE0J9p8mOiEj+JF34NBhjnVFJfXiXVCS0gbjYN6tJI
	 dsAN4h43e3Mn4Eh6hag0qEp5Xkt3HiZw2sLBC+F57l1rNrz7I4bk5QmG/FnoPFRWbe
	 sId2/CQXb+fRC1QDuuzssJZzGI5LJLJVzG++w+5BDXYJcpaOWyNKWwwVyIMkg5+T2v
	 bTlDBmoy6wfvUxGyd7zDklgD20wx8hVV5qj1qCGcK6AqUp+hZaOZOiSAf0jqTfBrxa
	 wnPFVXAabP6bAZ6U7jk79QNT5K58dA/RUxO2l2HXDApcjmPXenOO/DSnUaNSPWD/sR
	 /RvFvmj71ctWw==
Message-ID: <sashiko-outbox-229131@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/7] arm64: dts: mediatek: Add MT6895 SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Letuchiy" <asalde.le1@gmail.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261123-initial-mt6895-v3-6-95c46597e63d@gmail.com>
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
 <20261123-initial-mt6895-v3-6-95c46597e63d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 11:25:57 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] arm64: dts: mediatek: mt6895: missing EL2 virtual timer
  interrupt in timer node
--

commit 52307c1c986494baf205914bdd46826de40efb27
Author: Alexander Letuchiy <asalde.le1@gmail.com>

arm64: dts: mediatek: Add MT6895 SoC

This commit adds initial devicetree support for the MediaTek MT6895 SoC,
describing its Cortex-A55 and Cortex-A78 CPUs, caches, GICv3, PMUs, timers,
pin controller, UARTs, watchdog, and keypad.

> diff --git a/arch/arm64/boot/dts/mediatek/mt6895.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt6895.dtsi
> new file mode 100644
> index 0000000000000..62584cec0f4fc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6895.dtsi

[ ... ]

> +	timer {
> +		compatible =3D "arm,armv8-timer";
> +		interrupts =3D <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
> +	};
> +};

[Severity: Low]
Should this timer node also include the fifth PPI (<GIC_PPI 12
IRQ_TYPE_LEVEL_HIGH 0>) for the EL2 virtual timer?

Cortex-A55 and Cortex-A78 implement FEAT_VHE, so when Linux boots at EL2 in
VHE mode without the fifth interrupt entry, arch_timer_select_ppi() logs a
FW_BUG warning ("VHE-capable CPU without EL2 virtual timer interrupt") and
falls back to the EL2 physical timer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-initial-mt=
6895-v3-0-95c46597e63d@gmail.com?part=3D6
