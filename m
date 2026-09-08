Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8AB377A93;
	Tue,  8 Sep 2026 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851211; cv=none; b=phLIxzJxUJdBTgAMrd9JEIdy/egnfw8VkDHL9BFVkONs+H1LezMFstBQAA1hkRRHkfvHt7OGEAtDBkqp0Lp5dPlGwwl9u/0iDyL6qPnEEAssk9HLYH2dDiCfUrJyXDmOWicJIh9UHU5t1GhYem8W2C08r6Jh1szu/ZYB0Od662o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851211; c=relaxed/simple;
	bh=2fcrYPpUrtoB6BEGf24Voa6RfaHacqnigE3TyU9Q1Xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvD0agfcZzvMvJmBzeICMvGOtK7muK02WzkT+cvw/X8RAGGUCNWf+B25XvXGV+gg/u70d7er4tYs067wDQFVVKfMWcmbCs3EneJy5KZW08SlcwgLJQyOQL0AX5Emawo7VaD/7J1NRw5vfrH00OeVMTp7at/pYtwXnOlwZJ35f8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AuYiKfn0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AuYiKfn0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788851208;
	bh=2fcrYPpUrtoB6BEGf24Voa6RfaHacqnigE3TyU9Q1Xo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AuYiKfn0fFshNHjujbNbTmK8vwYckrWNao4X5pzLTRLRgxo52kqrKqTboQbrk/1dY
	 K0bGgkeV3bacBN67EbvGHlPKQZ8br0lJyQHvu18trECjyWww391KRicoGzD0P47Dhl
	 SiwZVU3ZoPe8ePQHem0z46ojf/Mf6yNsYglr2L3SL5Vmge00bUu1Oo7K8gF/epJc0V
	 YF1dG+do0ddmI/hBDpEWj7FkMB4WQLw6kGnkYNzRflg9sGorqNznC56sYVF9AfflBs
	 xOARzZ9uaVkk6HFnlwNmYhOYhJK8yj8uGVMTGWXY4LgV33ebdbq/7IzSwTnm4iRBCt
	 N/PD47J6x26UA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 964E817E0D43;
	Tue, 08 Sep 2026 09:06:47 +0200 (CEST)
Message-ID: <f8419831-8467-4d72-bbe9-d5b7c158cb22@collabora.com>
Date: Tue, 8 Sep 2026 09:06:47 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 9/9] arm64: dts: mediatek: Add MediaTek MT6392 PMIC
 dtsi
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 linux-mediatek@lists.infradead.org
Cc: Val Packett <val@packett.cool>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Linus Walleij <linusw@kernel.org>,
 Julien Massot <julien.massot@collabora.com>,
 Fabien Parent <parent.f@gmail.com>, Akari Tsuyukusa
 <akkun11.open@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mfd@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
References: <20260902193351.185771-1-l.scorcia@gmail.com>
 <20260902193351.185771-10-l.scorcia@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260902193351.185771-10-l.scorcia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/26 21:25, Luca Leonardo Scorcia wrote:
> From: Val Packett <val@packett.cool>
> 
> Add the dtsi to be included by all boards using the MT6392 PMIC,
> providing support for regulator, keys, pinctrl and RTC.
> 
> Import the new file in the shared device tree for the Pumpkin boards.
> 
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt6392.dtsi      | 145 ++++++++++++++++++
>   .../boot/dts/mediatek/pumpkin-common.dtsi     |   7 +
>   2 files changed, 152 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6392.dtsi b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
> new file mode 100644
> index 000000000000..cc4770d70246
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + * Copyright (c) 2024 Val Packett <val@packett.cool>
> + * Copyright (c) 2026 Luca Leonardo Scorcia <l.scorcia@gmail.com>
> + */
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/regulator/mediatek,mt6392-regulator.h>
> +
> +&pwrap {
> +	pmic: pmic {
> +		compatible = "mediatek,mt6392";
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +
> +		mt6392keys: keys {
> +			compatible = "mediatek,mt6392-keys";
> +
> +			key-power {
> +				linux,keycodes = <KEY_POWER>;
> +				wakeup-source;
> +			};
> +
> +			key-home {
> +				linux,keycodes = <KEY_HOME>;
> +				wakeup-source;
> +			};
> +		};
> +
> +		mt6392pio: pinctrl {
> +			compatible = "mediatek,mt6392-pinctrl";
> +
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};
> +
> +		mt6392regulators: regulators {
> +			compatible = "mediatek,mt6392-regulator";
> +
> +			/* Fixed supply defined in the data sheet */
> +			avddldo-supply = <&mt6392_vsys_reg>;
> +
> +			mt6392_vcore_reg: vcore {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_BUCK_MODE_FORCE_PWM>;
> +			};
> +			mt6392_vproc_reg: vproc {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_BUCK_MODE_FORCE_PWM>;
> +			};
> +			mt6392_vsys_reg: vsys {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_BUCK_MODE_FORCE_PWM>;
> +			};
> +			mt6392_vaud28_reg: vaud28 {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_LDO_MODE_LP>;
> +			};
> +			mt6392_vxo22_reg: vxo22 {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_LDO_MODE_LP>;
> +			};
> +			mt6392_vaud22_reg: vaud22 {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_LDO_MODE_LP>;
> +			};
> +			mt6392_vadc18_reg: vadc18 {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_LDO_MODE_LP>;
> +			};
> +			mt6392_vcama_reg: vcama { };
> +			mt6392_vcn35_reg: vcn35 {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_LDO_MODE_LP>;
> +			};
> +			mt6392_vio28_reg: vio28 {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_LDO_MODE_LP>;
> +			};
> +			mt6392_vusb_reg: vusb {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_LDO_MODE_LP>;
> +			};
> +			mt6392_vmc_reg: vmc {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_LDO_MODE_LP>;
> +			};
> +			mt6392_vmch_reg: vmch {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_LDO_MODE_LP>;
> +			};
> +			mt6392_vemc3v3_reg: vemc3v3 {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_LDO_MODE_LP>;
> +			};
> +			mt6392_vcamaf_reg: vcamaf {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_LDO_MODE_LP>;
> +			};
> +			mt6392_vgp1_reg: vgp1 {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_LDO_MODE_LP>;
> +			};
> +			mt6392_vgp2_reg: vgp2 {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_LDO_MODE_LP>;
> +			};
> +			mt6392_vefuse_reg: vefuse {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_LDO_MODE_LP>;
> +			};
> +			mt6392_vm25_reg: vm25 {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_LDO_MODE_LP>;
> +			};
> +			mt6392_vdig18_reg: vdig18 { };
> +			mt6392_vm_reg: vm {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_LDO_MODE_LP>;
> +			};
> +			mt6392_vio18_reg: vio18 {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_LDO_MODE_LP>;
> +			};
> +			mt6392_vcn18_reg: vcn18 {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_LDO_MODE_LP>;
> +			};
> +			mt6392_vcamd_reg: vcamd {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_LDO_MODE_LP>;
> +			};
> +			mt6392_vcamio_reg: vcamio {
> +				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_LDO_MODE_LP>;
> +			};
> +			mt6392_vrtc_reg: vrtc { };
> +		};
> +
> +		mt6392rtc: rtc {
> +			compatible = "mediatek,mt6392-rtc", "mediatek,mt6323-rtc";
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> index 805fb82138a8..b19d5792bd89 100644
> --- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> @@ -6,6 +6,8 @@
>   
>   #include <dt-bindings/gpio/gpio.h>
>   
> +#include "mt6392.dtsi"
> +
>   / {
>   	aliases {
>   		serial0 = &uart0;
> @@ -160,6 +162,11 @@ &i2c2 {
>   	status = "okay";
>   };
>   
> +&pmic {
> +	interrupt-parent = <&pio>;
> +	interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
>   &uart0 {
>   	status = "okay";
>   };
