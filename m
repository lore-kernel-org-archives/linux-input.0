Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D5EE7E643
	for <linux-input@archiver.kernel.org>; Tue, 26 Sep 2023 14:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbjIZOnH (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 26 Sep 2023 10:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjIZOnG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 26 Sep 2023 10:43:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0082E10E;
        Tue, 26 Sep 2023 07:42:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B10C433CA;
        Tue, 26 Sep 2023 14:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695739377;
        bh=uMjIAFfVnuWj2Z28spkl8zPcFTWWFYCo1rAP0UtIQ9M=;
        h=From:To:Cc:Subject:Date:From;
        b=LyaBuSKfQXWP56qsP4GUXh6c9xYn3Stl0nrozbD9NELYcX9GWWfrHRN1c+LaWHTQC
         ujH8Cd2PSKwwC8TyhjQITk4d+9MgHe1mvI1/Rx6ZPgmilP/003ndSf0MlMF2Y8vVL9
         0ioejwwvksqZBC3U1zlDeS4KQnZxWVns7TtNdUCc7xt4GS14zbxeyLV44QpswFtls2
         ecbJi85EWYNEC3TzGrwGyyfwgK4kSvZIG5WzmphClQfdJrrs0HBGRdjS/ETaS00QR/
         TMShVThH2OAz0Eidx7ZpHGyXl1lLuj9FF34xyxbgqDKaGSGjw8uoroLYuriUc4XqUS
         MURD2f38J/O+w==
Received: (nullmailer pid 4053487 invoked by uid 1000);
        Tue, 26 Sep 2023 14:42:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Vincent Huang <vincent.huang@tw.synaptics.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: input: syna,rmi4: Make "additionalProperties: true" explicit
Date:   Tue, 26 Sep 2023 09:42:44 -0500
Message-Id: <20230926144249.4053202-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Make it explicit that the not yet documented child nodes have additional
properties and the child node schema is not complete.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/syna,rmi4.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/syna,rmi4.yaml b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
index 4d4e1a8e36be..b522c8d3ce0d 100644
--- a/Documentation/devicetree/bindings/input/syna,rmi4.yaml
+++ b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
@@ -164,6 +164,8 @@ patternProperties:
 
   "^rmi4-f[0-9a-f]+@[0-9a-f]+$":
     type: object
+    additionalProperties: true
+
     description:
       Other functions, not documented yet.
 
-- 
2.40.1

