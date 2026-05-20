Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334CA3F8706
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301399; cv=none; b=dHzekpA2/cLtNJY5ktLjjOWnG7bXg2DQj5rGYO4wrS9DKHFjHV+0BGAqZ2e4YVStGCjvppIeleMWGjg2hSEGiIiL7mnub1XEhW/xAuM/o+Z3rVRtTWZO6dsUsGkdV+D09gSvIrhJN701waxxB1n3qaqqmn2OH4EjHjn7Gbblpks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301399; c=relaxed/simple;
	bh=DrNGeBlRxTjZoXBtwt3WHPiWKByZ7OZ+6oYAQENqEx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjfmkM/0nM1v1QqBRmZmtrE+KG4KucHw7Al6GOjbqbHARsZ/bGaqPBct+oL+gwZQZyBW6VrbGAtCaDPCe0ponWFIFHmwiZFx9JjPWl6OaUEFWacdClMHxojMG3UeuQIt5I+7zS8Em4NBoEtVyJZxipSsPTByTSE9yC/0fUaQiP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akt16iCY; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akt16iCY"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44509921fbcso3346733f8f.3
        for <linux-input@vger.kernel.org>; Wed, 20 May 2026 11:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779301397; x=1779906197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFT7mMG9k0k/BXen8CQg8hnB8vdYe60xOPZB+uYBrVs=;
        b=akt16iCYWyGuFuq/BySn+yBAP22U+VauCP1VfFjlxMpEu0M2DrcMBMHrTJ9padWPYD
         BiBtSU0CWO+TPWZ9cpQNi6LhC6EljQflx2K8LEl+lsb/iwLG7y49IGopsXLElVo83Wsc
         H9iMB1H2w68rIl444/CBLzCxoEVIXN4v9qfoTHrKG8622u16TJ07FF1LOEAWyJw4RPN6
         r1XI/8HeaxlPKUV5K/03OEmk8qdrg51CKoX8UPZY9OpN0Ym7O5kaytnAzbxhTVhZGZmH
         ZwvUb4z6B1A46gCpoZ8D4ljd/zsPNJqWVp9bcvEoMJICk55tzBXaYwW4K16g4468CzDp
         E/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779301397; x=1779906197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KFT7mMG9k0k/BXen8CQg8hnB8vdYe60xOPZB+uYBrVs=;
        b=U+LLwsvGkjHyEyjz/TA5HmIq1EN/vDhLLJAU+hunR4Y2xmJ1qcwcctw2yNtBhEa8DT
         qORZAl5WliEDqrcGIkBoZnxqCpID4XXRHetPyGr3yjzJLAXDUdcV5argeM7xOTlsKKrJ
         RlI+a3S+zdjuPulQzcOCwvFwrtZ2ilPcum1R5jVnOrsgXX3NTAfAoMTcsNGTIBiaIDKv
         dXrizWsbpSyZl2Ze40a3i5qr6qsJbltiM/3yNWNhxlTzcBTYAReOcjBgM1X1bJh3Aba8
         CQpesTwfn396rieK8JXb+s1aDGZNQgYmsNMzjxx0Kr+SJiazCHUkupn4UyILwh7F0P8J
         qE5w==
X-Gm-Message-State: AOJu0YwCeclDyU+oVp+1n6Xio3CV3xipo3z1oLKNRcbxVB6+sUWxVr3r
	Q44s0iLz+g7xFoMUwyj55qeE3ZKe5xrcEKb52vwbFw/3jmFytlBWa/4U
X-Gm-Gg: Acq92OHij2fonM/FDwC6n2zowgFdzUlf9B9r+xOGccSO64fLXVItMmioLSz/ddPnlyR
	/9TaLBZTlR80ePDWdmhjBzSZCm6mpoVQ7p++4hANUAauJyaa0fo7NmgU0hqImpIpHa0km77MVUc
	gjw5iYJKuVdeZVrUctAnMOJqyCeNfVNfmOIPVmfLQFbZ3t0N9hhuzPciw0sMqissktpluZ/b1aO
	WbAUjwkR6/x0jjbOYTRqaA/xCjRc5/S9uBFQpz0nC54adVhoT5o/QHplgl33XSMvJGLxrR0eSmr
	YbfddCrkjj28ZA0TSE0sGVMzqZpz1kIQno8GnFTcrfOPREKjs5TLaN1iRAUaBM5nWs6TTcKCHNb
	lNM/PuJxomAEZjNce6A9J8d2JtCWqNcWmxyBg/RpSk2ld1aPdwXfPJYiy5tpGE00lwedwEq2x08
	1MtuQP11XLuWhB
X-Received: by 2002:a05:6000:24c9:b0:43c:ffee:ee94 with SMTP id ffacd0b85a97d-45e5c5a0198mr43839740f8f.11.1779301396553;
        Wed, 20 May 2026 11:23:16 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3b18fsm51297739f8f.11.2026.05.20.11.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 11:23:16 -0700 (PDT)
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
Subject: [PATCH v6 1/6] dt-bindings: leds: leds-cpcap: convert to DT schema
Date: Wed, 20 May 2026 21:21:19 +0300
Message-ID: <20260520182124.117863-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520182124.117863-1-clamor95@gmail.com>
References: <20260520182124.117863-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert LEDs devicetree bindings for the Motorola CPCAP MFD from TXT to
YAML format. This patch does not change any functionality; the bindings
remain the same.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/leds/leds-cpcap.txt   | 29 -------------
 .../bindings/leds/motorola,cpcap-leds.yaml    | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap.txt
 create mode 100644 Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-cpcap.txt b/Documentation/devicetree/bindings/leds/leds-cpcap.txt
deleted file mode 100644
index ebf7cdc7f70c..000000000000
--- a/Documentation/devicetree/bindings/leds/leds-cpcap.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Motorola CPCAP PMIC LEDs
-------------------------
-
-This module is part of the CPCAP. For more details about the whole
-chip see Documentation/devicetree/bindings/mfd/motorola-cpcap.txt.
-
-Requires node properties:
-- compatible: should be one of
-   * "motorola,cpcap-led-mdl"		(Main Display Lighting)
-   * "motorola,cpcap-led-kl"		(Keyboard Lighting)
-   * "motorola,cpcap-led-adl"		(Aux Display Lighting)
-   * "motorola,cpcap-led-red"		(Red Triode)
-   * "motorola,cpcap-led-green"		(Green Triode)
-   * "motorola,cpcap-led-blue"		(Blue Triode)
-   * "motorola,cpcap-led-cf"		(Camera Flash)
-   * "motorola,cpcap-led-bt"		(Bluetooth)
-   * "motorola,cpcap-led-cp"		(Camera Privacy LED)
-- label: see Documentation/devicetree/bindings/leds/common.txt
-- vdd-supply: A phandle to the regulator powering the LED
-
-Example:
-
-&cpcap {
-	cpcap_led_red: red-led {
-		compatible = "motorola,cpcap-led-red";
-		label = "cpcap:red";
-		vdd-supply = <&sw5>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml b/Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
new file mode 100644
index 000000000000..c8e7b88a05cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/motorola,cpcap-leds.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorola CPCAP PMIC LEDs
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  This module is part of the Motorola CPCAP MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. LEDs are
+  represented as sub-nodes of the PMIC node on the device tree.
+
+allOf:
+  - $ref: /schemas/leds/common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - motorola,cpcap-led-adl # Display Lighting
+      - motorola,cpcap-led-blue # Blue Triode
+      - motorola,cpcap-led-bt # Bluetooth
+      - motorola,cpcap-led-cf # Camera Flash
+      - motorola,cpcap-led-cp # Camera Privacy LED
+      - motorola,cpcap-led-green # Green Triode
+      - motorola,cpcap-led-kl # Keyboard Lighting
+      - motorola,cpcap-led-mdl # Main Display Lighting
+      - motorola,cpcap-led-red # Red Triode
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - label
+  - vdd-supply
+
+unevaluatedProperties: false
+
+...
-- 
2.51.0

