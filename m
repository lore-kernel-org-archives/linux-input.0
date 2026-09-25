Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792FF420465
	for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336715; cv=none; b=c2SM891/qYmsltPkNNZhAJmu6oXsF2VKZ2nruVAuoQ8PoEC75Jh/llHV7fHdqqWutV/1c2DbakJdP92nAcUvsZ7/idvhi5tojVJXuLgJB0vPq/jA19v+/GXy5jTmli8c0yCA/WfAxZbPmVVoS7BFTBBLOtUtiMW+ZdYkPycvseU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336715; c=relaxed/simple;
	bh=L5axvNjMcm+pgr+m0+4b2lZ1ZPKlo5BtupsaNoexQuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJV1kgaFPB5nZ+1p8mdXdd0ybUFBB6vWoPk2Yk7Nj34URUlVDSjVf1f0yTgEEf14B44jTy1H2Cp7aZ5Pi/nUnIBq6xg9UNPIeWRNlx4XDTUVzE8akOwjkDMey+Y16eXvUBcc9e/ZZyhpjMEqhRRRBDBbNOR2lE9yDKh6T1wxKU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2ac3wAT; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2ac3wAT"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e5eso17017a12.3
        for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 04:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790336714; x=1790941514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2DTsVJwVE2nUdlFVAFsAEgFBcB5wWmelooPOcyKGAnM=;
        b=R2ac3wATTaPHGjHJMcY1WCRYF7eerdSSuP86sdwZWEmqAE8ZHtZlyrEstt9qGxPBd9
         lPvM55mROGjb+GMah0ebJYNqcbVfnUOsoOIf5FROUQllo/qR6iY8928xARD8ddAbpmNS
         ftI1NInPyJZRCjhjYuquY6GUqFABsjyfSt722FCYdcdiDRPAM9CLe1UBcwXZ9z/1civF
         Uutq0J6wfvbyR8CD0uHk1XsneU+hN58GwEHJsgxh3tkmdOlYDZgNKHnqHPfZ4tzwc71b
         3w1KvrhYhg/gG5dVEP9zDrgqeep6JvKk5HQ8+4LGyE7/7TDWWBxNnfI7S5Guqg44n9CT
         IeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790336714; x=1790941514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2DTsVJwVE2nUdlFVAFsAEgFBcB5wWmelooPOcyKGAnM=;
        b=S+pJP1SxPn+uee9rLFuOK0Hm7Gesx8Xmy6Dgz7ob8sGUktkvN8yKdoW78xXOHekmeb
         /NIvtc/dWVlW8NdD8UiAbzZnaAHrjYkcqQikLZ10KyoqnFGsNly+vcNcZA+GPg0eGVj9
         6dpDAJyYALOWg2l4NM31mwyYW7e/RzQAlMlUErQa/g4CmcV7tB9VlIcufPByXjsghmu5
         4FE/vy0jLwGznANZ2mFB7vzrrjZwxiw3Q0fyHDLs3A83f0CY3rn3pLWoeT1HTFfD3i+I
         r2gqhjKxRaxn7cjb5HyJo2KyrM9nbtnEyDE90GXYWT6MfoYXE6ZAD4ZzJxfYWa5ZL6Ln
         ZsxQ==
X-Gm-Message-State: AFuF++kXvjzNYZMwN12nZ9MrhO+wQTYfDKDC4KAqcZm/wpk/3+MkQ8KM
	tgj36X3ePEtnCmsavLvcPyIlsmH7Ny8s96LM4jqIA5PHOglujzVeaPcE
X-Gm-Gg: AYBFou1MWTnCa/Z38eem1/FIZV3AbwHsJGnF74xL3DUp2vTGmu9oEI3bKrV8YD4Bz+e
	OZz4dKXsx+tG5Pc+wEX8ff9X6a1MRVcH9PtqVuypjhGT61QfuW872mON3ilJb4Xq2Pr0q7NzWMh
	Y7GLuffMvSz7wadoYAmaXS7Rypbwixs+DbUBe9HgP0RbK9jnH69ltrsbbGUuztDka38wdUQbXWs
	G7GsqHBEp/crBgDd8DTm8vVvYGBCTcFKBCTwOGhH6WLK04MyfY/eogbdXSthjrap8kmp2wjs0zk
	UNibUtuivkwgABFhVrAFEgakZmihQSvo+o34NZmirEChMoggXaHqBinP10yNrw/4t98+MTaA6zT
	JnlH3jXzvtsUnZGbgtimfcZMTcz/U8r0tC8WxdtSZj6rdL93ULSeJGKGYZWEd8l+TQ4e3E1OCbF
	NYqlF3MD45au+1WOYM7ks4NLt2aY7PwqiCuwLUjgcBRv/2kdWOk1xSY4GeG6/d1h4OH4JQYLW2F
	XypzfJVPlK+fwZcbllA755/az4=
X-Received: by 2002:a17:90a:e187:b0:3a0:be2f:4334 with SMTP id 98e67ed59e1d1-3a0be2f4866mr1302161a91.19.1790336713695;
        Fri, 25 Sep 2026 04:45:13 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:8004:98ea:c60f:8ff:fe17:57ff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b498fb12sm1610333a91.0.2026.09.25.04.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 04:45:13 -0700 (PDT)
From: Bihaan Sen <stevewholikesthings@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bihaan Sen <stevewholikesthings@gmail.com>
Subject: [PATCH v3] Input: xpad - add support for 8BitDo Pro 2 Wired Controller for Xbox
Date: Fri, 25 Sep 2026 17:14:38 +0530
Message-ID: <20260925114459.110253-1-stevewholikesthings@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925092439.79904-1-stevewholikesthings@gmail.com>
References: <20260925092439.79904-1-stevewholikesthings@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 8BitDo Pro 2 Wired Controller for Xbox is already matched by the
vendor-wide XPAD_XBOXONE_VENDOR(0x2dc8) entry, but a later hardware
revision reports product ID 0x201e, which has no entry in the
xpad_device table. The device therefore binds and functions but is
exposed to userspace as "Generic X-Box pad".

Add the VID/PID pair so the controller is named correctly, and set
MAP_SHARE_BUTTON to expose the share button as KEY_RECORD.

Signed-off-by: Bihaan Sen <stevewholikesthings@gmail.com>
---
v3: also set MAP_SHARE_BUTTON to expose the share button as KEY_RECORD.
v2: move the entry after 0x200f to keep xpad_device sorted by product ID

 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f834..023b70bddf76 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -372,6 +372,7 @@ static const struct xpad_device {
 	{ 0x2993, 0x2001, "TECNO Pocket Go", 0, XTYPE_XBOX360 },
 	{ 0x2dc8, 0x2000, "8BitDo Pro 2 Wired Controller fox Xbox", 0, XTYPE_XBOXONE },
 	{ 0x2dc8, 0x200f, "8BitDo Ultimate 3-mode Controller for Xbox", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
+	{ 0x2dc8, 0x201e, "8BitDo Pro 2 Wired Controller for Xbox", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x2dc8, 0x3106, "8BitDo Ultimate Wireless / Pro 2 Wired Controller", 0, XTYPE_XBOX360 },
 	{ 0x2dc8, 0x3109, "8BitDo Ultimate Wireless Bluetooth", 0, XTYPE_XBOX360 },
 	{ 0x2dc8, 0x310a, "8BitDo Ultimate 2C Wireless Controller", 0, XTYPE_XBOX360 },
-- 
2.55.0

