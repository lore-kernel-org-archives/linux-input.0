Received: from mail.nozomi.space (mail.nozomi.space [139.162.184.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3173D525B;
	Sun, 11 Oct 2026 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.184.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742933; cv=none; b=pj3mTqxg8l4JHp/4yseDQwu2+HZu/gD15UTHUsv/UhZOvhud8oz/2Ibt1ymKoOYAWkZ5eE3Xwnf3S2uqVE9g2Bb4DWK36+yE1VsXCLcJ3TzbSSJgZ4x4oBj6YLHEAhPbGLcxN6Ep4eErcbhds5/9d2oEjZqpYWtzZTNmNIoCwgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742933; c=relaxed/simple;
	bh=BbmJi8vZciVUk38WN8/tDCgMbCdprOPnGMCBvTtNfQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B1VbAHG5mApgok3bvS+Lr4ldb1Lrn3+S9lGni7bkQa+sPCaJ7doNlPiuL6wQvTv18AtBcDo91cjNg32KcEpU9iEy3zkqsAsr1VnUDL94a2fwVzOG/uB9E8rqIAM/V2Ujh9dbw62hVR3UFvupozhkxiw/tPvzG0mFlSU9uBTRnDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space; spf=pass smtp.mailfrom=nozomi.space; dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b=0She3xN/; arc=none smtp.client-ip=139.162.184.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nozomi.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b="0She3xN/"
From: =?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozomi.space;
	s=mail; t=1791742596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LVgYSY2UxISntRQ+WN3hTQeIMTkiy9umGiKAb6XsNSQ=;
	b=0She3xN/8VN2Z7OQ3s5cWgL0l6SaoRYFz+y0rmQPZiYwZcdJg85cw7ZH7EI6arBvRkgIA3
	62qtNpCKgNfh9sceDizfxQhay7jtljTEeFt7JunR9UW7cZ+TOGgsM5CaWLkLnI711nZO88
	RyvkRvcmEVIXYdM2hzKCpb3JfaGAqWBTJWjlRUAH7t2Mvb3QjVhADTS2+17vmrdxNvzoxm
	DEXnofsyla/KP9WLFF0XDFaDdoC5YxMC0l1Z7DVfiz5/V9cHGGwnZtxKPgVhyz/FEaQptv
	mQwRGZJ2Ht8v3waIqLUWM7vDrXj/Adqnex/UAZfIz9LtDkjvnF0MX/gFqqgRJg==
To: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	allencl_lin@hotmail.com,
	tylor_yang@himax.corp-partner.google.com,
	felix@kaechele.ca,
	dianders@chromium.org,
	=?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
Subject: [PATCH v6 0/3] HID: Add support for the Himax HX83102J touchscreen
Date: Sun, 11 Oct 2026 20:16:30 +0200
Message-ID: <20261011181633.1778969-1-michal@nozomi.space>
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

As Krzysztof suggested, I have taken over the series and rewritten the
driver along the lines of hid-goodix-spi instead of cleaning up the
vendor code. Allen Lin and Tylor Yang are credited with Co-developed-by,
since the protocol, the firmware loading sequence and the heatmap
handling come from their code.

On Ciri the controller has no flash, so the firmware is loaded from a
file (himax_i2chid_1002.bin or himax_i2chid_1003.bin, depending on the
panel, the names ChromeOS uses). These files are not in linux-firmware.

Tested on Ciri (sku0, BOE panel): touch, stylus, display off and on,
suspend/resume and reloading the module.

The firmware report descriptor declares feature report 68 (usage
0xff0000c5), which the driver does not serve, so hid-multitouch logs
"failed to fetch feature 68" once per probe. Touch works regardless.

Changes in v6:
- Take over the series and use Allen's full name (Krzysztof).
- dt-bindings: describe how reset-gpios differs from
  display-reset-gpios (Krzysztof).
- dt-bindings: use unevaluatedProperties and drop the properties that
  only repeated the referenced schemas.
- Squash the four driver patches and rewrite the driver: a standard
  module_spi_driver() with devm resources, no kerneldoc for standard
  functions, no __func__ in messages, no probe message, no CONFIG_OF
  conditionals or .owner, dev_err_probe() in probe (Krzysztof).
- Rename the driver to hid-himax-spi (CONFIG_HID_HIMAX_SPI), like
  hid-goodix-spi.
- Power the touch function up from a work item when the panel has been
  prepared, so loading the firmware doesn't delay the panel, and drop
  the unexplained 2 s and 1 s delays of the vendor code.
- Request and validate the firmware once and keep it, so resume doesn't
  need the file system. Check every offset and size taken from the
  image.
- Keep the HID device across power cycles instead of recreating it.
- Request the interrupt in probe, disabled until the HID device exists,
  and take its trigger from the device tree.
- Retry a failed power up when the panel is prepared again, and pass
  -EPROBE_DEFER from the panel lookup through.
- Size the heatmap buffers for an odd number of nodes, and use
  hid_safe_input_report().
- Use crc32c() instead of an open-coded CRC-32C.
- Only reset the IC when reading the event stack fails, not when the
  HID core rejects a report.

v5: https://lore.kernel.org/all/20261003142741.48634-1-michal@nozomi.space/
v4: https://lore.kernel.org/all/TY0PR06MB56110754EB9D827BE3304A259E0F2@TY0PR06MB5611.apcprd06.prod.outlook.com/




Michał Kopeć (3):
  dt-bindings: input: Add Himax HX83102J touchscreen
  HID: Add Himax HX83102J SPI touchscreen driver
  arm64: dts: mediatek: mt8188-geralt-ciri: Add the touchscreen

 .../input/touchscreen/himax,hx83102j.yaml     |   98 ++
 MAINTAINERS                                   |    7 +
 .../dts/mediatek/mt8188-geralt-ciri-sku1.dts  |    4 +
 .../dts/mediatek/mt8188-geralt-ciri-sku3.dts  |    4 +
 .../dts/mediatek/mt8188-geralt-ciri-sku5.dts  |    4 +
 .../dts/mediatek/mt8188-geralt-ciri-sku7.dts  |    4 +
 .../boot/dts/mediatek/mt8188-geralt-ciri.dtsi |   33 +
 drivers/hid/Kconfig                           |   13 +
 drivers/hid/Makefile                          |    1 +
 drivers/hid/hid-himax-spi.c                   | 1300 +++++++++++++++++
 10 files changed, 1468 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml
 create mode 100644 drivers/hid/hid-himax-spi.c


base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
-- 
2.56.0

