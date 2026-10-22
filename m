Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660762;
	b=TzAhRk6rWoQyxzL1LrXPvDpkpVIW9oug3ZIJM+9eyDcXEdf64Gr6DEVgSqvCT8U/hH4t
	 9tcsNyNtwufplbrVewELnyxSZFkc3LO1De0DxpLzpoU3BE0kVvd5LhmhIYyypUsiCBhto
	 JzeC73VtDEFLaMzY5g0YQUYbBK0mPjuLNXGMQA4IBwc1zpkmq0CrR2l64PhXu24JRmWZ1
	 1R8WI+NONrUk9l+28SJHYlqtEor74Yds9+IG2kEqbV7AgSU4pOEAnGSekuW4kjmQpkCYT
	 cVqTA893MPEZxLL+dnRLmp/Sc2mG9vI6N9du2q52BrFMFGOSTZkumWjUsKdmszK0n3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=hAMNTPK/AYw6mgKrLcGhVsFn803cpE4k/KbZ4nEtqy8=;
	b=LxJXzuUJZMKmliYULkJPu6fIOPCmtxk+01nDA33VXSfU0Rn144o6Q0zkQw9/Y2018K2V
	 sdabCsafeHgOfPmH2LdAW9dnKwwHBBhkdNdgQ+F+TEY0UqAIpZaNBaZj9L9eR7UE89OSM
	 /gD0Ti2Al+eGRn7wS3zCOQubC6AnwVFtP9aop4nYR7hk+w+thFckHLzKpfR8NQz0Xh7Z8
	 LOOBqBg59S+YaoIZvlHS6AP6LHK1rGkfnPVZqpZfDufW8IYWEb8CeNw1S7tZFQilwE40N
	 6QE06eE/KqTCte7jIk7H0/DWThepUeNtoO34vNGIgaanCrYgys6S9EuFg6uN7PLtYLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=gXl5+Gb6;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC3C60A2601
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 09:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCC3C60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=gXl5+Gb6
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6ae14eecc64so2268984a12.1
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 02:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1792660760; x=1793265560; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hAMNTPK/AYw6mgKrLcGhVsFn803cpE4k/KbZ4nEtqy8=;
        b=gXl5+Gb6xohglf6t2PtAn6M8rqT9TTuWwPgMpEtwM+UheIq1KRs8zY7QIDcxht8PzO
         1ZPZM24MgSPYmEEdlvK0bB9tF6GRM3hX8M4hvq3GB62Wf9Hq/BSjbV6k6rm9/oqpqI6+
         QD/pyF1oFgvvojgb2GEt/vc5HSrimYUihuOmfp24y37TXu1kydvHQxL6vb9gtANnAvNW
         xakS433LHUxbj9ne7GTnnkWXBBRj0mfV9/oSDK3v1XmBBlPsUEgzsLX+NgA23e+vDL80
         aCT4sMlH6auzjfpbhbY/VyDrvvDEth0whQcVz0H7zvh/+CvkNcpd8+MMIrL51M8uuflz
         7apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660760; x=1793265560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hAMNTPK/AYw6mgKrLcGhVsFn803cpE4k/KbZ4nEtqy8=;
        b=0LHeeJXUDKfYuflYPyuqT4+fTfMN5ujZyv0uEXATEP+F2idd03koZSQdYuuySGVpqL
         Mr6R+JaHZ3p+Unk9Ik2mAizR+az+AKnD6tahId/mR4Gr8NqTzOY3RnSKMtLxlsxudQPO
         SQpt+SH9zWlGav7Bey6Q81QqQqnnTxvWxyRcbxSyMMFvoenQpis5gij+x3Ee7ZWWQgyn
         CHngYAuL3M+FfKHoi+MNVQ3VkfXQ7IlYs/ZUldPaOm7Kj/Nzv3sTbS3l6Gr1RDV64giz
         e7FvnpBJiDOvXQKWOHCk7QbSas0V8vnv47GB6FEHsGKg8sWO6qhq/ioKUIgyiANx6iE7
         pwwg==
X-Gm-Message-State: AFq9FYJGd5z/vTyX/PoX3vWFvqBBUG2Jr72NGNJ5nx0+8GD52DUNZy+N
	mXry12zwk/CnxCf9BPfG7W+md7D6KLcW/pSUnXHiypk00t23smrqepcjUSVFOjOaBKv0GUPe1lV
	SKQDs4LM=
X-Gm-Gg: AYBFou1DPFIUJJN1zLyQZV7BAs9sb9RTe+WbIur7LzU0XylJPI5m/osc5H/skv3P6J2
	ugNqjrwTo96lmPz7mfRRr1hO76M3o2aMBTGGy1l2o7vshJS3+XZoNBq6y26dLwB/hIk83eplGBH
	9DKN9sOKaOU7xgYXvsgLFcdjJPHXulmn5S1eavwnS3xzHdTh/gsLdovwIp6Uko7pOU/n3N2CT1G
	BVVSeIZ4LCN9oMgHfxi5na1jVTunXlQwhlcPhcucdNpa2WalNwkqR1T81e604JrFbv9FSIypXDb
	aGJqrvhtEeSzalhprDr3pjfNDh+OnCiPh/1HD+jHLMpBJYg8VKhZpV/uvfQMqDM4vOE6qmNFLIa
	t5XurNmGFJ/5EMcDTf4wiyaYH62y7NxaFmkdwgv7y2VSIXazWcFEgMiwVKRNywcT7UqVWRQw30g
	a74l6TZ1fdsd7umKord6HFksaTuuK1iIvqGm4borgUNvYE3tdpA7HF7OBXwaUy1v5mdcZP7G7J3
	SMZULBR/qNfHbHFr9yon6GcJiPwRW8sNuLQujFor3vB7Sajaa40jzaRRJ7ee7g6CeURUnglMaAj
	2FKXV9SSZuEjxarFgcbNEniA3is09PsUTX9yUM5vP+z5qZ79VANO2sVU+Zi2x3CTjm1sJOFVsCV
	9+KCPxdyQbCO2LnErm1xwgLj9nCrGKcxdpH5TiVOY4AO1VmWK66zySDgZiMDAsTIvmEyV
X-Received: by 2002:a17:907:c608:10b0:c46:8c16:a656 with SMTP id a640c23a62f3a-c468c260476mr152082566b.18.1792660760257;
        Thu, 22 Oct 2026 02:19:20 -0700 (PDT)
Received: from 2001-1c08-080f-fd00-57f9-c36c-aa93-fd36.cable.dynamic.v6.ziggo.nl (2001-1c08-080f-fd00-6fe5-b143-671a-f202.cable.dynamic.v6.ziggo.nl. [2001:1c08:80f:fd00:6fe5:b143:671a:f202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a50aa01sm85790866b.22.2026.10.22.02.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:19:19 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 22 Oct 2026 11:19:17 +0200
Subject: [PATCH v3 3/4] arm64: dts: qcom: sm7225-fairphone-fp4: Add AW8695
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
Message-Id: <20261022-aw8695_haptic_fp4_driver-v3-3-ac8c14377e82@fairphone.com>
References: <20261022-aw8695_haptic_fp4_driver-v3-0-ac8c14377e82@fairphone.com>
In-Reply-To: <20261022-aw8695_haptic_fp4_driver-v3-0-ac8c14377e82@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792660757; l=1650;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=aA+iGNmAXb9ktbwAU0KbUX7yr+F4w/IPZJ4vFwuykl4=;
 b=7+N8AToHLH9xdV3tCOOMykHgHkC/SjnCyxhXQF5Xbwj8wB5CmBkIGumo/1wSKGWDi0IkaKEly
 nKKRh8WkrzOCBsnRZcvh+pPmdQcgLeB6bDtrGICgzm2J/XqZ0xXceoc
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

