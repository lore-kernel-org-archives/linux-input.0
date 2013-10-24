From: Denis Carikli <denis@eukrea.com>
Subject: [PATCHv7][ 4/4] ARM: imx_v6_v7_defconfig: Enable tsc2007 support.
Date: Thu, 24 Oct 2013 14:42:16 +0200
Message-ID: <1382618536-25320-4-git-send-email-denis@eukrea.com>
References: <1382618536-25320-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:60407 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754709Ab3JXMmu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Oct 2013 08:42:50 -0400
In-Reply-To: <1382618536-25320-1-git-send-email-denis@eukrea.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Thierry Reding <thierry.reding@gmail.com>, Denis Carikli <denis@eukrea.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Fabio Estevam <fabio.estevam@freescale.com>

The eukrea cpuimx35 and cpuimx51 have a tsc2007 touchscreen controller,
  so we turn it on.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Eric B=C3=A9nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/im=
x_v6_v7_defconfig
index d8a52a0..23ba17d 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -130,6 +130,7 @@ CONFIG_MOUSE_PS2_ELANTECH=3Dy
 CONFIG_INPUT_TOUCHSCREEN=3Dy
 CONFIG_TOUCHSCREEN_EGALAX=3Dy
 CONFIG_TOUCHSCREEN_MC13783=3Dy
+CONFIG_TOUCHSCREEN_TSC2007=3Dy
 CONFIG_INPUT_MISC=3Dy
 CONFIG_INPUT_MMA8450=3Dy
 CONFIG_SERIO_SERPORT=3Dm
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
