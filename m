Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1004E497B9C;
	Fri, 25 Sep 2026 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790338178; cv=none; b=dNqj9yqcVPKmtZvvQdThxBRuNNpMzMXl1ykZA2l9ZMXGWZAZGJzHxQoSfgYo8dnfgLy/D3orlhH/RPu1KvAGorkvJR0DiZQ5H0NcAQFTstSXWM0gOkoSdJPX/0BpiZ/PS7wBo9U0xOU2BhRyo5Y0KdHfWwsRbgfEi3NctqgSDA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790338178; c=relaxed/simple;
	bh=4qiYD27LZQmNYf2FNSkR2aGivadOxQ+TW8v3vHQM4LY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vzw5aOxFFXar6M5l1OsFkVEqIa7ieSWRes0EkwMR4rhrpL3IOFC8qCGo9nrLEqR+Kl1YD1rz1XRiuNIS3neKH6lARuTVaQTVrvpNNFVIH1O2JP/WCUeBEFZH1z+fYKwhv52lZ8UllLbgS4WTzj7GtwEeZzUAcK5iTByg8WGSkyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T90ZnRCl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T90ZnRCl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3863C2BCFF;
	Fri, 25 Sep 2026 12:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790338177;
	bh=4qiYD27LZQmNYf2FNSkR2aGivadOxQ+TW8v3vHQM4LY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T90ZnRClfqLxx32H+GdNCORpOpgCkZ1olfBDCkGhy1h0ZVvYvhTyJLEpMLh0Egn/0
	 li/TGNFJcJK3w2ojkbKsal4Hup/4vP1ZQp90tJfmW3FfKWTqjIX1paoYsjhlz0xlO+
	 cH1GWzUq5WXNmep9GvfPC72Rqu0CWTjqBckJl9xWtv+W8rG88hzlVLMfNJ5AY3xFP4
	 dwLdj/k+Km/F6MiRk8UNAuRvABiEQHFQim9wE+ObY/QOWplqM4g6hr0PIkLHCFGhVb
	 1zr1jAba5xFdsUAV8URoVfNKAxSqA0R0xuIGqCWrPlEmfCHJp7qfTDoHaDgKQe2uO1
	 jWD4bn2wSnFQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1779C98321;
	Fri, 25 Sep 2026 12:09:37 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Fri, 25 Sep 2026 22:09:36 +1000
Subject: [PATCH v4 09/10] arm64: dts: apple: Add MTP DockChannel HID nodes
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-apple-mtp-keyboard-final-v4-9-304c267518f4@gmail.com>
References: <20260925-apple-mtp-keyboard-final-v4-0-304c267518f4@gmail.com>
In-Reply-To: <20260925-apple-mtp-keyboard-final-v4-0-304c267518f4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790338174; l=11038;
 i=michael.reeves077@gmail.com; s=fedora-20260918;
 h=from:subject:message-id;
 bh=/5hkCvCUAmjCSdccexaiCZN2CQ/12JP1JSbFKuWg8as=;
 b=Dcb4DvQ5PRf2PmLPaVVK1wJ7FmoGNOhMCXMZ1GM4WiYZexiB1afsXxkOXnI8rTxQWe1x0PLGb
 2/Gb1A27gAXAxbDIVv4lN1l3cwGgfrM8rTI7P+lm/wR8Z88NoTuTd0P
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=VJ0TvyQ9TvfzYZa908YSE9kpkjFLLD5luv0bERu+boc=
X-Endpoint-Received: by B4 Relay for
 michael.reeves077@gmail.com/fedora-20260918 with auth_id=1035
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

From: Michael Reeves <michael.reeves077@gmail.com>

Add disabled MTP nodes for the Apple SoCs used by M2 and M3 systems.

Each instance describes the RTKit ASC mailbox, MTP DART, DockChannel
mailbox, and DockChannel HID client. Board files can enable them on
machines that route internal input through MTP.

Co-developed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
 arch/arm64/boot/dts/apple/t602x-die0.dtsi | 47 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t6030.dtsi      | 47 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t6031-die0.dtsi | 47 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8112.dtsi      | 47 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8122.dtsi      | 48 +++++++++++++++++++++++++++++++
 5 files changed, 236 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t602x-die0.dtsi b/arch/arm64/boot/dts/apple/t602x-die0.dtsi
index c33623f0e..c0e74edad 100644
--- a/arch/arm64/boot/dts/apple/t602x-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t602x-die0.dtsi
@@ -161,6 +161,53 @@ pinctrl_smc: pinctrl@2a2820000 {
 				<AIC_IRQ 0 857 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	mtp_mbox: mbox@2a9408000 {
+		compatible = "apple,t6020-asc-mailbox", "apple,asc-mailbox-v4";
+		reg = <0x2 0xa9408000 0x0 0x4000>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 693 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 0 694 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 0 695 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 0 696 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "send-empty", "send-not-empty",
+				  "recv-empty", "recv-not-empty";
+		#mbox-cells = <0>;
+		status = "disabled";
+	};
+
+	mtp_dart: iommu@2a9808000 {
+		compatible = "apple,t6020-dart", "apple,t8110-dart";
+		reg = <0x2 0xa9808000 0x0 0x4000>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 676 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		status = "disabled";
+	};
+
+	mtp_dockchannel: mailbox@2a9b14000 {
+		compatible = "apple,t6020-dockchannel", "apple,t8112-dockchannel";
+		reg = <0x2 0xa9b14000 0x0 0x4000>,
+		      <0x2 0xa9b30000 0x0 0x4000>,
+		      <0x2 0xa9b34000 0x0 0x4000>;
+		reg-names = "irq", "config", "data";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 677 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <0>;
+		apple,irq-index = <1>;
+		status = "disabled";
+	};
+
+	mtp_hid: hid@2a9400000 {
+		compatible = "apple,t6020-dockchannel-hid", "apple,t8112-dockchannel-hid";
+		reg = <0x2 0xa9400000 0x0 0x4000>,
+		      <0x2 0xa9c00000 0x0 0x100000>;
+		reg-names = "coproc-asc", "coproc-sram";
+		mboxes = <&mtp_mbox>, <&mtp_dockchannel>;
+		mbox-names = "asc", "dockchannel";
+		iommus = <&mtp_dart 1>;
+		status = "disabled";
+	};
+
 	sio_dart: iommu@39b008000 {
 		compatible = "apple,t6020-dart", "apple,t8110-dart";
 		reg = <0x3 0x9b008000 0x0 0x8000>;
diff --git a/arch/arm64/boot/dts/apple/t6030.dtsi b/arch/arm64/boot/dts/apple/t6030.dtsi
index dda9568af..327bff4b9 100644
--- a/arch/arm64/boot/dts/apple/t6030.dtsi
+++ b/arch/arm64/boot/dts/apple/t6030.dtsi
@@ -474,6 +474,53 @@ wdt: watchdog@3642b0000 {
 			interrupts = <AIC_IRQ 480 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		mtp_mbox: mbox@37a408000 {
+			compatible = "apple,t6030-asc-mailbox", "apple,asc-mailbox-v4";
+			reg = <0x3 0x7a408000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 953 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 954 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 955 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 956 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "send-empty", "send-not-empty",
+					  "recv-empty", "recv-not-empty";
+			#mbox-cells = <0>;
+			status = "disabled";
+		};
+
+		mtp_dart: iommu@37a808000 {
+			compatible = "apple,t6030-dart", "apple,t8110-dart";
+			reg = <0x3 0x7a808000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 937 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		mtp_dockchannel: mailbox@37ab14000 {
+			compatible = "apple,t6030-dockchannel", "apple,t8112-dockchannel";
+			reg = <0x3 0x7ab14000 0x0 0x4000>,
+			      <0x3 0x7ab30000 0x0 0x4000>,
+			      <0x3 0x7ab34000 0x0 0x4000>;
+			reg-names = "irq", "config", "data";
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 939 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <0>;
+			apple,irq-index = <1>;
+			status = "disabled";
+		};
+
+		mtp_hid: hid@37a400000 {
+			compatible = "apple,t6030-dockchannel-hid", "apple,t8112-dockchannel-hid";
+			reg = <0x3 0x7a400000 0x0 0x4000>,
+			      <0x3 0x7ac00000 0x0 0x100000>;
+			reg-names = "coproc-asc", "coproc-sram";
+			mboxes = <&mtp_mbox>, <&mtp_dockchannel>;
+			mbox-names = "asc", "dockchannel";
+			iommus = <&mtp_dart 1>;
+			status = "disabled";
+		};
+
 		pinctrl_smc: pinctrl@36c820000 {
 			compatible = "apple,t6030-pinctrl", "apple,t8103-pinctrl";
 			reg = <0x3 0x6c820000 0x0 0x4000>;
diff --git a/arch/arm64/boot/dts/apple/t6031-die0.dtsi b/arch/arm64/boot/dts/apple/t6031-die0.dtsi
index 47d08672a..b0a01b875 100644
--- a/arch/arm64/boot/dts/apple/t6031-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t6031-die0.dtsi
@@ -195,3 +195,50 @@ serial0: serial@391200000 {
 		power-domains = <&ps_uart0>;
 		status = "disabled";
 	};
+
+	mtp_mbox: mbox@2ac408000 {
+		compatible = "apple,t6031-asc-mailbox", "apple,asc-mailbox-v4";
+		reg = <0x2 0xac408000 0x0 0x4000>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 692 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 0 693 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 0 694 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 0 695 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "send-empty", "send-not-empty",
+				  "recv-empty", "recv-not-empty";
+		#mbox-cells = <0>;
+		status = "disabled";
+	};
+
+	mtp_dart: iommu@2ac808000 {
+		compatible = "apple,t6031-dart", "apple,t8110-dart";
+		reg = <0x2 0xac808000 0x0 0x4000>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 675 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		status = "disabled";
+	};
+
+	mtp_dockchannel: mailbox@2acb14000 {
+		compatible = "apple,t6031-dockchannel", "apple,t8112-dockchannel";
+		reg = <0x2 0xacb14000 0x0 0x4000>,
+		      <0x2 0xacb30000 0x0 0x4000>,
+		      <0x2 0xacb34000 0x0 0x4000>;
+		reg-names = "irq", "config", "data";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 676 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <0>;
+		apple,irq-index = <1>;
+		status = "disabled";
+	};
+
+	mtp_hid: hid@2ac400000 {
+		compatible = "apple,t6031-dockchannel-hid", "apple,t8112-dockchannel-hid";
+		reg = <0x2 0xac400000 0x0 0x4000>,
+		      <0x2 0xacc00000 0x0 0x100000>;
+		reg-names = "coproc-asc", "coproc-sram";
+		mboxes = <&mtp_mbox>, <&mtp_dockchannel>;
+		mbox-names = "asc", "dockchannel";
+		iommus = <&mtp_dart 1>;
+		status = "disabled";
+	};
diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
index ec248ca05..dfe6a229c 100644
--- a/arch/arm64/boot/dts/apple/t8112.dtsi
+++ b/arch/arm64/boot/dts/apple/t8112.dtsi
@@ -987,6 +987,53 @@ pinctrl_aop: pinctrl@24a820000 {
 				     <AIC_IRQ 307 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		mtp_mbox: mbox@24e408000 {
+			compatible = "apple,t8112-asc-mailbox", "apple,asc-mailbox-v4";
+			reg = <0x2 0x4e408000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 864 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 865 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 866 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 867 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "send-empty", "send-not-empty",
+					  "recv-empty", "recv-not-empty";
+			#mbox-cells = <0>;
+			status = "disabled";
+		};
+
+		mtp_dart: iommu@24e808000 {
+			compatible = "apple,t8110-dart";
+			reg = <0x2 0x4e808000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 848 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		mtp_dockchannel: mailbox@24eb14000 {
+			compatible = "apple,t8112-dockchannel";
+			reg = <0x2 0x4eb14000 0x0 0x4000>,
+			      <0x2 0x4eb30000 0x0 0x4000>,
+			      <0x2 0x4eb34000 0x0 0x4000>;
+			reg-names = "irq", "config", "data";
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 850 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <0>;
+			apple,irq-index = <1>;
+			status = "disabled";
+		};
+
+		mtp_hid: hid@24e400000 {
+			compatible = "apple,t8112-dockchannel-hid";
+			reg = <0x2 0x4e400000 0x0 0x4000>,
+			      <0x2 0x4ec00000 0x0 0x100000>;
+			reg-names = "coproc-asc", "coproc-sram";
+			mboxes = <&mtp_mbox>, <&mtp_dockchannel>;
+			mbox-names = "asc", "dockchannel";
+			iommus = <&mtp_dart 1>;
+			status = "disabled";
+		};
+
 		ans_mbox: mbox@277408000 {
 			compatible = "apple,t8112-asc-mailbox", "apple,asc-mailbox-v4";
 			reg = <0x2 0x77408000 0x0 0x4000>;
diff --git a/arch/arm64/boot/dts/apple/t8122.dtsi b/arch/arm64/boot/dts/apple/t8122.dtsi
index 1ee61c5b3..26c96921d 100644
--- a/arch/arm64/boot/dts/apple/t8122.dtsi
+++ b/arch/arm64/boot/dts/apple/t8122.dtsi
@@ -438,6 +438,54 @@ pinctrl_aop: pinctrl@2f4824000 {
 				     <AIC_IRQ 351 IRQ_TYPE_LEVEL_HIGH>,
 				     <AIC_IRQ 352 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		mtp_mbox: mbox@2fa408000 {
+			compatible = "apple,t8122-asc-mailbox", "apple,asc-mailbox-v4";
+			reg = <0x2 0xfa408000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 838 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 839 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 840 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 841 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "send-empty", "send-not-empty",
+					  "recv-empty", "recv-not-empty";
+			#mbox-cells = <0>;
+			status = "disabled";
+		};
+
+		mtp_dart: iommu@2fa808000 {
+			compatible = "apple,t8122-dart", "apple,t8110-dart";
+			reg = <0x2 0xfa808000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 822 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		mtp_dockchannel: mailbox@2fab14000 {
+			compatible = "apple,t8122-dockchannel", "apple,t8112-dockchannel";
+			reg = <0x2 0xfab14000 0x0 0x4000>,
+			      <0x2 0xfab30000 0x0 0x4000>,
+			      <0x2 0xfab34000 0x0 0x4000>;
+			reg-names = "irq", "config", "data";
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 824 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <0>;
+			apple,irq-index = <1>;
+			status = "disabled";
+		};
+
+		mtp_hid: hid@2fa400000 {
+			compatible = "apple,t8122-dockchannel-hid",
+				     "apple,t8112-dockchannel-hid";
+			reg = <0x2 0xfa400000 0x0 0x4000>,
+			      <0x2 0xfac00000 0x0 0x100000>;
+			reg-names = "coproc-asc", "coproc-sram";
+			mboxes = <&mtp_mbox>, <&mtp_dockchannel>;
+			mbox-names = "asc", "dockchannel";
+			iommus = <&mtp_dart 1>;
+			status = "disabled";
+		};
 	};
 };
 

-- 
2.55.0


