Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7518B35CBCB
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 06:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333182; cv=pass; b=Sb7IR07toUuXpfMehbMkTzNK2VHI0qIx63wEh396ZJ/KWiCjwGb0HqV/qYoaCxOiFV+rP3ORG03OwGnCfyHTp41RnDppbnCSaD6Amzwy7su2otAIw/yGl3EFrW0uCGLNt8wxGpeMuT7IPG8NDg1ufodp4O18IT+ulrccGIa9rFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333182; c=relaxed/simple;
	bh=tZfVoPBmk3Y21JvcgAvm0GaBLRd1bvbAe8InDftuxuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrljxH1ngGnPQt4Nh7F0FVmKTWtdtvtGIno3u/oDQXjLTvn7hA+CDgwPNjwzqg47v9PxlsJq1prOMo9oD5uy+DBL8pB++gvMe0Bs0pF8ICapX7mz560SZlfLrrANnkEMeCJLugG5S3yVCrdahhyLEx1ptB45cdbrhRugQDutBPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpDne2OE; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpDne2OE"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68cc6c7df99so2533390a12.1
        for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 23:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781333179; cv=none;
        d=google.com; s=arc-20240605;
        b=dCdjPZ29KR/GXyTArlnP/lXeeCU10oHnwDOvnWUlsYmq77sdGSSeHU41NYHo11D0+v
         6G4nPUlWZRozRkA99nZEgGXxYBX5VbR1Qub8As8KswW84B2OoGHjdEKNcIdgRxgHcZfm
         lMEXIFnpA/OJYkGcVbpKCQQkzVGoUUHJP4XPwjELKj6aVzSYXiuUCFb3gO0c5ps/npT0
         t4H9AwmGOA0gf1MEia5p8KBVaJay5cTBbkDc6H3rCOpkK8fuU7A2+zbHPXGEeU3pD6QF
         7zVXimsMHJGkh/5JyzycYQozaeICd/Msd087z1CHZqMLx8B1ImrKUgG20XT+4/Rj1C+F
         qhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=K3Zaw0q13XlwMt/D9vZ2oQHEjwluxKV2bQEyoZSCaZI=;
        fh=B/80t+a0DLod8ZvAKnB2Gp+v4tJU/IHZzO8ArFg5Z0Q=;
        b=J2qo05j7BiVo6ujyIjXTtuOJ7jgqfuXxMs8Zejxg/LgNLE91FsoPGG7RZYfulTBz8I
         sCtvmQ+QtfisHfd7fkigA1v90SI9OBTdZplgQXwh+xwLd2L8w9zwtIPQJYOJl2Yebc85
         Fz7ZXxSVVCfZC6myRGSd/J8zjHxC9GLtDfRwQjwk3YdGBI6fuRMPU9o/OWC9M+OYPiQF
         SIi2I4ztqtgaODkBh3Ygz1QhoJgV1XKQMaOpW3PnCUUHvAtmFUYiaBasTjBMjwXh4Ey0
         iIsLz1iLu/rMgZvtxYEwd3SMZeGvOVXk7peXh3pAolOXy7tHOjmX3wTygU77vdBieKDO
         +kRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781333179; x=1781937979; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K3Zaw0q13XlwMt/D9vZ2oQHEjwluxKV2bQEyoZSCaZI=;
        b=cpDne2OEqyWaMAImgAFndpx/Lm1DfkhxzFH6v1fGANkIktqCUiReeJUb/6kgSKVjDV
         pZ3B5VcxPnVgtoG3hTn8qE6G4waLNaP38AEaKqv7oYY+P3CSW36ZLJDlPFARqgHsJXjY
         Yj7BaL5hvmsDD1uRV7k3v19T9S1tcWaXp/U+f2R3msr6hcGwetXvdCZLnhfbBs6UPGwI
         SygYaDbHjnIXPC826gOC5MTK8R2b5PVE4scUpKNEjnUtzQtO/yq6nH6ooMo9bnSXgxsO
         QW/pR4d8VIdoIKjE1uCy1NIi4v8LQiNJ4DW8Zdsd1HkfVqSlUbYfsaKCM5P5Qk4c7Q7Y
         B/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781333179; x=1781937979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3Zaw0q13XlwMt/D9vZ2oQHEjwluxKV2bQEyoZSCaZI=;
        b=lXKvqKTN1cDAMy3lXVylLeeCIE1CUBSp+gjaVaxNxVFvsF11TMCkoYQgPQ9zIYv16Q
         hxKkoVwPyQWQmN8PNAhsClDNklBbl8SH9VEiI8UMeBxM/52Alpt6rlkUuW1HQybTbJ5v
         krKRkUefy3GJH3fn9F/txkT+n0Cf0fy8YLPZnPMjn3UZvCjXlNnzpqf3nNTP22L8+s0l
         kg7PbT/E+TlKG+o0PsJaDHZTv9DOZeTCzOAK2ec0dGKnTC2UCIGH+NGTmLz9yYzGMJkL
         sYd44ffKLWta/2E87bLzkBwyBUbuW+nQXuaj67CpdXv/uZm+8JTeNbAX5L9gkZyDjw8q
         dY2Q==
X-Forwarded-Encrypted: i=1; AFNElJ8U2aWomvT2z+HppIqt4tWkcIJIPxXbfjl6aWwu/D5tm2Qq9wx8PXPlw3+hsb2fFrJDWAwOgp7JopDY7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMtKY9yfpbHlldyUQPEYZDnBXS5tIGmLJY8UVdi22N6NvzDPj3
	zHyZyxYf3BT2zkRVp0R0dRgm71run5u3bXCfSOtgbaNtqY9cPpSV8aQfGkeHYQPY/wZcGuQfZU+
	q9iWHf7PPylA5iIjtibTmK8122aVDLyk=
X-Gm-Gg: Acq92OFM05bafNmGVn/jCvWF32sZusVcRd0idfg/48Nhc4Ih6WjrLvsZiYRBy/e7jEK
	KSCZB5YZN7EsuAd/L+vF7bAFYgehf6rWNbx0bzavfi8rRJst2sgcLYBOlbMDAjDSX0yWsVogsXT
	KfwqeMLTFfxfAq8WWLqVAzco85BlJV/n6FrK2J0BTd72gxYpfhvNrZWxqyyJ1WU59/R/hQt1aXe
	flevsDqyFW7aJgcW+oOh8G76yCabzPKg3gEeYsvQMYli5RUb13aJGJxII2loJ7sz8aLj3RVeWjJ
	x09aAf8XtgF2D3rh18KCe4uoe6PeuCIJJCC15mc=
X-Received: by 2002:a05:6402:11d2:b0:691:956a:cf64 with SMTP id
 4fb4d7f45d1cf-693785f9535mr2788429a12.12.1781333178678; Fri, 12 Jun 2026
 23:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612200717.361018-1-l.scorcia@gmail.com>
In-Reply-To: <20260612200717.361018-1-l.scorcia@gmail.com>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Sat, 13 Jun 2026 08:46:07 +0200
X-Gm-Features: AVVi8CeFuX_UIHrrQxcpZMFblszx1DO_NPnUuKDdU-CWG2K7N00GECZfmMGjMUg
Message-ID: <CAORyz2Jv70NuKNJbaG6o9Evm+3LcCpq+6qmOp_3Q=vf2CFCQ8Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] Add support for MT6392 PMIC
To: linux-mediatek@lists.infradead.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>, 
	Julien Massot <julien.massot@collabora.com>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Val Packett <val@packett.cool>, 
	Fabien Parent <parent.f@gmail.com>, Akari Tsuyukusa <akkun11.open@gmail.com>, 
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Please ignore this patch set. As correctly described by sashiko-bot,
the binding with no regulator node would not be usable, even if it
passed dtbs_check. I need to complete work on that and then resubmit.
Sorry about the confusion.

Il giorno ven 12 giu 2026 alle ore 22:26 Luca Leonardo Scorcia
<l.scorcia@gmail.com> ha scritto:
>
> The MediaTek MT6392 PMIC is usually found on devices powered by
> the MT8516/MT8167 SoC and is yet another MT6323/MT6397 variant.
>
> This series is mostly based around patches submitted a couple
> years ago by Fabien Parent and not merged and from Val Packett's
> submission from Jan 2025 that included extra cleanups, fixes, and a
> new dtsi file similar to ones that exist for other PMICs. Some
> comments weren't addressed and the series was ultimately not merged.
>
> These patches only enable three functions: keys, pinctrl and RTC.
> Regulators and speaker amp will follow later as I still need to further
> improve those two, but getting the main PMIC in will make the series
> easier to review.
>
> I added a handful of device tree improvements to fix some dtbs_check
> errors, added support for the pinctrl device and addressed the comments
> from last year's reviews.
>
> Please note that patch 0005 depends on patch 0004 as they both need the
> registers.h file, but they belong to different driver areas. I'm not sure
> if I'm supposed to squash them even if they belong to different driver
> areas of if it's fine like this. Any advice is welcome.
>
> The series has been tested on Xiaomi Mi Smart Clock X04G and on the
> Lenovo Smart Clock 2.
>
> Changes in v6:
> - Dropped the regulators driver for the moment
> - Explained the FCHR key name origin in the commit message
> - Introduced the MFD_CELL_* macro in the sub-devices definitions.
>   A separate, independent commit introduced MFD_CELL_* to all the
>   subdevices in the mt6397-core.c file for consistency
> - Replaced of_device_get_match_data with device_get_match_data
> - Removed the mfd_match_data enum in favor of the preexisting
>   chip_id enum
> - Adjusted the error message if the device is unsupported
>
> Changes in v5 [5]:
> - Double checked regulator driver with data sheet and Android sources.
>   The data sheet I have misses a lot of register descriptions, but
>   Android sources have been helpful to fill the gaps
> - Reintroduced the required attribute for the regulator compatible
>   in the bindings
> - Fixed the missing reference to the MT6392 schema
> - Fixed casts/unused vars reported by kernel test robot
> - Removed Reviewed-by tags from the regulator patches as they have been
>   modified in this version
>
> Changes in v4 [4]:
> - Dropped usage of the regulator compatible
> - Fixed commit messages text to properly reference the target subsystem
> - Added supply rails to the regulator
> - Reworked the regulator schema and PMIC dtsi. Now all supplies are
>   documented and the schema no longer includes voltage information
> - Removed redundant ldo- / buck- prefixes
> - Renamed the pinfunc header to mediatek,mt6392-pinfunc.h
> - Modified the MFD driver to use a simple identifier in the of_match
>   data properties
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
>
> Fabien Parent (3):
>   dt-bindings: mfd: mt6397: Add MT6392 PMIC
>   dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
>   mfd: mt6397: Add support for MT6392 PMIC
>
> Luca Leonardo Scorcia (2):
>   mfd: mt6397: Use MFD_CELL_* to describe sub-devices
>   pinctrl: mediatek: mt6397: Add MediaTek MT6392
>
> Val Packett (2):
>   input: keyboard: mtk-pmic-keys: Add MT6392 support
>   arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi
>
>  .../bindings/input/mediatek,pmic-keys.yaml    |   1 +
>  .../bindings/mfd/mediatek,mt6397.yaml         |   8 +
>  arch/arm64/boot/dts/mediatek/mt6392.dtsi      |  41 ++
>  drivers/input/keyboard/mtk-pmic-keys.c        |  17 +
>  drivers/mfd/mt6397-core.c                     | 294 +++++------
>  drivers/mfd/mt6397-irq.c                      |   8 +
>  drivers/pinctrl/mediatek/pinctrl-mt6397.c     |  37 +-
>  drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h |  64 +++
>  include/linux/mfd/mt6392/core.h               |  43 ++
>  include/linux/mfd/mt6392/registers.h          | 488 ++++++++++++++++++
>  include/linux/mfd/mt6397/core.h               |   1 +
>  11 files changed, 840 insertions(+), 162 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h
>  create mode 100644 include/linux/mfd/mt6392/core.h
>  create mode 100644 include/linux/mfd/mt6392/registers.h
>
> --
> 2.43.0
>


-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
