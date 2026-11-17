Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919197;
	b=JWKg749NdPJ1Xb3mhg2AzCBm/xaPAn11N4OX9FokVXUVcRk24w96/Kv0bQwttRp/Wfu4
	 Tg5oj5DZ5gxPXPzX0oUa6yyHd8okQUtfVFcSLrpmbtuklfB34/aM9hlJLl58O8bpC9SlJ
	 c79Y6x5zNFSPZIfyqFM+aHewjbBDcG9+L9QRfphgPjdJGeBPsXxGOPloYGj9mlk+xhrpT
	 hGV6SnuoRRt7pjsfL5gKtVZJbpxjNjmHrJfHxGlD7kmaWLiw0hIdGZ/70IqA5qET5/Z2+
	 v7cHp+La/KTOBRlWFBHYpzI09GHD+48PqanCURE8FlvHHOKkACRTmDeUTUKDUHDisSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=acRH3NbgLkYCK5iiPRFwHw3LXKQX8KfNDsHlQP+4/XA=;
	b=DO0bnnwfyUpZ164DR68Sauy6ihvJksCX9A6fijuSLRb8nZyVKGvVZmqOYNN4nblC9vbg
	 05wr0NNheYllNNG1FcbrRp3xUcxWtjKG7DLr+CDzNHVp1fB+/oWZB3Zz2oPos/fDJmJsJ
	 +tFA0KwMhGEsJ/gaWtoH8XSJE8v1E4oHO21eo1/QMUGwRJ8pW84nFKyH7DMjLsQAoDdFA
	 Jmip9zHwt2vJG/2YRGFNhwwt8s3Q5DHsV9fIq9vq2D4PdSkEtQNmY122thUFoXcTf27Xk
	 SsdWQchORCRgJYORtHuKPgY7Ool7RAVqUhNMsJGOt4YzGxU25j+PncmI1i3Uaier6AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y81t6W7a;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0762C60A3814
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 12:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0762C60A3814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y81t6W7a
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so11252795e9.1
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 04:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794919195; x=1795523995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=acRH3NbgLkYCK5iiPRFwHw3LXKQX8KfNDsHlQP+4/XA=;
        b=y81t6W7aTl95C4y9Rf0QU2nrD+sHK1morXML7lei63TX2FL3EWpNkN9I0aknlqyqK4
         gqHGoz2NXR8U0/otEEzXPgPNGzm/tI0i3FS0qTz08OkkknigPevlog1Q6m3RP7mq4xh7
         0RfSrVo1lbYrDa/L8TWUkyhwAHxnVHA0nNsFgAgAadTUbVUV7wpjcy+WqfOsafTXixTA
         A0Ksby2GTQifFsp4kd+zFwI7enrUtCAQxXxlWM3SNu3pqse7KFQHusE6UEAgcGgQRkpW
         PUcxqKnK+MccmXMoCZfVKYkegfkG4KcED9/9iyc1OUoDzS9PJPfwoWpqUo51uQ0qjeVK
         Tiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794919195; x=1795523995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=acRH3NbgLkYCK5iiPRFwHw3LXKQX8KfNDsHlQP+4/XA=;
        b=s5WnNg9KlbLEZvMJoGnaN4WTCaUuNugAJetZ5SuLpA2ywwslLBAvta2DQMU4IwmsdN
         sVdYkjiPl3sVKXjbpSn7AYVJEY7lfNyhQKv4yFZkZa17LaTlWgksecVhCsEhc8puZ8SM
         R8I2hBUFBTHPPU7K+N0B9X5lvqrT9Fy/7N3D/7g38jIdqnZthYll08KYDT2CMv7eACD3
         W01La7bsK/B02PYLShRYnDcAG17kwbv+D12Mt3I5FGRx7lg3aLZq+OMYUG7icsRuNFla
         OWqDGYG8GE02w6axX4+dM3tW2ghcG8B0pZ6NLkuRmWUeuV4eexzgPlJUC1mP4w7se0NT
         P4pw==
X-Forwarded-Encrypted: i=1; AL+hErEvVgQFnKhIFVHsdJdFpNYPWCG9VtMWiHDkE9HCYvLuh/tYNqYa45MAlpp9jSyXnPABLoZMCmIL64QGWA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8tSAsiHaO6j5DYm6NpQCetFeLcX3z0ZLDhCH781rtXwPai/B3H
	9Mlp2XcJF8fp8J2NGeV9VGzdjmcf5z1jSGvVSoUWLrZb+hKcNKQ/NgOG
X-Gm-Gg: AYBFou02k6lC7031DX/RJ+hVd0qIQH6eUe/FYZOBzJgrDXJnGOwVXo1y006wLyqA1wx
	CZS8UpCZPY2uteJ6UXSKvvteYRC2o1pHrWWVEhfuErtTNHYsGgMe44XOf+5IcB6BDl1SPt4Cc4v
	L/Ou922Xaez8au+ft8b0X9Wk5DY5DFnEUsI6IYyavMtD3FZrQWH9CTPl6R9nG33VkFAmBeMPE1/
	mcH3H/9oahryTsZrCdtVWADjMXbkm3HUKkgptWikeGOOE06FfxCDdTBDMbFouoo/zt50LETKT1n
	hlb262Dszc24kp7v9rG/4dcoTX8I1+q8waOW+9oTc+JF3fHxSm1nLBXjnzXfH+zJKs3W4aOi0GU
	WDpqDmc69g4eIUDZj1P8joKbOha0ETfnW23InqcNNwuFVrfntIhLUb9Kvmp0qH2+TXvAcTGSyBL
	+9IatMLoletkYhMljA0heGpmfRX0lqy/UaFbw18wX95CDVDEjc7yF36qUEuGIE4nUhR0QipdpyF
	bG3Ho9L9ov6IlNPZRXd0DjNwBzhlZpYVUQX7gphAlZN14xMkh9cYZh4w9i/1TrpQaKNGFbkVUHc
	p7Tkrpi8zCRnDc2+pO19YnZSo04rVe7A5H6pq8EiON7DuI4BLQVorqPvyj/JgQY3sIL4fg==
X-Received: by 2002:a05:600c:5012:b0:4b4:a551:681a with SMTP id 5b1f17b1804b1-4bb7837264cmr55075555e9.3.1794919194974;
        Tue, 17 Nov 2026 04:39:54 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu. [94.21.223.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:39:54 -0800 (PST)
From: rofikkerneldev <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org,
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
	rofikkerneldev <rofikcoga@gmail.com>
Subject: [PATCH v1 06/11] dt-bindings: input: touchscreen: add Silicon Works SW42902
Date: Tue, 17 Nov 2026 13:39:41 +0100
Message-Id: <20261117123946.668557-7-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117123946.668557-1-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
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

Document the I2C touchscreen and its interrupt, reset, power-enable,
and panel-size properties.

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
---
 .../input/touchscreen/lg,sw42902.yaml         | 74 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
new file mode 100644
index 0000000000000..c56cfb8530eeb
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/lg,sw42902.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Works SW42902 touchscreen
+
+maintainers:
+  - rofikkerneldev <rofikcoga@gmail.com>
+
+description: |
+  I2C touchscreen used in the LG V60 timelm JP DCM. The controller boots
+  its existing flash firmware; the enable GPIOs switch its 3.3 V and
+  1.8 V power rails.
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: lg,sw42902
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: Active-low controller reset
+
+  vcl-gpios:
+    maxItems: 1
+    description: Active-high enable for the 3.3 V rail
+
+  vdd-gpios:
+    maxItems: 1
+    description: Active-high enable for the 1.8 V rail
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - vcl-gpios
+  - vdd-gpios
+  - touchscreen-size-x
+  - touchscreen-size-y
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@28 {
+            compatible = "lg,sw42902";
+            reg = <0x28>;
+            interrupt-parent = <&tlmm>;
+            interrupts = <39 IRQ_TYPE_LEVEL_LOW>;
+            reset-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+            vcl-gpios = <&tlmm 67 GPIO_ACTIVE_HIGH>;
+            vdd-gpios = <&tlmm 68 GPIO_ACTIVE_HIGH>;
+            touchscreen-size-x = <1080>;
+            touchscreen-size-y = <2460>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index abdaabe16ed53..f4c54d7d86bd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25835,6 +25835,12 @@ S:	Maintained
 F:	Documentation/fb/sm712fb.rst
 F:	drivers/video/fbdev/sm712*
 
+SILICON WORKS SW42902 TOUCHSCREEN DRIVER
+M:	rofikkerneldev <rofikcoga@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
+
 SILVACO I3C DUAL-ROLE MASTER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Frank Li <Frank.Li@nxp.com>
-- 
2.39.5

