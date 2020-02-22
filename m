Return-Path: <SRS0=ep/6=4K=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77739C35669
	for <linux-input@archiver.kernel.org>; Sat, 22 Feb 2020 23:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFEC20707
	for <linux-input@archiver.kernel.org>; Sat, 22 Feb 2020 23:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="mBIbednI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgBVXVz (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 22 Feb 2020 18:21:55 -0500
Received: from vps.xff.cz ([195.181.215.36]:34178 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbgBVXVz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 22 Feb 2020 18:21:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582413271; bh=ZfpciIj4N/ohC5xxET/7O8AAxYB9cySsBo6ydi0t5+E=;
        h=From:To:Cc:Subject:Date:References:From;
        b=mBIbednIO0f1b1OU46STOHFWNVaSoDFgW9GXvd/AxkhWoElcraX72ilVHdTdRtHbB
         wS/hbfGVmYtFnU2ZvVuRqm1pmCotSeoX4JbTDB7OT3smhLf9ka5SZJNiQuZMjBJw4g
         o2Tapz8AEKRv0T6titDi7YC14Z3/qawG3YLziTMM=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Luca Weiss <luca@z3ntu.xyz>, Tomas Novotny <tomas@novotny.cz>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] dt-bindings: input: gpio-vibrator: Don't require enable-gpios
Date:   Sun, 23 Feb 2020 00:14:25 +0100
Message-Id: <20200222231428.233621-2-megous@megous.com>
In-Reply-To: <20200222231428.233621-1-megous@megous.com>
References: <20200222231428.233621-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

It is possible to turn the motor on/off just by enabling/disabling
the vcc-supply.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 Documentation/devicetree/bindings/input/gpio-vibrator.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-vibrator.yaml b/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
index b98bf9363c8ff..f8f4093a0a454 100644
--- a/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
@@ -24,7 +24,6 @@ properties:
 
 required:
   - compatible
-  - enable-gpios
 
 examples:
   - |
-- 
2.25.1

