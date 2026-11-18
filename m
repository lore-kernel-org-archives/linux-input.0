Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003647;
	b=Mwp3quQ1uZtSbPGx93OXLaa4HdBhh3L1s3dyYh0G+pHdz5HvIY3m3jo1/j/OPzkqigJ6
	 404OkZj8/hrlLWfESfjnRjnmt2ITjqHwQkR75pOa3dckwPHhWcqldOvLgfXBupLa5aN5N
	 FBQDAB9miXqDvWLIH+LbAutT1X7i++cenPcz3GOHJDCGI96PMbdK6k0d360m6OxFfoRua
	 5XNVumuDquAg8t1U0IhuchgNzfTuMLEHZc7CghoMrfwk2nv39hAYNVmi+U7gHxz1m3n/Z
	 jKB2QEXBr875MqRg+TU1IpLrrYi6gAGJSQe3XncNyU1m8c3MVgibr6JGovwhYVswMNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wOO7pl4T1V2FI+1ZhOhvGDpiZBHJDeIfIIIzY8CL3HM=;
	b=3mUSW6un0BpU9P8foLmUYqa0IyKaG6maCy83lF2uC+u4bctYwiqMZLMuh0qlxsQ6B/Qb
	 14EgFo4M/jgBpUTThf1YAzMie/DDfKg2gU9fQaXPr6Bo1YxQLMPKweHMn4lgFGBqlusFJ
	 ByvW6CtugfooQdnz36BqsNrMtdIDQ1tWsZenB66+zdRNJ5xc0x9PvNM4Pm8XgdzRNyLIY
	 11feOHSxd2l5XWlc8LqwryNAi3DVwbWeQqeyB/ejVZW9T8CcBJ8Nf3kKBQ8fdumNizB5M
	 Sli9zru208V55dpOsc4EMxAEn92CMP8r/xOKB6tQwEfiM8ILGIeFWMI02v8I9/Af3wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hCM3XXoA;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF86260A5BDF
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 12:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF86260A5BDF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hCM3XXoA
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so8051615e9.0
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 04:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795003645; x=1795608445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wOO7pl4T1V2FI+1ZhOhvGDpiZBHJDeIfIIIzY8CL3HM=;
        b=hCM3XXoABsifPCJHl+S9eIEkiniH8JknIKrQQ5Q4sOKVkcnlgSaYr4w7x6Lm6d08Ue
         TZ1dOmCDAbwd5+r03qljZcFpePl0kaycFVhaciEsPK8NYWUznZEYvVuDRQTNrJJ/cErB
         CwzXcoHVSixwu/iW9djD6fPOSrCq81FtTuYd9zHM5NR8oFkgkTUq/7+v86Kf6uK60RLw
         xIBruYyEb1eKcyjlwVe3KmMBsmia9hK3JkIWr966eDgD1FvzBi1elzbRLMkznNB2eTCZ
         KIcrOtAdznKdiLxM25GbEO+cUeIFZwIff93pzsBsPYmo8lt/MaygSGgz1sazwbOKgX+C
         g1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795003645; x=1795608445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wOO7pl4T1V2FI+1ZhOhvGDpiZBHJDeIfIIIzY8CL3HM=;
        b=Rdzy8Eu/mDZEmekGPn19+Z7L7p/zC0aTYhr2atxhtIBMnPv2DmTMNy9EAlecdyyp6/
         tvTWVr2bNIqC6OEwsDl0YSAJVl4JBkUm9PZWU69oNPqykEeYhoKEg5ArlU+SEM4NQLCp
         PC55lEIUag7noJy6Jcr0qiwjsI4YShQo6TcOhzMEo84gi4TXCl3QywtgReq2nBDES6+t
         nPs9hbm0BrK0m00QYp93Y5ED5lX4pUerH5KwN/8AZj8TzPXY8XSFDutXYDO54Mm7DGqB
         NfOOVc9lfdGs12AApWau8JFlmHl7YOXxcpSxC+YJfmDJ3ZPQ6bo+OIRmjOHCiFena8RV
         Za8Q==
X-Forwarded-Encrypted: i=1; AL+hErGTfSXLHAoTLXmEKxc9pqnxosxFPDdKwEeCzKGIodvBIgj1a9N2T7gp95koofFokbYR2GItWomoBIit0Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z95/fJ1LDTfm1w6IyU2ngd0HZE8NOgDg/4zO4OKFKn02rU54l9Q
	csij+zewPAzqmgHk8LtxprwwIRaw2t7855kLNn2tY+40ZOdO24Hrq0Mm
X-Gm-Gg: AYBFou1ThBGxJK2zKB+DCgsDa/OL9cFL2/zAr/Sf7ef5qzesLLoRPIDpzCI3/7JonOO
	o5uF8fv+yZs8uHGFLRc3SPZAoOwtpyCz4U7RGEa7UBfKRqS9ODyHpWm2S/u/1eUFtHepqW19PuD
	bN2L/+hTAqEX3cULo2bAl4mYfWKxOkOBbe51ty/3aUWG/1NdwDfljM2i6jpRJ3FVMZGObU7xuy3
	t2eEHtUb0lWwoT+F8kh/XPSSkfPA1wnZa6WDd93tgXUx+EcjlCJMNC4JKcVPMjppjJuvmjBX/SM
	5G9sqpH+qyRH3VKk9Y3kV7D1D29jFrpmydFmr0vQwOfBtCeFeT8qaHoGtx8JQk2AkfoSaLxo6rG
	Ai0ogqTx3FVDxxa5bSSQsCmwpk8h8jhUIf4lYfCBb0uVj/B/PuXidC5K0pcg+7KiEAk0kFcaAK6
	G1D+uSN+21I9UnwOmO+JoI9fwnx/WSgNMJdy49oe41fefyhe7svoavWf6kurLF0k7rNqXnN/hIh
	/rViRg2KGZUG5Ly08/KzVOistiBiQ4qhXdWmWHWQSs0n/fz1HIdJFOIeuMEc4up4Vq8fvOOjnfH
	KFXM5kq+2HgpnkwAVCucpK69GBOfNZsPR8DKxLukrKtdvBUYvXyuW72Wc1ZuAygfCsu22MplIhA
	=
X-Received: by 2002:a05:600c:4e93:b0:4bb:5c92:ce12 with SMTP id 5b1f17b1804b1-4bb7da12f06mr44646025e9.17.1795003645203;
        Wed, 18 Nov 2026 04:07:25 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c37fsm4382583f8f.18.2026.11.18.04.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:07:24 -0800 (PST)
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
Subject: [PATCH v2 08/10] arm64: dts: qcom: sm8250-lg-timelm: add SW42902 touchscreen
Date: Wed, 18 Nov 2026 13:07:12 +0100
Message-Id: <20261118120714.31505-9-rofikcoga@gmail.com>
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

Describe the SW42902 touchscreen on GENI I2C13 with its interrupt,
reset, regulator supplies, pinctrl, and native 1080x2460 touch area.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index d307a52cd0e62..be5b894b677bb 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
@@ -101,6 +101,24 @@ vph_pwr: vph-pwr-regulator {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	reg_ts_vcl: regulator-ts-vcl {
+		compatible = "regulator-fixed";
+		regulator-name = "reg_ts_vcl";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pm8150_gpios 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_ts_vdd: regulator-ts-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "reg_ts_vdd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&pm8150_gpios 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &apps_rsc {
@@ -461,6 +479,29 @@ zap-shader {
 	};
 };
 
+&i2c13 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	touchscreen@48 {
+		compatible = "lg,sw42902";
+		reg = <0x48>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <39 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_default>;
+
+		reset-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+		vcl-supply = <&reg_ts_vcl>;
+		vdd-supply = <&reg_ts_vdd>;
+
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <2460>;
+	};
+};
+
 &mdss {
 	status = "okay";
 };
@@ -604,6 +645,13 @@ sdc2_card_det_n: sd-card-det-n-state {
 		drive-strength = <2>;
 		bias-pull-up;
 	};
+
+	ts_int_default: ts-int-default-state {
+		pins = "gpio39";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
 };
 
 &uart12 {
-- 
2.39.5

