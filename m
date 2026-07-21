Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841A4499BD
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627596; cv=none; b=SErZl2xHekWgl7095CgpzlEmfRjTweRB8KCOZ2MdVBlwwN7cCmzEKkhq9JLe/UEg+Ok0uL/AS+dmRPGcov0YB83FCQAT3v4xvvoTMQbokfGENuDf9hMqbQHwgJrSUgOdqOuyRd/uPLiIpH4sc6CBL+3qClkHsLNuQ4jYx+qUF8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627596; c=relaxed/simple;
	bh=0ir6EEm9FNQCLp9OUbkjQzJH24SRp6mnaINdn/CT2yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbNG7YAdHKBbgOWUJj6eJfZ5J6bUDCB5nte1omrQrYMfwcYkoWhWo42XQvyC1/4xfitF4INFaoIFR6fLkXDZCNDOzn70sxPCKZEoSIZgv7JLV1+4VR/qo5uVaqmkq9LXJhJ8jAPwDIZuKp3KLCd+HEfkXXyaylsokGCbpXDdDe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsOOpwQ+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsOOpwQ+"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49547fc63a0so19692875e9.2
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 02:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784627590; x=1785232390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y460qay5LS+R/33REWXsFlmhxRCfcVfcAqdFzdNEv44=;
        b=YsOOpwQ+3wfC0e2UXNFHanFBM/BVD5SaU4flkwj/lb4t6xsTB6dowmnnSHlAMlI3ug
         KpBbsNrDtTMlF9Jfsyz4WgZRLmN0LqMwTJ0LsnEOznlcIYcJLOIaBx//jwnLFUIKYBhy
         5DLHOmTE1xFo8Qnw63/Y4nXb/N6S6RUTVhXrk9WeGlLnhn3Kle/WXVFPN2WubL60GQgr
         FBYoGiDvedXc7Y+eulEzpLiN43koGYjP2I/W0x1RQSciafRvfTSw3zeqaiF958o43xbz
         yBNp6Bvq7XKPi5fyqwPqBrjrGnU40gC95XJhKwADxJtgxsHEk7vhYWgIIUNWuT4kxFH+
         HBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784627590; x=1785232390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y460qay5LS+R/33REWXsFlmhxRCfcVfcAqdFzdNEv44=;
        b=PxNY4Z+tCCaIBg1rVSCbBfObEDr5GPJSbzklLtx2KjfioT2ESCAiZoyLH7yu4EMVUq
         vSijgJT0N+3SYeCrpuXIaeo5dcvZ8wzijwFeZ+R4Gg6Z+XyyBsGJHK8PBnq08esvthnu
         6Nj2tB77rCJyEN7fZ9hPh4rqiAWCt56XeofaTA7FXWtqfbkC6QJCtSYMxrzA3HWSdV+o
         DwgKvRBWdF1vOlJObB+AIMpornYe5KOHL8S6laJZWb9AQMPsLrwI1yPIsW8OAFPiEPh9
         YN/XHuRJ7lPCIeJ6eTv1zUzXYN5CCha/sUEJjZhcTjSHmNwUbdyH4Wwf8/gXqya3rCFZ
         YP5w==
X-Forwarded-Encrypted: i=1; AHgh+Ro976HB6Ecsf17LgrLRZVUguXmfz91SgecmpgFGOl8ORioC06jt0/puQR2JtJTdnC3LnKaUPwz4xIdWXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYt3gBqTg2G2qKlZ2CPHzQqQyPqVQe+FTyPo9jAjYsea3FYtCk
	c2yxGCnbbWcaegfbNJvxROW2/Ixy1xLTrZpcYGVWvAIGS9HMmVM0tvrc
X-Gm-Gg: AfdE7cnNueaI9QkdiumAlhJo+D0htCNmVQrWDD8vUsWriEQOPfiKlMvIdgenvlhJ+hf
	5BNQhLDGdLsMK+bonetCOhaF6+stOWi8fCLPx3ZF5HzMZAQC1jvnk+DOEaaQkMGiVUbztJ/TXfQ
	ZFFA1YoolWoj6jgb1tkOoSTqoVbJFMF9Wg0TnzfPdounXfGqmGEDL6Hf6ztKieAcG0LsAmuzgbX
	kr1ezHSyf8WiZteBlUTtULut8hdPw9WF6oy6d3NZLV4WcV/apic8cfVHQtEyV2IcfHyoqY8Er8y
	A54/AHE/TQpOvhMBzlVq9jtu+/x8tPidF249ohtKb8woyzVR+/O82ZXuhHEn6cczTbaz7KUd78f
	P7SgpS3LTXSzlbRgLmw6jAgwVEhp5O6EvF+I638FS5sjFaieJDO00e30R3HfeDItLB7DmMzPb8h
	h6+TVD9ySlFrKlSr3JxuBmHos=
X-Received: by 2002:a05:600c:5490:b0:495:6130:7805 with SMTP id 5b1f17b1804b1-49561307a51mr66115845e9.14.1784627589765;
        Tue, 21 Jul 2026 02:53:09 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49565482c5asm82834285e9.10.2026.07.21.02.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 02:53:09 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v10 1/7] dt-bindings: embedded-controller: document ASUS Transformer EC
Date: Tue, 21 Jul 2026 12:52:27 +0300
Message-ID: <20260721095233.420823-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721095233.420823-1-clamor95@gmail.com>
References: <20260721095233.420823-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document embedded controller used in ASUS Transformer device series.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../asus,tf201-ec-pad.yaml                    | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml

diff --git a/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml b/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
new file mode 100644
index 0000000000000..60b6375864aaf
--- /dev/null
+++ b/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/embedded-controller/asus,tf201-ec-pad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASUS Transformer's Embedded Controller
+
+description:
+  Several Nuvoton based Embedded Controllers attached to an I2C bus,
+  running a custom ASUS firmware, specific to the ASUS Transformer
+  device series.
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+properties:
+  compatible:
+    description:
+      The 'pad' suffix is used for the controller within the tablet, while
+      the 'dock' suffix refers to the controller in the mobile dock keyboard.
+    oneOf:
+      - enum:
+          - asus,sl101-ec-dock
+          - asus,tf101-ec-dock
+          - asus,tf201-ec-pad
+          - asus,tf600t-ec-dock
+          - asus,tf600t-ec-pad
+
+      - items:
+          - enum:
+              - asus,tf101g-ec-dock
+              - asus,tf201-ec-dock
+              - asus,tf300t-ec-dock
+              - asus,tf300tg-ec-dock
+              - asus,tf300tl-ec-dock
+              - asus,tf700t-ec-dock
+          - const: asus,tf101-ec-dock
+
+      - items:
+          - enum:
+              - asus,tf300t-ec-pad
+              - asus,tf300tg-ec-pad
+              - asus,tf300tl-ec-pad
+              - asus,tf700t-ec-pad
+          - const: asus,tf201-ec-pad
+
+      - items:
+          - enum:
+              - asus,tf701t-ec-dock
+          - const: asus,tf600t-ec-dock
+
+      - items:
+          - enum:
+              - asus,p1801-t-ec-pad
+              - asus,tf701t-ec-pad
+          - const: asus,tf600t-ec-pad
+
+  reg:
+    description:
+      The ASUS Transformer EC has a main I2C address and an associated
+      DockRAM device, which provides power-related functions for the
+      embedded controller. Both addresses are required for operation.
+    minItems: 2
+
+  reg-names:
+    items:
+      - const: ec
+      - const: dockram
+
+  interrupts:
+    maxItems: 1
+
+  request-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+allOf:
+  - $ref: /schemas/power/supply/power-supply.yaml
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: asus,tf600t-ec-dock
+    then:
+      required:
+        - interrupts
+        - request-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      embedded-controller@19 {
+        compatible = "asus,tf201-ec-dock", "asus,tf101-ec-dock";
+        reg = <0x19>, <0x1b>;
+        reg-names = "ec", "dockram";
+
+        interrupt-parent = <&gpio>;
+        interrupts = <151 IRQ_TYPE_LEVEL_LOW>;
+
+        request-gpios = <&gpio 134 GPIO_ACTIVE_LOW>;
+
+        monitored-battery = <&dock_battery>;
+      };
+    };
+...
-- 
2.53.0

