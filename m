Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E842749DC
	for <linux-input@vger.kernel.org>; Sun, 17 May 2026 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779025944; cv=none; b=BChSdwFgrGTRpnidlUHXof947EZ7Q18Ca50IqkppZkmaVv13bwcP+qaw4qg8tw89AONNC109QRuv3O9iYV/6sUDUeAPhOsbx/oiWg6XT/hjolNtXZgx5HmCQEuRCj4Sgw1gmViC8M1YTqvUWNHXbyl55jB9oy3X5nqMwA5QXAJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779025944; c=relaxed/simple;
	bh=9OSQaBLb6900xltJAuoF9h1NtHtsGHcKQhKm5xgD8FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+za2cSjIPh5pNFRCSoQ7zHblkS66IedfGmtvnf499LIhi+RaWqGC78p173Zi7ZGjtRtQBddOWPxWUz3MPXLh54ONLMn9+OmGx5SP8dqlTzlpxmk6EmatP9lAJSfNvJmGcQXmuhqlwB+c15z73ABx7vTeQhtM+mXdPlCNAZZBSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3JaCQUP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3JaCQUP"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bcd3ac3307so7649655ad.0
        for <linux-input@vger.kernel.org>; Sun, 17 May 2026 06:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779025943; x=1779630743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+H1HXfC+KayiHQioTXzdTqJjQu2X0tkOK+rOlXJhQQ=;
        b=g3JaCQUP+OuMOAGhWJkaEqZXsNt+VXIFiJfEvETUfhLWJca8C0FCmeyaxF/C3krAHu
         jiOY30k+Gz4wSvK3DqaHi5uAh7/8yJ4KZm1r0d3j6mJszwILtP36/sd+qr3+bBmf3Cdf
         QGaZCCFUQxOR5HrWsGDG6CjN51QdCWUthg3rU8sbhDlYcla2Fx2gaFY9+PVfAO+Ry4nJ
         R96yLzkvJ+GAbW1LOzUv6exOaXsaUoVFwKcBqt81ELlMmNeXlNz0GbZ+SMeGXyLrk5IH
         OcUDZZkZI6rov30hacpjb2sAzTM/nRiONWVgn2Lixbk+WXnCxNtCD2BxafA7ylA/IY+M
         Li+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779025943; x=1779630743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j+H1HXfC+KayiHQioTXzdTqJjQu2X0tkOK+rOlXJhQQ=;
        b=A9kO+HaqMGRi3dcT6WcYcjSB4QX2r9BHLT1ONWOHC5Z/Fz14dngk7jEv/nGOs6r6oy
         JPsYWNShls0NolJrtdic/fu7UpsBuNps1nX3vP1X73BtPfO3mtcuHzLWZqwXhsqipvuq
         Rh5iyAzPQK78/TvP35+XdGVI6OpoewsitbktPMMBPFONgLpVl1yimOqfIScKi6tfIkXw
         t3VBsQPQzNJ6MNJ8Fv88Dls+0kx3xkCa/FnUGSH5nGGq9r3nwlIxIPGmB5Bf1BJqcz+x
         tObiL6n6nN18vqlSzqh+7kNzVM6h1hOrJM8ZgsF5oM2xJAa1dsF7cL/1uVvqy8d/avGg
         yXWg==
X-Gm-Message-State: AOJu0Ywx8NoeVypkiSWvqnctKPK66szBcblk+VjZ2PEfnK5qJ5JynY3Z
	D5Ryr3+3RDhRRftTl8GjZxle1Hgxx9u9zxtqSKTdzSYoiTyJREDGvoNZi3m+pTAyw2uEAQ==
X-Gm-Gg: Acq92OFRRduVEywiyyaHM2YG6gwluhh0JMGxSBwehK8DmIv+X4bqiaVvLCVtqnvVpMr
	eWnCtTtc4Yyz3vavbVLGMKN0yfP01GfHamOimlgB9yk9UJo72oxaJBrmHB2xI+9AHHIA4qAKGdL
	a+yZzAufT1LcJ4jf+TMYmB1fwuhzVrpZQZpuW5trrDOSJP/jz/zAph1pTK4XiKLGKnBBt76TIT/
	AQRJIVL7+r3sTm9rrEIBQ7r+GKdVy5cqO6U7WbVF2p6ISWrypJUaznUto915Cv+AoFo9s1SrJR2
	iYgd7XtVpEQa0+Y5Q7cGvdiNi5aYsSHJ0bCO03dMwJiPzHw5DFCzdtVL2D1/xcX3SYHylIIY3Hf
	57LRLnj4BZBbX0/N0a3JuWlPzYi7ohaBAg76HD4J9O9a49PnPBUVMl4vqdrB3zZoRUbTd7jgKwd
	gFDllwbPxrd82tJTn7Cj9dYt9M8wmv1avhPEgjHqZ6taydPJG1
X-Received: by 2002:a17:903:3c6b:b0:2ae:825b:49a5 with SMTP id d9443c01a7336-2bd7e415675mr118577905ad.0.1779025942850;
        Sun, 17 May 2026 06:52:22 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fc47sm113873385ad.10.2026.05.17.06.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 06:52:22 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH 2/4] HID: wacom: validate report length for DTU handler
Date: Sun, 17 May 2026 22:52:13 +0900
Message-ID: <20260517135215.2220117-3-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517135215.2220117-1-jinmo44.yang@gmail.com>
References: <20260517135215.2220117-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_dtu_irq() accesses fixed offsets up to data[7] in the raw HID
report buffer without validating the buffer length. This sub-function
is called from wacom_wac_irq() which receives the length parameter but
does not pass it to the handler.

A malicious USB device can declare a small HID report in its descriptor
and send a matching short report that passes the HID core size check
(csize >= rsize), but the driver assumes a full-size hardware report
layout, leading to slab-out-of-bounds reads.

Add a minimum length check in wacom_wac_irq() before dispatching to
wacom_dtu_irq().

Fixes: c8f2edc56acf ("Input: wacom - add support for DTU2231 and DTU1631")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_wac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 6d06842b6..873d58a6d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3472,6 +3472,8 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 		break;
 
 	case DTU:
+		if (len < 8)
+			return;
 		sync = wacom_dtu_irq(wacom_wac);
 		break;
 
-- 
2.53.0

