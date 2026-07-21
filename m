Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D4741737C
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620444; cv=none; b=qF3DNLnLyqPqwEuN7kWJwl3xLB15Oub5R+8pL0ImLjFailEw5EtnF0HuWnJFE1M5OC5KJosS97q3Vvs/pq5/p+ZPmoKV/mJKu+f1pxxMxpDQ4ZxjXLVGWUyHfhZNE5QhEEwShyQb11dEMgD1dDJlAeLMhqJeE2x9zj7Dvl2RYV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620444; c=relaxed/simple;
	bh=XbhUMMlW4dlSM7JU/MuPyutK2kIopX7DVU5/wV0oYo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BkGujzO7O6slOnd6tqFO5xKSmXCEM7HSKsbinqX9n+ZhDbeDcAb9osdtl5djzdzCyXVZmgRRjp/7IoNi4KYFVLhZRFKHnsdDElgl2O+1gvxzqXyhyFth/pCZ0rHT0gzNyYOZWZ7DcqxJB81HBQdc1z6Mk/h7gnRqJV+cmkqXsNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nygficqi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nygficqi"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc73e322dbso128758545ad.1
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 00:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784620442; x=1785225242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1UfUXCr53MVmAxCgEvl6p7BqmYW2167OMSThHKBq4o8=;
        b=nygficqioLunHGQ0MPawRDUG7S1Yw3+c5rYEJCy3HEhYpxtIJgcCOUjB95xSlB46w2
         tGNrqtw1VlAUvC9fwTP5IkYpkeVy/Ld897OqMP0NLiLUW8LGUb7lYVLmz97Zo53smq2W
         tUjyrMsJF69mpxZlqGgwNNUK9V+I1k1E2pP+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784620442; x=1785225242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1UfUXCr53MVmAxCgEvl6p7BqmYW2167OMSThHKBq4o8=;
        b=CAze4lENOPkDLrtD0qgIFp+5hKEbAk6pe8vqVtrnQsl+RIgkuzLQ5fSN9F/NTIlWyL
         GYGXnilIMc/zmS0YwXJrijeG2ZqgcUbaYmk5qIIxEpB78StrbX9HXrGylq2oTrKG98k8
         M11F+s4OD/okUaH+zmEvX2EfJcniPDUuGdPld6Xb8RYf6uqvcJDjDMqDQFwJxsFAPY9h
         rZNAdwGA1hjJTBZ9+u3Wd06PANY3nT3k983yfsJpf8ERWDnIlvPFzfgUdkl44kndOq78
         D1spYeYiSb/DrNDzNi0c4PwqyGLcur56IKvKB9neh7tB4q0uNNvE7lq/DTr+82FJUSJl
         DsUw==
X-Forwarded-Encrypted: i=1; AHgh+RqaTIqEVTyXsq3ZAvy2tdWoSHeuWKiHokydVmLBSoU8lQsfMNXVuGbNApBjPWOaALndJCjkPYmyrW+dBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe5nzkmLvzQPBtTOB2TkXA95sELvP464+QgxZ1Gwk9Xb2vYsMW
	IhXjHSq3nkFal7R4YbNLOe/WKTP0DYHoX5LPaxo50q/p42ja1QihPX7BSM19UHi3gw==
X-Gm-Gg: AR+sD10p16dGJxNO2jMSsYK7iS878CQMo8qmCzOAPQltZmoLVs2rq0maqrKtiLpM4pU
	kKrtYPwoLmESG/0BCgrPjdafJg8hVtKa56Rp4ROBfNr52Hszeqn5WJrGD/COTn8SHCtAm090fN+
	FQwkYNhUpb3xoureDSjFEpRG5xcB/epFowRfThSSHpqguOd/2xrCdjKXTCeGSXYAFdUG2KpsTN6
	MIr/YoetGeTLp2c5fO6S6TbKYKYQxFaPANfc3rjycSKHhGzkxlFo7WnP+6SLlSMsm6fqm+MLotg
	7Y9mDPL03wgDoMUbB2jc2X6W7fiOHUvKQn1cHERk9xQ50RVAkFl5PEiM/NWeAj8yrljpn4Jp/yC
	6/MbvrioXq7g8K7ivNkcg3YU3sBmczMgsigISVOsw2a6NM+gNQhXc2s+1QKw+4ZeeTh9Cd+GCoX
	MXAXMAvgCGqxPOJx5xI1+3VXtWBLeFyQUVxLB2n9r0NJ49jWJtf8sKsOSX+yk=
X-Received: by 2002:a17:903:3c44:b0:2ca:ed41:d331 with SMTP id d9443c01a7336-2cf34a3f5c3mr188180995ad.45.1784620442019;
        Tue, 21 Jul 2026 00:54:02 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448f705sm70724175ad.15.2026.07.21.00.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 00:54:01 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/9] arm64: mediatek: Chromebook trackpad supply fixes
Date: Tue, 21 Jul 2026 15:52:14 +0800
Message-ID: <20260721075226.2347933-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This is v3 of my Chromebook trackpad supply fixes and optimization
series.

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
different maintainers.

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
 drivers/hid/i2c-hid/i2c-hid-of.c              |  9 ++--
 drivers/i2c/i2c-core-of-prober.c              | 25 ++++++---
 drivers/input/mouse/elan_i2c_core.c           | 23 ++++----
 .../platform/chrome/chromeos_of_hw_prober.c   |  4 +-
 drivers/regulator/core.c                      | 53 ++++++++++++++-----
 include/linux/regulator/consumer.h            | 21 +++++---
 include/linux/regulator/driver.h              |  2 +
 10 files changed, 96 insertions(+), 52 deletions(-)

-- 
2.55.0.229.g6434b31f56-goog

