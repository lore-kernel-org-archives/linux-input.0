From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH v3 3/5] ARM: imx_v6_v7_defconfig: enable imx6ul_tsc
Date: Fri, 28 Aug 2015 17:09:34 +0800
Message-ID: <1440752976-9094-4-git-send-email-haibo.chen@freescale.com>
References: <1440752976-9094-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1440752976-9094-1-git-send-email-haibo.chen@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dmitry.torokhov@gmail.com, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, haibo.chen@freescale.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, mpa@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Enable imx6ul touchscreen controller

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 79194c6..61d4e02 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -159,6 +159,7 @@ CONFIG_MOUSE_PS2=m
 CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_EGALAX=y
+CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
 CONFIG_TOUCHSCREEN_MC13783=y
 CONFIG_TOUCHSCREEN_TSC2007=y
 CONFIG_TOUCHSCREEN_STMPE=y
-- 
1.9.1
