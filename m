Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFA548035F
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396682; cv=none; b=XI1KWZJaaiw8Y0+iSu+eAcrSlc86A1oLz8PuKmNBVZNiBu5CbD+kAWnPxMWkSg4L0bgO5E7F8+IoPeBcH/kvgGb4tIJUQWjWjtgXJNeKEeBkzXdgxFthsqny0yktseOEYfkYv6b9tO+vvpj6sXS5KgctUDOJ47K56pRjNoHYQw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396682; c=relaxed/simple;
	bh=An5kVD+QUS2KRFPqoTzuP3KiyxlNWixnd0SrSGxYc80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XSH1xE/TgJU3A9FI3wMEU3etIxA1VNq61MUmXhckRrR+s5KH/Y+xpt/R/yKkETvCho4pCeRXG0ntci5y+T9JzqmbPgPjZgNfWEyshuMsBa4/TeR/H22OfaYW/IThk9h+HjtMk9cRt9VYB8FDpIxniQH4LXLu0rPj6zGtG9z+pXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=tOhblX1H; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="tOhblX1H"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c25ef7a3ce9so256152566b.3
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1789396678; x=1790001478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g8LfNC9HXmpFwQ3HeSQNxdEPD6YaISqvodeZzu0yt/c=;
        b=tOhblX1HbQWKzAbGVxfCQOKLCcponVlAb5+wv3zW7icjHVLMjLY5y+zpaVX43texjG
         P4N/vm0WysYAn406Hr1A7j2tMt77H/PPcXiWtry8n2DQgknKKABgfyjOfKHtSaB6+U/a
         N4/a0Tot2sdqt3eG39Ddt+dzjD37EqeXxuvurBVH67+yHv0VVcK3ArItDkCTW5B+umGY
         lp/aidzMO/D/AuVjpqBadygLkpYR7BQq05Cp/7Vw29uecbeJB2qoWFkUl15LYrfHtlzx
         SFdDUav+oOO+BL+MFeXbWqeKv1cch89a7rg432aoIj5up85VXxkdiAd7ykOAUfhAdz4E
         gWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789396678; x=1790001478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g8LfNC9HXmpFwQ3HeSQNxdEPD6YaISqvodeZzu0yt/c=;
        b=JTpSuLch6eXlrAExk5H9WlRFyebWvg/vyU6XmAQPh2ZvwwG1MJsgPll5CJUHJ8iwIk
         fUYPbleUu4U0spEMQuV3/YKQIM6vgG0fV0kyROAqRRXz5dkX1/zt3JhT78JcFFHHM+o9
         ki24jRR1iqktMt3XMMqWW/kCwyMRM2QLIpxHZtPW3OWv8mYZeTEED/yYqxfnWU896oWT
         8Bqo39ccc4aJxAHZR0T1LZQh7zYwZSmVbhNlw0fVlVAPr3ZuJgoiZE6vZ1AaH4iyera7
         6ndckvmohG0GMeL71yw92D5xZD7ubuDR/4XrLJ6NdPJ4yO6fEkV5l446Z/nKWunOLt5E
         lLJw==
X-Gm-Message-State: AFuF++lIx6HepWN8+KKEpK9/FRdV1wyezUI7ipgX8R2AicXNlmma07EN
	uiBXP7HIAqjJHRrLlaDyr7YVP8WQXJzM0DAuNxh4d1lwraheDsX2WVbFMBEPT4And10=
X-Gm-Gg: AYBFou0/Im5xEsquyoQTqtIp6rryIlv/43TuN4+WoLdCvJESmdAS6nsYMIbXdKzJn5q
	5VT3qTiDjggct/WMbjFnRTLxud0Xn275qoGBGO5qoLd5SqKpTsxJ9tdzby5y/T5IyZlkaxynOUa
	GqeohfGiqE1KIo7YwTDFAsf7uwSJ+zQ/Qs7tGVc8nXPJtZsSOXXbhESudeXQ1Svvlh4crkzHora
	uIJbhfLgsaJTnX2pVEA2ptxZdoLXKZ0XegFGBjmHdDEObQXkjZSOmCF7RON8zaIhZzzhjjaSynn
	cdByasdjRcmP2NhPtNmc023XHboUDJAEWj7Be6zuXf22lQ+wJVPIwEvj2ioMKCPS/z0NlPvbjxq
	vy2HZBFicCChzGO5aF1jZxgsxFOn0PNA/reVMFgdkE4va3PDFA1+B3iisTbAarINF5UehV9t47r
	qpUs83kj+7p6l8UkOiZLP1vsEcHC5NfH99xTQhCkqXZ4gyF+/zOfu3UmNouDdmEirEXwYuxpEQe
	7RGRFLK2nNl96fUH9By7dtmeq64jKqdhcXi11kMBR/FDgYBm3b/6ug8kJx+Mfxwzh6v
X-Received: by 2002:a17:907:d19:b0:c29:5340:182e with SMTP id a640c23a62f3a-c29b84d2b89mr181142266b.2.1789396678031;
        Mon, 14 Sep 2026 07:37:58 -0700 (PDT)
Received: from [172.16.220.224] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29660b29a7sm449634266b.43.2026.09.14.07.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:37:57 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Mon, 14 Sep 2026 16:37:49 +0200
Subject: [PATCH 3/3] arm64: dts: qcom: sm7225-fairphone-fp4: Add AW8695
 haptics
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-aw8695_haptic_fp4_driver-v1-3-156f7549149a@fairphone.com>
References: <20260914-aw8695_haptic_fp4_driver-v1-0-156f7549149a@fairphone.com>
In-Reply-To: <20260914-aw8695_haptic_fp4_driver-v1-0-156f7549149a@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789396675; l=1538;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=fEJxwk1bbs1F94cymqRXVbWtKaMJcVnL63UV2RvymTM=;
 b=pX9xn5+XqtBfjlYTYtS6dF5s9O1svEi9nf7O+5BRvhnBYR1PYcmL023f/AwzJ4KXl32012Grz
 eiDmUOn79YVBSgQHaBsK6xqF7gFbhw75sh1WUvishlk6BeGR5fp0vUd
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

From: Luca Weiss <luca.weiss@fairphone.com>

Add a node for the haptics driver found on the phone.

Co-developed-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 26 ++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index 23f950067a08b5ac4f7f9f61cbe060fa00b9f485..8a55a1d3426bce699a076e75b948b3def698fc36 100644
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
+		bias-pull-down;
+	};
 };
 
 &uart1 {

-- 
2.43.0

