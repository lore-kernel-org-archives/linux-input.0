From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 5/8] Input: olpc_apsp: depend on CONFIG_OF
Date: Mon, 10 Sep 2018 13:26:51 +0200
Message-ID: <20180910112654.42061-6-lkundrak@v3.sk>
References: <20180910112654.42061-1-lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910112654.42061-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-input@vger.kernel.org

This is a device-tree enabled driver. Moreover CONFIG_OLPC is specific
to the x86 platform code, while the driver is for an ARM-based laptop.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/input/serio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index d90d9f1098ff..a4f70021b53e 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -254,7 +254,7 @@ config SERIO_APBPS2
 
 config SERIO_OLPC_APSP
 	tristate "OLPC AP-SP input support"
-	depends on OLPC || COMPILE_TEST
+	depends on OF
 	help
 	  Say Y here if you want support for the keyboard and touchpad included
 	  in the OLPC XO-1.75 and XO-4 laptops.
-- 
2.17.1
