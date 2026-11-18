Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003641;
	b=pGI5YsZAKLelXdYW1UFkzzebNyV3Tc79FYuhu3m64x4b52hO0KdKvqCBFrax5XNOQ8OL
	 5jozX8SC8cHxD5TV4lAsZNH+ygtWSUuUEEuSmzdTbpL8jDXRKOhO/G0IcasPG5JUP6lCd
	 G40fd84Lswcp4vBAsE7M0Bw/3dYWZ6v7dVocuTeyZEDBT3fyhHikgVPlGYisk0cWI7qrJ
	 wjqponSAqvm4E/tlxdAusnQ8YB+XtZbuhJDI4sdg+bEasaHQRFHDxzPX5x36A2ZLEDL80
	 i+D0kq+JnK0mKdFVOx3Igqu6N1sJaOa3RSB94bNIKNq5XzQjEyh3g0PNvEBCNOFwm/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dsLmXofWh30s/RrFp/am5k44VgINvU+/ItmDuae2D4c=;
	b=VEbyoDqhjjtMrPn0zQxgolAh3PdAUcOXZcIbhQGnYllLubb5QDr6EZPSxDoBcuqwG8Vz
	 /CFyzoEZGMir1wz2kaInQM58TRx5GggEqFOoiKkWqNm+gVSMDtsonBvCCMzEfZbVNJiba
	 fLOueFOs+kkkPIrQUtLpS3KCeXcn20rikrL9YCM2ZEq7oXXCfoCeeWqEERpSEOT0rLk42
	 XAoSO1U4gmNvCusSrIcw/shVADDpEXZ8qSKs4NO0gfO+M+UgMSLxawCH4VrZziGA3NJZ2
	 ljwYDAh2X94zVBrTY+yKVkIl9ql68b2v/HAF5LkziuUZ7O2kPtqGVOu8k59SkpuSVNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JtmHmyg1;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A8360A262A
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 12:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33A8360A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JtmHmyg1
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso8650875e9.1
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 04:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795003640; x=1795608440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dsLmXofWh30s/RrFp/am5k44VgINvU+/ItmDuae2D4c=;
        b=JtmHmyg14Boyp9v535ErgQNT94x0DC7zP8DBwjHhodcFpFL40uBudkYtO7GookjHB5
         fgnu6n4vz9ahUXfO+yd6vWaZOCGSUscbc3nUv9FdtZUwyuYxWdKLRCQdnu4ckUGOFqVt
         lXY+L5N/SBAixdwwbzCxXUKFZ29ZTul7rCZmAsSNkvLD4jnvZFigWaGrObwsqmFQ6BgS
         RgJg62kfIcR4INg4bpKLb91vrF2OWFVyxwS4MkSRBtd/Lgp7XOZGGdTXEAvvONXmfRED
         AZgL6Jf4oBFJVq/DbYWVHrZ0uwqZ4UQqgO59l7J+925SACoeOnJNZUn7oSxlIstPoG+O
         jiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795003640; x=1795608440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dsLmXofWh30s/RrFp/am5k44VgINvU+/ItmDuae2D4c=;
        b=YySToYpw6SB4h3mzN3hW6K/A9yYjZ94QUdb4m2/77pYecC5E9HHtdAzksgBghcMd40
         iief/erqv7I6lOW3nbPqnW+DrthyjhgGCDtfLvQoHm1dS7SayjUCEcmbvVAgG/AjOJu0
         phI36xmx895jogiBqPe91uQNdJDCNDa2qcaBu9qY9754otHI6J+I6bXDCUkUpb+Pd2ln
         dAjA0k/k6AYChm7eevYPuVmQuuCyaznUTXv327J+3IDndZz5nICgWjo8KyFXW+c9Ojth
         NRNdguJDhfhLZcyAkgx2G72i8qniQ5EdryCrwyeRKMBPFMxuB5vnPUpOffH5LJ92Ul16
         sQ2w==
X-Forwarded-Encrypted: i=1; AL+hErGjsxvQnxd0mM2bVl/5sGa8pKUdCMsYTHeOL1wh3MZX0Zj8dXI7uTcLBsTKC2tn/9rtpQTJvjRqBtoZeg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8wlFZCS3aqKhxqEeqO/4vg6jvj3DUIObclIm1qjkVW73N3GJRr
	jKN7mXFfEA6AsPD/RnWbRCcnsXABVhZQc21KpGIVt4m1OuqaSyxo86vcURG+ywqahzINyGEP
X-Gm-Gg: AYBFou0xHlVRgqtzF9oLct4WaeLMRG3YXuEniq0YGG2NnBl/eX0oh3UcdRAWVH+S6JK
	PWUGzdxT1IXvRTcs07DrRzCpXk3jn7rXozk1djojlOW8PwUAH6CBzyc+XoO8Ip9TUY+CGgYV6sf
	j6v5biG+VQL+SEUBNQ8zt/h3xA44/G7MHQ6hKQM7T5OwCH+EXsiWD/Us3vHVLep5aDS/9leQZou
	iHqB0z1/9DDlYP6jADbMljaixyyUsDL/Q07zhp1sB/P30lAqgP4QZz2zaQUygkDuEf6fGgerqX8
	dBQajHJbgOteFWTY1wcVSqJqQxP3wPi5zu51ZuNlD1BVyWjKgxFbgZx2BoiYqrxPJVzpgWcKebn
	9ypJryeYjQv8mJvZofVXqi3n7cJ4CLNAPMcP5BGuv7fyYU86fpQB35bjWT77z0RlUbK4+NH1yps
	7LJZ/GOx7P5rCxb/Ztm4M3uz/15xk6RTwcnFoMC8p1KGluwDacXIZR6rGjhwmQwltvkLHqP/Bc1
	f73YHufze7nd/w3+CQTpwJcghKQ2dOn9OeXXRrwvgPWm4Ca4QALGqQrUCnWwUySX7xnkFv0JZ/S
	3XwdkNW4risc6mzqnwf8QsvS34k3OC+2qpET4YlunoK7zSOZnS8g6n84c/8FCL3mSccNPAa5fI2
	hLY2F0gXXLTlM7B8F/tgEwA==
X-Received: by 2002:a05:600c:354b:b0:4a1:9078:911 with SMTP id 5b1f17b1804b1-4bb7da4805fmr42799545e9.31.1795003639681;
        Wed, 18 Nov 2026 04:07:19 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c37fsm4382583f8f.18.2026.11.18.04.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:07:19 -0800 (PST)
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
Subject: [PATCH v2 03/10] dt-bindings: display: panel: add LG SW43103
Date: Wed, 18 Nov 2026 13:07:07 +0100
Message-Id: <20261118120714.31505-4-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261118120714.31505-1-rofikcoga@gmail.com>
References: <20261118120714.31505-1-rofikcoga@gmail.com>
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

