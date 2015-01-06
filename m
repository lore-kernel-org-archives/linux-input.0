From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 16/17] ARM: sunxi_defconfig: Enable TOUCHSCREEN_SUN4I, CPUFREQ_DT, CPU_THERMAL
Date: Tue,  6 Jan 2015 10:35:26 +0800
Message-ID: <1420511727-8242-17-git-send-email-wens@csie.org>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:40998 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542AbbAFCfs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Jan 2015 21:35:48 -0500
In-Reply-To: <1420511727-8242-1-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

This patch enables TOUCHSCREEN_SUN4I, CPUFREQ_DT, and CPU_THERMAL to
enable cpufreq support with passive cpu cooling (thermal throttling)
by default.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/configs/sunxi_defconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 7a342d2780a8..46a8688bd49a 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -9,6 +9,8 @@ CONFIG_HIGHMEM=y
 CONFIG_HIGHPTE=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPUFREQ_DT=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_PM=y
@@ -54,6 +56,8 @@ CONFIG_STMMAC_ETH=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_SUN4I=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=8
@@ -71,7 +75,8 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_SUN6I=y
-# CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+CONFIG_CPU_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_MFD_AXP20X=y
-- 
2.1.4

