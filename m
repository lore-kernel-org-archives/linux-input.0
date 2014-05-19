From: Carlo Caione <carlo@caione.org>
Subject: [PATCH v6 6/7] ARM: sunxi: Add AXP20x support in defconfig
Date: Mon, 19 May 2014 21:47:47 +0200
Message-ID: <1400528868-5971-7-git-send-email-carlo@caione.org>
References: <1400528868-5971-1-git-send-email-carlo@caione.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1400528868-5971-1-git-send-email-carlo@caione.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com, maxime.ripard@free-electrons.com, hdegoede@redhat.com, emilio@elopez.com.ar, wens@csie.org, sameo@linux.intel.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org, boris.brezillon@free-electrons.com
Cc: Carlo Caione <carlo@caione.org>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/configs/sunxi_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index b5df4a5..6e305da 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -40,6 +40,8 @@ CONFIG_SUN4I_EMAC=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
 # CONFIG_WLAN is not set
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_AXP20X_PEK=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=8
@@ -55,6 +57,7 @@ CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
+CONFIG_MFD_AXP20X=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
@@ -69,3 +72,4 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS=y
 CONFIG_PRINTK_TIME=y
+CONFIG_REGULATOR_AXP20X=y
-- 
1.9.1

