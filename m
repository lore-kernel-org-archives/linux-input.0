From: Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH] dt-bindings: input: ti,drv260x: fix typo in property name
Date: Wed, 12 Jul 2017 15:13:22 +0200
Message-ID: <1499865202-19337-1-git-send-email-andrea.merello@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35949 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752517AbdGLNNo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Jul 2017 09:13:44 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Andrea Merello <andrea.merello@gmail.com>, Francesco Diotalevi <francesco.diotalevi@iit.it>

The driver looks for "vib-overdrive-mv" property, while in
documentation we have "vib-overdriver-mv". Fix the doc.

Cc: Francesco Diotalevi <francesco.diotalevi@iit.it>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 Documentation/devicetree/bindings/input/ti,drv260x.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/ti,drv260x.txt b/Documentation/devicetree/bindings/input/ti,drv260x.txt
index ee09c8f..4c5312e 100644
--- a/Documentation/devicetree/bindings/input/ti,drv260x.txt
+++ b/Documentation/devicetree/bindings/input/ti,drv260x.txt
@@ -43,7 +43,7 @@ haptics: haptics@5a {
 	mode = <DRV260X_LRA_MODE>;
 	library-sel = <DRV260X_LIB_LRA>;
 	vib-rated-mv = <3200>;
-	vib-overdriver-mv = <3200>;
+	vib-overdrive-mv = <3200>;
 }
 
 For more product information please see the link below:
-- 
2.7.4

