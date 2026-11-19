Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107272;
	b=vR69GI+isHyT6t8f+X+YYK3dFbFOB3sTrgLp4iYdBCaSopjJccpa/kB8RGVqAYRN2rOM
	 GEZ+nBk3VuhhYAmVs3N18YH7S5dbBXhabxiy4QK6WBpRFocXK8vBPLxpUMTx7I8IhqXmZ
	 20QBLkChGbyFivimHbBGT4GzGTTihLWiXzh0Z1YHhoi6UXa4vRGCXyL88MpIttneK4AdF
	 dP5jJeIMdgzUq6223ChIvSPDIOCyh3bbSZoYVFPxnFdNXZZg8M5ShpwnOAGTAhB/LBusS
	 Ns6dj+zOOpg9n6gf2AY6wMWPiTuBuWapo/s+KY8vvowKXh5dkTWrxyqvV+RX1Fem6Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tqAZ8i8YHyd8H+59b7YVQzKbswaS0aGE8O0OFJI4g/c=;
	b=v81if1yrAZ9FLXCdFqIwY5mk6wH6qa6iOagvrJzXLd2zQIj3c7nXr3LQhx6HV1EvVLSo
	 yqgT3rbDVMIiieSN5Qxo5i024DhhJ0fGhJ1zQP/uAr92obxBInCd0To6UiKRJ2ecafUs1
	 iDeU4V+Lcflqj3H8xl44+PzqiiK38GVMbX5byhDBUOTuXjmmQ/5MVS6GIVAE1XtPf08iQ
	 sbu+l4rd6wZBpnTaxMSRArYNywIGXsP/MhdQBlP4Y0faC4DjuZ1VmfZX/yU21yD/kfQwB
	 FvrWQ9KYRxqKWRljLi7PzbV8bl3ItLTiiIoDNvVgqVgO1HxYryrLgHLbzGVEzZ3e62A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XjvZK7Pu;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B1A60A5BC0
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 16:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56B1A60A5BC0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XjvZK7Pu
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso28042795e9.3
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 08:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795107271; x=1795712071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tqAZ8i8YHyd8H+59b7YVQzKbswaS0aGE8O0OFJI4g/c=;
        b=XjvZK7PuZi8XTLMQa9L1sxjKmZ99wpMJwrPePbpWH07379UZUNok+6QSl9OC3Kggox
         FeCAOTpSGChqgFOVuCTcHjorrGpGYc5CohQoABPLaPZBcDDw17Q0VZW2GZshTqjA5iKQ
         Wi4a0lcEzN40ZbpCD02r7Q0jjIVCCJNzYofqFcHcPD/AaAYTQ5IHBDJPGOygekgGzhdN
         dIjMZvJgXgHZW/k+CljgLPFPTkvnB5OG5SMpeR+WlZVaF/cNyo0UeXmqPX8BP/GRobN8
         epQmPJeLpAp12sX9EPiUxmh3SrM2MY9gu8A5HVpKexGoiKKNmeGTZraqbvC4Qz+fjM9e
         7yzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795107271; x=1795712071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tqAZ8i8YHyd8H+59b7YVQzKbswaS0aGE8O0OFJI4g/c=;
        b=Ke5icyDVjjNbtM8y+Hwr3oh+9PURGo3DPqdGORkeUGEUXsuUwmKt1J8R7HFEcfmrAg
         BQviEfifELXUwpT3N3LAYGrhx8HWc7C6F5/7iaaq/zH7nRVHrg4CbzHNXPvMSKcqaNxJ
         S5vhfMNKgAhEQ8CRvdPm5wgRguPpSglSBYitpgklQUFQOdCgUjRsCbkkJnJ9kdnD+VZH
         AEjsQ53t5p0MkJgHXOikkWK6E9KSSPRoIYxLYxzgxNVOVa94+8lxqg2LQcOt0lQQJtih
         eDzIIE/DNeF6dyb1/mHsz/ldBU2fMn9UrklOCi5b1IQTiYwcbw7Omhlo9B3OQV/skX+k
         M5tg==
X-Forwarded-Encrypted: i=1; AL+hErEkFPB9Zp7lHoGz8hwmvxiR1rMe04gMnxUBFoCmY2yf7OdXNaDzm0UFx0A2vQUjEVc/vYtXIyiLiYEXVA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8R5YRNWCteoLpLcFGMlir74V595NBcaFKBxdjaoJ+pNHfKWspx
	ivz9DJXs5cjLRTYBdvWYBqro76WUjb6xrIbro1vUOO2SdDvfp7uyhl2+
X-Gm-Gg: AYBFou0wHmcBk284T1Td8moC4yF4vihZITxJEnHtKO0GH60H8675Xucp1MzhgJVEIhr
	mwV3gfSSUW02BfHHUVaI+jj0eSCvWtCR9CzU7v1R0GK6u5Xdiu4ZJsl6CdQoODcgBL/c62F9g1D
	xY+qIR3Xoa30gDy6ovlkaJMcwgaeNLddLfKaCOggLgAxpL0w4duHj6l0FY4412E4NMYtB4vapWK
	FE1Myhm8rkUs3sUd9+AzEA5hX4b6ls3Pk62DIkzXsRMcWubX61mqwx/QTbB/T1sSVDGAbXOxH2z
	wpBf6YwmEAL4zQjnTBCtLL4PGlmn1FKQzFe6sEp/E8n1ohUVAkGPLjmi49JUK4tvDgAud+KoFi1
	CjrSEimxEL4cGyADZwpvM0hVqgEIf+sfVPu0CxNy/byUuvqMnVEqdJkUgNUb7m/rWmuL/aJHtNH
	2Sabdc1B0dpTS75PdKF3YhxSx5EOcoH934AEVsYHlZQYkf5TAgctz0tM2NSyrO35cwJhjE9gANT
	dTbsPR2gQgLaZp/9df9WydgRYtUCY1ss3B4JXQ1tTacTv94GbZD0K7Ax0tQru4Tb4MYxvdljg4o
	mQqhHqvuTE56ZWgilU6jIsP4erzc29Wmkpm/WdLNGYdN2DSBVRYyJt+tPwfwFdli6WVYV7SuuVU
	=
X-Received: by 2002:a05:600c:8184:b0:4a3:5a7b:6002 with SMTP id 5b1f17b1804b1-4bb8881e969mr1657545e9.28.1795107270775;
        Thu, 19 Nov 2026 08:54:30 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm9894555e9.0.2026.11.19.08.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:54:30 -0800 (PST)
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
Subject: [PATCH v3 07/10] arm64: dts: qcom: sm8250-lg-timelm: enable SW43103 panel
Date: Thu, 19 Nov 2026 17:54:17 +0100
Message-Id: <20261119165420.24466-8-rofikcoga@gmail.com>
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

Enable MDSS, DSI0, and its PHY. Attach the SW43103 panel with its power
rails, enable and reset GPIOs, and four-lane DSI link.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index 00e3fa560e95e..59d6c1518a469 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
@@ -461,6 +461,42 @@ &gpu_zap_shader {
 	firmware-name = "qcom/sm8250/LG/timelm/a650_zap.mbn";
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l9a_1p2>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "lg,sw43103";
+		reg = <0>;
+
+		vddi-supply = <&vreg_l14a_1p8>;
+		vpnl-supply = <&vreg_l11c_3p0>;
+
+		reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&pm8150l_gpios 4 GPIO_ACTIVE_HIGH>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&panel_in>;
+	data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l5a_0p88>;
+	status = "okay";
+};
+
 &pm8150_gpios {
 	google_assist_state: google-assist-state {
 		pins = "gpio1";
-- 
2.39.5

