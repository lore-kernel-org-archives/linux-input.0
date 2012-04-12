From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH 1/2] of: Add Semtech Corp. vendor prefix
Date: Thu, 12 Apr 2012 13:20:12 +0200
Message-ID: <1334229613-678-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:54850 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761937Ab2DLLvn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Apr 2012 07:51:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, devicetree-discuss@lists.ozlabs.org

This commit adds a device tree vendor prefix for Semtech Corp.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: devicetree-discuss@lists.ozlabs.org
Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 6b6e465..19af408 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -44,6 +44,7 @@ simtek
 sirf	SiRF Technology, Inc.
 st	STMicroelectronics
 stericsson	ST-Ericsson
+sx	Semtech Corp.
 ti	Texas Instruments
 wlf	Wolfson Microelectronics
 xlnx	Xilinx
-- 
1.7.10

