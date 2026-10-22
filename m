Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660763;
	b=gT3covJWwD8+I84rItK82ZBnSpIzjWtNkZuwrNzGlXQckjnjTS4sqUE2mw5WVEki1i00
	 /R3stwlG5pZ2IddLUta7poag12ml4PstCY2KEJUJRqjoSavjLzFCh8ueSD350kuicnf1B
	 Cn1r+enWf5rZK//DgXJesPcZ8Mlm/vOSNxXrn7n0ORwCIdYhk7/7iqXJRnM9wbvt6GQLl
	 Ia5WUEqV+XyD8Zp3me1OtNmOsDTb6Adlvaa7S/pz1JSvMcD3GF8JkENV62lICGkUz2JkX
	 krZTOJv6qiggOBHabwD99c5GVbEWSGxiHgM2rfcfo0h5jWzzEJLwwJEGTGspsibkHBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=UH4FeDzPCNNR2s+JvuKV7mYVmUzbbIHkggk2wlVeLXo=;
	b=WR6s4u/0wBpd9o7jezZ09r9CPfY4WVkSH4g0b++IMZ8izrxoBCgqXoUmAYYQK+3ebYV+
	 M9wnOuK6hE89xYUAZQXaTcE+ui00KjvwbcIpD0ZnaRMBaNPqUeUBXNlDgeZLO91P84EdE
	 LXlVC6aWHxIJhYN/B5g+c19Kg5rXs2RVpjRAP37nw6SHc/xe6HFph/i+94bhfgpOd12Ap
	 WCWpAGC++16hH3wFNvec6GtIW5WDhXaLdvy+e8qC5XAKwAbRgVvEJzgyK8TqK6oKG0nsb
	 qz1ktrqaaLzOFUfcfW9sZqiT4WOPBNClDbq/16Iz+nZ5gHH77TQu6/MaZKceaFAJ3Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=GLqS2jxP;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC9F60A2606
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 09:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FC9F60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=GLqS2jxP
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c445c95d553so209453766b.1
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 02:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1792660761; x=1793265561; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UH4FeDzPCNNR2s+JvuKV7mYVmUzbbIHkggk2wlVeLXo=;
        b=GLqS2jxPj592NSbnpzPb3btzVGgCkLlIqc2/z7sbSOnfobGOCMPB8gzQsJX7Yqfg43
         6Wmitb2SYy20M51IJ2RxNzAyLYyJG8a/inWV2I2vjrxkOfbceXzBKX1tbhGzq4luXZSW
         hkKAHhUplOKV7QXrGiTrKD/HZvQsw0TjMzrk2Nyk2H3fP19rvg2zstpImhy+i42vkxIQ
         maiv4olGWTyT7H4CCb6ExlCxY+W/5GdhZeOsGaSU8N/hRAfBQJf8/pfw/ge2J+f6rAdu
         GP4iBpkz+V4clHyvYWFuqItfblDI4QNEdCR5h6Wm5SiEZPoNUv8vZuR2bMmiqMbY7TUI
         hqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660761; x=1793265561;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UH4FeDzPCNNR2s+JvuKV7mYVmUzbbIHkggk2wlVeLXo=;
        b=AE8YyEWVXQNFhF9avdrq1zbTDOwVaILKl/6IAdPqo8dB2L5mdHzlTj+KmfWPQ8ToQa
         jDNlFfY8hLvlRQKvwt72kMVt7dxIyg1DqdstSXlXfmerdv5QYUfI5XGT3bT4+rymbipJ
         SdpYgDvbKCB3c0iscPiBAFUhB1oTX+cvuseCaKIHXD5X/wtQxBPPW+/WDmYETxeBDNb6
         rhtQo4OXaypPQlUSsMgZgy34d0mg+w3okdV8p39yu63EfOmZUnmwJlLazNj/iFx5lSOB
         +cdXCO6xw/vtGr8nVA66xpNxuBwygrER+yI4z662Ry5/mZ5mrGU2rA3MTNB/l+U6Caub
         IJtQ==
X-Gm-Message-State: AFq9FYLNVetUVxtwdfHuhkPoMiswTXHzGP92M7kqWSAHrGhsMTw9eL0H
	8cXgxBOsvfM0mbsKx84UAIzH8HQdMq5TPMuU7DEDZ+1dg6xSQouy4UUQQUq+Tr+egbE=
X-Gm-Gg: AYBFou3fPSltn/VsvumQUF7S9dxw0Ud1pYh3EUnfv65P5pvGDlDOKDP0ZiWfkIUVw/n
	XEBoBKLp2A506J6XzO2bHrf6vpFSCfv895G8G6C66HwQ/EGdAKLfthJjJfTS9AeHNGVH8TFQ1/b
	CRNWqIXyTpS9+ulxc6/PHBFoS8fcWvRT2Nd6JReCYUrYwykBpmSR+hJ1+I9E/0t7BIbXbebk1H0
	1czoEKKh1XXmwtDEDBMWqtGBwstpKlnCqMfYTvhrMt9y2uH+H0n3Z8+VHOlTXTl7PCmhkI9RyDV
	QAScl5zASZc4npfBVWL5ijNm4tka4cP4dCxIVqFYWvQyzsHZDehScTggfffP1obDUcTxSIun8/x
	XlOErwOOLMVPPtsRapluUjLj/F9ezVudf5GMWkNKwP1BHBMtuL1DH2VvX8IiJIG06A7EEcIRFwk
	d83R8DrlU41JZF1758wJoqm/YlUGVl8wJvE4fpcxloJPj9eVC8zMD/lZtx4RYxD8Y65nDB5SjLy
	3otJXKd/WBlQxcqbltmsuGuS62fSqduAMtzM/Lzz7nEB8gEo3iW7T9wsknunyg/Mcr+0OS+TYlz
	YrI6+I6k49iMW0gwQYCOTWSUXnEbfNhTCyTY77cw3DTd7DqyiikHC3JK8jqMjaMBo2U8iuGE/Fb
	Prn6KZgmDiGUqqqClk8eUj14s643/Le79jvZ1JONQFp+4Tv1lOPHomz3AHHTfS4gw7oGI
X-Received: by 2002:a17:907:969f:b0:c42:24ea:3220 with SMTP id a640c23a62f3a-c467970e3b6mr441406766b.31.1792660760888;
        Thu, 22 Oct 2026 02:19:20 -0700 (PDT)
Received: from 2001-1c08-080f-fd00-57f9-c36c-aa93-fd36.cable.dynamic.v6.ziggo.nl (2001-1c08-080f-fd00-6fe5-b143-671a-f202.cable.dynamic.v6.ziggo.nl. [2001:1c08:80f:fd00:6fe5:b143:671a:f202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a50aa01sm85790866b.22.2026.10.22.02.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:19:20 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 22 Oct 2026 11:19:18 +0200
Subject: [PATCH v3 4/4] MAINTAINERS: add entry for AWINIC haptic driver
 family
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
Message-Id: <20261022-aw8695_haptic_fp4_driver-v3-4-ac8c14377e82@fairphone.com>
References: <20261022-aw8695_haptic_fp4_driver-v3-0-ac8c14377e82@fairphone.com>
In-Reply-To: <20261022-aw8695_haptic_fp4_driver-v3-0-ac8c14377e82@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792660757; l=880;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=pi2nL8kvBYr8FUFdGc6j29pfQDAldTc7iyEJBmQFvzs=;
 b=ozZpMWob2iUFdSZSQQRasTmd+MG2lGCrchPwltTq2tgohqewvze837ywdzkHno0JEnexC4HzP
 6KXAChSxZbOCovVdvHsD4hokJQTcLOOgtPYbLKKhap7193bDvVHJyRX
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

There was never an entry added for the AW86927 driver, I will take
responsibility for my creation and maintain it alongside the other
drivers in its family.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f53047aa8d3c103edaab227e7a21e50f6d9fd733..5b5792bfd58b9b4971bdd8471cb832068f8aec16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4419,6 +4419,12 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/pci/hws/
 
+AWINIC HAPTIC DRIVERS
+M:	Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/awinic,aw86927.yaml
+F:	drivers/input/misc/aw869*.c
+
 AWINIC AW99706 WLED BACKLIGHT DRIVER
 M:	Junjie Cao <junjie.cao@linux.dev>
 S:	Maintained

-- 
2.43.0

