Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD61442C4F0
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248992; cv=none; b=tDwYOxcP4+JeWi2QtxjtziYYHlCGtuD0VzUZ0kdmLcHW3hOEwyhTGI6X9TxwQtV58RcUuLs1Oz0yw+szgjTqaYRRAUOnYyINyubnbRKQxvX5Mm9s4YDIvBR8bKO6SZO814S4BcYXJGPjB6A3sxMSfykYP8S5H5Wi5keSAU0ADpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248992; c=relaxed/simple;
	bh=KvANuwyiv8DCexxCu/aQYT4W/sj7Sy7QAkbUJMUn/G8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FFvnIbseYKcdt1X+1r+ILnLfhVA12ryeKaDj+EU5RMzfHnWP8B7MqxpnQDpWML/ofVNf0sak6PXl2pGahXkYH79LMfz9tpNI1UdeZWM4yIq2y78dG5ggJbHxSxLYtFuaJFMi9dkDUA0LINcItv94nw6OBfrNcTsOfoYZJfC6ANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H5ZhdL0i; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H5ZhdL0i"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d58efc7356so53314955ad.1
        for <linux-input@vger.kernel.org>; Tue, 01 Sep 2026 00:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788248990; x=1788853790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KfyZyO9Nh/74YiXm8QLieiH5kTcxaWjtqwY5nnPQU9w=;
        b=H5ZhdL0izP7LtUL3yM5sTR3c+XLps63TQhteyfJUdTaPMU0HHKvODr2xNDGR1dvr12
         g8GFCSGAaxpDDrEog5kLMvYs+SCmmfUhLMuWZ5/nZwVEWx208EVDeVmgP+/EAeuhpx7J
         gzSBoUfLxUohFdGJVyuCWvfzjOu9pjHJNDijE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788248990; x=1788853790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KfyZyO9Nh/74YiXm8QLieiH5kTcxaWjtqwY5nnPQU9w=;
        b=c7rM+cz0gg+C3oYlzsQ4DBJOmPOaQZj2FMWRm4IvguSNdV/VkV8DnyEws8lRBw42Lm
         gtP2362nif+vAAUKI+ezj3RQ+BveoTxbFXc2bxAL4ku8R6MPnh4m7vpqgY5+/8NY65G/
         eF8af2e6b5LClFMXWU62/gCD2iWEKevz1c7+clBS7ee44xuIu5uBsWv8smlhCxe2N+oY
         n9veoYtH5A4vsOz1QQHPRqLGf94cCp1QjSAC0lVFXleARSPdc4IWmvFm/4uqfNic4kM8
         uZNBzLguC06yby6dFTE3Deah3zU2n1LxpEYSGeFNwOyTIiK1SJbHX9W+jumoqd9dTnns
         xePw==
X-Forwarded-Encrypted: i=1; AKwUvBxDjsIdsKqkT7wvj7gSsl2ur38DDXuk8l3TgZTjdDVhpJ34KdirX9OZv0kN/xDwyUD4AJnkbxBghGU0wg==@vger.kernel.org
X-Gm-Message-State: AFuF++l4a6Eqya18hTUtjvV1Xvo1L10yNkny/3dCbf2cypB6o6MFKbu7
	SMmRDTv2bgFQqLVr+fKK16+T9YWv6IaJseGobgwIfo0zQZguD4ryxflEcpzraCPiQw==
X-Gm-Gg: AYBFou2wAowxVgRjMU7YO9o4LKatb9s/KJp1mEAhzdTnbqWoqelHk6wIZMObf3zmNL7
	NJvNux8MBsiqZivRcS/rqII0sZCtvQ/GOrN9ua4gmygRYeW3BOkOac55+tk9eh0v4FigIYMRSRT
	r/K5zjlvOPB6nbuT+s38P746bXHrOe8T+fdIHxVn8984ISnC0AYokPlkmh4AM2v+6JhIsCaZUd/
	r2JGeuWdr87CcSCDRuzX5piel1tiWuKGP5ZaL1VFQArp5IO4GQ8s4/O0J4LxZMwsIKvPotw3qBN
	ZF8qN0WXS9JungV72yHJgNdmKCQWdNDlo93N6qcy8RNou6nnncAMnBYwTvy3Sg/wM7A3672fs0L
	yNaQqJQSO+wnt3J4MEm/aPJJxl73UXxy8WZM256DKe4tV0Au3fdU0+rRHUR9TDjig1UbzLhT1j+
	RddrbNpsSiXgl4G7hbN/1azWgcRV9xIG6ialeqYOva6jEWUbg4ckTVyIsC+6Vesj2XC65cnldkD
	kbaDOA0fTedQXspsglxq3IxeNp8z07Hdt5boSFTRUU1YA==
X-Received: by 2002:a17:902:fdaf:b0:2d8:d4d0:792b with SMTP id d9443c01a7336-2d8d4d079a6mr348893415ad.15.1788248989697;
        Tue, 01 Sep 2026 00:49:49 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:8cf:6df0:9c4e:f5e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75988b699sm48142515ad.59.2026.09.01.00.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:49:48 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/8] arm64: mediatek: Chromebook trackpad supply fixes
Date: Tue,  1 Sep 2026 15:49:18 +0800
Message-ID: <20260901074930.764550-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This is v6 of my Chromebook trackpad supply fixes and optimization
series.

Changes since v5:
- Patch 1 (regulator)
  - Correctly assign wait_us to all bulk consumers (Sashiko)
  - Check _regulator_is_enabled() > 0 to check for enabled regulators
    (Sashiko)
  - Lock regulator_dev on final _regulator_is_enabled() check in
    regulator_register() (Sashiko)
  - Make it clear that _regulator_is_enabled_recursive() assumes that
    supplies have been resolved (local AI review)
  - Consider supply's last_on timestamp for regulators that are already
    enabled or have no .is_enabled() ops (local AI review)
- Added noautosel tag for some patches
- Added patch to pass component probe success or not to cleanup callback
  (patch 5)
- Only defer regulator disable if a device was found (patch 6)
- Link to v5:
  https://lore.kernel.org/all/20260825041628.988369-1-wenst@chromium.org/

Changes since v4:
- Made regulator core try to set last_on timestamp for regulators that
  were left on by reset default or firmware, but not enabled in kernel
- Dropped two patches that were merged
- Link to v4:
  https://lore.kernel.org/all/20260811122011.3539250-1-wenst@chromium.org/

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

Patch 2 adds the correct enable delay after enabling the supply regulator
for the Elan trackpad to initialize. This uses the new "enable and wait"
regulator enable function.

Patch 3 applies the same logic of skipping the power on delay to the
i2c-hid-of driver.

Patch 4 applies the same logic of skipping the power on delay to the
i2c OF component prober library.

Patch 5 makes the I2C component prober let the cleanup callback know
whether a component was found and enabled. Needed for the next patch
to only delay calling regulator_disable() if a component was enabled.

Patch 6 adds a delay between when the device node found is enabled and
when regulator_disable() is called. This gives an asynchronously probing
driver some time to increment the enable count of their regulator
reference, thus keeping the device operational and allowing the driver
to skip the initialization delay.

Patch 7 removes the "always-on" setting from the trackpad supply for
Elm / Hana and adds the correct delay to the second source trackpad.
This corrects the hardware description. Should not be backported without
the other driver patches.

Patch 8 adds the supply and power on delay properties to the Synaptics
trackpad on the Spherion device. Combined with previous driver changes
this should cause no actual functional changes or delays.


Please take a look. Patches 2, 3, and 4 have build time dependencies
on patch 1. I suggest placing patch 1 on a separate immutable branch
or tag for the other maintainers to pull in. The three patches all have
different maintainers.

The DT changes must go in after all the driver changes land, especially
patch 2 that adds delays to the Elan trackpad driver. Otherwise the user
could potentially end up with a non-functional trackpad on the device.


Thanks
ChenYu

[1] https://lore.kernel.org/all/20241001093815.2481899-1-wenst@chromium.org/

Chen-Yu Tsai (8):
  regulator: core: Add "enable and wait" functions
  Input: elan_i2c - Wait for initialization after enabling regulator
    supply
  HID: i2c-hid-of: skip post-power-on delay if powered on sufficiently
    long
  i2c: of-prober: skip post-power-on delay if powered on sufficiently
    long
  i2c: of-prober: Let cleanup op know if a device was found
  i2c: of-prober: Defer regulator_disable() on successful probe in
    simple helper
  arm64: dts: mediatek: mt8173-elm-hana: Unmark trackpad supply as
    always-on
  arm64: dts: mediatek: mt8192-asurada-spherion: Add Synaptics
    trackpad's supply

 .../boot/dts/mediatek/mt8173-elm-hana.dtsi    |   8 +-
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi  |   1 -
 .../mediatek/mt8192-asurada-spherion-r0.dts   |   2 +
 drivers/hid/i2c-hid/i2c-hid-of.c              |   9 +-
 drivers/i2c/i2c-core-of-prober.c              |  34 +++--
 drivers/input/mouse/elan_i2c_core.c           |   7 +-
 drivers/regulator/core.c                      | 129 ++++++++++++++++--
 include/linux/i2c-of-prober.h                 |   7 +-
 include/linux/regulator/consumer.h            |  21 ++-
 include/linux/regulator/driver.h              |   2 +
 10 files changed, 172 insertions(+), 48 deletions(-)

-- 
2.55.0.897.gb25b4bd76c-goog

