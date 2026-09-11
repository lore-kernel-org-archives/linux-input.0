Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1688A37473A
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139779; cv=none; b=JMpgVXA08sRX1Awf2Rg9b/oBLNVCQbRDYCFPF7iOqfsHhW3hDIB8pQfcaWQrisO4tithYjJbpeudPpC5QQ9Ace0xyRfN8G3FpNvxLMrg2CbE4GzqFw1sErK0Kyl8/MzdRYxhEK6QNyoDhVh9jJZvc9Qcjobund3+EQpV+3X/e60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139779; c=relaxed/simple;
	bh=8AhNBKZpnaYUD2pQxjChPO5qgquyOMhWXmxX3P9/qnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lxq6tdytksNiyyoxvnZ9HOn1XgNvM+n4prEAL1R7lL+2oQWvGp/DIN/XKMK3ntT+2mgLau7mWJqDQH9zD3xn3S50sapWuHgSieAUYqmHkDuC0zbucuuCcdBOGpanTk/9krgaJObO/6StiXcjfIY2wPqTgiKSaN9pm29eumjjqt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=H6mxH4D4; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="H6mxH4D4"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a9a4dc8afeso1646845a12.3
        for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 08:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1789139775; x=1789744575; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QuBzPHoSnBjRL86Zizr+XKaGzMxevhAgb2XWxWkSVN8=;
        b=H6mxH4D4VnGGfHmT0ag9DjctgtlupAtfzOAbpqHc+0+Y4krVg52rRNWmeTeM9yWdYU
         P3IBSloqqNkx0n9xCzcsW2AfeElvPyyg2ZdZKYLOZJD9ALJxuRUKzbSZ1mai7JctKyF9
         +SlmrE4NLlzFGY4sF17j5vqylen+JWu/+mkzC/TCcuf9A9LmtZ2iZUbzGAIR6kzMcUM8
         B0fqdjUxnnnI/Nr3IU10O/+slWjmfKuCoEmWR9+3XyRTwcc4eOjJGg2IKBm+HgBhfPrf
         y1tdx+2qsY77+V2JCTe76pp5hYyjzNkNYHmeQBSyiFg/66F1W+TB7mrfrwfHFmwNAHIi
         ob6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789139775; x=1789744575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QuBzPHoSnBjRL86Zizr+XKaGzMxevhAgb2XWxWkSVN8=;
        b=aFuGp7H4846DGC3x1jom8LvdfvYBkLKGdSc/aWUQy3EupbyxeYtjBxsNFXDNd+YEeJ
         KUZkrnyPXmsvK29H4skN988Ye0dsawrlZbIJgNh6T6CJc+nNBpvIxX1ZwSO6xLwMyoav
         dbHavfBTwEWP1Q6f3erJ5LyQQJnVAsFKvlzIzPHdhhEp8qd5keG0orFmiRBMwasBXe/s
         1hljDLpLGEpW7rTLbLVXmsUdumXtKWFIT7fb81YkEh5r5F52Invkerh8iB+NLvzsM4Pj
         wVn8sNo7iKuCAWpjQ5XXcw9QQEmeQ7+X0YXrm9qExPy+LZOa+AlARSr8RVAXAquwDYuc
         GOlA==
X-Forwarded-Encrypted: i=1; AKwUvBwI6nLDMScmqjCwaBqAk4HTAxDtdJ7NvXvnohpvhbKIi8NhLZajoi0QJGF2scbFey5QbKdc/C47hoX/6Q==@vger.kernel.org
X-Gm-Message-State: AFuF++mnxU8pmP4Hxbl8lNIozc/ii07eiF/dR4cbi4khRtmJlTZ3L2/p
	YsvQwPqtcWFKuKmVf1SCaPCsNF/ATCLBbk4kMbGwDAFm/tNQDp3G5vy6NdyD8uZFQn6bLhDcTjN
	1540x
X-Gm-Gg: AYBFou0WetOhinbTye4xFbLAeLXMcSVNXTvGGaItmudRrbHPJ9HfqamD/vnMW/Ss3nW
	RTi1r4PpbzmtdB1QhmdguVlaCdMKr5yBUJbd04mVYIVamf+PKWPEOy6sqFAgQn5cgdDV/v4/7XX
	4ZZZwW/1JYUxEzN++yoVgXKohP58Xt/fiWbxhJvCFu6Ncg2jACumofg8T0XtJQ4FjQdQy8Eswwm
	UwNGo10l1L0H8qbhXUSZPO2ZiEAh1g+oXRvBMFyGdDI8RdC5SncNCxkmgksSHTCf5vynvHqDnSE
	Jlb2LVX802fe66NQsf+7lZNsJog+dhDsVv6jF+wwTzKn6ppldFQHvNSyZQ9kfHk4fgQUncyyCu5
	8kJDWr/sngRS68rNZHbOv7K8TkQbTnuqEIqg5ujc0uAwLSF614O9LF9pJJaPXdelHHKed0ySq21
	vQSXCbBCxHtus9W+obYHHuVhehK4/6034+1VdVsYwd+WONBUIrfXNQtQ9XCgtqvbErd2nXzJ5Sh
	10OFgzmf6KDU6sgVosFlHaaIeUea2vUoOZsLO6TMjasVeMDsQt1cA==
X-Received: by 2002:a17:906:6290:b0:c29:6400:ef8e with SMTP id a640c23a62f3a-c296671348bmr202563666b.42.1789139775315;
        Fri, 11 Sep 2026 08:16:15 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29660ba623sm94656766b.45.2026.09.11.08.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:16:14 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 11 Sep 2026 17:16:09 +0200
Subject: [PATCH 1/3] dt-bindings: input: touchscreen: document ESWIN
 EPH8621
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-eswin-eph8621-v1-1-db447ff9e445@fairphone.com>
References: <20260911-eswin-eph8621-v1-0-db447ff9e445@fairphone.com>
In-Reply-To: <20260911-eswin-eph8621-v1-0-db447ff9e445@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789139772; l=2508;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=8AhNBKZpnaYUD2pQxjChPO5qgquyOMhWXmxX3P9/qnM=;
 b=klm5WaCMDKqec15ANu9XtYr2/JmBMK+XJPgebCb8nmQlHNdiQ6PGH2kPZYx1us0RzXLSKLfl8
 5FNQAJ9XfH7C1PKqsY0VAh3Ov1W/+d4FyTZ6HK7k8FY5F5hY90iGJ/+
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the ESWIN EPH8621 touchscreen controller, which can operate in
SPI mode. Other touchscreen controllers from the EPH861X family (and
potentially also EPH8621) can also operate in I2C mode, this was not
added yet.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../bindings/input/touchscreen/eswin,eph8621.yaml  | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/eswin,eph8621.yaml b/Documentation/devicetree/bindings/input/touchscreen/eswin,eph8621.yaml
new file mode 100644
index 000000000000..03f981ba19e4
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
+additionalProperties: false
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

