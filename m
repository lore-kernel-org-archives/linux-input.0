Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CD24FC331;
	Mon, 21 Sep 2026 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015844; cv=none; b=EhHyfnu+vIliELn85K69ouIQHPyMmlHOJwhrZzlV2RB+K+Yc5OeC1IYwx0daRejkFXumYFYcYDyohMN8f0PTpTwmKxLLf9kd6rPCjkfMLnkkn1CPwQei8v2oisW4Nk3IVEW+YSSlOM9AQAffptjBtNv1aFsGoCouYmEKDrn5aVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015844; c=relaxed/simple;
	bh=ndQUE6YHU2ixXOwk4QYgdxWp4lpHVDloKpYUcVkUmWg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rcBZIhZEBkVo12g450J4hlb1ANeGKdMVKVrhzQ8TgJ9C5wTsncyVn892IXuZRQGLjqkmJyloD6mBpuRC1k8Pc2Bt7CbZR+8pygfSxl60sl9dA3t1eeoPvqQ60U2ebCuDQx/kMNphRvv55WIGhfLELPwJyKs+mDXv9iWFdibd7s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eo57eAbt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eo57eAbt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6E31F000FF;
	Mon, 21 Sep 2026 18:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790015842;
	bh=ndQUE6YHU2ixXOwk4QYgdxWp4lpHVDloKpYUcVkUmWg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eo57eAbtiFX4ZzqmWE/Z33h3nunHgHkkZ6DQFtAnGAvAng8yIqNtM1bWC88ZPz2BD
	 YWVjEgVgCz9ZB/+nLKc4YqVxwoE9NNSqPZAGrG7ExgQaR728juur+h62BpqOMv2lLj
	 LLU3Hk3cXx4wDozjCECiyyh6dkc7nMggQRGvRFfydszEVDdjkEDlWqdZanI9yHiaXH
	 ZpGWNlapXzwnPunCyo5HhpUsTjn/HqsKyXIlQaAgKDYm8zmeab7U/kKQwGgHmqx7Nw
	 0zhJFmTjvbPFLISssFFV7cNzqKg/9Q2QV15Vr4aClz0FVnneTUa9q0YNejcVYsGVg3
	 nqAi4uCT9QZgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 19/19] arm64: dts: qcom: generalmobile-shamrock: new
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dri-devel@lists.freedesktop.org, dmitry.torokhov@gmail.com, linux-clk@vger.kernel.org, mfd@lists.linux.dev, conor+dt@kernel.org, lee@kernel.org, robh@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-19-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-19-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:37:21 +0000
Message-Id: <20260921183722.2F6E31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Add General Mobile Shamrock (GM 5 Plus). Shamrock is designed
> similar to L9300. Downstream reference is [1].
>=20
> [1] https://github.com/Asderdd/android_kernel_generalmobile_shamrock/blob=
/cm-14.1/arch/arm/boot/dts/qcom/msm8952-l9300.dtsi
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D19

