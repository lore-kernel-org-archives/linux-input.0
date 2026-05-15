Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB9F188CC9;
	Fri, 15 May 2026 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778826292; cv=none; b=IZbxrtP6u7rLFPfUObxYjgL0PPtY3f9x5qBDClrraw89ou9ZcDKmJ5rtaA7htRpMviJ9c0F4Xhw0CyJtdNqAU+S8kzGfHPArLAaRLtaQufsTvRwWnB/Uke45iYp5ZfGWVqhEMRnRDSASacQXPK34LVdbGU7cIeGfisRGTwuHIOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778826292; c=relaxed/simple;
	bh=wobkoBQhSgvyGNYJS74WkcdJYDfXmH5gCb4hZhR18C8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IYpOMtx86jKiiJFhkF2tDtE+inEaGybSzG2Uqux4Ndtl6YgkO6T5SFB6duf5Cm1XCSLWSaUotlcg1jXYnQOLj5abbh8mK+C0p6siNgWonsIZyrAEdYIQrDILOt0o/W2JFPoHB3NUc1X0Iz1jjQZScE+v04J0k59ZHrJuVPmSirE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUt9gJMO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUt9gJMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F069DC2BCB0;
	Fri, 15 May 2026 06:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778826292;
	bh=wobkoBQhSgvyGNYJS74WkcdJYDfXmH5gCb4hZhR18C8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VUt9gJMO47Y9fuWRlBjuhx6APU/L7LuQtjhbBbAPSR4oQoFlGxIB3TfV2XTeq9A9J
	 o0RwMD9BgCCrzuoxl3l2iyXy1rHR2GfcGYBygRgu07/NsTqbNxKOHBxD+eW9GiBUJI
	 siVm3rquJXwEMY5LLUsT4Z8+hUjOTZAmZhAHhSct6Lo+5aC1UiBhpcNT74qyYCBF0A
	 jOmsUiuV7huhm96eydtEpUI2w03nDeJo/SPWmJ7T/2v2un8NM5n4Uw/QVDE0LABruC
	 SZbKi1vcloGduMeNf0VyBoCc6JFcRHO6M0TCo3D3kC69gDCFLE6KJBkbs72lCK5P/q
	 +tbxg9mLSne3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: hamoa: Add inline crypto for
 UFS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harrison Vanderbyl" <harrison.vanderbyl@gmail.com>
Cc: devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org, robh@kernel.org
In-Reply-To: <30c12b79c6cc481afb13ac93630c5a16bc856ae4.1778822464.git.harrison.vanderbyl@gmail.com>
References: <30c12b79c6cc481afb13ac93630c5a16bc856ae4.1778822464.git.harrison.vanderbyl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 06:24:51 +0000
Message-Id: <20260515062451.F069DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The mapped register size for the `ice` (Inline Crypto Engine) node=
 is too small, which will cause a kernel panic when Hardware Key Manager (H=
WKM) features are used.
--

commit d49e015ad1235b81d3dc9cb4256b44b206a03560
Author: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>

arm64: dts: qcom: hamoa: Add inline crypto for UFS

This commit adds the Inline Crypto Engine node and wires it to ufs_mem to
enable UFS storage encryption on x1e80100 and derivative SOCs.

> diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qc=
om/hamoa.dtsi
> --- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
> +++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi

[ ... ]

> @@ -3997,6 +3999,14 @@ opp-300000000 {
>  			};
>  		};
> =20
> +		ice: crypto@1d88000 {
> +			compatible =3D "qcom,x1e80100-inline-crypto-engine",
> +				     "qcom,inline-crypto-engine";
> +			reg =3D <0x0 0x01d88000 0x0 0x8000>;

Will this mapped size be large enough when hardware-wrapped keys are enabled
via the Hardware Key Manager (HWKM)?

When the qcom_ice driver initializes HWKM, it accesses registers at offsets
that appear to exceed the 0x8000 length provided here. For example, it acce=
sses
QCOM_ICE_REG_HWKM_TZ_KM_STATUS at 0x9004, and QCOM_ICE_REG_HWKM_BANK0_BBAC_4
at 0xD010.

Could reading or writing to these offsets cause a synchronous external abort
and crash the kernel since they fall outside the mapped memory region?

Should the size be expanded to cover the full HWKM address space, such as
0x18000, similar to the configuration on other HWKM-capable SoCs?

> +
> +			clocks =3D <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
> +		};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1778822464.gi=
t.harrison.vanderbyl@gmail.com?part=3D6
