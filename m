Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E4E36F909
	for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784377507; cv=none; b=GXq8JKumBN7RiPFeH+NVyFiWrMpwANWXpPBQ1/lB9cmLvTYWMDHXFH9lRuOC96lBittYJQ3B/Sk+DDBLgbyPfqF2WvXKb0HtRwPkj9ncc+lhWZGJyiHesdPE201AyUff3SbHUBRINwQfWLkVHuPumxC8t8ZjC5PZVfHou11j28I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784377507; c=relaxed/simple;
	bh=dCqc/Gpt+qabsfg4ePm0xR6+Vd07oJfgE8KWaErQ2LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tYA7wxV1us5DhigZ8PQFt/qQoi+S2VZivM96wMlF7tMtcFLblt8FQZ2756hZfBIGekVYmvE/lrVWAHsT+3j4fLQ5iEKJaYE8SsLJ458wWG4UHHjSpFBRDPsd5MfvhGY/EE29CS3AZqbjIad7grkiqghjUwm8erFkhFs7Xy4OO8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsKe3pr4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsKe3pr4"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cacb8416a1so52894805ad.1
        for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 05:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784377505; x=1784982305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iqcJM3A5wcf1kOSiEdh2r5s0uC3gHTtk06Wi4etClSY=;
        b=bsKe3pr4Ei6jlgu2v27JT2MzeCk+aw9q9oFfr0fStZPf2lhmjqPwYU3D9UU6hBDz6/
         mFITZhgUshi7jp/dHzZyanSQyc8qMyynJL9z1PalyZKKMwJeEJWtjWo9du0MQjFNq54A
         U9yY6vjshxGW+8ym+wO/PyHXVrTJLxEEaBNWAuX4cp3tbQiVHpM+DxBz/XS16pE1uj9z
         OWstGowmvPGZn8qo/H8X5okZuGMhOztCbGDZ/0btKKQSwTMOX6zHlTdlhDv+FPhZql1M
         cBiPuVG7j6e/5ERQR1H9hDhMR0lG8i0xyBeob3HMqJJI23th1xd5WvpNAEcdzG6rM1G7
         Yx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784377505; x=1784982305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iqcJM3A5wcf1kOSiEdh2r5s0uC3gHTtk06Wi4etClSY=;
        b=rEATLRlOuMczxBpTONKL2QpZhc7cEp76jOPqeSNo06UOOQgMFr8iZzmPM8Abjb76xu
         UCd7L1QVYlsCZzlia8YhIfJDeoalaQx9Qg5vJz2JZ1TdIMCITNW6RmYUxUVhEStn4/VH
         qbSNjIQgAf5CsaHLab+R5JTnO3jhL7fuKmnnaxXWSpxw+cHMA69wda1Rf6fCFuQdvkvF
         /mob3xwBzVeXsle/ZaQjjt5huaCPcnVbeMnmdHbrae5ruyCmAN0q9spgUMNCDEWDzmwh
         yuUSeHLa+fi7WB/YrICwg+TFNZVWQhAymT+rYRbVfrD7mXAv/24odyVtR2VcyYz11NCN
         HGKQ==
X-Gm-Message-State: AOJu0YyljP10x/bvXE2l9Ve/j/SgbaLpsV+HFHLKoxFYmh/vfQ06G+Wh
	tXU9ZOBLDgNg18Rpc1eYVgX9L/0obME1B5zRGPgkKg0qW/stKGyMYlvrlZ7hiT2/gSQkPA==
X-Gm-Gg: AfdE7cm758omFAmfVOdWgNXUznvnbph+z+sBKWrmbMbVMlfzA2etmnevlPFmVFqNfjv
	ptnRvxc3pDbnFHvSC4daFOnmTwTjcO2iDRcUfKJeOdiM09c+k7G0EamaEF9Wux2hVRgk2ulcgtT
	+X+teD62ik2pinWlsGo09+i2Kps3W0MXadvxj6DFYmrzAdOl7JRckRictDwrFgL2Vuk0+5nktho
	4oye5sKdxRH741n+jjZEZ37fCBuU8HBdf0HyIL+ddyAtgPerXcUe6eAYIU66eQRreTVNv23jxdS
	q5aIyfkaJm4ObgUEVWniKO0KpIYLqbxzI0ckL1jpQI7LZPsT2IZbt7JTlJ6GEtuZqil2E9n0YRy
	O1LrfkpYHonHsUyeyJalyiirNY8wLov8s2SLtjVBR7rF3ZTSdLv/ccaAHozzvC5o/4O3EDTcXNq
	6MDcah
X-Received: by 2002:a17:90b:17cf:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-38e4b4113d6mr6677460a91.11.1784377504923;
        Sat, 18 Jul 2026 05:25:04 -0700 (PDT)
Received: from XiaomiLaptop ([123.166.62.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4aff247asm2665629a91.7.2026.07.18.05.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 05:25:04 -0700 (PDT)
From: Andrew Zhou <zhoulol888@gmail.com>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	Andrew Zhou <zhoulol888@gmail.com>
Subject: [PATCH] Input: i8042 - add Xiaomi Book Pro 14 to dumbkbd quirk list
Date: Sat, 18 Jul 2026 20:24:37 +0800
Message-ID: <20260718122437.11112-1-zhoulol888@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Xiaomi Book Pro 14's built-in keyboard doesn't work by default.

Add the device to the quirk table with SERIO_QUIRK_DUMBKBD so the keyboard
works out of the box without needing i8042.dumbkbd on the kernel command line.

Tested on a Xiaomi Book Pro 14.

Signed-off-by: Andrew Zhou <zhoulol888@gmail.com>
---
 drivers/input/serio/i8042-acpipnpio.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 412f82d7a..6b18014e2 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1430,6 +1430,18 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_DIRECT)
 	},
+	/*
+	 * Some laptops have a broken keyboard controller that reports
+	 * incorrect data. SERIO_QUIRK_DUMBKBD bypasses the intelligent
+	 * probing and forces a basic PS/2 keyboard assumption.
+	 */
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "XIAOMI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Xiaomi Book Pro 14"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DUMBKBD)
+	},
 	{ }
 };
 
-- 
2.54.0

