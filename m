Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602108;
	b=pWKc3XtJI1D2ogxGEsSsC9mWLfVi4uduDhX7xxF/wI/BMAfqn35iHK5ojdsVqJZa650Q
	 hB1B3Wl/RY3/noRozeqSDtb8sDuHzYX5kqrKDDIb4mNQKO2jDMjllwJiY22DU2nRdrtnk
	 0B1QbqfRBL0WTvU3o/yHCHp0O5mQxe+msVcAMKLGZbpNiQzBc/w7FvREU+qCPFU2dYDxY
	 AOv4n3/BxA66jyXQx2nosyXb58ZqX+4WZnflPh9lklvh9RTYCmLSnRA/OEFLfxUz/2mKN
	 XpR13zIinaMEfqeLt86eXOxStE6Odo+5ORDqOBnjoVMkqPM2hnEv+keQ/73nqg7YbOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602108;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Jqv/u2tnssWrFUsKbYvCGg3pp/wTeTpZgo5sziz2JA0=;
	b=B4R0cvzUbrah94/pd+Gp1XoUawv6vUx57Ii8aUB/GkrPu3ra/vs9UMBwNgw7bZOjjQpq
	 mkrxT6gTg+ZOQePKFdCgrWsTsSRGTEZsCb/odOM9+gbRqFKa7CMfRCqWU1b03S/qA7WB7
	 RbQ1Fw2z39cRXBhfAQXAjDS0NuxuTMfDZMZ6NAftHnE3wE2TQOeZvLkAg5+B0sJU5kvBX
	 ep9iEPVUpKDwKhzkoJX8DlRSNBmHLvKEbdRT1oViEYhQZzZYExXXRYH/OytM9AoRmYwwz
	 /cQkheon31Q4IaYofPRkE5MGMcYe05jOpJ2w3c88Kd0fKGuah5q01z5FGPtoGTAmNoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Y7nIRwDk;
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAEC606A31E;
	Wed, 25 Nov 2026 10:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EAEC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Y7nIRwDk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795602099; bh=Jqv/u2tnssWrFUsKbYvCGg3pp/wTeTpZgo5sziz2JA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y7nIRwDkSL979sdDZDGTrAmUl/qLEB83OV1EZ6TQrjZguM36FgudiN3pFdRx4WhTL
	 XquV6SkeXpLrNb8XhFSstuMi3LmgNG8Mlv+MivD2zppQoqOlxwDd6joRUa4KFQlu5G
	 0MESz9sjLfYTUXQnmn9EymCEEYT/eYRMpHLGgHZE=
Received: from HF ([240e:47e:32f9:92c3:8064:1335:aef9:f3d1])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 56009AF2; Wed, 25 Nov 2026 18:21:32 +0800
X-QQ-mid: xmsmtpt1795602097tqz5wuv9k
Message-ID: <tencent_77C6C7AD95DE770C61C3D3F9EF142AE1F806@qq.com>
X-QQ-XMAILINFO: M2SvzgchpLqf1fwMWnNEYiJ2j3cHtLjw4XljYPSdpHc3DrA2tJQ/85WE1pToLk
	 8FXg9hcYFQBSHqfMbqJDvqX9zqnGTh0hgiCnxkgINIVy89EvOrsfikURFM70ASxZOSRVIdLiXf1/
	 /2TbNnKNzQPUAcZI95KLaR3Iqix8IoqO0BkCTqVgmYkUkmXiSxnEGSUSZxC4SNniAgWPP/kQoj1v
	 v2I+Dh6ZozpbrWiTMWuMGPVUTdx38S8yrlqyji2OZrY1W1s0VQZDaCV9D3QmC9058EH7j9tHN0U8
	 o0BHiZQLPBXnF3PiPxDU+ezS1BbhPZOX8JqhZFPdxO5wIWBdxuLL+jBlMPISE3b2tWdiR59v1N2C
	 OBhi/jtD3y9P+cV2xNNxmhhb+b5sAJgxx4x045vLQVo7zwSf3a9T9Elnr8NZAOAIR8aQ04/VnOWH
	 xlJFAQm96Lg+tBZv44JTy679Xw1cVifFBieeSr3aQuqSAsi0nI6mHXnqVGyPzXUuYUqUvwxgW9K8
	 wfp6GdGQxDajmukqsF8oTVDBqmb9q10/ufnJYbRTYAPIllyyLTfuDbI3BwIOnVRWbS06w9RWdwd1
	 inqka8rRbX4+CXSc5pqXfdPvpgX6Us8u5Xq5sZ8Y979M02KDpbVCXtPFROz72rPmTVpSqaXRxuwD
	 b4EUS4PnETcLJq/qKKHyySpWWbIlWF5WGppRv8HVD5RE2cN6bz2umFQUwIV/KiUzc2rgv6N+vSlN
	 ujDc0wVVBvvQTQo44NiDE4DFOI6QlOzL8X8NLqnXWlPb3voSH4ClZDconegSJTvvoucR/5UAaq6e
	 BnqWRGDFbfFJ3chQZUkMgTFYPsj3J75D5w20fzE1Mx04CZPbgKz179kZehfPXN/KaEEc/i5MmeQ1
	 UpVBc1WGq47zZB4WmxjsfOwBcEBghkbxhaafiv22KTMLdswxUYvWz0cMYu/4L2D7fCem+1saqPvC
	 YlxbNftSDcYSzariTggcR9+0Qxlr22Tlawt12fysf7ZbMDv+Y29v+pIZOKiv5XvE0vWhQe//fFXe
	 NhpdqvfSjA7e8FbfAyuaKfyIKafdQ3TUn3uEssycHR1Pw9I1Kx4DerL+GTPPrl8Xn3yQ3/83xYxd
	 4jrAyD4vFb7zNPjc584To4q58EvIiN2bBg2kyc
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk@kernel.org,
	conor+dt@kernel.org,
	dmitry.torokhov@gmail.com,
	Hefei <3066883572@qq.com>
Subject: [PATCH v6 4/6] drm/panel: add VIEWE JD9365TX 7 inch DSI panel
Date: Wed, 25 Nov 2026 18:21:28 +0800
X-OQ-MSGID: <20261125102130.256-5-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125102130.256-1-3066883572@qq.com>
References: <20261125102130.256-1-3066883572@qq.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a DRM panel driver for the VIEWE 7KF82 720x1280 Jadard JD9365TX
2-lane MIPI-DSI module. The TX command set differs from JD9365DA
(page select 0xDE, unlock 0xDF, lane config 0xCC).

Signed-off-by: Hefei <3066883572@qq.com>
---
 MAINTAINERS                                  | 299 +++++++--------
 drivers/gpu/drm/panel/Kconfig                |  11 +
 drivers/gpu/drm/panel/Makefile               |   1 +
 drivers/gpu/drm/panel/panel-viewe-jd9365tx.c | 359 +++++++++++++++++++
 4 files changed, 524 insertions(+), 146 deletions(-)
 create mode 100644 drivers/gpu/drm/panel/panel-viewe-jd9365tx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 944802a56..ee72ecdc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -449,7 +449,7 @@ F:	drivers/input/misc/ad714x.c
 
 AD738X ADC DRIVER (AD7380/1/2/4)
 M:	Michael Hennerich <michael.hennerich@analog.com>
-M:	Nuno Sá <nuno.sa@analog.com>
+M:	Nuno S谩 <nuno.sa@analog.com>
 R:	David Lechner <dlechner@baylibre.com>
 S:	Supported
 W:	https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad738x
@@ -479,7 +479,7 @@ F:	drivers/input/touchscreen/ad7879.c
 
 AD7944 ADC DRIVER (AD7944/AD7985/AD7986)
 M:	Michael Hennerich <michael.hennerich@analog.com>
-M:	Nuno Sá <nuno.sa@analog.com>
+M:	Nuno S谩 <nuno.sa@analog.com>
 R:	David Lechner <dlechner@baylibre.com>
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
@@ -664,7 +664,7 @@ F:	Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
 F:	drivers/net/phy/as21xxx.c
 
 AF8133J THREE-AXIS MAGNETOMETER DRIVER
-M:	Ondřej Jirman <megi@xff.cz>
+M:	Ond艡ej Jirman <megi@xff.cz>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
 F:	drivers/iio/magnetometer/af8133j.c
@@ -921,7 +921,7 @@ S:	Odd Fixes
 F:	arch/alpha/
 
 ALPS PS/2 TOUCHPAD DRIVER
-R:	Pali Rohár <pali@kernel.org>
+R:	Pali Roh谩r <pali@kernel.org>
 F:	drivers/input/mouse/alps.*
 
 ALTERA MAILBOX DRIVER
@@ -1393,7 +1393,7 @@ F:	Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
 F:	drivers/iio/dac/ad3530r.c
 
 ANALOG DEVICES INC AD3552R DRIVER
-M:	Nuno Sá <nuno.sa@analog.com>
+M:	Nuno S谩 <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
@@ -1412,7 +1412,7 @@ F:	drivers/iio/adc/ad4000.c
 
 AD4030 ADC DRIVER (AD4030-24/AD4630-16/AD4630-24/AD4632-16/AD4632-24)
 M:	Michael Hennerich <michael.hennerich@analog.com>
-M:	Nuno Sá <nuno.sa@analog.com>
+M:	Nuno S谩 <nuno.sa@analog.com>
 R:	Esteban Blanc <eblanc@baylibre.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
@@ -1448,7 +1448,7 @@ F:	drivers/iio/adc/ad4170-4.c
 
 ANALOG DEVICES INC AD4695 DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
-M:	Nuno Sá <nuno.sa@analog.com>
+M:	Nuno S谩 <nuno.sa@analog.com>
 R:	David Lechner <dlechner@baylibre.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
@@ -1528,7 +1528,7 @@ F:	include/dt-bindings/iio/addac/adi,ad74413r.h
 
 ANALOG DEVICES INC AD7625 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
-M:	Nuno Sá <nuno.sa@analog.com>
+M:	Nuno S谩 <nuno.sa@analog.com>
 R:	Trevor Gamblin <tgamblin@baylibre.com>
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
@@ -1752,7 +1752,7 @@ F:	drivers/iio/gyro/adxrs290.c
 
 ANALOG DEVICES INC ASOC CODEC DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
-M:	Nuno Sá <nuno.sa@analog.com>
+M:	Nuno S谩 <nuno.sa@analog.com>
 L:	linux-sound@vger.kernel.org
 S:	Supported
 W:	http://wiki.analog.com/
@@ -1806,7 +1806,7 @@ F:	include/linux/clk/analogbits*
 
 ANDROID DRIVERS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-M:	Arve Hjønnevåg <arve@android.com>
+M:	Arve Hj酶nnev氓g <arve@android.com>
 M:	Todd Kjos <tkjos@android.com>
 M:	Martijn Coenen <maco@android.com>
 M:	Joel Fernandes <joelagnelf@nvidia.com>
@@ -1963,7 +1963,7 @@ W:	http://www.aquantia.com
 F:	drivers/net/ethernet/aquantia/atlantic/aq_ptp*
 
 AR0521 ON SEMICONDUCTOR CAMERA SENSOR DRIVER
-M:	Krzysztof Hałasa <khalasa@piap.pl>
+M:	Krzysztof Ha艂asa <khalasa@piap.pl>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/i2c/onnn,ar0521.yaml
@@ -2272,7 +2272,7 @@ F:	arch/arm/mach-*/
 F:	arch/arm/plat-*/
 
 ARM/ACTIONS SEMI ARCHITECTURE
-M:	Andreas Färber <afaerber@suse.de>
+M:	Andreas F盲rber <afaerber@suse.de>
 M:	Manivannan Sadhasivam <mani@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
@@ -2314,7 +2314,7 @@ F:	arch/arm/boot/dts/airoha/
 F:	arch/arm64/boot/dts/airoha/
 
 ARM/Allwinner SoC Clock Support
-M:	Emilio López <emilio@elopez.com.ar>
+M:	Emilio L贸pez <emilio@elopez.com.ar>
 S:	Maintained
 F:	drivers/clk/sunxi/
 
@@ -2409,7 +2409,7 @@ F:	arch/arm64/boot/dts/amazon/
 F:	drivers/*/*alpine*
 
 ARM/APPLE MACHINE SOUND DRIVERS
-M:	Martin Povišer <povik+lin@cutebit.org>
+M:	Martin Povi拧er <povik+lin@cutebit.org>
 L:	asahi@lists.linux.dev
 L:	linux-sound@vger.kernel.org
 S:	Maintained
@@ -2670,7 +2670,7 @@ F:	drivers/pinctrl/pinctrl-gemini.c
 F:	drivers/rtc/rtc-ftrtc010.c
 
 ARM/CZ.NIC TURRIS SUPPORT
-M:	Marek Behún <kabel@kernel.org>
+M:	Marek Beh煤n <kabel@kernel.org>
 S:	Maintained
 W:	https://www.turris.cz/
 F:	Documentation/ABI/testing/debugfs-moxtet
@@ -2924,7 +2924,7 @@ F:	drivers/pinctrl/mvebu/
 F:	drivers/rtc/rtc-armada38x.c
 
 ARM/Marvell PXA1908 SOC support
-M:	Duje Mihanović <duje@dujemihanovic.xyz>
+M:	Duje Mihanovi膰 <duje@dujemihanovic.xyz>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
@@ -3130,7 +3130,7 @@ F:	drivers/media/platform/nuvoton/
 F:	include/uapi/linux/npcm-video.h
 
 ARM/NUVOTON WPCM450 ARCHITECTURE
-M:	Jonathan Neuschäfer <j.neuschaefer@gmx.net>
+M:	Jonathan Neusch盲fer <j.neuschaefer@gmx.net>
 L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Maintained
 W:	https://github.com/neuschaefer/wpcm450/wiki
@@ -3256,7 +3256,7 @@ F:	drivers/irqchip/irq-rda-intc.c
 F:	drivers/tty/serial/rda-uart.c
 
 ARM/REALTEK ARCHITECTURE
-M:	Andreas Färber <afaerber@suse.de>
+M:	Andreas F盲rber <afaerber@suse.de>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-realtek-soc@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
@@ -3362,7 +3362,7 @@ N:	s3c64xx
 N:	s5pv210
 
 ARM/SAMSUNG S5P SERIES 2D GRAPHICS ACCELERATION (G2D) SUPPORT
-M:	Łukasz Stelmach <l.stelmach@samsung.com>
+M:	艁ukasz Stelmach <l.stelmach@samsung.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-media@vger.kernel.org
 S:	Maintained
@@ -3708,7 +3708,7 @@ F:	scripts/make_fit.py
 
 ARM64 PLATFORM DRIVERS
 M:	Hans de Goede <hansg@kernel.org>
-M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
+M:	Ilpo J盲rvinen <ilpo.jarvinen@linux.intel.com>
 R:	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
@@ -3774,7 +3774,7 @@ F:	Documentation/hwmon/asc7621.rst
 F:	drivers/hwmon/asc7621.c
 
 ASIX AX88796C SPI ETHERNET ADAPTER
-M:	Łukasz Stelmach <l.stelmach@samsung.com>
+M:	艁ukasz Stelmach <l.stelmach@samsung.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/asix,ax88796c.yaml
 F:	drivers/net/ethernet/asix/ax88796c_*
@@ -3830,7 +3830,7 @@ F:	drivers/mmc/host/sdhci-of-aspeed*
 
 ASPEED SMC SPI DRIVER
 M:	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
-M:	Cédric Le Goater <clg@kaod.org>
+M:	C茅dric Le Goater <clg@kaod.org>
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
 L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 L:	linux-spi@vger.kernel.org
@@ -3883,7 +3883,7 @@ S:	Maintained
 F:	drivers/hwmon/asus_rog_ryujin.c
 
 ASUS WIRELESS RADIO CONTROL DRIVER
-M:	João Paulo Rechi Vita <jprvita@gmail.com>
+M:	Jo茫o Paulo Rechi Vita <jprvita@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/asus-wireless.c
@@ -4182,7 +4182,7 @@ F:	drivers/clk/samsung/clk-artpec*.c
 F:	include/dt-bindings/clock/axis,artpec*-clk.h
 
 AXI-FAN-CONTROL HARDWARE MONITOR DRIVER
-M:	Nuno Sá <nuno.sa@analog.com>
+M:	Nuno S谩 <nuno.sa@analog.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
@@ -4191,7 +4191,7 @@ F:	drivers/hwmon/axi-fan-control.c
 
 AXI SPI ENGINE
 M:	Michael Hennerich <michael.hennerich@analog.com>
-M:	Nuno Sá <nuno.sa@analog.com>
+M:	Nuno S谩 <nuno.sa@analog.com>
 R:	David Lechner <dlechner@baylibre.com>
 L:	linux-spi@vger.kernel.org
 S:	Supported
@@ -4201,7 +4201,7 @@ F:	drivers/spi/spi-axi-spi-engine.c
 
 AXI PWM GENERATOR
 M:	Michael Hennerich <michael.hennerich@analog.com>
-M:	Nuno Sá <nuno.sa@analog.com>
+M:	Nuno S谩 <nuno.sa@analog.com>
 R:	Trevor Gamblin <tgamblin@baylibre.com>
 L:	linux-pwm@vger.kernel.org
 S:	Supported
@@ -4569,7 +4569,7 @@ F:	arch/riscv/net/
 X:	arch/riscv/net/bpf_jit_comp64.c
 
 BPF JIT for RISC-V (64-bit)
-M:	Björn Töpel <bjorn@kernel.org>
+M:	Bj枚rn T枚pel <bjorn@kernel.org>
 R:	Pu Lehui <pulehui@huawei.com>
 R:	Puranjay Mohan <puranjay@kernel.org>
 L:	bpf@vger.kernel.org
@@ -4890,7 +4890,7 @@ F:	drivers/staging/media/rpivid
 
 BROADCOM BCM47XX MIPS ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
-M:	Rafał Miłecki <zajec5@gmail.com>
+M:	Rafa艂 Mi艂ecki <zajec5@gmail.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/mips/brcm/
@@ -4898,7 +4898,7 @@ F:	arch/mips/bcm47xx/*
 F:	arch/mips/include/asm/mach-bcm47xx/*
 
 BROADCOM BCM4908 ETHERNET DRIVER
-M:	Rafał Miłecki <rafal@milecki.pl>
+M:	Rafa艂 Mi艂ecki <rafal@milecki.pl>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -4907,7 +4907,7 @@ F:	drivers/net/ethernet/broadcom/bcm4908_enet.*
 F:	drivers/net/ethernet/broadcom/unimac.h
 
 BROADCOM BCM4908 PINMUX DRIVER
-M:	Rafał Miłecki <rafal@milecki.pl>
+M:	Rafa艂 Mi艂ecki <rafal@milecki.pl>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
@@ -4917,7 +4917,7 @@ F:	drivers/pinctrl/bcm/pinctrl-bcm4908.c
 BROADCOM BCM5301X ARM ARCHITECTURE
 M:	Florian Fainelli <florian.fainelli@broadcom.com>
 M:	Hauke Mehrtens <hauke@hauke-m.de>
-M:	Rafał Miłecki <zajec5@gmail.com>
+M:	Rafa艂 Mi艂ecki <zajec5@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
@@ -4929,7 +4929,7 @@ F:	arch/arm/mach-bcm/bcm_5301x.c
 
 BROADCOM BCM53573 ARM ARCHITECTURE
 M:	Florian Fainelli <florian.fainelli@broadcom.com>
-M:	Rafał Miłecki <rafal@milecki.pl>
+M:	Rafa艂 Mi艂ecki <rafal@milecki.pl>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
@@ -4964,7 +4964,7 @@ M:	William Zhang <william.zhang@broadcom.com>
 M:	Anand Gore <anand.gore@broadcom.com>
 M:	Kursad Oney <kursad.oney@broadcom.com>
 M:	Florian Fainelli <florian.fainelli@broadcom.com>
-M:	Rafał Miłecki <rafal@milecki.pl>
+M:	Rafa艂 Mi艂ecki <rafal@milecki.pl>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
@@ -5196,7 +5196,7 @@ N:	hr2
 N:	stingray
 
 BROADCOM IPROC GBIT ETHERNET DRIVER
-M:	Rafał Miłecki <rafal@milecki.pl>
+M:	Rafa艂 Mi艂ecki <rafal@milecki.pl>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -5232,13 +5232,13 @@ F:	drivers/infiniband/hw/bnxt_re/
 F:	include/uapi/rdma/bnxt_re-abi.h
 
 BROADCOM NVRAM DRIVER
-M:	Rafał Miłecki <zajec5@gmail.com>
+M:	Rafa艂 Mi艂ecki <zajec5@gmail.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	drivers/firmware/broadcom/*
 
 BROADCOM PMB (POWER MANAGEMENT BUS) DRIVER
-M:	Rafał Miłecki <rafal@milecki.pl>
+M:	Rafa艂 Mi艂ecki <rafal@milecki.pl>
 M:	Florian Fainelli <florian.fainelli@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-pm@vger.kernel.org
@@ -5248,7 +5248,7 @@ F:	drivers/pmdomain/bcm/bcm-pmb.c
 F:	include/dt-bindings/soc/bcm-pmb.h
 
 BROADCOM SPECIFIC AMBA DRIVER (BCMA)
-M:	Rafał Miłecki <zajec5@gmail.com>
+M:	Rafa艂 Mi艂ecki <zajec5@gmail.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
 F:	drivers/bcma/
@@ -5520,7 +5520,7 @@ F:	include/uapi/linux/caif/
 F:	net/caif/
 
 CAKE QDISC
-M:	Toke Høiland-Jørgensen <toke@toke.dk>
+M:	Toke H酶iland-J酶rgensen <toke@toke.dk>
 L:	cake@lists.bufferbloat.net (moderated for non-subscribers)
 S:	Maintained
 F:	net/sched/sch_cake.c
@@ -5791,7 +5791,7 @@ X:	drivers/char/random.c
 X:	drivers/char/tpm/
 
 CHARGERLAB POWER-Z HARDWARE MONITOR DRIVER
-M:	Thomas Weißschuh <linux@weissschuh.net>
+M:	Thomas Wei脽schuh <linux@weissschuh.net>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/powerz.rst
@@ -5858,12 +5858,12 @@ F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
 F:	sound/soc/codecs/cros_ec_codec.*
 
 CHROMEOS EC CHARGE CONTROL
-M:	Thomas Weißschuh <linux@weissschuh.net>
+M:	Thomas Wei脽schuh <linux@weissschuh.net>
 S:	Maintained
 F:	drivers/power/supply/cros_charge-control.c
 
 CHROMEOS EC HARDWARE MONITORING
-M:	Thomas Weißschuh <linux@weissschuh.net>
+M:	Thomas Wei脽schuh <linux@weissschuh.net>
 L:	chrome-platform@lists.linux.dev
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
@@ -5871,7 +5871,7 @@ F:	Documentation/hwmon/cros_ec_hwmon.rst
 F:	drivers/hwmon/cros_ec_hwmon.c
 
 CHROMEOS EC LED DRIVER
-M:	Thomas Weißschuh <linux@weissschuh.net>
+M:	Thomas Wei脽schuh <linux@weissschuh.net>
 S:	Maintained
 F:	drivers/leds/leds-cros_ec.c
 
@@ -5893,7 +5893,7 @@ S:	Maintained
 F:	drivers/platform/chrome/cros_ec_uart.c
 
 CHROMEOS EC USB PD NOTIFY DRIVER
-M:	Łukasz Bartosik <ukaszb@chromium.org>
+M:	艁ukasz Bartosik <ukaszb@chromium.org>
 M:	Andrei Kuchynski <akuchynski@chromium.org>
 M:	Jameson Thies <jthies@google.com>
 L:	chrome-platform@lists.linux.dev
@@ -5915,7 +5915,7 @@ F:	drivers/platform/chrome/cros_typec_vdm.*
 
 CHROMEOS HPS DRIVER
 M:	Dan Callaghan <dcallagh@chromium.org>
-R:	Sami Kyöstilä <skyostil@chromium.org>
+R:	Sami Ky枚stil盲 <skyostil@chromium.org>
 S:	Maintained
 F:	drivers/platform/chrome/cros_hps_i2c.c
 
@@ -5927,7 +5927,7 @@ F:	drivers/watchdog/cros_ec_wdt.c
 
 CHROMEOS UCSI DRIVER
 M:	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
-M:	Łukasz Bartosik <ukaszb@chromium.org>
+M:	艁ukasz Bartosik <ukaszb@chromium.org>
 M:	Jameson Thies <jthies@google.com>
 M:	Andrei Kuchynski <akuchynski@chromium.org>
 L:	chrome-platform@lists.linux.dev
@@ -6319,7 +6319,7 @@ F:	kernel/context_tracking.c
 CONTROL GROUP (CGROUP)
 M:	Tejun Heo <tj@kernel.org>
 M:	Johannes Weiner <hannes@cmpxchg.org>
-M:	Michal Koutný <mkoutny@suse.com>
+M:	Michal Koutn媒 <mkoutny@suse.com>
 L:	cgroups@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
@@ -6429,7 +6429,7 @@ S:	Maintained
 F:	tools/counter/counter_watch_events.c
 
 CP2615 I2C DRIVER
-M:	Bence Csókás <bence98@sch.bme.hu>
+M:	Bence Cs贸k谩s <bence98@sch.bme.hu>
 S:	Maintained
 F:	drivers/i2c/busses/i2c-cp2615.c
 
@@ -6850,7 +6850,7 @@ F:	net/ax25/ax25_timer.c
 F:	net/ax25/sysctl_net_ax25.c
 
 DASHARO ACPI PLATFORM DRIVER
-M:	Michał Kopeć <michal.kopec@3mdeb.com>
+M:	Micha艂 Kope膰 <michal.kopec@3mdeb.com>
 S:	Maintained
 W:	https://docs.dasharo.com/
 F:	drivers/platform/x86/dasharo-acpi.c
@@ -6930,23 +6930,23 @@ F:	drivers/media/platform/sunxi/sun8i-di/
 
 DELL LAPTOP DRIVER
 M:	Matthew Garrett <mjg59@srcf.ucam.org>
-M:	Pali Rohár <pali@kernel.org>
+M:	Pali Roh谩r <pali@kernel.org>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/dell/dell-laptop.c
 
 DELL LAPTOP FREEFALL DRIVER
-M:	Pali Rohár <pali@kernel.org>
+M:	Pali Roh谩r <pali@kernel.org>
 S:	Maintained
 F:	drivers/platform/x86/dell/dell-smo8800.c
 
 DELL LAPTOP RBTN DRIVER
-M:	Pali Rohár <pali@kernel.org>
+M:	Pali Roh谩r <pali@kernel.org>
 S:	Maintained
 F:	drivers/platform/x86/dell/dell-rbtn.*
 
 DELL LAPTOP SMM DRIVER
-M:	Pali Rohár <pali@kernel.org>
+M:	Pali Roh谩r <pali@kernel.org>
 S:	Maintained
 F:	Documentation/ABI/obsolete/procfs-i8k
 F:	drivers/hwmon/dell-smm-hwmon.c
@@ -6965,7 +6965,7 @@ S:	Maintained
 F:	drivers/platform/x86/dell/dell_rbu.c
 
 DELL SMBIOS DRIVER
-M:	Pali Rohár <pali@kernel.org>
+M:	Pali Roh谩r <pali@kernel.org>
 L:	Dell.Client.Kernel@dell.com
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
@@ -7012,7 +7012,7 @@ F:	drivers/platform/x86/dell/dell-wmi-privacy.c
 
 DELL WMI NOTIFICATIONS DRIVER
 M:	Matthew Garrett <mjg59@srcf.ucam.org>
-M:	Pali Rohár <pali@kernel.org>
+M:	Pali Roh谩r <pali@kernel.org>
 S:	Maintained
 F:	drivers/platform/x86/dell/dell-wmi-base.c
 
@@ -7201,13 +7201,13 @@ F:	include/uapi/linux/devlink.h
 F:	net/devlink/
 
 DFROBOT SD2405AL RTC DRIVER
-M:	Tóth János <gomba007@gmail.com>
+M:	T贸th J谩nos <gomba007@gmail.com>
 L:	linux-rtc@vger.kernel.org
 S:	Maintained
 F:	drivers/rtc/rtc-sd2405al.c
 
 DFROBOT SEN0322 DRIVER
-M:	Tóth János <gomba007@gmail.com>
+M:	T贸th J谩nos <gomba007@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/iio/chemical/sen0322.c
@@ -7337,7 +7337,7 @@ F:	fs/dlm/
 
 DMA BUFFER SHARING FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
-M:	Christian König <christian.koenig@amd.com>
+M:	Christian K枚nig <christian.koenig@amd.com>
 L:	linux-media@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
@@ -7591,7 +7591,7 @@ F:	include/uapi/linux/dpll.h
 DRBD DRIVER
 M:	Philipp Reisner <philipp.reisner@linbit.com>
 M:	Lars Ellenberg <lars.ellenberg@linbit.com>
-M:	Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
+M:	Christoph B枚hmwalder <christoph.boehmwalder@linbit.com>
 L:	drbd-dev@lists.linbit.com
 S:	Supported
 W:	http://www.drbd.org
@@ -7875,7 +7875,7 @@ F:	Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
 F:	drivers/gpu/drm/panel/panel-lvds.c
 
 DRM DRIVER FOR MANTIX MLAF057WE51 PANELS
-M:	Guido Günther <agx@sigxcpu.org>
+M:	Guido G眉nther <agx@sigxcpu.org>
 R:	Purism Kernel Team <kernel@puri.sm>
 S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
@@ -8129,7 +8129,7 @@ F:	Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
 F:	drivers/gpu/drm/panel/panel-sitronix-st7701.c
 
 DRM DRIVER FOR SITRONIX ST7703 PANELS
-M:	Guido Günther <agx@sigxcpu.org>
+M:	Guido G眉nther <agx@sigxcpu.org>
 R:	Purism Kernel Team <kernel@puri.sm>
 R:	Ondrej Jirman <megi@xff.cz>
 S:	Maintained
@@ -8199,6 +8199,13 @@ S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/udl/
 
+DRM DRIVER FOR VIEWE JD9365TX MIPI-DSI PANEL
+M:	Hefei <3066883572@qq.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/viewe,7kf82.yaml
+F:	drivers/gpu/drm/panel/panel-viewe-jd9365tx.c
+
 DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
 M:	Louis Chauvet <louis.chauvet@bootlin.com>
 R:	Haneen Mohammed <hamohammed.sa@gmail.com>
@@ -8500,7 +8507,7 @@ F:	include/linux/platform_data/shmob_drm.h
 
 DRM DRIVERS FOR ROCKCHIP
 M:	Sandy Huang <hjc@rock-chips.com>
-M:	Heiko Stübner <heiko@sntech.de>
+M:	Heiko St眉bner <heiko@sntech.de>
 M:	Andy Yan <andy.yan@rock-chips.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
@@ -8560,7 +8567,7 @@ F:	drivers/gpu/drm/omapdrm/
 
 DRM DRIVERS FOR V3D
 M:	Melissa Wen <mwen@igalia.com>
-M:	Maíra Canal <mcanal@igalia.com>
+M:	Ma铆ra Canal <mcanal@igalia.com>
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml
@@ -8570,7 +8577,7 @@ F:	include/uapi/drm/v3d_drm.h
 DRM DRIVERS FOR VC4
 M:	Maxime Ripard <mripard@kernel.org>
 M:	Dave Stevenson <dave.stevenson@raspberrypi.com>
-R:	Maíra Canal <mcanal@igalia.com>
+R:	Ma铆ra Canal <mcanal@igalia.com>
 R:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
@@ -8612,7 +8619,7 @@ DRM GPU SCHEDULER
 M:	Matthew Brost <matthew.brost@intel.com>
 M:	Danilo Krummrich <dakr@kernel.org>
 M:	Philipp Stanner <phasta@kernel.org>
-R:	Christian König <ckoenig.leichtzumerken@gmail.com>
+R:	Christian K枚nig <ckoenig.leichtzumerken@gmail.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
@@ -8622,7 +8629,7 @@ F:	include/drm/gpu_scheduler.h
 DRM GPUVM
 M:	Danilo Krummrich <dakr@kernel.org>
 R:	Matthew Brost <matthew.brost@intel.com>
-R:	Thomas Hellström <thomas.hellstrom@linux.intel.com>
+R:	Thomas Hellstr枚m <thomas.hellstrom@linux.intel.com>
 R:	Alice Ryhl <aliceryhl@google.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
@@ -9214,7 +9221,7 @@ W:	http://www.broadcom.com
 F:	drivers/scsi/lpfc/
 
 ENE CB710 FLASH CARD READER DRIVER
-M:	Michał Mirosław <mirq-linux@rere.qmqm.pl>
+M:	Micha艂 Miros艂aw <mirq-linux@rere.qmqm.pl>
 S:	Maintained
 F:	drivers/misc/cb710/
 F:	drivers/mmc/host/cb710-mmc.*
@@ -9271,7 +9278,7 @@ F:	include/linux/errseq.h
 F:	lib/errseq.c
 
 ESD CAN NETWORK DRIVERS
-M:	Stefan Mätje <stefan.maetje@esd.eu>
+M:	Stefan M盲tje <stefan.maetje@esd.eu>
 R:	socketcan@esd.eu
 L:	linux-can@vger.kernel.org
 S:	Maintained
@@ -9391,7 +9398,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
 F:	fs/exfat/
 
 EXPRESSWIRE PROTOCOL LIBRARY
-M:	Duje Mihanović <duje.mihanovic@skole.hr>
+M:	Duje Mihanovi膰 <duje.mihanovic@skole.hr>
 L:	linux-leds@vger.kernel.org
 S:	Maintained
 F:	drivers/leds/leds-expresswire.c
@@ -9884,7 +9891,7 @@ F:	include/uapi/video/
 F:	include/video/
 
 FREESCALE CAAM (Cryptographic Acceleration and Assurance Module) DRIVER
-M:	Horia Geantă <horia.geanta@nxp.com>
+M:	Horia Geant膬 <horia.geanta@nxp.com>
 M:	Pankaj Gupta <pankaj.gupta@nxp.com>
 M:	Gaurav Jain <gaurav.jain@nxp.com>
 L:	linux-crypto@vger.kernel.org
@@ -10306,7 +10313,7 @@ M:	Ingo Molnar <mingo@redhat.com>
 R:	Peter Zijlstra <peterz@infradead.org>
 R:	Darren Hart <dvhart@infradead.org>
 R:	Davidlohr Bueso <dave@stgolabs.net>
-R:	André Almeida <andrealmeid@igalia.com>
+R:	Andr茅 Almeida <andrealmeid@igalia.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
@@ -10598,7 +10605,7 @@ F:	Documentation/hwmon/gigabyte_waterforce.rst
 F:	drivers/hwmon/gigabyte_waterforce.c
 
 GIGABYTE WMI DRIVER
-M:	Thomas Weißschuh <linux@weissschuh.net>
+M:	Thomas Wei脽schuh <linux@weissschuh.net>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/gigabyte-wmi.c
@@ -10648,7 +10655,7 @@ F:	drivers/firmware/google/
 
 GOOGLE TENSOR SoC SUPPORT
 M:	Peter Griffin <peter.griffin@linaro.org>
-R:	André Draszik <andre.draszik@linaro.org>
+R:	Andr茅 Draszik <andre.draszik@linaro.org>
 R:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-samsung-soc@vger.kernel.org
@@ -11102,7 +11109,7 @@ F:	samples/hid/
 F:	tools/testing/selftests/hid/
 
 HID LOGITECH DRIVERS
-R:	Filipe Laíns <lains@riseup.net>
+R:	Filipe La铆ns <lains@riseup.net>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-logitech-*
@@ -11138,7 +11145,7 @@ F:	drivers/iio/*/hid-*
 F:	include/linux/hid-sensor-*
 
 HID UNIVERSAL PIDFF DRIVER
-M:	Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
+M:	Tomasz Paku艂a <tomasz.pakula.oficjalny@gmail.com>
 M:	Oleg Makarenko <oleg@makarenk.ooo>
 L:	linux-input@vger.kernel.org
 S:	Maintained
@@ -11160,7 +11167,7 @@ F:	drivers/hid/wacom.h
 F:	drivers/hid/wacom_*
 
 HID++ LOGITECH DRIVERS
-R:	Filipe Laíns <lains@riseup.net>
+R:	Filipe La铆ns <lains@riseup.net>
 R:	Bastien Nocera <hadess@hadess.net>
 L:	linux-input@vger.kernel.org
 S:	Maintained
@@ -11893,7 +11900,7 @@ F:	Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
 F:	drivers/i3c/master/adi-i3c-master.c
 
 I3C DRIVER FOR CADENCE I3C MASTER IP
-M:	Przemysław Gaj <pgaj@cadence.com>
+M:	Przemys艂aw Gaj <pgaj@cadence.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/i3c/cdns,i3c-master.yaml
 F:	drivers/i3c/master/i3c-master-cdns.c
@@ -11943,7 +11950,7 @@ F:	include/linux/sw842.h
 F:	lib/842/
 
 IBM Power in-Nest Crypto Acceleration
-M:	Breno Leitão <leitao@debian.org>
+M:	Breno Leit茫o <leitao@debian.org>
 M:	Nayna Jain <nayna@linux.ibm.com>
 M:	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
 L:	linux-crypto@vger.kernel.org
@@ -12022,7 +12029,7 @@ S:	Supported
 F:	drivers/scsi/ibmvscsi_tgt/
 
 IBM Power VMX Cryptographic instructions
-M:	Breno Leitão <leitao@debian.org>
+M:	Breno Leit茫o <leitao@debian.org>
 M:	Nayna Jain <nayna@linux.ibm.com>
 M:	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
 L:	linux-crypto@vger.kernel.org
@@ -12178,7 +12185,7 @@ F:	drivers/iio/common/scmi_sensors/scmi_iio.c
 IIO SUBSYSTEM AND DRIVERS
 M:	Jonathan Cameron <jic23@kernel.org>
 R:	David Lechner <dlechner@baylibre.com>
-R:	Nuno Sá <nuno.sa@analog.com>
+R:	Nuno S谩 <nuno.sa@analog.com>
 R:	Andy Shevchenko <andy@kernel.org>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
@@ -12544,7 +12551,7 @@ F:	include/uapi/drm/i915_drm.h
 
 INTEL DRM XE DRIVER (Lunar Lake and newer)
 M:	Lucas De Marchi <lucas.demarchi@intel.com>
-M:	Thomas Hellström <thomas.hellstrom@linux.intel.com>
+M:	Thomas Hellstr枚m <thomas.hellstrom@linux.intel.com>
 M:	Rodrigo Vivi <rodrigo.vivi@intel.com>
 L:	intel-xe@lists.freedesktop.org
 S:	Supported
@@ -13335,7 +13342,7 @@ F:	drivers/isdn/hardware/
 F:	drivers/isdn/mISDN/
 
 ISL28022 HARDWARE MONITORING DRIVER
-M:	Carsten Spieß <mail@carsten-spiess.de>
+M:	Carsten Spie脽 <mail@carsten-spiess.de>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml
@@ -13631,7 +13638,7 @@ F:	net/sunrpc/
 F:	tools/net/sunrpc/
 
 KERNEL PACMAN PACKAGING (in addition to generic KERNEL BUILD)
-M:	Thomas Weißschuh <linux@weissschuh.net>
+M:	Thomas Wei脽schuh <linux@weissschuh.net>
 R:	Christian Heusel <christian@heusel.eu>
 R:	Nathan Chancellor <nathan@kernel.org>
 S:	Maintained
@@ -14025,7 +14032,7 @@ F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktd253.yaml
 F:	drivers/video/backlight/ktd253-backlight.c
 
 KTD2801 BACKLIGHT DRIVER
-M:	Duje Mihanović <duje.mihanovic@skole.hr>
+M:	Duje Mihanovi膰 <duje.mihanovic@skole.hr>
 S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktd2801.yaml
 F:	drivers/video/backlight/ktd2801-backlight.c
@@ -14090,8 +14097,8 @@ F:	include/net/l3mdev.h
 F:	net/l3mdev
 
 LANDLOCK SECURITY MODULE
-M:	Mickaël Salaün <mic@digikod.net>
-R:	Günther Noack <gnoack@google.com>
+M:	Micka毛l Sala眉n <mic@digikod.net>
+R:	G眉nther Noack <gnoack@google.com>
 L:	linux-security-module@vger.kernel.org
 S:	Supported
 W:	https://landlock.io
@@ -14783,7 +14790,7 @@ F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
 F:	drivers/iio/dac/ltc2664.c
 
 LTC2688 IIO DAC DRIVER
-M:	Nuno Sá <nuno.sa@analog.com>
+M:	Nuno S谩 <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
@@ -14792,7 +14799,7 @@ F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
 F:	drivers/iio/dac/ltc2688.c
 
 LTC2947 HARDWARE MONITOR DRIVER
-M:	Nuno Sá <nuno.sa@analog.com>
+M:	Nuno S谩 <nuno.sa@analog.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
@@ -14811,7 +14818,7 @@ F:	Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
 F:	drivers/hwmon/ltc2991.c
 
 LTC2983 IIO TEMPERATURE DRIVER
-M:	Nuno Sá <nuno.sa@analog.com>
+M:	Nuno S谩 <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
@@ -15031,7 +15038,7 @@ F:	drivers/rtc/rtc-88pm886.c
 F:	include/linux/mfd/88pm886.h
 
 MARVELL 88PM886 PMIC GPADC DRIVER
-M:	Duje Mihanović <duje@dujemihanovic.xyz>
+M:	Duje Mihanovi膰 <duje@dujemihanovic.xyz>
 S:	Maintained
 F:	drivers/iio/adc/88pm886-gpadc.c
 
@@ -15044,7 +15051,7 @@ F:	drivers/phy/marvell/phy-mvebu-a3700-comphy.c
 F:	drivers/phy/marvell/phy-mvebu-a3700-utmi.c
 
 MARVELL ARMADA 3700 SERIAL DRIVER
-M:	Pali Rohár <pali@kernel.org>
+M:	Pali Roh谩r <pali@kernel.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml
 F:	Documentation/devicetree/bindings/serial/marvell,armada-3700-uart.yaml
@@ -15095,7 +15102,7 @@ F:	drivers/net/ethernet/marvell/mv643xx_eth.*
 
 MARVELL MV88X3310 PHY DRIVER
 M:	Russell King <linux@armlinux.org.uk>
-M:	Marek Behún <kabel@kernel.org>
+M:	Marek Beh煤n <kabel@kernel.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/phy/marvell10g.c
@@ -15264,14 +15271,14 @@ MAX9286 QUAD GMSL DESERIALIZER DRIVER
 M:	Jacopo Mondi <jacopo+renesas@jmondi.org>
 M:	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
 M:	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
-M:	Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
+M:	Niklas S枚derlund <niklas.soderlund+renesas@ragnatech.se>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml
 F:	drivers/media/i2c/max9286.c
 
 MAX96712 QUAD GMSL2 DESERIALIZER DRIVER
-M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
+M:	Niklas S枚derlund <niklas.soderlund@ragnatech.se>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/i2c/maxim,max96712.yaml
@@ -15382,7 +15389,7 @@ F:	drivers/mfd/max77714.c
 F:	include/linux/mfd/max77714.h
 
 MAXIM MAX77759 PMIC MFD DRIVER
-M:	André Draszik <andre.draszik@linaro.org>
+M:	Andr茅 Draszik <andre.draszik@linaro.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/*/maxim,max77759*.yaml
@@ -15710,7 +15717,7 @@ F:	Documentation/devicetree/bindings/media/renesas,fdp1.yaml
 F:	drivers/media/platform/renesas/rcar_fdp1.c
 
 MEDIA DRIVERS FOR RENESAS - VIN
-M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
+M:	Niklas S枚derlund <niklas.soderlund@ragnatech.se>
 L:	linux-media@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
 S:	Supported
@@ -16140,7 +16147,7 @@ F:	drivers/net/ethernet/mellanox/mlxfw/
 
 MELLANOX HARDWARE PLATFORM SUPPORT
 M:	Hans de Goede <hansg@kernel.org>
-M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
+M:	Ilpo J盲rvinen <ilpo.jarvinen@linux.intel.com>
 M:	Vadim Pasternak <vadimp@nvidia.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Supported
@@ -17215,7 +17222,7 @@ F:	drivers/platform/surface/surface_gpe.c
 
 MICROSOFT SURFACE HARDWARE PLATFORM SUPPORT
 M:	Hans de Goede <hansg@kernel.org>
-M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
+M:	Ilpo J盲rvinen <ilpo.jarvinen@linux.intel.com>
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
@@ -17444,7 +17451,7 @@ F:	drivers/media/dvb-frontends/mn88473*
 MOBILEYE MIPS SOCS
 M:	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
 M:	Gregory CLEMENT <gregory.clement@bootlin.com>
-M:	Théo Lebrun <theo.lebrun@bootlin.com>
+M:	Th茅o Lebrun <theo.lebrun@bootlin.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/mips/mobileye.yaml
@@ -17866,7 +17873,7 @@ F:	include/uapi/linux/netrom.h
 F:	net/netrom/
 
 NETRONIX EMBEDDED CONTROLLER
-M:	Jonathan Neuschäfer <j.neuschaefer@gmx.net>
+M:	Jonathan Neusch盲fer <j.neuschaefer@gmx.net>
 S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
 F:	drivers/mfd/ntxec.c
@@ -18390,7 +18397,7 @@ F:	drivers/media/i2c/ad5820.c
 F:	drivers/media/i2c/et8ek8
 
 NOKIA N900 POWER SUPPLY DRIVERS
-R:	Pali Rohár <pali@kernel.org>
+R:	Pali Roh谩r <pali@kernel.org>
 F:	drivers/power/supply/bq2415x_charger.c
 F:	drivers/power/supply/bq27xxx_battery.c
 F:	drivers/power/supply/bq27xxx_battery_i2c.c
@@ -18401,7 +18408,7 @@ F:	include/linux/power/bq27xxx_battery.h
 
 NOLIBC HEADER FILE
 M:	Willy Tarreau <w@1wt.eu>
-M:	Thomas Weißschuh <linux@weissschuh.net>
+M:	Thomas Wei脽schuh <linux@weissschuh.net>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git
 F:	tools/include/nolibc/
@@ -19271,7 +19278,7 @@ F:	include/linux/mtd/onenand*.h
 ONEXPLAYER PLATFORM EC DRIVER
 M:	Antheas Kapenekakis <lkml@antheas.dev>
 M:	Derek John Clark <derekjohn.clark@gmail.com>
-M:	Joaquín Ignacio Aramendía <samsagax@gmail.com>
+M:	Joaqu铆n Ignacio Aramend铆a <samsagax@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/oxpec.c
@@ -19309,7 +19316,7 @@ S:	Maintained
 F:	drivers/char/hw_random/optee-rng.c
 
 OP-TEE RTC DRIVER
-M:	Clément Léger <clement.leger@bootlin.com>
+M:	Cl茅ment L茅ger <clement.leger@bootlin.com>
 L:	linux-rtc@vger.kernel.org
 S:	Maintained
 F:	drivers/rtc/rtc-optee.c
@@ -19662,7 +19669,7 @@ F:	include/linux/leds-pca9532.h
 
 PCI DRIVER FOR AARDVARK (Marvell Armada 3700)
 M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
-M:	Pali Rohár <pali@kernel.org>
+M:	Pali Roh谩r <pali@kernel.org>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
@@ -19782,7 +19789,7 @@ F:	drivers/pci/controller/mobiveil/pcie-mobiveil*
 
 PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
 M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
-M:	Pali Rohár <pali@kernel.org>
+M:	Pali Roh谩r <pali@kernel.org>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
@@ -19875,7 +19882,7 @@ F:	drivers/pci/controller/pcie-xilinx-cpm.c
 
 PCI ENDPOINT SUBSYSTEM
 M:	Manivannan Sadhasivam <mani@kernel.org>
-M:	Krzysztof Wilczyński <kwilczynski@kernel.org>
+M:	Krzysztof Wilczy艅ski <kwilczynski@kernel.org>
 R:	Kishon Vijay Abraham I <kishon@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Supported
@@ -19926,7 +19933,7 @@ F:	drivers/pci/controller/pci-xgene-msi.c
 
 PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
-M:	Krzysztof Wilczyński <kwilczynski@kernel.org>
+M:	Krzysztof Wilczy艅ski <kwilczynski@kernel.org>
 M:	Manivannan Sadhasivam <mani@kernel.org>
 R:	Rob Herring <robh@kernel.org>
 L:	linux-pci@vger.kernel.org
@@ -19985,7 +19992,7 @@ F:	include/uapi/linux/pci*
 PCI SUBSYSTEM [RUST]
 M:	Danilo Krummrich <dakr@kernel.org>
 R:	Bjorn Helgaas <bhelgaas@google.com>
-R:	Krzysztof Wilczyński <kwilczynski@kernel.org>
+R:	Krzysztof Wilczy艅ski <kwilczynski@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 C:	irc://irc.oftc.net/linux-pci
@@ -19996,7 +20003,7 @@ F:	rust/kernel/pci/
 F:	samples/rust/rust_driver_pci.rs
 
 PCIE BANDWIDTH CONTROLLER
-M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
+M:	Ilpo J盲rvinen <ilpo.jarvinen@linux.intel.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	drivers/pci/pcie/bwctrl.c
@@ -20285,7 +20292,7 @@ S:	Maintained
 F:	drivers/mtd/devices/phram.c
 
 PICOLCD HID DRIVER
-M:	Bruno Prémont <bonbons@linux-vserver.org>
+M:	Bruno Pr茅mont <bonbons@linux-vserver.org>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-picolcd*
@@ -20834,7 +20841,7 @@ F:	Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
 F:	drivers/media/rc/pwm-ir-tx.c
 
 PWM SUBSYSTEM
-M:	Uwe Kleine-König <ukleinek@kernel.org>
+M:	Uwe Kleine-K枚nig <ukleinek@kernel.org>
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 Q:	https://patchwork.ozlabs.org/project/linux-pwm/list/
@@ -21083,7 +21090,7 @@ F:	drivers/net/wireless/ath/ath11k/
 N:	ath11k
 
 QUALCOMM ATHEROS ATH9K WIRELESS DRIVER
-M:	Toke Høiland-Jørgensen <toke@toke.dk>
+M:	Toke H酶iland-J酶rgensen <toke@toke.dk>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath9k
@@ -21407,7 +21414,7 @@ F:	drivers/net/wireless/quantenna/
 
 RADEON and AMDGPU DRM DRIVERS
 M:	Alex Deucher <alexander.deucher@amd.com>
-M:	Christian König <christian.koenig@amd.com>
+M:	Christian K枚nig <christian.koenig@amd.com>
 L:	amd-gfx@lists.freedesktop.org
 S:	Supported
 B:	https://gitlab.freedesktop.org/drm/amd/-/issues
@@ -21606,7 +21613,7 @@ RDACM20 Camera Sensor
 M:	Jacopo Mondi <jacopo+renesas@jmondi.org>
 M:	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
 M:	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
-M:	Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
+M:	Niklas S枚derlund <niklas.soderlund+renesas@ragnatech.se>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/i2c/imi,rdacm2x-gmsl.yaml
@@ -21618,7 +21625,7 @@ RDACM21 Camera Sensor
 M:	Jacopo Mondi <jacopo+renesas@jmondi.org>
 M:	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
 M:	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
-M:	Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
+M:	Niklas S枚derlund <niklas.soderlund+renesas@ragnatech.se>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/i2c/imi,rdacm2x-gmsl.yaml
@@ -21736,7 +21743,7 @@ F:	drivers/watchdog/realtek_otto_wdt.c
 
 REALTEK RTL83xx SMI DSA ROUTER CHIPS
 M:	Linus Walleij <linus.walleij@linaro.org>
-M:	Alvin Šipraga <alsi@bang-olufsen.dk>
+M:	Alvin 艩ipraga <alsi@bang-olufsen.dk>
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/dsa/realtek.yaml
 F:	drivers/net/dsa/realtek/*
@@ -21838,7 +21845,7 @@ F:	Documentation/devicetree/bindings/i2c/renesas,iic-emev2.yaml
 F:	drivers/i2c/busses/i2c-emev2.c
 
 RENESAS ETHERNET AVB DRIVER
-M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
+M:	Niklas S枚derlund <niklas.soderlund@ragnatech.se>
 R:	Paul Barker <paul@pbarker.dev>
 L:	netdev@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
@@ -21859,7 +21866,7 @@ F:	drivers/net/ethernet/renesas/rcar_gen4*
 F:	drivers/net/ethernet/renesas/rswitch*
 
 RENESAS ETHERNET TSN DRIVER
-M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
+M:	Niklas S枚derlund <niklas.soderlund@ragnatech.se>
 L:	netdev@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
 S:	Maintained
@@ -21917,7 +21924,7 @@ F:	Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
 F:	drivers/ata/sata_rcar.c
 
 RENESAS R-CAR THERMAL DRIVERS
-M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
+M:	Niklas S枚derlund <niklas.soderlund@ragnatech.se>
 L:	linux-renesas-soc@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
@@ -21966,7 +21973,7 @@ F:	Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml
 F:	drivers/rtc/rtc-renesas-rtca3.c
 
 RENESAS RZ/N1 A5PSW SWITCH DRIVER
-M:	Clément Léger <clement.leger@bootlin.com>
+M:	Cl茅ment L茅ger <clement.leger@bootlin.com>
 L:	linux-renesas-soc@vger.kernel.org
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -22033,7 +22040,7 @@ F:	Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
 F:	drivers/i2c/busses/i2c-rzv2m.c
 
 RENESAS SUPERH ETHERNET DRIVER
-M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
+M:	Niklas S枚derlund <niklas.soderlund@ragnatech.se>
 L:	netdev@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
 S:	Maintained
@@ -22586,7 +22593,7 @@ M:	Miguel Ojeda <ojeda@kernel.org>
 M:	Alex Gaynor <alex.gaynor@gmail.com>
 R:	Boqun Feng <boqun.feng@gmail.com>
 R:	Gary Guo <gary@garyguo.net>
-R:	Björn Roy Baron <bjorn3_gh@protonmail.com>
+R:	Bj枚rn Roy Baron <bjorn3_gh@protonmail.com>
 R:	Benno Lossin <lossin@kernel.org>
 R:	Andreas Hindborg <a.hindborg@kernel.org>
 R:	Alice Ryhl <aliceryhl@google.com>
@@ -22893,7 +22900,7 @@ F:	Documentation/devicetree/bindings/rng/samsung,exynos4-rng.yaml
 F:	drivers/crypto/exynos-rng.c
 
 SAMSUNG EXYNOS TRUE RANDOM NUMBER GENERATOR (TRNG) DRIVER
-M:	Łukasz Stelmach <l.stelmach@samsung.com>
+M:	艁ukasz Stelmach <l.stelmach@samsung.com>
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.yaml
@@ -22914,7 +22921,7 @@ F:	drivers/platform/x86/samsung-galaxybook.c
 
 SAMSUNG INTERCONNECT DRIVERS
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
-M:	Artur Świgoń <a.swigon@samsung.com>
+M:	Artur 艢wigo艅 <a.swigon@samsung.com>
 L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Supported
@@ -22928,7 +22935,7 @@ F:	drivers/platform/x86/samsung-laptop.c
 
 SAMSUNG MULTIFUNCTION PMIC DEVICE DRIVERS
 M:	Krzysztof Kozlowski <krzk@kernel.org>
-R:	André Draszik <andre.draszik@linaro.org>
+R:	Andr茅 Draszik <andre.draszik@linaro.org>
 L:	linux-kernel@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
@@ -23154,7 +23161,7 @@ F:	include/scsi/
 F:	include/uapi/scsi/
 
 SCSI TAPE DRIVER
-M:	Kai Mäkisara <Kai.Makisara@kolumbus.fi>
+M:	Kai M盲kisara <Kai.Makisara@kolumbus.fi>
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
 F:	Documentation/scsi/st.rst
@@ -23648,7 +23655,7 @@ F:	drivers/input/touchscreen/silead.c
 F:	drivers/platform/x86/touchscreen_dmi.c
 
 SILICON LABS WIRELESS DRIVERS (for WFxxx series)
-M:	Jérôme Pouiller <jerome.pouiller@silabs.com>
+M:	J茅r么me Pouiller <jerome.pouiller@silabs.com>
 L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml
@@ -23715,7 +23722,7 @@ F:	drivers/video/fbdev/sis/
 F:	include/video/sisfb.h
 
 SIS I2C TOUCHSCREEN DRIVER
-M:	Mika Penttilä <mpenttil@redhat.com>
+M:	Mika Penttil盲 <mpenttil@redhat.com>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt
@@ -24444,7 +24451,7 @@ F:	drivers/bus/stm32_firewall.c
 F:	drivers/bus/stm32_rifsc.c
 
 ST STM32 HDP PINCTRL DRIVER
-M:	Clément Le Goffic <legoffic.clement@gmail.com>
+M:	Cl茅ment Le Goffic <legoffic.clement@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/pinctrl/st,stm32-hdp.yaml
 F:	drivers/pinctrl/stm32/pinctrl-stm32-hdp.c
@@ -24775,7 +24782,7 @@ F:	Documentation/devicetree/bindings/sound/st,stm32-*.yaml
 F:	sound/soc/stm/
 
 STM32 DMA DRIVERS
-M:	Amélie Delaunay <amelie.delaunay@foss.st.com>
+M:	Am茅lie Delaunay <amelie.delaunay@foss.st.com>
 L:	dmaengine@vger.kernel.org
 L:	linux-stm32@st-md-mailman.stormreply.com (moderated for non-subscribers)
 S:	Maintained
@@ -24999,7 +25006,7 @@ S:	Maintained
 F:	drivers/gpio/gpio-creg-snps.c
 
 SYNOPSYS DESIGNWARE 8250 UART DRIVER
-M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
+M:	Ilpo J盲rvinen <ilpo.jarvinen@linux.intel.com>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 S:	Supported
 F:	drivers/tty/serial/8250/8250_dw.c
@@ -25731,7 +25738,7 @@ L:	linux-iio@vger.kernel.org
 
 TI ADS1119 ADC DRIVER
 M:	Francesco Dolcini <francesco@dolcini.it>
-M:	João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
+M:	Jo茫o Paulo Gon莽alves <jpaulo.silvagoncalves@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
@@ -25924,7 +25931,7 @@ F:	sound/soc/codecs/isabelle*
 F:	sound/soc/codecs/lm49453*
 
 TI LMP92064 ADC DRIVER
-M:	Leonard Göhrs <l.goehrs@pengutronix.de>
+M:	Leonard G枚hrs <l.goehrs@pengutronix.de>
 R:	kernel@pengutronix.de
 L:	linux-iio@vger.kernel.org
 S:	Maintained
@@ -26349,7 +26356,7 @@ T:	git git://linuxtv.org/media.git
 F:	drivers/media/pci/tw686x/
 
 U-BOOT ENVIRONMENT VARIABLES
-M:	Rafał Miłecki <rafal@milecki.pl>
+M:	Rafa艂 Mi艂ecki <rafal@milecki.pl>
 S:	Maintained
 F:	Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
 F:	drivers/nvmem/layouts/u-boot-env.c
@@ -26445,8 +26452,8 @@ F:	drivers/usb/common/ulpi.c
 F:	include/linux/ulpi/
 
 ULTRATRONIK BOARD SUPPORT
-M:	Goran Rađenović <goran.radni@gmail.com>
-M:	Börge Strümpfel <boerge.struempfel@gmail.com>
+M:	Goran Ra膽enovi膰 <goran.radni@gmail.com>
+M:	B枚rge Str眉mpfel <boerge.struempfel@gmail.com>
 S:	Maintained
 F:	arch/arm/boot/dts/st/stm32mp157c-ultra-fly-sbc.dts
 F:	arch/arm64/boot/dts/freescale/imx8mp-ultra-mach-sbc.dts
@@ -26733,7 +26740,7 @@ S:	Supported
 F:	drivers/usb/class/usblp.c
 
 USB QMI WWAN NETWORK DRIVER
-M:	Bjørn Mork <bjorn@mork.no>
+M:	Bj酶rn Mork <bjorn@mork.no>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-net-qmi
@@ -27223,7 +27230,7 @@ M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
 R:	Paolo Bonzini <pbonzini@redhat.com>
 R:	Stefan Hajnoczi <stefanha@redhat.com>
-R:	Eugenio Pérez <eperezma@redhat.com>
+R:	Eugenio P茅rez <eperezma@redhat.com>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/block/virtio_blk.c
@@ -27242,7 +27249,7 @@ VIRTIO CORE
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
 R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
-R:	Eugenio Pérez <eperezma@redhat.com>
+R:	Eugenio P茅rez <eperezma@redhat.com>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-vdpa
@@ -27283,7 +27290,7 @@ VIRTIO FILE SYSTEM
 M:	Vivek Goyal <vgoyal@redhat.com>
 M:	Stefan Hajnoczi <stefanha@redhat.com>
 M:	Miklos Szeredi <miklos@szeredi.hu>
-R:	Eugenio Pérez <eperezma@redhat.com>
+R:	Eugenio P茅rez <eperezma@redhat.com>
 L:	virtualization@lists.linux.dev
 L:	linux-fsdevel@vger.kernel.org
 S:	Supported
@@ -27318,7 +27325,7 @@ F:	include/uapi/linux/virtio_gpu.h
 VIRTIO HOST (VHOST)
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
-R:	Eugenio Pérez <eperezma@redhat.com>
+R:	Eugenio P茅rez <eperezma@redhat.com>
 L:	kvm@vger.kernel.org
 L:	virtualization@lists.linux.dev
 L:	netdev@vger.kernel.org
@@ -27374,7 +27381,7 @@ VIRTIO NET DRIVER
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
 R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
-R:	Eugenio Pérez <eperezma@redhat.com>
+R:	Eugenio P茅rez <eperezma@redhat.com>
 L:	netdev@vger.kernel.org
 L:	virtualization@lists.linux.dev
 S:	Maintained
@@ -27747,7 +27754,7 @@ W:	https://wireless.wiki.kernel.org/en/users/Drivers/wil6210
 F:	drivers/net/wireless/ath/wil6210/
 
 WINBOND CIR DRIVER
-M:	David Härdeman <david@hardeman.nu>
+M:	David H盲rdeman <david@hardeman.nu>
 S:	Maintained
 F:	drivers/media/rc/winbond-cir.c
 
@@ -27783,7 +27790,7 @@ F:	drivers/input/misc/wistron_btns.c
 
 WMI BINARY MOF DRIVER
 M:	Armin Wolf <W_Armin@gmx.de>
-R:	Thomas Weißschuh <linux@weissschuh.net>
+R:	Thomas Wei脽schuh <linux@weissschuh.net>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/stable/sysfs-platform-wmi-bmof
@@ -27952,7 +27959,7 @@ F:	drivers/platform/x86/x86-android-tablets/
 
 X86 PLATFORM DRIVERS
 M:	Hans de Goede <hansg@kernel.org>
-M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
+M:	Ilpo J盲rvinen <ilpo.jarvinen@linux.intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 Q:	https://patchwork.kernel.org/project/platform-driver-x86/list/
@@ -28079,7 +28086,7 @@ F:	net/xdp/
 F:	tools/testing/selftests/bpf/*xsk*
 
 XEN BLOCK SUBSYSTEM
-M:	Roger Pau Monné <roger.pau@citrix.com>
+M:	Roger Pau Monn茅 <roger.pau@citrix.com>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/block/xen*
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 310064051..5e38bb78b 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -1141,6 +1141,17 @@ config DRM_PANEL_TRULY_NT35597_WQXGA
 	  Say Y here if you want to enable support for Truly NT35597 WQXGA Dual DSI
 	  Video Mode panel
 
+config DRM_PANEL_VIEWE_JD9365TX
+	tristate "VIEWE 7\" JD9365TX DSI panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here to enable the VIEWE 7" 720x1280 Jadard JD9365TX
+	  MIPI-DSI panel.
+
+	  If unsure, say N.
+
 config DRM_PANEL_VISIONOX_G2647FB105
 	tristate "Visionox G2647FB105"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 75f6bf272..f3489cda0 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -113,6 +113,7 @@ obj-$(CONFIG_DRM_PANEL_TPO_TD028TTEC1) += panel-tpo-td028ttec1.o
 obj-$(CONFIG_DRM_PANEL_TPO_TD043MTEA1) += panel-tpo-td043mtea1.o
 obj-$(CONFIG_DRM_PANEL_TPO_TPG110) += panel-tpo-tpg110.o
 obj-$(CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA) += panel-truly-nt35597.o
+obj-$(CONFIG_DRM_PANEL_VIEWE_JD9365TX) += panel-viewe-jd9365tx.o
 obj-$(CONFIG_DRM_PANEL_VISIONOX_G2647FB105) += panel-visionox-g2647fb105.o
 obj-$(CONFIG_DRM_PANEL_VISIONOX_RM69299) += panel-visionox-rm69299.o
 obj-$(CONFIG_DRM_PANEL_VISIONOX_RM692E5) += panel-visionox-rm692e5.o
diff --git a/drivers/gpu/drm/panel/panel-viewe-jd9365tx.c b/drivers/gpu/drm/panel/panel-viewe-jd9365tx.c
new file mode 100644
index 000000000..3346ea519
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-viewe-jd9365tx.c
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 VIEWE
+ *
+ * DRM panel driver for VIEWE 7" 720x1280 Jadard JD9365TX (module 7KF82).
+ * 2-lane MIPI-DSI video mode. Optional reset-gpios; many FPCs use POR only.
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/mipi_display.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_of.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+
+#define JD9365TX_DISPOFF_DELAY_MS	80
+#define JD9365TX_SLPIN_DELAY_MS		200
+#define JD9365TX_DISPON_DELAY_MS	20
+
+struct jd9365tx_panel {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+	struct gpio_desc *reset;
+	struct regulator *vdd;
+	struct regulator *iovcc;
+	enum drm_panel_orientation orientation;
+};
+
+static inline struct jd9365tx_panel *to_jd9365tx(struct drm_panel *panel)
+{
+	return container_of(panel, struct jd9365tx_panel, panel);
+}
+
+static void jd9365tx_panel_reset(struct jd9365tx_panel *ctx)
+{
+	if (!ctx->reset)
+		return;
+
+	gpiod_set_value_cansleep(ctx->reset, 1);
+	msleep(20);
+	gpiod_set_value_cansleep(ctx->reset, 0);
+	msleep(20);
+}
+
+static void jd9365tx_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
+{
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xdf, 0x90, 0x84, 0x14);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xde, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xbb, 0x46, 0x55, 0xb5, 0x22, 0x22,
+				     0x55);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xde, 0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb7, 0x16, 0x00, 0x6e, 0x44, 0x77);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xde, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb3, 0x00, 0x01, 0x50, 0x50, 0x3c,
+				     0x3c, 0xa0, 0x00, 0x20, 0xb6);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xbc, 0x0c, 0x28, 0x88);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xbd, 0x00, 0x5c, 0x56);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xbf, 0x10, 0x35, 0xc3);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc0, 0xbd, 0xbd);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc3, 0x03, 0x09, 0x00, 0x04, 0x2b,
+				     0xe2);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc4, 0x05, 0xe3, 0x0d, 0xd1, 0x05,
+				     0x2c, 0x06, 0x51, 0x06, 0x51, 0x06, 0x51,
+				     0x00, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0xe0);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc5, 0x01, 0x00, 0x8c, 0x00, 0x5e,
+				     0x01, 0x7d, 0x09, 0x60, 0x02, 0xd0, 0x05,
+				     0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00,
+				     0x00, 0x00, 0x00, 0x01, 0x0e, 0x01, 0x92,
+				     0x02, 0x00, 0x02, 0xb0, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc6, 0x00, 0xe4, 0x00, 0xc8, 0x00,
+				     0x1d, 0x28, 0x82, 0x00, 0x00, 0x00, 0x01,
+				     0x00, 0x01, 0x00, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc8, 0x20, 0x80, 0xb4);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xcb, 0x7c, 0x66, 0x57, 0x42, 0x32,
+				     0x2a, 0x1b, 0x1f, 0x0a, 0x26, 0x27, 0x25,
+				     0x44, 0x32, 0x41, 0x35, 0x35, 0x2b, 0x1e,
+				     0x14, 0x06, 0x7c, 0x66, 0x57, 0x42, 0x32,
+				     0x2a, 0x1b, 0x1f, 0x0a, 0x26, 0x27, 0x2d,
+				     0x4c, 0x3a, 0x41, 0x35, 0x35, 0x2b, 0x1e,
+				     0x14, 0x06);
+	/* 2-lane: 0x31, 4-lane: 0x33 */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xcc, 0x31);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xcd, 0x23, 0x0e, 0x23, 0x0e, 0x23,
+				     0x0e, 0x23, 0x0e, 0x23, 0x23, 0x22, 0x22);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xce, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0xaa, 0xaa,
+				     0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+				     0xaa, 0xaa);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xcf, 0x40, 0x00, 0x00, 0x3f, 0xff,
+				     0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x3f, 0xff, 0xff, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd0, 0x00, 0x3f, 0x3f, 0x64, 0x64,
+				     0x3f, 0x3f, 0x3e, 0x3e, 0x2a, 0x2b, 0x3f,
+				     0x3f, 0x1f, 0x1d, 0x1b, 0x19, 0x17, 0x15,
+				     0x13, 0x11, 0x01, 0x03);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd1, 0x00, 0x3f, 0x3f, 0x64, 0x64,
+				     0x3f, 0x3f, 0x3e, 0x3e, 0x2a, 0x2b, 0x3f,
+				     0x3f, 0x1e, 0x1c, 0x1a, 0x18, 0x16, 0x14,
+				     0x12, 0x10, 0x00, 0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd2, 0x00, 0x3f, 0x3f, 0x24, 0x24,
+				     0x3f, 0x3f, 0x3e, 0x3e, 0x2a, 0x2b, 0x3f,
+				     0x3f, 0x10, 0x12, 0x14, 0x16, 0x18, 0x1a,
+				     0x1c, 0x1e, 0x02, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd3, 0x00, 0xbf, 0xbf, 0xa4, 0xa4,
+				     0xbf, 0x3f, 0x3e, 0x3e, 0x2a, 0x2b, 0x3f,
+				     0x3f, 0x11, 0x13, 0x15, 0x17, 0x19, 0x1b,
+				     0x1d, 0x1f, 0x03, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd4, 0x00, 0x60, 0x0c, 0x01, 0x03,
+				     0x20, 0x04, 0x00, 0x00, 0x00, 0x07, 0x00,
+				     0x05, 0x1d, 0x01, 0x23, 0x45, 0x60, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x01, 0x05, 0x20,
+				     0x05, 0x22, 0x01, 0x03, 0x80, 0x0a, 0x00,
+				     0x0a, 0x05, 0x24, 0x05, 0x24, 0x00, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10,
+				     0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00,
+				     0x20, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd5, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x3e, 0x00, 0x00,
+				     0x00, 0x0a, 0x78, 0x00, 0x00, 0x05, 0xe6,
+				     0xf7, 0xa0, 0x0f, 0x08, 0x08, 0x10, 0x00,
+				     0x2f, 0x04);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd7, 0x00, 0x09, 0x7d, 0x09, 0x7d,
+				     0x09, 0x7d, 0x09, 0x7d, 0x09, 0x7d, 0x09,
+				     0x7d, 0x09, 0x7d);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xde, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc7, 0x14, 0x14, 0x04, 0x04, 0x47);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xcd, 0x30, 0x53);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xce, 0x09, 0x00, 0xe0, 0x00, 0xe0);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xde, 0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb3, 0x4a, 0xa3, 0xe2, 0x2f, 0x43);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb4, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xbb, 0x00, 0x7d, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x41, 0x40, 0x43, 0x04);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xbd, 0x1b);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xbf, 0x0f, 0x03);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc1, 0x50, 0x40, 0x00, 0x00, 0x00,
+				     0x02, 0x02, 0x02, 0x02, 0x00, 0x00, 0x00,
+				     0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc2, 0x02, 0x42, 0x50, 0x00, 0x02,
+				     0xe0, 0x31);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc3, 0x20, 0xff);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc4, 0x00, 0x11, 0x07, 0x00, 0x0e,
+				     0x01, 0x08);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc6, 0x4a, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe5, 0x00, 0x70, 0x70, 0x19, 0xc8,
+				     0x09, 0x00, 0x42, 0x01, 0x30, 0x05, 0x00,
+				     0x00, 0x05, 0x07);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe6, 0x10, 0x0f, 0x88, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe9, 0x10, 0xa0, 0xa0);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xec, 0x10, 0x77, 0x0d);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xde, 0x03);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd1, 0x00, 0x00, 0x39, 0xff, 0x08);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xed, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xde, 0x00);
+	/* TEAR_ON; Sleep Out / Display On follow in prepare() */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_TEAR_ON);
+	mipi_dsi_msleep(dsi_ctx, 30);
+}
+
+static int jd9365tx_prepare(struct drm_panel *panel)
+{
+	struct jd9365tx_panel *ctx = to_jd9365tx(panel);
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
+	int ret;
+
+	ret = regulator_enable(ctx->iovcc);
+	if (ret)
+		return ret;
+
+	ret = regulator_enable(ctx->vdd);
+	if (ret) {
+		regulator_disable(ctx->iovcc);
+		return ret;
+	}
+
+	msleep(150);
+
+	jd9365tx_panel_reset(ctx);
+
+	jd9365tx_init_sequence(&dsi_ctx);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, JD9365TX_DISPON_DELAY_MS);
+	if (dsi_ctx.accum_err)
+		goto err_power;
+
+	return 0;
+
+err_power:
+	gpiod_set_value_cansleep(ctx->reset, 1);
+	regulator_disable(ctx->vdd);
+	regulator_disable(ctx->iovcc);
+	return dsi_ctx.accum_err;
+}
+
+static int jd9365tx_disable(struct drm_panel *panel)
+{
+	struct jd9365tx_panel *ctx = to_jd9365tx(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, JD9365TX_DISPOFF_DELAY_MS);
+	return 0;
+}
+
+static int jd9365tx_unprepare(struct drm_panel *panel)
+{
+	struct jd9365tx_panel *ctx = to_jd9365tx(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, JD9365TX_SLPIN_DELAY_MS);
+
+	if (ctx->reset) {
+		gpiod_set_value_cansleep(ctx->reset, 1);
+		msleep(20);
+	}
+
+	regulator_disable(ctx->vdd);
+	regulator_disable(ctx->iovcc);
+	msleep(20);
+
+	return 0;
+}
+
+/* 800 * 1510 * 50 / 1000 = 60400 */
+static const struct drm_display_mode jd9365tx_7kf82_mode = {
+	.clock		= 60400,
+	.hdisplay	= 720,
+	.hsync_start	= 720 + 20,
+	.hsync_end	= 720 + 20 + 20,
+	.htotal		= 720 + 20 + 20 + 40,
+	.vdisplay	= 1280,
+	.vsync_start	= 1280 + 200,
+	.vsync_end	= 1280 + 200 + 2,
+	.vtotal		= 1280 + 200 + 2 + 28,
+	.width_mm	= 87,
+	.height_mm	= 155,
+	.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static int jd9365tx_get_modes(struct drm_panel *panel,
+			      struct drm_connector *connector)
+{
+	return drm_connector_helper_get_modes_fixed(connector,
+						    &jd9365tx_7kf82_mode);
+}
+
+static enum drm_panel_orientation
+jd9365tx_get_orientation(struct drm_panel *panel)
+{
+	struct jd9365tx_panel *ctx = to_jd9365tx(panel);
+
+	return ctx->orientation;
+}
+
+static const struct drm_panel_funcs jd9365tx_funcs = {
+	.prepare = jd9365tx_prepare,
+	.disable = jd9365tx_disable,
+	.unprepare = jd9365tx_unprepare,
+	.get_modes = jd9365tx_get_modes,
+	.get_orientation = jd9365tx_get_orientation,
+};
+
+static int jd9365tx_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct jd9365tx_panel *ctx;
+	int ret;
+
+	ctx = devm_drm_panel_alloc(dev, struct jd9365tx_panel, panel,
+				   &jd9365tx_funcs, DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ctx->dsi = dsi;
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	dsi->lanes = 2;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+			  MIPI_DSI_MODE_LPM;
+
+	ctx->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->reset))
+		return PTR_ERR(ctx->reset);
+
+	ctx->vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(ctx->vdd))
+		return PTR_ERR(ctx->vdd);
+
+	ctx->iovcc = devm_regulator_get(dev, "iovcc");
+	if (IS_ERR(ctx->iovcc))
+		return PTR_ERR(ctx->iovcc);
+
+	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get orientation\n");
+
+	ctx->panel.prepare_prev_first = true;
+
+	ret = drm_panel_of_backlight(&ctx->panel);
+	if (ret)
+		return ret;
+
+	drm_panel_add(&ctx->panel);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		drm_panel_remove(&ctx->panel);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void jd9365tx_remove(struct mipi_dsi_device *dsi)
+{
+	struct jd9365tx_panel *ctx = mipi_dsi_get_drvdata(dsi);
+
+	mipi_dsi_detach(dsi);
+	drm_panel_remove(&ctx->panel);
+}
+
+static const struct of_device_id jd9365tx_of_match[] = {
+	{ .compatible = "viewe,7kf82" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, jd9365tx_of_match);
+
+static struct mipi_dsi_driver jd9365tx_driver = {
+	.probe = jd9365tx_probe,
+	.remove = jd9365tx_remove,
+	.driver = {
+		.name = "panel-viewe-jd9365tx",
+		.of_match_table = jd9365tx_of_match,
+	},
+};
+module_mipi_dsi_driver(jd9365tx_driver);
+
+MODULE_AUTHOR("Hefei <3066883572@qq.com>");
+MODULE_DESCRIPTION("VIEWE 7\" JD9365TX MIPI-DSI panel");
+MODULE_LICENSE("GPL");
-- 
2.55.0.windows.5

