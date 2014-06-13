From: Denis Carikli <denis@eukrea.com>
Subject: [PATCH v2 6/6] ARM: imx_v4_v5_defconfig: Add I.MX25 Touchscreen controller support.
Date: Fri, 13 Jun 2014 17:21:39 +0200
Message-ID: <1402672899-6995-7-git-send-email-denis@eukrea.com>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
 <1402672899-6995-1-git-send-email-denis@eukrea.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:15436 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753163AbaFMPVr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Jun 2014 11:21:47 -0400
In-Reply-To: <1402672899-6995-1-git-send-email-denis@eukrea.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Markus Pargmann <mpa@pengutronix.de>, Denis Carikli <denis@eukrea.com>

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/configs/imx_v4_v5_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 397f43c..b6b3674 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -98,6 +98,7 @@ CONFIG_KEYBOARD_IMX=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=m
+CONFIG_TOUCHSCREEN_MX25=y
 CONFIG_TOUCHSCREEN_MC13783=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=m
@@ -118,6 +119,7 @@ CONFIG_HWMON=m
 CONFIG_SENSORS_MC13783_ADC=m
 CONFIG_WATCHDOG=y
 CONFIG_IMX2_WDT=y
+CONFIG_MFD_MX25_TSADC=y
 CONFIG_MFD_MC13XXX_SPI=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-- 
1.7.9.5

