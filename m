Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577295;
	b=hdcvy/n55UN5r8czC6PVYLgG6NzwOak+zLD4dmtq9q5xRtdLGEWnEd5++Br9xASCzaF2
	 UMV0Nrj7aAFwhLDjEQmikX6BUH+nMcDhmqmLQ0JVfkD7DesZ1Uca4fj5zBv9Asj8BnTum
	 AvE3Gge/7whHUHQ+oSSFdQFC+M48ap0fnZ+wKh0qTBmeUJo/L1HQXt/VfWKtBe0e3xx1r
	 vNE10bIgWKf3oTRWoop3cCw1tU3t0OJlCsze6UZLdYmfl58iXfUhb/3qEufY9fSQcma7F
	 MIzJBZ8szzZPtrYRMiZ8TbMNArxeZgpFmhDd26D3nVqWgoyz4sSps+qAJWcD67zEIVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sG4IjzQzTOsq8+1nteR/Dqn0VR6TUjyjIc18rbJBV9s=;
	b=Vv1JhpV5J29D7AMGuUvQ21W87Vel2lLnkWHnu34tmDxrN9RZ6uHJJ9uYe+7j4hTjOWft
	 dUuP5p1iJ0P5/5Iki/SXhCnp6Fa72WPB4rvbJ7tYNrHP45Qdj38CHva+6tfHUy5Tc9f8U
	 hdtUU4Ilmnkjheu3mUN7fJiitBh/lHAgLrUOI555fcDDNV7poMcImWxnP8DKqSduLfJY8
	 /KsryNwCD2gIFWLxmLkDdbYgwv/8b2EUfwuWhUChEcGGQSAeZjCA22BWID5aVLHtdNv/F
	 eTzrd9/KBl4JiKMm3Ry8L6iHUCCfngqjqAJ8jDUjM0T0UDNOy/gmqd0Cdjw1dE50n7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pva+qH5L;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3658606A6BA
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 03:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3658606A6BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pva+qH5L
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e09aa5264so2986608f8f.2
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 19:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577293; x=1796182093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sG4IjzQzTOsq8+1nteR/Dqn0VR6TUjyjIc18rbJBV9s=;
        b=Pva+qH5LwkfRhY/HwbuWQ54KdZoI9qwiM2ANNoQjop+Al1lt+Gs2GjJHLVhyECm8Z1
         2CChIklgFlF83RjXCGNzKTVjFdbIyeakGRqfM7vpIyAAloWFT6JAbfBg9/toCxKyOlJd
         xe0Y9nRMliTY7LRnF7+Xl+8iFb1uRZCZFwR3KGlkBm34l64abBXecw4P5+rjfmTV2VXH
         S8WeMlhR7JMXkJYiJrNVOx6dvwMRwMhrxKlkUGvXrWB8DEsZczOtWRAzorpvWKnS3P0v
         aEtnkYsRgeclvDywKMKzvJBSAM0phfesoeu8/WVlmJsi2EO9R+BLhgV4C0eCkJJdYtuJ
         YWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577293; x=1796182093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sG4IjzQzTOsq8+1nteR/Dqn0VR6TUjyjIc18rbJBV9s=;
        b=U2MVcCxXBVU7KbaWmVRCXkUQ1A5Si+IeiOyPhM4Bh2maGqAhsnOqRUdDZZVT/8fXSj
         M+r8WJK2BsVODu16IqR7LUQ1t073IQEomH6TfKUBYZrFH/9m8Swpe6hjCSnQRz8HbhDo
         sGxiQMZUndu3ZFQUHok6P2DevQm16mJAI1kT5ttaiU2qnIMxiN79S89nG44pGPDgHB87
         x8wRuqddJdZNf8yqqLoPERVMiHroWgio4PJBQhryYTPEuRv4rJlGqrMPsJiXNXyC78iH
         b2gJu273yJrlpjr/Ga9hbDRJkJ3hMZCGMyXbyltgh7jeUezEHDf0UTn6Jg/gs5gLhNo1
         2WHQ==
X-Forwarded-Encrypted: i=1; AL+hErEovFsBOO4Kr8W3FH1wlSJNmmsuzR/Yt4SfkB7ToM9TBUDSFDxoq0lxVsV3A04SwgMWp3H/bT6CdfIk9w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8GUjo71Yeq1w85ODzDRSllOdLfDguiQYXtY26DupXNH3WnglW8
	nPAiBeiHX2CjtdWj0zx41nV4J+LcjYt28aQsjQISIS+X3sCJzOYcZan3
X-Gm-Gg: AZFdTZcYRH3lW+Kv7gOy6YJrvTJ8Y5an39+cQ5wyoPobTeoovq5yVbbHf7I/2YIMk3I
	JIA+/CMbJ8JCTVQBksagYlDXmzU8QpCx7eVkjfuNuaSS2n9P7yTfEyoYe5c36RN8rAbjcw6oDy1
	BC/Hx/hzLRbz0I/W+2hzw/eRzbrMdJ6KAp6d94KF5iNAfa1CYWqbO3zqL4Z1D7Zibtkb0QVRQKC
	j22+JTIvzU0lEhGtsIHxpBvkTA/mJF/uEBPOUNe7JktLV/QAr5F7i2FZlkm1ssX/H2cStl0SD9R
	XxY/DXAXK2tAJTTuEYkbjAxxRRhsUT0snvqrPgUvRh3AGijXvri4kNL8tpdsGeUHHXbowGcxRP1
	LRkWvpP51UX7vt/xHTBhAid+9E/AnhmITtX3JXnSLDl/FiencDhu/NHYJGLmnNI/5yb4toqmzX4
	OLt0MaIoqNjMt5aRu4v9ICdPT7yCJQMizn1c9zfD7LJHbMSshv/+reLZfIq22H69AfDxt0ZraWd
	4+e9Jb/GVbz4qcRhph39ea7D0rBEGBt++Uw21+sF3VjpxA/xwwJbuoiXNwDbfG9Tqj9HEudVtqZ
	fNe6J9WbE3ZOWkN+he4O1j2md8ZhegPMVaigVIkwSXFCpZS3044Pcjlci5/NTNiyTstHc+ZJDRF
	Mtr5t6rBS+hHIv43ly7s3Da79cfOKJL4=
X-Received: by 2002:a05:6000:2913:b0:4a8:7115:fa08 with SMTP id ffacd0b85a97d-4abb0f3c202mr33671845f8f.13.1795577293140;
        Tue, 24 Nov 2026 19:28:13 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe48sm28918822f8f.23.2026.11.24.19.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:28:12 -0800 (PST)
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
Subject: [PATCH v6 4/6] dt-bindings: input: touchscreen: add LG SW42902
Date: Wed, 25 Nov 2026 04:28:00 +0100
Message-Id: <20261125032802.8460-5-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261125032802.8460-1-rofikcoga@gmail.com>
References: <20261125032802.8460-1-rofikcoga@gmail.com>
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

Document the LG SW42902 I2C touchscreen controller, including
its interrupt, reset GPIO, power supplies, and panel touch properties.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 .../input/touchscreen/lg,sw42902.yaml         | 72 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
new file mode 100644
index 0000000000000..e8ef2d325635d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/lg,sw42902.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LG SW42902 Touchscreen Controller
+
+maintainers:
+  - Abdur Rofik <rofikcoga@gmail.com>
+
+description:
+  The LG SW42902 is an I2C capacitive touchscreen controller used on the
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
index 6a41a0690d9f0..8c88429e647ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15211,6 +15211,12 @@ F:	Documentation/ABI/testing/sysfs-platform-lg-laptop
 F:	Documentation/admin-guide/laptops/lg-laptop.rst
 F:	drivers/platform/x86/lg-laptop.c
 
+LG SW42902 TOUCHSCREEN DRIVER
+M:	Abdur Rofik <rofikcoga@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
+
 LG SW43103 PANEL DRIVER
 M:	Abdur Rofik <rofikcoga@gmail.com>
 S:	Maintained
-- 
2.39.5

