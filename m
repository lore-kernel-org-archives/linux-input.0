Return-Path: <SRS0=VlPx=YW=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8010ACA9EC3
	for <linux-input@archiver.kernel.org>; Tue, 29 Oct 2019 00:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424CB21479
	for <linux-input@archiver.kernel.org>; Tue, 29 Oct 2019 00:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="txcdpDXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfJ2A6Q (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 28 Oct 2019 20:58:16 -0400
Received: from vps.xff.cz ([195.181.215.36]:51658 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727441AbfJ2A6Q (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Oct 2019 20:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1572310693; bh=HlkHtBIrl2Pu/yMqJm7oISnuzbeLkbNyGnJaRkUbXDA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=txcdpDXcilixDJQpryeqFSA3pevzH5StDEHTo9UTXPMnP/dL0CHe2pudqWhYQZj80
         IP8Cxqot5KkvVCez+SqRfMVZHgLADbC/uFtlc51DvMQ+XmNfu2erqlQsq5GvSWYvW0
         hbyaWNp7IS8AmxyaR4wpE0zuLcdVHTABra9GsSTk=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] arm: dts: sun8i: a83t: a711: Add touchscreen node
Date:   Tue, 29 Oct 2019 01:58:06 +0100
Message-Id: <20191029005806.3577376-4-megous@megous.com>
In-Reply-To: <20191029005806.3577376-1-megous@megous.com>
References: <20191029005806.3577376-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Mylène Josserand <mylene.josserand@bootlin.com>

Enable a FocalTech EDT-FT5x06 Polytouch touchscreen.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 568b90ece342..19f520252dc5 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -164,6 +164,22 @@
 	status = "okay";
 };
 
+&i2c0 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5x06";
+		reg = <0x38>;
+		interrupt-parent = <&r_pio>;
+		interrupts = <0 7 IRQ_TYPE_EDGE_FALLING>; /* PL7 */
+		reset-gpios = <&pio 3 5 GPIO_ACTIVE_LOW>; /* PD5 */
+		vcc-supply = <&reg_ldo_io0>;
+		touchscreen-size-x = <1024>;
+		touchscreen-size-y = <600>;
+	};
+};
+
 &i2c1 {
 	clock-frequency = <400000>;
 	status = "okay";
-- 
2.23.0

