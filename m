Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E813783BE
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770642003; cv=none; b=SNhlojF7lka+KKchhggBot+3KmtFpnR8vAaL1bHMfR1B35cGVtONpvsG1DrZE7l9KGJsbl2ZT7ihOyw91y+MWupRsRamFNaz4PE9ZExDOtbnZBWpLNo6PQuXxGVUa21bTQeoi3JOrkbS255uotI1br/st13dnm/KzpjOEhnNUqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770642003; c=relaxed/simple;
	bh=qfKnEcsoVX06QZzEM7/4cC6HPLmj8y0sO6sxJasyjlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ptM/Q52mOg2JHelb1fkGBT+oDMxwaqmHxFcadNlVnYtxTR/TERHQoXlpVc7a/MvtPBwHeO26v/Wz537CdIOr2B66tfpuf2dci0Uc+q8BOyxwIdfbj2UCniy4loRi/lPqRR4QhrQuPqggGQtNdwjnJMTmeQNiGPg+eOpfjnXlz4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=zyN77k3W; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="zyN77k3W"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b884d5c787bso485722366b.0
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 05:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1770642001; x=1771246801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQRQHvtqeyxSd6xSuySaBNbpnzY0H4KkdhX34aIrxhU=;
        b=zyN77k3WQFGV+mUZ2kx1KRb8WdAhycj2/mbOntnjs0ZSOoRIv+Jg2ID7zhe1NizG6q
         ig4+3FimO0VGoaBqJjwmL0qDA4PdSEQWjcfvAjzlHC5Idqq2ajmB5qBmL61n/rvmbUEi
         irxnsbzHOlx73wSL0CPlLPf2eZVXN2EmMhLqjyJN5KtGgl5Bvzuwkuq8D0yER1+2xUYU
         hErAwlSFBlJHcbgZI2wqMqP7Ly5Yjthvky9lExfRVyBFF06zF1bMEvzCi92uQ4cHzdJj
         1dQ2tOnld99sBlwwyWsFrnTjl5RbWCiVXLEASAlfhMbEPbHCepFhf1HUEs4z/2gLA937
         Z1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770642001; x=1771246801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sQRQHvtqeyxSd6xSuySaBNbpnzY0H4KkdhX34aIrxhU=;
        b=n45H1E2j283ShHjGuSw7GlZCXXiE6dN+PxX8w1THT6vnt5EblA+9hkYKNbVSygPZg4
         8LJD9lSbAMPEezOK1N5ADE1sDMay0tmS2kIfDcAjMEeeaqzCO/EefQOVXo+eu6RoPoAQ
         19NXcBYdNYIIC1oOBWfuCLxQqv6TUk9RoNmWigimBcYqjZL1gfO5HHoj1eOmk4Wq75SX
         vocBVaWshCnKh+N+E7+fPH/bXoIqmzD59W6Q720xsQ/CKdN7InTe9s55jH6dI7zPWEGr
         NuZ+9vQnPMOx88u2uRFWp4viVI3QLsMZzUTU8R/F96563xfYEIrOwAjR96MjdfgSbx5P
         FVgQ==
X-Gm-Message-State: AOJu0YwMIBAaY+ti8amesZd6l2/Sbp+n1NQO+2X35GZ5iCIe8aGVkInQ
	AbcJQbjitpwc1+3O/I73Pz68HjnA9JEG7NzJkt8eraYIFVVxN6SZ8f2K4tKkT4TlGN8=
X-Gm-Gg: AZuq6aJeTdg76vWTU0cwjDxF77YAwADACYmYAnD+v+LtEoX+/Vaj6naCuDW1PwOST7i
	nP5Dvlsc5X4lsNcKlKyO2ayBQXIcSxuNyf1HnJm0xjb+QcffVaFlOQVxjXFXzN24abrJIAZPyyU
	m+6kgHsL6frktFdEEy6/p9ORdD0F22vQU0lwEbgD9mWBQF3wH8GEX9g3WJBRZ87coVUcZrfx5am
	rn6FjwobWSMXeX1NmXtkDlYV/2mOFIjSbV2hacrIYSozAnC6VmLtOwEUgP62WUBaJjS1Wt3yeSm
	in9MYgETNdXvps9QU/MBs00jDEFou+qQDIlsHTYdafiPqsOoaMM2CHFatx8DOeI2/1eePYFaCJc
	uhvIq3nlPC+UvaIt/Uf9BqOXcyQANUMdYrD6vH1CO5iBe7IIMwv+ER3Td31L0VWxP8mLbL6R9D4
	CpNvjiJGOQAnGuyv25cqF54amhN7YKCvawbpnjpvV/geVWBDFODYwQsYADy1/aFIztNuMG9Q==
X-Received: by 2002:a17:906:7315:b0:b87:3beb:194a with SMTP id a640c23a62f3a-b8edf3821c7mr636202266b.44.1770642000978;
        Mon, 09 Feb 2026 05:00:00 -0800 (PST)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65983ec70fdsm2803040a12.15.2026.02.09.05.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 05:00:00 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Mon, 09 Feb 2026 13:59:47 +0100
Subject: [PATCH v3 3/3] arm64: dts: qcom: milos-fairphone-fp6: Add vibrator
 support
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-aw86938-driver-v3-3-5c79cff30492@fairphone.com>
References: <20260209-aw86938-driver-v3-0-5c79cff30492@fairphone.com>
In-Reply-To: <20260209-aw86938-driver-v3-0-5c79cff30492@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770641998; l=1662;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=qfKnEcsoVX06QZzEM7/4cC6HPLmj8y0sO6sxJasyjlw=;
 b=QxXr159gJrFONiROJ9wYKHa19mSuqT81JhngYRfyHeul0AaTK8uqBUGLCtxIbx1MbGVe6HoKH
 NHsxWObDQzSC8ATsAN9/06hVBTP01Yi4H4W24FkvKbqtft2SEpfbczc
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

