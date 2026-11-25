Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.202
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575411;
	b=Q5dX1SqgY3BhPcZ5UZMX0+AnGOiZha+IztDLI8O03d1aSBTkoyH7SPscklTlB/QvLl7C
	 d0QnRKbd7XMkPs7vK2DdCOOt6QVYGP++0cKMJWJjbfLVJ4qk4hc7pALtCsFzi0sakWTB3
	 btH2p0E1iCTSwQP4yW/SFm821fOlb+x7PZACqPgrAjClJeHG06WsJ8xEURnU1/8/lzZSi
	 QtiQSMjzn1kxI2bZtA/m+PGcLAc/XqNFppWoQ3Xgvy//jYh7ix1V/oqn7uNLXdvSF8z86
	 ix7ywZLRgGzgnBWiA2CXTUIu0PIoGC9vD8ePAtkoU+bOzbKYIbQwPLDgD1VKQQNT9pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575411;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Zley+tZa5UBCEuXBe2RxpLK6JVeG8RJlYwhvm31EGek=;
	b=27cPcqryHrFPYZM+YZpHkwvhzVETF0p60FaINA0IYl4tZZu3Ppbj0g+GcqL7cQEpOHdH
	 kCXNhOiNF88NWAm3ZR7CCBz2jgPJTm5yeqQyb5Eryb9UiUHQyRtv5tFPBd3dATrgVMMvF
	 LrLVLoKRjBUnfIgYLPLscPpodQ7NZ8f2nMX+YGUxl1tfbegf4pH7gBG1U+dZ6irlelVq2
	 FQJDTpiEH3VcR8iF0BgxsCVSxmNO8IqH0x9g2Gi0OjEPlXf6G2d2moG5bX24arT7yOMO8
	 vjMkjjL/K52+Qidgc9TQKQHaJ2udlf8vQHSNFORsFlj+C7d3dNR+ZzzCZVaNwUZ5nqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=IyEasHUV;
	arc=none smtp.remote-ip=203.205.221.202
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4554606A323;
	Wed, 25 Nov 2026 02:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4554606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=IyEasHUV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795575402; bh=Zley+tZa5UBCEuXBe2RxpLK6JVeG8RJlYwhvm31EGek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IyEasHUVYirj2s0q7+aqXXN4c9RIK5fJkRMmv4nVMTZgmgrJsldWqWXsnv0Blr7TC
	 WMNPGOkQ2/MdysWEphHDalTnilLEFQZZgZJFIDbyRKJfApO8uEEGy8uoPtrr3dMRsR
	 lm4DKVn2puSs7FOLCZowr0/xy2xVbZb0nf9p8+TE=
Received: from HF ([113.90.236.90])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E279BA4D; Wed, 25 Nov 2026 10:56:39 +0800
X-QQ-mid: xmsmtpt1795575401t5sfuvk7f
Message-ID: <tencent_381F4A5669DF8884104F17BF29A893E3A408@qq.com>
X-QQ-XMAILINFO: Nek/h3uRel9hgVaeMUs3m5dcYIM+V/s8+7pi9/cIYGznbuRQwfSAN32x/jd0hj
	 uAxIi3RgahNNGeKBSFZNHckH07rXJIoBgoixDuni4cpBcrQqMzzq4s5SVE/ZbbPljEQq/Vczzpvt
	 HNPTf4Tqn43VW8BkxFxyXJHb88zw83j9fEApyPQy1WQ78yxQf+u9VN9aD3vNJj7LvlZbTSVi61FL
	 aVklNZW50wqiwoGHGNidDJFgDLJMhNAvMsO2QkkF+beA2p5rXgryOOdkQPPJhlwn7IzkmLwcOE4b
	 a/9Hf+reu60c0IBtbjpDSQ+iyysW0+OVtD/YIeR2tBvJqOTEPNnkrrD+L+hTmFomC3laS0srbOyl
	 f9QEtgVcG2fy976HJTEjo0XJVlDqKwTR5WUoqzIx18prIYqXBQIlS8gG5tgwIdYJWefr3abl+33s
	 uNnfjoGX5dNzDqpS1UKuvcTL/Ci6RWGKGQyBoLGlznpENEVxX2I4cTQsYCw5/Wes+SidbCyJwv8q
	 IQAgJ9cC6sZ8IHlIycfB4DihX0X50X1PAy1C5o9wGq2snbl7M+90muM9cfX1aakPa8id0xcW/IA+
	 md8UQci29rcGZe8Piv3Y94uFSZeBbRD3i536KgN1gGKYMdcZas386NGYllw8ntYy28pyVzhZ/5Fb
	 n14087Q3QaUEOzOfKGynCV5jeL2mzQMNuZ7NemppfWZr3Rw2dawTHc73lq1gA2XUDucARWqoi+PZ
	 GON7qpdhJZwPm7SaMbRM5OTXw/lnWoVRR5krcmBMEXvXmglXHA2lgpgAQhdYYpX3yYoKJ/58HRxl
	 kazEMwarOc7LDRN9lE/bzsVST1cMEx8jkc2QHKg/DqdW3W1zW1JFG4Y6JqlwSrhv7yvV3kIiMbJt
	 8ab/97iNmenoIgkYefJwAVnRTFxGk9BPaOSM5ywCxR9lSMWp1CAWUIjlgi9BXcszEjSH15/ZaW+q
	 An97r4ckZluSToydXeLye0DswhxhraSDui5j1/30IpMMt+xfKH2RyXsHir3Ee/aOHLms7DOgY63b
	 2R38NgyAJu2Yyz1l+ClfwSpjZdxv5qGcpN6lPvUd8uXk7TnXCCCSZwxNPx8W6ezmfn5/EOb1OADm
	 77DoNtRjDZ/E4r8k+lOQqVO7Pbf4lAAqt5Bq9OIQquD+jNnqSSS5D8MRxohgoPXbwXUSlwUk76hC
	 XLLa4d1+HlbytNl+179Rk43uYP3PZ6ykEm5+0=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	conor@kernel.org,
	Hefei <3066883572@qq.com>
Subject: [PATCH v5 1/6] dt-bindings: display: add VIEWE 7KF82 JD9365TX panel
Date: Wed, 25 Nov 2026 10:56:33 +0800
X-OQ-MSGID: <20261125025638.1171-2-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125025638.1171-1-3066883572@qq.com>
References: <20261125025638.1171-1-3066883572@qq.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the device tree binding for the VIEWE 7KF82 720x1280 Jadard
JD9365TX MIPI-DSI panel, and register the viewe vendor prefix.

Signed-off-by: Hefei <3066883572@qq.com>
---
 .../bindings/display/panel/viewe,7kf82.yaml   | 67 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/viewe,7kf82.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/viewe,7kf82.yaml b/Documentation/devicetree/bindings/display/panel/viewe,7kf82.yaml
new file mode 100644
index 0000000..1ece390
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/viewe,7kf82.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/viewe,7kf82.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VIEWE 7.0" 720x1280 Jadard JD9365TX MIPI-DSI in-cell panel
+
+maintainers:
+  - Hefei <3066883572@qq.com>
+
+description: |
+  The VIEWE 7KF82 module is a 720x1280 RGB888 video-mode MIPI-DSI panel
+  based on Jadard JD9365TX. It uses two DSI data lanes and exposes in-cell
+  touch over I2C on the same FPC.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: viewe,7kf82
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: Panel VDD supply, usually 3.3V
+
+  iovcc-supply:
+    description: Panel IO voltage supply, usually 3.3V
+
+  reset-gpios: true
+  backlight: true
+  rotation: true
+  port: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - iovcc-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "viewe,7kf82";
+            reg = <0>;
+            vdd-supply = <&reg_vdd>;
+            iovcc-supply = <&reg_iovcc>;
+            backlight = <&viewe_bl>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9ac7e0b..9135da6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1739,6 +1739,8 @@ patternProperties:
     description: Vicor Corporation
   "^videostrong,.*":
     description: Videostrong Technology Co., Ltd.
+  "^viewe,.*":
+    description: VIEWE Technology Co., Ltd.
   "^virtio,.*":
     description: Virtual I/O Device Specification, developed by the OASIS consortium
   "^virtual,.*":
-- 
2.55.0.windows.5

