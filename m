Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63D1D4606
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 07:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024072; cv=none; b=PqV0TY2BGK1ocDE/qOKNL7dDdej2YF0y+WdQo0gHE9a26pUis7+3X8+LM9t6J81tXuGIafRNc97Hk6uz/fPuvqI0kwV6aoy1/6WCr/+lE0y8fx15rzYxzBgdV1997scX9D2BU0Bl4pqQidx1qkbv0CStLF1dxZXtp0EHPkEx5iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024072; c=relaxed/simple;
	bh=P2OqeAVCWHFS1/46fjXp/GqTmb5OLthjWFq4IcxNSrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mf8nzD8pFn81iyZfuc0EHx2Zp41Pdj1lkdcqsdsgpErZCzfZZJoNsrIcVj9ZFr2mngK4weLGmL+519NXOHhlF1UiCQtnM3wqZuapOiMsY+U59BpHrUUdFMr+p4T4JZ3+irZVshsbwQlwMPc4EIcKLi6LRe9OMB24SmEs9mV65kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O28Mq88m; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O28Mq88m"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-484392e3d33so4793144f8f.2
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 00:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789024064; x=1789628864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6N41mPYMtwHJxcU+b3y0AU5P4+rfzOFqefvh/tO1NTI=;
        b=O28Mq88mXSz6XKCUzS9M/KBDQXXgZURxNuPPzcjkA7ep1BYoB8jn6395/uA9wyUm81
         PzfM6rSpniSRzSLbNKxRWuGScTYsGJRnCcGx3U9DuJX/ZjBr2cSlOj5YBU/LqwB/waex
         1gP6XtZpdb6sWSOmTBcEoz8dSIVt7Cc9FAv0ta8ICEApMq2cDji08BiC4DMW7tzGYJVO
         +H6TpqIVfpztHFkhOHE0gPNJ9cfwN7IssO67B+m9YFaeTVHXHP0HJtKvqN5r0tBJL95b
         7Cji+9o4CYFKmioJSZsu3SdmmxmRN/5MV4xfKuQlmkOv7zDPWiGqvNj+kTwQ00x80St+
         KaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789024064; x=1789628864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6N41mPYMtwHJxcU+b3y0AU5P4+rfzOFqefvh/tO1NTI=;
        b=ONpZH41S8543Z5VZUiSebigBd+SsovnpuSI4HGLRlN6pjBmTQP2qL68MfBXiz/ndjr
         Q1zG8IY5O4gZK8P83H0ZjQ7NAe5cXUQ9g4XpOFoNaZJTCxu0BMD2agNKdyQFHETMmofl
         fqpKsP8ddp5cPYSLbzkNUiXVSbBprz3Qi6UxKbw1BMJJp7K+0zyJpZt1un85yYhElUCg
         QpfNbH9k10J8AybQ+43tdUrFKGYqkSEvM/Ex2OfqCnbwnRYFRbHZNLcXQHK0QVZiEE+y
         uIo5CoQdo725ue0Fs8qFprs9jIs0yacvB0EWDu0+7JvxC/OlW4yE94LfjbjZBSMz4jBi
         m0Dg==
X-Forwarded-Encrypted: i=1; AKwUvBxqRksbqOMylwUUs7p3uGh9xJsY91Hp35ZCmwMDPV15nIVGQgwVIqZk3vsfIvQgH9+uouLfZq1PaesJOQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lsdp1oq5v1n3ks5y02Q+WExUTiWvVgnHa/MFWgOa2FbF46/lWT
	8+AKdudUYkJ7eofSHM4HsKChMec9EqIk8J8zO//uJg5TiUsCs7lJ3S2S
X-Gm-Gg: AYBFou3rEVbh6CLqUV+By1HLPeH01ZnhnlpQQcLy4kWQtuKQnQ5oVrGhUdkniW2fxMS
	ngvARr5Ct+61VNqDwe3RsfcNkeK1zeI6d+ANh84/8ksSYKSUmcIvecprmVZhoj5lY89keVfGY6V
	vo4UchPsq6Iqq3nI/KtMud2dsWWYGEU55Mse1Xtt7EZGBSQaOVkz+HbZiOF+Ome8l2TdULr1yaB
	yC3D5FMDoKSeKMX6Qnvf6N174QMvWust6hzNydlj9hJa7k4r84/z6NyrbUsiYcLwOvUdBpeiD6S
	RG09Rac0JkfyRw/UjZII3IT4JUzCU7Cw68z+F3SJdVSx61Th3YQk7DwyiBMU/MIo0toDtcvuzbd
	xc4nIXlbzrusA558fiXWxD6zJGckGe9Pd7hDaxbOhEBzZahfjQg6tZkJdeFkVjWaAf/f8e3JjzY
	kTtkiACm2bKoubki0v1P9PyU4JNuTJI1og7G3vWmoeFT0bjgSn8eQ0+uAIyUD/qde/yFCGlX89A
	7c=
X-Received: by 2002:a05:6000:38e:b0:485:ea30:1f72 with SMTP id ffacd0b85a97d-485ea301fb5mr5498696f8f.27.1789024064007;
        Thu, 10 Sep 2026 00:07:44 -0700 (PDT)
Received: from Empers0n ([193.23.219.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883959f0sm52244311f8f.10.2026.09.10.00.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:07:43 -0700 (PDT)
From: Vsevolod Nevorotov <sevanevorotov29@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Henrik Rydberg <rydberg@bitmath.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vsevolod Nevorotov <sevanevorotov29@gmail.com>
Subject: [PATCH 1/2] dt-bindings: input: touchscreen: add Synaptics S3908 controller
Date: Thu, 10 Sep 2026 14:07:22 +0700
Message-ID: <20260910070723.347768-2-sevanevorotov29@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910070723.347768-1-sevanevorotov29@gmail.com>
References: <20260910070723.347768-1-sevanevorotov29@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree schema binding for the Synaptics S3908 TouchComm
generation-1 I2C touchscreen controller, found in devices such as
the OnePlus 9RT.

Signed-off-by: Vsevolod Nevorotov <sevanevorotov29@gmail.com>
---
 .../input/touchscreen/syna,s3908.yaml         | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/syna,s3908.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/syna,s3908.yaml b/Documentation/devicetree/bindings/input/touchscreen/syna,s3908.yaml
new file mode 100644
index 00000000000..68479b0b7d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/syna,s3908.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/syna,s3908.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synaptics S3908 TouchComm I2C Touchscreen
+
+maintainers:
+  - Vsevolod Nevorotov <sevanevorotov29@gmail.com>
+
+description:
+  Synaptics S3908 is a TouchComm generation-1 touchscreen controller connected
+  over I2C.
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: syna,s3908
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
+  vdd-supply:
+    description: Core / digital power supply regulator (VDD)
+
+  avdd-supply:
+    description: Analog power supply regulator (AVDD)
+
+  wakeup-source: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - vdd-supply
+  - avdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@4b {
+            compatible = "syna,s3908";
+            reg = <0x4b>;
+            interrupt-parent = <&tlmm>;
+            interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
+            reset-gpios = <&tlmm 22 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&vreg_l3c_3p0>;
+            avdd-supply = <&vreg_l8c_1p8>;
+            wakeup-source;
+        };
+    };
-- 
2.55.0

