Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694C9340DA6
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788603646; cv=none; b=F14nh1xiDD/sp5/Y9kqnqYLftKqeEu9ryCWzIORyoX6blN60LF9OEm4/Cc90hjPogf26ipa+LzIHYT8eoei5Ziz2WXXrRDAZle808E3nM0zV500An5eG/ztT+1lPbLSvQRacmcGxhEWOmaEmw7/7de+zCY9IOV0e0keC3Bm90bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788603646; c=relaxed/simple;
	bh=DcDVWEoGw4mU+hURnvGHMh0XA7ZJW3eTiASybXL99+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m8tQ8N0c7UW+TYpDnzMEH4XpPiTWLyzQUz/OnpWg7XoDFgOgmiphF/jEJoAvzcXY+C+PR00ESEX86F+tLnQYqbuoRQJqBqVEZBjCsZcjbpf11WbM4f5EPGjm2nqPK5bP0zgsM6+RGpqNdsKfBbWFemIQ9cOL4/CEtOLz3uOfm7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J76liRv1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J76liRv1"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-485843aeab8so1992062f8f.1
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 03:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788603644; x=1789208444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rkpTTROaXEWImpK11bVrCYbCSBvilUTGEzzvHACOOW4=;
        b=J76liRv15ZXBJ80n4femml/Dm8dAgVIB26zAhiSneq+/ch+FH9cP0I1+ZcD0jAB4Lq
         N3lxQ9N2TR8LBPwL+mcku1gkmG4Y3HM+/yaBDZshXrgka5u9CY2NmU3ewjsVLY3hJGBk
         vfyzF3r7Dph7h/vjWvvUc7Jec15JlssMSBw32WqfC6BQkcZBKPqioaNBcVllYZrxfSiT
         iaFnJsuCCK8Sm2qT2z6NO0V2dycxLnwQNM2904qj5bKmwHiExmw0vHX1FM1h1Bdb4yMs
         I9OSkACVgLrmgpcTKgc+duIQoFOw1zXj7wOpi22F7RPeZtvmimXpMx8bz35RAU9FYWmW
         GOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788603644; x=1789208444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rkpTTROaXEWImpK11bVrCYbCSBvilUTGEzzvHACOOW4=;
        b=q1l4yS6akkRhLYeJBwImfAVbEz/QwnwGBL5NBVcuuSLTrcQdDSlV8kjvy7yCwRLjvO
         JzxdxrfBz66OPOCitZcQfbbs5kKQ1Tq3wZLI1+nA380zAG1xwqjO3RG2vYEJY0iwWu5a
         KHFelChDmwXqIlwS247gmaqYNIwgrB2Hf6CKxiZbbOFcjmAORSHFlgeeD361ew2CMkhO
         SBqtX6V6gD/jI3ptX6wUkcCZDg51j3xK0PVIqCZEDq46+uEMbpQFddQcmzroieKTJR3N
         5I2WuuhA2HHKhsXig1nmQRWbDlVf9fIHRN/Wjok3N6qobfBLDJZHjDgJZgCU2L1PHVnl
         sL4Q==
X-Forwarded-Encrypted: i=1; AKwUvByw+RdQyfy5ZsYT5bwr8Br5P9AepsmAKxMUNg7NlVTxTBhBCZA78q4JYECOrAVzc0JiRddtGT56WEucvw==@vger.kernel.org
X-Gm-Message-State: AFuF++lfUB90IHGJ8f4eaUcGuQfRJ1on4mE5mAGSc4jt3nLFGmx8RA72
	yAYAC2QfuHYrMCSyFGjXIb3KsfvQewjxpMtu3cyNZ11tXveY85T4RI0d
X-Gm-Gg: AYBFou0dMvOiZLWMztpWT0K2tskFM4lv5pS8n+Lr5SxTY4JfSBlv46zg26pnFXGlsvp
	Dsm8m3ypaPwFKmYg7Dje+75Jb8IiZb03izl2iKKprWOgWAX1OIMPH9Iiz3eUXuOliUdVsFWIU1J
	3dz3qMxeINJ7FTp0jRq/6ArNhgg5nR6efR7qNh/kRNt45UX/Okh5V3RuItaBBnN50SlD9Nwr0nR
	4vjZjCEHtnRWkyNxB2SN9GHizrYmIJ3Ri0pRdeGFpIcTVoHsYykdneK92VYjoeHLhkwOO7ghQm9
	I3Ee0QOSKGKegPgBklOZD6Yy6Abyu+U9hDA/cM+8sa0gdZdIou7+wljnXnbiQ08YfBmKeyWSZ0f
	DinFe8XjyIKzFRficQHABp20WLJADSKtnmOh0uwW2I1f37XB0yaTi9AlV3EaxWSWfXW6LqS0SUr
	JnJ281n7zu+fufIh/u2JxpTccDUKnDdJVBWSgMaz3T2eidYbOqIgRoQpQcZY6R8z9NhmH73OWB5
	qXmBEbzYkZFdZ4OMTisbHWhiLaWJj8dAo/HhwjE9vpQ37uKpFQbrio3sOotCSfggDhvTYtNedxD
	dIqATt9fGXnHBxX7HVRzJMK8wTFrO5C1OzPqK6RzbwcwcOwrAYjimVEiKp1fg4lk6mY=
X-Received: by 2002:a05:600c:4f4b:b0:499:83f1:398 with SMTP id 5b1f17b1804b1-49cf823f53emr215342755e9.9.1788603643468;
        Sat, 05 Sep 2026 03:20:43 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7febb4sm238448575e9.14.2026.09.05.03.20.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 03:20:43 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-input@vger.kernel.org,
	Aishwarya Pant <aishpant@gmail.com>
Subject: [PATCH] Input: trackpoint: Fix the inertia attribute name in the ABI document
Date: Sat,  5 Sep 2026 12:20:38 +0200
Message-Id: <20260905102038.42882-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The attribute is created as "inertia" (TRACKPOINT_INT_ATTR(inertia, ...)
in drivers/input/mouse/trackpoint.c); the ABI file spells the path
"intertia". The description below it already says inertia.

Fix the spelling.

Fixes: aebb47d4e7a9 ("Input: trackpoint: document sysfs interface")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/ABI/testing/sysfs-devices-platform-trackpoint | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-trackpoint b/Documentation/ABI/testing/sysfs-devices-platform-trackpoint
index df11901a6b3d..7954434b0434 100644
--- a/Documentation/ABI/testing/sysfs-devices-platform-trackpoint
+++ b/Documentation/ABI/testing/sysfs-devices-platform-trackpoint
@@ -5,7 +5,7 @@ Contact:	linux-input@vger.kernel.org
 Description:
 		(RW) Trackpoint sensitivity.
 
-What:		/sys/devices/platform/i8042/.../intertia
+What:		/sys/devices/platform/i8042/.../inertia
 Date:		Aug, 2005
 KernelVersion:	2.6.14
 Contact:	linux-input@vger.kernel.org
-- 
2.53.0

