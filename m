Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9F2519925;
	Wed, 16 Sep 2026 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569077; cv=none; b=JNTyIOQT7BdMNih2SGYgz0eGL5XjtGMm+BEXeUcApm0b28ko9kswhhZ09jQt/Bo7Y7/qvR17rAfGiGGNqrzl2llxgcP8x26TNyILNvW/E4HOjbCMLP5Xj73VRbWNO4VmGPWeSg/8rCwyI+z4Iy/LT/u0gTmonPP+MTvDuZr3/Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569077; c=relaxed/simple;
	bh=lX4sBLQWCgzSTEPrUyTPOqD8/ta6vpCp3yXo4tlAwqk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uSImZDgbBG8DTm62FrnwCKy4JzmFql5oaPSw3jYTkVSTA+GfZstcWnaP6UvD7l6L/pcMKjY8eKQPyQgDNniRTUx3GxbXizmmke1i6cg6U6IrtsUVR51psX9mMtfyAEZYM+VEHnmklgjm7gyeaoJnTorpYHIJf5raGjPB5pBS4d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUQdrEG2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUQdrEG2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811EF1F000FF;
	Wed, 16 Sep 2026 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789569074;
	bh=MyHBmiyk0d26r4cuOXzwI2x+5zAzBC2ZsrXc1p/R3dI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cUQdrEG2wlUA2R34kh94j3mMU+jiP46BLyMyA4jn8nIx+pjABby1ANlRGZ3NHFadG
	 /JlrEqjQeQBuAl5LLffCOvaakJLNBjlU8eSt1J8dOVef97HA2u8ewM8cAh/Mww55Z4
	 gaSmZhfjYDwZxoiY+3wzTdqoBIR6j0J8Jj2RnQho0nBZFMHmFtUpYIrXPil92nfmp3
	 TD8F3PWfZXzmssU4c2ldZGOSi19rAI8JdfSMY27YGypVnqlA3UHbDgbYyIucrcQnoy
	 PIfdQZj7SSGViSDIG6f6wFjb23TsG+mPUnUbyBLP0jJZALs9PgmcYA1P63lByIy8lZ
	 a31/hTRLAES6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/19] dt-bindings: clock: qcom,rpmcc: Add MSM8952
 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org, lee@kernel.org, dmitry.torokhov@gmail.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, mfd@lists.linux.dev
In-Reply-To: <20260916-msm8952-initial-support-v2-12-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-12-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:31:13 +0000
Message-Id: <20260916143113.811EF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: missing qcom,rpmcc-msm8952 in allOf conditional block
--

commit 1a36458fc826545d7c948ae6e71fb8e460a8f8cc
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

dt-bindings: clock: qcom,rpmcc: Add MSM8952 compatible
   =20
Document the rpmcc found on MSM8952.

> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Do=
cumentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> index 17332aa558862..aa532f208f5af 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> @@ -56,6 +56,11 @@ properties:
>                - qcom,rpmcc-shikra
>            - const: qcom,rpmcc-qcm2290
>            - const: qcom,rpmcc
> +      - items:
> +          - enum:
> +              - qcom,rpmcc-msm8952
> +          - const: qcom,rpmcc-msm8976
> +          - const: qcom,rpmcc

[Severity: Low]
Should qcom,rpmcc-msm8952 also be added to the allOf conditional block furt=
her
down in the file?

The new compatible string is defined here, but appears to be missing from t=
he
explicit enumeration block under allOf:if:properties:compatible:

Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml:
          contains:
            enum:
              ...
              - qcom,rpmcc-msm8953
              - qcom,rpmcc-msm8974
              - qcom,rpmcc-msm8976
              - qcom,rpmcc-msm8992

Without it in this block, device tree schema validation for the new compati=
ble
string will be incomplete if a node uses it without the fallback string,
potentially allowing invalid clock configurations (such as the wrong number=
 or
names of clocks) to silently pass validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D12
