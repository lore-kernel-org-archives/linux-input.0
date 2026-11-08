Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794122717;
	b=CrbuIZu8ysTGqRoomh0b2o2392Ep3oxfL2L8YFUj/2XHIDsC2KN2yeTumwvvr35v+C+1
	 HAmcPmMbVRztmXRUoEL7isH6G1Vk3k1ZliFn9rJOxZ1Vt/1W+KCwSqqh06QG3Q3r1Z70i
	 6L5XKzC3UirdLGjFfS7wXDr7JuKXbugTGXBNFF235KPxivODfTOv/tvKbaFlXSURNSk+P
	 BtgCEhU4tfapHMpd+PuqOEkxXJsfssqV250etfGpOTnBjqhuQNIWDlf+HuSJNMvpqcTqx
	 6sO0ZYud117N5gStkhFlctTsT0mrxxBS65J6c1j7T0swdr/EUrjUb298/fdqb9GgNxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794122717;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=h6/tcuwf4M16iHGktdr2wBFCXiF/+PUe+e/SrIDTxac=;
	b=dAf7ctixWtQSOtLKL5K67pyCXR2P/aHe3UjUye3+Ov4Sw1t9S6ez9OY0N42uvUjQyI5a
	 RN4u0i6v1trjof7jclfTRaZ1Ji9kT/Gi+Rx9t2hbPQV8ljZhSLSZXukjVM8orQIQG2MrW
	 Y/4Ue6x6Zmlefb7lumBgJ6Sq4soSbP0cOdDdasckQdFpDuB/41ZKtqhNM5MA6kIqhiG3G
	 U9+bdIy+LXlttRCKris3jT2gPtCaZh25Am9UcvMx5Qqbi4q/dO4KI2rMOUSxtipDwnw4K
	 GeFzuYvhQO/i40rdIDmsrHwVzwtDIRjXnZO86AsWpbVhWrhjhvXZaQQSB9N3BqyXPcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjGYpR67;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F329606A323;
	Sun,  8 Nov 2026 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjGYpR67
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794122716;
	b=fOVvPyF/8OLER891/h6c247RMVmQuSfkB6UxvRYYA/qcADkvJCOYlJimXKXpqtLNkIb+
	 0PtH2YHa+JDeKMk8SaE+1NfiQTyvm9kA5Ul54Z9gYfE8v/NkP848vTVs4+he7nzER/T24
	 T8ed4vpMm7GWECUucMBfFBjrntJezXOlT+tsB7aSCSjCnDWLnxu9IgWfQxWg0O6Kb0dMn
	 DyNp96RzIWCxccaonjL/Hk9suZCvT/MCngPBAxnbQbEzh6meZhYyOqoBtuxX6ui94cndF
	 /bqjgldjHLevyympe3Xaz5kYtB9Kfcl6ii7WWLJVni8uidYsmggWkiHjdT9CD7hhjRw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794122716;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=h6/tcuwf4M16iHGktdr2wBFCXiF/+PUe+e/SrIDTxac=;
	b=L1RzGst6msCZ2BUNWZ4yTTzste/iQ5U10qIIDHE3D+DrOc8jfHOk7TSrucxbx+rp2+IU
	 c8dEFtpiONpJMtcOdHOJufxhGx+dvYCZUuR/Q0wJClILSm7mOLMs4mTKGLnCHYN4Ftmfj
	 YOQrxjp1PUsEHBRFrAb/BO0kb9P5b0jaelYXtJz9lE/SODm5FxqDCBkuI8uNIMCBGGlCJ
	 tD8HUuFFQCUxQh7eioCec0/9MWys6IOTaaxWSHMnx/4eiCb1vFxTT0qVYPtF4lFpbiEDn
	 51sqNR2WzrJ71F+OUmjHEe1lffRIs5QfTmqC7KsSzkv6azk+mI3nUD/QRld/9OW6NDQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 296041F008BE;
	Sun,  8 Nov 2026 07:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794122716;
	bh=h6/tcuwf4M16iHGktdr2wBFCXiF/+PUe+e/SrIDTxac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KjGYpR670PDpaxORJpkBH9kLu9MNqKbM5KDYboKOssQtGIg/T//vRokZ+fgyYmIhv
	 L8r0iS6QwQViI6IsnSdF8/9OB+HdwUuLyi5jRkKlOHTJvgVJQgylt/bMjZvyEX0cAX
	 DP3/bOR9T743aFrP9Sk9f0SPEsKuR/KGgNFLCFCa7pNZGqJzrHZDv3Vn50gTJIN2IB
	 HqKv9sxU9c7tAGnVTNBaOBLlMM7vEoq+oqatoJjBbtoCzpL+qHbnnAYrdasN+ZRMlD
	 H9A3h9eko83ITJudj/dL7QKd35C0xqB/aDWPcGx2u+3BkwXKm3bRBYHfm+ayyWHSTU
	 ojsOxWKD/JPZQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8158F47E6F;
	Sun,  8 Nov 2026 07:25:12 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Sun, 08 Nov 2026 07:25:12 +0000
Subject: [PATCH v5 7/8] arm64: dts: apple: Add MTP DockChannel HID nodes
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261108-b4-apple-mtp-keyboard-v5-7-e2c97b82669a@gmail.com>
References: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
In-Reply-To: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 Michael Reeves <michael.reeves077@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794122710; l=10915;
 i=michael.reeves077@gmail.com; s=20261107; h=from:subject:message-id;
 bh=WDelLwSDqq2jI3NIoE8Ina9Mo3ruQiPKwQGyBOtG344=;
 b=K+oWNIOGVIXfwgLeTXG6bzIV16P87ldrPeKxm2NOdP5lU/3AqwQ/ayivUXM/UPFM34qW1kQKd
 9Q6eicP2VBWBNNwq8AS7p4Xn3n0jDGJp/2wo73ZVpYK4b3iCC94J/Ht
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=ykwkLcuByJYb/cdLc2UuoYP03pIzwrscEZg30+4tJL8=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20261107
 with auth_id=1442
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com
Content-Transfer-Encoding: 7bit

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
index 05819755a18f..3ae7f59c91f9 100644
--- a/arch/arm64/boot/dts/apple/t602x-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t602x-die0.dtsi
@@ -162,6 +162,53 @@ pinctrl_smc: pinctrl@2a2820000 {
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
+		reg-names = "asc", "sram";
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
index 524e532830e2..15c102758097 100644
--- a/arch/arm64/boot/dts/apple/t6030.dtsi
+++ b/arch/arm64/boot/dts/apple/t6030.dtsi
@@ -492,6 +492,53 @@ wdt: watchdog@3642b0000 {
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
+			reg-names = "asc", "sram";
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
index b14443436e26..e2ad05598a46 100644
--- a/arch/arm64/boot/dts/apple/t6031-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t6031-die0.dtsi
@@ -207,4 +207,51 @@ serial0: serial@391200000 {
 
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
+		reg-names = "asc", "sram";
+		mboxes = <&mtp_mbox>, <&mtp_dockchannel>;
+		mbox-names = "asc", "dockchannel";
+		iommus = <&mtp_dart 1>;
+		status = "disabled";
+	};
 };
diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
index ec248ca052cb..06b3a836ae9b 100644
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
+			reg-names = "asc", "sram";
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
index 52257fa22631..64abef536f24 100644
--- a/arch/arm64/boot/dts/apple/t8122.dtsi
+++ b/arch/arm64/boot/dts/apple/t8122.dtsi
@@ -454,6 +454,54 @@ pinctrl_aop: pinctrl@2f4824000 {
 
 			apple,npins = <54>;
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
+			reg-names = "asc", "sram";
+			mboxes = <&mtp_mbox>, <&mtp_dockchannel>;
+			mbox-names = "asc", "dockchannel";
+			iommus = <&mtp_dart 1>;
+			status = "disabled";
+		};
 	};
 
 	timer {

-- 
2.56.0


