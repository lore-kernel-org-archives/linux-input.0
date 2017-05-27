From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 1/2] power: reset: reboot-mode: Make include file global
Date: Fri, 26 May 2017 23:51:29 -0700
Message-ID: <20170527065130.3456-1-bjorn.andersson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>, John Stultz <john.stultz@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Move the reboot-mode.h include file into include/linux to allow drivers
outside drivers/power/reset to implement reboot-mode.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/power/reset/reboot-mode.c                    | 2 +-
 drivers/power/reset/syscon-reboot-mode.c             | 2 +-
 {drivers/power/reset => include/linux}/reboot-mode.h | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {drivers/power/reset => include/linux}/reboot-mode.h (100%)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index fb512183ace3..8f975ca0a8c4 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -13,7 +13,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/reboot.h>
-#include "reboot-mode.h"
+#include <linux/reboot-mode.h>
 
 #define PREFIX "mode-"
 
diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
index c8c371b285b1..563a97d7f73e 100644
--- a/drivers/power/reset/syscon-reboot-mode.c
+++ b/drivers/power/reset/syscon-reboot-mode.c
@@ -15,7 +15,7 @@
 #include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
-#include "reboot-mode.h"
+#include <linux/reboot-mode.h>
 
 struct syscon_reboot_mode {
 	struct regmap *map;
diff --git a/drivers/power/reset/reboot-mode.h b/include/linux/reboot-mode.h
similarity index 100%
rename from drivers/power/reset/reboot-mode.h
rename to include/linux/reboot-mode.h
-- 
2.12.0
