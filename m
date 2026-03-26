Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2D0405AC9
	for <linux-input@vger.kernel.org>; Thu, 26 Mar 2026 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540856; cv=none; b=ZExOJ6gTCDwFNGgJRyd448W9OnwJyprCJXKbi9FV6ejh8tbtfwHNipGz9VOFmqV2DFcjMWGZJcpYxWucp+RYTHSm38ufIrlFzdR++4WYEd68sBYmb6nafY57W/WkHxzln7au9muUgnXFMGXhbnMB9H/Pr1DR2q9/igBh8hqDBPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540856; c=relaxed/simple;
	bh=RSvvyTyW2XZkEENG17lB1Oblx6erTsG+MebMWIb5AHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U2p2N7MUKTmIz02aU4JKRt11pUAQm3vZ9rblq057fKpW031EAbXaVBpB/h8yyW8Q5HR1igMaGI+VonvchvhYyYm4m2atA1oj2l4HRWhR1ULlljGbtaDFwTpiwMk3XNnd0I8y/9kZk+A3tpik3oCzn8tZG0yRY1ThjXDGR8r3vGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1vTP91R; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1vTP91R"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35a1cc6e478so715034a91.0
        for <linux-input@vger.kernel.org>; Thu, 26 Mar 2026 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774540852; x=1775145652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YvFR3KxAw15uSv4iY4Lv7/ll1oFU9FiM6COpB4SJLD0=;
        b=C1vTP91R3tiUyv2PWeb4z2FGkvx8RKe5td6mlaqZQzBwwHVd2T7ss8IE9j8TgsTwfZ
         TkwONWQC4COl6QpykqAdDyNisAflt1Fl21dQqeGAd4aiTiUj6ml+wo0vf8ltTlGa1RYY
         umenIDgjsWh67m5+SI7IHWWQ1uDQf2G7OH6IdcUoELix7V1J4DwqDkEWlT28K4Lf4Uyx
         4ufjiwxZLtmBKAZTXLJMkCJJt8DSrtGH4MNLANOwPN+OFHdY7am66a/VNVPRHLeNJWgE
         qiMULggbLRc0OU8Bj/6UlPfr1SxN/82PHkrxX21yo3J7x99KgoFJQF65ENM0uKtaHmeL
         EGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774540852; x=1775145652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvFR3KxAw15uSv4iY4Lv7/ll1oFU9FiM6COpB4SJLD0=;
        b=auqmRxW38kkQhoS3yjyoMs4D7olOZNkE1XhqiJ9LGThLaND2Wvr8P6ZIWx/sq+jgr3
         V3V6rYcrkmVHBrB0i3Wj/rkO85unODwH/N/Jte63AwjLoKsfuNx2Js/ssbzbelFFFshI
         yuNdSq3vn9NEpeKf5nSocD4NvqJTv1Yfe7lmjmrjibooJ7OAjJjNwlORVzJAbSu8ojTz
         EXcUEV/3Uk/vVbxmn3jOzTTO4JRKQd89VQTtnKywHCq8kdaC9XHn50rChinP7nb9LvZG
         +0b+sglKY4fw/oo9TJPhQ9vvuToVEPzsgsPEMmIDSa8hfHsUT3vj0OPpc2tzxzal+XnW
         5OzQ==
X-Gm-Message-State: AOJu0Yzd/zV/cgzrYk7BzTXnOP6lOVaTEBIDcRLCu+1ey1/IfJ3h9yKO
	l4hzx7I6j+osWVfY0h+xBnnrp4a3I1DAjrFWrAX4uC+EG3n31Fzt0ZFh
X-Gm-Gg: ATEYQzy6I0FKk/sctXFQLywNAZG1pG+s0HaNpbF2iImaOytfNPmD+QJ9vqZpY71gmbi
	uR2zrAX0RdnFTgjjIYVJBSMkm6WQU7dR1kejQZr2aVWzlOwtI9rFfNALJZFhgJlNOk3+zHRiB5N
	iZV0153cEScRj4tK9zQXRKzikMs6d/Hso73XEdjMlJ+x7SSZAsj6vFcV34FLVO0Ri5O5wHDkSNT
	eJaPQhC5Sx3CyWRoC4ty/h1IKV9u3Db+j64AMTKq3OglMKH4i/Ui4Zbh6a7NLofVVkTjOvTBqBe
	M/KhUyUFCy1XiI2lLHTo/BdeL17e9jPFHSz25BtLYZkQ0Zo04jtLTPvciUojJeUNQDTIi0UTu7r
	r6BC1N1pu83dmyM+fOhP56BCOsN9/5wScGtwhg/K602tE1fUTOpFRb0f7q3rb6ioMgLQLel7VTn
	5YD7KgC7ZPnZhAgusYMBR2ggWcRfb+UYXBSMFHAor9cFmKXE+P
X-Received: by 2002:a17:90b:3d01:b0:354:a57c:65db with SMTP id 98e67ed59e1d1-35c0ddb1367mr6586824a91.20.1774540851891;
        Thu, 26 Mar 2026 09:00:51 -0700 (PDT)
Received: from debian.killsync.com ([152.58.216.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22cebf63sm1993319a91.15.2026.03.26.09.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:00:50 -0700 (PDT)
From: aravindanilraj0702@gmail.com
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aravind Anilraj <aravindanilraj0702@gmail.com>
Subject: [PATCH] HID: belkin: Split switch case statement
Date: Thu, 26 Mar 2026 12:00:16 -0400
Message-ID: <20260326160016.8963-1-aravindanilraj0702@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aravind Anilraj <aravindanilraj0702@gmail.com>

Split a single-line case statement into multiple lines to improve
readability and conform to kernel coding style.

No functional changes.

Signed-off-by: Aravind Anilraj <aravindanilraj0702@gmail.com>
---
 drivers/hid/hid-belkin.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-belkin.c b/drivers/hid/hid-belkin.c
index 75aaed35ee9f..61fdcfac3219 100644
--- a/drivers/hid/hid-belkin.c
+++ b/drivers/hid/hid-belkin.c
@@ -34,9 +34,15 @@ static int belkin_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		return 0;
 
 	switch (usage->hid & HID_USAGE) {
-	case 0x03a: belkin_map_key_clear(KEY_SOUND);		break;
-	case 0x03b: belkin_map_key_clear(KEY_CAMERA);		break;
-	case 0x03c: belkin_map_key_clear(KEY_DOCUMENTS);	break;
+	case 0x03a:
+		belkin_map_key_clear(KEY_SOUND);
+		break;
+	case 0x03b:
+		belkin_map_key_clear(KEY_CAMERA);
+		break;
+	case 0x03c:
+		belkin_map_key_clear(KEY_DOCUMENTS);
+		break;
 	default:
 		return 0;
 	}
-- 
2.47.3

