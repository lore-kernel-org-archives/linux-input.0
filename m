From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 17/17] ARM: multi_v7_defconfig: Enable TOUCHSCREEN_SUN4I, CPU_THERMAL
Date: Tue,  6 Jan 2015 10:35:27 +0800
Message-ID: <1420511727-8242-18-git-send-email-wens@csie.org>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:41001 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564AbbAFCfs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Jan 2015 21:35:48 -0500
In-Reply-To: <1420511727-8242-1-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

This patch enables TOUCHSCREEN_SUN4I and CPU_THERMAL to enable cpufreq
support with passive cpu cooling (thermal throttling) on sunxi by default.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2328fe752e9c..0e7159ad269b 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -189,6 +189,7 @@ CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
 CONFIG_TOUCHSCREEN_STMPE=y
+CONFIG_TOUCHSCREEN_SUN4I=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MPU3050=y
 CONFIG_SERIO_AMBAKMI=y
@@ -267,6 +268,7 @@ CONFIG_POWER_RESET_SUN6I=y
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_LM95245=y
 CONFIG_THERMAL=y
+CONFIG_CPU_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
 CONFIG_ST_THERMAL_SYSCFG=y
 CONFIG_ST_THERMAL_MEMMAP=y
-- 
2.1.4

