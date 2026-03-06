Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECC135B12B
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793674; cv=none; b=o0XoVaVEzczXGiKAu7Zswq7ADKLpTmPox7C0IDfXGAhusrSVr+/nwH2fjDBygDTQri7jSWeS3hhMZc2tVoYLDyfnaIiE1wbkb/KnWDe1MRxlfBaOlRHQjDquuZqspcO/xvoC5n+JZ8LJrDDUFfN38eawAN8xX/igDUs5ijJbNv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793674; c=relaxed/simple;
	bh=wPZiFdqCiDOOFye8FKOQoufL7cyIaxgiXa67+xHsn0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeNmctGkwvX3zb0ALkAp7mfXqHXqZehBwWSpMCJj7G7oVLsKtVwffuLDGDfjt27VRp55MvEbjLViks2SeTlGritn4Zn79+mkbKl0xWfsQEQad65EorvOLeiKVu5g8XjXK7I4nZEF8uYeK2cgVbor5f+xJJrIMh+f0cMe9Kf1vkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cg+h5f9o; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cg+h5f9o"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ab39b111b9so42602285ad.1
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2026 02:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772793672; x=1773398472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkTY0vM9EzW6XUSGNuKIJpMIFfDu1qpzZf7r+qP4u6M=;
        b=cg+h5f9oKbyf0fsdPUspoF/BDaA6nqPOX86U4ECGVQP9hJMuAvd8kdqlAbljG/rV5y
         SQIHlOqFlnrXIvVQKmbqCkT787dO81tjTS9YeJ6Rqn9fUU6uET64T8S8EYZv7SUP2Y9+
         xUOG3G1Eeggivm8oYVG7jlRbhCGVR85BRWkp9Q3rWkUueqH+wkxkWiK8icJFDRv7Kh9X
         jIDbH8ln+yaRIZ2qmOBWQaaaEWJTuuMdRtXMWaJmpVEHF/+zuYvm4UtTgf4rPW+Je2iv
         CTPBkLCvROhhe11RJPQP4e8C77T3Vw4mnP8bJCX3sQlIImTgbt+67YVeMhOljDDHzzBu
         ap0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772793672; x=1773398472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HkTY0vM9EzW6XUSGNuKIJpMIFfDu1qpzZf7r+qP4u6M=;
        b=keiuM+Y3K7djYKPNFA7btrxZkWcPHNfdqiR64AXABjhIUZR8383BnylRMASHpv79n5
         jMAQ2kcZCzz5uOD/9gjeUj2lO5Vfn0+23UC5VgSUSZzTbBkGwci/XEBKifkeaYzchuUx
         omvaSGs3MsE/LVtroOD68GctPH/NBHamZgTJn3C0ukRv+wGjl8e/U14RS05uKjjo6vCz
         HSQe5wx64FFAK2Ro2zJ7BEDemkIabPFyNedq0t6iRV7dMKxesMePDoKN4zuPjnWkDc3o
         atIjkl3aaANL4k5WMOKBSDdDLlSLGLMCGJCLFbkNQ/XZxqD26zdHrwVLfCbekkdr6p9B
         Skzg==
X-Forwarded-Encrypted: i=1; AJvYcCXZC9KpVoiAxliu7zrX4rUcYbe0v5txZh8hyOy971e7xXb+5axQ7oMnh+iH9IMhGVjhOije6IQfJy99CA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFBaGBy/6MA9iebGctOYp+nmyjRXgbMamFp05cuHFZikkmDTcu
	UzWtCXeakpATasd1nKo5wPOalU05OI68exqRwDinVQYYPNSnlORUigMN
X-Gm-Gg: ATEYQzxjffLZk+/hcQ/J+zfLwwYUVEBnS7czcKFyN3/S2QrTSDrxmVgQcaa/5cu1WCT
	QTg+dzo5thNqeWlkC3B2jpVL21Fuv94RBUUvoWmE64N62caP2xagDwwZ2smzJTQM7V1PevhjQI1
	H+ZiHqxusas1s63ytUH+eWWHqFFabYjqoXlpxZ/o0UbjF3yoxAvCvrlB4/lrkSFwEvK/0ajsB/4
	ZeuzPVs5s/e/jI0f6//kb3Ny+PxzoPfiNVJT4S/raMoBLYdPQQuGrGjrFodTdnXQoeCaavE81G4
	Ql8tDorfARYwSJuUKf+aHjgFwA3EAKsuqpN57QzSBFt8Brl/2/uX8I2QfbztFWi+Vi8rQJXShha
	54YSKHSvubuoNHyS0XBaxq4DP7v3eLGgiGdoGDF3HCLg16h8I87TM633KzDOpfgwbvLs4njGBgn
	Bn/v6006z+OE3vFJqCEaDVuy5dKsIrpqCcu6cTTLN0yPRrJek62FOXkliN8FTb//dzU0VW
X-Received: by 2002:a17:903:985:b0:2ae:8293:74ee with SMTP id d9443c01a7336-2ae8293797emr18095625ad.48.1772793672405;
        Fri, 06 Mar 2026 02:41:12 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83fa2fa5sm16107775ad.70.2026.03.06.02.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 02:41:12 -0800 (PST)
From: phucduc.bui@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jeff LaBundy <jeff@labundy.com>,
	Bastian Hecht <hechtb@gmail.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 2/3] arm: dts: renesas: r8a7740-armadillo800eva: Add wakeup-source to st1232
Date: Fri,  6 Mar 2026 17:40:24 +0700
Message-ID: <20260306104025.43970-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306104025.43970-1-phucduc.bui@gmail.com>
References: <20260305113512.227269-1-phucduc.bui@gmail.com>
 <20260306104025.43970-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Add the wakeup-source property to the ST1232 touchscreen node
in the device tree so that the touchscreen interrupt can wake
the system from suspend when the panel is touched.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts
index 04d24b6d8056..d47a6cc3e756 100644
--- a/arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts
@@ -228,6 +228,7 @@ touchscreen@55 {
 		pinctrl-0 = <&st1232_pins>;
 		pinctrl-names = "default";
 		gpios = <&pfc 166 GPIO_ACTIVE_LOW>;
+		wakeup-source;
 	};
 };
 
-- 
2.43.0

