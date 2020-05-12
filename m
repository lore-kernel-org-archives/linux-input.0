Return-Path: <SRS0=3AEP=62=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BCCC2D0FC
	for <linux-input@archiver.kernel.org>; Tue, 12 May 2020 22:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55AB924927
	for <linux-input@archiver.kernel.org>; Tue, 12 May 2020 22:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="ZSclaWce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbgELW1U (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 12 May 2020 18:27:20 -0400
Received: from vps.xff.cz ([195.181.215.36]:41822 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731524AbgELW1U (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 12 May 2020 18:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1589322129; bh=2kuqCfvBiBgSUuWgI49jTz7T7hYvoNkypGtcPc22suM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ZSclaWceGXKK8TlazmlVyjxbImVQl2CTSVLPfxDhZubC8op+g/z54lqTVRl1P09F4
         uM2G1V54TCT6q3NccRezPMtaEHcgOZz1Wr44lX2RsUU3eC1KaVrPftGaFUnlFHBif4
         DE/DEM5xwqDkELhUm0Az/4xdozKgpM9tkh8rH1p4=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>, Luca Weiss <luca@z3ntu.xyz>,
        Tomas Novotny <tomas@novotny.cz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: input: gpio-vibrator: Don't require enable-gpios
Date:   Wed, 13 May 2020 00:22:02 +0200
Message-Id: <20200512222205.1456300-2-megous@megous.com>
In-Reply-To: <20200512222205.1456300-1-megous@megous.com>
References: <20200512222205.1456300-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

It is possible to turn the motor on/off just by enabling/disabling
the vcc-supply.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/gpio-vibrator.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-vibrator.yaml b/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
index 2384465eaa19..c700b640bd53 100644
--- a/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
@@ -24,7 +24,6 @@ properties:
 
 required:
   - compatible
-  - enable-gpios
 
 additionalProperties: false
 
-- 
2.26.2

