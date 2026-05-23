Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A7935B62F
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779533751; cv=none; b=D6x1HTrCBNzTXYlDmfYFdMoB0Gvcr43TJPg+Y52EUl6Wm1czc9Vdu41yhOgn8YNctadQ3M7f7No0TQOUltTzQkWkbGanzPazBhxXRTtJfeB4TmVogDEoGffnCWniHnBH3JBoOR4PCFVd6x9Ah1020qUp3kDIiksX9VV60Trujyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779533751; c=relaxed/simple;
	bh=eIIjFYNCMGcLlWFQTUmQKvTKAGx5AVvElMmz8bmDvUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EqZvC44Yz5LFsN+0sQvEios7Z7mLwzyha97ezblVlENZxOy/YniPFrxbLEunuPGDXIq2aX8cTC6q5bgBxzTUP9NZ+QZ5VACaq5KJxsFnIVOE3J4nW5g6a9Z7bbzvdCTOU/YLhVuDkEjAQJ8VDV8sW4eoePEz2VeLXwO3Ci1azco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oz757hRe; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz757hRe"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49056b9f04aso1003175e9.0
        for <linux-input@vger.kernel.org>; Sat, 23 May 2026 03:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779533748; x=1780138548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m8TECU0a9VkWyIfHI9nsrriIHeeHyStiVg6Xoy4jWt4=;
        b=Oz757hRevz+MA4/57Nein7P920/XR3lnVei5w2ZI16kYCJ6w06cfDI59I6SYSYrVKN
         ppKkjXmBVnnPs/4nK7Z07m9aZONwKTGE+Qhlby4V9lwik3WU3bv+WBZ2rs5qBOyEC/S3
         TeVwe7gST4d2VXt2uP8OIw1BhkLd5qUaFE715x19dlhPoHOD7JVNGzIV3adNodAU1Pz/
         hOUQNsdHeCnss2p/flWDho1J+EDyFYDrdSGPSwYXDt48E0+aM06+2leudpLsIcA4SsDL
         JIhoNE3KdNVK9Ww9f5sjdAjjPFzUAzuan2SH1ey9BICMyfaeahhsF2fcaTDvlsC3cAPJ
         qFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779533748; x=1780138548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8TECU0a9VkWyIfHI9nsrriIHeeHyStiVg6Xoy4jWt4=;
        b=eQP6/RotL4E/ranG/Hu4NC5x0ykSpmKkgxjR8MClgZCFiaC10/tQB4OibYJa+WLqa6
         68nHTobfTRQob4nXk+XcM6luguGhxzHyahlBahSXwUvVnNrlmHM22I0tGmZ/xQMrCYRE
         OxvEzgM+wHK4isdtv6OtQcoGOueafyDJ7B6V6hH4T9wkckoIkTNKtzuz+Y5V0wnmhMMv
         PR7zcklcgLF6GG//yOAYByY158tm4MgwGmImK96fMSa/1WgNhNbZGZFBrPBx6HRcShPN
         E7XjdVgt6RbhK1k7SOMOpMiYsjSw74Z5egrFKfHgofeTUDFzUVS4kcW8W+aW/Il2pNlk
         oEXQ==
X-Gm-Message-State: AOJu0YxKEqCRh7r1+pPr1XfaXSk+TDqJ0od/Rb3pYffjd22WTMieEC0n
	Y8lg63csXQF6ulSmFDmEhElIVs4J9QAb0xnmScdh62MOFHlLoz9bbmME
X-Gm-Gg: Acq92OEjFFaZdoC4JR2HkpronFQ3FiFfVShDrXPZ4VqjhLo0JttvKkO5IE/GW2PQQ9u
	iseeih1yqBgbx/MtWBTaABh6gLz8QUvV/Yt8AAZI9UwWmy+ofHaFHrRSSlPacj/w83qLhvX2l1e
	yfLz5gYlC09mER06fwKQBR99R8Cx2PV9Keek59tNtB7RM4WAiErmeNx/2crvE5M5jpnwkqWyfyt
	DXqlLhO0JKapQ84IrXjiBS9SCaSTK2e6WjHAOj9AgvHp/vorZrqFroEXME4qUWVuQKTPHpT+16L
	5+0sOVrY7qco333U0to2gC68xSpXJRGXqHJ4cQrExtWU6qkqHy4jhs10Q9CSnojxUJUippwO6sH
	D2Cd07bW37jO435cstBEPHzUXgxwYRhgAG2gaQeGREiggZ+Pqjvgb2v+gdbdN75qg9zPmzT46vB
	XCZd6S+qRlwLVeXIHlRL2TWTaAiTG9L/nU3L8NNToiByyh4Prhs1mGsZ+HrQdBWENT1IIzEQ==
X-Received: by 2002:a05:600c:3547:b0:48f:e6b9:c740 with SMTP id 5b1f17b1804b1-490428f30bcmr112976715e9.30.1779533747882;
        Sat, 23 May 2026 03:55:47 -0700 (PDT)
Received: from teknoraver-mbp.local.lan ([195.182.211.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d493dfsm11502417f8f.23.2026.05.23.03.55.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 23 May 2026 03:55:47 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH v2] HID: core: demote warning to debug level
Date: Sat, 23 May 2026 12:55:45 +0200
Message-ID: <20260523105545.68079-1-technoboy85@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

The log level for short  messages was changed from debug to warning,
flooding syslog on systems with devices that regularly send
short reports, in my case an UPS:

    $ dmesg |grep -c 'Event data for report .* was too short'
    35

Demote it back to debug level.

Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 drivers/hid/hid-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 41a79e43c82b..503b9bfa5d37 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2072,8 +2072,8 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 		rsize = max_buffer_size;
 
 	if (bsize < rsize) {
-		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %zu)\n",
-				     report->id, rsize, bsize);
+		hid_dbg_ratelimited(hid, "Event data for report %d was too short (%d vs %zu)\n",
+				    report->id, rsize, bsize);
 		return -EINVAL;
 	}
 
-- 
2.50.1

