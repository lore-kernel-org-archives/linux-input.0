Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A8F3F9F2B;
	Thu,  9 Jul 2026 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598411; cv=none; b=ork8UBcQ3nRMmrHy1rYdQyhwcttySjqQ+cihv1iNzW6qdPQ+RoZtiZwTpYBKd66LwsMCb2C3aUJq2DaJZihENpItsQkJHOIaylbjnWHyodLglNXnHH64a347Wo2k1EUoA4cfYG4hvcGgOCe+MZZPSZ9kBGc5dKG9rdJ4hk5MhMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598411; c=relaxed/simple;
	bh=kwl0XOjYuU+yjnX9PrF2f8rc5CD9oTBprz5Zr74v+Nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5Ltrvs45+I11lgmDa8Hui5sOKtH+arWkNL+Cpx1j+8DxYWmcMYsIE4p0amFwiFLQ2hyfSd45denfiUgVnkT/NMEiNYp3YL9fdWb6wTirjhuhOqbXbFyzqUBe1XXLOOERiZPq0g5ibncvZJwZLkuzIyyDUMxd8EYnC/3B+JfWeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YXym7TbL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YXym7TbL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783598404;
	bh=kwl0XOjYuU+yjnX9PrF2f8rc5CD9oTBprz5Zr74v+Nk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YXym7TbLNL6bxTw0o78eEps3QhL7tbSUOFoHcANiMpU33OIpJygX/HfSf5wP/iki1
	 Xr5Sl8I09r/+FnVufmJBnBNbUAFHimcrCSYOWFGZ6NAwRXDclLGYasm4atXtMyAK/p
	 cg8GSG3XkBe1go9mXULwvruvq2aqBiD7fNIrXjBBT8JUs6fiqbWzcRZ/FFGBELKtgR
	 JJt1wmiCNRHK2V7K51OYIt3E+LZsXNzQQ5dEwQsNZ6+Mb9c2/h9mpCWuYyXCmWt6bE
	 L4NreGPSTptX7AY5tZdo4L+DXO25IrF2MbHD4wD1RaOC0uA5IXDxxH7oOUftQ64kO6
	 h0ptHSCLgYSqg==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5213717E019E;
	Thu, 09 Jul 2026 14:00:03 +0200 (CEST)
Message-ID: <0ae1db88-1dad-4f8b-a719-370c3aa8aaf4@collabora.com>
Date: Thu, 9 Jul 2026 14:00:03 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/9] Add support for MT6392 PMIC
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 linux-mediatek@lists.infradead.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Linus Walleij <linusw@kernel.org>,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Val Packett <val@packett.cool>, Julien Massot <julien.massot@collabora.com>,
 Fabien Parent <parent.f@gmail.com>, Akari Tsuyukusa
 <akkun11.open@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
References: <20260621081634.467858-1-l.scorcia@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260621081634.467858-1-l.scorcia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/21/26 10:13, Luca Leonardo Scorcia wrote:
> The MediaTek MT6392 PMIC is usually found on devices powered by
> the MT8516/MT8167 SoC and is yet another MT6323/MT6397 variant.
> 
> This series is mostly based around patches submitted a couple
> years ago by Fabien Parent and not merged and from Val Packett's
> submission from Jan 2025 that included extra cleanups, fixes, and a
> new dtsi file similar to ones that exist for other PMICs. Some
> comments weren't addressed and the series was ultimately not merged.
> 
> These patches enable four functions: keys, regulator, pinctrl and RTC.
> Mono speaker amp will follow later as I need to work further on the
> audio codec.
> 
> I added a handful of device tree improvements to fix some dtbs_check
> errors, added support for the pinctrl device and addressed the comments
> from last year's reviews.
> 
> Please note that patch 0006 and 0008 depend on patch 0005 as they need the
> registers.h file, but belong to different driver areas. I'm not sure if
> I'm supposed to squash them even if they belong to different driver
> areas of if it's fine like this. Any advice is welcome.
> 
> Patch 0009 also depends on patch 0003 because of mt6392-regulator.h.
> 
> The series has been tested on Xiaomi Mi Smart Clock X04G and on the
> Lenovo Smart Clock 2 CD-24502F.
> 

While series is

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Thanks!
Angelo


> Changes in v9:
> - Correct binding for vrtc as it does not support mode setting.
> 
>  From sashiko:
> - Added missing include in MFD documentation example.
> - Fixed constraints for regulator-initial-mode in regulator binding.
> - Fixed wrong register write while setting LDO standby mode.
> - Added missing pmic interrupt definition in the pumpkin-common include.
> 
> Changes in v8 [9]:
>  From reviewers:
> - Added example code to the MFD device binding, removed it from the
>    regulators docs.
> - Added minItems/maxItems constraints on the regulator mode definitions,
>    improved the mode constants.
> - Fixed formatting issues in the regulator binding.
> - Import the mt6392.dtsi file in pumpkin-common.dtsi, as it was originally
>    meant in [8].
> 
>  From sashiko:
> - Added more explicit constraints on the regulator modes definitions.
> - Use the appropriate modeget register for LDO regulators, Buck registers
>    don't have the corresponding register according to the data sheet.
> - Added the missing of_map_mode function.
> - Removed some debugging code that had no use and masked error codes.
> 
> Changes in v7 [7]:
> - Removed patch 0008 dependency on patch 0003.
> - Reintroduced the regulator driver. In earlier revisions of this series,
>    it was proposed to remove the dedicated compatible for the regulator
>    device [3]. The driver does not use actually it, but it is not possible
>    at this time to remove it from the bindings since it's a required
>    property.
> 
>    Making the regulator-required property conditional was NACKed in [5],
>    with the suggestion to create a separate binding altogether for devices
>    that do not require the compatible property. I tried implementing this,
>    but since the parent device needs to be declared as compatible with
>    mt6323, it leads to a warning in dt_binding_check since mt6323 would
>    be declared as a compatible in both mt6392 and mt6397.
> 
>    In the end the only regulator driver from the mt6397 documentation that
>    still declares an of_match is mt6397-regulator and it does not seem
>    to be necessary, so it should be possible to remove it and make the
>    regulator compatible optional for all regulators, but that change would
>    probably deserve its own separate patch series.
> 
> Changes in v6 [6]:
> - Dropped the regulators driver for the moment
> - Explained the FCHR key name origin in the commit message
> - Introduced the MFD_CELL_* macro in the sub-devices definitions.
>    A separate, independent commit introduced MFD_CELL_* to all the
>    subdevices in the mt6397-core.c file for consistency
> - Replaced of_device_get_match_data with device_get_match_data
> - Removed the mfd_match_data enum in favor of the preexisting
>    chip_id enum
> - Adjusted the error message if the device is unsupported
> 
> Changes in v5 [5]:
> - Double checked regulator driver with data sheet and Android sources.
>    The data sheet I have misses a lot of register descriptions, but
>    Android sources have been helpful to fill the gaps
> - Reintroduced the required attribute for the regulator compatible
>    in the bindings
> - Fixed the missing reference to the MT6392 schema
> - Fixed casts/unused vars reported by kernel test robot
> - Removed Reviewed-by tags from the regulator patches as they have been
>    modified in this version
> 
> Changes in v4 [4]:
> - Dropped usage of the regulator compatible
> - Fixed commit messages text to properly reference the target subsystem
> - Added supply rails to the regulator
> - Reworked the regulator schema and PMIC dtsi. Now all supplies are
>    documented and the schema no longer includes voltage information
> - Removed redundant ldo- / buck- prefixes
> - Renamed the pinfunc header to mediatek,mt6392-pinfunc.h
> - Modified the MFD driver to use a simple identifier in the of_match
>    data properties
> 
> Changes in v3 [3]:
> - Added pinctrl device
> - Changed mt6397-rtc fallback to mt6323-rtc
> - Added schema for regulators
> - Fixed checkpatch issues
> 
> Changes in v2 [2]:
> - Replaced explicit compatibles with fallbacks
> 
> Initial version: [1]
> 
> [1] https://lore.kernel.org/linux-mediatek/cover.1771865014.git.l.scorcia@gmail.com/
> [2] https://lore.kernel.org/linux-mediatek/20260306120521.163654-1-l.scorcia@gmail.com/
> [3] https://lore.kernel.org/linux-mediatek/20260317184507.523060-1-l.scorcia@gmail.com/
> [4] https://lore.kernel.org/linux-mediatek/20260330083429.359819-1-l.scorcia@gmail.com/
> [5] https://lore.kernel.org/linux-mediatek/20260420213529.1645560-1-l.scorcia@gmail.com/
> [6] https://lore.kernel.org/linux-mediatek/20260612200717.361018-1-l.scorcia@gmail.com/
> [7] https://lore.kernel.org/linux-mediatek/20260615071836.362883-1-l.scorcia@gmail.com/
> [8] https://lore.kernel.org/linux-mediatek/20190323211612.860-25-fparent@baylibre.com/
> [9] https://lore.kernel.org/linux-mediatek/20260620200032.334192-1-l.scorcia@gmail.com/
> 
> Fabien Parent (3):
>    dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
>    mfd: mt6397: Add support for MT6392 PMIC
>    regulator: Add MediaTek MT6392 regulator
> 
> Luca Leonardo Scorcia (4):
>    dt-bindings: mfd: mt6397: Add MT6392 PMIC
>    regulator: dt-bindings: Add MediaTek MT6392 PMIC
>    mfd: mt6397: Use MFD_CELL_* to describe sub-devices
>    pinctrl: mediatek: mt6397: Add MediaTek MT6392
> 
> Val Packett (2):
>    input: keyboard: mtk-pmic-keys: Add MT6392 support
>    arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi
> 
>   .../bindings/input/mediatek,pmic-keys.yaml    |   1 +
>   .../bindings/mfd/mediatek,mt6397.yaml         |  75 ++
>   .../regulator/mediatek,mt6392-regulator.yaml  | 112 +++
>   arch/arm64/boot/dts/mediatek/mt6392.dtsi      | 145 ++++
>   .../boot/dts/mediatek/pumpkin-common.dtsi     |   7 +
>   drivers/input/keyboard/mtk-pmic-keys.c        |  17 +
>   drivers/mfd/mt6397-core.c                     | 295 ++++---
>   drivers/mfd/mt6397-irq.c                      |   8 +
>   drivers/pinctrl/mediatek/pinctrl-mt6397.c     |  37 +-
>   drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h |  64 ++
>   drivers/regulator/Kconfig                     |   9 +
>   drivers/regulator/Makefile                    |   1 +
>   drivers/regulator/mt6392-regulator.c          | 764 ++++++++++++++++++
>   .../regulator/mediatek,mt6392-regulator.h     |  23 +
>   include/linux/mfd/mt6392/core.h               |  43 +
>   include/linux/mfd/mt6392/registers.h          | 488 +++++++++++
>   include/linux/mfd/mt6397/core.h               |   1 +
>   include/linux/regulator/mt6392-regulator.h    |  42 +
>   18 files changed, 1970 insertions(+), 162 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
>   create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h
>   create mode 100644 drivers/regulator/mt6392-regulator.c
>   create mode 100644 include/dt-bindings/regulator/mediatek,mt6392-regulator.h
>   create mode 100644 include/linux/mfd/mt6392/core.h
>   create mode 100644 include/linux/mfd/mt6392/registers.h
>   create mode 100644 include/linux/regulator/mt6392-regulator.h
> 
