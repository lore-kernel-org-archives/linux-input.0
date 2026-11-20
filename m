Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190101;
	b=AGCQG1sHXAjc0cvNoc8AJTUwTSDg2FEGH6lq1u0M9lH5KcyM/BzcC/heaXWk8D0K/hdv
	 ufeFDWU48ix4waeYK0j4UoeyOaqOo1CW51EmYGx4AMd9XiRbqRsPIKGT2DGFdzy2KIpBB
	 ZZYEcAZ9s8a84NnPvy9+Gao/3z3wbLz31LtI5mI7ykPGTz+olv4ujcUT84ngWoQmNfDsD
	 Xu8VEwz/75KcL24VADHwlwHZyGnU1NJdfuD/kPKWycrTGjwbJlKT/oAXrUU6ZLENbmwW+
	 VJOefSA4xuPTrmr/fcl6G+FlbOarWz319roXGCUREJuG+2MsZD2BcXnuqMrkALftNLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=t5vfznkr0ETpK/dRsbewXSnBOXbKtjjAozkIrt96x4M=;
	b=d7dKg7RbhnSpodhfzKiNUo63OO1uj83qtCKkTZv0L8H81To/0S1NxSAUCn7Gtayrzn8c
	 w8YTH/Sn0y/b8JDrX+HG6WbilFnJO2hISXBOAp5uWNQH+BnaNoa2cwenwRTmqJLLXPtnT
	 LrZmNpoVgCS63ibeSSFU7osfWgx2r/aPkKZhVgVCGmPcURbNBwGouqlH0+nCZvQmfLTK7
	 0fzKrWirhZSBXSXrqqq+WBoAZmfy2dVzqdDQLMorLKABHtNoGle4mPfwM785Q4wBXBl2h
	 sbogxuq6a3ogP46HtGgq4cO8v+bAXGTVoSoijnIJTelGWNWG4K/pH9cRN7VySHiLZkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xwF0frtf;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A152F60A3820
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 15:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A152F60A3820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xwF0frtf
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so10170745e9.2
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 07:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795190098; x=1795794898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t5vfznkr0ETpK/dRsbewXSnBOXbKtjjAozkIrt96x4M=;
        b=xwF0frtfkMY1/qxSag910+kpSRw/8ZVubpuHSxXAaNIq9SXBxwLe1oM92PaVz6Wyzj
         vxastdnUrSKlzDSgoIAQAcBH7hbsaPd5hq4pfvE0pJoJglVlIC1KVSOcER2nPgBLgG28
         F1eGt8MeHrxFOLnEU4gf0ZlgffcQwpKbgRUBTLzAin0a0I8t8gBOGm3zMez/zPaorjUU
         pfTYKnbXgR1nsXluRpvk5bdFa+5BxzTg9G83t3RyJJqJk9au6RC+zYZDpKgQfKg/4PQL
         FebUt9XOCiKmA0U9r0ueLv7OfuEBSZ6M4CLvZBWdSjN8DsD2jfRkjSxr/QLJCDnuwNIf
         HhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795190098; x=1795794898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t5vfznkr0ETpK/dRsbewXSnBOXbKtjjAozkIrt96x4M=;
        b=W4mlz4Phms3lYD82EK9clVka9CYn2wxh+fKeGAeBNxk8L105dhJlsICtATGiZB1BSI
         49HsIPEIM5Mdq/2kBO+kyEaRSyrzlUPkPSxEcy5pNKLt5WyPpZOu8c/C5JgTPm3eKdtZ
         Vz8rpF2tiBogpyZZcSkicOiIqyv4QQE5KCPij0c0h+5yAaXQ8VuZAa5LWdi3WJXBAJpR
         Bp2XHvpdsvRWKWvnosWPZen6n9RrOBsKX7aPWJqxlCLdmqEBoSFk82EISZ2wlHzVAaer
         lhCKm9ebtuHXAUfQ7uxdZJwdUScEpFDUMuIOEnZQf3M3yqQ3xRT88ToUCheR9m98cM5A
         VN+A==
X-Forwarded-Encrypted: i=1; AL+hErGWasptNgfZzAnZdhlA0MhmHwD1pHpfw1W0J466vzBqFKzlJftVo4YNlXcR2BINmH7d24WFr4my7635Qw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/CgvDDUkgTKt72SHkB0cLbBt/lHjAfnN9sMpGI+TieoL59zRfA
	qXwmNXwWdOTGOO+lVwUiNsMwvCQY/ZXBz8Kibp2qfBUw5+74F7jNm4ZD
X-Gm-Gg: AYBFou2PhW6BMSkUHRjXp8L3p5Rkd0ry+xsUYPh27oRod28B903PqRV85zN8jPyX1Or
	1D5oL8LnHkgN/oAQg+bDT5zpjfW7oiRfu2laI8BGJLbeiWOq8HNBNwBYwUzubLVr9d4tvBfsXnk
	a1QGj3NAQOivNxbKsoyq1Ut/KDxz+LyyzslUlHqi+J6hciNPBsbTWsIeAgeDz3Mg8XIAP5bEiEg
	fWEyH9f+Ud3y6N3D1jwwqOvGDVdN7FMqqP2UJvRPSV1J0Kbyi4cxb98iNHnXMQNW8H90sd83srJ
	76XkjJw8WS1UsAxDSeNfU4/BcLrOYrgsd8ADdEOkr8BmgP+CvZDP3lJkDQ/IvXLWnhdjYIY15xY
	fNPVU4klhe+XLk6he8/DxvGgsPnVocvifyZxGiPMeQ5PqUuMZ90cUpJt4JVd4LucGjbqsi+rGtD
	7QW4epixQwhjjkrp+KQe6ICeaUq3HJGettoGWEgsJ23iU62BclUyuJBLXI1qZkzZftqlMITd6vs
	69DnUN3V7K7krxDB2bMqKs7I9hUVQA+kEiPrD6CUdQjvnhCb5iqqQYWtfU0mK4B012MvDs6Sa8S
	Hc85n/smjTyvHFlOQiw4CNFbYYAPA8XCzegh2B6/4UbawAsiqDhnoJQtx+hXXUY4w4HWfY1OcSU
	=
X-Received: by 2002:a05:600c:3ba3:b0:4bb:6118:4c9a with SMTP id 5b1f17b1804b1-4bb88819940mr86535245e9.30.1795190097249;
        Fri, 20 Nov 2026 07:54:57 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a15absm83982635e9.9.2026.11.20.07.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:54:56 -0800 (PST)
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
Subject: [PATCH v5 05/10] dt-bindings: input: touchscreen: add Silicon Works SW42902
Date: Fri, 20 Nov 2026 16:54:44 +0100
Message-Id: <20261120155450.7719-6-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261120155450.7719-1-rofikcoga@gmail.com>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
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

Document the Silicon Works SW42902 I2C touchscreen controller, including
its interrupt, reset GPIO, power supplies, and panel touch properties.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 .../input/touchscreen/lg,sw42902.yaml         | 72 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
new file mode 100644
index 0000000000000..2d6d9b1500faf
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/lg,sw42902.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Works SW42902 Touchscreen Controller
+
+maintainers:
+  - Abdur Rofik <rofikcoga@gmail.com>
+
+description: |
+  The SW42902 is an I2C capacitive touchscreen controller used on the
+  LG V60 (timelm).
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
+    description: Active-low hardware reset
+
+  vcl-supply:
+    description: 3.3 V power supply
+
+  vdd-supply:
+    description: 1.8 V power supply
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - vcl-supply
+  - vdd-supply
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
+        touchscreen@48 {
+            compatible = "lg,sw42902";
+            reg = <0x48>;
+
+            interrupts-extended = <&tlmm 39 IRQ_TYPE_LEVEL_LOW>;
+
+            reset-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+            vcl-supply = <&reg_ts_vcl>;
+            vdd-supply = <&reg_ts_vdd>;
+
+            touchscreen-size-x = <1080>;
+            touchscreen-size-y = <2460>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 28e4aac18d44a..a29019d984393 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25835,6 +25835,12 @@ S:	Maintained
 F:	Documentation/fb/sm712fb.rst
 F:	drivers/video/fbdev/sm712*
 
+SILICON WORKS SW42902 TOUCHSCREEN DRIVER
+M:	Abdur Rofik <rofikcoga@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
+
 SILVACO I3C DUAL-ROLE MASTER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Frank Li <Frank.Li@nxp.com>
-- 
2.39.5

