Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969043DA28
	for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450833; cv=none; b=j6c+p4mfR3vcafX0r4tz/P+oeNkdnox9+3jWCnFXlZ7ht+GK+fE/bTplGGpwS0ZzjKPAJ2NNAopcvv97ghu7w7cVcoR2MlDuz4B931AqXdjhgUU4/9xtc7V403xiKR4saPhybqezR+FgiPpJ47u0eCa4zZjYVAipafv2K5BcQEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450833; c=relaxed/simple;
	bh=z3+Ivh2jCKhd8EuEEzRHJUPYWNvKLd1Q/rinjxIyM9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DK1Hk/kSJDtV3sm5ZgorCE4NW6eBkqoO6KblfptsNmbPR2/fCKBq/Pe2ZPV9OR/oxebNrbmA3Pf3hQ4Hx/B91Uq0vfwLpn1DaH9vuCFgHJEdPGsySmUZjkcQJZJIUnOCb2rj6739zlKXwPO+R7fT6Ll4fvEIbE7tiSbetiCfkuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e4o95Xdd; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e4o95Xdd"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so750352b3a.2
        for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 05:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786450831; x=1787055631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iDHJIqp5FLLywri4WBqUbQEMXacNkK0ILuDy9FjFATE=;
        b=e4o95XddhIuH8EX9nfVTvDTSIqGRI2lyBhnra/cplPNt20aNbeGQFWZ4WLFNH+O3/c
         SQ++UY95jGc978dyiksQlaGAMY8Op3Q+r/KvFzIugsjG9wRSsETm1bIHNilPp5385jBE
         oAb6XaDi3F9hOf3GjFy3Tp4vNLaIbYUTk+eOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450831; x=1787055631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iDHJIqp5FLLywri4WBqUbQEMXacNkK0ILuDy9FjFATE=;
        b=fewHFf0TX7Q9uJGvJYJPJdcK7dq8crSIy8qThGvr9NpWX01NpERs5vhLqnWxDuUepn
         9BWJ8kTyO2BH/s3IyMQlryiSvi9S0e+RpfExEsptFM3iNHv73nN0G8mXwOL118+trwLQ
         A3H1yHIWUUWtRZFGj6v0itNEYz/XSinMDfbzYqiPuxMPFSzJ+UI/6LcenFVWGl008aKX
         GhwHL64cYE3cJnzbK6jNbAXBRg2YkjbEex5V/g2c9vsbR2yxbhmkSc5Q4mh+tLAFvW3u
         gxGXT0xI9cTmuVQyWowBWknOI66h6eIKNUCQllR0fI1miAepU10Dgzk+6r31lmuoiMRA
         D/5Q==
X-Forwarded-Encrypted: i=1; AHgh+RpzjIYJXLfAqw56p6Vnh3sb93HqryOqB2ctyjwhlkxuoOfqyFQvPMbCa1pnIzGw57yDwNkyRscxFmYhQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRm6bw4nvTYKjitj0EIke+uSaYTCoMKu1Uj4GK+BFGg5WCXlut
	38sR8yyw8PU/YKuQlHo5B/1cFXYmz6M7fdHhg+C5dnYxrWt8PxvPKX1LQjIu6llFKw==
X-Gm-Gg: AR+sD12sVE7mw+AUnQgoA7u9XUUcXVUvCRyIC+SdfALpfgBTGMDofuRsfp/F2tLhfsg
	X4zAjuSl8BZ/rd8uvDvSdvZ/Q3CDzOAKBx6B5nSTeKAvCihqjhDTu0X7JwirgsQ30VLZI/ShHDA
	YZOg9YfQrJyzxpbn0pR9lK7VSzxcIGr+9uRJBY36TBEWrxF2tLsQj6x8a9js9M1HerzokdUWgnh
	p2VKroPZpc99TpFAa+uNxefiPD+EJvSbOofDFtmih/bVzd4qg1hEFhdJoqYSDm0h3/W31zarZS2
	mTHzNNUSIXKMvRSS2YNJS+j88BlDzpNGw2Rb4yYro975gdOMmLJRvuEfS1s2lmfTYhflG8uODVw
	emt4sPcTkFbdFgEsf+2Wycnug2ht3IFLoKxsx3cKmJvK0uP0gQ5CAKqm/2at2Tgjss3ImRB2VU8
	ZSPk6tX7Y8LjVMR+9qKu4WMeiNESGGrRBQ6rf3iWUU5QMqV4vJjs/CGzKq8WJjCqN45YFr8vwKr
	NKcPZ9e57xZljJYZWGUZb8YbavKabnMgP0116J/VCk6Ag==
X-Received: by 2002:a05:6a00:9286:b0:848:63c9:ee39 with SMTP id d2e1a72fcca58-84fa8842387mr2815346b3a.12.1786450831335;
        Tue, 11 Aug 2026 05:20:31 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:12e1:df26:6add:1ea7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa9574e9dsm662454b3a.54.2026.08.11.05.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:20:29 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/9] arm64: mediatek: Chromebook trackpad supply fixes
Date: Tue, 11 Aug 2026 20:20:00 +0800
Message-ID: <20260811122011.3539250-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This is v4 of my Chromebook trackpad supply fixes and optimization
series.

Changes since v3:
- Added __private modified to regulator_bulk_data.wait_us field and
  switched to ACCESS_PRIVATE accessor for the field (Andy)
- Moved wait outside regulator lock scope (Sashiko)
- Moved "remaining" value assignment closer to conditional (Andy)
- Fixed variable unit name in regulator_enable_and_wait() prototype
  (Andy, Sashiko)
- Added commit message section showing average delay needed for I2C
  prober (patch 6) (Andy)
- Link to v3:
  https://lore.kernel.org/all/20260721075226.2347933-1-wenst@chromium.org/

Changes since v2:
- Added new regulator "enable and wait" functions that wait until at
  least the given amount of time has passed since the regulator was
  last enabled.
- Converted patches to use the new functions
- New header inclusion cleanup patch for elan_i2c driver

This series fixes the trackpad descriptions on some MediaTek-based
Chromebooks: either the trackpad's supply was set as always-on to
workaround missing delays in the driver, or the delay and supply
are missing from the trackpad's device node.

v1 was just the first patch [1]. It has since grown to cover multiple
drivers and devices.


Patch 1 adds new "enable and wait" functions for single and bulk
regulator enable.

Patch 2 cleans up header inclusion for elan_i2c driver.

Patch 3 adds the correct enable delay after enabling the supply regulator
for the Elan trackpad to initialize. This uses the new "enable and wait"
regulator enable function.

Patch 4 applies the same logic of skipping the power on delay to the
i2c-hid-of driver.

Patch 5 applies the same logic of skipping the power on delay to the
i2c OF component prober library.

Patch 6 adds a delay between when the device node found is enabled and
when regulator_disable() is called. This gives an asynchronously probing
driver some time to increment the enable count of their regulator
reference, thus keeping the device operational and allowing the driver
to skip the initialization delay.

Patch 7 adds the correct delay for probing trackpads for Hana devices
to the ChromeOS OF component prober.

Patch 8 removes the "always-on" setting from the trackpad supply for
Elm / Hana and adds the correct delay to the second source trackpad.
This corrects the hardware description.

Patch 9 adds the supply and power on delay properties to the Synaptics
trackpad on the Spherion device. Combined with previous driver changes
this should cause no actual functional changes or delays.


Please take a look. Patches 3, 4, and 5 have build time dependencies
on patch 1. I suggest placing patch 1 on a separate immutable branch
or tag for the other maintainers to pull in. The three patches all have
different maintainers. Or if it's not too late, Mark could take patch
1 for v7.3-rc1 and the rest can go in later.

The DT changes must go in after all the driver changes land, especially
patch 3 that adds delays to the Elan trackpad driver. Otherwise the user
could potentially end up with a non-functional trackpad on the device.


Thanks
ChenYu

[1] https://lore.kernel.org/all/20241001093815.2481899-1-wenst@chromium.org/


Chen-Yu Tsai (9):
  regulator: core: Add "enable and wait" functions
  Input: elan_i2c - sort include statements
  Input: elan_i2c - Wait for initialization after enabling regulator
    supply
  HID: i2c-hid-of: skip post-power-on delay if powered on sufficiently
    long
  i2c: of-prober: skip post-power-on delay if powered on sufficiently
    long
  i2c: of-prober: Defer regulator_disable() on successful probe in
    simple helper
  platform/chrome: of_hw_prober: Add delay for hana trackpads
  arm64: dts: mediatek: mt8173-elm-hana: Unmark trackpad supply as
    always-on
  arm64: dts: mediatek: mt8192-asurada-spherion: Add Synaptics
    trackpad's supply

 .../boot/dts/mediatek/mt8173-elm-hana.dtsi    |  8 +--
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi  |  1 -
 .../mediatek/mt8192-asurada-spherion-r0.dts   |  2 +
 drivers/hid/i2c-hid/i2c-hid-of.c              |  9 ++-
 drivers/i2c/i2c-core-of-prober.c              | 25 ++++++--
 drivers/input/mouse/elan_i2c_core.c           | 23 ++++---
 .../platform/chrome/chromeos_of_hw_prober.c   |  4 +-
 drivers/regulator/core.c                      | 64 ++++++++++++++-----
 include/linux/regulator/consumer.h            | 21 ++++--
 include/linux/regulator/driver.h              |  2 +
 10 files changed, 105 insertions(+), 54 deletions(-)

-- 
2.55.0.679.g6767b8d81c-goog

