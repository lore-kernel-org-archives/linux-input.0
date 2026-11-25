Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577290;
	b=MR1fSfO486J5FYdahPm7EXp506FiOWgiZ0ls/5wmH41PSZ0wMn8SvcVIXRrvQYjKQMnv
	 6ITmmIdSOdV8y1Nhrr2sc9YyHKSEv8HOQvMoDxBRK2vfE9PdKPY/B/jGEEMS905xuN++R
	 LorGH8V5zlcoyHGX0vQewgt0AwHBZsGN8oqHzlnBo0OvB45Vc+NAj11K+odxyFtR38amK
	 A99NlwZm7UDCV9SNRE0PbQep5EvPfCP+HFG2aIA7Uk3ni5MvO3uNqkKM2oW5VY5DwdujR
	 NGUq4Zp4ptAHFDBygX5M34yxZtcFdnyg7Rb5vnmD3eTzJYaYxtpfNVP0aVzllHuAlCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SOkOs4X+aYTNF/FE843B5YIM2qcfhLHQtKB0HpI+vVI=;
	b=YlVdl3gV6E4UHIO0/PqdBCt4acQkhcTvqO049oq/iFmUh+elilYjqVk/39b7Bk/f5dqW
	 XDDCg8hUhHdIq/UYgaheCgjhX2N0LRoqWwpoq0Bjd8N8udNf8+19o94DXjwlX/596kU5K
	 KSAqbKzf913r5dxMe2ILfiftT0cZ/p/ip4h79quctAkkvhNPvW5i0U6bBB4cH0EMeDW0c
	 dOczwECI0sT5Uy23MhTl/zNPLDMHaPDewNdaqldPI2YsOVoxQ0BwgCVenSdOS5eaeJprE
	 U+hENAC2h4kiycP+wrXY7lv2FAyMIOBbgajTz/vgKVnKfg8LZ9my8DXXxmIL3bvEZ9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RpixMif4;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B755606A699
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 03:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B755606A699
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RpixMif4
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4ad6219f7d8so4558789f8f.0
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 19:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577288; x=1796182088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SOkOs4X+aYTNF/FE843B5YIM2qcfhLHQtKB0HpI+vVI=;
        b=RpixMif4Byh/aV3xfOnH6SHw4AKFvidBBjZpuYgB4fwy5TNRO40GwWG0BFFM07jT5w
         bYWsepGfPXvuthLdC9uWBn5YrDcQ+iC56WlyAfSnJP0alv38jE4vCDhVrsWFN6w0di6g
         /mS6l9NTGiuzLyYepRo2qF2ZRzYTP1cQfkHmVTuwUNc/a8RA1XJf13fpxBAZULGT5pmK
         sd54elbf9/FlRGAqyzNODLlXoOwUyvNdaFLI0uSb7zBDJe6vKmS2y8Bk+16k2QDQw+pi
         fQSQZaWvqlZhJvGYid2Yktf6VmeglBzrW3oIAU+Z6tlmsK5AD01z3VXSMe8XQXDrGtGT
         sBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577288; x=1796182088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SOkOs4X+aYTNF/FE843B5YIM2qcfhLHQtKB0HpI+vVI=;
        b=LU4FtW9T9D5nw14A7YPDP+mQ8a+4WEs4D1hmBAWEulQzX1Yx2AuVnI9sX7SgGzXftd
         dvJuWjqeDwKZY1bVkATlxcvwXUwP44v5cGRFLyaqVavgpYyhlDWoobESzAO/nu5CAeHi
         yeZfqIz4R9SkVWqZos4lTNpfSOtMsuw5Cc5qPCdC7G8Lpf+chch1lLXvsJOHK236/m3B
         UXiZRttD8ktNUxBzPz4+xnHxWpgSGYOjjuZKa8A68/zmQoi4PjI+csO78zhsBEPMsPWo
         xXac27b4xuLirAGG2JK5c/IJoHhTmcpqyq9ELXwLt8qVHKuSeUdnUy0TbCDsS0HLA0V8
         Q6NQ==
X-Forwarded-Encrypted: i=1; AL+hErHAAIS4DzTXxxK7fHJt8ZCBJk+JNi7+bufOYfwrcS4fA0giY3dhh0uAA1VcqKz9VLepNNqyobYVjhebKA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/9Ex17ZGLssNtLfLpC8LCFshPp2UK9HG7JurZq5dujej+u9JdX
	I+gO7/OSnE42lIxk0nlKqE/Vtzk7Z/QJiwQujRUjSjL6/EJ8fb/4/Ezy
X-Gm-Gg: AZFdTZdEhuzcr6ob0MOui4jlzCsvFNTQdjWYIvSdpKIehaPT/lraPpRj7KrlHXVhXx/
	xH/M9Lqpjzrosuyc5wcCN/SCE98D/62EPBxwaWWKUvNpB1CPYSpeedpgHXm/rkCV2iZrjMR2atT
	XHUuh2TyHDXaPSxG9Qa44P9nOQeuRtYXwaihbgX5zoE+6/xyqp3XIi/xQuMZyEYDfiKylSfQHdx
	76zmCZRYYYOkALpqtAF86uq8fQ3y5htHlplapJ3PSEXwmOKYbka3d3l7bCncXRWR6QpLZxWICIN
	JbroK4SKSqF0yDL1eQmRlsYyWTJd0BVdOFdiMrJDxuMHF/5G7XlKpwMuCZQ5fAh0CjsYyM7w98P
	B0bRHiI1RbYESqTuG6XFpkqgBDD+Fjx0AQhCP7+yEFacJoZPXFReLUr6taYAdBqd0Y9cHpJE9bR
	iOfafADVw2gQnMefATE4/GVglkbb9GI3vyTLj3hzj6uzAslrYkq/Q4wPZZAuZ1B+awaYe0sDIDR
	1zyR3RaZ+PwsqGa7UUIgg1xuCrv1MbA2zTb39QceG9HesRr/XEAX8rwa9FREGt9W10D+hUjtxAq
	ATJMWF3UPQ23Jn4WAZ9/shtv/11z3mQK4s6Lk/AUzEmlfR23LrD2QihoNBFTGJqMqySqLA/uGfT
	2hXk4ivO3QB30dm2DYhyQdYPdrA0JFFg=
X-Received: by 2002:a05:6000:60e:b0:49c:fde4:1af5 with SMTP id ffacd0b85a97d-4abb9de7e8bmr30366806f8f.54.1795577288400;
        Tue, 24 Nov 2026 19:28:08 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe48sm28918822f8f.23.2026.11.24.19.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:28:08 -0800 (PST)
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
Subject: [PATCH v6 2/6] dt-bindings: display: panel: add LG SW43103
Date: Wed, 25 Nov 2026 04:27:58 +0100
Message-Id: <20261125032802.8460-3-rofikcoga@gmail.com>
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

Document the SW43103 FHD+ AMOLED panel used by the LG V60. The panel
uses DSI command mode with DSC and DCS backlight control.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 .../bindings/display/panel/lg,sw43103.yaml    | 67 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml b/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
new file mode 100644
index 0000000000000..971547c48bd6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/lg,sw43103.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LG SW43103 1080x2460 DSI cmd mode panel
+
+maintainers:
+  - Abdur Rofik <rofikcoga@gmail.com>
+
+description:
+  The SW43103 is a 1080x2460 command-mode AMOLED panel used by LG V60 (timelm).
+  It uses Display Stream Compression (DSC) over a 4-lane MIPI DSI interface.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: lg,sw43103
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
index ccbcdc0799b9f..3386c7dfb9493 100644
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
 LG2160 MEDIA DRIVER
 M:	Michael Krufky <mkrufky@linuxtv.org>
 L:	linux-media@vger.kernel.org
-- 
2.39.5

