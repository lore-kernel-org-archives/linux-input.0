From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: [PATCH 2/2] input: misc: e3x0-button: Update Kconfig description
Date: Sun, 25 Oct 2015 13:06:07 -0700
Message-ID: <1445803567-8511-2-git-send-email-moritz.fischer@ettus.com>
References: <1445803567-8511-1-git-send-email-moritz.fischer@ettus.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445803567-8511-1-git-send-email-moritz.fischer@ettus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: jaewon02.kim@samsung.com, k.kozlowski@samsung.com, dmurphy@ti.com, geert@linux-m68k.org, courtney.cavin@sonymobile.com, carlo@caione.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>
List-Id: linux-input@vger.kernel.org

The driver is now used for the entire USRP e3xx series,
this commit fixes the description that will be displayed in
the menu accordingly.

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 drivers/input/misc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 7ac277c7..a676c2c 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -94,11 +94,11 @@ config INPUT_BMA150
 	  module will be called bma150.
 
 config INPUT_E3X0_BUTTON
-	tristate "NI Ettus Research USRP E3x0 Button support."
+	tristate "NI Ettus Research USRP E3xx Button support."
 	default n
 	help
 	  Say Y here to enable support for the NI Ettus Research
-	  USRP E3x0 Button.
+	  USRP E3xx Button.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called e3x0-button.
-- 
2.6.2
