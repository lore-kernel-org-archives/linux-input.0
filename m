From: Carlo Caione <carlo@caione.org>
Subject: [PATCH v3 10/10] ARM: sunxi: Add AXP20x support multi_v7_defconfig
Date: Thu, 27 Mar 2014 22:29:24 +0100
Message-ID: <1395955764-18103-11-git-send-email-carlo@caione.org>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:44903 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757405AbaC0V21 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Mar 2014 17:28:27 -0400
In-Reply-To: <1395955764-18103-1-git-send-email-carlo@caione.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com, maxime.ripard@free-electrons.com, hdegoede@redhat.com, emilio@elopez.com.ar, wens@csie.org, sameo@linux.intel.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: Carlo Caione <carlo@caione.org>

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ee69829..239c014 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -134,6 +134,7 @@ CONFIG_KEYBOARD_SPEAR=y
 CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_MISC=y
+CONFIG_INPUT_AXP20X_PEK=y
 CONFIG_INPUT_MPU3050=y
 CONFIG_SERIO_AMBAKMI=y
 CONFIG_SERIAL_8250=y
@@ -189,6 +190,7 @@ CONFIG_SENSORS_LM90=y
 CONFIG_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
 CONFIG_MFD_AS3722=y
+CONFIG_MFD_AXP20X=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_SPI=y
 CONFIG_MFD_MAX8907=y
@@ -199,6 +201,7 @@ CONFIG_MFD_TPS65910=y
 CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
 CONFIG_REGULATOR_AB8500=y
 CONFIG_REGULATOR_AS3722=y
+CONFIG_REGULATOR_AXP20X=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_MAX8907=y
 CONFIG_REGULATOR_PALMAS=y
-- 
1.8.3.2

