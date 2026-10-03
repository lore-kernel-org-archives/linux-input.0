Received: from mail.nozomi.space (mail.nozomi.space [139.162.184.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488F030ACEE;
	Sat,  3 Oct 2026 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.184.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791038119; cv=none; b=pdRHyhKip/fyPd4vkyzuf9YrMnOr36vUqRtpS7gDvAv0T/BNhrLRd0pAUkhKh5aKzlxM5KhiDHUXjvHL2Gt/tA8RpNEn1L8VLkBHDqx34Jk92kvmKSkkApPDjNFNWZPhbMHlmcc03BLn9p4PpUKZUjCWaZgFL/+jsqwRrldaF2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791038119; c=relaxed/simple;
	bh=3cgM8nuIxz1frOrlIQ15qpXGO/VrY51cJ5oFg3DhkF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s87HG5NkfUTChplHKOMG4NuzYVl8cUKKI0NqE8lBcQgPuc6Az0BREkT8W9Ju7UILeJS21AYowFAV1md4x0+AWPgfYLhgEjehoYqs1ll1noLbjBYiTP7/KGXizQAw1AoI3tRB6VdHWzrZq7/zpaftiw9MkZyi8naM83b8LhInojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space; spf=pass smtp.mailfrom=nozomi.space; dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b=QXDuUr84; arc=none smtp.client-ip=139.162.184.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nozomi.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b="QXDuUr84"
From: =?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozomi.space;
	s=mail; t=1791037665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i7Pxqkmjt5iCbblP6tL95SkDHA/mfjdEN60DSU5pzNo=;
	b=QXDuUr847hdXKosbPGOjGatRrlxzNdEPHSMCpGdU2j5Jb4BI0iaKlQV0UN2RKmeTa6vkbU
	9cohl3V0IayrHLri/XsTdtLQ7bU9lSRrHBgcGcH+F/uPaa5Iuf6HQDcacXXxHHOpemDKq5
	iZFMMw6Cv+LvK37JfrN26ui60HkWbWivTYPyADninIngEqcGwof29x8ABo1gET1njrosKS
	CcB6nXhTt3T2FfVlX2iof9B0WJhdWVLWAATyYZimluJUAkAd54Qw1jNL/Iiaggu8MoO3ET
	6Z64KkP20/7onmLVk5L5srqu4mB5j2BywpCLLnoj7n68dsAjz+UCm+Dwb4B86g==
To: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Allen Lin <allencl_lin@hotmail.com>,
	Tylor Yang <tylor_yang@himax.corp-partner.google.com>,
	Felix Kaechele <felix@kaechele.ca>,
	Douglas Anderson <dianders@chromium.org>,
	=?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
Subject: [PATCH v5 0/6] HID: Add support for the Himax HX83102J touchscreen
Date: Sat,  3 Oct 2026 16:27:35 +0200
Message-ID: <20261003142741.48634-1-michal@nozomi.space>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds support for the touch function of the Himax HX83102J,
a touch and display driver integrated (TDDI) controller that reports HID
packets over SPI. It is used in the MediaTek MT8188 based Lenovo
Chromebook Duet ("Ciri").

This is a respin of Allen Lin's v4 [1], which stalled after the review.
I have kept Allen as the author of his patches and noted my changes in
each of them. Patch 5 is based on Tylor Yang's heatmap support in the
ChromeOS kernel driver, which I have credited there.

On Ciri the controller has no flash, so the firmware is loaded from a
file (himax_i2chid_1002.bin or himax_i2chid_1003.bin, depending on the
panel, the names ChromeOS uses). These files are not in linux-firmware.

Tested on Ciri (sku0, BOE panel): touch, stylus and suspend/resume.

The firmware report descriptor declares feature report 68 (usage
0xff0000c5), which the driver does not serve, so hid-multitouch logs
"failed to fetch feature 68" once per probe. Touch works regardless.

Changes in v5:
- Rebase onto v7.3 (spi->master is now spi->controller).
- dt-bindings: rename ddreset-gpios to display-reset-gpios and describe
  it and the supplies shared with the display (Conor). Dropping the "dd"
  entirely would clash with reset-gpios, the reset of the touch
  function, so I used display-reset-gpios instead.
- dt-bindings: drop Rob's Reviewed-by because of the above.
- Use family-wide names for the MCU helpers that are shared by the
  HX831xx controllers, e.g. himax_mcu_sense_off(), himax_chip_detect()
  and HIMAX_SAFE_MODE_PASSWORD (Felix). The remaining HX83102J names
  are chip specific: the TCON reset (0x80020004) and raw output select
  (0x100072ec) registers differ from the HX831xx defaults (0x80020020,
  0x800204b4), the hardware CRC registers are only used by the flashless
  parts, and the sizes are per chip. I have not tried to share code with
  himax_hx83112b, which talks to its I2C controllers with a custom event
  format, while the HX83102J sends HID reports over SPI.
- Unregister the panel follower on remove. Without it, unbinding the
  driver left a dangling entry in the panel's follower list.
- New patch: report the touch report and the heatmap. With the Ciri
  firmware, every frame carries the touch report, the stylus report and
  a 12-bit packed heatmap, which the firmware declares as report 97;
  only the stylus report was passed on.
- New patch: add the touchscreen to the Ciri device tree.
- List myself as the maintainer of the driver and the binding.
- Fix checkpatch --strict issues and expand the Kconfig help.
- Reword the commit messages.

[1] https://lore.kernel.org/all/TY0PR06MB56110754EB9D827BE3304A259E0F2@TY0PR06MB5611.apcprd06.prod.outlook.com/

Allen_Lin (4):
  dt-bindings: input: Add Himax HX83102J touchscreen
  HID: Add Himax HX83102J touchscreen driver
  HID: himax: Add DRM panel follower support
  HID: himax: Load the firmware from a file

Michał Kopeć (2):
  HID: himax: Report the touch and heatmap data
  arm64: dts: mediatek: mt8188-geralt-ciri: Add the touchscreen

 .../input/touchscreen/himax,hx83102j.yaml     |   98 +
 MAINTAINERS                                   |    7 +
 .../dts/mediatek/mt8188-geralt-ciri-sku1.dts  |    4 +
 .../dts/mediatek/mt8188-geralt-ciri-sku3.dts  |    4 +
 .../dts/mediatek/mt8188-geralt-ciri-sku5.dts  |    4 +
 .../dts/mediatek/mt8188-geralt-ciri-sku7.dts  |    4 +
 .../boot/dts/mediatek/mt8188-geralt-ciri.dtsi |   33 +
 drivers/hid/Kconfig                           |   13 +
 drivers/hid/Makefile                          |    2 +
 drivers/hid/hid-himax.c                       | 3187 +++++++++++++++++
 drivers/hid/hid-himax.h                       |  466 +++
 11 files changed, 3822 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml
 create mode 100644 drivers/hid/hid-himax.c
 create mode 100644 drivers/hid/hid-himax.h


base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
-- 
2.55.0

