From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v7 1/3] input: touchscreen: TOUCHSCREEN_SUN4I depends on !SUN4I_GPADC
Date: Thu,  3 Nov 2016 11:15:59 +0100
Message-ID: <20161103101601.24529-2-quentin.schulz@free-electrons.com>
References: <20161103101601.24529-1-quentin.schulz@free-electrons.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from up.free-electrons.com ([163.172.77.33]:33352 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752524AbcKCKQU (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 3 Nov 2016 06:16:20 -0400
In-Reply-To: <20161103101601.24529-1-quentin.schulz@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux@armlinux.org.uk, maxime.ripard@free-electrons.com, wens@csie.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, dmitry.torokhov@gmail.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, antoine.tenart@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org

SUN4I_GPADC and TOUCHSCREEN_SUN4I are incompatible (both are drivers
for Allwinner SoCs' ADC). This makes sure TOUCHSCREEN_SUN4I isn't
enabled while SUN4I_GPADC is enabled.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

added in v7

 drivers/input/touchscreen/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index efca013..c618cb9 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1120,6 +1120,7 @@ config TOUCHSCREEN_SUN4I
 	depends on ARCH_SUNXI || COMPILE_TEST
 	depends on HWMON
 	depends on THERMAL || !THERMAL_OF
+	depends on !SUN4I_GPADC
 	help
 	  This selects support for the resistive touchscreen controller
 	  found on Allwinner sunxi SoCs.
-- 
2.9.3

