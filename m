Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121CF369202
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770633870; cv=none; b=g5Rp8gf4FhIzcs3FAA4cHag1QIfy1TmSWa/RA4r2XnOgILoSVc721uyoVc27B7KiPpV4y16CbTCgXbcfR1z8c00VQ2lbE6z7OELuwMxyeN3TQ4dvwpelPGVe9El43yNOgFSnU2F8GHyWtdL3DLJYjRYblfOQk8h0vEASDSVPIGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770633870; c=relaxed/simple;
	bh=0rMc9serpkGe0Fm6CAZ7oAjYMwzI8MQXlyyHyy0L5GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWCQODr9u5nfxOulowfF1bqzXOMVjAt9b4Ql2qRTK3reSe1CaJbG4D9TJEUOjlfIK7yCZ2rVyyARi5R5ymzJz8vcIqqE5boEFlJ2XuoTFpx9CS8UDSM05azQZHCX0n30xlAI+dk3djM7biDziFLQnI5Ito723MKex+U22neOHSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pt3lXARm; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt3lXARm"
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-59de2d1fc2cso6369975e87.2
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 02:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770633868; x=1771238668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvOWIK1480Z8Yx2DsXHdUSkuQ/WnPILfKjXKA3uostg=;
        b=Pt3lXARmjg3kVulV3S5F7WLUVPqFht8rBb9v9tagQPuKAud9SSF8o9gteV5jYy9kv0
         pjDE+bPx1h2AqwKfxiTmVeSc7RS9ye+WroCUjeFMn4Q/8e735BAU1aP+hBiErrd4ZYoQ
         T+cgyV8o5BLmg7qTmtoMkV/yCf+hEregYpf64ttZehYgWP9ThvU4FYQhMewZ8u/NPtxJ
         2JMylXD5aPt4yB2GQjbLk1D6CVXpr7mmrot3TajSTupjbkbYJvHkiMlHcWMnK25hFF0P
         OBEZI0JCeR4+1o2N5oY91fEl4r5fmBgvLr+o6NcoX5TVr9ZUS5GlSGBhSZkS2C6QYWW/
         2PFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770633868; x=1771238668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pvOWIK1480Z8Yx2DsXHdUSkuQ/WnPILfKjXKA3uostg=;
        b=cNKM7PEqxLVswjZAjpqPud5Todm/tuFfxC7G9d0rIsuCPBjcSCHKS2ITyGdwqIbIBY
         DeOmCYlqoHZfkiX7v/T81LVVLGIskmOcm7AjTZO9w92horPmhPQlhFdpu2TV+uW+CXJf
         jXNcKN1RFySpuSe0FAZQ4uUavoMico9eWCyVV34lt4sw8GnRGuiJ2GVTF1KN3VlmYS/k
         BiHaECoEd0iSWgbWm+AZx1S2BNwddHN2fJgRUserIZcQjR6yDPff2HCX8g88qUNkRuaF
         699sR+i93Q9JK6shOeR5FdlONrcgj4SAvVdHv4jHAJ9cv2ZAvQaWVkV3qwa6pDO8cUNS
         7VNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGO2l7KWuJfNaFrLbBUPnuU72hNsEM40FS52cIfUR3Z1SGqWrVPTc31uD87wQ8VIdcwuAaUamPDjgxCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe2f/ZdrNW/vypseVsLGq3cqUiFqsRjTnTGYof0ZCO6coKZBVV
	mZQSVSBpTYaeRo5uCXJuRJ24V18itVmsp4yXoTpTCxUG+epD7/HVywU8
X-Gm-Gg: AZuq6aJ3vrWw787SmqtMixd9Rh+vfUjrxrFoW0eR2qW1VtReM+WtCVA8UVN36tEzAd3
	tSWR2F3LRTfzJH9xT8P9nnsqclrSSdbYFVr9to4AjoAFtF0Hx7jR7vdWQqcL4EEwHqVNfgRUxCY
	+jtnNtg0/93htwsctDZIaodT+OfJ7jnRy+1UThXoasdS36+jHKfc2HG80NH39JUPGQZ2YtNmS6Y
	9JLsxmiX4pg6T8X/fLnphXH5XWH5GJh6lDelkpms6JKWBDR1v8e5VX7Dta+0DP3oMpnmmFcX+8v
	OFJhN5oCJKWb90ezrqvzHSiswu2SfpAuf1n2XE1bXAjqVNECb/qwSbmq6738HLZNHqK8ziSVBme
	6fZ76KMAEzr/i7b5vi7ZgpE203NinMn6Dg4K9E0Wa7z4Omah/ft2CtrdNgapxmhiBLKxP4fsk1j
	2n
X-Received: by 2002:a05:6512:32c8:b0:59d:d615:4b72 with SMTP id 2adb3069b0e04-59e451532f8mr3290200e87.25.1770633867920;
        Mon, 09 Feb 2026 02:44:27 -0800 (PST)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cf6f88sm2501469e87.21.2026.02.09.02.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 02:44:27 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Ion Agorria <ion@agorria.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 1/9] dt-bindings: misc: document ASUS Transformers EC DockRAM
Date: Mon,  9 Feb 2026 12:43:59 +0200
Message-ID: <20260209104407.116426-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209104407.116426-1-clamor95@gmail.com>
References: <20260209104407.116426-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documenting an I2C device used in conjunction with the EC on ASUS
Transformers. The main function of DockRAM (the name used by downstream
ASUS sources) is to provide power-related functions, such as battery and
charger communication. The device is exposed as an individual entity
because multiple embedded controllers can utilize the same DockRAM
instance.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/misc/asus,dockram.yaml           | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/asus,dockram.yaml

diff --git a/Documentation/devicetree/bindings/misc/asus,dockram.yaml b/Documentation/devicetree/bindings/misc/asus,dockram.yaml
new file mode 100644
index 000000000000..0cfde619ba01
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/asus,dockram.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/asus,dockram.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Asus Transformer EC DockRAM
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  Dedicated i2c device used to provide power related functions of the
+  embedded controller used in ASUS Transformer device family.
+
+properties:
+  compatible:
+    const: asus,dockram
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      dockram@17 {
+        compatible = "asus,dockram";
+        reg = <0x17>;
+      };
+    };
+...
-- 
2.51.0

