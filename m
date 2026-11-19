Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107275;
	b=aNUM4kCngNbYbTjNXTalMiwd6dFj37S4ciXg3nqLEFuQvVy8cAvEIoPSf/iIoIFtKZVS
	 vPgGT8Xj6m8HL6IG/mH3Owh1A7USEcKXXMCdgZvD9jIy0Smq98wUQGtQYkoocxp/YsuRW
	 GtLIGNVLoIORc8wMT5FS0GVy/KMLbHja9X5HDRtyiLx+FCxVVGIX4T8NpnMbDxuu3q1Xl
	 E8UE7WCKz7zg59Zt0QNOLopsQ9DY3pP2adZ7mAMDbjzaHKz8VbhKlbCj0ZwgiT8rlPaap
	 c+n22WmD82WQogHbLhXRmVLapSvA4TiI6zLRaP+QRsBEA7ZkWGQxxUo0is+MUYBNPMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8HAdjmJFS/vSTReOhqoIJm4R7O9SEUoXAZM3wxNxKGg=;
	b=1wNj4Jf5nYD4014VJwylvwcEIt3qHPej0TcdYb4No3SAzyZgNiQAEcCM9jRxVWuQdWrB
	 jTQk/Iux47xmNpS2NOSYbTVPnCmmuq8d+A0VFpiiBoeLWkI7StM5msUF1IFXzmDkCBm7N
	 zP3n3T+dIFEBmuMMNo3BEgdHEvazgU+fJ6s82QgdZdzR3izyMdw9KLVRqF4o9fP57sWlk
	 tO6XXWRDWjN0UeM+E/3s5bxcTcHGFJ4li3IeuFShQzHRWKSxCgC6nLG9NMTKMDhZjbGrG
	 yNEwvn54HiEsbzx9iGDyCJ7tORXn8jYPL8LyALL2zCCPJE61POMRRw0x1fejQ+3C5Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tWxDVM+f;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7065A60A6F5E
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 16:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7065A60A6F5E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tWxDVM+f
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so23650035e9.1
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 08:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795107273; x=1795712073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8HAdjmJFS/vSTReOhqoIJm4R7O9SEUoXAZM3wxNxKGg=;
        b=tWxDVM+fAapdNLO5oAWMSWtAihRfVvePxg2vTZOMR1EAAz1T6LOrtjMhCbIyJukujb
         CK8xrym1k13GJeg8eVnp9YpO7I8Dml4JbqzQPDDNTW260lmsIw1Dy+21wMRdeblnV8GR
         rHisEaxrRdyV7+Iatn88T/yvi4WJXXkqtg4Teig9r/bD8OS9HsoYZmSR6+eLHfTP+TaK
         n8Q+MisHDTFGPTSqSsmHX1qPdRCEoAmYQNGhRWvVjUQVo5FFWYJO8fp22aEacncxuyIU
         NufuF4F5ndIjeqeCEhW7rSePkv+nfoUuAC5W8V9Omo7ibEFqK78trnrigzgQ+6gXRKnz
         5NjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795107273; x=1795712073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8HAdjmJFS/vSTReOhqoIJm4R7O9SEUoXAZM3wxNxKGg=;
        b=ZQofzS3rLXtKlrfqCiVTsvQ8kxiUW0/GutkM4Rv0mlH78X7mtk21/8cO9gcNXSZhWK
         kvW9/DbZX6KGIJmsDRmk+TDX0jUbN6JL71LVfW46seWzH3ZY/EzI5m37Hw53BIktsPl2
         nM9r9MbccSXdBKjyixtIzvQubhKxhtdEm6tcGaSNfiqlxN3oN17Iutv909ww0fckLnmS
         6DpruARjvyOhadg30LAUjsAx678xhhiiA799MjbDEXZMyyvYeU8M/APPEmtDkHtq9j/A
         zA4i8p5qyzjlfaMqk/6e1D9/tsBp1/2PbVCG2K/heMYZV3ubCg0gQ1DXzjcjDR4l4jDU
         QSVg==
X-Forwarded-Encrypted: i=1; AL+hErHXVvcIjFTjZ6yc1ZKIzjMaK5+QX9Oe3OYWA4A7me+FqkiE5ej/lz0JofxVmIBStCFP5XDaUTiP5/3TIg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+P6xgXEiho/dp5vHOHzh2PgKwUCr8kEYMtmJ6AJtns6FmJg76j
	adKuA5WLRTjm1axnFwgbxqwu8fUAopegWlstOqO3v/wRW7jdK2BiK9dY
X-Gm-Gg: AYBFou0bipBZy3R7kY2BFsxGnDS2jMdvRAobiNupxSBM2VDA+Hce/jQj5w6z/0rjuWB
	U7wEDRI8BsXZzotAeHrJn1aACkjNhMISZKtcJSJp4nJG4nZ1e9UzCxelCyJTxZpeQnQpVRxyt2P
	hIjovckYtp52l2znOK9UPDZKwKBuNAz/rYQVAmX2kd1C+8hsG1z1HTQhsoEfyAPrc8uiWIHPWSP
	aHbW0WSuSYC8JGtvZrO8F60SNW0iHEjtx/WZaTFHtLH1VfPbgQ3KIoggRakgoAaIaSAY2fDXywh
	hXmn/xVSaXtUpjo7GURuyXTiOYrVV4uiyyOG+3+RSp/lsGLT1dlsyNZkQivqE/mmBTigHg5ze4u
	4Hax2xcXVGOgq4B/uopCCOLpcfY09Ryud26dbzPsXVAsKzZQAlmoUK59vkG0e9vXq7HfKzyIkZK
	QDnbMeGrtHs7auodvoM2HiPKSnbjoQjm20CueGF5K7gje8A2ukt1VxXEI8nAKGXR4pYIH8lPBGD
	/TIUtaWxCB/HE3K9IUx4wxbFcyD8XSo2s088kF4uFfY+0SFdkQRv4Q1fT8lWDViqvB5AuVJulEE
	WA3YwcYcH2jGsoY6/1tH/9Np8PE3T4+REEMdfSSkd303L2SGaheK6LP7PPJ5/Fd2F51C07+cUZj
	v
X-Received: by 2002:a05:600c:8b11:b0:4a1:dda8:eb73 with SMTP id 5b1f17b1804b1-4bb8881c630mr1984605e9.27.1795107272825;
        Thu, 19 Nov 2026 08:54:32 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm9894555e9.0.2026.11.19.08.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:54:32 -0800 (PST)
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
Subject: [PATCH v3 09/10] arm64: dts: qcom: sm8250-lg-timelm: enable USB Type-C
Date: Thu, 19 Nov 2026 17:54:19 +0100
Message-Id: <20261119165420.24466-10-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261119165420.24466-1-rofikcoga@gmail.com>
References: <20261119165420.24466-1-rofikcoga@gmail.com>
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
index 160b6f4c98b17..3ce8161574a95 100644
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

