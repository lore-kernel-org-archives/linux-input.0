Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107270;
	b=qc8ogxs0Xs4ic5lDuAKrbnOwY3bpO2HTHTG/B/uzcjTZHiLA9W+UWCVPK6nUudthJKX7
	 16qHqlHVajNuUWcout67uZbW9NSyz7z85DhDi73/oxJxAcn9MN4Yt//hZWcoyhL4vN2VE
	 waGq0q472lpbpTC6w6Dz5P2zrUZpR/QGCpxfqKEX5E3Cl9viDf/DNUJh3ezVxQ6RBYghy
	 QiHy6WaBdkb0CepmGlUDpTfVOF1H4DhU5qzmq0/BgTk5Z/w7l7PisCNHwq4N8rXGNVXjw
	 4X1wWJLIXO1KhpwTHdSlQXF2/cj/vWIwX1WgiaathyFd0XptqRV3g5V+R2vQOD00KjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VlPXjcEHW+lGnIptKKRSC5EQ8CQecxUOoIc+hyAGrok=;
	b=0hmtE51ShjmbUMNz4sgj2q/hA6BD0C0yqkRmqxPLYkTsMWUiJo65+MvsJ0BGVkmMnmQs
	 d2+aNWpg1X5dYGLUn9zVDEDdjIcLrPjbuQ5MROCIHe3rxErjrNUtKBVoCzx1qfjbtF3n3
	 8Fm2zNlN5MR68IoJt2jyH3zTYlLa+SUvbtyrzWOI88oMCUnE6Rxs0I1Hxd5k+MKyNJJIQ
	 T4z1vK/xSQ3ZQpJja4wIOoit9WrLUqvI7VtWiKBVpcQHkgqFrVl+HRjrsmbzK/rOMEMpE
	 2juPoEKk/31CSPNQIOdR6uHPfncYrcsUzY4fqBMRtkCJgv7pXuIBFkSShs9vFFstjDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R+5DdiOM;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581AE60A3811
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 16:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 581AE60A3811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R+5DdiOM
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4b467581b98so30224425e9.0
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 08:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795107269; x=1795712069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VlPXjcEHW+lGnIptKKRSC5EQ8CQecxUOoIc+hyAGrok=;
        b=R+5DdiOMtL80c9mcJ5/KFHY0ZO+dJukfZdTMC2UzdCESjd8f1Ba/Hc3GxX3xNxmVsL
         ZVbM7daQY/whHTYRSQ44gXKI/K8p7wFjj5fzydgXq9FHdiDNMf7UHIaSB1XvXWGhnv/m
         Yc4iPjIVuZr6a8fd6I3YnVVNGO2oJBhwb6XMEX0OO5H8Bw0x0bNj6qmEmnoPXB14KLag
         DUP+9XNzj+038+vk+FXla4L5LSkEkaMl22I0svP6z6myJoGAFCVFnkZmhZGFacxMxRUO
         cucQKdZtIa4k1xngqIh6GWtKQcDtwwoxmzOtybDXsTvU/2S1bsaJNw20j4Wh0K7gRLSn
         zFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795107269; x=1795712069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VlPXjcEHW+lGnIptKKRSC5EQ8CQecxUOoIc+hyAGrok=;
        b=fd+PYnJemwdIGMiy6QpCfUWLlRePz5hEFfvcpHCAShyPZl7nTwwq6sVvs8JVw2cZKE
         eXUoee8zTDYQ/59kfYSooiAJvnWErCU8QTGIdoZ+XwBvoCmqZ/sd8ceX/V1HWMBDVNuO
         39OKEyLbNp7xkq3eLuAHILBBvuU4xcjuujB3zmBCnVREGGBO174HjAyH4Y2Pxgqfmm6d
         R+WUVKEabjDwfH2vuu2xkasR98F82nZH0k7RMUTKW+SWtE2DvBGUvitCZq3bpOgQkiID
         Dj/w59Mo8i76KDEnku7ijyKZU0NHsfq70erafDRUQRnMbQcFMzpIjvlivkM437Tcyj0c
         K1pQ==
X-Forwarded-Encrypted: i=1; AL+hErF8jaz3HR8UE9EWSEY1q548MD3J0rRj98xehDiU5CtR/8qFmDmImVvptdz4uyfBbjYoWKRe6MZdUI1oLA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+dCeyJ1wjztKS7KWgIBKcZQ91iVZpOddEE4rvh5CHC+md35UNy
	IX+e4XCgasOfaGh5jbdZ6stOA7tcjaiIhs147MuIoT3K3+LcY/BrIxVs
X-Gm-Gg: AYBFou2ajIcDI3nCj3d/HEK6tt4gi9u+FnhVv6whHq2VKiH2dHfSJClDIg5kUsZidcS
	tOcPFZ8S9yEQ56BEswgOb4HPGTq9ugDgrVGaM23YkL59PY2eXf/nZ0+uEEQn1keNpnkAPdb6W8y
	bttXwTS+mMqHvV5VvIsZ1BQyh2L+4UQHwS6z6Ui17Q/9Gdbok7tytkl3IjI2XqG5weAFAPDn6bP
	dwEs6+KvuWC/WdCsqicyCQ4agn2zA/I9aQ5LEip316DyrM59cgvFrQxORmKfvfmYPZTBwsdLgLe
	8bVNXGapbT26+l++/gvWQsZnpE4qbUQPb5Wygqmor8ji5MdfCXMZqxa4nnB5CyvW7XYZsEyFxjn
	96tUYK3a+EBWTtxTecdRQbwZOLhv/j/zhSLoORLWml9vp7Vz4EJBxg16Z3pzhHaQLCGC33Oqk9g
	Xg1TxhWhdymwpqIv2lQOsLyR+s22Ej9MdA2VT96qWJSW2GBFcCAYmrGobb8qfUgeW/ALDzih8Ib
	86OdRL7qWVYdW3PcS/5Tyc7YdFx2R/O+ph85DOvxe5nyFl0eoGspxg4ompRC5QR0g35n/Y6mcHH
	nX7gv/mrjOJBLE/bpdEZXEwQS8LYAJCZI8ex6YGVRozH7JU8eKk772yR2KjxZDQxYkCkFFthw9I
	=
X-Received: by 2002:a05:600c:3b98:b0:4bb:7033:c92f with SMTP id 5b1f17b1804b1-4bb88826810mr1542285e9.11.1795107268658;
        Thu, 19 Nov 2026 08:54:28 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm9894555e9.0.2026.11.19.08.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:54:28 -0800 (PST)
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
Subject: [PATCH v3 05/10] dt-bindings: input: touchscreen: add Silicon Works SW42902
Date: Thu, 19 Nov 2026 17:54:15 +0100
Message-Id: <20261119165420.24466-6-rofikcoga@gmail.com>
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

Document the Silicon Works SW42902 I2C touchscreen controller, including
its interrupt, reset GPIO, power supplies, and panel touch properties.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 .../input/touchscreen/lg,sw42902.yaml         | 73 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
new file mode 100644
index 0000000000000..c5ec3bf4e545b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
@@ -0,0 +1,73 @@
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
+            interrupt-parent = <&tlmm>;
+            interrupts = <39 IRQ_TYPE_LEVEL_LOW>;
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

