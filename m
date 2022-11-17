Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33232C4332F
	for <linux-input@archiver.kernel.org>; Thu, 17 Nov 2022 16:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbiKQQgS (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 17 Nov 2022 11:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240730AbiKQQfw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Nov 2022 11:35:52 -0500
Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch [185.70.40.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF605BD42;
        Thu, 17 Nov 2022 08:35:06 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:34:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668702904; x=1668962104;
        bh=j/4kwDCI6yUOY0rbKjZzBAtwpPVlmEC4din4OfwGdS4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=v5piwaPlqFYkj5womeFjfYDC5qiVpMjM7aWis7iwCbg7PT+E2KU9pAFaJ2GkDOW2z
         uergSTIvPHwyAOKlFp+3VgLV3THaOWMD4v641ZVYlsIRR0Sy3COF40lIg53UJOJ6eP
         Qc/qJOupnh/TnnVXTXFXFfGRqVI+FY5hEh6QwkT5KpOjRwpHTgz+3/jJOY10LBIgiF
         AM2ZfJWB3mAHbDJlvekjS7+m6eHTu+Ky46UdJzQqURGvaZL9O8JzHQDff1/HmuGeQI
         hCB30WO60muixsNzi4m3By9rGjhBwHBrI0uNpxrx0RMGCo3YryVC1F95XfeUkOv+Hj
         I19FSfScQM02A==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." 
        <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: input/touchscreen: Add compatible for IST3038 and IST30XXB
Message-ID: <20221117163440.23394-2-linmengbo0689@protonmail.com>
In-Reply-To: <20221117163440.23394-1-linmengbo0689@protonmail.com>
References: <20221117163440.23394-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Markuss Broks <markuss.broks@gmail.com>

Imagis IST3038 and IST30XXB are variants (firmware?) of Imagis IST3038 IC,
add the compatible for them to the IST3038C bindings.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
[Change from IST3038B to IST3038 and IST30XXB]
Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml  | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist=
3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist=
3038c.yaml
index e3a2b871e50c..85390f6ffe36 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.y=
aml
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.y=
aml
@@ -18,7 +18,9 @@ properties:
=20
   compatible:
     enum:
+      - imagis,ist3038
       - imagis,ist3038c
+      - imagis,ist30xxb
=20
   reg:
     maxItems: 1
--=20
2.30.2


