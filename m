Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107268;
	b=DWwKg+VZnssP4D8/t+lIYkC5P7E/x36+lQ+nqpd2iLCFSnDRZkbyiWdsKaOibzHNWcRm
	 2DHyL1fvjUCWabNpVUDXbNcKOBi81qj26DprhVcaaOm1n8eBLj6s+CF+n8aEUT04Y4j/0
	 ZLK6Ys0rR6K6P00iE8f3bH08JbsXJTP9SaoRY8+gKmrKp4GSw8VY6u3nG+SdTIlHmBzOB
	 0rYQ0a7vffIbB/r+J9VW/Ll5XCyYdc1tuSFhxk3wCo0v2dSrAURtHdAIN7wqpV6lT5P5W
	 CmLTdKzcWjmQM8AEKDm+SlTYbuQ0mk38yGsmPNI5dVw8aB6jTWluI946VLXiYBaB/Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dsLmXofWh30s/RrFp/am5k44VgINvU+/ItmDuae2D4c=;
	b=3P77Ot1yisqilacdUjvhBarB5o1XQWx7E8py7X/wrRIC4NDS2grnJZNTHl6isQ1VjMHH
	 +JmI40sQOVSjnF6/+WMHeJ2EAdqngOYFWepikgEdabCX6yIy+3U8bNSvdf84WglCBNmsI
	 zN47aZurta/YSlrrKCZZbZI3h4npzNS5lhymVxxofHJIZVO80X8PDgv2CMuc211g2vOzC
	 mIN9YazGYVu+ymLsXIC/YW/7k0b0JYWn+j5ki2J1RPPFciNwwE2sMctM3gJEW0+Q/Rqg3
	 f4uiClWsNG6PSS3yTU3FC0aaH3TPBvzQ5EQ6UgwXZXVaXoNL8/pUGWTEhgTa6/cTA9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dz+ZDg7C;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3058E60A262D
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 16:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3058E60A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dz+ZDg7C
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso22889855e9.3
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 08:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795107266; x=1795712066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dsLmXofWh30s/RrFp/am5k44VgINvU+/ItmDuae2D4c=;
        b=dz+ZDg7CRoUAxyICkSfyyt6wC/1KPGEqzo6Ii0+kewGp5nMjcEcYBTNjCXpxudpTjY
         R4Qf56JeUTKBjp3XPtzj6l2GLqtNky/bHv7lF4XyrVUfn2EDEw4PkRz1Wtz+WWAfXIGd
         phBHsiu1U4d31BS9e+pAE7DvsO3BPO99HGwRYogLtlgIXsrtq4bH0obS6t1dfhAshXtA
         Wn63K/4tBHKKWFrLr16DbwIK8iWjU5FTus85uzB71BynMtTtDDjV5H6lnuNIo7erzuNc
         /IaAJGbfIsArR69wiB+2BSjF6AiYqNd/gUBzgfhOR5HATERekqG90JczQSH9Oh/nn60/
         fbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795107266; x=1795712066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dsLmXofWh30s/RrFp/am5k44VgINvU+/ItmDuae2D4c=;
        b=UaNacvBqdDteOHXSWdAZdholkCUISdvJstf2doduKa1JEKh7zMMD3aRkw5B9UjZpWc
         yrRDIyAlReYMbns/fcBBh0Mvfm5y96tkuUGJTrzTnvthnmhq3RLb1stDZx6pvdzyEhuA
         BR4WagMKxPJd+XOVPomDGE3cBR5KQVimBBpRjn1cyOtN60osJfhBCIY+bKRXm8vmKqkk
         35QolYsd7NPz9cnYdNQE0sz2Ghwi/YDG/1yUVAIhZmBi7Lcag1hTTJCLnZiClraJDs3e
         9H2c1OWv0ghm2MlqUh8kJV1yHNUjNCJOs/9KUZT/MiPVOkwfenaqGJ/tq5ZOmVEsgER3
         XvPw==
X-Forwarded-Encrypted: i=1; AL+hErEdXWWd6dTPOEb1HEdeM58w0/ppCJZHE6NwDOH33JtihLfFeT9Vmok1OD0LTxjUIxTVgBRZrRRux5u+UQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9FvpJzvlBgsHQkxqgCgugnaF72xFGnAr0YAzF4HIff3AP7qwXr
	cEoOsHYhfdprbGcHxJC9PIpvto/YAxkvG506AG31ZbfbfJgUhUrbzWxD
X-Gm-Gg: AYBFou0kxXt2wFR7AQS6aI1i1K2uHDs4tj51HNPwEMiP8+G4fXqWkX1vrEqiI9KhvF3
	7d4W1a7Yxo5Wu/5jgu26N129/h1U8h0yNkrUamdw3S0JL5PxDMyo3ImjnDIuj0DAxxNm9WBlZSY
	/WGu1//5OBVvFp50eilbpUzW3o7IVZyajJj/Y/sXBQm7UHjubhQw0bdiiqKazI1eJAAOjLNV0FJ
	C9cmj9t0PXXZMuCnNDRAyrWDNDw9sHvEKkQnZDQ6XQaDQDwfzJ1My8wK4WQMXlKJWuHneE4Zh01
	02u2D7FsqDfpEr/m8KRPlwk3cSxptgcObwTZuw/Fje8I6eWbsLKeHcDAX2Fyx9kECypuBhP2PiC
	PRhZ2oMQy1DPHnH9J6fipfIdMMn7jXIcWbL9eo+LLD8u1SfUVgZqtf3JhderTZ9ddTeDPOvMgIJ
	2iZ27x5pXbiGY2SH/bu+ftk9fHxy5VDU8aAHTMOjgyZf9SWJLrU+LnTt5HO2g5Rzhl+5Zub2+Q1
	XgqUi9D6mHTOE+DuGozpMNom/rT/uSViMf4LHxT4HsEn7eC7hdicjyx5JpKrcFCMSj9s9A8r4QB
	C34yPlDrg+EEHXmTZaY2Z+/PN5pYR55kQs+P4w4Qm3QEVxiNBFjQcNb4O/NsR8aUGN6f+vpd/gA
	=
X-Received: by 2002:a05:600c:310f:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4bb8881f9b7mr1875815e9.34.1795107266548;
        Thu, 19 Nov 2026 08:54:26 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm9894555e9.0.2026.11.19.08.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:54:26 -0800 (PST)
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
	Ivon Argel <ivonargel13@gmail.com>,
	Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v3 03/10] dt-bindings: display: panel: add LG SW43103
Date: Thu, 19 Nov 2026 17:54:13 +0100
Message-Id: <20261119165420.24466-4-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261119165420.24466-1-rofikcoga@gmail.com>
References: <20261119165420.24466-1-rofikcoga@gmail.com>
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

