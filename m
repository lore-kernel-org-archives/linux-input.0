Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF5A31A061
	for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776409895; cv=none; b=WG0XBFWTrWB9jO2U3HJ2rbW3D3bMFeoUL5a6zTg59mD75IA3i6C0L0wrwwM8JbTmrjri5q6BviINdS7UB4Ic31gFKNW2IOYlXgWyUCFYoCFtMfi/hX+kJQkEmgAqZb5VtTO4M24tPHdxHZzo0JeMLkMEyFGEE5HehCIjF7s5Zco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776409895; c=relaxed/simple;
	bh=DrNGeBlRxTjZoXBtwt3WHPiWKByZ7OZ+6oYAQENqEx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpCiMzmKO2sYqf33NhrlLPSQUrRr9n2uIFWOLp4jttyWYWBfvBPWU85Bl+yuAUZ+pIW6fo6lC1ept2sSRA0Z8/Vq8cy7dsTd5Ls9318IVS4fEoJbPx7itz0eyq8ds8W/XHIdBSJjNsZNSpzSRZ9xgaGrV7kHFoi7u0mRD0oQNoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=La4oMK6r; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="La4oMK6r"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38e9653b580so3412481fa.2
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 00:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776409892; x=1777014692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFT7mMG9k0k/BXen8CQg8hnB8vdYe60xOPZB+uYBrVs=;
        b=La4oMK6r0bH9F3SRmHbdD+x7Gwy/4imtA632ohRbqRTyGsIBzmRKxbqfGKtQ9Qd7rS
         5MPpFRHiERg+hwVIkpIFAfQ5F2bMj7JcCmeDvWN/4NZXmWgqnHhpRkiH8UpzUHJEvWyC
         oE9Lw02G84VdlqgQ0G/vfeBoyuNpRKVURbd8dcYGNRlsmX4amyDb/zPAH7f2MLxIXyoW
         nw0cEPCk+RUnC42CRYV6q01HXOU3WaphXk5TsOq1XNqjLjT75S6UzM7UXufOx3pteQwJ
         4JJGa4/rliSULJw8IJPrCulKGH1lUUIUFWTulI9JQ1X0ypZsNu9UXpkBnnmJcAYtiRPo
         IUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776409892; x=1777014692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KFT7mMG9k0k/BXen8CQg8hnB8vdYe60xOPZB+uYBrVs=;
        b=Mg4O2/Xey+62ebpzUzHAbv1i/AypXqIU6XM4PFnw2K9hSdtqtiKtsa/3V51HDkaHL8
         TzP1L/o8bVMRzLh9hCKPCkcDTdjE790KodKh9VaYEmE+qkTiVo9I397wxY7oInn8caxG
         9JJbidEuDPklpV1WRSahC+Qje6tM0oZNvdZYZDFFEigu5w6Q3GCKwCihik9j+9TzaNJp
         fOCR78W0AvTagrAfJz+8Wko2CctArMrBRvt/36fv0JI5uN/x4b5LDgP60xcuFJ+5i7j6
         2T5bRZPcRCnJA4QTzTxO43DAqWH41S8JruSiOeYH0CQSsSdJaTCqJhUrmNufCrAD9gtd
         uQVA==
X-Gm-Message-State: AOJu0YwxGr/teN4EZjK5o2hQWXMhGpJOzCQ2JKcB/eGSlbwj+Vk+nT2U
	l8zfNR8RC5UvnJhrkSbJEB5juYPmPlFXgnSo8dkliU51Mu8gfuSOS54G
X-Gm-Gg: AeBDievMi8bQ1qycvQusiulg38UwhTxbrOSc20UsMABtgQmcOQ4KN23O2Rs+mBnGLio
	9JhO89CV4qmqnwEtWu36v7uyNXiFBu1TQlZzIBkZS4wXGoD/2DLqqAx8Z/0q8lJvAyXdb30qvRv
	8O0urOFfejZPSg07kdCJgrHi3jYc1X2gNkGJCqc4imVs0Wkqgzmk5z06S4ViJIrgfFl62cMLb8u
	T8ZjiHmPhFam+ASBGm+c8Wne93twwUBZN4RnP86oesncRJHl8AOCFX7t49V/Mo7xiYns3B/yvby
	oiARPZn9v6bZKUep6qLZew4Agl2p4gX/DlWANpnbjSzJXOGPUhQUaFW3QU0c0piAh38EXCpqfkm
	Rwz3mewAy6qUbXw3IpOi7mXt9IpHA3rASq5Ci9BzCq11looQpQ49YV2M7nJVtmN86j19x/3aiOe
	nQOSj3T2W65MbnYHocn5Senlk=
X-Received: by 2002:a05:6512:6d2:b0:5a2:abc3:eaa8 with SMTP id 2adb3069b0e04-5a4172f60a8mr474614e87.41.1776409891908;
        Fri, 17 Apr 2026 00:11:31 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185bc240sm162772e87.23.2026.04.17.00.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 00:11:31 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v4 1/6] dt-bindings: leds: leds-cpcap: convert to DT schema
Date: Fri, 17 Apr 2026 10:11:01 +0300
Message-ID: <20260417071106.21984-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417071106.21984-1-clamor95@gmail.com>
References: <20260417071106.21984-1-clamor95@gmail.com>
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

