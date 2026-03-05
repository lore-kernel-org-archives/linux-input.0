Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3C3390200
	for <linux-input@vger.kernel.org>; Thu,  5 Mar 2026 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710583; cv=none; b=q3hu2s/JDOmFyAX/Lo74W/ES0VWf8VJxbnWuBg8q4op/dSaJ/N+/mS1Znd8Win6EgjUQ1hdaOF3AnDVwpWWC9nV1Sv6KGgoOtxu4mV/R4JdtNazMKt3C9Ndg1cx2FYTutra2j6C+pLLdEl15w67pSfNvJB19/5n+tVfOjbWtfbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710583; c=relaxed/simple;
	bh=wPZiFdqCiDOOFye8FKOQoufL7cyIaxgiXa67+xHsn0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z99vUD4cbsYEIxTLom5hpzB42NlkladI7pQngKU4a917lg1p3DTRwfB+w6Moh8/eUUdkCOPzNiV0G5UUMqlPclhRUXOmw1q+uTq9TP7B/7D2RHlLegl+IiiJxtMPMc6JedzkC1fczldc843QP4Igs1ZEFshnEmbTIkhy35+SnLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2rjwZ3M; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2rjwZ3M"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c6e1e748dc1so2511093a12.1
        for <linux-input@vger.kernel.org>; Thu, 05 Mar 2026 03:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772710582; x=1773315382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkTY0vM9EzW6XUSGNuKIJpMIFfDu1qpzZf7r+qP4u6M=;
        b=O2rjwZ3MGs8fPGfezZHnivOTuUKLLHmMEUwvSw4LgnsEKa6vcyN404kuUz8Ni2HkIx
         oNkI9VpBBDeI0DdS8NjNhBrr5O7m11D1EFuy/AI7kgvehsqVpK0tR0r2kHAeIJD2TdFL
         ODrmw128TOWi2AV5sE9W3jfGCTgw8gKBPMMm6Nr/o/SwPQ+fW8Si4ROWRUU+VOBCYB0q
         jGgkZVUJ4XFTCQjiiFgV5DvnbdUUeD5RvsyY+aF8vsAZp42onYbBroHphAcyPFZmQInw
         M5XLxHmJs01EtD4SmUPHyPZEwwmqP7xONtxhcDyPqjHt5tREVdwR8IDry9aSTKhVWVCc
         +CSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772710582; x=1773315382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HkTY0vM9EzW6XUSGNuKIJpMIFfDu1qpzZf7r+qP4u6M=;
        b=MWMbjORuo56pzQ8Esh/DHHWiDRvFZwvVVTPi5f5HCuCffLfdCV254ZDwHR3CV1eGDH
         7HyIU95dxuB0Fd1cOA6zJiF+YYk1zCLz2aqBYSATilw/bTHD5lTDlbH/2YqU7H2yeRYB
         q4/GOme7Xp9Wjvh09spjZphYKqtokLjnkgsxUeiq6cB5Lz060I2ZK3IudgUewNTODZ3H
         DDL0WBNW89zjUD3Q+b9W1C13mjmSFaDat4M1yyWhuUHjtXHtTVtu6yyzF1cqN9oPEW64
         zda3PqVohaCeYLEpz7j5C+kSFq3RdJ+tlGwZCmDGZfxR6H6sNPsrZRHtVIpSzjfQaNdd
         tyYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+3svRxJH4UXyYzu19mwcGML/A48OJcKKsYQpG3Axvrs0Ka9jrmBhIPUB62ynSKl3toIHsAjLJLNk9mw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6s3zDkbBsRZPCJazT+StZPO6+JGBd6/TKuoDWmnPvg2SaKy75
	hvLDKyUg8ME4/514MhBRct9+Ou+PwA7QRVZUg/cmsDgBnAflDOsBXtO7
X-Gm-Gg: ATEYQzxlIn+elrk7dmMtMHU+CB3SCmq2gDHy7t0p9DbrdaUuqJFzeM49+H4hT/spjgJ
	/vuknM7icwG6+1LnUagUrvxYA+oo0qp/E4uRc5v9pLgJfTneaHYz6L6FaWk/uXVqbdwLbGngOaR
	IZ0qzufYjtdnE8WQszZ5eokRRQ3/+iIMYzrh8l+7HbDVpT84vU65CtKhUOcrNG9iDV4rVd2IQh+
	H7U8RlstDbHG2l4M3hgM3A8MwSJTW3AtzgKOF9UIG0/j8rn/ali04X2Go1J5yZ7eCXkOzWhzZX3
	iHaLkM3pJcz8PW1Hi+839A5XkD4AN3RJ4hB2qr3NBZmOX0B/fGSBifXq7SiUcxpPyUi46J6KWH9
	0js1nfDI8+6PE3YliCoiEVYMXng5RX+/6D2YGl1FFWydQaRx/U7hYChP5W5JXBL37LV4eqbj1+h
	xko2L6Wt+7wlRJKFaCkP+w9wLvFp7BWYHRcS4J3fdq/6cX52MsflubBuKH4g==
X-Received: by 2002:a17:903:2f8d:b0:2ae:640a:9f2e with SMTP id d9443c01a7336-2ae75bb5d87mr20089695ad.19.1772710581875;
        Thu, 05 Mar 2026 03:36:21 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae5e1699c9sm78796995ad.10.2026.03.05.03.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:36:21 -0800 (PST)
From: phucduc.bui@gmail.com
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com
Cc: javier.carrasco@wolfvision.net,
	hechtb@gmail.com,
	wsa+renesas@sang-engineering.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	phucduc.bui@gmail.com
Subject: [PATCH 2/2] arm: dts: renesas: r8a7740-armadillo800eva: Add wakeup-source to st1232
Date: Thu,  5 Mar 2026 18:35:12 +0700
Message-ID: <20260305113512.227269-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305113512.227269-1-phucduc.bui@gmail.com>
References: <20260305113512.227269-1-phucduc.bui@gmail.com>
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

