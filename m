Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E236A4F7CAB;
	Fri, 18 Sep 2026 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738121; cv=none; b=X6tJFmEMq/i9dnxG8fH05242NmsnL0SkIf5Y4piT/3w4ZNGKHhre5abp9h6MnQ+0d4W1UW1R3cs3DQkkvAs+JZCpFn9DP2/yhRmHzBwNlVD7rliJnyv0iEp5KPW/hoHbf0fyeJFILl8eRu+OE26jEjzxuOUbxPY4kqabNfNGt6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738121; c=relaxed/simple;
	bh=XsLeQwB1fLUCtAKmgPFpm557IbbzSOp56z8va3WVDH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sadcsgI8ZtMTWhMG6Y+sV02jalgQ+SIXAzRhlL55iHEsUzvqDNFI4ZQLb2/o8ZBRvJ/Nc0smUy+A6K2gh33d10PmgzEWMZhseWL4SFxFap7JYAjkEN8FHaMRcBeT1eY+kLajUI/l/l8I2VI2M6HACyUuBrh9XI3tufsi8kztVKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNaYGErW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNaYGErW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FC28C4DDF1;
	Fri, 18 Sep 2026 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789738120;
	bh=XsLeQwB1fLUCtAKmgPFpm557IbbzSOp56z8va3WVDH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MNaYGErWQCvV3M5+lpKWBXF1p0O7L6sf3Ac5JXJz1ZP2Jn59oLJA+F49bPtsvxEZc
	 uu2ZQAcT51KDiinj+K0h98OLZMOvEDEd3HqZahvy+eaA6+JM+p1/34/ZkBsZUF1mP3
	 bn6wzVnbZUryaq6KgvcUoW8lpmeHDyA/sRd4e81dObIfYYKoa2rZzbRAt+AuRw5BBQ
	 J0QiST1dz6IR4lN8TG9GxbDcXZUCKkpBpsDmgKP98BhnYQlCFRtvES0kaf7PAP5DPN
	 hAaBVmE3bqYsauL/qsToBL5WCCbDIGfq2ir59M0fSO9WcjUfn8Eqi3bS1tV6P3dMSb
	 OsYA/rjY8Mj6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6C9C982D8;
	Fri, 18 Sep 2026 13:28:40 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Fri, 18 Sep 2026 23:28:40 +1000
Subject: [PATCH v3 10/10] arm64: dts: apple: Enable DockChannel HID on M2
 and M3 laptops
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-apple-mtp-keyboard-final-v3-10-e356464e454b@gmail.com>
References: <20260918-apple-mtp-keyboard-final-v3-0-e356464e454b@gmail.com>
In-Reply-To: <20260918-apple-mtp-keyboard-final-v3-0-e356464e454b@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-input@vger.kernel.org, 
 Yureka Lilian <yureka@cyberchaos.dev>, Julian Braha <julianbraha@gmail.com>, 
 Sasha Finkelstein <k@chaosmail.tech>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789738118; l=7273;
 i=michael.reeves077@gmail.com; s=fedora-20260918;
 h=from:subject:message-id;
 bh=78kUfdeWKUeiEf4dX7SZ0qB0VILZ/K/tdCVxq/uYAb0=;
 b=TGgCftyINjFjNL0uGFbBppvjrdM3U4Yf9IkDp1GwSU4ezULdUcx5vSDeaD3sAx+dqNhgzbUt7
 /tfScv6XQBVDgjGX/wg1xPhPJryLHGdVDcva/wqv68UFTNfSsupAvZ5
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=VJ0TvyQ9TvfzYZa908YSE9kpkjFLLD5luv0bERu+boc=
X-Endpoint-Received: by B4 Relay for
 michael.reeves077@gmail.com/fedora-20260918 with auth_id=1035
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

From: Michael Reeves <michael.reeves077@gmail.com>

Enable the MTP mailbox, DART, DockChannel mailbox, and HID transport on
the M2 and M3 laptop device trees using this internal input path.

Add a keyboard alias and keyboard child node for each machine so the
transport can expose the internal keyboard.

Co-developed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
 arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi | 29 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi | 24 +++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8112-j413.dts       | 24 +++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8112-j415.dts       | 24 +++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8112-j493.dts       | 26 ++++++++++++++++++++++-
 arch/arm64/boot/dts/apple/t8122-j504.dts       | 26 +++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8122-j613.dts       | 27 ++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8122-j615.dts       | 27 ++++++++++++++++++++++++
 8 files changed, 206 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi b/arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi
index 0e806d8dd..91fda44d9 100644
--- a/arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi
+++ b/arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi
@@ -16,6 +16,12 @@
 
 #include "t600x-j314-j316.dtsi"
 
+/ {
+	aliases {
+		keyboard = &keyboard;
+	};
+};
+
 &framebuffer0 {
 	power-domains = <&ps_disp0_cpu0>, <&ps_dptx_phy_ps>;
 };
@@ -43,3 +49,26 @@ &wifi0 {
 &bluetooth0 {
 	compatible = "pci14e4,5f72";
 };
+
+&mtp_mbox {
+	status = "okay";
+};
+
+&mtp_dart {
+	status = "okay";
+};
+
+&mtp_dockchannel {
+	status = "okay";
+};
+
+&mtp_hid {
+	status = "okay";
+
+	keyboard: keyboard {
+		hid-country-code = <0>;
+	};
+
+	stm {
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi b/arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi
index 517b84c18..f6fe382de 100644
--- a/arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi
+++ b/arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi
@@ -21,6 +21,7 @@ / {
 	chassis-type = "laptop";
 
 	aliases {
+		keyboard = &keyboard;
 		serial0 = &serial0;
 	};
 
@@ -64,3 +65,26 @@ &serial0 {
 &fpwm0 {
 	status = "okay";
 };
+
+&mtp_mbox {
+	status = "okay";
+};
+
+&mtp_dart {
+	status = "okay";
+};
+
+&mtp_dockchannel {
+	status = "okay";
+};
+
+&mtp_hid {
+	status = "okay";
+
+	keyboard: keyboard {
+		hid-country-code = <0>;
+	};
+
+	stm {
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t8112-j413.dts b/arch/arm64/boot/dts/apple/t8112-j413.dts
index 7ccfceb08..5b9bdad3d 100644
--- a/arch/arm64/boot/dts/apple/t8112-j413.dts
+++ b/arch/arm64/boot/dts/apple/t8112-j413.dts
@@ -20,6 +20,7 @@ / {
 
 	aliases {
 		bluetooth0 = &bluetooth0;
+		keyboard = &keyboard;
 		wifi0 = &wifi0;
 	};
 
@@ -93,3 +94,26 @@ &fpwm1 {
 };
 
 #include "hwmon-laptop.dtsi"
+
+&mtp_mbox {
+	status = "okay";
+};
+
+&mtp_dart {
+	status = "okay";
+};
+
+&mtp_dockchannel {
+	status = "okay";
+};
+
+&mtp_hid {
+	status = "okay";
+
+	keyboard: keyboard {
+		hid-country-code = <0>;
+	};
+
+	stm {
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t8112-j415.dts b/arch/arm64/boot/dts/apple/t8112-j415.dts
index fdc3409d2..3da132eeb 100644
--- a/arch/arm64/boot/dts/apple/t8112-j415.dts
+++ b/arch/arm64/boot/dts/apple/t8112-j415.dts
@@ -20,6 +20,7 @@ / {
 
 	aliases {
 		bluetooth0 = &bluetooth0;
+		keyboard = &keyboard;
 		wifi0 = &wifi0;
 	};
 
@@ -93,3 +94,26 @@ &fpwm1 {
 };
 
 #include "hwmon-laptop.dtsi"
+
+&mtp_mbox {
+	status = "okay";
+};
+
+&mtp_dart {
+	status = "okay";
+};
+
+&mtp_dockchannel {
+	status = "okay";
+};
+
+&mtp_hid {
+	status = "okay";
+
+	keyboard: keyboard {
+		hid-country-code = <0>;
+	};
+
+	stm {
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t8112-j493.dts b/arch/arm64/boot/dts/apple/t8112-j493.dts
index 7cea5c594..ecc057929 100644
--- a/arch/arm64/boot/dts/apple/t8112-j493.dts
+++ b/arch/arm64/boot/dts/apple/t8112-j493.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+ OR MIT
 /*
- * Apple MacBook Pro (13-inch, M1, 2022)
+ * Apple MacBook Pro (13-inch, M2, 2022)
  *
  * target-type: J493
  *
@@ -24,6 +24,7 @@ / {
 	 */
 	aliases {
 		bluetooth0 = &bluetooth0;
+		keyboard = &keyboard;
 		touchbar0 = &touchbar0;
 		wifi0 = &wifi0;
 	};
@@ -149,3 +150,26 @@ touchbar0: touchbar@0 {
 
 #include "hwmon-laptop.dtsi"
 #include "hwmon-fan.dtsi"
+
+&mtp_mbox {
+	status = "okay";
+};
+
+&mtp_dart {
+	status = "okay";
+};
+
+&mtp_dockchannel {
+	status = "okay";
+};
+
+&mtp_hid {
+	status = "okay";
+
+	keyboard: keyboard {
+		hid-country-code = <0>;
+	};
+
+	stm {
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t8122-j504.dts b/arch/arm64/boot/dts/apple/t8122-j504.dts
index 464491b55..a08a130be 100644
--- a/arch/arm64/boot/dts/apple/t8122-j504.dts
+++ b/arch/arm64/boot/dts/apple/t8122-j504.dts
@@ -18,6 +18,10 @@ / {
 	compatible = "apple,j504", "apple,t8122", "apple,arm-platform";
 	model = "Apple MacBook Pro (14-inch, M3, 2023)";
 
+	aliases {
+		keyboard = &keyboard;
+	};
+
 	led-controller {
 		compatible = "pwm-leds";
 		led-0 {
@@ -35,3 +39,25 @@ &fpwm1 {
 	status = "okay";
 };
 
+&mtp_mbox {
+	status = "okay";
+};
+
+&mtp_dart {
+	status = "okay";
+};
+
+&mtp_dockchannel {
+	status = "okay";
+};
+
+&mtp_hid {
+	status = "okay";
+
+	keyboard: keyboard {
+		hid-country-code = <0>;
+	};
+
+	stm {
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t8122-j613.dts b/arch/arm64/boot/dts/apple/t8122-j613.dts
index 51894ea70..a81326cd5 100644
--- a/arch/arm64/boot/dts/apple/t8122-j613.dts
+++ b/arch/arm64/boot/dts/apple/t8122-j613.dts
@@ -17,6 +17,10 @@ / {
 	compatible = "apple,j613", "apple,t8122", "apple,arm-platform";
 	model = "Apple MacBook Air (13-inch, M3, 2024)";
 
+	aliases {
+		keyboard = &keyboard;
+	};
+
 	led-controller {
 		compatible = "pwm-leds";
 		led-0 {
@@ -33,3 +37,26 @@ led-0 {
 &fpwm1 {
 	status = "okay";
 };
+
+&mtp_mbox {
+	status = "okay";
+};
+
+&mtp_dart {
+	status = "okay";
+};
+
+&mtp_dockchannel {
+	status = "okay";
+};
+
+&mtp_hid {
+	status = "okay";
+
+	keyboard: keyboard {
+		hid-country-code = <0>;
+	};
+
+	stm {
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t8122-j615.dts b/arch/arm64/boot/dts/apple/t8122-j615.dts
index 2a1970c1b..21bcacb6f 100644
--- a/arch/arm64/boot/dts/apple/t8122-j615.dts
+++ b/arch/arm64/boot/dts/apple/t8122-j615.dts
@@ -17,6 +17,10 @@ / {
 	compatible = "apple,j615", "apple,t8122", "apple,arm-platform";
 	model = "Apple MacBook Air (15-inch, M3, 2024)";
 
+	aliases {
+		keyboard = &keyboard;
+	};
+
 	led-controller {
 		compatible = "pwm-leds";
 		led-0 {
@@ -33,3 +37,26 @@ led-0 {
 &fpwm1 {
 	status = "okay";
 };
+
+&mtp_mbox {
+	status = "okay";
+};
+
+&mtp_dart {
+	status = "okay";
+};
+
+&mtp_dockchannel {
+	status = "okay";
+};
+
+&mtp_hid {
+	status = "okay";
+
+	keyboard: keyboard {
+		hid-country-code = <0>;
+	};
+
+	stm {
+	};
+};

-- 
2.55.0


