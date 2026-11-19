Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107275;
	b=wRYxaMsWUDd10oXjFcHGE8ciBJDuoL9F265k0l+gW53xNxrAnbXL16/ucDKhcroILDZD
	 2GsVNZlFFry3ilN2JGM18P4eTzxntgWtxGN3/Ae4kES7HkmXWuRiyNU8bgw/aa4+neQp/
	 MFWhBVkP6peFugT7OcQ6D/eGV+RazrHHfau9oPpOpjONEv3AKpIZaysjNPE/SdeGjPSA8
	 AWXrUXj3HEbZQ9GNvXazwsaOg8409pG20cmnj+RLJcwDOglANC4MsPeoBwTwNTIToYdD0
	 TmrjLIMKd6QKM8Dml0Z/+HNSElgjyXrfCXgPl0lCsr+h8Nsc15zd39ijzLXyNDJJ67g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eWJ+9K9CujW+/eiSnl3KVXLfbSNQleY4XU8YoN4v9sc=;
	b=QSvz45eH97dsSozl5gngywrMi+bixIkV/xT9AHyeh39WA/FDcFrwE89B9fZHwiBV1jXR
	 YDzOXex271Jy+KHZ3qdH4hWPVTsPB91Vy5bPBG0fUoZ2Gj17PO0wETYw3jY+pdtA3C9v9
	 rpC31i5x0p749O3bJf5wnzheWNISu8s5+YJEl7MJh0EdVuXoXYj3e797S5VaoGMObVxA2
	 AwUC1ok+vk1laKXuawR6MjXpsgjdTfJWUQJPoRXphuhHQU8wpOPJDhx+5m7v5nrFKm4/t
	 0F2EDZtJ1MMNFxz1voMb6TGtbmmy68bT0NqtUHAKsP1BQFIXY9QXRBxvjCVmi9LNHlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nrx391Qe;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6667960A6F7A
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 16:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6667960A6F7A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nrx391Qe
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso25899965e9.1
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 08:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795107274; x=1795712074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eWJ+9K9CujW+/eiSnl3KVXLfbSNQleY4XU8YoN4v9sc=;
        b=Nrx391Qe8+O8LqOtDCxu0O4VfUEM6BMWsAQwTIo6k8TAeB/r7c7TRfxpIZo1divfz4
         r8tO2cydvdc/MU3hs6payqwcxFAz9jPrmXFLNOdrDAvI3N9j+cXAVx2J2yH2FUrhXRea
         K+jyFhiVfTiha3RQw9kkuX2nQRWcBS5adNGDMSxkH0QsFJyVRSHwUMpxaZxkGUbgDGb1
         6b5CLWS1UAN4WZ2Ws7iiTdWqW1mRUPWrNVKiSTlA8306egVDp8KG7vtlPMrUmECR3+ny
         CjReWy+0X4DMn9i0Mmy+v/siVTSLv7Xb8hx/Gp2kpi1xdliQfdCEUV6OtE2fncCVBnri
         SGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795107274; x=1795712074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eWJ+9K9CujW+/eiSnl3KVXLfbSNQleY4XU8YoN4v9sc=;
        b=XdAywBdxQBLsDmMIuRrv4rmkgZcE1rL+U8P0W701s1q1NTuEX4MtITyL3N5ck9YVX7
         rB+hbGOczcWa1pnqpUDhWmYds8vU5bs/Qgikf0B6q4SDtYfb5J2rerBysd4+t2VeFsJX
         DwhjZA19dkyEy64kTLmHrEgdDZwTuJpLCmCQfu+HCIUJ1EzaUQPrQQhTY917u70CzCid
         HZCTq9EdXidqCBpxxHrvQUwMN2R7QxLYhgEYlm3vaT2xRCErc1K8CnQka+rAxuVBas+X
         A4vr740X+dz9c7DXlEZ+HDYNveDERe7XFC2GZpFKYuHHcKwMH/4V0L9ebMA7VXqSoWOP
         ypEA==
X-Forwarded-Encrypted: i=1; AL+hErEH0b1RWjBNXFxOr/XjjixDdKNjqEmQN85ShGK02xaTEFd1dInMb24YeGHwwjvAkb1qx7IFQueoVoqGRg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+EpoHFGqpQtBefMWvAehWyh5FrypS+D8q/iRzSVuPmEyAExarM
	RHwfOY6sDIYrpNwPWQRG7Xstj6suVfr7eSSug2kdesz4iUyHFKB/1jVg
X-Gm-Gg: AYBFou0gBqSFHjcAu0spKYA92Pr/dutCcpIJh0JzvHuaJkyle74FZ9BJyyMmmfiH2uc
	RKMPytVig4f3S1t21xeYOs35DauYs0g0fE3JtWpaFDY5BYnSRu54ZtvpLhLUI1wxzTuRtQVzT3A
	UxrFcuw+fxzFHmGZjIWRJufOB3VRUbnGQqc8rsyiwXNKaJy45ubKLClob6bnyg807xpg/rgepR6
	i5ISBKKJKAEtdfl8zegU8ff0vPzq4QjNZ6GW+COCgcby4ve8WeN8vVKQcMB1cxp+borm0FFAbgm
	OLul3xPTbmRnsaFzhE12edqutqYUGMjn0ToDA4Cmf+oziyoQdGnJ/pghpFKKkczzPoQ4ZjEStrb
	1530M7aZQbqp5okgWKZTnzGqAqB7EQHNJaQgnLhdyhftoL+Zh44AxXP8DgG9PWoKIF7NdJQGSii
	tMyE5UmqbYYO3SGENrckQvbxaF/sBfManAK7/7l8SOYkxKfJavRDFQxfXpUBBcFevHAdsmBQ6lt
	ZuKBIQnSUt9OBhbFH9WuOvpFqAwfunbXllNO8yLmZdobyerYJDVY8gQBB/91zdNeIGmAlnKM+WV
	m8TJfXE7UbuKG4TblIG7Ckh6tie8Yenu/N/8p2jvPhCbtdTYDNmmtF5bFLAmIGU4y7jiR3NhUdA
	=
X-Received: by 2002:a05:600c:3ba4:b0:4ba:493b:3401 with SMTP id 5b1f17b1804b1-4bb8880abafmr2552105e9.9.1795107273824;
        Thu, 19 Nov 2026 08:54:33 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm9894555e9.0.2026.11.19.08.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:54:33 -0800 (PST)
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
Subject: [PATCH v3 10/10] arm64: dts: qcom: sm8250-lg-timelm: add QCA6390 Bluetooth
Date: Thu, 19 Nov 2026 17:54:20 +0100
Message-Id: <20261119165420.24466-11-rofikcoga@gmail.com>
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

Describe the QCA6390 power sequencer with properly voltaged supplies
and enable Bluetooth HCI on GENI UART6.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index 3ce8161574a95..1426ce82d3f58 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
@@ -65,6 +65,67 @@ key-assistant {
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
@@ -634,6 +695,14 @@ &sdhc_2 {
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
@@ -667,6 +736,29 @@ ts_int_default: ts-int-default-state {
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

