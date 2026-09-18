Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66853CAE99
	for <linux-input@vger.kernel.org>; Fri, 18 Sep 2026 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716603; cv=none; b=YjpODQ0hEdTs2xhphtiZkAbPl5s5Mrz42W/oibN+TT+QqhicEYbzjTCwlPxon37O7dUUB76Q/TH4JLkloxQ+WE687WJ2DA+pcEPqhnZ4iVHdfU6RR0PDSbCXsAWfqfDsrPKetLr3zBMop2xjq6xWuukYGH9c7EAYKbPtZQWeh/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716603; c=relaxed/simple;
	bh=tKqz8WaA5fCf8zqxAuhb+KSHy9L2ioB7dBm28PChNnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P/4/GX+0WwuMzA8YQJn/E0lrvS8+/hUahB7RDLMgXnlb3vmGE4sbFB+RgJLSzrdXrQcCu9dyO4raZ/Do4xMLi5xqYnGEO9tIk93GLIWUnQhc78JPX9mUnHg69e5UvaHBUYdObBlb2fLogxc+8h3CkB4Ky2IIkcF+lxqIne8BYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=p7w9+/kk; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="p7w9+/kk"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a98dfb8002so556555a12.2
        for <linux-input@vger.kernel.org>; Fri, 18 Sep 2026 00:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1789716598; x=1790321398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T0+EbfIJEQi9Km2o4RWY1Oe967wA79enaext7ctyUJE=;
        b=p7w9+/kkhj5DvJ/KbvXEHJ+2s7Zm49sC4kRnUrDGS/7HDkoHK8RLEeIYIT4kMasctp
         VKXtB7vgwdWoDiwZn0TwMKFvsMujtsKW4IZmwgNUPsa0uqa5PZPiG+tU7mZvDoiERGWS
         ogxviEKXNdCdl9SzjKkNSI8nPc+DkJBEHhsDYWYropnTwITbtO3CH/S3QhmDgTxSGqkJ
         4+02P7zfWOKHFyskO2NTlMdn50EwWqI2DL4vSY5kUSQMCQs/7aM+D+HDeRmEjEi5J6/T
         JR6U5lvv+yiJZFzd3dYWeNge6MCVzBem8kHyLY35w+alRmR6VaCDWfn2paKVA+MpfcAF
         Nk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789716598; x=1790321398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T0+EbfIJEQi9Km2o4RWY1Oe967wA79enaext7ctyUJE=;
        b=Hr/JcfrJCMwPJDYS/mDubD9oStwPrA9NvhWxmlJ7+bDPpl5rISxRWwQ69TKENO00LS
         jOpBVIzZ74isdxdUGx9NWx7WLireOq3tbrj9Vl6732hQsoLmL0W/Toa9aVzL4QCwXeJU
         2X731GHZ5UTgggIYWORYX+9uKF65o0MO+cuCPcQRDybD8jKxpwNyb6KJLEZe6AVYkf4q
         7EbiKpt6BNOAtt23xq5P+TFLrNrvJjVPcb8yYzJq69CXXE0DiA8aeTxOBdEu2dc7R13Y
         EWX/a/XESE4HC5fnlNanZVeZLRdV7o8eDCrPFF5FIG/GEjmQu1RSnoXIXes31Fp/PvHo
         ItWQ==
X-Forwarded-Encrypted: i=1; AKwUvBx77rd/nifvd9w6Lj5zibUCxQy/W/smwB8OfDspwC5BwzEdfmh38sI9Lv15qVV0nYnRuYjxiJMZaB4y7Q==@vger.kernel.org
X-Gm-Message-State: AFuF++n+taolAjPbpwNacmZO1Gzh9yy4g8XuXq7gJa5PHy0S/CDnvIO0
	3hY7qtKCzySAQzV/SKmgbQKzg9Es8aC+FUfBw618BKPMJ2EMl/6QLHabvEU0vf+Fe30=
X-Gm-Gg: AYBFou2aTYuYxRPV2FEiUn3in9jbX39zZUO8KyRw04VJN5Vf5IJs8DetguN3PpnrKqF
	KSe2H1iI5sv9Ax0vVNE09E9/LF9R5s4PptNuOxb6TjUqOmyei1BLHgWmp2AYGIZY3pAcxzHr59l
	feqGCZexZ66IfvX98k0pIVtPwXirojZw72gGc87KrrJQ9Rfmz19xBJYJyWLWk0CjapuLWqx/r66
	PBO5mJQox1gmrQDznfBntFOyg1/0aDol1t2xR58k3p0OX6XK4/P3nhbR+nTDXWQaj7ZknVexFCS
	zGsQsGtUCrFwKQhbR3L29hnUtWRcEZI+JeoUchn/yKf65xzj0jmqcb+NaAPg+X+/dWG8Yfd6B97
	tlxFgkAQFVCFB45OMOao54JYsBiCC3tiGrc5bSfvgNV3PGcAyxLzZWHN2TrmR7qRh7Aca35BaTW
	zP8IOLlWLAx1EoQtcYxBRYsslko3zVTQWu8CZ93hHIN605j9HXPYxLjvCpaomxXaytBFC1GDsDX
	pG2roH78E6P7oPDOr9jRmKKhEiLm3p1Xf0p4YSvjf+nh6GTK1cGTBfVODgq+R0=
X-Received: by 2002:a05:6402:4406:b0:6a7:f505:ef3a with SMTP id 4fb4d7f45d1cf-6aa548a74c0mr564874a12.35.1789716598550;
        Fri, 18 Sep 2026 00:29:58 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa58d55cd3sm462048a12.2.2026.09.18.00.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 00:29:58 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 18 Sep 2026 09:29:54 +0200
Subject: [PATCH v3 3/3] arm64: dts: qcom: milos-fairphone-fp6: Add
 touchscreen
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-eswin-eph8621-v3-3-514eb1f622c0@fairphone.com>
References: <20260918-eswin-eph8621-v3-0-514eb1f622c0@fairphone.com>
In-Reply-To: <20260918-eswin-eph8621-v3-0-514eb1f622c0@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789716594; l=1602;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=tKqz8WaA5fCf8zqxAuhb+KSHy9L2ioB7dBm28PChNnM=;
 b=FSUkC8Dg+KYzQ1EbVyPSln4RuJEUYkt0GCi4zrHCKl6m1CNeYmsTytFydVGIhLVu7WZEc283N
 JHQdxsdjJ/SALm7EsjPehZ2veC95aM6/MbRmVii4aLXrmNkQCsjglDK
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add a node for the ESWIN EPH8621 touchscreen connected via SPI and the
pinctrl state for the two GPIOs connected to the touchscreen.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 29 +++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
index 4b7ae87270ac..498fde3d3d18 100644
--- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
+++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
@@ -983,7 +983,27 @@ &sdhc_2 {
 };
 
 &spi0 {
-	/* Eswin EPH8621 touchscreen @ 0 */
+	status = "okay";
+
+	touchscreen@0 {
+		compatible = "eswin,eph8621";
+		reg = <0>;
+
+		avdd-supply = <&vreg_l22b>;
+		vddio-supply = <&vreg_l9b>;
+
+		interrupts-extended = <&tlmm 19 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&tlmm 20 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&touchscreen_default>;
+		pinctrl-names = "default";
+
+		spi-max-frequency = <2000000>;
+
+		touchscreen-size-x = <1116>;
+		touchscreen-size-y = <2484>;
+		touchscreen-inverted-x;
+	};
 };
 
 &tlmm {
@@ -991,6 +1011,13 @@ &tlmm {
 			       <13 1>, /* NC */
 			       <63 2>; /* WLAN UART */
 
+	touchscreen_default: touchscreen-default-state {
+		pins = "gpio19", "gpio20";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	sdc2_card_det_n: sdc2-card-det-state {
 		pins = "gpio65";
 		function = "gpio";

-- 
2.55.0

