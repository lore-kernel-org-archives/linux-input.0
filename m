Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C133C0608
	for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784979414; cv=none; b=EzUwhTKyivZJu5ul1BXP8plJI6npMEUmGWSeMYhuIUyjYxNLyB5lCHWbgcmsyt6TiFfvF4Y4qdxZ7kaotYX8fOOJpFmqUjTguYVmQOV1DQN7LwUt1wfwzvYVGHbgQGp+ikQBC4ApLlnFB4Bgf5Q0CewGu5ZugsCUTL3qM9I1hXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784979414; c=relaxed/simple;
	bh=tZJmXbhgj3JSsNgOBmimBTAW3uGyY+mqY/TufiQ2S2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IXUgX4JQHiYxWOEXb6qBPc+R5a8/o+I2kpWxcupmqCNxP58WTjtkrfGtjhOb/2CtJOks7VPNvp6JqwuLPO1MUeAkXFH08WUH0MSKtJeG/qvBc8YCu65ltAe3BbUUcLQ38PR2Gwi7uwvREtPOI7CiBio0G3hM4ExVvcXNaU/+ze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=suVT4wcb; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suVT4wcb"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca957432c7fso953478a12.1
        for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 04:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784979410; x=1785584210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pJkmKF2j7wJ+FjnE5oUNx+TfAZGFVq8yqQXZVyQI06k=;
        b=suVT4wcbk5AHEbHqKap1JGUxG8u4iWIbtFImWm32UJqSqI6fZjdpGXwJebrbvhmibh
         86OKMsMWTBBDHZu1eFhATeCZGYeNUY2Xb6XfvjBOphkxGxgRirYvD9gTvz7hNqTwP+mp
         bLrSdxKuddnVMGCv/iLqltZXmzzKMOxbjeV87sotNYCCYpAxEl0oCIhoz7cuO7Oi7IrZ
         tAuPp1+INd16oLYWCESKRO3S7jkqsSs7+CHRWiKYmjhnsoaSsITnagLz6BrkrMZrnkSh
         bRg+9PksE6aGjowxwf5lJSxhwFb/DwXScT8CPsc2YOUOays7tTA2uQ/uF5S2k+co4Y0X
         a9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784979410; x=1785584210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pJkmKF2j7wJ+FjnE5oUNx+TfAZGFVq8yqQXZVyQI06k=;
        b=mELokIlPQuo53oqeTNrUcIzXabFtT8ptMLJ2ksh7VhL2Q8xpv3Akve9l79buPVlo6r
         7OREgHP5ZDqMoicaPoCTiS/YPsx290RR+emDbKFBi3BBY9RepodLPixvdso2XJTmysqL
         As5IMwBb/JpRRKEJ2+LZOEY9Ebn8Zkmy16jICwKNTEnC4CkQHZUkxJPLI6lGUdktpPUv
         KfLWZ/PyoTG5tqdkO4R92JnQu97UToOiwrMw43rLQbeiDjEqa99Y0yDfAxlxL7mFgsus
         BpChNMWdSi3+CW0345vM2A1RG/LN99+x9Pnru7glHRuuAq25cP0ApPQVNNq/jbwTeYjn
         tBfw==
X-Gm-Message-State: AOJu0YyMLmam96UBzDxclo8wYfytm/gC8twuMv/udhvHeFQTbn7F5hpq
	/x23D8ltSVYBSxcXtup3sqINv13pufFKnqP7eLBEUw3XPWmWhu9FND51rCSWVTeZ
X-Gm-Gg: AR+sD13RnhGpNjcDA+1JKR0aCyOWyNLo2han8SEBsTrkcXH6fL1LXPMBjAVjSRkvJiS
	b3Pwt1b9GlMfFYSMfng6uGJRNBh9m0XO6r+xblqsjtjDK3B+wdEllapRfX9qI9sFtBtg7klLhgw
	pCDnAutC1kNqsp1/fV049rsAa32J2Mi9paOnp7/nqkxj6aO3XoB899HdsTD3+ji3eO1Dde60Th5
	PD6Yhwvc9pDEUw7pwSuE12jgZ0fCTYO8rDecedfm/9jJw5IAu5jkijp/Nb0olJywinq4GxziINu
	y2X8/JaSFtTTWDjFeyPYSXgIrYbY1pVGqsp+Z9N+mkcsDvoZaCy1bE4JvwChE8YHbOZOOrTjHyQ
	Yj1yLkes4EFwbbVSzvq45e0yMQcXIQPGN7Pw9qw5CsXWe0x57ribQJB99M/lGJicNh52wFFDY1w
	hZ/4LuzceZ75ic3iFPAuKoaXgxgA==
X-Received: by 2002:a05:6a21:1505:b0:3c3:ac9c:9a6e with SMTP id adf61e73a8af0-3c67e1a297dmr1874144637.68.1784979410208;
        Sat, 25 Jul 2026 04:36:50 -0700 (PDT)
Received: from ubuntu.localdomain ([49.43.243.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5cb670sm14422452eec.31.2026.07.25.04.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:36:49 -0700 (PDT)
From: Bivash Kumar Singh <bivashraj750@gmail.com>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	Bivash Kumar Singh <bivashraj750@gmail.com>
Subject: [PATCH] Input: elo: fix coding style issues in elo_setup_10()
Date: Sat, 25 Jul 2026 17:06:38 +0530
Message-ID: <20260725113638.5147-1-bivashraj750@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two checkpatch warnings in elo_setup_10():
- Add missing space around '-' operator in array index expression
- Add missing 'const' qualifier to elo_types pointer array, since
  the array is never modified after initialization

Signed-off-by: Bivash Kumar Singh <bivashraj750@gmail.com>
---
 drivers/input/touchscreen/elo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/elo.c b/drivers/input/touchscreen/elo.c
index 6814d5789b6f..97aeec7ef709 100644
--- a/drivers/input/touchscreen/elo.c
+++ b/drivers/input/touchscreen/elo.c
@@ -257,7 +257,7 @@ static int elo_command_10(struct elo *elo, unsigned char *packet)
 
 static int elo_setup_10(struct elo *elo)
 {
-	static const char *elo_types[] = { "Accu", "Dura", "Intelli", "Carroll" };
+	static const char * const elo_types[] = { "Accu", "Dura", "Intelli", "Carroll" };
 	struct input_dev *dev = elo->dev;
 	unsigned char packet[ELO10_PACKET_LEN] = { ELO10_ID_CMD };
 
@@ -273,7 +273,7 @@ static int elo_setup_10(struct elo *elo)
 
 	dev_info(&elo->serio->dev,
 		 "%sTouch touchscreen, fw: %02x.%02x, features: 0x%02x, controller: 0x%02x\n",
-		 elo_types[(packet[1] -'0') & 0x03],
+		 elo_types[(packet[1] - '0') & 0x03],
 		 packet[5], packet[4], packet[3], packet[7]);
 
 	return 0;
-- 
2.53.0

