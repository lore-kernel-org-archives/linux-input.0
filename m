Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391D41D63F3
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 00:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782780345; cv=none; b=ZBbEINkSQ9ZKQSWkDAvl2Fg0MvpoZT2qNZlKZ9cwl4AxSPkbY5cjfMEXINq49+STa8EmiHy66hOrcGEgECTyx2gTSigP+T6fQ1nZr15NvAtNAPejtBJNvQNWvagdXWhIA+cPQEagNvxA1viDZfXWxSz+qVBS9xpDiIt/SGqAKfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782780345; c=relaxed/simple;
	bh=Z6LXOpfzZRZ5TGA22lvFHfnX1V+N4vlERlWCR+17XA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FtAUKDLgq4tUSFwvEBcDH9GfOIRAzeM/qBZZLyBgWFKzOiqepEsF7fDZDCa6injZxabezeSsD0JCo9arFvCTPFHCMwvrkFfx0rrznzBm9oKoHPs01O0jQDm61PUuymCPixeNHQ0+kygXeGLdG03cAgB2+xpMAzyrqkLFbOyX3nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZKh3tgf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZKh3tgf"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso49252395e9.2
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 17:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782780342; x=1783385142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JfiTaVBEdEzzdoXET/G9g87aKaZ6PIZli+Pr8KHubdU=;
        b=ZZKh3tgfA+8eKrap+rbQEScTByidjmJY/ifVlOEBOAmcj/tlOdICxAcG/ln63HqKxF
         ruCtzdVlKe2n+2vix3qRXRUQzg7WZiQGTqnR35nHWJ8AKXN//Q44Yl+TsjpYSG8xCywP
         ppN0e2W5vQ0LivEMMWcj2gR9D+Lugr/2hSwzBI1lL0N1AMYP8HAmWrPjvCcGgzKQ523+
         UKzSGF/Rjhw51k6u+mHTHueyJrSVJUXalYRVNSDbsmYgTYixxYVduc+P9UyeuxAv3xne
         1HPXByHN9eq6t8bknN3Uu47Me6DB/IxEkk9TkxXgz+vRrQYK6f4TcYnJqoDn5E2juoAd
         APJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782780342; x=1783385142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfiTaVBEdEzzdoXET/G9g87aKaZ6PIZli+Pr8KHubdU=;
        b=Qr4EWNsN6BNi6MigxlC2w/k0v8zydJA4Z8RE3LMi/wAUuhJ1qxRXuIY/GF16Tr17/c
         /AOxGybiaEsFgczYfn30bccbjgp3S1fsPlIv0wPEnx8r1V4yCVhXlmpqfMavtrSDecR2
         LenSgC6MuvMExZdkRpbOs2WUvnwSih0iOBP9G5nqXc1OouSyCIrpXNRQyRJNhPCZJE0J
         9cZ+rBsdEnpGH7anyJg3+ExevJ+qYYVGsRk9RLUImXR1+32FGfMf1vcLdFg60hldglW0
         nOnd4B8tQzkqBTnJ0yg3FHzYeJZ3tIOWtLNDMh1kNJ5CO21g8p7wYNM1JhJVVDTEE6fN
         AuDg==
X-Gm-Message-State: AOJu0YzhnqKbHWWE85yQU48UvlBrtw7XyRrY6FFUKXh9B/y6Y+WFboRz
	igtCvc/OlXWOFA1kZ9ZoV4FA/K84R7E0eiq9mNrFKI7uVMQnIehbHPNDMJW5lu07XTs=
X-Gm-Gg: AfdE7ckdmuo6rEhUHEWIHZnGPdZP4xJCvfDKQmo4+ajW2vhfx7oKU8SlpZ5dVfF65DZ
	6MuQJoC6imXYfpGf4PGj27XSwQT2PRfk5VlqqpaxW6hwGgBM8yKk/QnzRAsx+NUYeTz2YF90qDb
	n9pMBJioT9T4Wh3N/sWLleEp/DICuEZSLqJN0W0i3VaVS6jGTUC2j+8LRPh6qUm1TXp3BWjYoCh
	FagHN4KbBr64+N6j6ODObuLO3HnvSLiK80BL/SE72n/AHobbVsriVNfh1jLhfVWUgn6Pen0z4FY
	Tfk7hTZ74r4zvlXgFWNwD9RXuC09o+IYkbjKPkxkey/zj6tE7h57YQEux3wIMRJWt6ODK9KETS4
	+wCbe32ReKMy8mDOVnBGxeFnt/JJX6qdenLDfAqps/1fa7xLbADCw0Eo5PxMZJwqBFs0oFF2i8V
	V9mrrSP3I5rxIttYFW9f6MNyMqA2mGZ0Z/gHy8gLEs/o6HhVB73VkEwdmeOFJn/u7fIvo3jBZjz
	xGaRnTJgrAl
X-Received: by 2002:a05:6000:25f8:b0:46e:f162:64a8 with SMTP id ffacd0b85a97d-47551ee71a3mr1821458f8f.23.1782780342356;
        Mon, 29 Jun 2026 17:45:42 -0700 (PDT)
Received: from snakeroot ([2a05:87c3:2001:7400:25e9:cccc:54ef:5829])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475674af239sm2261877f8f.30.2026.06.29.17.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 17:45:42 -0700 (PDT)
From: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To: linux-input@vger.kernel.org
Cc: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	linux-kernel@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Subject: [PATCH] HID: corsair-void: Fix firmware event packet description
Date: Tue, 30 Jun 2026 01:43:24 +0100
Message-ID: <20260630004323.589696-3-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size was incorrectly stated as 4 bytes since the ID was missed out.
Add the ID in and correct the indices for the firmware versions.

Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
---
 drivers/hid/hid-corsair-void.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-corsair-void.c b/drivers/hid/hid-corsair-void.c
index 5e9a5b8f7f16..ce92e3a9c058 100644
--- a/drivers/hid/hid-corsair-void.c
+++ b/drivers/hid/hid-corsair-void.c
@@ -51,20 +51,23 @@
 /* Receiver report information: (ID 102)                                      */
 /* -------------------------------------------------------------------------- */
 /*
- * When queried, the recevier responds with 4 bytes to describe the firmware
- * The first 2 bytes are for the receiver, the second 2 are the headset
+ * When queried, the receiver responds with 5 bytes to describe the firmware
+ * The first byte is the ID, then 2 bytes for the receiver, then 2 for the headset
  * The headset firmware version will be 0 if no headset is connected
  *
- * 0: Recevier firmware major version
+ * 0: Report ID
+ *  102 for the firmware packet
+ *
+ * 1: Receiver firmware major version
  *  Major version of the receiver's firmware
  *
- * 1: Recevier firmware minor version
+ * 2: Receiver firmware minor version
  *  Minor version of the receiver's firmware
  *
- * 2: Headset firmware major version
+ * 3: Headset firmware major version
  *  Major version of the headset's firmware
  *
- * 3: Headset firmware minor version
+ * 4: Headset firmware minor version
  *  Minor version of the headset's firmware
  */
 /* -------------------------------------------------------------------------- */
-- 
2.53.0

