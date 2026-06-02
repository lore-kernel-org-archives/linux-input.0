Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608123B2AA
	for <linux-input@vger.kernel.org>; Tue,  2 Jun 2026 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420155; cv=none; b=WtOarz2epsicXeraDTiPcCjh2rZsJbi8SE2vSpfhtv2PLJ8HTOz2mOWtnpxHXA4Xfm6IhYkie7N3BRWFfrtTL/7YCXPpKzYHnVQPOxzf508VvJOcdjhuWZNEO3gtv5UyXIhMTAv8OCgDQonT3R7/qpBXDMJDOT4lYMooZUeyIuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420155; c=relaxed/simple;
	bh=Nq/7iUUYhaSyctHhetyJNwBu9dImCJlgB+RYDFQABJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A/6ZgW5bspqdKscvyjqLnAoe/lhI9qswqcOrN/WFSXlVGZ9mDF2sYXbuajpOO7JUgnSn1bzER83ebKeBFikOjj2rhTdmcMhPax89KF7Oaqa4tkcvuOsp8nIUurkIKcR69OzDYVYsqmhFZFgv8BpTG11t+izjoTiZidcwhGlJsEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccejDfI4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccejDfI4"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0c2d8b95bso19383665ad.1
        for <linux-input@vger.kernel.org>; Tue, 02 Jun 2026 10:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780420153; x=1781024953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8W6N9JfnEPYwzNquyA4+h1YE8ds75cd/Cvlu+WRihD8=;
        b=ccejDfI4clxYY7KKnIRiI0bKB039Owh6A0ODU3dPzZ49aKczzpQmJaDzHSLcE3Of01
         rSO25UVTavwO+fYpIzHCtAsovrceojJNlTJFgm5Z3xAIolYNbJpXIlS9p3NQFk57TASF
         NR5cLXR6t0v+bsUhwVNO3ZEJSDdT+8PSUFJ/mR9bOl+F3Zw1rnnLpZyon0dgAE7vN6R5
         F03lzk/HgigktODMgwKxqL79qUK94l35kGaMY1qLxIqrjY1K1oEcWtpDMmHfeNWIX0Z6
         54/gcmn16SJN55a9KIpO6eqTwyGZP1Iqou+Q09VOQjr2gXlfXd6PpOjra1BoTKUMRpFf
         SvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420153; x=1781024953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8W6N9JfnEPYwzNquyA4+h1YE8ds75cd/Cvlu+WRihD8=;
        b=S/CBHRZToRJ7jH/m4ibkBUQGdntuKZwHuNMeXhx0tO1MDpZ+WaLP38fmIHU2/fX7xx
         Xk+XycuiK66A/lRUxOkAHa2CewCATB23O2xvr1MoTMoi8wsGsQT4IrrPcHkLvLne/1kh
         oiRbhHwNJxjeGxhn/n3/EZ+5Iaw1BEY47gklW6udVXkDvEJhuYsiR0UuL8JBqVrktoVo
         /yLTI6ekdMeCLiFRY8uHz8S62j41YyDcpdIDZvkxembqk6Gs9+JYvchkdQfhWN8lemmu
         5T0MjPSuRIPhr/sl9XKX8i84TBR2dsI9neRmKHpMh9AULvCPQtyQ26BpNZuYoTfu4i0E
         UxzQ==
X-Gm-Message-State: AOJu0YxODIogZAj6m9VMbNASc3zt5bhAgy1DeCBfUbpHLgvnEYEtn5g7
	TyUo7P2FcqDfAEkKAalT2IrcE79cESFSrE20UeVBKdxSgvzXsA/1x7wN
X-Gm-Gg: Acq92OFcuBgmA2cPP9jM7ZAxfQ3semDWs3wlZGtGZSb6ITcSWdBPPVkuLPQNnqYb5k6
	1hcp46AqGYMjVUMTkE+hDTVApHwETirtvQUXmPC5qNwRaKsnZZs5kdhb3XHE2cTqIiyCPHERyox
	rxO9qavUqmTFWzNKEzK2fz5aQma/HOvlzMee3PyGeeuhONOLhXWxW4tBGDrRdqcRBFQv3EFLm96
	d5+5IBG+CV/YD5xBivJGvh0Xq/5ONAxEv02mk3NGxS3lPWMHMNwkIjOyA9aqSp8j1yv8dnx+7t9
	RFfsLPDmMXV81rSRfbsS9d1modTwUPAJgS7JIhVP1eLFBLnJ67IPYnQsxG/wZf9UwmM/XMduyCi
	G65JS4sCP2kYqbGEcH4KPABRjj1zbIZGhsH4prwPAiwXUNHhWtExHyDZA8cm4plzIfiE642moqD
	wQXehyN6UMIGyRe94pRNMD2ZG5L0Sl//yxqA9uE4TpqtdE
X-Received: by 2002:a17:903:3585:b0:2bf:2243:d4e9 with SMTP id d9443c01a7336-2bf367c1458mr199500325ad.13.1780420153545;
        Tue, 02 Jun 2026 10:09:13 -0700 (PDT)
Received: from eureka-YOGA ([240e:b8f:57f5:ba00:44e3:92c:4a04:f96e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239fd24fsm176455645ad.20.2026.06.02.10.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 10:09:13 -0700 (PDT)
From: Zeyu WANG <zeyu.thomas.wang@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org
Subject: [PATCH] Input: atkbd - add DMI quirk for Lenovo Yoga Air 14 (83QK)
Date: Wed,  3 Jun 2026 01:09:09 +0800
Message-ID: <20260602170909.14725-1-zeyu.thomas.wang@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Lenovo Yoga Air 14 (83QK) laptop keyboard becomes unresponsive
after the standard atkbd init sequence. Controlled testing on the
actual hardware shows the F5 (ATKBD_CMD_RESET_DIS / deactivate)
command specifically corrupts the EC state, causing zero IRQ1
interrupts after init.

Skipping only the deactivate command (while keeping F4 ENABLE)
resolves the issue completely: both keystroke input and CapsLock
LED toggle work correctly. The reverse test - skipping only F4
while keeping F5 - makes the problem worse (zero keystroke
interrupts), confirming F5 is the sole culprit.

Add a DMI quirk entry for LENOVO/83QK using the existing
atkbd_deactivate_fixup callback, consistent with the existing
entries for LG Electronics and HONOR FMB-P that address the
same EC F5 deactivate issue.

Signed-off-by: Zeyu WANG <zeyu.thomas.wang@gmail.com>
---
 drivers/input/keyboard/atkbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index c8ad55f..217e66e 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1923,6 +1923,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* Lenovo Yoga Air 14 (83QK) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83QK"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{ }
 };
 
-- 
2.53.0

