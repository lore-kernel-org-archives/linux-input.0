Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A0407119
	for <linux-input@vger.kernel.org>; Thu, 26 Mar 2026 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542097; cv=none; b=Zu5Dv9PeZzt92G+jb4QpPb9rdxu1sSbouoDBLlOSaUCwcZdHeycehKXw7D/qcKuiPh0PzMQshF1UUSpugLxS1LZvh3wAT3bgLBRkYKlVAw3safti5XZ9G944WXl6lap8NPnSqCaSaVoILHyXp+jUmh9+8K174oChknD5o1nUNKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542097; c=relaxed/simple;
	bh=VsBCuJjOEYNZoy3NcHBcjZY1NT9pC2WZjyRqEq0AhnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=chbsmgVWXGGmGDN/BFBVAZ3sF3/mmJY0AeLrMxmTmdglDmp3zl+Jw2xPyVsgWBTk9zoRAc2LSSrtgZEPj+uIIAKtnSviePtYLWYg2yL2UV8tiUtsioJJJH0o85WHOxfmdykU1md+diHqx8BYWm5Ipky5qULWSUHOxBQ/4KBiHss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6wvoPNj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6wvoPNj"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35c206f0481so810331a91.0
        for <linux-input@vger.kernel.org>; Thu, 26 Mar 2026 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774542095; x=1775146895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2FD8jHyD19Y3WwhdoI7heMDMlnt3ezmsGui98ikgby8=;
        b=E6wvoPNjWydRY/5IFrBezmf1Iird/acFOFlr8JhpYwXzEqkYOBXrxuFeuJfBWNFrZh
         iELU1GsBc+hXNGTG1U3+JSLXdscVQYEds8xV3tS6vAseRLirg2lkhpmweT2HfYKaJoJY
         mQBR7cYcUPOoZHOF1Wio9MRAoP0wmuery9jLsJspkNbMEM7koUIVNDdh5wIPZ3HOs4ga
         n6aCUkWGBs4/6mVuvdZvob2TwXn4gWicOeK4nSkWeavHXban0c1364JKwRA+tT8L85Bv
         tiFw6jaj8gKHWP4Wt+BVzMb5fVIo31cOHOE4ZixVnS0HURk4tEsWHqinANEowTFcpk9D
         3agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542095; x=1775146895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FD8jHyD19Y3WwhdoI7heMDMlnt3ezmsGui98ikgby8=;
        b=rQKIrcV1iC3lUbJO0T4ohjJy3nMO9Hl9Tj2jAERcs1LdVbp6/HPmJNDlu7rOjMHHJS
         wPoeMS1uihP8fvb0UfcPaHNuF3uClJw6C7se4x6gkLxP/tTQ/yVJ0e3MN+tMAK1i7xgu
         PEd6Xx7F8QvyZ356kYOI03QXHRGnzuQw+c4xSOTI25k7e8ev3sumIQghelCLX39HaASe
         OrvC0f4gML8uuvpL+bFTRGGsEIwjoJ029SmIgHHALnfFFtth6JhwQvnDyRM8POWpD43G
         Wo1BS314OecP6nAoWdpQupnAKBhnPBHhD45GViK5yIEktP5eEjULYrmIs47WLfBzhKAO
         E08A==
X-Gm-Message-State: AOJu0YxxnXeyeB5tmENgrH9sR59J0HjXsrIV+AllGbv+5DOpnJ8QKXPx
	XchmjaCsCgzwM0ht12X/nTR66sO9YzTBoXFATpyG/puUS78szH6XinXck56TXDg/
X-Gm-Gg: ATEYQzx83GShrQoIm1e31NHon4lfuVGFopsb6V2iPyJjgz1/GjYZha2oBBDr6YFuypj
	aCORhUT//ljLdO/mI0VnyApkABhmLgBbjNJ53ZNYj4vY1AvSt8puoqSytnPJuSy2wtFXgT1ZVhi
	scZ+ukJMBKUvN/OvkdKILCF8PGWl81UHAHLS06RgJUrRU6tu34BVKoGbhP/xs2VqnSaZQGL0S3D
	4nkqWNCmFYu29RrxR5Tpl0fPJq27nUYN8RfbsKGCeW2EhMWn9kciG/hujheOfExDbXlmWBRedhB
	haQ1RZXloWrbTtR8CAoG7f/ME7fp/jEhuZkc+C/q1HHkcTemYD/j2bSV7kYhuxQtRx/Wv+dxKnt
	fMYr4yu9v++McjgpppHXym+0KXbjRw6gkYeBnv343EvSLVINL09Uh1wVgtmWsav1rK6+eWJL4NI
	LhvCQAd2ScWut5wN0oQ9OhMqEaz8pC0yOyeIVyuNrUqCzaEo9Z
X-Received: by 2002:a17:902:e54f:b0:2b0:58a8:5fc4 with SMTP id d9443c01a7336-2b0b0b55738mr93713885ad.50.1774542095251;
        Thu, 26 Mar 2026 09:21:35 -0700 (PDT)
Received: from debian.killsync.com ([152.58.216.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc881e9csm37296715ad.42.2026.03.26.09.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:21:34 -0700 (PDT)
From: aravindanilraj0702@gmail.com
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aravind Anilraj <aravindanilraj0702@gmail.com>
Subject: [PATCH] HID: sunplus: Split switch case statements
Date: Thu, 26 Mar 2026 12:21:10 -0400
Message-ID: <20260326162110.11378-1-aravindanilraj0702@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aravind Anilraj <aravindanilraj0702@gmail.com>

Split single-line case statements into multiple lines to improve
readability and conform to kernal coding style.

No functional changes.

Signed-off-by: Aravind Anilraj <aravindanilraj0702@gmail.com>
---
 drivers/hid/hid-sunplus.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sunplus.c b/drivers/hid/hid-sunplus.c
index 64e4cff8ca1d..a1703f6dc727 100644
--- a/drivers/hid/hid-sunplus.c
+++ b/drivers/hid/hid-sunplus.c
@@ -40,8 +40,12 @@ static int sp_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		return 0;
 
 	switch (usage->hid & HID_USAGE) {
-	case 0x2003: sp_map_key_clear(KEY_ZOOMIN);		break;
-	case 0x2103: sp_map_key_clear(KEY_ZOOMOUT);	break;
+	case 0x2003:
+		sp_map_key_clear(KEY_ZOOMIN);
+		break;
+	case 0x2103:
+		sp_map_key_clear(KEY_ZOOMOUT);
+		break;
 	default:
 		return 0;
 	}
-- 
2.47.3

