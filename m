From: Mauro Salvini <mauro.salvini@smigroup.net>
Subject: [PATCH] dt-bindings: input: tsc2005: fix vio-supply property
Date: Wed, 12 Jul 2017 10:01:11 +0200
Message-ID: <20170712080111.7094-1-mauro.salvini@smigroup.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from MAIL.SMIGROUP.IT ([82.188.252.231]:46664 "EHLO mail.smigroup.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933300AbdGLIL7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Jul 2017 04:11:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, Mauro Salvini <mauro.salvini@smigroup.net>

tsc2005 documentation reports that vio-supply property is optional, but
actually this property is required (driver fails with error if not present)

Signed-off-by: Mauro Salvini <mauro.salvini@smigroup.net>
---
 Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
index b80c04b0e5c0..5c5f80abe78e 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
@@ -6,9 +6,9 @@ Required properties:
  - interrupts		      : IRQ specifier
  - spi-max-frequency	      : Maximum SPI clocking speed of the device
 			        (for tsc2005)
+ - vio-supply		      : Regulator specifier
 
 Optional properties:
- - vio-supply		      : Regulator specifier
  - reset-gpios		      : GPIO specifier for the controller reset line
  - ti,x-plate-ohms	      : integer, resistance of the touchscreen's X plates
 				in ohm (defaults to 280)
-- 
2.11.0

