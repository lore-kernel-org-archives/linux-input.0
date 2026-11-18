Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003648;
	b=U7fGUyrPk9FhsdBv0PfRNMaHw2Si4dsD0iqTVWJmVXQZGLFhPg5lKZEjWCkyoSrRfDZE
	 XPRrRPho49dU2yw0SLvSn8LguFnteOBuXW/oWRw4L0M45Sws+zuhajgf2lakmPSqRcmzC
	 x4Ky3AoeLFgL1+1TTNJ+K84uWFAWp7i5hBmBqDDdUJ3xc+UzHIfAg+uj/8pzICDuJTwkE
	 BA9951Y8sVeldA17rkHrCvk45NqCpbs7C4vv4zcVpltjxG9dQr0spFs2OxYE74EsWM+Wl
	 Ud9JptO7ehz/8uM9HTzhiTc1vo7gRuFV0Fi3Bv6qolPQUTYXTbxWY8Yz54vOwLAYVJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=167OHAGXM6J7PJAqZ3MLk9kxvb+fEinCgbUkehm0fFo=;
	b=zszHCDt0Hjw4R7wyEc3XMHIDhMV2F2fFXUKxxlO9cQ4MjYglgTLhzKLU6PGhktWTEN0l
	 6ufc7vQQYydPsWRjMmFO4Pv1DZ1Tn2ZBIvRPoAMHXq8BK0mjJvNCAmsLnx2MnQOdu3rt4
	 PO1Uk9dJT2CvYc8RCjtOf383ld1HS6ifZcCq6R4RMcVynj/4ZLV+00B9vyrwVxj2rCR4/
	 LUy1xWnVABfVFM9plaiBF9pYv7pptRUEQeWByclaVvVDYp57ZG8TU+DlFwDpT7+c7TM4K
	 zvQgE8WujRd8pRijuLZOPP1y4gvRlFmoubjC/a1Av9/rdkrm+5M7sPoV6Shj1Mq5MDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UpCybyBE;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A560A2613
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 12:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F19A560A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UpCybyBE
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so557295f8f.2
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 04:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795003646; x=1795608446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=167OHAGXM6J7PJAqZ3MLk9kxvb+fEinCgbUkehm0fFo=;
        b=UpCybyBEXExg7fNyUzYHBW3rjcRsRXehyFFmfjaYvHLSQ90D5OFnveZgTMARiksJNJ
         uEo1gYGyFBz5M/L1biwqZDQpqSuBmv3z9cXIRbLCZCWB2YGoBTB5aNbXgwYOJxRmwMQy
         L5sJ5TsbCibNGc4ossOWkSSNPuTaSHaHEdNCf7qpeEonP8siaY2D3g6Nfvhwl8uvq7MK
         VQuZEzjtfY2J+R265c6K2fB5CRwrOFUpXNvB2V8Cj45FFnLMsxqOYMqoVfrw9Bt0UQDT
         DY5/T/+uKCoxo3cf2CGgoKDFlnirJjwoffAbXmcXRBC6bwGN9V/b7E0jYizr9J/2YsJs
         WGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795003646; x=1795608446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=167OHAGXM6J7PJAqZ3MLk9kxvb+fEinCgbUkehm0fFo=;
        b=XRXWZsqpEuAWb/L2logKIUv5/rki/CXgVYhLNAcUyLa0stIHzf2lln08mNYcyActfu
         3IMPHHMl6TCdKIi4gao3pkevm3TSI15B+F/K4Qtt2f1HJeN/JMmkYsuvFUmAm2xhec9z
         jnprZuHcISagSSKeT5nTCOS+LofPhc+w7OxGDB8IKUdRGy7iv6QTxoRq0PrJnt9oatPa
         apwv8TaZp0NE0Ybcls5bc1FAlgFHNxML1V3Ej5EMTp9bN7fCOFu8ZudHiRqtsGmauNYa
         vMvx2GQ25l7c2jQOdZwluTeYoj84cOg3PWlySTuII7xkWkgkwY9tQCQggcV75Mox581L
         jZkg==
X-Forwarded-Encrypted: i=1; AL+hErHexYb0CZiTRclqSC1Ja79ydCd3tIZVrkSnpenUZXQIgj+Ud3q8/Mel5rPPJPmRH47NBXambv2/+McVZg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9t3CP3AtYn7vWgAq4HdQOcWdzFB3+/HwlX+agQBc8D1Mutxo+X
	NAGp4qEJeEuwJ3aKTIuw/6c1zuLy7TdzRgUFfD0g15JnIjqZn2VhDiBM
X-Gm-Gg: AZFdTZdowdp/+lQKSWgBRSdQhBFIdNJgdyHTtcfwYJ9kAX8N3ZHgtQpGdbcMVam99s4
	GFPf2RtHY82ZtpLBrO88SNJmI/NrTVDUqIcafeDEWQOy6qGN5bmt0psJPOXJgy7TYDbUE0B+OKb
	5w6OVJKZ/5Gx53e4sl1c2r3YSLYBkHPBOEa5h+zxvQGBIRsfeGURat3yu7lNU5GKg2ZfIUE1XUc
	0yNHzJBpWwmvSvH0WCYsNitJhexSpeQH1IELrTfI9FpmV240R/3eyWdOhp3Kt5QuVZz//0ZRBHv
	hxQcyDETAUr2eH2KwwruOqKrkbU5acTxOUx0ZI/vrANIl8Tdad4iUjYFHZv+VtH61otQ2Se0iI5
	icw5r6Wwq1uxZkBqR6YzYPnHajxa92JlOxzdsICLu1MkddGidJIhmhXD0eT6xFrwlP5v0tXS4lT
	QvePeTzASxQXkubdVlhtekql16jfLTKd5CIuRsKmxAofcipYrHuoL9F2AdB++ASr4LJiAaklz1H
	jqlFj0d1fjblkOZ3ZJK+sNPubZtZUmL5RpWHFPuX4W9tCfj6s2x16AHyRIpxSh1hoFySGpPtgWa
	92jzmtrcSjRgWi1ep7Ut4i8H5kDka28b7yUd4hWeXjDpYB6xcCQfOO4+O9jE+675o2sAPSEM2fC
	fx7FWjfaPAXZHqGyetGv8
X-Received: by 2002:a05:6000:1606:b0:48e:6f84:2e8e with SMTP id ffacd0b85a97d-4a63e6f1a49mr3049066f8f.39.1795003646222;
        Wed, 18 Nov 2026 04:07:26 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c37fsm4382583f8f.18.2026.11.18.04.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:07:25 -0800 (PST)
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
Subject: [PATCH v2 09/10] arm64: dts: qcom: sm8250-lg-timelm: enable USB Type-C
Date: Wed, 18 Nov 2026 13:07:13 +0100
Message-Id: <20261118120714.31505-10-rofikcoga@gmail.com>
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

Enable the PM8150B Type-C controller in sink mode with PDO_VAR up to
9V/3A, and connect the OF graph endpoints for USB DWC3 and SuperSpeed
QMP PHY orientation switching.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index be5b894b677bb..12ca5ea921fff 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
@@ -10,6 +10,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/usb/pd.h>
 #include "sm8250.dtsi"
 #include "pm8150.dtsi"
 #include "pm8150b.dtsi"
@@ -556,6 +557,45 @@ volume_down_state: volume-down-state {
 	};
 };
 
+&pm8150b_typec {
+	status = "okay";
+
+	vdd-pdphy-supply = <&vreg_l2a_3p1>;
+
+	connector {
+		compatible = "usb-c-connector";
+
+		power-role = "sink";
+		data-role = "device";
+		self-powered;
+
+		op-sink-microwatt = <15000000>;
+		sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+			     PDO_VAR(5000, 9000, 3000)>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				pm8150b_hs_in: endpoint {
+					remote-endpoint = <&usb_1_dwc3_hs_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				pm8150b_typec_mux: endpoint {
+					remote-endpoint = <&usb_1_qmpphy_out>;
+				};
+			};
+		};
+	};
+};
+
 &pon {
 	status = "okay";
 };
@@ -684,6 +724,10 @@ &usb_1_dwc3 {
 	dr_mode = "peripheral";
 };
 
+&usb_1_dwc3_hs_out {
+	remote-endpoint = <&pm8150b_hs_in>;
+};
+
 &usb_1_hsphy {
 	status = "okay";
 
@@ -698,3 +742,7 @@ &usb_1_qmpphy {
 	vdda-phy-supply = <&vreg_l18a_0p9>;
 	vdda-pll-supply = <&vreg_l9a_1p2>;
 };
+
+&usb_1_qmpphy_out {
+	remote-endpoint = <&pm8150b_typec_mux>;
+};
-- 
2.39.5

