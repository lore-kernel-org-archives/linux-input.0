Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2061C861D
	for <linux-input@vger.kernel.org>; Sun,  2 Aug 2026 03:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785640582; cv=none; b=CPVK5GMlAlxeB12J9tRBnnrC/KudvEGnflpNZlilItyCVfRnV+2nSopK3GKr2PluPS2OAwsIEnyZ79RCxF5yl7FQ9xBfBkiA6qpDnRPXpMrBnqL7UwhuHnvzW38Xeoqjy73GhJJumuJdQFgoR2cZAhFvEYKVHYMY89QbujutOII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785640582; c=relaxed/simple;
	bh=/XhZ1aVu4At1OajSWcUasRCtEb+jFFura59MTLZj4ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPeW3LLjCTtfHEuIsHnMrshsmNi41sbkAlmLmVltJcbHy64SJM12LllL50K6pRqeX5CdmB5T65YQdNGgUVw74sp6dqN8yzhpHofqC0XKpWEnTE9qUnydnMOLI7VaI/jz+h6Z+eE0wu3fEkvdKzrMytDYbrHjyLVl5tNW5FPQyeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEedcliD; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEedcliD"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so2006456a91.3
        for <linux-input@vger.kernel.org>; Sat, 01 Aug 2026 20:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785640579; x=1786245379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J8kkEhJEL1gBoW9A1iqS1uDrICA5x8rxqvqKjWPtAyE=;
        b=hEedcliDqgeoLbJGWP3yzC73b9KnMLcxpTGF2gLDssGELBoqtHFC+rYLmzyak6llM7
         i4gI2OlnU+5dHwu0wqLvOTo6YT5GQA+FF8jVO1jWR0idfXTh7kna9A1xBRKjVY0o9qKW
         RlyCDoQbjEOjV37TOlWwPFW3bQOdypk4yMiR6cyhxnFKJbSbTFsw1Ro0myILMM9wDjCl
         Z32fgTaEYe4dor3WUR235b9LOaJxEJ7BLE3FcoPIBogWN/t9AeDAl+lfpNk89Iu7v7j7
         NEMNGcSyvKlLPgZxrqqy8sudxqjaypnEy2fTSta9JCOIFXFv5y9jlHqQpsc6Hd6Fy5GH
         6E1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785640579; x=1786245379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J8kkEhJEL1gBoW9A1iqS1uDrICA5x8rxqvqKjWPtAyE=;
        b=ZqDYBSs6WIvYfI/+P9EjnR2/rwem5Fg4Ko9lrse7kK4u+FvG9gj7qM6rnR7SHZfReo
         LUzEO2W4FCuWV/qHQ1RSMv9yjkTqfKoqWFdhnF4NXWZsQkc+E7Y47CJqhPo1jnlVz52K
         fWEXDqNX8lj60lB+LcNQDmUhecRXXkiithpOJSEYEenSNAm3Zx6VIH8WDRJBKbh+h4V3
         RpxmGtDw9WkIYARD88P61EN7GI+ZA4/QwHx5n+084i3WTsqFCbvryZae6vzuxz8VbkyX
         U2PwvR8SRmYvEBtx+GDLJQ8RXr1U+3rJfJgQcyLB6VDNHP70PEcTZbpNyf/i8vQJ5iLz
         1TcQ==
X-Forwarded-Encrypted: i=1; AHgh+RpY6CtLOV1IuyumeZEFMXgS3+FyhkoCSYiZOugP+ICOk3lo/Ogd4MDZP23EQ6vGdkakiGhdHf5ZLRAF2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YywLdsTHbaHCPqM739fNu7+PuRE2Gatrd4sz+ejriA/x3tlYgvT
	ayapTp11Zovk5qdhNn68L6DyAZkWIE2wzp11sZwxF/Z1xqk46p733eJ5
X-Gm-Gg: AR+sD13e7eHl6pfCRIxCIQOqW6qDidBC0aLLtvsOfrCcsN4BNoIH2fD95T6L+KTpbFp
	RXwRa4GAcBq7uVuyP4Ij8QI2AnyFTNdSOx6jvzt047jJPkZLw0sLmpznichQclHxD+IYU4OdLT8
	pPoYTPoLE+wihxhYchaJeFkiwXM5d11nvXu+Ms2Jy2JBOTi/YB6M5t8g+zzrVc2m1ASbeLul5XW
	CGpM+qu39CimKYdfRiesRT1KcG6PtJHIPfIIAB7/TzKcL2bLqIYrYSxT1d41lXbUoraT96rAuP5
	zeIhViRgs8CXg6omsyiw94/fgV7aaixQaeXXrkHwlm3QhYmKr7rRyqwORNTX5foq5uxMbX7QEWe
	mmPa0wXKsqUpWL/+7xaSDCU4oTW+M7YtQZaOEWP2fIv+c/xiwE8rPlNVxfAP9AjoSMhuRima8D5
	M+M5dS+AFgrsRvfst6OdoKLS7+1r8LZtpNFa7+w/hAOScoq0Gzm4hMTjfshhiHMw==
X-Received: by 2002:a17:90b:5746:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-38fbc40e2f2mr4915356a91.6.1785640579288;
        Sat, 01 Aug 2026 20:16:19 -0700 (PDT)
Received: from xiaomibookpro-14 ([149.19.17.31])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4e44bcsm25356701c88.12.2026.08.01.20.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 20:16:18 -0700 (PDT)
From: Zhefu Zhang <a723356@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Zhou <zhoulol888@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhefu Zhang <a723356@gmail.com>
Subject: [PATCH v2] Input: atkbd - skip deactivate for Xiaomi Book Pro 14's internal keyboard
Date: Sun,  2 Aug 2026 15:15:59 +1200
Message-ID: <20260802031559.19701-1-a723356@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801101908.33838-1-a723356@gmail.com>
References: <20260801101908.33838-1-a723356@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The internal keyboard of the Xiaomi Book Pro 14 does not work unless
atkbd skips deactivating it at the end of atkbd_probe().

Using 'i8042.dumbkbd=1' also makes the keyboard work, but then the driver
never writes to the keyboard at all, so the Caps Lock LED is lost. The
atkbd_deactivate_fixup quirk fixes both without a boot parameter.

DMI: XIAOMI Xiaomi Book Pro 14/TM2424, BIOS XMAPT4B0P0909 05/06/2026

Signed-off-by: Zhefu Zhang <a723356@gmail.com>
Reviewed-by: Andrew Zhou <zhoulol888@gmail.com>
---
v2:
- add Andrew's Reviewed-by
- explain why i8042.dumbkbd is not an equivalent fix

Previous: https://lore.kernel.org/all/20260801101908.33838-1-a723356@gmail.com/

 drivers/input/keyboard/atkbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 8cb4dc6fb..6c897282d 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1938,6 +1938,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* Xiaomi Book Pro 14 (TM2424) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "XIAOMI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Xiaomi Book Pro 14"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{ }
 };
 
-- 
2.55.0

