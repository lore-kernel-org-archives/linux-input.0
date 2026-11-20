Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190097;
	b=X2ff/hOL50c7ngnjAzPt/pecWBPs/rwZUrC2XH3tzPYEYdhHJnHejDSTHEKb1dQfu5cR
	 LS9xWr4FLFq2eGjBNC641uPkuZgR0zrEwHZ6cqlVWR6zgVP8Egs7VTxH5PO4/xGOhy33V
	 Jho6/s7V1WeBrqEiQaH1/5WpwZrPG+/4UU/RiPx62mcnIYwrrEw4Jtef1G0lWVPJWPvN6
	 KuScAVFijXlYjlrtQ7oJ4WrandwEeYQC/bl/9vr8Hq2oUmjt6AIsy9FqyUQEm9zGzZ8/X
	 bT07i5ubv10JvJtaKqiOWj0GSfF3xpw7BLifrhojzYDLgdxmNU/DNOEHoChDVAqzjRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190097;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dsLmXofWh30s/RrFp/am5k44VgINvU+/ItmDuae2D4c=;
	b=tjqmXgLjTCSkwAN0H8ehXpZqxHO9SUjWTKzsaxp5Nxe5WxiZ9gl++HHxIVOQ2v7x77Lq
	 Wth7UUZVAepYNLaUdHJ3UJ7oLsmcBuviQ4PRIrbSY8Gw3+gBcDxRG5AIE7q1QokZrwZXL
	 JNg7i0i4bHJQOMwEqzGpfGhJKiqE/i1Sj2w1asK8UkXqiVTKXT9V872XiWqszWHsZquqx
	 15aUyex7Nu+431LryyX34GW8KA4g8j5aZ+SihvY7vzoHhnIPiPyXsmupRIsgsdPO+5iyF
	 b/Y0Vp5pKbuzq6rgl2NJcNx/C6e5NHYnQxI32XmkO07t3LKPoQg+UrZzwWOLQ0ugY7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dpaivp5c;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2BB60A2629
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 15:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC2BB60A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dpaivp5c
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so9313365e9.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 07:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795190095; x=1795794895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dsLmXofWh30s/RrFp/am5k44VgINvU+/ItmDuae2D4c=;
        b=dpaivp5ck36xhT0mSf3cEhG83JMNpndV/TDWJHrvmuFpnac9HUTpZp3vuYPaad/kOo
         RGhn4lKUpnnVcpFC/yaxfCyQXeRrK979BXupamV4LBS+vKLvlrb2gh8SWEdAy0rpHwKL
         HhorfYU3lt7r4/teZcJ6M9g0lzuHVgrF4jtW73dzFzeHF2tAerfB+OG1PlLOYWMKRgu0
         7Km1MLWMao/4k8glK8Puv0YOdJpzpv4mYxmhlkhmLPyJqN5QDMkPtPizb13BlzsnWgzO
         MPC/kwklGeqDxJnmDreueLfzrZwysMXydWVAwE18acn2eOJSoHSeh0N4i4U/aAwvZJ4O
         Hpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795190095; x=1795794895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dsLmXofWh30s/RrFp/am5k44VgINvU+/ItmDuae2D4c=;
        b=ZhTIJGRKuWFo1Fa7ORwiSzjXsu7U9E8wAJA2H8KqUMQOXjp5o5DMyPQ4SOBkmB8Bl3
         uJ4N5pcPTzGLD6L4EXh/0Netg6VC/97hraHogbnBfGIprtxIjVIYZFpbo96aObCu6F14
         S2IowD0N0DDVDyy6kgEfZPgLBvVXuMDL/tFdgA1TESYzJHdIVPD9W6Slt9iNLW2nR/lb
         1VC8ybY6nhvsqXhk46GvtNc0Jx2II4gRNkUdHcBwGwbvb9h+/pwsnpojqoZRZB9/hK7C
         N7oAw0XTCX8EkGinT5BL02Xd2siBYbDpLuAGfy8gxiujJKGFD3W0M+npCla8NruiInD3
         tc1Q==
X-Forwarded-Encrypted: i=1; AL+hErHBkoZ0X/vFXb6mK9QWgVn+tYnUbRAHoCkE1ZABiP41H4D+yI61plEQKT7w7RugQp17hiQxt5J1Shjkbw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8qvgf7gEm9kWUxxQu6OmTPFqrBsuqCFDcMOC3qL0cXNuM5UK9t
	/i/U7e9U0BBF3dErwFP/dPi6Veiz1Mt+RQnTNbsoZsAY5O5x3WFOq8+i
X-Gm-Gg: AYBFou31ri9RktSNL1OjPF+mxgCottGKTkTuDI1jbU/nt9FqBlmdudxVQO6ZsDwIJmZ
	tlU0t96yPjtR5pqxLjwKawqcffvdNLmCKG5zR/4APO/kByCJ45Y/sAX4UXaQkOPe96M8G938QA5
	F2ZT296xJUBULC/tpwMJaYM7ks7Vlu4RBnGn576ifOOnqp7TkkZ2csAVp6a8Z81VP/kZiLJMUcY
	IxWhmKel7d6D15RCdgwaUKddRPo4+k9BIzhkSqvvlL669WggAPcbQNf29BUzkqMgse2cHcRKpTN
	Gw7eHVu7GHy0OQqahZmj3SkmFlF7AC+P5Am29eQX3H8zse+heUadh4CiAlMfI+i+E3ASvbD7RAO
	qadJhi90wO5TTr/j4xJM7RxvE9bpHIvqSHQnyaPimEA3g4JuEULPWb3X2o2zcJMqXhEAXKcVta3
	uznvf73oSYRcl3ZcsfcYdVCv95ARVuzB6IDuWiByrGcrYFkHW7xPQ6x+iQSI4VuwddEHp8AIdGi
	iNXrYgzCFSxFvNJt8fqBwXdH132TvH9gzPZyWox67g4VJcXvUtSB6pPHxSy98t+1b4TJOezzc04
	L3Ien9lIiLQffs0qItBihcrhWODc16Vk8LS9a9Jz9/MG5Mh7gpL38v/0+7E9xUQSV61SFe4n9r8
	=
X-Received: by 2002:a05:600d:82d0:b0:4bb:818d:8d8f with SMTP id 5b1f17b1804b1-4bb88818955mr89360365e9.23.1795190095071;
        Fri, 20 Nov 2026 07:54:55 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a15absm83982635e9.9.2026.11.20.07.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:54:54 -0800 (PST)
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
Subject: [PATCH v5 03/10] dt-bindings: display: panel: add LG SW43103
Date: Fri, 20 Nov 2026 16:54:42 +0100
Message-Id: <20261120155450.7719-4-rofikcoga@gmail.com>
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

