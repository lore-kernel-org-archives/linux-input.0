Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803123;
	b=fMCj4LzvgAAD7YU33CESvipa3/t+3+FUWYNQcP9eLh39CprdolKZv52R6fC6yvgcJjD0
	 CvqYBNUj5U4XJ6Xa6mghcog2JE/u0f0Mv/1whTqESMWFz1gQa8FnCeDDNz4A+tS4lIxC3
	 Zs/bKDhzlNdzYQKhBSXk37qsW9aOmcQid9afpZBhe1VeXqBObzUKXrhQMEyiJ5+BkpfJC
	 /+IHudH22lSiOcu1kJNj/DPuOGek4F7fUoCbLKOQRZHpN1S1HKw7jFDSbYSvCwChkXpTA
	 WLdunTm8fsa8xKgoAo0V8U+kMee3Y/ysVUnQHHSBGIq7dVu6LYAxITbV+c9/1/lMIUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=FOqWh0YVIMqSNQR+C9AUSAav6J63QCzsPs/EWmskesI=;
	b=dE8nVPyyF6D7zPuYCUOtKUqQPYYnOj/UZnqqgaXgskTSDlPXXT6rBHcUS62KS0CsM42g
	 uc4XXy0c7Eq/ac6hjRvLWfidrgBQEFlKeYl3lkb7dQhSNBPJ0qdFnsWTUiT1zUfNZF6RQ
	 7m1mX+6OTYuP9A7Q6KbLjwztUAd4P/zMwCrz4s683qBpaaGWdZ0WMNFFmLPVKvDCCkj06
	 f+wTHTqi5MZXOFljZU9E6//C3wsLPyEVnoBJrEeeKqPy+G5zfQqif1Pl7wRpIhNYpyyR6
	 hpJwvfsvugPdDUhBTZ5Ly8WDJZdiDl1hM+ZRABQhIzeoekoFf+kVNw+11XxqToya7Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dXuB4Hch;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6979260A261F
	for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 00:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6979260A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dXuB4Hch
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc147d86bebso677493a12.0
        for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 17:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792803118; x=1793407918; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FOqWh0YVIMqSNQR+C9AUSAav6J63QCzsPs/EWmskesI=;
        b=dXuB4Hchn949TxwwrxnOqWrN7tFQqf8FYrosr0zcDvftQEXUenfgHn60BVKN0n3e9j
         fPhI1ylzo3uVaSGq2wfYuA5lesY5wZNd6r+UxMymP/Ln7yips+8XEPVeWsE2gJD6dApk
         CrJKThWRC/bMhsVKBj5xusQaQGD3wp7ppjIc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792803118; x=1793407918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FOqWh0YVIMqSNQR+C9AUSAav6J63QCzsPs/EWmskesI=;
        b=JMAyb8UOLvVMj1pNo4+kUcnk0UirqusxqzdnEcWASdzE6hpnYDC7ddp3CqOf+bT6kJ
         0rT3zpww+NKG+Pm+l9Nkn6qLNx6w248SYR+SMla4fzP9JPRI/NvROuL7Z1/X+nA9f2DS
         nqduWtDD1Hd7O/Gb58wMfkjyLpN+2HzYAq6TUnrm0RlfAQGpAPT06mVpunGrstbhlEC7
         7LGloRKiWJBSsHFsTFz04inB+gPAAcTF6i1BOZi6WiYR0uZfsqu5sY3gIuU3A1pXrubd
         WNy06NS0hnsKlBd+xUaA4xe7Gcizk0N7WDdV6m4V+zj/VVDBi7sqoHVcO7sMlufRb8Ux
         zJeQ==
X-Gm-Message-State: AFq9FYKWuB2O3Q0JZvlUkhruDZAPbUKygy6U91ybNzu6bTJ0JUnc4eNV
	+b+5cNPK7dJIGlsdaAKD6daVCLCrxuUUgwJxPEhGfGlfljEXXsi8Scvl6l3MKMLe0M4g0rxlJ2M
	hYDE=
X-Gm-Gg: AYBFou1wK36gFgioNjTxiLj+ulQqED38iHK+kFFVTpvf4FkYVBYrx30b/2+nCj0mYmk
	w9ONJJyEcZGja60fSJzGvQ6g9kKjo/W4zhHg4aIAMfXRWsLk2cAYhw7VkYJaiLgps+3zySom7mK
	uXp9zjQmMzZ4BnszZOQ14c8UJwZUbT1Z729sgVBNwJDMvPazfZPoW0nnKELYxhv9aSzyMVRJz5/
	SBhPClgS/DzfmfiQ/lQ4YAjVovqhS8Sc3ubXnKKWrE2VdnYkt6xn0mbDLX1EFGrcM7adaZ4Wd0f
	h2x10ze+u4I+jPJ1pfvSb1kTbw+ZzKdw5NB1OCfg16xSdINcuT7o0OBqIqsGDJdG8lHrKtes9af
	ZTGgjhoRyYLaGa/nh5Md76Hbs2tAwrnS9dqou3Q5ROY43wmFe5qa2mjX5pqqFFUtU5K36bsbdQc
	EwJ2oigARFbSVVxW2vN82ftCLBri/chCuxOOKT6lJWgBlg0SAxAvk39t5vm1/y+xtxWK7F9RIgt
	PY25YIZRFrymNyOEfN8dh4CDfg8ELPfVVfiLNIyChtL2ujc8sZXdzLYDhxC+62giZ8wQRePiZMr
	sm4vpfKasTpTjKrehToUqixZ13JQiYtxReSUODqTs5uB7hp7UGv8H+6bt8LBPo4=
X-Received: by 2002:a17:90b:6c8:b0:3ad:ba54:c3d6 with SMTP id 98e67ed59e1d1-3adeb3aa756mr451535a91.1.1792803117836;
        Fri, 23 Oct 2026 17:51:57 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfeb1sm843763a91.9.2026.10.23.17.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:51:57 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Sat, 24 Oct 2026 00:51:42 +0000
Subject: [PATCH v7 08/11] dt-bindings: input: Document hid-over-spi DT
 schema
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-send-upstream-v7-8-abad13174b43@chromium.org>
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
In-Reply-To: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Dmitry Antipov <dmanti@microsoft.com>, 
 Jarrett Schultz <jaschultz@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792803111; l=2819;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=LKvYa/CLhKW+YzjSrs/NoZ9wb/gOcKYEJBUJ8orknbs=;
 b=dsZaqSkAfRPlQsBnAlhhKrVeQzXIS3bZOeQJ5YOz7fnco+9KGbTAo5yazXZtfLMbg3/nVpvgb
 XOaIb5Tfds/C784G7HjUd9pqWsagfxfpzdw8j+o9DFF+ntj2LIpYQjX
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Dmitry Antipov <dmanti@microsoft.com>

Documentation describes the required and optional properties for
implementing Device Tree for a Microsoft G6 Touch Digitizer that
supports HID over SPI Protocol 1.0 specification.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 .../devicetree/bindings/input/hid-over-spi.yaml    | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
new file mode 100644
index 000000000000..bed0746f004c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/hid-over-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HID over SPI Devices
+
+maintainers:
+  - Benjamin Tissoires <bentiss@kernel.org>
+  - Jiri Kosina <jikos@kernel.org>
+  - Jingyuan Liang <jingyliang@chromium.org>
+
+description: |+
+  HID over SPI provides support for various Human Interface Devices over the
+  SPI bus. These devices can be for example touchpads, keyboards, touch screens
+  or sensors.
+
+  The specification has been written by Microsoft and is currently available
+  here: https://www.microsoft.com/en-us/download/details.aspx?id=103325
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - microsoft,g6-touch-digitizer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO specifier for the device's reset line. The HID over SPI
+      specification requires a dedicated, host-driven, active-low reset
+      line. The line must be flagged with GPIO_ACTIVE_LOW.
+
+  vdd-supply:
+    description:
+      Regulator for the VDD supply voltage.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - vdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      hid@0 {
+        compatible = "microsoft,g6-touch-digitizer";
+        reg = <0x0>;
+        interrupts-extended = <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
+        reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+        vdd-supply = <&pm8350c_l3>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&ts_d6_int_bias>;
+      };
+    };

-- 
2.56.0.257.gf7497c7d27-goog

