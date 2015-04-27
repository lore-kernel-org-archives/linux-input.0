From: Rajeev Kumar <rajeevkumar.linux@gmail.com>
Subject: [PATCH] rajeev-dlh.kumar@st.com email-id doesn't exist anymore as I have left the company.  Replace ST's id with Rajeev Kumar <rajeevkumar.linux@gmail.com>
Date: Mon, 27 Apr 2015 12:40:03 +0530
Message-ID: <1430118603-12080-1-git-send-email-rajeevkumar.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:35019 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143AbbD0HKR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Apr 2015 03:10:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, broonie@kernel.org, a.zummo@towertech.it
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, alsa-devel@alsa-project.org, rtc-linux@googlegroups.com, akpm@linux-foundation.org

It also updates .mailmap file to fix address for 'git shortlog'

Signed-off-by: Rajeev Kumar <rajeevkumar.linux@gmail.com>
---
 .mailmap                                     |    1 +
 arch/arm/mach-spear/generic.h                |    2 +-
 arch/arm/mach-spear/include/mach/irqs.h      |    2 +-
 arch/arm/mach-spear/include/mach/spear.h     |    2 +-
 arch/arm/mach-spear/spear6xx.c               |    2 +-
 drivers/input/keyboard/spear-keyboard.c      |    2 +-
 drivers/rtc/rtc-spear.c                      |    4 ++--
 include/linux/platform_data/keyboard-spear.h |    2 +-
 include/sound/designware_i2s.h               |    2 +-
 include/sound/spear_dma.h                    |    2 +-
 10 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/.mailmap b/.mailmap
index 0d971cf..c570755 100644
--- a/.mailmap
+++ b/.mailmap
@@ -96,6 +96,7 @@ Peter A Jonsson <pj@ludd.ltu.se>
 Peter Oruba <peter@oruba.de>
 Peter Oruba <peter.oruba@amd.com>
 Praveen BP <praveenbp@ti.com>
+Rajeev Kumar <rajeevkumar.linux@gmail.com>
 Rajesh Shah <rajesh.shah@intel.com>
 Ralf Baechle <ralf@linux-mips.org>
 Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
diff --git a/arch/arm/mach-spear/generic.h b/arch/arm/mach-spear/generic.h
index a99d90a..0bfd2ea 100644
--- a/arch/arm/mach-spear/generic.h
+++ b/arch/arm/mach-spear/generic.h
@@ -2,7 +2,7 @@
  * spear machine family generic header file
  *
  * Copyright (C) 2009-2012 ST Microelectronics
- * Rajeev Kumar <rajeev-dlh.kumar@st.com>
+ * Rajeev Kumar <rajeevkumar.linux@gmail.com>
  * Viresh Kumar <viresh.linux@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
diff --git a/arch/arm/mach-spear/include/mach/irqs.h b/arch/arm/mach-spear/include/mach/irqs.h
index 92da0a8..022cf98 100644
--- a/arch/arm/mach-spear/include/mach/irqs.h
+++ b/arch/arm/mach-spear/include/mach/irqs.h
@@ -2,7 +2,7 @@
  * IRQ helper macros for spear machine family
  *
  * Copyright (C) 2009-2012 ST Microelectronics
- * Rajeev Kumar <rajeev-dlh.kumar@st.com>
+ * Rajeev Kumar <rajeevkumar.linux@gmail.com>
  * Viresh Kumar <viresh.linux@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
diff --git a/arch/arm/mach-spear/include/mach/spear.h b/arch/arm/mach-spear/include/mach/spear.h
index f2d6a01..0d2f14d 100644
--- a/arch/arm/mach-spear/include/mach/spear.h
+++ b/arch/arm/mach-spear/include/mach/spear.h
@@ -2,7 +2,7 @@
  * SPEAr3xx/6xx Machine family specific definition
  *
  * Copyright (C) 2009,2012 ST Microelectronics
- * Rajeev Kumar<rajeev-dlh.kumar@st.com>
+ * Rajeev Kumar <rajeevkumar.linux@gmail.com>
  * Viresh Kumar <viresh.linux@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
diff --git a/arch/arm/mach-spear/spear6xx.c b/arch/arm/mach-spear/spear6xx.c
index da26fa5b..c6dcb0d 100644
--- a/arch/arm/mach-spear/spear6xx.c
+++ b/arch/arm/mach-spear/spear6xx.c
@@ -4,7 +4,7 @@
  * SPEAr6XX machines common source file
  *
  * Copyright (C) 2009 ST Microelectronics
- * Rajeev Kumar<rajeev-dlh.kumar@st.com>
+ * Rajeev Kumar <rajeevkumar.linux@gmail.com>
  *
  * Copyright 2012 Stefan Roese <sr@denx.de>
  *
diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index f42a543..623d451 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -3,7 +3,7 @@
  * Based on omap-keypad driver
  *
  * Copyright (C) 2010 ST Microelectronics
- * Rajeev Kumar<rajeev-dlh.kumar@st.com>
+ * Rajeev Kumar <rajeevkumar.linux@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
index d2cdb98..d14be33 100644
--- a/drivers/rtc/rtc-spear.c
+++ b/drivers/rtc/rtc-spear.c
@@ -2,7 +2,7 @@
  * drivers/rtc/rtc-spear.c
  *
  * Copyright (C) 2010 ST Microelectronics
- * Rajeev Kumar<rajeev-dlh.kumar@st.com>
+ * Rajeev Kumar <rajeevkumar.linux@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -504,6 +504,6 @@ static struct platform_driver spear_rtc_driver = {
 module_platform_driver(spear_rtc_driver);
 
 MODULE_ALIAS("platform:rtc-spear");
-MODULE_AUTHOR("Rajeev Kumar <rajeev-dlh.kumar@st.com>");
+MODULE_AUTHOR("Rajeev Kumar <rajeevkumar.linux@gmail.com>");
 MODULE_DESCRIPTION("ST SPEAr Realtime Clock Driver (RTC)");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_data/keyboard-spear.h b/include/linux/platform_data/keyboard-spear.h
index 9248e3a..5e3ff65 100644
--- a/include/linux/platform_data/keyboard-spear.h
+++ b/include/linux/platform_data/keyboard-spear.h
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2010 ST Microelectronics
- * Rajeev Kumar<rajeev-dlh.kumar@st.com>
+ * Rajeev Kumar <rajeevkumar.linux@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
diff --git a/include/sound/designware_i2s.h b/include/sound/designware_i2s.h
index 26f406e..3a8fca9 100644
--- a/include/sound/designware_i2s.h
+++ b/include/sound/designware_i2s.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (ST) 2012 Rajeev Kumar (rajeev-dlh.kumar@st.com)
+ * Copyright (ST) 2012 Rajeev Kumar (rajeevkumar.linux@gmail.com)
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff --git a/include/sound/spear_dma.h b/include/sound/spear_dma.h
index 65aca51..e290de4 100644
--- a/include/sound/spear_dma.h
+++ b/include/sound/spear_dma.h
@@ -1,7 +1,7 @@
 /*
 * linux/spear_dma.h
 *
-* Copyright (ST) 2012 Rajeev Kumar (rajeev-dlh.kumar@st.com)
+* Copyright (ST) 2012 Rajeev Kumar (rajeevkumar.linux@gmail.com)
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
-- 
1.7.9.5

