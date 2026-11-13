Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794560412;
	b=t++tNeUqr3p/ZZWmSFyW+Wa4dQRgJky083BhNSNAKZAZxo546rlLHmUPxD/ZsMP21kKA
	 NI4+iDGFVZnvOqu02O9vTsces9L7dBkIKDXYJCkIahTvWKgGabvmW/f9Hlc3vCCVr/RYl
	 VDlam0eCSdcVjXevOI4emfRVU2v+RrZ03uqk7HNL4zfSgnXfumU/MRPjXLd1SnwVGe26L
	 gqhTp4mGHWl2B7l1uh55TWFFHHugDAYq50blc8CLJzhlIIJImtlango7ZoaFPddXToxpu
	 G/K9JMQo3gKNnu2iHCKRltjZpFYQppLzcSCMVV4BHPfg2/Bs6vI7EThSHRgl+oPA+Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Un80vRFzwpcVSJmCxlKjL26KdkwkmzqjZ1VKDAH+aPE=;
	b=MPgkf//GoRubEODEX0RaRYw6v4dhCijx0C3wrv1dt2T8R14igCpI9P+ndQXgAbAgwPZ9
	 NE2pAbzuKh2lAVFF31+rKs7yQhiE6jOUhokUB6VMB9vRY5PvRvCy2h82H1E2IvlheQrFv
	 WiY55wYEeLo/0c6rlVV/zX9y8u0EUxyRqnGPGpodM4UI2ICouamZAlVIcnampo4f6b97J
	 NckEhnOWQDJWg5RPgvUP+qO03E/LApjPQven4zAjjdpr5NHeDvY0e/LLSt0Wmbo1+166N
	 kfkDt+HY2QiymxkgfgPSzAn5LJ/fhJcjot+UV6BBlS3aEePWU7BwM1+goQ3H235svIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wo4k2G9C;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28405606A331
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 09:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28405606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wo4k2G9C
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ed0e2015aaso4082345ad.3
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 01:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794560411; x=1795165211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Un80vRFzwpcVSJmCxlKjL26KdkwkmzqjZ1VKDAH+aPE=;
        b=wo4k2G9Ch+TdfLfKs3LSzSmoXQG/4x9YfDkSpb7CG24WR2mcPTjIJuoR6KK0Tvq81H
         9hks5LOa5Eowl5fFrARTQyvR3ttBVXQHLLqyRTJWvPgJ8Qo2Wh2JU7Ydef/nrAET9D4t
         qintq2fx9FyCfJzlqBNAWXfJtgd0kjo8hl3+yInmg4qfq1J/u0HVDFEs3UFnxR1ndR3i
         erkae8PQHbdcTmEBhagTbda6IExPwxCULbsjQYNYWy/b2NHAQpAAgYYTsE2T9ps3T2Ql
         whhWtevMFy8kw/Z8r2KlTkH+7cBJ2/TxRSYRhWTZRj+o/oeXAxEPPXSbHM5F6pUCyWac
         EelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794560411; x=1795165211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Un80vRFzwpcVSJmCxlKjL26KdkwkmzqjZ1VKDAH+aPE=;
        b=iOJl4jkQlYjE/9o40rAIhz8OupJuVWsIwqHLaUUKSfn14JcIa14w0PKIPBrl5iY6WE
         aAJp/cwXXMNR/aQgrbjIq3bwuQHNykMudo4j8Jg5JXUHtWRJs72QQh7YKQ0hHE00AqeH
         RiRh9W0GVFH4ENgy/ffmugWo+rha3nnvSQJBizuKAc4piYqcnkmrOBnEHGgsWtqkjUR5
         8h3aHU07/OUxcX1EIgjZwe88NK6ZaM9eTzy7g1l3gBSlQwAcYxk9epnp1eIskjDdZIYK
         NkcAelScwPV8BT9iIavKm1Rm5crutVIAwjcJVVpRCyawBxZg3P/OvLP55EdeKAOq1prp
         jjsw==
X-Forwarded-Encrypted: i=1; AL+hErFT0e4gB5U3LNBl6CJNytm8/e6pjBA1LSWimZbMFHQa/N5qxbBUk4+OS1Dko4sfFW15GKLEqmCqGG1/5A==@vger.kernel.org
X-Gm-Message-State: APuU4Z80Hxi21qobZMJfJJJ0TGRX41qvma5JC5cCK0vDSPpZE6jC70ED
	2j/13NsmTK7hOoh3V+JQNFFAy4hfCVovqX0geh+gICcYxt3PybC3aecb
X-Gm-Gg: AYBFou2+a1mg3mf2c8NKV5tLIkg3beOnu0cwZp6DaUrf4sVChipmZDaDlP2NbJa5+SA
	u3Hy1msLPH5GFT+pAycbCrWLEL+jvs+hPAvpu7vseojW+WkdPVSoqF56UYRZ/s9Cdoo2BT1/+IH
	D0o+imaeTJAnb1Ae9pkDBOERwoTEhcINh5qp05ldztokT/oDSM1SBLEU+9luILK4eqZ7+Fp9udW
	lCINQk4j0FNTeU0r32EpM0sTYuxjgdgaT4s29EPY578NdRN/LYdwzXayGA303IVoCtwBAA+yY6f
	9uhH2oPcFxmLYmj54LpUsJJQctXLeJoI1uOGrtVjBVVHMYeysrSNIVAChf7bXIc7NTmXXknASAd
	ERrF3PzhrUTgilvxcVanQpy5L4c6rR2QN7PfZ8Kuat0Sgtvj4GJWUYDXuVlvoIcMlOTo1oC6hG8
	ZAi67QzEBG2cw2ipeMQDGZQRDXJfe3XE5VKgWZ7jJgMo6Ab4scqo/a7iKzUV02WyZiQRMKT9coU
	HultgxVOqd9eqpSX9ows5GkoDwRqkQULGJfyEXRECDnS6Rp9GWme+0lfBqYIUc5GnBUE9oCAbaj
	EBLU2vRGaeBm8h9vuna+DQvhB02duJaq/S53Nj9S7pfbFQpBUWgWHVCD3LG3+W7CFY4CUtFuf7z
	IXwIQ
X-Received: by 2002:a17:903:18e:b0:2e9:4bf3:37a1 with SMTP id d9443c01a7336-2ee0dd9fb88mr18714675ad.63.1794560411369;
        Fri, 13 Nov 2026 01:00:11 -0800 (PST)
Received: from fyhsueh.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f8dc859sm6953055ad.59.2026.11.13.01.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:00:10 -0800 (PST)
From: Feng-Yi Hsueh <fyhsueh4linux@gmail.com>
To: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	fyhsueh4linux@gmail.com
Subject: [PATCH v2 1/2] dt-bindings: input: Add Nuvoton MA35D1 keypad controller
Date: Fri, 13 Nov 2026 16:59:59 +0800
Message-ID: <20261113085959.32798-1-fyhsueh4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113084852.32727-1-fyhsueh4linux@gmail.com>
References: <20261113084852.32727-1-fyhsueh4linux@gmail.com>
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

Document the Nuvoton MA35D1 hardware matrix keypad controller.

The controller supports up to eight rows and eight columns
and generates interrupts for key press and release events.

Signed-off-by: Feng-Yi Hsueh <fyhsueh4linux@gmail.com>
---
 .../bindings/input/nuvoton,ma35d1-keypad.yaml | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/nuvoton,ma35d1-keypad.yaml

diff --git a/Documentation/devicetree/bindings/input/nuvoton,ma35d1-keypad.yaml b/Documentation/devicetree/bindings/input/nuvoton,ma35d1-keypad.yaml
new file mode 100644
index 000000000000..ff4f94166f0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/nuvoton,ma35d1-keypad.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/nuvoton,ma35d1-keypad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 Matrix Keypad Controller
+
+maintainers:
+  - Feng-Yi Hsueh <fyhsueh4linux@gmail.com>
+
+description: |
+  The Nuvoton MA35D1 keypad controller scans a matrix of up to eight rows
+  and eight columns and reports key press and release interrupts.
+
+allOf:
+  - $ref: /schemas/input/matrix-keymap.yaml#
+  - $ref: /schemas/input/input.yaml#
+
+properties:
+  compatible:
+    const: nuvoton,ma35d1-keypad
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  keypad,num-rows:
+    minimum: 2
+    maximum: 8
+
+  keypad,num-columns:
+    minimum: 1
+    maximum: 8
+
+  autorepeat: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - keypad,num-rows
+  - keypad,num-columns
+  - linux,keymap
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    keypad@404a0000 {
+        compatible = "nuvoton,ma35d1-keypad";
+        reg = <0x404a0000 0x10000>;
+        interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk KPI_GATE>;
+
+        keypad,num-rows = <4>;
+        keypad,num-columns = <1>;
+        linux,keymap = <MATRIX_KEY(0, 0, KEY_1)
+                        MATRIX_KEY(1, 0, KEY_2)
+                        MATRIX_KEY(2, 0, KEY_3)
+                        MATRIX_KEY(3, 0, KEY_4)>;
+    };
-- 
2.43.0

