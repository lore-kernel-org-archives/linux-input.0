Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015434;
	b=AxGom84yK/umtKyI2Ycd+PxJTelBB+8j2GQ9ATgUibOB2j46MS4509uR1PoNhUTEWE+r
	 hHUwtESGaFEV/rkPWEVGUm4BNLgTpwFPHATRCr4ghWPC9r/h+MloNSoldDWNRaet9I+jw
	 aIpR5Eqi/LEumMvaI9aTQx/1UUogOXFjl0CdxOmjKXjBHkfG9cFhr2qaB+6ctSJv6X3CK
	 zsVkKELOa9FXNK6EaTcsfttrGYpiQwBM9/DGXZB6fCM7qau0Zju1K5O75rZY32WuqLoyE
	 gXVFMoAiLTE+tn0kncB9tNIpvWt5P5mGFq6x9nZLJ3ciyoL/BwL4WwMkKOq2VmNcsqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015434;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=oKUUXTVJS/LFVlMihYz3ZWqF9UHg5n3wCBX0shTUj3s=;
	b=3zMwLeL6b4WyZcZnAi8S4+BS6G4t7jGk4KsJU4o2dnIa3CNdsXgOJVPWfAWDmmwRBwfC
	 iurJvVQQeYQDd0AwQ/2HiD1gcAnpz/nQ1+bNlbuvx06eNzLWI9uYLvbbp7ztp2c13obKQ
	 ELYWFF0RHqm2ablo5mCvD73grSIjIYu52pmQScmN9ikarwCNkK048r999jO13HADlcfes
	 oxcW9VyVV6V/NvXYPmmaCxnIT41kWpRlTk+bTHmAlCri3scZc8dP/SekfAvjFBdGAsoZo
	 Nh0iO8l3sbfhLy6JkzgtNThbhHuLRoIXYvi2tk0F9KYF62r2gXfdcK+pSSOzOYSPB+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UwezS82B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC94606A331;
	Wed, 18 Nov 2026 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UwezS82B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474E81F000C4;
	Wed, 18 Nov 2026 15:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795015434;
	bh=oKUUXTVJS/LFVlMihYz3ZWqF9UHg5n3wCBX0shTUj3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UwezS82BdpUqMBy6fK1UgkbsZuFIzeYBAHayDD/gHgjNKwteAV2kDw6lP/s8WB/NS
	 uFYMT3oyayM+8iacAsp3s09qOWnYngmh2Or5c2BtPU2iAPrb2Kq5YjwOv6X0LUlIG5
	 QD2BI7vedjejC0Kcb1nFhR1YuVhV8YJ4hIPKCj2Bhgz0zR4YGP2iNdVB46kZ/B8naV
	 gt66QUhOjmUbeK3Hqij0aZlR+oZWjXPajS9gXG8CUx808RdK0K6BmeSNbBTp9WmtWN
	 ujAQqkV2RVk2jF/Ir/CFHuarhIT7ypMfUzRRpHQWdiw7mULKhlA67SBziSrWogtWO1
	 s003oniKbOejw==
Date: Wed, 18 Nov 2026 15:23:46 +0000
From: Lee Jones <lee@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Val Packett <val@packett.cool>, Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v12 0/8] Add support for MT6392 PMIC
Message-ID: <20261118152346.GC98456@joneslee-macbookpro.roam.internal>
References: <20261105194426.1113050-1-l.scorcia@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105194426.1113050-1-l.scorcia@gmail.com>

On Thu, 05 Nov 2026, Luca Leonardo Scorcia wrote:

> The MediaTek MT6392 PMIC is usually found on devices powered by
> the MT8516/MT8167 SoC and is yet another MT6323/MT6397 variant.

[...]

>  .../bindings/input/mediatek,pmic-keys.yaml    |   1 +
>  .../bindings/mfd/mediatek,mt6397.yaml         |   6 +
>  .../regulator/mediatek,mt6392-regulator.yaml  | 112 +++
>  arch/arm64/boot/dts/mediatek/mt6392.dtsi      | 145 ++++
>  .../boot/dts/mediatek/pumpkin-common.dtsi     |  82 ++
>  drivers/input/keyboard/mtk-pmic-keys.c        |  18 +
>  drivers/mfd/mt6397-core.c                     |  97 ++-
>  drivers/mfd/mt6397-irq.c                      |   8 +
>  drivers/pinctrl/mediatek/pinctrl-mt6397.c     |  37 +-
>  drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h |  64 ++
>  drivers/regulator/Kconfig                     |   9 +
>  drivers/regulator/Makefile                    |   1 +
>  drivers/regulator/mt6392-regulator.c          | 764 ++++++++++++++++++
>  .../regulator/mediatek,mt6392-regulator.h     |  23 +
>  include/linux/mfd/mt6392/core.h               |  43 +
>  include/linux/mfd/mt6392/registers.h          | 488 +++++++++++
>  include/linux/mfd/mt6397/core.h               |   1 +
>  include/linux/regulator/mt6392-regulator.h    |  42 +
>  18 files changed, 1913 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h
>  create mode 100644 drivers/regulator/mt6392-regulator.c
>  create mode 100644 include/dt-bindings/regulator/mediatek,mt6392-regulator.h
>  create mode 100644 include/linux/mfd/mt6392/core.h
>  create mode 100644 include/linux/mfd/mt6392/registers.h
>  create mode 100644 include/linux/regulator/mt6392-regulator.h

MFD looks okay now.  How many more Acks do you need?

NB: This patch-set looks split in two in my inbox?

-- 
Lee Jones
