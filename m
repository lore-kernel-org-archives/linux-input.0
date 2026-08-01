Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2DB43553A
	for <linux-input@vger.kernel.org>; Sat,  1 Aug 2026 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785579570; cv=none; b=g0+S1lDCD19VsDZb2hNukSIh6+OE7veTq3yyQPcyWfi/7qsBsewHjEInRcmx+hpxhN95/53XdZxq3tUJtaUYKriRJdeJLsz2B/1ouJ9vKpvTiobdDe7AhjgmzFgoQCs0bycT/lgKATrDuDY4v+OR7KStp8pGFivdFMjGFeU4loY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785579570; c=relaxed/simple;
	bh=uqXJD6BV6xnkaRAj6UkGJyJamyPWK72UY4hAzwPjqU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sZANKxNEusjPNsztIc625r/TTMUE1Q4uRL4oAqG0rJZPY8MtzRGFfGBNt5qjpmAe8/JFSIbhZWX2wVp9Vog5v3XbJlK84GD9tzLpcFTPsWjksn1+ucmWOFO1gGnM5t8wK1VKg8XPSOGueAiMzFWIiMGQ4GHg0v/6xbve9ReF31g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYcT8gfk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYcT8gfk"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf27856f9cso18936065ad.2
        for <linux-input@vger.kernel.org>; Sat, 01 Aug 2026 03:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785579566; x=1786184366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dQivBhoyLILkT0xK6WqciGz/f9cGO872vLrrXwrtBSQ=;
        b=PYcT8gfknSp7+osjrbNpyPLWWDsf7SNBEJ+Kea665hQb0APZLplB3cZmGQ5kizMbs0
         BNoCyQR+pFsKsL/WNHRmsYZnF28Wk9qK+O1jmCZotroIcHACmnoXqjbmAzT+qtnS8Ssd
         yT+pngWvpbx9uTGBJkzm+lz1sm6BvRiDe59hUMnXqXl16SSvHl8myw36uN2AXmWzhh9w
         DDo8oWvQKELBcTOZiojZDnq6W9oBPS7i0KSZ9E3uYwXigzUI8azYEPiao/HDh7kO5c40
         lKW8Gewl1AwjRD6Ch1GtDY1N7CNqgB7Kx5kMUlTQiPhQi24L6AMvpTwhW09l2SiHSBZT
         54Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785579566; x=1786184366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dQivBhoyLILkT0xK6WqciGz/f9cGO872vLrrXwrtBSQ=;
        b=oiaC0rjJ1ARFnxIe5riP+yb0QwHbMitJ/0BhBgt5BI45xtO7SwrhMSmyDd5JLYQ+tJ
         ubA3Lt6eW31i2KiNInnoLvQfacdf4UMGte1tsMwxiy0IWjuXA2lT4NGJTfWQzXGbM4Zu
         FJCBJZZL0Nlh6cAEd1qIVgiXf69XBO5SJh+G6T0ITLiUE1BV12SeIVqXQx9SsvdytfG8
         RbmzaQbBmid9l1g4383ITzBM3t0FVhgoH926N++1IZdz4on64RWFSTwUexnwUNo1smlO
         xe3iMy45DLMwYMZ61Af8IjE55jIQKvNV0Y0ckQUQCuPjWOQU0SmMwmhKRG02TMSqxBuM
         DPxQ==
X-Gm-Message-State: AOJu0Yw9TWnz54X4CmcaQ1Jf6j7nHuNsOEaeKuEvTSndY1y/CHed96Ls
	FccxbOE5Y90re9mIQux63h6kAWRQSprK0pRzqTwCzzQch834wlO0Usxe
X-Gm-Gg: AR+sD11aKgeNmecOOeADYYqRcp5QlGRifEvsrPhpmfg1eVP9pK8sgZuQcFeyoE+6kIY
	whb3g0FobnkVNwhAcEQWRYe47TWvysTCt/oovqX0bbFKngUbJ3jyCai+3a4KmIgZTU3r9hvhmHz
	DlpUX+PHzYzoiZex+m4Af5B3yznAjFA/99qndGRXl69zptJWO00ePr2TZAPRRbiEnuEg6PCj0C+
	q4hSGLWPZ4RVlVoJjvI6CQ4pb+n4ZoZTzb2bo7G814umyKmaE6/C+04ESVvkw8HvyhQCuj1TJdH
	ijni+EJIXDhSnogSC/EgPb7I78zArlZ+R9T4JD6Fz93gZQ6ZdLcP1w6MR8HUOpEY86rV4q14DeK
	x5TwyqbuywrcFd9suvkPwZ00/smvX54nn96J5faiVNGsNCkEl/iuT5B8URwmeg+a1fm6pGFBZ5+
	6n/Timrj0x65V6kZFPRAFjTjijs9fTSwxoUAUllEx36BqqLEv+WxdlhUr1Ffm2OA==
X-Received: by 2002:a17:902:ea05:b0:2c9:d55d:2d3 with SMTP id d9443c01a7336-2d052244e67mr31844595ad.15.1785579565484;
        Sat, 01 Aug 2026 03:19:25 -0700 (PDT)
Received: from xiaomibookpro-14 ([149.19.17.31])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4cb51asm18560574c88.9.2026.08.01.03.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 03:19:25 -0700 (PDT)
From: Zhefu Zhang <a723356@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhefu Zhang <a723356@gmail.com>
Subject: [PATCH] Input: atkbd - skip deactivate for Xiaomi Book Pro 14's internal keyboard
Date: Sat,  1 Aug 2026 22:19:08 +1200
Message-ID: <20260801101908.33838-1-a723356@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The internal keyboard of the Xiaomi Book Pro 14 does not work unless
atkbd skips deactivating it at the end of atkbd_probe().

DMI: XIAOMI Xiaomi Book Pro 14/TM2424, BIOS XMAPT4B0P0909 05/06/2026

Signed-off-by: Zhefu Zhang <a723356@gmail.com>
---
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

