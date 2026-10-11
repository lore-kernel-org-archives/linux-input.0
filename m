Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A87372EE2;
	Sun, 11 Oct 2026 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723409; cv=none; b=t0XvRB9dzpSkxKmBwrHKPm7B7ej8SWKwTI/YDp2/PRBE1V537AvGxrzzRWhdMX9J/ew64zDRzPxqfhoTwMgie/RwTU8wGIwE7fj9oLjlAo+NiYEZ8MqeyOCd6Ev38FWdd2PMFBEWcVW79W0CgbnrfH2q4kPdAZH028WTRbUZcjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723409; c=relaxed/simple;
	bh=aDKj2U0X/DE9Yy9OF/iPoSmXRkPpr6DL3PcMg2CUwWY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CPRwS9bAgDf4z/Bmlwjqr9hm3Nd1XeCdQ+wbpdsQW5r6SlU7VRifkn/ZJUxeFalH8xqhNSLO1sv89+lRAmuR8or2Rqlq6LgNd22cXWZHCQIQrQcYpcoOz2rkfwiPSarHjp9KoMnzUNUNXdpGo7P4hqFI5N2fDJpA5D2ZD3gPMGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timmermann.space; spf=pass smtp.mailfrom=timmermann.space; dkim=pass (2048-bit key) header.d=timmermann.space header.i=@timmermann.space header.b=RQioT9p6; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timmermann.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timmermann.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timmermann.space header.i=@timmermann.space header.b="RQioT9p6"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4j2gP31l6Nz8tCW;
	Sun, 11 Oct 2026 14:47:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timmermann.space;
	s=MBO0001; t=1791722871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=btNDbK48xuDBWKfwWNXMiDHC86J0cvKtwBVfd31rk2M=;
	b=RQioT9p67PYKErxNhpz+kKu2Q3oSLUKo1fHwnvF4zFuyDf7q7xholJKQ90gVmGYIt+kMMw
	Pp3+TVONM9Oww1ZTTMR2pOEHBcNvpYZ+N4rlG3oXLDgxf8vnE7vybaSYEc7Q0ymgX0HA6I
	clCzsBD+BIzj46L+r4ZrIc99B95JRck9m6Q5bCUY9u1/KQBY9bjm9Aq36NbSI/MJpQZ/Z1
	Hv5xdWa080YDk5dc6YU2JlgTO6UVXCtHa6MlYXSWM5wV5NJjm07uimQBkdMkziX0/aHmnL
	X3vjdoHebYNUPYFK7bL79Gc2xn0bra3ABSFWlQpLPShXF2HbBU5gs/0za/m/+Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of foss@timmermann.space designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=foss@timmermann.space
From: Lukas Timmermann <foss@timmermann.space>
Subject: [PATCH 0/7] Input: s6sy761 - add SPI support for the S6SY791
Date: Sun, 11 Oct 2026 14:44:55 +0200
Message-Id: <20261011-lat3st-google-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQqDMBBA0avIrDvgpFCwVyldpHESU2wimYkI4
 t2b1uXb/L+DcIkscO92KLxGiTk10KUDN9kUGOPYDKY3N+qJcLZ6FcWQc5gZi105oebqJqyLaGH
 7QU+DdSMZ8sZBCy2Ffdz+k8fztNTXm53+ynAcXykHBiqGAAAA
X-Change-ID: 20261011-lat3st-google-raven-touch-upstream-f19acd121f2c
To: Lukas Timmermann <foss@timmermann.space>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 4j2gP31l6Nz8tCW

This series adds SPI support to S6SY761 touch controllers, specifically
S6SY791 devices. Also included are the necessary adjustments in the DTS
for the Google Pixel 6 Pro (raven) which uses the aforementioned SPI
version. As the mentioned board has a reset line wired, I also added that
functionality to the bindings and driver. To implement SPI versions
cleanly, the driver was split into core and bus transfer modules like
seen in other drivers.

This series was successfully tested with a Google Pixel 6 Pro. The I2C
transfer part was untested because I don't have a device with an
S6SY761 controller.

Known issue: on gs101 the touchscreen probe at boot fails with -EIO
because the very first SPI transfer is not understood by the controller
(the reply is all zeros); rebinding the driver works. This looks like
spi-s3c64xx applying CPOL/CPHA only in transfer_one(), after chip
select has been asserted, but I have not verified this further. It is
not addressed by this series.

Patches 1-4 and 7 are meant for the input tree, patches 5-6 for the
Samsung SoC tree. The DTS patches depend on the binding in patch 1.

---
Lukas Timmermann (7):
      dt-bindings: input: touchscreen: samsung,s6sy761: Add S6SY791 and reset GPIO
      Input: s6sy761 - split into core and I2C modules
      Input: s6sy761 - add reset GPIO support
      Input: s6sy761 - add SPI support for S6SY791
      arm64: dts: exynos: gs101-pixel-common: add labels for touchscreen supplies
      arm64: dts: exynos: gs101-raven: add S6SY791 touchscreen
      MAINTAINERS: add entry for Samsung S6SY761 touchscreen driver

 .../input/touchscreen/samsung,s6sy761.yaml         |  37 +++-
 MAINTAINERS                                        |   7 +
 .../boot/dts/exynos/google/gs101-pixel-common.dtsi |   4 +-
 arch/arm64/boot/dts/exynos/google/gs101-raven.dts  |  50 +++++
 drivers/input/touchscreen/Kconfig                  |  20 +-
 drivers/input/touchscreen/Makefile                 |   4 +-
 .../touchscreen/{s6sy761.c => s6sy761_core.c}      | 226 ++++++++++-----------
 drivers/input/touchscreen/s6sy761_core.h           |  34 ++++
 drivers/input/touchscreen/s6sy761_i2c.c            | 112 ++++++++++
 drivers/input/touchscreen/s6sy761_spi.c            | 172 ++++++++++++++++
 10 files changed, 534 insertions(+), 132 deletions(-)
---
base-commit: 3857c2fe5449541e24afc5efdb0f81a8a8f9a3a0
change-id: 20261011-lat3st-google-raven-touch-upstream-f19acd121f2c

Best regards,
--  
Lukas Timmermann <foss@timmermann.space>

