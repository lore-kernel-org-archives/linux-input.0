Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2176A25E469
	for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784468286; cv=none; b=Y/s403Z7eQ5objlai4Bx33l/uWbyXYYsQzjuL2a5Frtna+6MGEJIakJwMnVbPAaDcSHFhAppMCr+f3EHKmdspicniNeQQHG6ou7HcOxXO5V/XHsRaY81VI8Luleh7Q8bvwDTvc2g1EMyUAS5eAVvYK1RAh0BCf+3NKBoTUn6uJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784468286; c=relaxed/simple;
	bh=WftaguEcCAcPmKC9Su5TwqMoY3w6a0AarFeIyjamMCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZqG95O1WUCRbCo1sMnZaNlPVEDqcvVKYG/5KCU5JGSmBUN8mgfADY2vT0y0E/2OT2cKHXNcOw7rPwpxM6EcYmbz0+E2U9lLnHKr+/wsf8M/QM+1WRb3kn+JBYx9FThOhti/HjYZu5qnBHIKWzRtrtj8aOes5RVepnc+mE6i0nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUugsB5c; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUugsB5c"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-495590dde14so5187925e9.0
        for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 06:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784468283; x=1785073083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PpzzNW2sfZBH0zCyv8njtaSsrPQC9iQno8eKZX+8/b4=;
        b=BUugsB5cWADzNMpelhEwbaw7eYt36ZsNqOC3WwG7CkLVlT92r+2aYk6nnRzI4Igtv6
         TFrCG4xnJgMqmpw+yVgbyAnr9drVYyDX7YwkFXgC0h40WwPjwyCKwq767MWWfcUrDmEa
         vo7+Rf6clxP4ALsALVghtUvY4jkuX/2nYGs1yDMCjWnjyO7XSNPj0kJzCEhhzJmetmpg
         BP5gPh92Kxpx131pcgaIE1bnVz/JFCLxgebqKcIQboSDmVoPIhQS3Mx8PotfKTGvN+Or
         jPXTtYvNpjPaU9ih2DAiKyA4leS6d9rfkYwol+CtDqZ+5aAu8KZlZmvBxbN8t4Wy+ETy
         fdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784468283; x=1785073083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PpzzNW2sfZBH0zCyv8njtaSsrPQC9iQno8eKZX+8/b4=;
        b=IDYnDVSGLlT9RFN8ZVzCppaNQ5Or6bpQ+xioGwpUc42buXIbqr0jafokdtpXR3HCJ6
         R+N3CroNBYXR6qT/UauaL0113IloYgGSlUM5uv7HQ3UwyXQtjlKsK+0+r2FRO4bw3LQO
         Gntm1zuqamiuiMfP9ew6dn8G6RD7FaM04YRC2Fz00+UzVYwDJ1fFVSJU91aPKwkKz+Wa
         gNb5QWKdxnqSs4jNDN7lig3b9JJm9Kj/8QwDHhSG26sMKuiotdX1JzZELAD1gbJUgyVT
         89o3zn+X/E2YbZJw3jNnDdl7y7ClR5VBgWVmqhgF5KcuJdobptrgFl++2yq8S0298T2c
         kSfQ==
X-Forwarded-Encrypted: i=1; AHgh+RrjD/rpeuFS0Xe3NlI03/KbmTPFiLMQUIjlU3bzJlYqkuaZJLR1tLjfF0/3ioyge7tzm1UBwsEQTGPM9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFb7fNfB6eWHlcCgYirNsOdMoc3MNQqhR5JhMdeH24wipagbF/
	aK1Xu1pM+RzbfLMAAGvxwdP6OC84F+wTkiy96LlAG5WC1mjT9UxAJgRD
X-Gm-Gg: AfdE7clUsaxmgym/kouf82o5sGjHKeI5aLge3LaKn6kp22w7OiQ4Q8Va9L/li/CLtYi
	KugBh6TZek9Mpg2B+V8VEXP/YLBKwm0Adyw8EIQrNUyV/oDWbrqinQZNp6GyN29QEbkeFD3N4VY
	o/c1hdaXPsGZibp7QVsBsIMbEIZTfbDHdva/D3NPq3DOJUQuNb6FVnhJrXhx1V/v+DQD4/uRanx
	8TnPToYivGkbrnG8Fi7KykW/6zzjpda7PnYoxq1exkLyR3Xg172cg8rVZBXWBgfqXM3ozVvkCUw
	LQCqjkVPDFsU9NsPJvfzCZRQv2AknZiVUlDM/Pcb2PqtHLc8AW0LXMIYNCHSv5RfJfGo0UtsS4P
	PuxTMM59YjTXO2/hPRMSQs1z5uXsEGU9IoqQOHTHfxftGD+t/ZeSsg+MCfaZEw/4XugHnwp12Td
	SUOi0FiNEmHDmNlPLPiClBDztJtGSGwJIXWe33mUGTTNEo
X-Received: by 2002:a05:600c:3b01:b0:495:4fd4:144b with SMTP id 5b1f17b1804b1-4954fd419e8mr72113155e9.21.1784468283025;
        Sun, 19 Jul 2026 06:38:03 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f63edda9bsm21807179f8f.31.2026.07.19.06.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 06:38:02 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eduard Bostina <egbostina@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH v2 2/2] ARM: dts: ti: omap: Disable keypad and enable it on the boards that use it
Date: Sun, 19 Jul 2026 13:37:30 +0000
Message-ID: <20260719133730.3551691-3-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719133730.3551691-1-egbostina@gmail.com>
References: <20260719133730.3551691-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The keypad node in omap4-l4.dtsi and omap5-l4.dtsi lacks the matrix keymap,
which is board specific. The binding requires the matrix properties, so the
incomplete template nodes fail dtbs_check.

Mark the keypad disabled in the SoC files and enable it on the boards
that actually complete the node with a keymap.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
 arch/arm/boot/dts/ti/omap/motorola-mapphone-mz607-mz617.dtsi | 2 ++
 arch/arm/boot/dts/ti/omap/omap4-droid-bionic-xt875.dts       | 2 ++
 arch/arm/boot/dts/ti/omap/omap4-droid4-xt894.dts             | 2 ++
 arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts            | 2 ++
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi                      | 1 +
 arch/arm/boot/dts/ti/omap/omap4-sdp.dts                      | 2 ++
 arch/arm/boot/dts/ti/omap/omap5-l4.dtsi                      | 1 +
 7 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/motorola-mapphone-mz607-mz617.dtsi b/arch/arm/boot/dts/ti/omap/motorola-mapphone-mz607-mz617.dtsi
index a356b3a2f24e..b97ab2906950 100644
--- a/arch/arm/boot/dts/ti/omap/motorola-mapphone-mz607-mz617.dtsi
+++ b/arch/arm/boot/dts/ti/omap/motorola-mapphone-mz607-mz617.dtsi
@@ -4,6 +4,8 @@
 #include "motorola-mapphone-common.dtsi"
 
 &keypad {
+	status = "okay";
+
 	keypad,num-rows = <8>;
 	keypad,num-columns = <8>;
 	linux,keymap = <MATRIX_KEY(5, 0, KEY_VOLUMEUP)>,
diff --git a/arch/arm/boot/dts/ti/omap/omap4-droid-bionic-xt875.dts b/arch/arm/boot/dts/ti/omap/omap4-droid-bionic-xt875.dts
index 1d9000f84f1b..e72ac17fdd96 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-droid-bionic-xt875.dts
+++ b/arch/arm/boot/dts/ti/omap/omap4-droid-bionic-xt875.dts
@@ -18,6 +18,8 @@ aliases {
 };
 
 &keypad {
+	status = "okay";
+
 	keypad,num-rows = <8>;
 	keypad,num-columns = <8>;
 	linux,keymap = <
diff --git a/arch/arm/boot/dts/ti/omap/omap4-droid4-xt894.dts b/arch/arm/boot/dts/ti/omap/omap4-droid4-xt894.dts
index cc3f3e1b65ea..62f87cf95f74 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/ti/omap/omap4-droid4-xt894.dts
@@ -46,6 +46,8 @@ slider {
 };
 
 &keypad {
+	status = "okay";
+
 	keypad,num-rows = <8>;
 	keypad,num-columns = <8>;
 	linux,keymap = <
diff --git a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
index e11d1931c42a..d51913620f06 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
+++ b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
@@ -428,6 +428,8 @@ mpu9150: imu@68 {
 };
 
 &keypad {
+	status = "okay";
+
 	pinctrl-names = "default";
 	pinctrl-0 = <&keypad_pins>;
 	keypad,num-rows = <2>;
diff --git a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
index c1afc49f456c..00f98991cc5c 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
@@ -1200,6 +1200,7 @@ keypad: keypad@0 {
 				reg = <0x0 0x80>;
 				interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 				reg-names = "mpu";
+				status = "disabled";
 			};
 		};
 
diff --git a/arch/arm/boot/dts/ti/omap/omap4-sdp.dts b/arch/arm/boot/dts/ti/omap/omap4-sdp.dts
index b550105585a1..a04234b3be2a 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-sdp.dts
+++ b/arch/arm/boot/dts/ti/omap/omap4-sdp.dts
@@ -531,6 +531,8 @@ &emif2 {
 };
 
 &keypad {
+	status = "okay";
+
 	keypad,num-rows = <8>;
 	keypad,num-columns = <8>;
 	linux,keymap = <0x00000012	/* KEY_E */
diff --git a/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi b/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi
index 72849e1c95b0..af32ca329930 100644
--- a/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi
@@ -2449,6 +2449,7 @@ target-module@c000 {			/* 0x4ae1c000, ap 11 1c.0 */
 			keypad: keypad@0 {
 				compatible = "ti,omap4-keypad";
 				reg = <0x0 0x400>;
+				status = "disabled";
 			};
 		};
 	};
-- 
2.43.0

