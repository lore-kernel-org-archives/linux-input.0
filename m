Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E703ED5AA
	for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774455249; cv=none; b=ctVjbpjc85ec6/M46IjyVZXtDxJoAA69X04Gk8TiRU7NVrHKsjSDm0ZdUxyvX5iu0GCKBRDT2vjlk/51tVNF+hXDBJHSvAR4BvOtAeBJG97HoIiIxPvNS9unSO7NTLkIQPiqbe/Dh7E4qYyU+03DWpS4n1m0ckvUqJQKMNdpAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774455249; c=relaxed/simple;
	bh=WXqfz/CRjp+tCNRZ20cIGl65WOjMv6PFBL8LPFClGSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ktlfm5ZLG7sZ0sNPdHBy6W1DNGV+oP5UeKPxVs1VhIko+vZChFe9ALB5xYWtPOKSkzTXn52abXi/UZZgKTvykYZEbUHveQPHNPSjxP3J+A2cZuz//GLXDvmOCtsm3/pAedXlptXkL3BJCb5aDt0U0BvxeaRePpGFTVpyVD9lxbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdi9qaVg; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdi9qaVg"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c70c112cb61so70127a12.0
        for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774455245; x=1775060045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5QWtbrnIPLe7UVe9X1ymrZwEQiveci/bM6lp3XBmjtE=;
        b=mdi9qaVgbenT06npHhQXpGNhyPnysrlF5yhN8IOvWbv5w3bzI86I+8O6LI730tT5km
         QCoyak3unSi1vChoy8D9lL8TTTOT/4OoH2a9lZjVSQRPp43lRn5Df5iK/V5R6owxCTsR
         1ItvHoS9BwjQqgsgpEUpkcLg20Q9yKqdDGuMMIBi7BIMcc31hScASiOBg4TgPkP5IRhO
         zQP4ZTYHfSPoh0DbsSqVl4Y0R7C6gf7wLfeRi6UpZMWm4Hnp4lKgcCkBBnmzrbbpO8it
         5v12dSCsCTS8r59HB5FkwzamHaeg1qpvCLmW/hmnCbQ5pMq1TzgIrNfKdwcyXn0X0CRs
         2kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774455245; x=1775060045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QWtbrnIPLe7UVe9X1ymrZwEQiveci/bM6lp3XBmjtE=;
        b=suRI19sBuYN5JRRED85wsHVXn66J1CyjvP8tnMPtK3SfabazuFTK/OLiusa06I1Md2
         WUnSKXP/Jqwx6VonGTiZsEfGN88v3iqUViBeTy51mcUvXohSTeF2zGO5zfAFEQmSRR6K
         EW4NDMPpLysd/BRN+oADwrHL61Zfj+ULKewpIQqEgN7Yu/5edntz48HuCleQlqqbWq45
         JSvPjM6/D6EZRSClxKcsdDIR3v0sE0LbgBgJM2GyGP4RMxrx78g17JEvEWie7OJfXTyN
         6/N8vpa4vdi9AnfRfbOcH/0SLhyTDS/tAlMnyYixLhUEwWS0Jdd+nVqvMlgtN4RU/1gA
         EOYw==
X-Gm-Message-State: AOJu0YyTq9ryoAltf4L7hbv5DC6WgUki6RI9t3CWnfZ4M4pb0mgyGJbo
	eimhfldCKV/8C28OmiaS5lBXl485QJHGRX+5XEIrZgYwIeq0ZgKajUSK
X-Gm-Gg: ATEYQzzn3geerIGJLKO34zv85Re5xkZR/YAQ/R58j51tHWCOiCKE11in5Keo95qPQuP
	6A0JMdcFpaL8KtdIkEcKsPsZ26UOsxGINIhTPZzWkarJJr7RhyL3FMk+/sJHY7wxgj42mRWFZt9
	FxF/eViyI+nJN21M1NBUGiobH2j+9kCQZagBRrnSk9I+5fRol/3/1Aey62mu0iy7MpzUwerK6N5
	W0sz+OIL1slKnklxdb7X3ux80FWBsbmPFsb4YnJn+Wejmk7Xgp8sNAFDqK+Gy/f6KftvCxzmPCM
	siP0ZHlNW5IhaZC/tsgxn/2Sq20fH/A88uAM+WcdnqjAC6EVf/kKbXAsAPAEoerGWAZSbjUITyY
	krmEgDgSWR++SNspYGr61W4LSNjTEMARKvJ+npmV2pp7L8zq9pOtGAeBWOHu6LzADL1/Hgvmn+t
	bzIob6zEg9lAT1kAu+T4dlXyT1wS2WloYbMuh8mbeo0dznIXRT9TUSEXCscw==
X-Received: by 2002:a05:6a20:431f:b0:394:6344:e5c4 with SMTP id adf61e73a8af0-39c4aaa560amr4777403637.3.1774455245559;
        Wed, 25 Mar 2026 09:14:05 -0700 (PDT)
Received: from debian.killsync.com ([152.58.216.86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74443ccbf0sm13620304a12.26.2026.03.25.09.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 09:14:05 -0700 (PDT)
From: aravindanilraj0702@gmail.com
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aravind Anilraj <aravindanilraj0702@gmail.com>
Subject: [PATCH] HID: cherry: Fix switch case formatting
Date: Wed, 25 Mar 2026 12:13:28 -0400
Message-ID: <20260325161328.260110-1-aravindanilraj0702@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aravind Anilraj <aravindanilraj0702@gmail.com>

Fix checkpatch warnings by splitting single-line case
statements into multiple lines.

No functional changes.

Signed-off-by: Aravind Anilraj <aravindanilraj0702@gmail.com>
---
 drivers/hid/hid-cherry.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-cherry.c b/drivers/hid/hid-cherry.c
index a504632febfc..828a3cc67512 100644
--- a/drivers/hid/hid-cherry.c
+++ b/drivers/hid/hid-cherry.c
@@ -43,9 +43,15 @@ static int ch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		return 0;
 
 	switch (usage->hid & HID_USAGE) {
-	case 0x301: ch_map_key_clear(KEY_PROG1);	break;
-	case 0x302: ch_map_key_clear(KEY_PROG2);	break;
-	case 0x303: ch_map_key_clear(KEY_PROG3);	break;
+	case 0x301:
+		ch_map_key_clear(KEY_PROG1);
+		break;
+	case 0x302:
+		ch_map_key_clear(KEY_PROG2);
+		break;
+	case 0x303:
+		ch_map_key_clear(KEY_PROG3);
+		break;
 	default:
 		return 0;
 	}
-- 
2.47.3

