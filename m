From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH 1/2] Input: add touchscreen bindings for TS-4800
Date: Thu, 10 Dec 2015 11:11:11 -0500
Message-ID: <1449763872-572-1-git-send-email-damien.riegel@savoirfairelinux.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:58411 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbbLJQLY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2015 11:11:24 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kernel@savoirfairelinux.com, Damien Riegel <damien.riegel@savoirfairelinux.com>

Add bindings for the TS-4800 touchscreen.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 .../devicetree/bindings/input/touchscreen/ts4800-ts.txt      | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ts4800-ts.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ts4800-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/ts4800-ts.txt
new file mode 100644
index 0000000..63282fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/ts4800-ts.txt
@@ -0,0 +1,12 @@
+* TS-4800 Touchscreen bindings
+
+Required properties:
+- compatible: must be "technologic,ts4800-ts"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- syscon: phandle / integers array that points to the syscon node which
+          describes the FPGA's syscon registers.
+          - phandle to FPGA's syscon
+          - offset to the touchscreen register
+          - offset to the touchscreen enable bit
+
-- 
2.5.0

