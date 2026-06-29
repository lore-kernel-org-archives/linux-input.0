Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034AC3403EE;
	Mon, 29 Jun 2026 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748318; cv=none; b=LRuBgg/foPSQtAfwMGBOHtgYX32Q+ynqqy3tHcqXIPtz21p4//jbeTdbsQYOXogZ0YYhiDWUcCBrcSxWPaOeu4uXNigmBJayGS7T59nqU4qkHMpnnFeaUrcYunm7Mxrl4QLkyh31Q2LJujXpMonoCAFctGZkcuDN0P889WI+3vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748318; c=relaxed/simple;
	bh=NkSqXsCjFelI+fw0m730nbL+Y68+r9Ov6+K4pl4qoaA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hCG/ihQELocbpvsmZDL68+jM+OO92yhdRbyi1RWvV2nJutTykI0SAIO3GHcegbbGGzKEGIWaJSsk6wtbCKXEVNvssuptrB3SVNboBpmU+yyPgrT8guVUqHo3SMjml4BSIMxqgaK2VqcaboDVclHF3LJHLLyyYejQIW8wtqz2stU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPocfMEU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPocfMEU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6211F000E9;
	Mon, 29 Jun 2026 15:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782748317;
	bh=cMcHgc36aaJU0Nr7RRyNOjEsyz6bF5/W9plziuy9uws=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kPocfMEUYuMNe84xZZDYWtfO4m0SOtx7s/Wp7ICcWWqoGN1zL9e+D+YdUSO/UDmwD
	 PZzO4FMO2ScHMKS8p25Z65MJYD1ORoPTJD7nt4sGLBtxXRxW/bZQue9ECmf/HDI3iz
	 lfnnY2V5SIv0HIb0q4NP/OPYwhG2OJai3WgC9k5JSZtsJZYVuwOU+amtlAI7xhLUBB
	 vxwP+hpxCqI1M09qg/vVNt7mNjO3homFld20KjeBbaExljBFjfc2SC9Ssf5mysLUSn
	 Uhb+TZZ53DLlorbdHpoUSUe0DvQCKRje6YvtsDnZKz2Kbsd64qr/57gWoTNUXnbMmO
	 phfu3Yl2/CZwg==
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
Message-Id: <178274831392.2336627.18238595158174074345.b4-ty@kernel.org>
Date: Mon, 29 Jun 2026 23:51:53 +0800
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

Applied to sunxi/config-for-7.3 in local tree, thanks!

[1/6] arm64: defconfig: Enable Allwinner LRADC input driver
      commit: b4158103c45386ab30ba7624bee17ebf33940baa

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

