Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160045;
	b=UIW1AEHtNA6D1tUHr8oUz6j26AcThkQ5HnL4zsNqPhZytM2q8IZkRehvFHkI9hgb+YyY
	 LP9fEGQYvVYc5hfkO7R2Hnfdmo3VfhGM2iQiYzV0OCD9UmIncBq+itN2MFi/JEj/YuVtX
	 i6NkrzFqHnwXm02n8batlRZuc9EYwWs9hBpab6ZM6sEjPR8PB6YNX+13irbBlVqF4dyKx
	 3KC1Q3UvUIkbyT+2neg0tjOJK8zLMFvaLdm8XmhYk6OxMKJsghfm5h527MqROBOp8AfIz
	 Q06i69ri7n6leYFfNoMjwN51qB2UQv1f6DpO5zAvY2qhiUU4tIdchXDqzeL5zffjBGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dsLmXofWh30s/RrFp/am5k44VgINvU+/ItmDuae2D4c=;
	b=hKUSkSpWO82wCbewUUalx5OBsd/4Zh6hggCaMHo2oZDqHgnRDfW8NAUUtaggM2IzL4g1
	 HwDgosXQd13Xbuis3DoBj4CxpIiHnhkIxY9jYWaTLVbLPGPJhK8QO4DFgViUatD1mkZfd
	 YIJWXcngEvMwT5cSCcSETQD/ZdmibrU/wBUrd79/UXU5LlLBRq4nl0f/yrXiTTw5ptCNA
	 fEPJ9WMaxHiUDWSqqhNmbDlUG0X/idViTJLbbc009kiiFfetedE2F51siY+gJIHre7rJg
	 pW5ugSxUgMV3VDjXu8RAVsmaYAxqsFazncEpdmoxZwI512LUpSh61pgxMDIgefjEUTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UGKPN5sg;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0DE60A261A
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 07:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B0DE60A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UGKPN5sg
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so4945645e9.2
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 23:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160043; x=1795764843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dsLmXofWh30s/RrFp/am5k44VgINvU+/ItmDuae2D4c=;
        b=UGKPN5sgnx/JqyrT4bunkDQklLznRnCu7ogj28UGxAtEc6KwzYIx1NZItncO3oCsy2
         WQwOTT4lqZnhEGkFTU2b0VsycWz3M8JsTUfgictNO4H7nhfo8Xa8SB5nE/4hoihOR+HV
         Iz93718IqHJWyQt97zdXQoV9pzVcMYIhwQCzOi/Q6u4n0TpTFiyCGzRrt53wHObDgLxF
         Xi3kUPiCfr4xbBx74tg/LQCT3qU9C9Tw0Ab5AOU4Xtu69qLTbTC3wJPvAMxWuXfC8r4o
         pAz8JNmmJFL1alSsFqn0U8j113YfwK3WZqXD7BRmX4YDkKQTGUWqTicnH/hJfPsct1Jw
         DWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160043; x=1795764843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dsLmXofWh30s/RrFp/am5k44VgINvU+/ItmDuae2D4c=;
        b=EbUi+usYBBxlzoB6Bu/BQdIlODrs23oTLqmRquNvjh/I261O7RoQUleC9XztgJMvvQ
         yZqFlrQith43Z8B1Vx9hBFx5PUa9Om6GBH0euKa2lOzIFeHN7bcZUmCp+YDrQ2H4oIzw
         zLsEAczOapiwBBYG5qNxUG0uIbyjbp/E+uehxP8PEjpNj7Qs61GcrswQ+BwC7hf5B/Xn
         z/KE3ygPrWN5Y4a5UUf5Q/I2oI9tauTwiq9FXWmsB+opbVI9Mg+kO2xXc1RWkvV+U80B
         LzrLren84SVIUNc1K54ObILvFHNWzl9jdvrTRxoRaDgplKiPjmAwO2e78dWoVZb5gbzP
         2qmg==
X-Forwarded-Encrypted: i=1; AL+hErHgyc9766K2kZhSemzFzYrGPRh9VI0N5tX1Full1YO/i37pN+BI6OAz+tfzRL1Gtxpg6HDka24/cn38Tw==@vger.kernel.org
X-Gm-Message-State: APuU4Z94EdBFuBdWCeO1aKfjjq2OTRhWNtxYeukXnUz+hBqwub8dYQju
	V94V4majADK4hC98EBTAE1pWneBTO5xF+XpMbjcOXgAXzc4+Ci+C+kWg
X-Gm-Gg: AYBFou2LBHCHBJs/uMdmjbup5SsUokaAm4pUWlWSmoNsv2oTc5PpxGV6dQJX+dPMvi1
	nw3FlF8yv4w6Gl7/rqMeCz1T9Cji2o2KIcVbd3MYyHHwA2IiOKjp67rIIv/EzthUi9GkOBKnegt
	uHMgInW4Rbgm4jfJiLzSCiWYin55QYI/4r3pKmbCSxwER55hN1sbqEHoqOVnjqawa0LpZ4uXrd5
	qZ1CADmy39e50Cs3lHuYClhA79j76pqbJJx7NWWrFFhrwCR6/2yAHtlSrpKRAP1QFittA6ATz3C
	b5V9p9NnUV0GnZ49d/HKRHIE9ydIFw59/9ePkgVXkwWh/1YRGZ7o9Gy5QMkcqyeiRA7DxaXQOfn
	juZ+hupJGXWOrRY4F1tyfNQbLL2Ef6lO3bFt15DvjwRxiYaNWkNQufrsiZVBX44k6nvUsXX7UFQ
	vlpO0NU3dMqXsOGuhVnEQMsOHGf7j1XCykg6jU7iX07/Vu7Xr7gmPBsNAXII0ciQqlDJ+1u4ZtS
	F80E/ZzMDfSumwTXe1n/PTGhS+GUIvB5o9hwRHBnq8aBEN3P3UiZrbiqYavZwC6/0AwYSF9coLN
	8kiJtJwy7SvFA0xu4JTPDq8IpieQgkjFXSM5/1urnR/mig/tWcP9kSZtRjkFFFxr8dI23XSKpYY
	=
X-Received: by 2002:a05:600c:5487:b0:4bb:5de1:e92c with SMTP id 5b1f17b1804b1-4bb88813157mr44144925e9.26.1795160043279;
        Thu, 19 Nov 2026 23:34:03 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm54154045e9.10.2026.11.19.23.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:34:02 -0800 (PST)
From: Abdur Rofik <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v4 03/10] dt-bindings: display: panel: add LG SW43103
Date: Fri, 20 Nov 2026 08:33:51 +0100
Message-Id: <20261120073358.10267-4-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261120073358.10267-1-rofikcoga@gmail.com>
References: <20261120073358.10267-1-rofikcoga@gmail.com>
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

Document the SW43103 FHD+ AMOLED panel used by the LG V60. The panel
uses DSI command mode with DSC and DCS backlight control.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 .../bindings/display/panel/lg,sw43103.yaml    | 69 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml b/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
new file mode 100644
index 0000000000000..7f44ac6672bda
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/lg,sw43103.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LG / BOE SW43103 1080x2460 DSI cmd mode panel
+
+maintainers:
+  - Abdur Rofik <rofikcoga@gmail.com>
+
+description: |
+  The SW43103 is a 1080x2460 command-mode AMOLED panel used by LG V60 (timelm).
+  It uses Display Stream Compression (DSC) over a 4-lane MIPI DSI interface.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - lg,sw43103
+      - boe,sw43103
+
+  reg:
+    maxItems: 1
+
+  port: true
+  vddi-supply: true
+  vpnl-supply: true
+  reset-gpios: true
+  enable-gpios: true
+
+required:
+  - compatible
+  - reg
+  - vddi-supply
+  - vpnl-supply
+  - reset-gpios
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "lg,sw43103";
+            reg = <0>;
+
+            vddi-supply = <&vreg_l14a_1p8>;
+            vpnl-supply = <&vreg_l11c_3p0>;
+
+            reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
+            enable-gpios = <&pm8150l_gpios 4 GPIO_ACTIVE_HIGH>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&mdss_dsi0_out>;
+                };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 80c1bfb66f8cc..594863936fb5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15211,6 +15211,11 @@ F:	Documentation/ABI/testing/sysfs-platform-lg-laptop
 F:	Documentation/admin-guide/laptops/lg-laptop.rst
 F:	drivers/platform/x86/lg-laptop.c
 
+LG SW43103 PANEL DRIVER
+M:	Abdur Rofik <rofikcoga@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
+
 LG V60 THINQ 5G (TIMELM) SUPPORT
 M:	Abdur Rofik <rofikcoga@gmail.com>
 L:	linux-arm-msm@vger.kernel.org
-- 
2.39.5

