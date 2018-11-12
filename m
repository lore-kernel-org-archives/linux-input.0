From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 4/6] Input: olpc_apsp: drop CONFIG_OLPC dependency
Date: Mon, 12 Nov 2018 03:30:27 +0100
Message-ID: <20181112023029.648408-5-lkundrak@v3.sk>
References: <20181112023029.648408-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181112023029.648408-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-input@vger.kernel.org

CONFIG_OLPC is specific to the x86 platform code, while the driver is for
an ARM-based laptop.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/input/serio/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index d90d9f1098ff..c9c7224d5ae0 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -254,7 +254,6 @@ config SERIO_APBPS2
=20
 config SERIO_OLPC_APSP
 	tristate "OLPC AP-SP input support"
-	depends on OLPC || COMPILE_TEST
 	help
 	  Say Y here if you want support for the keyboard and touchpad included
 	  in the OLPC XO-1.75 and XO-4 laptops.
--=20
2.19.1
