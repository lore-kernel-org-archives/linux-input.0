From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH v2 1/3] bfin_rotary: move rotary platform header definition to linux platform_data head path
Date: Wed, 14 Jan 2015 16:54:12 +0800
Message-ID: <1421225654-27872-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2on0059.outbound.protection.outlook.com ([207.46.100.59]:17024
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751434AbbANJM0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jan 2015 04:12:26 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>, adi-buildroot-devel@lists.sourceforge.net, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

The platform data definition of the rotary driver should be generic for all architectures.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 arch/blackfin/mach-bf527/boards/ad7160eval.c       |    2 +-
 arch/blackfin/mach-bf527/boards/ezkit.c            |    2 +-
 arch/blackfin/mach-bf548/boards/ezkit.c            |    2 +-
 arch/blackfin/mach-bf609/boards/ezkit.c            |    2 +-
 drivers/input/misc/bfin_rotary.c                   |    2 +-
 .../linux/platform_data}/bfin_rotary.h             |    0
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename {arch/blackfin/include/asm => include/linux/platform_data}/bfin_rotary.h (100%)

diff --git a/arch/blackfin/mach-bf527/boards/ad7160eval.c b/arch/blackfin/mach-bf527/boards/ad7160eval.c
index 9501bd8..beb011b 100644
--- a/arch/blackfin/mach-bf527/boards/ad7160eval.c
+++ b/arch/blackfin/mach-bf527/boards/ad7160eval.c
@@ -666,7 +666,7 @@ static struct platform_device bfin_sport1_uart_device = {
 #endif
 
 #if IS_ENABLED(CONFIG_INPUT_BFIN_ROTARY)
-#include <asm/bfin_rotary.h>
+#include <linux/platform_data/bfin_rotary.h>
 
 static struct bfin_rotary_platform_data bfin_rotary_data = {
 	/*.rotary_up_key     = KEY_UP,*/
diff --git a/arch/blackfin/mach-bf527/boards/ezkit.c b/arch/blackfin/mach-bf527/boards/ezkit.c
index d64f565..728cda4 100644
--- a/arch/blackfin/mach-bf527/boards/ezkit.c
+++ b/arch/blackfin/mach-bf527/boards/ezkit.c
@@ -1092,7 +1092,7 @@ static struct platform_device bfin_device_gpiokeys = {
 #endif
 
 #if IS_ENABLED(CONFIG_INPUT_BFIN_ROTARY)
-#include <asm/bfin_rotary.h>
+#include <linux/platform_data/bfin_rotary.h>
 
 static struct bfin_rotary_platform_data bfin_rotary_data = {
 	/*.rotary_up_key     = KEY_UP,*/
diff --git a/arch/blackfin/mach-bf548/boards/ezkit.c b/arch/blackfin/mach-bf548/boards/ezkit.c
index 1fe7ff2..8f70f83 100644
--- a/arch/blackfin/mach-bf548/boards/ezkit.c
+++ b/arch/blackfin/mach-bf548/boards/ezkit.c
@@ -159,7 +159,7 @@ static struct platform_device bf54x_kpad_device = {
 #endif
 
 #if IS_ENABLED(CONFIG_INPUT_BFIN_ROTARY)
-#include <asm/bfin_rotary.h>
+#include <linux/platform_data/bfin_rotary.h>
 
 static struct bfin_rotary_platform_data bfin_rotary_data = {
 	/*.rotary_up_key     = KEY_UP,*/
diff --git a/arch/blackfin/mach-bf609/boards/ezkit.c b/arch/blackfin/mach-bf609/boards/ezkit.c
index e2c0b02..f9dc64d 100644
--- a/arch/blackfin/mach-bf609/boards/ezkit.c
+++ b/arch/blackfin/mach-bf609/boards/ezkit.c
@@ -75,7 +75,7 @@ static struct platform_device bfin_isp1760_device = {
 #endif
 
 #if IS_ENABLED(CONFIG_INPUT_BFIN_ROTARY)
-#include <asm/bfin_rotary.h>
+#include <linux/platform_data/bfin_rotary.h>
 
 static struct bfin_rotary_platform_data bfin_rotary_data = {
 	/*.rotary_up_key     = KEY_UP,*/
diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
index e69d9bc..8f6c7cd 100644
--- a/drivers/input/misc/bfin_rotary.c
+++ b/drivers/input/misc/bfin_rotary.c
@@ -12,9 +12,9 @@
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/slab.h>
+#include <linux/platform_data/bfin_rotary.h>
 
 #include <asm/portmux.h>
-#include <asm/bfin_rotary.h>
 
 static const u16 per_cnt[] = {
 	P_CNT_CUD,
diff --git a/arch/blackfin/include/asm/bfin_rotary.h b/include/linux/platform_data/bfin_rotary.h
similarity index 100%
rename from arch/blackfin/include/asm/bfin_rotary.h
rename to include/linux/platform_data/bfin_rotary.h
-- 
1.7.9.5

