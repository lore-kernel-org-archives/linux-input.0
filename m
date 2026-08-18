Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F7146D540
	for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059232; cv=none; b=EY/pSMefY4689wz9LMzI9URppQ+DPQY/3FteVt6LGEBk4TiB+KROKKCiHS4XWlZ94HRy1wnD468iHEFdXkzN/966svHIALXUPOR+74qHsjhXJ7tiqFT8mXr4w156DJkow/DWevIQ6gvK53WxHBsn9cswixrEpdKvkF1f+C3X2YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059232; c=relaxed/simple;
	bh=UDtWwchdhUl1geudWWvYZjXqhs5605XgfHNI2kDLcXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ec7FFB3gf8csxozYPhAC28KFDxrtDcsunvBi1QkOyca2+5IyCvM0qQiVs9JClZKlwN8zA//W6fhRueQJj2vFR6/dGiGpCs7ObAKfLFJ7F0PbnX5PI6esXyMcBS4aoae1qADJoGXvB4/RZv4/bbREsiuOECvJXY0seft1ryYig/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mR5Hi5eX; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR5Hi5eX"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c20ce3c118aso184864366b.0
        for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 06:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787059228; x=1787664028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UCXJXOTsM7aQw7ElDYlqfjKjTvQ4u0H2LjQVlRKBQ1E=;
        b=mR5Hi5eXnZH3bvuSA3Nb8wBmw8xfW1e4FTiDeTMdrP6NjBe5VIw+p4Iky2WnGxcD/m
         75jtiXee0ZRfvQwWwKJHxe70Jhb9ZFSVQc3b2gFwOOInswpm+7eT45bzzUooQ/6YufBX
         oFzd1DIcqHJbOxBJo10yS7B4HPcSZIq3wGcBfVTvnJHY8TU8vys5FO5et8C/WJqOnMRJ
         JvIJM/jFuVa5iJSebCRtwz8CXLatkme5kxi+xW5KZqdI606tetWw+v8stCUfoZ3SPadG
         ivmBZFv25PGEcQV1ZzkSCuL1IkPAa/Mye6IxQRksmB4C0AxONSoUUaQiyaShv8tC9FBI
         aawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787059228; x=1787664028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UCXJXOTsM7aQw7ElDYlqfjKjTvQ4u0H2LjQVlRKBQ1E=;
        b=q2jQtazsgDuj7NUZj2fKpnYCD1Tsf8pwsIU9Qmj4+MhSpGjNql7G7xaMxCmO13rSQ4
         3zrkmoAtxquq02yyeRN3p5ovtS01ftsYBgIJK/iCvvWqF9kD7r5zWih1jgcU4V8m08js
         R3MRDxfeQFf2d+AVbvyDN0id3e9a/mK1b5Z6i8KAWlQCGMIZ4sZMZrKlDT0IgP+Si7qH
         BKAsZT47aj5U33545ZnrW6mTTtdIdPa0XYpDuo+bUK7sGfQTQJagG5tlv3IufIbSYN5S
         ltfhUFpfBnzVmWe/MJ3+STa0wm2Fnkd8XOft/BJZgaAm/Cng+mTR1ir8C2GSOtqa7Muk
         kNsA==
X-Gm-Message-State: AOJu0YxmTzIz9pdPpDuQJ4ABYYx0vHpNvXsUrB44FFGYuXWRrKrBXbQH
	ISJ18mTsYdoDNznIbM4G6P6X2oI1iMB6Nqg8x0l9dxu8kWt3Nl2ZmkXp3MZVz0d5
X-Gm-Gg: AR+sD12j4T3dipjthuXANceq6BWWXKnnOfI+piyXK755cNfLDpv0lilMsgABAE33QCN
	QICOWHlDk/gMxqytyWFdcFMxwdo0M+LqZJl6CJhroXUtXj18bo6J5oSpGNl59KTDksJgS+G4siU
	1hELM0VBY2vHQgYyIMKQ5OiufoxyZCuNJYP9+rm7F+fqXIgGEorlnr/4amZoPvMvKhKKjIWOLRA
	g9S/YI9LdxndThDWMFQ8I3JgOl3C/7CbDTywFPugzY+SBnS4jc9nqU915zUUdsSVRE15aBaZhWJ
	qeuWGt0lc6rcqPL78N7yXBB2lt7zNbsAab22eNAD06Rx1PEJ1IQtomhquAN5Y6/cUquHU+BRWfd
	juEp/xaTWOST6jhQ7RmTNKrjbucWO+4fZTgnTNZEpX5fdpZbFEKjJ834XMGV2LAVNGTutXocfhP
	m2sSaN/NinGWU34Cki6tfGA6QxKtimlAeyMZuTzC7Y6p427sF5E9A44u8YWZanj+SueLoV3c+EF
	7NAaoQMwz96YAVNM+3kjEfmPDTQE60Hqi5YoXbpNwlBeqD7zFLxf2HhNwwoyg==
X-Received: by 2002:a05:600c:5286:b0:499:5f80:83ac with SMTP id 5b1f17b1804b1-499a206e0b6mr92445125e9.7.1787059218039;
        Tue, 18 Aug 2026 06:20:18 -0700 (PDT)
Received: from snakeroot ([2a05:87c3:2001:7400:10b8:9b75:83b9:c6d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49987b25ad8sm270696685e9.2.2026.08.18.06.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 06:20:17 -0700 (PDT)
From: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To: linux-input@vger.kernel.org
Cc: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	linux-kernel@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Subject: [PATCH RESEND] HID: corsair-void: Fix firmware event packet description
Date: Tue, 18 Aug 2026 14:00:53 +0100
Message-ID: <20260818130053.45064-2-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.55.0
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
2.55.0

