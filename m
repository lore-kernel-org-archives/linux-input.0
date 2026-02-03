Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D6C30CDB6
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140742; cv=none; b=lYl3Y7vkmnKWwFCoFZaXofq0k1cO62IEqPKmzgOzJGJIUZMrE5pgzA2sfSp7wJxxygjFT0IY0yfahYLwNsbQP9eNvmW1ad81pWQ5RCxFp+Ro8gOV5iUU25seFPHjy6P55OIWaQdUV8rpZ3l+06Nv39+N08tnh/VVlPAe9FbuP+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140742; c=relaxed/simple;
	bh=jysDirCxM9VRNdx+7Si4w9nZh+octhRlQsZ5XOvW/bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SA7BMCUWX9BYtRi5edol87vWYykHL7EgXRZCUXWDPV62yxoic1Y/YxsLutC6+zOeEpiGiNfKF9k5gj/1JIA8UtCflPeA3b6Dqi7XZy+lW2L6aK2fiu0M9Eba0yNJwoJuJ6pd4MypmxoGKyGn9SDc2DTJNHXzIblfMrfC3TIjgUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4A1EQjX; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4A1EQjX"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b87266fdf56so77178966b.2
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2026 09:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770140739; x=1770745539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDKWiaZ02MFYPKM7YM/ZCDrXn2+T9deiZZcFOvrBfsI=;
        b=V4A1EQjXRaeYF1LzTFyrDUbTOZxqrfOj5fmUFwZQqBk7gTrf7RLIbWMPV8qozy63PY
         rlEDGJ6zFEIvxuX6ONKN7eP0fgTvodu/dRnjO2VjMtyOP0nZpnxLEbP6PJzMpSJmK4Lo
         gQ34ES9vwtMNEKnFg+frNwCvxcJNMqZaGgvJIgTZOf2J6zcw9hYkE5U/fnR3l9Sj5I3U
         SYP7Fw2xgMsPyAS5QmP12qkw8+t5Rq1UmiH3nLXepcKwAnNGf/2y9HTLq5vN5s8exlrc
         /rQebKBeCZx7TOLJ6BLE6rcewFfFt2fEeOfeH4Hzc6uBI2Skk9NZ6ndJBElsjFmIdaED
         UsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770140739; x=1770745539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eDKWiaZ02MFYPKM7YM/ZCDrXn2+T9deiZZcFOvrBfsI=;
        b=AxI2mpOwqh7ga9HQf4B34VUsIPy6KQLSXP3OB7N481l1ogqC1IjrV9zZVZjdQEtpEa
         EJWLCL8bcqXhfsPBKTHSRBtdWN2wbP2S8Xh28EtzA74mykctD72yRRcG46F8Ofo8qGVQ
         ls0Ee644TJ6LuTgajV0mEtq35nCTyKo/oIG7Uwr/dWhw37eNvSED/cCTXItqixQeASGd
         C3+xW8aie4YrQdQwBqB//tTVWxVNnezUVWffABAVzQBhOG1ybSvyAmsJjbPeB1lVDirO
         wJTUcvstzFpuYTPpfDwyV7ovjvqnpD6C3I2aHTNRaYih344q2tBRNgeru+VLsBk82wD6
         CNxg==
X-Forwarded-Encrypted: i=1; AJvYcCXv85jFKsoK4Hqke8RHgqGrQShmgLgPRvgHhyO4prUhKpeEDUfGTG9hYo2fWSx1hzxiAa4d7Ftf6QYmoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJHYRhIb7ef8qcYFG+e4r/vyoSl8bIYKkRyw/DsAOoOnw9OgUi
	AhVcBQwKrga4UkL1yvXy8mo5OEA0DLHcmqrLkNHNcn+ZqXdpbuuC9qxT
X-Gm-Gg: AZuq6aLCUXgLgvZ8Di09GiAN6l3Wxg3Zea5tJVXc2PCzDTC/R52OpDjgeeW9vMp4WD4
	842yZ/SB8KGoIzbevqSApIAMxR2E+Mflr3mvX2l+0ujG5XvWu+YULguxN/xpM6zEqg0/xXEPiSI
	HaKeCPzINwmmOyM6R8ecMZYzg+zdaBSusCL+WdyFoJ7we/8OUYjv+ugfb75yGQ8j8F6hcmb+S7g
	HaR/ZJVOM217aLb3IGCZlftloMXe+Uprhb7NI+qOgeiuWgudhEL8lh+ATSWi34vIdJXHrGZN0M9
	1VbwWxPwHhvtPe0QhWXIPZ5I/ERczH65M/tQvsEiIFfD54pP7PqJU/16zFRcsX7KYH2wHv5l3xZ
	MhxqSRQd90LvfxAd1iCN1ZUvRuNkQcG+aEJNE6niW/KT0tCDsIdCbON/oYE87FTaHwUWb697enS
	d0oI69m7X1Y2RHS66C+MOSV1qLdyBFAdpgmZxHcqXjfZGi8eJieTSjF+7/NDSfoN+t
X-Received: by 2002:a17:907:84a:b0:b8e:64e:1fd with SMTP id a640c23a62f3a-b8e9ef2082amr13890966b.1.1770140738986;
        Tue, 03 Feb 2026 09:45:38 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fef001csm5078866b.44.2026.02.03.09.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:45:38 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: oleg@makarenk.ooo,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tomasz.pakula.oficjalny@gmail.com
Subject: [PATCH 3/5] HID: pidff: Add MISSING_NEG_SATURATION quirk
Date: Tue,  3 Feb 2026 18:45:29 +0100
Message-ID: <20260203174531.2866644-4-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203174531.2866644-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260203174531.2866644-1-tomasz.pakula.oficjalny@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the same case as the previous MISSING_NEG_COEFFICIENT quirk

Co-developed-by: Oleg Makarenko <oleg@makarenk.ooo>
Signed-off-by: Oleg Makarenko <oleg@makarenk.ooo>
Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/hid/usbhid/hid-pidff.c | 14 ++++++++++----
 drivers/hid/usbhid/hid-pidff.h |  3 +++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index aebf6c89643f..17bdc36d1908 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -619,16 +619,19 @@ static void pidff_set_condition_report(struct pidff_device *pidff,
 				 effect->u.condition[i].center);
 		pidff_set_signed(&pidff->set_condition[PID_POS_COEFFICIENT],
 				 effect->u.condition[i].right_coeff);
+		pidff_set(&pidff->set_condition[PID_POS_SATURATION],
+			  effect->u.condition[i].right_saturation);
 
 		/* Omit Negative Coefficient if missing */
 		if (!(pidff->quirks & HID_PIDFF_QUIRK_MISSING_NEG_COEFFICIENT))
 			pidff_set_signed(&pidff->set_condition[PID_NEG_COEFFICIENT],
 					effect->u.condition[i].left_coeff);
 
-		pidff_set(&pidff->set_condition[PID_POS_SATURATION],
-			  effect->u.condition[i].right_saturation);
-		pidff_set(&pidff->set_condition[PID_NEG_SATURATION],
-			  effect->u.condition[i].left_saturation);
+		/* Omit Negative Saturation if missing */
+		if (!(pidff->quirks & HID_PIDFF_QUIRK_MISSING_NEG_SATURATION))
+			pidff_set_signed(&pidff->set_condition[PID_NEG_SATURATION],
+					effect->u.condition[i].left_saturation);
+
 		pidff_set(&pidff->set_condition[PID_DEAD_BAND],
 			  effect->u.condition[i].deadband);
 		hid_hw_request(pidff->hid, pidff->reports[PID_SET_CONDITION],
@@ -1097,6 +1100,9 @@ static int pidff_find_fields(struct pidff_usage *usage, const u8 *table,
 		else if (table[i] == pidff_set_condition[PID_NEG_COEFFICIENT])
 			PIDFF_MISSING_FIELD(NEG_COEFFICIENT, quirks);
 
+		else if (table[i] == pidff_set_condition[PID_NEG_SATURATION])
+			PIDFF_MISSING_FIELD(NEG_SATURATION, quirks);
+
 		else if (strict) {
 			pr_debug("failed to locate %d\n", i);
 			return -1;
diff --git a/drivers/hid/usbhid/hid-pidff.h b/drivers/hid/usbhid/hid-pidff.h
index 5bf54e981543..8d879067718f 100644
--- a/drivers/hid/usbhid/hid-pidff.h
+++ b/drivers/hid/usbhid/hid-pidff.h
@@ -24,6 +24,9 @@
 /* Allow devices with missing negative coefficient in the set condition usage */
 #define HID_PIDFF_QUIRK_MISSING_NEG_COEFFICIENT	BIT(5)
 
+/* Allow devices with missing negative saturation in the set condition usage */
+#define HID_PIDFF_QUIRK_MISSING_NEG_SATURATION	BIT(6)
+
 #ifdef CONFIG_HID_PID
 int hid_pidff_init(struct hid_device *hid);
 int hid_pidff_init_with_quirks(struct hid_device *hid, u32 initial_quirks);
-- 
2.52.0

