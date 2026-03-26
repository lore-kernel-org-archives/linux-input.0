Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3EB401A3B
	for <linux-input@vger.kernel.org>; Thu, 26 Mar 2026 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774539032; cv=none; b=OU+HsHzS7323ldOOEWaRP10tvhNHiBhmFq4kiRPUU2mzSfNywQ+wLR0iEgJKJKCiJQNlFJLh/z4/iZ+FYfew1IsjE8P1Vns4Qu8avEzUKsSWcFHmaHt+GtpaKz/7s+nzxXECGn9mtELZj83Hm5es0TC3a6iR/usBL8DPg9dWgd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774539032; c=relaxed/simple;
	bh=QAvWtaioTmxJT1T74HQT0PIEvGndUgH8/1G2l3K8rak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tdeiqdS+BrnJYzcLfaznTq8tKSf4kBOVkn6G2Z0cU9PjOVtS7RdlV+B75DzXBe68/8Iww/F+5Aj5P70wCp2ViAtjVoS/Nq5G1FCJXBmcGX+lIR9J1lDqDe+tf4pM5djXiq37EO4tdSs0IigsfJP28EddyfO4Mv3h4h022+lzZz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZwMIi/7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZwMIi/7"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b0603ee486so7346555ad.0
        for <linux-input@vger.kernel.org>; Thu, 26 Mar 2026 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774539030; x=1775143830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C8Ky+4PL72CND/dg4ek+qkqa9cmRxcemp7dPpgK3hXY=;
        b=HZwMIi/7H47x0rou6yKqXlXhySbAM4rhAGM/YxEwyYqpGzE+gGjTY0YFzisqZYcBMZ
         u3r8mzpgb3zPimjSVVMaV1Kyk7kjsti1ZBLUJj1yu0aexxgOyjY56eJvr5UMY2gG5K2q
         AFKEuJRqq2GZ0pfPdh1PJDb4sFfuiRtb+ZCfmqMPL9DjB/F1r7F47x9ZuN70Jv0Gwc+G
         nmouoQypGaeST7+yt3yrCL2hJ34oI/YT6DXrAVfTvJveSSTkrBLmwA4jtpARcllCoPk9
         OkZ8YoeGaFPzZru1NubhXJRxi+0lT5uVQ0c1V8QAFMDKGnQVEKEoxrqOD2HNi+R0pmge
         LQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774539030; x=1775143830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8Ky+4PL72CND/dg4ek+qkqa9cmRxcemp7dPpgK3hXY=;
        b=NENOde3wjYpDbyNlqR4YkbSqXc+L2Ol9l62lCR7UXe6pRZcvFMlkKf6PTZChbGsjBv
         unPcdJgSB9L+LGjPJpuofJlRyi/7uPL+J4a0353MqOhTVRw5JYk2rJSkOskTe18YTbIt
         qJ1ImC3mfi0UVurwbwArwHhKHZ4D6ocbSZ6xTN/+xDpe8VPH8mDHnhVxZlQmSLlm1knP
         veoqqcOrrWFwsSYyMz+YAJxnWwZjlRhaiJan8wn3CKy8oTtWcTk+6448Xv0Dl3yCvYmb
         trTrYBrefTf6QVHypeImnrwp5M3pEArB8ygu20xlgSD//jqCwKyFmhcfHOq7j/6emepa
         D8hA==
X-Gm-Message-State: AOJu0Yx8U1sQZZQFsd8Zy2j+dJlMl0w+hpTShcZAR+X+nP2cRt7v4E+y
	IsNeJZPmcw52Rudb1kNbnWXHHakCsvQTR5Y0BxQ5qScWG7ivAI3QrUNh
X-Gm-Gg: ATEYQzxxzNlR7LO6fjlsjdo2bSr7wDzHBYXDkJcpXuXo7QeWeeQBfZ1pWsdCJxy7aRp
	L8wEmSq+C7DfPT8zW/Adn9rsJ/0QV5LDePcKy3g3mY8pfDx38b7cp9anyrinqYux4poIzVkmcvx
	mGUySGQPccTk2BiuoxI+9Ofx6GGt3SCPoAauydrBDP10oaFCG2qSVX9fzsEyLWuFxPe/3zsQEuE
	lMn/NPwvO8VlfHsJqtRdVqiqvnm8JKaoEAORUZymY3sEOvBYqkuO3lzG7H3SqcrOU6UXJpKV+ky
	LZ/vZfJ5q7lHU1Arns09WhVOaf7l0Pa/YMFRs1cPSO8SL0MhAQ0R6WW6qOerbfnj9e///wsuVND
	4FsEwC6yQpCYUXhR0HU5y5yEwMG4Mip8Wtoefy0aom4KYwoRkp2Dc0rMi2jmkUccFh1KaPhy0xM
	zoQjD3Yu9w8XMKpkmglu6Mw/Qjistt8Nq1yOQRxHtCMjf2Vp1sPxLjq1KJPIY=
X-Received: by 2002:a17:903:1a86:b0:2b0:445a:8c7b with SMTP id d9443c01a7336-2b0b09e74a1mr88476255ad.15.1774539030161;
        Thu, 26 Mar 2026 08:30:30 -0700 (PDT)
Received: from debian.killsync.com ([152.58.216.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc87e661sm33718835ad.53.2026.03.26.08.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:30:29 -0700 (PDT)
From: aravindanilraj0702@gmail.com
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aravind Anilraj <aravindanilraj0702@gmail.com>
Subject: [PATCH] HID: kensington: fix trailing statements in switch cases
Date: Thu, 26 Mar 2026 11:29:05 -0400
Message-ID: <20260326152905.8412-1-aravindanilraj0702@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aravind Anilraj <aravindanilraj0702@gmail.com>

Split single-line case statements into multiple lines to comply with
kernel coding style guidelines.

No functional changes are done

Signed-off-by: Aravind Anilraj <aravindanilraj0702@gmail.com>
---
 drivers/hid/hid-kensington.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-kensington.c b/drivers/hid/hid-kensington.c
index 16839027981f..e838dc0c9a8a 100644
--- a/drivers/hid/hid-kensington.c
+++ b/drivers/hid/hid-kensington.c
@@ -25,8 +25,12 @@ static int ks_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		return 0;
 
 	switch (usage->hid & HID_USAGE) {
-	case 0x01: ks_map_key(BTN_MIDDLE);	break;
-	case 0x02: ks_map_key(BTN_SIDE);	break;
+	case 0x01:
+		ks_map_key(BTN_MIDDLE);
+		break;
+	case 0x02:
+		ks_map_key(BTN_SIDE);
+		break;
 	default:
 		return 0;
 	}
-- 
2.47.3

