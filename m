Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E053D3CE2
	for <linux-input@vger.kernel.org>; Mon, 16 Mar 2026 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684732; cv=none; b=aUuc5s0HfzszuzPLSdxUV3mzO+fDsB+L7msMKtG2YUrvGob9wZ15CzvloTut4dvyjV+eUtJ2RJL6XH7OygOQ0VYZIWEXuXX2YxzWdp5axZGqLbHGBgVETrMoqm4vuQGJMtWlurqUMxDYYndc/gwwxYBRFzoPpnYMTEgQkzDXfcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684732; c=relaxed/simple;
	bh=dt3alpAXUOQoTq44HebBnWI/jUQU9/9QNQ+dm8LV8Wc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qCe/1oOZ/2uRMtP6NFXZ4JvWHsZltbjkKPg7/neTRo7tyFzsjr/iKt98sTGkWVefbuKeLOkc+QpOWlysBlm++FvFzDhS3MlZbpBQnP38aC8BhMlMgETTf2MWRBbqEAHcR/TmeVN3D49TRfTGMYOmL1lqIh4lRsLWNzQYECXz+DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L06XRiFd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L06XRiFd"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852ff06541so54824305e9.2
        for <linux-input@vger.kernel.org>; Mon, 16 Mar 2026 11:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773684728; x=1774289528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNoFb191mvWm3HG8KPjdrK6BEhKwrJKwIStTVlNnrUE=;
        b=L06XRiFdqc5nYolNuqZlVNECB9rA1A2rW9ZQNa8d+rpEWBrJPGzePLFlMJKEJ94eNi
         MeVSo07TAJh+SDumkZ02KYA9yIPm4hoojIU7fRqUv7AlLRiNh5kMcTQJZV7hV5SuhkQu
         /m/J96fzt2CASgo5cUrVvWZzlE+lqFaWciwZV5yRSDUxGYCbYFaNPlqJRtF3VM0uFJyN
         4+hYE1dbbAGa9XVCv0lf9vM65i6eItNEwhuz+FMuXUsr7pwVFiNDMk+PxWS7nwQmpGV4
         nwQNVFDXLRZtDoahKrx8WeKZwPnYOJhVl9ef9tH5HQ33Tsy2sKPy85F/yXJoH2/KVohK
         qSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773684728; x=1774289528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNoFb191mvWm3HG8KPjdrK6BEhKwrJKwIStTVlNnrUE=;
        b=NIlJhFiKUfdg+GD87rKJnE84ksGo6t5vBn9Ob1JWdRVugqJimnOJ+YmuHFfM7IhZDi
         2xB0yIMPVHfUqq+fkay1mIpJqP/5DJ5vymRCYSjJRIGU7PUx00ftSA0gtmyyVElXQwsj
         EgeJ4+2PuZCv7SD+zb4aPCxws56mSwXiTf6H0CAdT5PxaUuVRcMslZ9Kl79ua4Z4D71X
         Uhh+8y+HV/wYi2Ys3NJdn5yZkZXsi4G00Bd/0yCD/ZgQHIMRuf2TaPqcRVVK3prhG6Go
         SnRfuQMEgFT8zVyJrbgZoHKiuhceAa/YJIqXBt+IqvEE98g/P0MpMuRXCKx6u3/FZSNQ
         cHjA==
X-Forwarded-Encrypted: i=1; AJvYcCUZRV4v5Wm4J96cBkEo7m9qhitQX6UknXgWxutUmBUPuyvASw+HYJr+GLylxbBLrtLKDCeqGiYTV7CyiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw79HWhbjtipxm5vsdSn4ixVGkwGHmQN/JThEh+wN/OSMTanm5
	PmnLQMZ7dw/LupfsbVTXhQf5jOGRPKsWdli2AgbTaDqrJWKYwQKcLkvg
X-Gm-Gg: ATEYQzzj7AalpgebNFx8TS4eKPHYERVe2lgyzzS7SVlNCyfW8KG/o3KAfDsCDjv7X8I
	icFJwv20xG4ywQ62bNW6LHqJcdHoLJ2xKX7+qNOBhRw36ZwkxUyAqC41JU6oYH1aRAFgTpatoaH
	oHE8GyZzujHBE2Fy65f3GZGJ5V82ry4H9diKyf80jcHqb/ngSXcOF2XAhtqcYg9IjnNByCYGylh
	fBvXiKIxnQIdkgVx53P9qekJiGyr0g/rWkMpuUyGevwi0Wrvh+AYiTBli2WtCnMJH7Q7g6SGOMZ
	pcay9cjb2ZDewcarE2ubxFKx9sZkwaYKRasm8D7bObwoaXuYKPgh6HfGV2yoQXiAleSRnY+/L4L
	L7hdTXGf5wSzPzLT1DQ0Zhi/S8hCcjZWX/r4kS29Tn6m/Rw3SeWQqupgxDUg/59QAof+gTNAj+9
	IccL89j6wAH6XvnRU=
X-Received: by 2002:a05:600c:548f:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-4855670514dmr233546695e9.20.1773684727835;
        Mon, 16 Mar 2026 11:12:07 -0700 (PDT)
Received: from fedora ([82.137.32.223])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48557c89186sm247427825e9.1.2026.03.16.11.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 11:12:06 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	egbostina@gmail.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: input: touchscreen: Convert TS-4800 to DT schema
Date: Mon, 16 Mar 2026 20:10:37 +0200
Message-ID: <20260316181038.9771-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the TS-4800 touchscreen bindings to DT schema.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
Note:
* This patch is part of the GSoC2026 application process for device tree bindings conversions
* https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings

 .../touchscreen/technologic,ts4800-ts.yaml    | 42 +++++++++++++++++++
 .../bindings/input/touchscreen/ts4800-ts.txt  | 11 -----
 2 files changed, 42 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/technologic,ts4800-ts.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/ts4800-ts.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/technologic,ts4800-ts.yaml b/Documentation/devicetree/bindings/input/touchscreen/technologic,ts4800-ts.yaml
new file mode 100644
index 000000000..c033774b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/technologic,ts4800-ts.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/technologic,ts4800-ts.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TS-4800 Touchscreen
+
+maintainers:
+  - Eduard Bostina <egbostina@gmail.com>
+
+properties:
+  compatible:
+    const: technologic,ts4800-ts
+
+  reg:
+    maxItems: 1
+
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle to the FPGA's syscon
+          - description: Offset to the touchscreen register
+          - description: Offset to the touchscreen enable bit
+    description: Phandle / integers array that points to the syscon node which
+      describes the FPGA's syscon registers.
+
+required:
+  - compatible
+  - reg
+  - syscon
+
+additionalProperties: false
+
+examples:
+  - |
+    touchscreen@1000 {
+        compatible = "technologic,ts4800-ts";
+        reg = <0x1000 0x100>;
+        syscon = <&fpga_syscon 0x20 3>;
+    };
diff --git a/Documentation/devicetree/bindings/input/touchscreen/ts4800-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/ts4800-ts.txt
deleted file mode 100644
index 4c1c092c2..000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/ts4800-ts.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-* TS-4800 Touchscreen bindings
-
-Required properties:
-- compatible: must be "technologic,ts4800-ts"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- syscon: phandle / integers array that points to the syscon node which
-          describes the FPGA's syscon registers.
-          - phandle to FPGA's syscon
-          - offset to the touchscreen register
-          - offset to the touchscreen enable bit
-- 
2.43.0

