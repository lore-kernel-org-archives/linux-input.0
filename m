From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH 2/6] Input: pm8xxx-vib: sync device tree bindings doc with the driver
Date: Fri, 31 Mar 2017 12:15:34 -0400
Message-ID: <20170331161538.11657-2-damien.riegel@savoirfairelinux.com>
References: <20170331161538.11657-1-damien.riegel@savoirfairelinux.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:36880 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933144AbdCaQQk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 31 Mar 2017 12:16:40 -0400
In-Reply-To: <20170331161538.11657-1-damien.riegel@savoirfairelinux.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kernel@savoirfairelinux.com, Damien Riegel <damien.riegel@savoirfairelinux.com>

The driver uses a hardcoded value for the register, so the parameter set
in the device tree is not actually used.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
index 4ed467b1e402..86ce95fc6cf8 100644
--- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
+++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
@@ -12,7 +12,8 @@ PROPERTIES
 - reg:
 	Usage: required
 	Value type: <prop-encoded-array>
-	Definition: address of vibration control register
+	Definition: address of vibration control register. This value is
+		    actually ignored and hardcoded in the driver to value 0x4a
 
 EXAMPLE
 
-- 
2.12.0

