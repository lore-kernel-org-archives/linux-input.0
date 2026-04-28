Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD963921D0
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777390598; cv=none; b=Fn8LAuXmJMMn3yuTG/ssSYlYE3myohI1Blp6fXtiqMa+bsZo8vf4zaahEphg5TGeuOtjm8UPBXSokLAJfd2hXVAELostpf9CiBMZKhrIrRKsCNypHGZyicFeiLZyQJxkiBPtx8irc2FLB4+dPuW8Wf6f0hY1JswKuecaz1XpELw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777390598; c=relaxed/simple;
	bh=DrNGeBlRxTjZoXBtwt3WHPiWKByZ7OZ+6oYAQENqEx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dv2F5Eom4ibUem0WwBRe+GwmvwT6PqAGRd1YvLqbOvJ3zaY3GaquFaXCUxKz+6lAfYlJFArin4ltkiKJ9MJDx/QZOoaFNutB7lMYStaV4ilEwjd7RR4oJwA0TYDz9rvWYLIOytcFiE9nKQ3m7NTwbI/GnIUKUGONB1ZTArJtdvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDorovP1; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDorovP1"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso96482965e9.3
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777390595; x=1777995395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFT7mMG9k0k/BXen8CQg8hnB8vdYe60xOPZB+uYBrVs=;
        b=mDorovP1vtG3qVNGAvuiZaUeQAB/SVLlSzcMis4/jv5E1v6ZmQEKzXd/38Kx+X4OYs
         A0qYPrp4+r7PrKFMDN4KxvC4cHUvrfUzCVUgENG9clBGm5ub5P4CQCiu0S7hTz2uN6HE
         FmY3DQDWGN+vuiW9PUQw02Ol3xY+488wudtXSHCDajTOkay7JXrbA2UbXHICQOKDLr0t
         ZTb5gVcKsIJVrRjTFrwn3pWt6YtTNhvqu1AJi0RR6NgDaazjr05zcyanvH7vWC1Y0u9s
         2u6ZxfpQ1HpsKjnQXM2+AttwLKgYXvOUPIj+GqYcAW31fVX9jWZb1ml8LpxiduwiA0Wk
         KuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777390595; x=1777995395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KFT7mMG9k0k/BXen8CQg8hnB8vdYe60xOPZB+uYBrVs=;
        b=NUiRlz2m6xkmpKNHcNv5N62a4kC7BMAydZXJ90n/CtsBbrBIOtiaxbCQL+R+AHM/tm
         g1zYwm5xH1mpksMQ1m0Fl8M2GLsHZxGl6s33Yu879oJ3JHn9YJxswOez55t4gXRe7BbM
         ZR/HAxwswpv/tzF/8hVU/B7Efk5xgZwH92Q932xXtGPOx0DUNq1fL3Kjc2pUZ4XU7HTN
         qJ8NLHodqCwjsre/ozXVtCwhODxor3fRbSdOiRETmmC/at4n7MWzxI6MwVDilByC1Gj0
         N3lsePKzy/+/AILqIYDaNf243OqsnGLtqDoX1zq3xNoUvAYb0LQ7EYlAyKbxUgiX1ClW
         nnAA==
X-Gm-Message-State: AOJu0YxM9nOeW8fJAY/BLRspW1dOc5Ts4dbjyMZdDD2hNiaKruU+9dw6
	2ueJYbcYUtd/y52sw9PpK4YtcOnyp6gjHomECXGQA8XhZMKYl4h3DFGi
X-Gm-Gg: AeBDieukIaQmgXj0xxA1SJoeJjZn/rMVUITCbpP1C58WLOkGTAQ4ETCKTKNyGB/L2hR
	kwwSu1WRA1VF/2/a53Djd5UdADk66QlNICRQwOXJNjyjGyrLHkRhuSHMctNOFdeN2eV1LM7jBpl
	Wbb52S9BSbhF2eUZC3DTPJR3Ul1gAJh5Lewu7mrZj+PW0NIHJlcc5SwVa6auB/qtu2QQGufBVvO
	KcQYcos4NBPwvTJeYMVLaDPNmehCx/pQXl35bSjX0XQcxVKYT4Tr4kqJCrRXIvRgIcWRrCgtD5D
	UNebEa5DevE/DZhWPo3174X1e1NMz+yhOw65gHIATkEqrfWtFe8OjYgwApOrzQp65OmCi6tYs+H
	nW5K9HzGqGLAs6VQxqzd/NrPYLr8aP+dcVLXYPF/K/WByj3J6L3KFVCRYVgAdaE1bZfWwhFA0uB
	1pDq6D5D7lF2oBO3V8xMBNVpc=
X-Received: by 2002:a05:600c:530f:b0:488:b241:2c5f with SMTP id 5b1f17b1804b1-48a77b298b3mr56286425e9.26.1777390594937;
        Tue, 28 Apr 2026 08:36:34 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b56c2d0sm1358875e9.11.2026.04.28.08.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 08:36:34 -0700 (PDT)
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
Subject: [PATCH v4 1/6 RESEND] dt-bindings: leds: leds-cpcap: convert to DT schema
Date: Tue, 28 Apr 2026 18:36:06 +0300
Message-ID: <20260428153611.142816-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428153611.142816-1-clamor95@gmail.com>
References: <20260428153611.142816-1-clamor95@gmail.com>
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

