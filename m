Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F0E37B40E
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375507; cv=none; b=F8TEkh1AfyLefSN3rXql6UYgHtj8QBiBPYeAcy/73VfYkMMcb8p1W//EwkcNxsHls3ZCJ79z02bVOWYGYVV+NOEaiSWRnHs72+TNFvjnw4ptf06Gf6d2RaHXI6sBUI9FTzz8mq8QZ8mECnVhuBA/q3hrQ/X20czzHm+nUHgWTVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375507; c=relaxed/simple;
	bh=sJYSHWc09xFtiXGLxIY3eCmrqPgEujr443cRCV1hpP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZyxMnlc2+3BkU1Qqv9pmJz2yaWUiY1XpUTDyqXn+L3sIY3zYmcwwdWsyGGtPuMFKPwA5vCRWhrU5niXf0UvmhopxeLk8triLI3JfSQOwckjiZdKhNVu5gsm+YCN//dFQSbHb6yIAitxJOxVAEHyK7RhGpuFlg0JG/NG5Vbh2Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djWWtKKY; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djWWtKKY"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aea367c965so183474e87.1
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 01:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782375504; x=1782980304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eV+WP61ShKOblE3anHz+BLN4XFN+aFPa0yNq3Cy5s6A=;
        b=djWWtKKYlwe1GiKgd21dgSYK+HKmJFmZigUgDj2Amtm1hFydkbgtsP2+WiXZ4iJKMI
         ixf4HoZYgSQ8Uv3GvEcCCODN6B6FlioMGm+YWIPuI67sE6xT1yt0dwOLBwDSX+NA1CWk
         hpyYTXi4VLTas8wZ+/X6eZRFaMNPwjfb8wWp5Sd6hc1y/krysqFq6sJgb3CzNFQRScWr
         pAVQ6jqO8yvxi2gm5vUQOAaijtLKhKk6inMJBmG9wfb/rNfRw8cC/Fy7EJHxIfvF+27w
         0fDj3yDruTF2sWgsd/sRyip5ihtyX5a+jLDXmeJddga7azJRPQhhUihv8rOZcIlbYoDL
         caPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782375504; x=1782980304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eV+WP61ShKOblE3anHz+BLN4XFN+aFPa0yNq3Cy5s6A=;
        b=eNTvgnuqXPmOU5A3ptSsXDTHpfb9uT/7T+5RyqxzqahVfzLq5NpkH+Yl4ziVXDY+D4
         uMdRJvbi/EhpABhkxWYW3B9Vpph+D7ri6pnWbTnX0i2oEmRizWFETKrRSbNaJdAMicXl
         zROq59BVsL0GVZRDN3hXH6cKCAXddl5EVoLuYGtLtsYlwSpzyP9vRPk/OxPBJk06bdCs
         9aKatg8GDTxjms5UtnB06LGA/Qq3X4h4LaKlogFSKO9IybMLT5P/grFY10hRLHtT+z+T
         cTcZCZgAq0f00rlP9/zMqsg0PIWQ+0nSyj1hn10g9Ur2R0fEwFcNw+Dicz2TwuH/tD5u
         TISw==
X-Gm-Message-State: AOJu0YyOlL/DoXffQPUwPRzuxk8monyUdjpmGjdRnS9wzUirmBozt2zB
	5qiKMJs6k7FVAZgw2yg7nA8PSkFsDHF86y8mk1l7vSIQTHE8/VmDncdq
X-Gm-Gg: AfdE7cl84fj8gmp3mTaLXfGyAeOu66ENG5mMPwQLQh6QN/UURKCF+8gDi/gASL1szkM
	ufEV6fbQafNqzfZbOn0jZqGXWfOmCEdRRI1LF0k6ap8gx202BryxS0kBcN7oyZPrf/MnIqV2O13
	Aqke1u9m1cH0/zCjZqsUJQ22fngnMYuHbmxoMUu/gXeabYpryiy6xqerGfiifZRijkt64MqVJ9c
	fvUuYplJ6ukJ4pprU0Y4j9fTL3seqsItnTCOUahOPSlU69xGeyoKTNw+BUjbfpp9vYqGQOopeSY
	qgvAFtnn/vvDYviI/U5vlm5jmyiYwrg29mDvaAJOfxnPy2uzLr4NSl+L6G/Vn4D8Sb1RgGcAwtu
	N5jJOIM2ahKWUh7R2hhCiWF4pcDA4JWhvdmXZifLYCQMhDE670w3bh2/bIDiGxdwzlvSRhT+yDl
	6gr0EUaWv8LCa71u+S1w97ZRvdhTf1RO1p1Q==
X-Received: by 2002:a05:6512:64ed:b0:5aa:6ede:51 with SMTP id 2adb3069b0e04-5aea1f61b7dmr404454e87.27.1782375504313;
        Thu, 25 Jun 2026 01:18:24 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6957a268sm2464601e87.38.2026.06.25.01.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:18:23 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v6 2/6 RESEND] dt-bindings: input: cpcap-pwrbutton: convert to DT schema
Date: Thu, 25 Jun 2026 11:18:08 +0300
Message-ID: <20260625081812.33474-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625081812.33474-1-clamor95@gmail.com>
References: <20260625081812.33474-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert power button devicetree bindings for the Motorola CPCAP MFD from
TXT to YAML format. This patch does not change any functionality; the
bindings remain the same.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/input/cpcap-pwrbutton.txt        | 20 ------------
 .../input/motorola,cpcap-pwrbutton.yaml       | 32 +++++++++++++++++++
 2 files changed, 32 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml

diff --git a/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt b/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
deleted file mode 100644
index 0dd0076daf71..000000000000
--- a/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Motorola CPCAP on key
-
-This module is part of the CPCAP. For more details about the whole
-chip see Documentation/devicetree/bindings/mfd/motorola-cpcap.txt.
-
-This module provides a simple power button event via an Interrupt.
-
-Required properties:
-- compatible: should be one of the following
-   - "motorola,cpcap-pwrbutton"
-- interrupts: irq specifier for CPCAP's ON IRQ
-
-Example:
-
-&cpcap {
-	cpcap_pwrbutton: pwrbutton {
-		compatible = "motorola,cpcap-pwrbutton";
-		interrupts = <23 IRQ_TYPE_NONE>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml b/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
new file mode 100644
index 000000000000..77a3e5a47d1a
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/motorola,cpcap-pwrbutton.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorola CPCAP PMIC power key
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  This module is part of the Motorola CPCAP MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. The
+  power key is represented as a sub-node of the PMIC node on the device
+  tree.
+
+properties:
+  compatible:
+    const: motorola,cpcap-pwrbutton
+
+  interrupts:
+    items:
+      - description: CPCAP's ON interrupt
+
+required:
+  - compatible
+  - interrupts
+
+additionalProperties: false
+
+...
-- 
2.51.0

