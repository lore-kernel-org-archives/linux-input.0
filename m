From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH] Input: tegra: move platform data header
Date: Tue,  4 Sep 2012 16:40:31 -0600
Message-ID: <1346798431-28839-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Move the Tegra KBC platform data header out of arch/arm/mach-tegra, as
a pre-requisite of single zImage.

Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/input/keyboard/tegra-kbc.c                 |    2 +-
 .../mach/kbc.h => include/linux/input/tegra_kbc.h  |    0
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename arch/arm/mach-tegra/include/mach/kbc.h => include/linux/input/tegra_kbc.h (100%)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 2c1c9ed..5faaf25 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -29,8 +29,8 @@
 #include <linux/of.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
+#include <linux/input/tegra_kbc.h>
 #include <mach/clk.h>
-#include <mach/kbc.h>
 
 #define KBC_MAX_DEBOUNCE_CNT	0x3ffu
 
diff --git a/arch/arm/mach-tegra/include/mach/kbc.h b/include/linux/input/tegra_kbc.h
similarity index 100%
rename from arch/arm/mach-tegra/include/mach/kbc.h
rename to include/linux/input/tegra_kbc.h
-- 
1.7.0.4
