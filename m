From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH v2 3/5] ARM: imx_v6_v7_defconfig: enable imx6ul_tsc
Date: Tue, 28 Jul 2015 17:58:39 +0800
Message-ID: <1438077521-12857-4-git-send-email-haibo.chen@freescale.com>
References: <1438077521-12857-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438077521-12857-1-git-send-email-haibo.chen@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, dmitry.torokhov@gmail.com
Cc: haibo.chen@freescale.com, hans.verkuil@cisco.com, hadess@hadess.net, mchehab@osg.samsung.com, mamlinav@gmail.com, arnd@arndb.de, jonathar@broadcom.com, hdegoede@redhat.com, christian.gmeiner@gmail.com, scott.liu@emc.com.tw, geert@linux-m68k.org, benjamin.tissoires@redhat.com, sebastien.szymanski@armadeus.com, sbranden@broadcom.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Enable imx6ul touchscreen controller

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e1ba3e2..9823ddc 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -157,6 +157,7 @@ CONFIG_MOUSE_PS2=m
 CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_EGALAX=y
+CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
 CONFIG_TOUCHSCREEN_MC13783=y
 CONFIG_TOUCHSCREEN_TSC2007=y
 CONFIG_TOUCHSCREEN_STMPE=y
-- 
1.9.1
