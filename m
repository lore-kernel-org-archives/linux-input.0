From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: [PATCH 2/3] doc: dt: Add documentation for e3x0-button bindings.
Date: Thu,  8 Jan 2015 22:02:50 +0100
Message-ID: <1420750971-21812-3-git-send-email-moritz.fischer@ettus.com>
References: <1420750971-21812-1-git-send-email-moritz.fischer@ettus.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:64574 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755910AbbAHVDa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Jan 2015 16:03:30 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so5893847wid.3
        for <linux-input@vger.kernel.org>; Thu, 08 Jan 2015 13:03:29 -0800 (PST)
In-Reply-To: <1420750971-21812-1-git-send-email-moritz.fischer@ettus.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 .../devicetree/bindings/input/e3x0-button.txt      | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/e3x0-button.txt b/Documentation/devicetree/bindings/input/e3x0-button.txt
new file mode 100644
index 0000000..751665e
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/e3x0-button.txt
@@ -0,0 +1,25 @@
+National Instruments Ettus Research USRP E3x0 button driver
+
+This module is part of the NI Ettus Research USRP E3x0 SDR.
+
+This module provides a simple power button event via two interrupts.
+
+Required properties:
+- compatible: should be one of the following
+  - "ettus,e3x0-button": For devices such as the NI Ettus Research USRP E3x0
+- interrupt-parent:
+  - a phandle to the interrupt controller that it is attached to.
+- interrupts: should be one of the following
+  - <0 30 1>, <0 31 1>: For devices such as the NI Ettus Research USRP E3x0
+- interrupt-names: should be one of the following
+  - "press", "release": For devices such as the NI Ettus Research USRP E3x0
+
+Note: Interrupt numbers might vary depending on the FPGA configuration.
+
+Example:
+	button {
+		compatible = "ettus,e3x0-button";
+		interrupt-parent = <&intc>;
+		interrupts = <0 30 1>, <0 31 1>;
+		interrupt-names = "press", "release";
+	}
-- 
1.9.3

