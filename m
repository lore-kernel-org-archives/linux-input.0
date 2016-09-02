From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH] Input: gpio-keys-polled: don't use unit-address with button nodes
Date: Fri,  2 Sep 2016 22:17:57 +0300
Message-ID: <1472843877-6163-1-git-send-email-vz@mleia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:38445 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932187AbcIBTSC (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 2 Sep 2016 15:18:02 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org

The change corrects an example in device tree documentation section,
because button/key device nodes don't contain reg property there is
no need to declare unit-address, and address and size cell properties
are also redundant.

At the moment a compilation of the hypothetical original example
should produce W=1 level warnings, and it is better to stop spreading
misusage of the polled gpio keys device tree binding through this
example.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 Documentation/devicetree/bindings/input/gpio-keys-polled.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
index 95d0fb1..4d9a371 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
@@ -34,11 +34,10 @@ Example nodes:
 
 	gpio_keys_polled {
 			compatible = "gpio-keys-polled";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			poll-interval = <100>;
 			autorepeat;
-			button@21 {
+
+			button21 {
 				label = "GPIO Key UP";
 				linux,code = <103>;
 				gpios = <&gpio1 0 1>;
-- 
2.8.1

