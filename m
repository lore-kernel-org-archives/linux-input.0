Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A8B30F805
	for <linux-input@vger.kernel.org>; Wed, 28 Jan 2026 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615489; cv=none; b=n3ZEXbybe/Kjv+OnxFSzsDnWds+vYCgnLtuymHIJA4iwUf/R0hyXUF/4N5opP1bpEYzhYYGhoIHNZbY6sJCoLuDJ2rKKz2YfxpTCltVS3hk2YprVhbZ3chDytKjb3tAYcwnu7RXPlpQ4RmqgZcdESnv5VbM69OKheUVBPSc08LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615489; c=relaxed/simple;
	bh=OE8Va/qqR+Kr9++NQoSw36y7Yx+kr2GMJCERdWsWQhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CXmAQ7pmK1nVUWgj32UgtNAdaCUPIqxCqWL/TPtWPwU4tbS8jQupDPv2QhaHsPuGWo+zKBRKaPQ4SkI/mGBnbMKwy3hMFoXOzYS18mzBGGI0bIWvdp6dDCEO+We2lSaUE1Ev2DzM5Z0hQy8ewDDH77dKpbSDI03kiVRk9Pu82vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=vsnzKvfe; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="vsnzKvfe"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65814266b08so13637a12.3
        for <linux-input@vger.kernel.org>; Wed, 28 Jan 2026 07:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1769615486; x=1770220286; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldPtKD6ix4w1Qcpvj9OyKIUSGU8VGaicrJuthvpMMWY=;
        b=vsnzKvfeipDs/3LNEQeXGg/I+GFFNnEYs9twFxa/7y2s5shimLQA7sWI0b3PZT0jZP
         0tN+tRIxyLZJ93uCxwll43a9pcdlvJfLZPDYX9RH2C83IgaXXvyxvfQ9LMiIH2YBG1Uq
         uDw2xx1PBcF6KMoi0aQRyD8yKUtuFqCZU5QSPQlsjl0bGG0ALOP0oVFaJlJ8IcnY/0Tb
         pqO05/McLlBQxofqiw1ypOVEI6vLvxrFnOt8/IFUfqg6/DKjCtoAJY8cOAtINrbcxjxT
         vJFA4ODRaSEn7z+EaOC1qC0n1Ww+EVyrKy/zSgf4a4nIH94q8yYTw2Hxtcu79Nvtx/xL
         ZjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769615486; x=1770220286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ldPtKD6ix4w1Qcpvj9OyKIUSGU8VGaicrJuthvpMMWY=;
        b=wULFHwEsHDGQ4UjXpK5LJTvrywI4TGTCWFQ2sdAu787oRjthkjeSbIlr2SmHz4evsl
         HQtqnN7i3XKF/sEcf0GJn/8YwqRcSaKr1bmD4hgSfCohmQa6pHOeD9qsXF1HgNWfDA29
         0EUT0XWV3DVshZiQk1BIihipKgPD+0W+dbwifOGMx62GcFjbLnEPQo3tWwbQs/Z2wocs
         TaYCBF9jcroKrpBmHtNYfnq7adL9gycfwoaqf5iHpcj0jzdSvb03gpp+SWBe/+ujEDFI
         ccVtC+/TTCZzdDKw70e/0a0TZIhQDukDlOHfYQz8UHbKPplB3/eiBfF0y1cRXF5oVB5e
         FpdA==
X-Gm-Message-State: AOJu0YxTyqC3N3OKthbcx8Ma1QgHQwijul4iZK/7TbcWCoQj+Ld3Qxfc
	PDp59SOp1IHQGv3jlMHHkU1b2yk2sXynaIXjKMwhQT0X0rs4Po3G6cv3UGWh4/mQbeo=
X-Gm-Gg: AZuq6aJWYvMNBNjpo89vDC/VD2ZrpHAMv9kTq5BWgiq0IWhBonQYaV0SCuTqIJGI8+t
	1dXghlo9dFd64NsSIFZ93wP9R/8eyxmfEhF4QbMBaLTrKHZNgqnSdXVP31A7ZTg48V1LastIz6o
	1BPAwxlO1Gv6dmJVMnz9l4THkVxWM4FQ/qaVGAheIKHV+//j5pUMUXlhX4QRIHwkXxM30HvisLe
	mwRF2rl0hdURyPNh7kV75OCSvbCBSA/81Ls8DBszG6xFdVIJ7E6biVv05SVZviP2WQ2k8AydbGA
	laB66Bgn3wHrsbbfoWBT87UHlLyUqx5Kl1+/q5SzCWbx5ctWzBcQA3XhU1rz2OR8ETuQB6NBwwE
	Kj4oe6q0bO89Mdv1LaJ88COP8BDzKVY9rBtg+YMeCrrDlZO+0c3pj7r46NS7fTyaBRSxMGv9v9I
	R1PbvaOIKQ8/kKBx4Eq1CSpIB23KHobPRnIR3EfluXw0hMwDk0g8QXf3akcFRbuoScgECd
X-Received: by 2002:a50:9ea4:0:b0:658:b535:77d0 with SMTP id 4fb4d7f45d1cf-658b5357977mr1666850a12.34.1769615485687;
        Wed, 28 Jan 2026 07:51:25 -0800 (PST)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b469eb9fsm1727223a12.28.2026.01.28.07.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 07:51:25 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Wed, 28 Jan 2026 16:51:15 +0100
Subject: [PATCH v2 3/3] arm64: dts: qcom: milos-fairphone-fp6: Add vibrator
 support
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-aw86938-driver-v2-3-b51ee086aaf5@fairphone.com>
References: <20260128-aw86938-driver-v2-0-b51ee086aaf5@fairphone.com>
In-Reply-To: <20260128-aw86938-driver-v2-0-b51ee086aaf5@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769615481; l=1330;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=OE8Va/qqR+Kr9++NQoSw36y7Yx+kr2GMJCERdWsWQhs=;
 b=Wz7Wn2eegKWPudoKWK1GhVW4YccbSOgvk4e0Jityiqj7256/xXYqOuzhC7BGfZAfeQIJS/F3J
 6D3dn6u2AeRCVapUoogJ0y2zRUgD/TTfO8LUsgp4hnETv+rC8Gs/Wrs
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add the required node for haptic playback (Awinic AW86938)

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
index 52895dd9e4fa117aef6822df230ebf644e5f02ba..881239d22fa97685206d1fa3a70723c5b77a339c 100644
--- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
+++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
@@ -625,7 +625,17 @@ vreg_l7p: ldo7 {
 	};
 
 	/* VL53L3 ToF @ 0x29 */
-	/* AW86938FCR vibrator @ 0x5a */
+
+	vibrator@5a {
+		compatible = "awinic,aw86938";
+		reg = <0x5a>;
+
+		interrupts-extended = <&tlmm 80 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&tlmm 78 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&aw86938_int_default>;
+		pinctrl-names = "default";
+	};
 };
 
 &pm8550vs_c {
@@ -755,6 +765,13 @@ sdc2_card_det_n: sdc2-card-det-state {
 		bias-pull-up;
 	};
 
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

