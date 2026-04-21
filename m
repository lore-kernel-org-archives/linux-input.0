Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CFD3CFF46
	for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779319; cv=none; b=Er4DD2NVbo+09nZCTDuyjW/6ifx7BqOI1n0C8r8ZixjMMCUVOuBLlp8tL1Txqfj3S5o0ghlWr8mqHi+cC7Gzjaa/1W28XFzZFfJVW7K78NvW4KU4zQ2DYWAUFmlQAzDuUZE/eWHIOKCZCjXF54zdfO90iWOm79L7QknVZDM9wbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779319; c=relaxed/simple;
	bh=WbNtjzISnxSHkHdb8GZtF7HqPYrFwU8J9aZiRPQQ55E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DweWrtu9sM/fQNpwHvUA/mFtvddF9QQXF+Jkb9Zfg88NDX0L5SIl1sYaho/f9pYAgGRhhIl5rFpw8J1kv+QR0rnY0hVCcKRdIssvA36M7LT4X1p7H0NTT/JDmIMYkim+qmug2+GjaI8Y0/0X55Vd1g3F1eCCoGqj1iMQpjRZ5zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCBuZEKb; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCBuZEKb"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-35d95017a68so2801694a91.3
        for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 06:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779317; x=1777384117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9jfB9fwSZU1vF7GA4SSd9rU1L7EkYZ4ZeHeffptwY/g=;
        b=cCBuZEKbmhaNcv97JCRQCsLNc6pmckAgCM7cvaUBGmI/pTdwEwVnQl4Q6PqzR7TTOU
         Zd3C97oMmtPfj0WmaLD9BiSmTJcLcB7dvlNSEAZj0ILE8ZXQwhBVK4URC/Magf26Immb
         vZnS7ZDeIebSwmpUpl/7h9lGIGfNA0E6eGN0q0YgaEaUJNVJysUNeWdZvYzQO+/2v+Br
         p86hkj7MTIx4xqNdjPbwaroE71CjgHrz13nv8jNWwU5gomO/U9GIdc1k21TZ75JBXACa
         c5dTLKlvYsDPKYV8vH1CJ2GRRCy/rtHKQk3gMRTGsJgWBzqNgk2/IgzrvU8B3bnhMWFf
         BVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779317; x=1777384117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jfB9fwSZU1vF7GA4SSd9rU1L7EkYZ4ZeHeffptwY/g=;
        b=jvODY4+km0JtaA+2TWktzUq8sndCmHym4Lol6F71/gOWdE6GETxLmbkec9MpbEbkdn
         N1yY4Cj5Yti6tdHCWVjUBP8Tpy0jbF7ZGm3vQl9ih9M4iYAAuOMac6/g3z92D1UXjRSQ
         ijI4K55aU2YlTKf5dJ2w7gle21HkwuKu/nLxBLzUTTXKe6ncg98IFx1e785gIrqTvj1Y
         Ucz3RXXmIlCubRZy6GCU32oTWl8ix/V8EcUXl7XLrDuwhFpvp7slUXmXw1m72Ugyt/qK
         zmUinMmdNj87KgZlJrXt71GNebuVgjffXjSz4kpPdbwZ7/jKlhi5pdskjx1bckFGAD63
         X4Sw==
X-Gm-Message-State: AOJu0YyHFR7IPabBDN25ZZ0Q0WUp2Es+fSDbIOrFr84Wpw+/uGCSZevi
	rivaZ7iIHNFeah0sw5Wfvi+J1LyR0wnSW27+HaJZA2vITPMXRlc5OWuv
X-Gm-Gg: AeBDiet8BMt3BqICG2ZAjHfrwvRlCHiS0huqikwZypvlt1QLRlTbupe2I4pVA9itcQU
	B159gOC1sx4FtwWELitWNYT0HmAS0bhIA9KSZEoTME8vCDMpYTs95BDn5JP0I0Lfxk7ISPY5EJ9
	4OGBakyXC+nf4XrwYO0NhPNjWkfjS7B7MRqS1BJV5tYU7MypjJvK+BC1n0nVU1pfbZAEmX8Zakk
	D/Piv+eKwgoFj+u+r1gD+Wnn9T4bXQYFVkklkk6uh/mBRRf5Wym+d4zBng9Q7WK3CFJDe2kYhD0
	ItASLVDBTdcpop0nD1fe4fkvlH8AGjFVz6YhaAOtk7kLbOj7yXBBUKR3kG3sD+6TnP+rvw5xlF/
	Y/J9MxnpJCVPaw9Hu0j4Pjk5UaqF3GyDDJrJbbdDyWMQtaXQmAzzt5oSklW0+4Ed5KHpsQQMbVD
	Dt+yb/nXVJVEeGKYazupLEG5l3Ks/biECV6+B0Q9Cip9L7AahQdgay2bMOLOeQs0gd3A==
X-Received: by 2002:a17:90b:3c0c:b0:35b:e690:c5ad with SMTP id 98e67ed59e1d1-361404a1ef6mr18976520a91.25.1776779317010;
        Tue, 21 Apr 2026 06:48:37 -0700 (PDT)
Received: from LAPTOP-1HUHJV8R.localdomain ([2408:8642:893:d2da:c016:592:ddae:fe0d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-362b9a79176sm2558358a91.5.2026.04.21.06.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:48:36 -0700 (PDT)
From: l1za0.sec@gmail.com
To: jikos@kernel.org,
	benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: u2fzero: fix general protection fault in u2fzero_recv
Date: Tue, 21 Apr 2026 21:48:18 +0800
Message-ID: <20260421134824.35027-1-l1za0.sec@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haocheng Yu <l1za0.sec@gmail.com>

A general protection fault in u2fzero_recv is reported by a
modified Syzkaller-based kernel fuzzing tool we developed.

The cause is that u2fzero_probe() calls the u2fzero_fill_in_urb()
function but ignores its return value. When the urb setting fails,
dev->urb remains NULL, but u2fzero_probe() continues to run. When
`dev->urb->context = &ctx;` in u2fzero_recv() is executed, the
KASAN null pointer dereference crash will occur.

To fix this vulnerability, I added a check for the return value of
u2fzero_fill_in_urb() and aborted u2fzero_probe() on error. And I
added a NULL value check for dev->urb in u2fzero_recv() to further
ensure its integrity.

Signed-off-by: Haocheng Yu <l1za0.sec@gmail.com>
---
 drivers/hid/hid-u2fzero.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-u2fzero.c b/drivers/hid/hid-u2fzero.c
index 744a91e6e78c..c51f6dd80635 100644
--- a/drivers/hid/hid-u2fzero.c
+++ b/drivers/hid/hid-u2fzero.c
@@ -134,6 +134,12 @@ static int u2fzero_recv(struct u2fzero_device *dev,
 
 	memcpy(dev->buf_out, req, sizeof(struct u2f_hid_report));
 
+	if (!dev->urb) {
+		hid_err(hdev, "recv called without initialized URB");
+		ret = -ENODEV;
+		goto err;
+	}
+
 	dev->urb->context = &ctx;
 	init_completion(&ctx.done);
 
@@ -341,7 +347,11 @@ static int u2fzero_probe(struct hid_device *hdev,
 	if (ret)
 		return ret;
 
-	u2fzero_fill_in_urb(dev);
+	ret = u2fzero_fill_in_urb(dev);
+	if (ret) {
+		hid_hw_stop(hdev);
+		return ret;
+	}
 
 	dev->present = true;
 

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.51.0

