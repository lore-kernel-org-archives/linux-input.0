From: Jelle van der Waa <jelle@vdwaa.nl>
Subject: [PATCH 2/2] devicetree: add vendor prefix for Zeitec
Date: Fri, 23 Dec 2016 17:32:14 +0100
Message-ID: <20161223163214.7716-2-jelle@vdwaa.nl>
References: <20161223163214.7716-1-jelle@vdwaa.nl>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:35467 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941722AbcLWQcb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 23 Dec 2016 11:32:31 -0500
Received: by mail-wj0-f195.google.com with SMTP id hb5so7730124wjc.2
        for <linux-input@vger.kernel.org>; Fri, 23 Dec 2016 08:32:29 -0800 (PST)
In-Reply-To: <20161223163214.7716-1-jelle@vdwaa.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: Jelle van der Waa <jelle@vdwaa.nl>

Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 16d3b5e7f5d1..a3d7608a5cb3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -329,6 +329,7 @@ xes	Extreme Engineering Solutions (X-ES)
 xillybus	Xillybus Ltd.
 xlnx	Xilinx
 zarlink	Zarlink Semiconductor
+zeitec  ZEITEC Semiconductor Co., LTD.
 zii	Zodiac Inflight Innovations
 zte	ZTE Corp.
 zyxel	ZyXEL Communications Corp.
-- 
2.11.0

