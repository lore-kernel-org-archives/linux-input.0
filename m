Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6D235AC24
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772448634; cv=none; b=n9ewmUu37jsPnfCyqiR14uEoY2dmwMEsxwKGHFWXG/u+MaucvZMf9t8kXZwS6rbHAIdf3EyTTsRDcSu+r3c4OSF0FuIjpkaExmELysjxcuMBsq2pe0gn8DeUkcwTHvoUdWN1pBl5I1i+bJ8fPsmT0OCEBAGduciNOf6sLwz3S+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772448634; c=relaxed/simple;
	bh=qfKnEcsoVX06QZzEM7/4cC6HPLmj8y0sO6sxJasyjlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=omYtS7mfyn199vn4aTDTv0P0qgDesxWYXVm1xaDvTf/tBD9D/PFIfJxgTTrMyVFOEy6jXgOckLwuPb9jGrtsg5ShHDPxTHGlijuETQTi6yz7PXRUqQLYgeZfCRQZ1l3Nq6eezG60QHQzgWmpppb3HBLV0T/oFPlmY+Vj946/3cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=hAT1LYva; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="hAT1LYva"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65f771c6b89so6231162a12.3
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 02:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1772448631; x=1773053431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQRQHvtqeyxSd6xSuySaBNbpnzY0H4KkdhX34aIrxhU=;
        b=hAT1LYvaTiGkwA1DQLIjiQHG6/W6EeCDkHUdIXcXsnHWmLXCJNC+5EL+AjOQGdPbg6
         T6egcUGhTXMkRxnYwuBZJloG8yEXk8sX8RHc6AuLgzUMIabQfcpjtUe49mFzEoSm3Roz
         6VKMhkJJZ/3g7MMSgJdO2BM0+kkg9Go5h2zvzSBBTqN6LWzKS6qDslKAxBxMMWKiwUsd
         h9JW3M9QH97GY8DxJ5+ndtyZajmMjMtJ34r+oJ+n99uk3zCXlpoTesOrN28IannM5bCc
         jA8FJV/hoswIYx3fiYXVaIILxNfzDuAAq0IUnEYQRcLikmbxWh2pnuZSAjtqzQPZTseE
         GLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772448631; x=1773053431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sQRQHvtqeyxSd6xSuySaBNbpnzY0H4KkdhX34aIrxhU=;
        b=PUN78mY4L8NOy7FFu0kHpIVM2EYZ6rcUjfRLt4ppU/F0ABrGIvMNcJh5Dz0meJaPpO
         4oVF5JTB/jKp8zXfQQWl8cMHSuJQDOchQaM9J6QRCwKSAaqjRgAtaAVbOZ9QLb6YE2dM
         mynH7kbs8OD9a96q69MsCWaVPXcqsUE+q7sLWbudortMEq/WJFNDM1stFveoIplQ1H0t
         u3VC2bYP8VKNrY4rR1R8rnB5K5zTJgraNIVQawycV1W+kt7sIbcJf1owW224YOG8s9+b
         p+X6yn7YmqFs2/Wdk2DRgur+XD6mw3n/shuVG/W9Q/AMPBlALGY1mlge4fknW6Dgqhqd
         67GA==
X-Gm-Message-State: AOJu0YxJsJBN8/aY3UvpeVU6V4g5+WuOZyaTcRViL3BjA/fQkUMkdjCc
	Sm0aqfowKeMMMFc+vEDxG+v3rrspj3VrCCv6WHol4OtUnKhe491djSaSRIp/9ObmQyI=
X-Gm-Gg: ATEYQzwAX9aMXHKIwFNH0L9WFmbhzayAekV0Q2+ejlKgz6SdLyeKqpdhTFF/WxVCCVw
	0IyZKrSg76jo4wk8aOto+PqV7PJOVXdtS0HBXmM6Frgk6G6KF0tbtufPnB6WkujbvWwbERkfYKM
	0MdOVLyy5To1DjGmBGI7sCquiiEiFc2pf4jSwVKrqhr5Uat2zxrNlSmyAtEinqvKl0GlXg038sm
	lXQDuywn2QYQ2jynTta5NAuEH7cvqiM+6vT17ArBX3HXsXhbtqKdMen/g1CD2fR6CwNc2YdJWco
	m6zkSZ2Vo0byiB+mrENosXVIk9WRBAIK/bBc7ZKXioJdK1ctGm/zNy8uoNy/KfNsVOwM1i0VLXw
	8r9yifcSeUF4qnAbFTQ+WsiUvMbo5/rQn+RO2JghXVPG7+T2nBMCPDVCaJVLMjYM85eY8AAJJuF
	S5id1yGfwsvp0jl01Vdp2xOtL41MkTGMiRIMhy0Vt1F0aAvAMMKl+y2+Td1VqfNrmFHqkfNZWBB
	fbig38Cpg==
X-Received: by 2002:a05:6402:398b:b0:65c:2af1:b7e2 with SMTP id 4fb4d7f45d1cf-65fddee587dmr4742714a12.27.1772448631462;
        Mon, 02 Mar 2026 02:50:31 -0800 (PST)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabbd98bcsm3511769a12.0.2026.03.02.02.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 02:50:30 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Mon, 02 Mar 2026 11:50:28 +0100
Subject: [PATCH v4 4/4] arm64: dts: qcom: milos-fairphone-fp6: Add vibrator
 support
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-aw86938-driver-v4-4-92c865df9cca@fairphone.com>
References: <20260302-aw86938-driver-v4-0-92c865df9cca@fairphone.com>
In-Reply-To: <20260302-aw86938-driver-v4-0-92c865df9cca@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772448626; l=1662;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=qfKnEcsoVX06QZzEM7/4cC6HPLmj8y0sO6sxJasyjlw=;
 b=CD8MrPX2NaW+cddjb6pIzw4VQffjeV7qC+Jfx7vwUkfptL/drfQGxZeVF0rp/mWLz02lbvFU3
 Zw5SSxZkMpmAfNx8ptsMHqTaGjsmbUkCUtVYYwgEs2Me4gpbRczIfpR
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add the required node for haptic playback (Awinic AW86938)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 26 +++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
index 52895dd9e4fa117aef6822df230ebf644e5f02ba..324d18d9900881a840806ada84e33fe9664296a0 100644
--- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
+++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
@@ -625,7 +625,17 @@ vreg_l7p: ldo7 {
 	};
 
 	/* VL53L3 ToF @ 0x29 */
-	/* AW86938FCR vibrator @ 0x5a */
+
+	vibrator@5a {
+		compatible = "awinic,aw86938", "awinic,aw86927";
+		reg = <0x5a>;
+
+		interrupts-extended = <&tlmm 80 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&tlmm 78 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&aw86938_int_default>, <&aw86938_reset_default>;
+		pinctrl-names = "default";
+	};
 };
 
 &pm8550vs_c {
@@ -755,6 +765,20 @@ sdc2_card_det_n: sdc2-card-det-state {
 		bias-pull-up;
 	};
 
+	aw86938_reset_default: aw86938-reset-default-state {
+		pins = "gpio78";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	aw86938_int_default: aw86938-int-default-state {
+		pins = "gpio80";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
 	pm8008_int_default: pm8008-int-default-state {
 		pins = "gpio125";
 		function = "gpio";

-- 
2.43.0

