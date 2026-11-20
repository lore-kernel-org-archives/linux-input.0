Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160052;
	b=JvpDSHsWxNF8wPPMNWrkb2mDCA8viDNnJm6f1CtaIh6dzCJE/jyUOyuxZGRIJSBXWNDh
	 6Dtue7lIhqU7pXPJHdK5JJ4FWy7OoOLA3kGzLYxlvGRMkfz7HkHaar2Z0+zvY24kX2AqU
	 F0fNXOVYtyUSOYQUrwa2kjk6HBRx9iNBucKmrp5X7W4HQ6Ku2VzGdc5z/ecnuo9a3UKbR
	 RA+QNvrCAdz3CVfNm/KQo7UsHMYQcD5P8U3a3r7O4sbQ7MXWgzL1Fi5DVUMceUKz+owpy
	 T+ZMCkeyOlgLxF+3L8A/efK+b2BnTafaQvAGCvzluM7DDgI4FIrmCqR79/k3kJkrlIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kRnaLXMIjjDmMSY6mFAZa1ZXluewGJuLAGDDGmmf4rQ=;
	b=cc5mV1JqCzB1NrI0qSe2fOz3HMKE7PWAo6z7t/V7aTtE5fuvxNUPuDfEooTpJfDfaHEO
	 NhbY5a/fOsnK8OiHDRy6w1mYcF5QZvsGQOtkNgmwG+hJtOSdUd3uH+NHuufuQhLzijPYe
	 i/BAe4SeVIGH8VWPxo0sNtemxIvIa8rfc7LcIYbZfnST3MUxJTCvB5zfOjlAEE/RW+KmW
	 bLCg8mwwKK6IlJZLcs1CkszuppZ/i+DUj+YWasSXtAaaJ08OMb3LqsrtZIu9OvVDvEcsl
	 LYcZtOp2XVUk2b4z5M9rwR1XGQfTHYvxggDn864ZtlFgMyQj9hzdA4F9vi02HblLJKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HKPNdU8p;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E42160A3806
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 07:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E42160A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HKPNdU8p
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so5014575e9.0
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 23:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160050; x=1795764850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kRnaLXMIjjDmMSY6mFAZa1ZXluewGJuLAGDDGmmf4rQ=;
        b=HKPNdU8p6BYIA0PhbhaC1eJory9J9d32I7tNCfsWv3fuI/ikf80iOswt2MD/UneDAR
         pZfsOIkqqGcjGwnK+QtkPXz76nrHkKEKIwP45S6dvMaiaSmTWRYOYMj9bs8Kvr9CqIhy
         UlpiewL52fQp4co1XHQk4F373mEW+dWSbBgzggPwt42FJHWZ7PAAtv//hGT/1c5aa2xJ
         /zbRclE/JIs2XkUT1vW3xRAdh6aefo8FO+wSmudGTq3AiCh0FSnZyAGRaqLKNoh5deiz
         cM5lGO7zQLxFPFWg9KsIf1xmHAtyWTRD7J4o+skfJ5KIHrZLemE6Y9/SB3dgKLtZsULk
         xLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160050; x=1795764850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kRnaLXMIjjDmMSY6mFAZa1ZXluewGJuLAGDDGmmf4rQ=;
        b=W3IaRmGsT/uzGHIfw88K2FPGnpa+DGTvLInlaKc4lXcVRa+tCJYKTMrN3zni3hrS8f
         TEQ4LWYk3xPYGejHW6vEoBd0AbdNKEQ013TqhjFtxD6uMu6cUny0igPPeJYLMQ6L7dn9
         sYgKBhLalIRervDJ90sRtCXrLyQB272SawkLufkuo8sBGzWrcs0zzQ1B3Tift2dxu7qe
         1cVv0GEIcs/s/EU2yCMJHVkTG0zYXcn2SAggNkch1YJpfc3Y5Ydm0HJchDCkgPJeJPAb
         BfAMgDLK7wqJREP5csn3dZqZzpYzzLSv817v2aSKsQ+dg65LQMPcu8Q1e/kd8kT/+9xY
         Zs2Q==
X-Forwarded-Encrypted: i=1; AL+hErEiOp/OeYoeg4TXSn57KkcjOglEINLk7rVv3MqAjaNC1MfZACHrY39FhbZYkm7GlRwsu6PwPXrVxBJ2Kw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Xv5IMYr7sHaeCarKf1eA9YLZUc9TuKnCU/C8YRDGOHgAEd3DX
	VXnfJ6pzfIddrPv+VcoJ9Yp/NAMIr5/S3CwSpUHWdG5tqJvwVyVPB8ad
X-Gm-Gg: AYBFou0CDTBzUlVeORFfHGLvVbPYEUDq/iZ5l29LqY2ha0mvYVhRwXqn47CAkvu5J3Y
	c3i43bc6WlckWnnaV0cqSSAutIaNCfvA0gUfwmHAOUYyHG6PUutVD4c77nnLAAK1irYMCd3B5n9
	fogOxSm0++vvgIzPa1FeggQS5ZH8ccE7so+d75qyinVfxlHFc28IjRxPDnU1H5ypD4JHx9MCCDe
	b5V364nMN1iwmitWmG4MKneflmODs1uYLM2od8k4fgtknI4aO/8ejqCGJncR8miv2wWA4uVjKf5
	f5gPN+sR3t32LAAfWxlHuMomChwd4iC5MvCCPOHjeBfJtdELK8O7fbQxRn5ixUa67wYihB4in5m
	IWfzVeA0KuGuy8bNCbKj4OrZbIe8u/w7xWSRsCrlzmrLBrRUTD9da7xlTyrb1oeHcbrmd803xVJ
	aLL/qyb6u4Lc+Kui3QxuRFxThBk6gTj3wxWFyIO2p9+PwBAJ+6IkoeRdLuohzIxzj3HGdU9kcZa
	Yi+9dBKSml4VeUMMGjiMGWcC2X/OKTdWdXLegiJAMrY+JF0WjN5gt7EvsP4CHBB6uwRxX1IID0o
	xJVX9+2VvPhqaRFn6t0aJ8UqWEazD5XOHww/7+0ZXOD2or9dLdV6r3vzlKX4QV63qgYwhR7VUcQ
	=
X-Received: by 2002:a05:600c:5246:b0:4bb:6de4:2f7c with SMTP id 5b1f17b1804b1-4bb8881c5bdmr46585025e9.20.1795160050056;
        Thu, 19 Nov 2026 23:34:10 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm54154045e9.10.2026.11.19.23.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:34:09 -0800 (PST)
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
	Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v4 09/10] arm64: dts: qcom: sm8250-lg-timelm: enable USB Type-C
Date: Fri, 20 Nov 2026 08:33:57 +0100
Message-Id: <20261120073358.10267-10-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261120073358.10267-1-rofikcoga@gmail.com>
References: <20261120073358.10267-1-rofikcoga@gmail.com>
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
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index 16014df9c087a..2d8b06c05ecc3 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
@@ -9,6 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/usb/pd.h>
 #include "sm8250.dtsi"
 #include "pm8150.dtsi"
 #include "pm8150b.dtsi"
@@ -556,6 +557,44 @@ volume_down_state: volume-down-state {
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
 &pon_pwrkey {
 	status = "okay";
 };
@@ -660,6 +699,10 @@ &usb_1_dwc3 {
 	dr_mode = "peripheral";
 };
 
+&usb_1_dwc3_hs_out {
+	remote-endpoint = <&pm8150b_hs_in>;
+};
+
 &usb_1_hsphy {
 	status = "okay";
 
@@ -674,3 +717,7 @@ &usb_1_qmpphy {
 	vdda-phy-supply = <&vreg_l18a_0p9>;
 	vdda-pll-supply = <&vreg_l9a_1p2>;
 };
+
+&usb_1_qmpphy_out {
+	remote-endpoint = <&pm8150b_typec_mux>;
+};
-- 
2.39.5

