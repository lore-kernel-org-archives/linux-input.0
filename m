Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003649;
	b=cXF6CUSVy/EX4pxZKA4Tc9lo8x3RLhthBpyOY2QUze38peMMH1Rph/slS9OrsC5CzQjE
	 QgPA0U4v1c05scnNLSGy7gVBR0dkb0zANHN1UdUcAj+HRH+SE8QV6DDfXQbUrFXlbmeBr
	 yPnsR7Qlj83AKDIoE+pGMKaA6QXrkeSLz1h9iZZeG5ef/IWzF367cfBMsc+s3W7UWrp7f
	 fmNoXn0FvG9gQqkGVmZti5nMETDK/iZci/bYucDcKpDhqvvsAwsBgXg84M57De4eEFhxE
	 BgLbEYtNz5nOfyNvbP9YUt18mIZf93cWaKrc+9dGwUlJWYumZs2ps6BMqfNKH/KeXXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3RiYetiebufQr59c1XKeWhbsUwEqVSkodNc50lBB/z4=;
	b=pozqitJUDO2GA+FTByAi83uLm4rIBJnKVpzS797kUGaJpnhfJA8X7XG6ezTHNfFtgQDX
	 olpiMXCS1x6xBM1tUhY2eHwWkG+Nn23XLfnIHP61tm58D91MF2Tjpz5NbdJxmv3RI9nTF
	 yN++RLdVHyiBBRkVetZZxl+V8ribddkKqjqon3Pdjshgv8oZXduFNqNz4Ci9+DvsIZoL/
	 64Vk7kg6favK07MFT20f81g6De1bkE+DUUiIF3vRbuf7Lpnu3orzWUa4MqJE3cI+5R5ON
	 3duAZ6quPD/I39Vpu5bkAc1VkSyvRIfRIwKiFAMaP+5n6itK9rocvYj0flCkJc/7OAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jbz4eToF;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2092960A6F79
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 12:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2092960A6F79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jbz4eToF
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so7147535e9.1
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 04:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795003647; x=1795608447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3RiYetiebufQr59c1XKeWhbsUwEqVSkodNc50lBB/z4=;
        b=jbz4eToFtbkmkcUjSm2s0E3wVNeRhz0CDifw3wn4or6WdNIk08jOTUaxblKrLn5VcD
         FTwP1k7GqdSPFnP2nBhEiXUYVJqQ3y/mY4HFGaCVJ19HlDsTxyLs0UOpxniALFEeWijq
         fca5783vNEPVW8FKdqsyhQN1dM06fA/akUSpV4tB4fiiuk1NESrIqIzeRNSLLBQxWrY9
         u9XYdjmlwfTmTu9YxuJ79GthES2zNxaqhBe2dCwqdcKR0I5hrSEBxc1gALwjtMQ3ML1/
         D7pcf+ff/bna9PSW4oTXdTP6gMJJtvF3RW33CvpXyroktqwL2wYzCUQlUPN+EQSrqj43
         WxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795003647; x=1795608447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3RiYetiebufQr59c1XKeWhbsUwEqVSkodNc50lBB/z4=;
        b=qH8UFsW/f+2mn5QmE9v5u9tXdV4GLr+aEk7vjcbnW6xxc0ibJFZ1Kr7CzQT7tUb4lQ
         nXdo3g3kZZ+GopznsPR/y9WS4yJ+H6FjoKKRoSigD71eL9ypQdVPR7tTKMiMpSkdiIhx
         4+j8rjD47J3AY+YUY//F5BPGoOa0AeEBgQBqqSuDir5624Ww2x0eWvDaAHUlN4GughzS
         KM0QDR8bHPmpOWU42mB5gXdNsRjQ9NXXJq7esziE8U59g1NmbxQL7GuER64bRH6tvYtb
         WqBdYkAcRTGBBRJWIr8b7xIevISCNvKGz0zLoQkfw6QplVdeWGPvkyC7JIhi2NyBAnd4
         M5bw==
X-Forwarded-Encrypted: i=1; AL+hErGPjGkk5q0lqWbuX3SX4b0VAf7j9ss5kwuEYgN9+HeZ0HjpRbpSpy2sD3Tllwzd94Q/Wj3iFKJ72OgJ8Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8NlWl1N0KcqCQK4n+djlBafLFhrK4FV0GhDY6r1v+3184oFqZX
	q9ePZXeNIryl8S3KNxmq0fAFy9yWzR48PAOb4cRY+4KJeTmM+z0WqIlj
X-Gm-Gg: AYBFou3kUob9lFFTO0Etek/wSvWOtcmY36yncvfzBkd231pcwINp79n0NRaexlrNxQ7
	s7tXiszBTEcC+9i056RB/DxvC/sR9m6SS4KwxEroqpu26yR6bur6jMzA7Gkk4dCp9JmZMhZO+Ll
	OPuQOlv09yKxSF8YVpyBzQDMul0dLwCjWoDy+kdwlDmKpA6njdJLik2mNLL8g5xCw0lV6KTr9rr
	vvG3U5WEnJykULuELjnxH+kc3Ky1R8GgRwHueZh4QMAoHuGAcyEEa3m+F9+RqrQ8moP3ODA+rfV
	MPx3BHQ2vTVfOuToMHFV2fHklWnWxm3iT/+sA9IXIlZVv2fRKEqfH4cQcisu6uXJlBL7sSLroiY
	Eq7tUXegc+Pig/jlShlfUEuNN3NHUzNk/rIWbkx7E+lrqOI7Jmm8rVhUNrWNP38BxCbQUAC64CS
	HlEik5OjE1iDCgLArdbWgQyH6g6h+aOqcLHsktATxCm3pbUQ+JLE0fMGTU4F708n3oJnm+/fQdK
	X8TQwgyZDRgtVZJlXvPeViV9cnZgqmZnj2+55HOQAEEWjvFv4GJDHVRzAAinQtZ5fCJkNji7sl9
	zgb6uOIGI3rN4igk/NILRPIlWAfHExa7R4Lvjkgv4O/z1sqltVXmCQrS/w9Jr68a+YIfMlhrEIE
	=
X-Received: by 2002:a05:600c:474c:b0:4bb:6a2d:b426 with SMTP id 5b1f17b1804b1-4bb7d5d40fdmr43108495e9.1.1795003647402;
        Wed, 18 Nov 2026 04:07:27 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c37fsm4382583f8f.18.2026.11.18.04.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:07:27 -0800 (PST)
From: Abdur Rofik <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ivon Argel <ivonargel13@gmail.com>,
	Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v2 10/10] arm64: dts: qcom: sm8250-lg-timelm: add QCA6390 Bluetooth
Date: Wed, 18 Nov 2026 13:07:14 +0100
Message-Id: <20261118120714.31505-11-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261118120714.31505-1-rofikcoga@gmail.com>
References: <20261118120714.31505-1-rofikcoga@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the QCA6390 power sequencer with properly voltaged supplies
and enable Bluetooth HCI on GENI UART6.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index 12ca5ea921fff..3356099696a5e 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
@@ -67,6 +67,67 @@ key-assistant {
 		};
 	};
 
+	qca6390-pmu {
+		compatible = "qcom,qca6390-pmu";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_en_state>, <&wlan_en_state>;
+
+		vddaon-supply = <&vreg_s6a_0p95>;
+		vddpmu-supply = <&vreg_s6a_0p95>;
+		vddrfa0p95-supply = <&vreg_s6a_0p95>;
+		vddrfa1p3-supply = <&vreg_s8c_1p35>;
+		vddrfa1p9-supply = <&vreg_s5a_1p9>;
+		vddpcie1p3-supply = <&vreg_s8c_1p35>;
+		vddpcie1p9-supply = <&vreg_s5a_1p9>;
+		vddio-supply = <&vreg_s4a_1p8>;
+
+		wlan-enable-gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
+		bt-enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
+
+		regulators {
+			vreg_pmu_rfa_cmn: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn";
+			};
+
+			vreg_pmu_aon_0p59: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p59";
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator-name = "vreg_pmu_wlcx_0p8";
+			};
+
+			vreg_pmu_wlmx_0p85: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p85";
+			};
+
+			vreg_pmu_btcmx_0p85: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p85";
+			};
+
+			vreg_pmu_rfa_0p8: ldo5 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+			};
+
+			vreg_pmu_rfa_1p2: ldo6 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+			};
+
+			vreg_pmu_rfa_1p7: ldo7 {
+				regulator-name = "vreg_pmu_rfa_1p7";
+			};
+
+			vreg_pmu_pcie_0p9: ldo8 {
+				regulator-name = "vreg_pmu_pcie_0p9";
+			};
+
+			vreg_pmu_pcie_1p8: ldo9 {
+				regulator-name = "vreg_pmu_pcie_1p8";
+			};
+		};
+	};
+
 	reserved-memory {
 		res_xbl_uefi_log_region: memory@80880000 {
 			reg = <0x0 0x80880000 0x0 0x14000>;
@@ -639,6 +700,14 @@ &sdhc_2 {
 &tlmm {
 	gpio-reserved-ranges = <40 4>, <52 4>;
 
+	bt_en_state: bt-enable-state {
+		pins = "gpio21";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
 	sdc2_default_state: sdc2-default-state {
 		clk-pins {
 			pins = "sdc2_clk";
@@ -692,6 +761,29 @@ ts_int_default: ts-int-default-state {
 		drive-strength = <8>;
 		bias-pull-up;
 	};
+
+	wlan_en_state: wlan-enable-state {
+		pins = "gpio20";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-pull-up;
+		output-low;
+	};
+};
+
+&uart6 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,qca6390-bt";
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
+	};
 };
 
 &uart12 {
-- 
2.39.5

