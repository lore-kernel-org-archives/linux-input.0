Return-Path: <SRS0=81TE=X4=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AB5C10F14
	for <linux-input@archiver.kernel.org>; Thu,  3 Oct 2019 06:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC55222C7
	for <linux-input@archiver.kernel.org>; Thu,  3 Oct 2019 06:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="jzXNuTst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfJCGNF (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 3 Oct 2019 02:13:05 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:44198 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbfJCGNE (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 3 Oct 2019 02:13:04 -0400
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id 984FBA097E;
        Thu,  3 Oct 2019 08:13:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1570083181;
        bh=xdnbhlP5VZbX9psldGdVTegnvgtlaS1Fp9fUYQIGahc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jzXNuTstAvIRcwxw0uaMz8WP5eiNlVYqcxVHcXy6k2MuFix+Owq2QWpSAN4aZHoTZ
         OsDVix5LvcztbDzQS720x6g7Xtc1wTTvUTgeeM8wFpvxwlF1IWwAwiUMsh15uUv4+m
         RetB633fnFBW7m/qIfY4BBwCT/FiW/fP1kqwHtrQ=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH v3 5/5] ARM: dts: imx6dl-yapp4: Enable the MPR121 touchkey controller on Hydra
Date:   Thu,  3 Oct 2019 08:12:56 +0200
Message-Id: <1570083176-8231-6-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1570083176-8231-1-git-send-email-michal.vokac@ysoft.com>
References: <1570083176-8231-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Add the touch keyboard present on Hydra board. The controller
is connected only using I2C lines. The interrupt line is not
available hence we use the polling mode.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
Changes since v2:
 - None

Changes since v1:
 - Use poll-interval property name instead of linux,poll-interval.

 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 13 +++++++++++++
 arch/arm/boot/dts/imx6dl-yapp4-hydra.dts   |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index e8d800fec637..6507bfc0141a 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -4,6 +4,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/pwm/pwm.h>
 
 / {
@@ -330,6 +331,18 @@
 		vcc-supply = <&sw2_reg>;
 		status = "disabled";
 	};
+
+	touchkeys: keys@5a {
+		compatible = "fsl,mpr121-touchkey";
+		reg = <0x5a>;
+		vdd-supply = <&sw2_reg>;
+		autorepeat;
+		linux,keycodes = <KEY_1>, <KEY_2>, <KEY_3>, <KEY_4>, <KEY_5>,
+				<KEY_6>, <KEY_7>, <KEY_8>, <KEY_9>,
+				<KEY_BACKSPACE>, <KEY_0>, <KEY_ENTER>;
+		poll-interval = <50>;
+		status = "disabled";
+	};
 };
 
 &iomuxc {
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-hydra.dts b/arch/arm/boot/dts/imx6dl-yapp4-hydra.dts
index f97927064750..84c275bfdd38 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-hydra.dts
+++ b/arch/arm/boot/dts/imx6dl-yapp4-hydra.dts
@@ -45,6 +45,10 @@
 	status = "okay";
 };
 
+&touchkeys {
+	status = "okay";
+};
+
 &usdhc3 {
 	status = "okay";
 };
-- 
2.1.4

