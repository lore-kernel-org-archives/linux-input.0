From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v2 4/5] dt-bindings: input: add pm8916-vib bindings
Date: Tue,  4 Apr 2017 11:41:52 -0400
Message-ID: <20170404154153.19901-4-damien.riegel@savoirfairelinux.com>
References: <20170404154153.19901-1-damien.riegel@savoirfairelinux.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:55492 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753575AbdDDPmw (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Apr 2017 11:42:52 -0400
In-Reply-To: <20170404154153.19901-1-damien.riegel@savoirfairelinux.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kernel@savoirfairelinux.com, Damien Riegel <damien.riegel@savoirfairelinux.com>

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
Changes in v2:
 - removed documentation tweaking, let's keep it generic
 - changed commit title to start with "dt-bindings: input:"

 Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
index 4ed467b1e402..64bb990075c3 100644
--- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
+++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
@@ -7,6 +7,7 @@ PROPERTIES
 	Value type: <string>
 	Definition: must be one of:
 		    "qcom,pm8058-vib"
+		    "qcom,pm8916-vib"
 		    "qcom,pm8921-vib"
 
 - reg:
-- 
2.12.1

