Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919203;
	b=wMHciKtoUUU20VktZLXYvRAEBavwp51GCCWHdtwxm1M+oDhO+kq84OKOqOO3LMybKYoC
	 UaaoQs9gbHlob+ISsDbvnFL+ayNt3yIN+K7V+G+H5DE+z9+wjO6TiokxXTjaDBeIECIs7
	 Khdam3TuUmPNAjYM/sSURhe9afwYp35kUNzavHH2OiOQrKaqXWSiUO/Pw/5AiAsaTNR91
	 lVA6FbikZ/OnKcqgIij7UgAVV2zUKqnKv2H+xSFHbhcgCGSEr4gRb1c8IqU/WiUHGYD7w
	 O+2YWsE4z48o0HgXyT5yxBn0i7HIhFjn6Wur4u8lKyTyvrsKWm8VkmZRnd8U3Ag72Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eH7GNmtkSKP2fzAXhmpuBWSGX/FXkIALtIPPfHtDiis=;
	b=PGrq8811m2mXMsI1zQHCaj/HjQqiPZJ22cXeZ/VcKz1BDsxX8pnMaRuVHPfIf6OArPWs
	 8vycASwSwB557Hjwig6e73pi86dExQdK8dqF7XYcjPll61/Un46HKc+en4MtLBQbDzGDu
	 J3dFh9kQa5kx7ymPRns3Jc62mDXMkKTWygumxNvz1OLzcyVxuW4/M1urxpyOw0f6Hk1DG
	 U4KXd67s+otmrvUeQUi9ztjuDcjyjNs4unUzxrlcWvmXXyFqx/Lez5pKHu0YD6Ys9COeh
	 6Bs03CD1dKQZVYukY9j802JG2noCMmNieIJPyn8Guj5riQQ5XaD4DrA53NYgNM+6yOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ce62sMFo;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F29606A8B5
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 12:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29F29606A8B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ce62sMFo
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so54761215e9.2
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 04:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794919201; x=1795524001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eH7GNmtkSKP2fzAXhmpuBWSGX/FXkIALtIPPfHtDiis=;
        b=Ce62sMFolZ8wDThxrrbo+CnTzEs6w7mi342mwpd9ugs27RJgJ5cnId07PBaxEu1f2t
         8GevcTB5H8HH0tU7USgs/C7oMgv9C0E/2ENimKZuqJYO6fUEJsnb+FA/18VNYiFDdJOV
         5Pob9+GtoRAtyzzeYV842RMcHt1a5qQwiptHgRxHqkDQEYD24TcKNisrkw9Umr0kQC2s
         b+gU0YRgX+3RcsiL5lLTQVNbAqgu6Lz1m9w9D0860q9fHHpe8W4Fb/a+9PLqJC1UR4Ao
         f5P9EdlzBCylkrLMsuxiJLc0SwS+WTSiku/JffJ/yUhwQwnzrhcmbogzStGBZmR0Uf3K
         75Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794919201; x=1795524001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eH7GNmtkSKP2fzAXhmpuBWSGX/FXkIALtIPPfHtDiis=;
        b=G0zLfSWYYLhg0uGjjaH1Jmp4DgiUYdKr6t5eJQV8ufxb/qZoSx3VpGuq5++zMX6OJP
         j2VmFS1RxEAfhplqALkCAXmyeuidKpIC1QleBG64GCEUxLgdf9LiPmTBFunY2SqicJAS
         qwVOt2QSG1cJkHiqtI8pTo4l1MuoxR+C/+Du7uB0lMRUciGkB9liRnk9xD+/7PdP8xQL
         WCLTEaDydExrcfE1Qw+mb9cmRehdpFnfgV3jUSeir1koWK/alsDxMYwJwbi1q+czuDBf
         3Kl2npuBflKlFxqPP67ZS6bsUmLprmM2jnPjIIGT2D5ZSh962xZj/yOBQQMRGuUpMi7j
         G4ew==
X-Forwarded-Encrypted: i=1; AL+hErHujH797OPnBVp9tQlxZmG70ImOxKzX50pFDIkJd2LhEsoJHd6OH/5ZhpLqTbcJ1BW4Leo+CC0AL5WoqQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+W9fYx+ywQ2tXsATc2Z3ChQYDfB/qPsq+NI/aVeYwAlSKH0t7G
	eW9psygNQfxW7E3vbEGYnZFYypNV77MW/gJ+Z9rKLMTLK7KRfMA5Zblu
X-Gm-Gg: AYBFou3t753JFQEICc/wszgX6fJD48DhSWV3tlAU7XJev1Ww1wRmntxL4xtcH6IrlfX
	ZzhJXrH/QfSgbRSArZgD3+Y3c7T5jUedzK0U+RuS9qcjSL1dey8zQn9QW+JyG3Giv1qX0CmXAw0
	Dn5kvqDFphgUVo6HSEITNbapCaEBvSFQQBae3GDClJustEthNLe8aBQjCABHTrlw/LDCIigeVd0
	MBOJYSxHw674ypmmeuMH08WJ9KGEAMPQAcYdU+zbii+xAYWZHZKyUn8R1r+F/vFzTRiu4isB+KC
	+y4gjPkKS9TjpzL3p7TUS0TK6KFh9dk6GhxDxUkxSSNfZmkHq9LSGQ9vHbz5/Z9bMGvLxwVN6G0
	OGK6rHoAfwI1Ur12NsVm/wsADlyywYKuR+NY4a2O95qnd9TliwBOXeSzm1ORAK70IoHfh/dLEC4
	UaIVtuANDM/d2E9eew9+Z5Wu82DWSD8EjzNlBrMo4kLSzUxda0iRuZSoQsXRa9MmpFZr54crV4E
	cbwynP/dxFdKKn2ND1n61UeoiU5QNXCyRmyGWZolQaRsZ7qeH0ScIzZizYIIvkRyPDfxpnkt2Bk
	XU7HC8Mm2I+2hSBBIV2iC/MzsvhfF2M1nr6Tk63iL7ynYzsvepefHEY0lzE/vrazkT4MSA==
X-Received: by 2002:a05:600c:8189:b0:4a3:598e:e7a8 with SMTP id 5b1f17b1804b1-4bb559f72b1mr298144455e9.4.1794919200559;
        Tue, 17 Nov 2026 04:40:00 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu. [94.21.223.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:40:00 -0800 (PST)
From: rofikkerneldev <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org,
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
	rofikkerneldev <rofikcoga@gmail.com>
Subject: [PATCH v1 11/11] arm64: dts: qcom: sm8250-lge-timelm: add QCA6390 Bluetooth
Date: Tue, 17 Nov 2026 13:39:46 +0100
Message-Id: <20261117123946.668557-12-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117123946.668557-1-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
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

Describe the QCA6390 power sequencer and its PMU regulators. Enable the
Bluetooth HCI controller on GENI UART6 with the supplies provided by the
PMU.

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
---
 .../arm64/boot/dts/qcom/sm8250-lge-timelm.dts | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
index 6b57c658cf918..38816268fcf53 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
@@ -95,6 +95,67 @@ key-assistant {
 		};
 	};
 
+	qca6390-pmu {
+		compatible = "qcom,qca6390-pmu";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_en_state>, <&wlan_en_state>;
+
+		vddaon-supply = <&vreg_s6a_0p6>;
+		vddpmu-supply = <&vreg_s6a_0p6>;
+		vddrfa0p95-supply = <&vreg_s6a_0p6>;
+		vddrfa1p3-supply = <&vreg_s8c_1p2>;
+		vddrfa1p9-supply = <&vreg_s5a_1p9>;
+		vddpcie1p3-supply = <&vreg_s8c_1p2>;
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
 		ramoops: ramoops@b0000000 {
 			compatible = "ramoops";
@@ -506,6 +567,21 @@ &uart12 {
 	status = "okay";
 };
 
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
+};
+
 &ufs_mem_hc {
 	status = "okay";
 
@@ -636,6 +712,22 @@ touchscreen@28 {
 };
 
 &tlmm {
+	bt_en_state: bt-enable-state {
+		pins = "gpio21";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
+	wlan_en_state: wlan-enable-state {
+		pins = "gpio20";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-pull-up;
+		output-low;
+	};
+
 	touch_reset_default: touch-reset-default-state {
 		pins = "gpio38";
 		function = "gpio";
-- 
2.39.5

