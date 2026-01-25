Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643E127A907
	for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769354789; cv=none; b=sKf2+4xX6LXd5h9FDJduPbgoW6rCuhprq4P+MW4vHmEat1UOcieoTZBllA+SdE+GNTuAs+8Nwokfz7kIVFh+EqAYndoj/r8x2SqsaiWPixz7jz7HUcBe9YCGuIUNggYkZw3Rr4Y5BWg5Xb+XPcFKtVEjFmu5JmLTbm14BGeom30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769354789; c=relaxed/simple;
	bh=SNf2NU+hs+ZIS4XXchD9gc1LEk0khnpy5wXM0ouJBNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocHsIZ3ExE8aGHlX4avQZ/c5cTfRyayfjNsTQUZFkwcf8Hjp4oCwQmgiJVBrSO56x4Ao4CKNkiYcoXtPjpx4OgIheoORTt4z3PZ8IwFOvHGcRDHFFktBIWAtRQpVcQR5UNyBPuWFd8zTfHd44IhIWCsg84VR0TiijVH0uq7MR30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lt7hu1nK; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lt7hu1nK"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-385c23b88e8so39123481fa.3
        for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 07:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769354785; x=1769959585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXpwpGUeOVZ6gd5Z9uZtu+VcPr504HYG8KCye/qyxZo=;
        b=lt7hu1nKIxLNXQ3kzRArhNAJeQGRM4HYkX02CQ2Z44EzGWZZyV61/q/Y+xYqgilDaY
         GaCSaa/41I7JmTpRA9Fk36gwR3EkR9JHNZV5818B9T3sBgRuTQWZ8jAdNntPvxVgvOAj
         EghOx1JgzPZPO27NGp18N5SrRXvUSTGhJ6K2Cf0UBBduCPnKYvc1kgoR4JDdSM6NhrVg
         3cxpAOdlnjsY/gsoALRMRPjxv2xWbkZHOrCOGd4axjKIfTxYOTDn8MF4j+YJnVZWnd/W
         Y+YOpOKqgsA3jp2w3bcJa2H5F6DNsoIpBLMzAUjSnqJemb5r40hYV4+tD9IJwnKISIWn
         Oezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769354785; x=1769959585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXpwpGUeOVZ6gd5Z9uZtu+VcPr504HYG8KCye/qyxZo=;
        b=fmGVtj64MQFDyFv3eJ03yG+AWVd8fMcJNxBzTKYd8LDZrCJbEc4g4aB5gCiC5UQGSt
         iDvn8xH52wHMWsj+0gZnsTgcqVbMbofzWOA9R433e8sZziMBIdlul/nB0mtEZd501w4L
         uasCv8NnxbCyjMn+M5bWfiX0sSs+X8b7NZxzeI4dAuej6tM8pNsO0yCqk0BaAlLaBhZG
         ZDYok374AtQ2Gf92dzdsnnCtRPEJo7XPEiL6KzsX8ixDqrENkGAHbtJBGUzIses9oO8S
         9IGhD0Ws3aDSSxs0IxLL5YPZuj5WgA8hqXnBR/Ruz2qvXyxXD/wxLEV+U+AinI9kzH8a
         Rzug==
X-Forwarded-Encrypted: i=1; AJvYcCV1UsallJIsf2BPnB9OLaA7fTZuS5JINCOxF5hyjzeMgraii7Ew/d6dFlB/dza0NPnZe9D2MJJCAWtoEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJEstlezvpVBJ9JSJM3GpAD2xku0DaCAsGiKlYe3QrhRlzFKKB
	JHG7+CMzddrDLcfwX1GmJBojOwZCD94DeCKvqaVEvElaJaHMCWdsQ9XaJbm3IA==
X-Gm-Gg: AZuq6aJPF4KUcom8VW8SApGI/BHWTbnMHtRxNLH0Qdm2L8ohiTwzpyhFTBokfJHKexZ
	sE88rJcX2Q//aG7mb3YhEMZolvufPJRs9Ge1Ast7bbIQXsSMl8qdQjJ7/mmZkCA+1343dxWR4f/
	9mZo3MQbI3HiL3tr0WN//5d44QfZUSb4MVKFVfYEU7/nb7rcE0tLeYuinrlRGyN32c4iQUh/lbe
	+TYRMiZrTZlrgK5C9AD6QADGXpoqWVaWSo/Czfls+5dK0zVdmmqaBx+7CQvN9Y+cebif+lJsSIw
	eeC9JZeje1mn/OjQNrOU+BvtWDHDT4IS5VJNg55PRKt1veel49GHAy3aoMDyjKRdnF7ncwURwNV
	uEkWlcduD/FCPmNTLxharKqo1oF3wgnAV4VllQ3taeLUVRMtZpVKEa2QeMdonx3tXUQUcCQa1/h
	ob
X-Received: by 2002:a05:6000:2403:b0:430:f97a:6f42 with SMTP id ffacd0b85a97d-435ca39c59bmr3398601f8f.54.1769348598831;
        Sun, 25 Jan 2026 05:43:18 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c246ecsm22459688f8f.10.2026.01.25.05.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 05:43:18 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v1 06/10] dt-bindings: rtc: cpcap-rtc: convert to schema
Date: Sun, 25 Jan 2026 15:42:58 +0200
Message-ID: <20260125134302.45958-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125134302.45958-1-clamor95@gmail.com>
References: <20260125134302.45958-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert RTC devicetree bindings for the Motorola CPCAP MFD from TXT to
YAML format. This patch does not change any functionality; the bindings
remain the same.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../devicetree/bindings/rtc/cpcap-rtc.txt     | 18 -----------
 .../bindings/rtc/motorola,cpcap-rtc.yaml      | 32 +++++++++++++++++++
 2 files changed, 32 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/motorola,cpcap-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/cpcap-rtc.txt b/Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
deleted file mode 100644
index 45750ff3112d..000000000000
--- a/Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Motorola CPCAP PMIC RTC
------------------------
-
-This module is part of the CPCAP. For more details about the whole
-chip see Documentation/devicetree/bindings/mfd/motorola-cpcap.txt.
-
-Requires node properties:
-- compatible: should contain "motorola,cpcap-rtc"
-- interrupts: An interrupt specifier for alarm and 1 Hz irq
-
-Example:
-
-&cpcap {
-	cpcap_rtc: rtc {
-		compatible = "motorola,cpcap-rtc";
-		interrupts = <39 IRQ_TYPE_NONE>, <26 IRQ_TYPE_NONE>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/rtc/motorola,cpcap-rtc.yaml b/Documentation/devicetree/bindings/rtc/motorola,cpcap-rtc.yaml
new file mode 100644
index 000000000000..bf2efd432a23
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/motorola,cpcap-rtc.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/motorola,cpcap-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorola CPCAP PMIC RTC
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  This module is part of the Motorola CPCAP MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. The
+  RTC is represented as a sub-node of the PMIC node on the device tree.
+
+properties:
+  compatible:
+    const: motorola,cpcap-rtc
+
+  interrupts:
+    items:
+      - description: alarm interrupt
+      - description: 1 Hz interrupt
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

