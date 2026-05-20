Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76063F4DD6
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301401; cv=none; b=JF/aHW4yhR+bSe279T9CotF7GHYVFsEncIGWOTME1KUgo1oEt9ULdc2VNVkK+UO+aTH9hTPOvxfcCDeNlJeB6CNsxw9pnRgqnKzkCZHq8MOag7wzQlIzMd6YJYOZmY47SnrdT1pqgCCTAhel7cH147GopGmCqrTtHhM0BWlxRW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301401; c=relaxed/simple;
	bh=sJYSHWc09xFtiXGLxIY3eCmrqPgEujr443cRCV1hpP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTNCZpLD12LQ05oTNV5zdFwVJip8xjtYiTUUeMZZhiS0LnbNYm9LLA8sfQDL75LPasn7nmczpQ4r4h41uiHZ5WL1PRtapLCt8L2Hcz2NyCt564gnnQ0wXx1ajj9of94iYfGKtpFpeigV0CcNfM7BG2PwgDopiBjx5VQL4bl8ppY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rZPLR0ee; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZPLR0ee"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48909558b3aso54555155e9.0
        for <linux-input@vger.kernel.org>; Wed, 20 May 2026 11:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779301398; x=1779906198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eV+WP61ShKOblE3anHz+BLN4XFN+aFPa0yNq3Cy5s6A=;
        b=rZPLR0eepIKcHVu7bhWkEfBnwl+1KMWEJjyfELBDkkHOv0mMQs04Tg08BdXAYVS4xh
         vkyfnxjKSALPjSDU+AZ67oj2541mnHaj0ElEK2aFS7egIj6lAn/NupggxKQSLqLi1/tQ
         Ep+0lXInLFI2pwT03sHEmvoQqNkoDbIbB3Ss/iUQ7iHgM9X9RXckgh5ONKbM0lM9rYLk
         9Rz3gLn4MQteOfSL4TmENtwsY9H5ss/J5IJ3BNiS5St/kKmzHfBDQUAifN4ZPaJINYtU
         sXWCJWjrG5SL4DNaUo6xrHRUXfXzi5bvdNc7w2eRkHBCdxE12ayxymd0Ej2FPACo0dB8
         MunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779301398; x=1779906198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eV+WP61ShKOblE3anHz+BLN4XFN+aFPa0yNq3Cy5s6A=;
        b=nBdw52Gmc25oANv9dnky+PqkXXRR3C0UnuRvDnAiN3ijl8vDHZ3NbC5J4k+HB4i6YJ
         Plb2HISEqoghYeoBKQy2BgD2aaiQ8iHa+e/1kwZDqlmyo8D2Q81TKFudgz2DMWHavbsp
         2mBJR8xNhRCRIw5pIp7/RNSgJXXgl56zQgBwe6rqbU4DWUZyd3D1rYtKB36qyRrDFh22
         KxvfW9iEORrU5howt6NrWFuSq2gu4CgCPvsqFCTdGvza1YLhwXZG2i3m2V3CfC+FhslN
         1kkvVfXtNzBqcaTX6tkBBIpOvwemMzjRjmgPryFjeAY0uxvxnigAKqPGT808ApUntPS8
         NDnA==
X-Gm-Message-State: AOJu0Yykrrq2JEZevHuCKCO7nJDabpF/Y17h6XIYS2M6J68j3k5NEyDg
	AyGOPZ2ruVtjAF6zJ83MUHVoShPhYSZpeIMxJ4mADTDgjNXMYCMOQhs8Df+CaQ==
X-Gm-Gg: Acq92OG7kTYa6TNQmncu4rreoSqK/DLgh0Lvg1AzSlQAA/BAT6FocZGKmVaLa8UDGVb
	FEhnu8qbZcOsuE0a2MzCy69inHybVDn8x0I+jVO5mUl2SBNcvU1jcXtr8PxlO+/tMfjsXW6xM+U
	zaVnonC4sCUG/NtMrdfz5XJzxLSxUb1u4X2SxI86wvn3H97UmdUCD6la0aOzeyZye+jvi39ULsD
	VbJ5CRyETCWzhjeap7wk6+mNS+GOzXesmKlzEAXKoZ7BdLQdUo5TBQS/kPRKySR7MOk2ZP4twxE
	PRtqP122X8I4Yp8N4rASKnrkImg0G2F503MRAbKOXgvSCq8g25nVTFh5nIJ4veckK4GPQoIWyX4
	PYlsdHdAxq1RqnZtoX+ebnBFJcDPgVZBFFYkgdZlwzEi/tQ5M8sm03xj20oeymKWqhvWcheJ9gt
	FTmf8Dp6Y5kQ8wv323kCWoxfM=
X-Received: by 2002:a05:600c:c494:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-48fe60ed839mr370183445e9.11.1779301397887;
        Wed, 20 May 2026 11:23:17 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3b18fsm51297739f8f.11.2026.05.20.11.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 11:23:17 -0700 (PDT)
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
Subject: [PATCH v6 2/6] dt-bindings: input: cpcap-pwrbutton: convert to DT schema
Date: Wed, 20 May 2026 21:21:20 +0300
Message-ID: <20260520182124.117863-3-clamor95@gmail.com>
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

