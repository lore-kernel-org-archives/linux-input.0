Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE38342123F
	for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633544; cv=none; b=dNqNIM2g+0XJ+CkW2LfwpMHeUUr553lGgT/En/ELolAw0Sa3znaGq9YLSXWGnfW6BG+fERCXJHNkPEViy7PBARsEVVk9ahKoUZMM2HoEgJvAvA0p10K6ZSm/MsRkKvpCuT5Ba+jWJbUGCLPBJYMzwIFg3Kgc/p/FGji7VscvKX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633544; c=relaxed/simple;
	bh=0M4sE/hfoJQ3CKEy3NN7fLe6+z2efpSPXuBLPdijfOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bKXf2J/dY0Xkh2mdYmDiy9dHqpvRoxeemFq89+wZT6TuPq0uhDbrRfhQYMeT/3pg0lt/fLfHsQEGZbzAuvqlepABCrv5d6ASCFuX1gds/TqH/mQWiyUl5k4dq42cqAGOpRqk0v1joN9sLIPnvbSD1o1I53HZkjBK2fFNhsyMyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=EH1U8rNV; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="EH1U8rNV"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f6c7a4aso77674666b.0
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 01:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1789633527; x=1790238327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H2L0ZhsQmTrZuxVtkeygootsPfgjhBA7S6bYd0vwJVs=;
        b=EH1U8rNVmy+OssuI2v6iA38ey0v7C2k+YMkHBYnCiLT33JTSoXrsNCSB56xHnrDO3/
         +Nvuh2Y3IwE5jb0uBVNjuf1rN7FeMPsH2cn4dS4DpK+sywmJTTDR/rupzgEu9WWoyneX
         vl6N5eBmflcBheSKrvbZ0WtFYMBs69Lx+Lqveg9REM5oovmEpSvkNdtno6EXV3PmI4JW
         XLGUrqOq5aWtnvyazNbk9p4zoEFFBL9WU3/VFhX5X4AXp2qD/Duint+F8lL59n60+riv
         fXc2KZ1pou2JOHV2eFd7SODs8sWgW7HUvHAfd+8lfIZOMVd/KNy5pqy12kkoW/xDJr5q
         GNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789633527; x=1790238327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H2L0ZhsQmTrZuxVtkeygootsPfgjhBA7S6bYd0vwJVs=;
        b=2Hk9zrHsi8BrUO5IKBjHDfkgcLPZWGZkqvi6ZqVj6flY7n6TKQf+o3o40snGMR8Hht
         DAcWbEbutmP2j9Jpd/WsoNEuLf01DsjtxIi4KyWN7swoZYj2SeqJYsb+VkCcsdCQsxBf
         iEtp6BvhqRiJKAxRdHTj9RsdXa9OQuyDtiFxmho8vc0Il1oCeFPVWb9uHfkMZZtBqrTp
         usj5VSTRdTM5ByWYMcG4oVTOhWorJ+pS6s0kiwZBzSsNVvUCtzv02nsCjzQtL9SKcBKS
         x8ayp04cL1J9WNHXuaydrDehqaGvaE9nqm9JIe27gRdNDu77OLkp1qNgjQSFSlO7YZ4+
         3PJg==
X-Forwarded-Encrypted: i=1; AKwUvBwhcG3OVQvOkycXNoxEhYwQ+773mpWIlmJz7RedIcONywLW4RzF8yulYirGfGPQq37JX7uEvMYy8XoKpA==@vger.kernel.org
X-Gm-Message-State: AFuF++m8Q3p9BW0AADTZIT+livyS/0hR1qb0VZdTC9+NnDwL6+QXKdaP
	h9vacrmcnytIq/OT5sEs5Irnu4Av/T/vBP94+pTeHmeha08Ny5gBrrxei2L/JUq95Q4xw+Q3VQE
	gJ0Ti
X-Gm-Gg: AYBFou0TjaOaUt2Z/sOWIROmbRWF9nBAh/EAWpK7GL9hPwzzjm5k8YigUms4VoadrHg
	40qlXFZ0VW+uASWSNydJhrN04TwFnQ/2J1aC6BhcVlwngXunsgc0leLfBoX7DLsrImY7Iqkvlk4
	ooX0/BRAy54ukFv6oqBg1LyHG9dFHhbOU0usVsko1wziFyMZr/xcQRNW+u9nmmkUsYZRjh+gtrR
	GGycssi4/B23ONrm6WnTxUzQN5XpLTZ+/WUVrlFhL8y9m/C3IAlYgtzVnsZaYi7mxVFY2HEDuN6
	AWvGqdYcCR3guG0fKV1KS2PmhQjseehhBatr/1IcVRQ1GMn8mO5/M0Dyff0060aFC2k6F0ML9H+
	CoDWpM+x+VkCRF4IohRPcUQlyVyntQq0QWPnCNTtu480rf4qFxGvB8bEGGajWrihA2NQ11y/U3d
	dT8lIWGl0y5N9KDSEI2Mw24HA/scCc6koBfS8ErPsvDAwDxGZP933shg1SMbFe1pfbYj849pHLX
	o8gSkkrguI9cgJ3+0THnLc4wtoteMVOeItNkjwWqpfpjwAB/kiJ
X-Received: by 2002:a17:907:3d05:b0:c29:6cb1:bc56 with SMTP id a640c23a62f3a-c29e532bea8mr428959166b.46.1789633527061;
        Thu, 17 Sep 2026 01:25:27 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de0851ebsm242943966b.4.2026.09.17.01.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 01:25:26 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 17 Sep 2026 10:25:23 +0200
Subject: [PATCH v2 1/3] dt-bindings: input: touchscreen: document ESWIN
 EPH8621
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-eswin-eph8621-v2-1-f534080a6338@fairphone.com>
References: <20260917-eswin-eph8621-v2-0-f534080a6338@fairphone.com>
In-Reply-To: <20260917-eswin-eph8621-v2-0-f534080a6338@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789633524; l=2581;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=0M4sE/hfoJQ3CKEy3NN7fLe6+z2efpSPXuBLPdijfOE=;
 b=LXWHrieBinkzfsTRaq07FaLKCin0Eu5cmjS6OAWA/r1KViaF57s4hblQsYFmgEQcnOHr2Cul6
 hY0762LRPc6AKstqWT1UE5YLKBty/MiBTvGODlIV2RMM1xsh+00KP8M
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the ESWIN EPH8621 touchscreen controller, which can operate in
SPI mode. Other touchscreen controllers from the EPH861X family (and
potentially also EPH8621) can also operate in I2C mode, this was not
added yet.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../bindings/input/touchscreen/eswin,eph8621.yaml  | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/eswin,eph8621.yaml b/Documentation/devicetree/bindings/input/touchscreen/eswin,eph8621.yaml
new file mode 100644
index 000000000000..ac7fa58644ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/eswin,eph8621.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/eswin,eph8621.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ESWIN EPH8621 touchscreen controller
+
+maintainers:
+  - Luca Weiss <luca.weiss@fairphone.com>
+
+allOf:
+  - $ref: touchscreen.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - eswin,eph8621
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  avdd-supply:
+    description: Power supply regulator on AVDD pin
+
+  vddio-supply:
+    description: Power supply regulator on VDDIO pin
+
+  spi-max-frequency: true
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-swapped-x-y: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - avdd-supply
+  - vddio-supply
+  - touchscreen-size-x
+  - touchscreen-size-y
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      touchscreen@0 {
+        compatible = "eswin,eph8621";
+        reg = <0>;
+
+        avdd-supply = <&vreg_l22b>;
+        vddio-supply = <&vreg_l9b>;
+
+        interrupts-extended = <&tlmm 19 IRQ_TYPE_LEVEL_LOW>;
+        reset-gpios = <&tlmm 20 GPIO_ACTIVE_LOW>;
+
+        spi-max-frequency = <2000000>;
+
+        touchscreen-size-x = <1116>;
+        touchscreen-size-y = <2484>;
+        touchscreen-inverted-x;
+      };
+    };
+
+...

-- 
2.55.0

