Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF30542B74B;
	Mon, 29 Jun 2026 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749317; cv=none; b=VQ/qmD7uceY7Sfnm/iYjZCQV3e9gLNqqj1IRxmp+jlviSthCDPEImLTUnMWqmkHP4FpIVuExmchTMSrxFcjODavXtAvQsVR4QC9tZsxZahwDfUj8h6/2ouDGYXk2Z1ExJJNEKrfeAGbyDpwHXq8APFCIt5bfqK3s7N0K1EwuXF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749317; c=relaxed/simple;
	bh=kKN+r0+IYhxuP7LbdslsAozFCufY+MpyzK6no63SVdc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M2RZfQjx9/WUgRLNYxrcEinAF9wz0R2xQPNS27iQL2OA06qB5QHIP+clQAvI8AefIaWA1HxLBissU3pnT8HbOU2LhyCEGer9tL6dhz5WCOPhNZ2KISuIBiVEmRfJ4+HvMeVfcx68+jVHpHyalL4gUEEV2pCYT9w7244euVndO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ3JsP62; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ3JsP62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6551F000E9;
	Mon, 29 Jun 2026 16:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782749316;
	bh=FEfPPsM3jAKLcsijf/AG4TNyIA2dGpwBNq8rgEHqEis=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OQ3JsP621KGe/TOc4kdvokUJw6kAgo20QUzkiEX1kd066aIXDElMGmCie7KItne4g
	 qIo2Vl+qI3bWkQR4A8IUI5PSU9OoefyKUJIm+6erQBV74LG7ZPqvcrxc6aAg2Zaws6
	 DtORRJQEY1q3YSu5m/4+DJgyg/7RjwJX7fx6fJNnpqs131GqGXLXau0IblZ0OU+Ow5
	 Cfv7mvZxBIyrK0BcTv2CxCCxL2lMHnVmx2SuYzz9+B3nHHdGptuygCIqXGefNt+c4n
	 Qr4T6//BZRikzNhijn44GWvSkHxO0nwTRx4LcTdvf3DP0A9NspA/WMJJK6nLKWUmJa
	 LreGiTOC/9+0Q==
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Alexander Sverdlin <alex@sverdlin.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Hans de Goede <hansg@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, Jun Yan <jerrysteve1101@gmail.com>, 
 Lukas Schmid <lukas.schmid@netcube.li>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>, 
 Eric Biggers <ebiggers@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Luca Weiss <luca@lucaweiss.eu>, Sven Peter <sven@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260623204824.691832-1-alexander.sverdlin@gmail.com>
References: <20260623204824.691832-1-alexander.sverdlin@gmail.com>
Subject: Re: (subset) [PATCH v5 0/6] Add support for Baijie Helper A133
 board
Message-Id: <178274931239.2343857.3591668827233792429.b4-ty@kernel.org>
Date: Tue, 30 Jun 2026 00:08:32 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 23 Jun 2026 22:48:12 +0200, Alexander Sverdlin wrote:
> Baijie Helper A133 board is a development board around Baijie A133 Core
> SBC. Features:
> 
> - 1/2/4GiB LPDDR4 DRAM
> - 8/16/32GiB eMMC
> - AXP707 PMIC
> - USB-C OTG port in peripheral mode (via onboard hub)
> - 2 USB 2.0 ports
> - MicroSD slot and on-board eMMC module
> - Gigabit Ethernet
> - Bluetooth
> - WiFi
> 
> [...]

Applied to sunxi/dt-for-7.3 in local tree, thanks!

[2/6] dt-bindings: vendor-prefixes: Add Shenzhen Baijie Technology Co., Ltd.
      commit: c3600c97eb9c1a20a933a7fba08272955f7a7ccc
[3/6] dt-bindings: arm: sunxi: Add Baijie HelperBoard A133 compatible
      commit: 1d81cb06c30746448deb73b6ce9ceccc9fb6ca37
[4/6] dt-bindings: input: sun4i-lradc-keys: Add A100/A133 compatible
      commit: 5e5e8a2e5a5e31fbe8858f08ef7ac44dff9ee351
[5/6] arm64: dts: allwinner: a100: Add LRADC node
      commit: 8fa3a2bf77f0adb5440f25c3e2951543691e1536
[6/6] arm64: dts: allwinner: A133: add support for Baijie Helper A133 board
      commit: 7204944dcb8f1131b6303a5e9ca11128eb20ac21

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

