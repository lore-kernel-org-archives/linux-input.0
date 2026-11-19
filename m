Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096492;
	b=qlvP+ynoR6PzJWF54IcusS3TYn/VN3GGyiW9wyygH/4gPa+VHNTNRxjaTnb6efLqqf94
	 HkoLFm8i5RNZvaPDH+IixRmcRxvKawSM+5HO2IGQr1Wsps+0LSyYu0EJb4RtrJLbhoB6L
	 hZjEX320D2dEaZAS+rN/8IBx1G6bkhSVx/I8OzPCuR1jYyhEEBxuRsGtd/YQPRIMmXJQh
	 YlYu3SuWYL1ComkyRh4NswUfg0JN+SF2LIMP/VJBIlWAuzh380YlaK0PqfSWge8D28nLz
	 RcCClgJsp7phxf3LQ+edIcW6EGLUSBJOf6urpQZRU2y5Gas/iGpj6Vyt+o4IdI87X/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=hAMNTPK/AYw6mgKrLcGhVsFn803cpE4k/KbZ4nEtqy8=;
	b=vEgbgoydCATf7+hBz5J6g3+S6o1/4jELTn45w9jHLDqWQ3+Vjl8GFv7sxSN2LAxOkqgV
	 0haAa4JCmP1atncaeEDrGjq31mCYb0yeoEdbYOeaMP7QLEFo9ieF9NzzsydqBJIXrpVht
	 P5W0QDQ31VKqr6KlqW3QseIYLCTAR+sN2xN+0WWpLUFUeio1PCotk54iM1rJnBCxWnfwO
	 syrkcAojUYTqURU+e2e3jisd4Lg/p8yXRWtFQRthEUGK8cTRsmJynqpMVag5qL3oV507O
	 KhrjOrHr8CG8GD0ImAP1E9uZaYeY89Hl+y0G+OKAUtHkIVoTnKmqlJXk4RvDrvAVEyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=iStJuBRZ;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA8C606A33B
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 13:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CA8C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=iStJuBRZ
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c445c95d553so319780466b.1
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 05:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1795096490; x=1795701290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hAMNTPK/AYw6mgKrLcGhVsFn803cpE4k/KbZ4nEtqy8=;
        b=iStJuBRZyeko+ck0h2qcp8lblF7jAeJsgGPT171M9fozU1T1YQpeMqvm+yDjdYymjb
         zRRiwjQLu1Yf5ot541+CH0yGBFp+H4KYqVAjNRAF1mZxWSMCVuBN5v52XJ7SyVXH4DjU
         eS11FINq/kc3d9V/bqwxLViXts7mx4ytpoGlJRQPZpctVpWQ+64i0qQH9CpdgMWGnwBo
         HfS4ld5gt8/0FrkxPVRpoVmk6feXZz59G9/bqWNkcJorJ36huAWvC1Xv41G5SN8u9C7o
         ZQ4bX7cTIZHqTmjJeW3DzYIvpZr751R3qU2DgewhZ6Hx/dD3BykZAZhp8NXik+SD/2DA
         Vuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795096490; x=1795701290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hAMNTPK/AYw6mgKrLcGhVsFn803cpE4k/KbZ4nEtqy8=;
        b=IPMurPAbD7C3MOS3Hs2vzXO0R0WrniDHv/Iw5+57a/As/QZT/IPkKLZT5r2oh+Fb9M
         4CXNFvEEMxXwVoCXlWpKIj2N80sQsRc83N1KC1xWKbCWG9JzB6O5iKoNNlEkwD7sDgpu
         GdgdhcNCu+yHHDVXmmDaezlENUjI69Sn2A6CdssFehM92pp0bzXM9Mo7wRenZGwFW/jy
         RJp3DkCFZSAyUy1I5IXb14sqRFnK9+L50TXZZTdcLTk0KxZIWxjBPJZ64JS0HkK7WhDR
         RbdRfxhifWDwf14lMf6kskNsogvMe1bhb1qtCTuhQqZl4zVISyS9HdV+fJVKAF2ugXFr
         x4Iw==
X-Gm-Message-State: APuU4Z93kVquiqv9pdCIuNVvaA53nydl7PjE8pMFp/uE64NUy5UtyTPT
	Pi2L+RRoPzxtZSz0Mr3UPBR5TuH8NZ3k6JkGjxN1V/BPeAvFA5Ev5ajLYEat+mVmQXiIo0z92eA
	IXgv5Ovg=
X-Gm-Gg: AYBFou07EavYrDj3A6DE5D3h8ACd4OLTy9PHcPg2eS7ajeuns2qCsvvSVAIbDHz9dqw
	hSzJaHkF7WzdwcWAGIljxZodr7Udmdt6mG6eaqG67dxGJu4U6dm2Ysv+SnPtz5DeIQhYRVI945p
	zKzjXIJ2rfszwe4z2dTESAnjDNmNRJNC/RqbZDvZxXngkavSPXJboLOjfDUfl6lgSelBhctgf0D
	C1+i9l1HzlP6GUXtn3WrlpnbSXbg/u02BEv37OZ7NsABhuKsJIjdUe2ECwmI+uHwg496biTQ5Dq
	raX9VbhyScxi9z7YIfUsoBzA4rA0EOWYCMhpzV3OA62ZeHpzWYer/fN+8hhLe+ni5qZ6VpYmWu5
	SdizjMe84LZhWFpsew0Jr49wGtFS4UBhWk1Ap+6pDVwf5XTSfk+f1RDzcdczy7wC73sU9Qce11a
	eUTdXwqf0o7jwsb89UZqSw6qgitcURGa7DtOk5SIkWn0DXnw0SW+G6agjGfrgxxxEKpV6ktrfTR
	sDAdue0gRXFZwC4bUw9nquHaZhSu14h6qsSZxcEOwkza8RYQZPrB76q5cUXp7mkbCP159uNxn+u
	p2muoarN1BvBRYlSG0pRBik/vYWCoBg/DQPIiYxIz6xymqdpQsF1CFCj/KQxFcCQ3ES0h8vd/kp
	nAA1rFw/YzQBM
X-Received: by 2002:a17:906:ee85:b0:c50:ea07:80ed with SMTP id a640c23a62f3a-c510e547d86mr560202566b.39.1795096490106;
        Thu, 19 Nov 2026 05:54:50 -0800 (PST)
Received: from [172.16.220.224] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51233c4d02sm106820266b.21.2026.11.19.05.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:54:49 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 19 Nov 2026 14:54:47 +0100
Subject: [PATCH v4 3/4] arm64: dts: qcom: sm7225-fairphone-fp4: Add AW8695
 haptics
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-aw8695_haptic_fp4_driver-v4-3-9d107334bdb2@fairphone.com>
References: <20261119-aw8695_haptic_fp4_driver-v4-0-9d107334bdb2@fairphone.com>
In-Reply-To: <20261119-aw8695_haptic_fp4_driver-v4-0-9d107334bdb2@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795096488; l=1650;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=aA+iGNmAXb9ktbwAU0KbUX7yr+F4w/IPZJ4vFwuykl4=;
 b=r1uAQNYUas2/uOCdwJ/uUDtwQzglg/TNjUIZyy7Tlkl1iSfbdZ6m8DH7MxwWkifuJuXBxpIwr
 HacaBfJyVDmDZ4v5kDX5zKr9vuattUfT8WkjmHynS2j3pd+xDJp3rp8
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

From: Luca Weiss <luca.weiss@fairphone.com>

Add a node for the haptics driver found on the phone.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Co-developed-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 26 ++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index 23f950067a08b5ac4f7f9f61cbe060fa00b9f485..76184027221402e57a569d74749350c1482f5afa 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -707,7 +707,17 @@ vreg_l7p: ldo7 {
 
 	/* PX8618 @ 26 */
 	/* SMB1395 PMIC @ 34 */
-	/* awinic,aw8695 @ 5a */
+
+	haptics@5a {
+		compatible = "awinic,aw8695";
+		reg = <0x5a>;
+
+		interrupts-extended = <&tlmm 85 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&tlmm 90 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&aw8695_int_default>, <&aw8695_reset_default>;
+		pinctrl-names = "default";
+	};
 };
 
 &ipa {
@@ -1178,6 +1188,20 @@ reset-n-pins {
 			bias-disable;
 		};
 	};
+
+	aw8695_int_default: aw8695-int-default-state {
+		pins = "gpio85";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	aw8695_reset_default: aw8695-reset-default-state {
+		pins = "gpio90";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
 };
 
 &uart1 {

-- 
2.43.0

