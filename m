From: Rakesh Iyer <riyer@nvidia.com>
Subject: [PATCH 1/1] Input: tegra-kbc - remove pre Tegra20 definitions
Date: Tue, 17 Jan 2012 15:26:50 -0800
Message-ID: <1326842810-12039-1-git-send-email-riyer@nvidia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:7777 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252Ab2AQX0m (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Jan 2012 18:26:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: swarren@nvidia.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rakesh Iyer <riyer@nvidia.com>

Add support for Tegra30 by correcting definitions. This is necessary to
make driver useful in Tegra30.

Signed-off-by: Rakesh Iyer <riyer@nvidia.com>
---
 arch/arm/mach-tegra/include/mach/kbc.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/kbc.h b/arch/arm/mach-tegra/include/mach/kbc.h
index 4f3572a..3610568 100644
--- a/arch/arm/mach-tegra/include/mach/kbc.h
+++ b/arch/arm/mach-tegra/include/mach/kbc.h
@@ -24,13 +24,8 @@
 #include <linux/types.h>
 #include <linux/input/matrix_keypad.h>
 
-#ifdef CONFIG_ARCH_TEGRA_2x_SOC
 #define KBC_MAX_GPIO	24
 #define KBC_MAX_KPENT	8
-#else
-#define KBC_MAX_GPIO	20
-#define KBC_MAX_KPENT	7
-#endif
 
 #define KBC_MAX_ROW	16
 #define KBC_MAX_COL	8
-- 
1.7.4.1

