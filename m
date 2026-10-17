Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484AA3E3141
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792246128; cv=none; b=fkW01tethiz4UIpoarWxkeJhm0yAFe1awdyGdfM3kZRmCZv3vkuceoijjFVQGaO/3LfJlAF+MDzbEggMq1pcx4ABzxBo/Xhzu70zf8Y4IwYtQ5CLpmxGR5eSpJ5dF5BMMUzboGuddV43YjwsXG92DeKBwDu8VmDKyFJGlMmJ/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792246128; c=relaxed/simple;
	bh=bKnsHJpO5i8GgziQaWMpsYIY/GTwM5uEkuyyNJ78nzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gktj3FDsoD4wt+OzRTjtTxb/pmvtsT6/kZziwRNIE037xt+RrY7fMqP0zCG8cJcj1j2dgpgfEZco3zaGxsvY3u6Ru+F1h2mEpZerio8NZd6BAlbhZHky4E/xwGweqItGMRQM8U5GrmQlY5TF8Bk5yPfhDzIivMTEJ4lf9Bu1Pb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6dqWQU4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6dqWQU4"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so8098615e9.3
        for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 07:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792246123; x=1792850923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xhG+wnkOUndHgFqi7q5mTZCxcyMx8su188FBsGRE7dU=;
        b=N6dqWQU40B87WQHNZ/4Hf2AM+P6Ilk/ZkAXjjHt+OK6v3LJNUMRjURg+E++2xXgthQ
         Fs6ocjoVpxziMztvbi11MF1k/CB9OpPsWjvF0uObs1p6rpqU/n5B+G4u7r3pknSHrdFK
         IFffMQ3MKR/949EcxmRnQUZLu5f/uUtUYkuvYHqamVEdyZUrFQwE3ly7AVXwgjBGiSKL
         ooHBgUtYAInx9HgTGKv0SURuAo832GqqaynoTQPvNIGxpaHGJfAjM6j8IpSGDiz3QgYt
         5O0uOiNUdVsnKAlBbpOoiT6LugH6Vo/WnYlrSM56lT3Px/OeZEGF54L2mirjwdOdMNBH
         mtkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792246123; x=1792850923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xhG+wnkOUndHgFqi7q5mTZCxcyMx8su188FBsGRE7dU=;
        b=kAf51sLehJvMNBuLZUvNMb24k0CMx3+YfepR5ZuzZ4ptmEZ6jzVS3hl4yDVG7LO96H
         Sq3WYUf4ZZXECbzPX8DROxc4AvEEKorF7dGs85iHIncNvUccDMDZX3A9CaMTmk2ej2au
         ijqJnW28JzNQtFGx/JSb9QSmFZlxx7/1TCI4WUuFuZT6fTrwxZBJfO7Pkc7BunRge7+u
         11wMKgYo2TQpPNFrgQVAnfUlFeqTzgk8sUu6HNpkRKi8rcxD946goV9xavBl+X6jNoIT
         ERpvl7iHNALSJ9H5lvup9zfEFQSrKUof4NICbg/Yu6eJcBmj3V7A3IApdEyiuLooyCi1
         jYQQ==
X-Forwarded-Encrypted: i=1; AKwUvBzVRXItWe02sn7FZmOrZwp4nQMOCmVJFb+qKuFHahsQ2yFcOXRq0roL2Es1gaL6/YxnxfIr6YEiPujE3Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYJItK1Nix3/QP4bz/TceCTOaIMDoCICdn0HTs2c0DHJyZ5tmYh3
	A42QAwk40IyaAn3NCZmp+KY2hoYZNPNmVZapPnlzz4zHn2iPMVj1gUe4
X-Gm-Gg: AYBFou0B+kbYDzz1cvIg9A8cj5ZeZrA8HwtgCrkLKBRcR0n3E7sNE2iDERc0l18EzBy
	kxms2KC1M7DBgXoZR/l4nV/pHFO8gY2q3U8KIGz6YbZ00a7rgYuvI6VwWan6PNa/HC38Ra3X1EN
	q2kQVAHmGCnB+f0yC26ickT8NDDw5ERlMXx/ern/JGw+lUXkHA8vfJPfwVpsDi+BbDxbK2VJ7Vn
	2o4FXzTDAg5oQc81s0QhENzEIKlC/3C8i9JrAyPwLO/r0ZeP6Vzhp8Rgr6H+azcY03GyjRWT7hL
	cS3VKHev2j+RGabFx+MzlQYf9skVpnN/3k77yXE2DDcCoKMjIYQKxf9Kgssq096DIFspLq8/oOW
	OFJRbFqouv9fx+tffKqYn84tpyJbNLi9q6XqPeRm2tlvALTsATxrDjoM2NzWuzZNmm3dZ4stLBY
	pgei7KSmMENqygza8JpeB7l4+gcxlOgJ/3CsXb8tyLhi1LQlWGqyEJjzPgzClJvwFi0SYgUBcMN
	XTySYMjlElTZY6n5R4cNGcnA3r1yHN7Y7qCZ6XBzPBJ1VxmpFaH3pjIhGlSuEQJ5Pm3j1HFoUGs
	Hg==
X-Received: by 2002:a05:600c:1913:b0:4a1:ad01:f8dc with SMTP id 5b1f17b1804b1-4a1d7628d95mr60095115e9.21.1792246123223;
        Sat, 17 Oct 2026 07:08:43 -0700 (PDT)
Received: from machine.home.arpa ([2a0d:3344:57f6::1046])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce3302b5sm84430745e9.4.2026.10.17.07.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 07:08:42 -0700 (PDT)
From: Luka Panio <lukapanio@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Luka Panio <lukapanio@gmail.com>
Subject: [PATCH 5/7] dt-bindings: input: touchscreen: edt-ft5x06: Add FocalTech FT8722
Date: Sat, 17 Oct 2026 16:07:53 +0200
Message-ID: <20261017140827.290666-6-lukapanio@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017140827.290666-1-lukapanio@gmail.com>
References: <20261017140827.290666-1-lukapanio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FT8722 is a touch and display driver (TDDI) whose touch controller
is connected over SPI and runs its firmware from RAM. Document its
compatible, allow the SPI peripheral properties and add a
firmware-name property for the firmware to download at power up.

The "-ts" suffix keeps the compatible distinct from the one of the
display side of the same chip, which is a separate DSI device. The
reset GPIO is required, as the firmware can only be downloaded while
the boot ROM is running right after a reset.

Signed-off-by: Luka Panio <lukapanio@gmail.com>
---
 .../input/touchscreen/edt-ft5x06.yaml         | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
index 68b2f1601654..51d22ff42675 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
@@ -19,6 +19,7 @@ maintainers:
 
 allOf:
   - $ref: touchscreen.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - if:
       properties:
         compatible:
@@ -30,6 +31,17 @@ allOf:
       properties:
         offset-x: true
         offset-y: true
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: focaltech,ft8722-ts
+    then:
+      required:
+        - reset-gpios
+    else:
+      properties:
+        firmware-name: false
 
 properties:
   compatible:
@@ -47,6 +59,7 @@ properties:
           - focaltech,ft8201
           - focaltech,ft8716
           - focaltech,ft8719
+          - focaltech,ft8722-ts
       - items:
           - const: focaltech,ft3519
           - const: focaltech,ft3518
@@ -60,6 +73,12 @@ properties:
   reset-gpios:
     maxItems: 1
 
+  firmware-name:
+    maxItems: 1
+    description:
+      Firmware to download at power up, for controllers that run their
+      firmware from RAM, such as the FT8722.
+
   wake-gpios:
     maxItems: 1
 
@@ -134,5 +153,23 @@ examples:
         wake-gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>;
       };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      touchscreen@0 {
+        compatible = "focaltech,ft8722-ts";
+        reg = <0>;
+        spi-max-frequency = <6000000>;
+        interrupt-parent = <&tlmm>;
+        interrupts = <81 IRQ_TYPE_EDGE_FALLING>;
+        reset-gpios = <&tlmm 105 GPIO_ACTIVE_LOW>;
+        firmware-name = "qcom/qcm6490/nexphone/ft8722.bin";
+        touchscreen-size-x = <1080>;
+        touchscreen-size-y = <2408>;
+      };
+    };
 
 ...
-- 
2.55.0

