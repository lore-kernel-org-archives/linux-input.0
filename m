From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH 05/53] Input: atmel_mxt_ts - Select FW_LOADER for firmware code
Date: Wed,  5 Jun 2013 18:36:58 +0100
Message-ID: <1370453866-16534-6-git-send-email-nick.dyer@itdev.co.uk>
References: <1370453866-16534-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370453866-16534-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan.Bowens@atmel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, bleung@chromium.org, olofj@chromium.org
Cc: Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
Acked-by: Benson Leung <bleung@chromium.org>
---
 drivers/input/touchscreen/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index f9a5fd8..beb5ad1 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -89,6 +89,7 @@ config TOUCHSCREEN_AD7879_SPI
 config TOUCHSCREEN_ATMEL_MXT
 	tristate "Atmel mXT I2C Touchscreen"
 	depends on I2C
+	select FW_LOADER
 	help
 	  Say Y here if you have Atmel mXT series I2C touchscreen,
 	  such as AT42QT602240/ATMXT224, connected to your system.
-- 
1.7.10.4
