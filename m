From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH 5/6] Input: pm8xxx-vib: add pm8916-vib device tree bindings
Date: Fri, 31 Mar 2017 12:15:37 -0400
Message-ID: <20170331161538.11657-5-damien.riegel@savoirfairelinux.com>
References: <20170331161538.11657-1-damien.riegel@savoirfairelinux.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:36896 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933152AbdCaQQl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 31 Mar 2017 12:16:41 -0400
In-Reply-To: <20170331161538.11657-1-damien.riegel@savoirfairelinux.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kernel@savoirfairelinux.com, Damien Riegel <damien.riegel@savoirfairelinux.com>

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
index 86ce95fc6cf8..4f968f02cad1 100644
--- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
+++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
@@ -7,13 +7,16 @@ PROPERTIES
 	Value type: <string>
 	Definition: must be one of:
 		    "qcom,pm8058-vib"
+		    "qcom,pm8916-vib"
 		    "qcom,pm8921-vib"
 
 - reg:
 	Usage: required
 	Value type: <prop-encoded-array>
-	Definition: address of vibration control register. This value is
-		    actually ignored and hardcoded in the driver to value 0x4a
+	Definition: pm8058/pm8921: address of vibration control register. This
+				   value is actually ignored and hardcoded in
+				   the driver to value 0x4a
+		    pm8916: base address of the vibration module
 
 EXAMPLE
 
-- 
2.12.0

