Return-Path: <SRS0=+R2U=4Q=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20974C3F2C6
	for <linux-input@archiver.kernel.org>; Fri, 28 Feb 2020 01:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC085246A5
	for <linux-input@archiver.kernel.org>; Fri, 28 Feb 2020 01:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="d62hkHQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbgB1BCX (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 27 Feb 2020 20:02:23 -0500
Received: from hermes.aosc.io ([199.195.250.187]:45214 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730148AbgB1BCX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Feb 2020 20:02:23 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id C17734B3D1;
        Fri, 28 Feb 2020 01:02:17 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ondrej Jirman <megous@megous.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: input: touchscreen: add compatible string for Goodix GT917S
Date:   Fri, 28 Feb 2020 09:01:44 +0800
Message-Id: <20200228010146.12215-2-icenowy@aosc.io>
In-Reply-To: <20200228010146.12215-1-icenowy@aosc.io>
References: <20200228010146.12215-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1582851742;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
        bh=Jg1jO+WxbhVjuN1AaAS0cnMrPopTgQ7H+WzftYXVnhY=;
        b=d62hkHQ/CqvF2ocRNpLb8ySENCyFTSBTm4iraT1oTlZP+qoahVoY9n0PBWdjPJC4pcE+C9
        jsB1f8iG1xuHwQagRkJp1nkV35BynSvuUaIbp2eBjasgrLFILzo4J2oKTUzOJoybqupapb
        wQYQgVXxFEHYCZSuo8xj3gOktVSdJE8=
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Goodix GT917S is a new touchscreen chip from Goodix.

Add its compatible string to the device tree binding.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Acked-by: Rob Herring <robh@kernel.org>
---
No changes in v3.
Changes in v2:
- Adapted for the new YAML-based binding.
- Added Rob's ACK.

 Documentation/devicetree/bindings/input/touchscreen/goodix.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
index d7c3262b2494..109e5ca8d6e8 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
@@ -21,6 +21,7 @@ properties:
       - goodix,gt911
       - goodix,gt9110
       - goodix,gt912
+      - goodix,gt917s
       - goodix,gt927
       - goodix,gt9271
       - goodix,gt928
-- 
2.24.1

