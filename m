From: Majunath Goudar <csmanjuvijay@gmail.com>
Subject: [PATCH] INPUT/MISC: Fix input/misc PWM related undefined reference errors.
Date: Tue,  8 Oct 2013 16:07:34 +0530
Message-ID: <1381228654-21947-1-git-send-email-csmanjuvijay@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: nataraja.km@lge.com, Majunath Goudar <csmanjuvijay@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This patch adds a PWM dependency to configure the INPUT_MAX8997_HAPTIC
and INPUT_PWM_BEEPER. Without this patch, build system can lead to build
failure. This was observed during randconfig testing, in which
INPUT_MAX8997_HAPTIC or INPUT_PWM_BEEPER was enabled w/o PWM being
enabled. leading to the following error:

init/built-in.o
drivers/built-in.o: In function `max8997_haptic_disable':
:(.text+0x1073a0): undefined reference to `pwm_disable'
drivers/built-in.o: In function `max8997_haptic_remove':
:(.text+0x1073fc): undefined reference to `pwm_free'
drivers/built-in.o: In function `max8997_haptic_play_effect_work':
:(.text+0x1074f0): undefined reference to `pwm_config'
:(.text+0x1075b0): undefined reference to `pwm_enable'
drivers/built-in.o: In function `max8997_haptic_probe':
:(.text+0x1076f8): undefined reference to `pwm_request'
:(.text+0x1077e8): undefined reference to `pwm_free'
drivers/built-in.o: In function `pwm_beeper_resume':
:(.text+0x1081a4): undefined reference to `pwm_config'
make: *** [vmlinux] Error 1

Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/input/misc/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index aa51baa..265240b 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -156,7 +156,7 @@ config INPUT_MAX8925_ONKEY
 
 config INPUT_MAX8997_HAPTIC
 	tristate "MAXIM MAX8997 haptic controller support"
-	depends on HAVE_PWM && MFD_MAX8997
+	depends on HAVE_PWM && MFD_MAX8997 && PWM
 	select INPUT_FF_MEMLESS
 	help
 	  This option enables device driver support for the haptic controller
@@ -461,7 +461,7 @@ config INPUT_PCF8574
 
 config INPUT_PWM_BEEPER
 	tristate "PWM beeper support"
-	depends on HAVE_PWM || PWM
+	depends on HAVE_PWM && PWM
 	help
 	  Say Y here to get support for PWM based beeper devices.
 
-- 
1.7.9.5
