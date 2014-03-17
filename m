From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 15/15] ARM: at91/dt: at91-cosino_mega2560 remove useless tsadcc node
Date: Mon, 17 Mar 2014 14:57:08 +0100
Message-ID: <1395064628-644-16-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395064628-644-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395064628-644-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Rodolfo Giometti <giometti@linux.it>
List-Id: linux-input@vger.kernel.org

The tsadcc node is useless as it doesn't refer to anything and the touchscreen
is handled by the adc0 node.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Rodolfo Giometti <giometti@linux.it>
---
 arch/arm/boot/dts/at91-cosino_mega2560.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/at91-cosino_mega2560.dts b/arch/arm/boot/dts/at91-cosino_mega2560.dts
index f9415dd11f17..cce621239b72 100644
--- a/arch/arm/boot/dts/at91-cosino_mega2560.dts
+++ b/arch/arm/boot/dts/at91-cosino_mega2560.dts
@@ -33,11 +33,6 @@
 				status = "okay";
 			};
 
-
-			tsadcc: tsadcc@f804c000 {
-				status = "okay";
-			};
-
 			rtc@fffffeb0 {
 				status = "okay";
 			};
-- 
1.8.3.2
