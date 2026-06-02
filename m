Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BD3280CE5
	for <linux-input@vger.kernel.org>; Tue,  2 Jun 2026 04:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780373427; cv=none; b=gKs4f7oW6RN+9nLLFTudcIF7TDGH4+XGv9Id1aPSLYpWDoLxF3TemgzkC9si24fDrvGOCZO6pG9XSC2/rhjJrdlHy8MimxgKXJ6CCcHxL+fEEpeQpe0kCb5Y7FobQMeAnjXNqhsoR8dmI836uWQDVZh3o6FNnFkwDPslbVP2PLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780373427; c=relaxed/simple;
	bh=NG296EPgL5vRoGxFIchwHcZK97kW7hHFNe7z2HaZtfw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p58VcagV3p51dYsFoqLfeUHurdp+vk87tJgIO42snEd0GFIfoxuybXUwqj6ctlsa5cA1ZSoCaRp/L4WVoimPnjDQ9xTovMgaCxv+rUUMBqfY0zS3HsiAtqmoqX32DYUnyxKmgjSYO3RcX2C6xZOo6/lwZndyp2k8zUIzZo8+m5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNTm44uK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNTm44uK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744F81F00893;
	Tue,  2 Jun 2026 04:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780373426;
	bh=eOiwYV7oXt08ESDvuNQxBdPI1/RHs0oG0OQg3cpPNto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JNTm44uKj3gz2C7BOkTXtMaCDKdpGGEUvnLB9ywipQadWmkIi88l8WW94d2YzspcN
	 O1XCvbCbEMumNe83wiFESGOjGA1noLuTFs6stG3K3/U5i71ix5b6o0IIMt7qeVPM/9
	 N3cGRp/Ry86hKyQ2t74Zy4WIEpTyO28OO8B1vL0vtxPTLcNKkA9o5hZdIomjpV2Eu4
	 ynGT6UCNyDgMQw3hhXL6S+vNn6N8IL8Mqgydxd63dA7Ot5qOeddZVWmhEimWo9nBrK
	 S7Vlwu0aZVF6IZbuD1psbBDAIpmaQaZI/xmgOB0FTIm0UxxJJVqXlF/Wc5mOorMAu/
	 0j+k45t7jniRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: xilinx_ps2 - replace in_be32/out_be32 with
 ioread32be/iowrite32be
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260602035907.623599-1-rosenp@gmail.com>
References: <20260602035907.623599-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 04:10:25 +0000
Message-Id: <20260602041026.744F81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Adding COMPILE_TEST exposes the driver to architectures without HAS=
_IOMEM, leading to build failures.
--

commit fa18055bb5a7f7464dd14a35a0c7198e7099cd71
Author: Rosen Penev <rosenp@gmail.com>

Input: xilinx_ps2 - replace in_be32/out_be32 with ioread32be/iowrite32be

This commit mechanically converts ppc4xx-specific accessors to generic port=
able
helpers. It also enables COMPILE_TEST for extra compile coverage.

> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> index 5f15a6462056b..60d886631c429 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -190,7 +190,7 @@ config SERIO_RAW
> =20
>  config SERIO_XILINX_XPS_PS2
>  	tristate "Xilinx XPS PS/2 Controller Support"
> -	depends on PPC || MICROBLAZE
> +	depends on PPC || MICROBLAZE || COMPILE_TEST

[Severity: Low]
Does adding COMPILE_TEST here expose this driver to architectures without
HAS_IOMEM?

Since the driver relies heavily on memory-mapped I/O functions like ioremap=
(),
ioread32be(), and iowrite32be(), allowing it to build on architectures that=
 do
not support MMIO (such as ARCH=3Dum) could result in build or linker errors=
.=20

Would it be safer to add a dependency on HAS_IOMEM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602035907.6235=
99-1-rosenp@gmail.com?part=3D1
