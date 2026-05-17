Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAA724E4C4
	for <linux-input@vger.kernel.org>; Sun, 17 May 2026 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779025941; cv=none; b=Cj6YvEH55Oqs+aWOfNeUj/x1EpMPKvtNd2J3q5qR7HdBIxV6MJdtaWEbLCvzBlOM4u0ULHvYUfyP/2X+E5Nx9qjIJxumdvGemX3i41/S9Kclktb65Hz+vSUYzbZhnE/C47/iSTR79XJoCsRud9/n58j0zUaZbPK5lBch7mCyMPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779025941; c=relaxed/simple;
	bh=h9wtCFyFzLcO5jEPh6ZyLGnKzsR9VPlqSRMjF9S/Z5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TKakzwqe5gtk9gyWqSJGPmWXwHN5ZoQuhsx4oRDgTJQTQi6j+pylyW24l98zGDaqCHZnJK0pktYWo8+DbEwe9fh4OpHkxL04+lZS+fulLoUTakC2uXoyFkyOO9hDVuFjge9KR6dyBQnrMuHkyykxROHAIokPP/toyyA5cNJ5YSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcMyu/Yi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcMyu/Yi"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bab82d75fdso5881545ad.2
        for <linux-input@vger.kernel.org>; Sun, 17 May 2026 06:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779025939; x=1779630739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgCyM9TX/SDLwUVzAsJaESZmJB2eQmJkR2yeVp3A4iI=;
        b=AcMyu/YiHnuv8UHNrshBKcUHaBruU8r/Mcv/3mpYinz4ZnZkcwnmbwP78k3L1nLOSG
         mRUHngbLMUiR180OjGSjLSqJYRNF2nBMo97GMLTN/Cbb+W3U3gePvaFnZgQp2UFdCf9r
         hvFv/NHudjvZj4PhBnn2qtnuVZXEKbwfhJFsmHA78qYpHnG8vci8Vxo0ODMyg3S85l3H
         ZA780cCPO1PtW/9nMoQ2RCSVynehZSsDATBhIRkKKylV1Zl8upVup62sVXpBi7GRlWUj
         8nOT/6B0JoVivvnwsKYOtVCGv/FdH45N1h37KBikvyWr9QupLmiJOdQW0ZcoVNaiazCe
         lj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779025939; x=1779630739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgCyM9TX/SDLwUVzAsJaESZmJB2eQmJkR2yeVp3A4iI=;
        b=SGIu3ilwcOuwn2usQvBruh/ukruZxvEzNtm2SjbUrstSEbOBRxdGN+hdZHWYsm96bG
         3eSHm8Eih4pMLRAuh+TqVL+okfjKYw2fQxoH2mP2yTk/sDz3u5i8txAmDW5GSclf0xyP
         liVulrIzEKT7+jh8ccGjLK73bZ8VdC3HFOvpbQrWAUE2tmITBgEJeugqao6wecO7GYkZ
         qleJzAD8/DwHlagOzIKARMKU2o9pfgWbJk8LgxhxL1hWaipdt3ai5AhSkGupY/ZIbCed
         sivVRHVHsQAZtLJMI2fL6jtumojyUcZLa+DIpRb7SQVAvVnSF/pI2gWx9rIClPhsGgrq
         Jk/w==
X-Gm-Message-State: AOJu0YzayB7qvRwvdjq3qV0jJ8/GYzaMp0/nSexGajTXL0ZBIti+0TJ3
	j0qfBTK5NJ3cb1uxmIUmXdKV7i0wIA3GkoEQssAZc7LyIbbePmUYP47CGZtG3VeKAUdlTg==
X-Gm-Gg: Acq92OEeklYep2osiSgppiB07rDpxQLxt06cWoRv8kljvovOloyM71xaWEKoJtwc2XC
	JbAmQCusZ8u/aP3Ga+yEzNuwY7HVBydjrfP0lJCfSc0eQGMtYW9IPlg9ckxkKHv2ach546vy8r8
	TzEJ/EWe1P6SHjxJBeDyu9uNABA3VbZGnD+gMzL3+fi+HKyoKFoz9RzQvMMAkzA+34xZ/OG8fBV
	jI8N6EEF9cDvj8Vv7A5f8IfNDheA7M37jx71Eq+sNIvvLOYK1TCtZ29Vc/0DWkGshoSa/rKBZtq
	kdUlAZTAVtnoywOaNsZ7esS+GxO4OzVKjIIhgekvtkLrW1FydwgrICmgipK0Dspi22mgpk567jp
	+SfoNrmfmjjvruyF/NZMJJyzXxT6ygUp6d0COvPg6MYz+1DCvevXRMFJO9zk6r80mjnPg0aF+e8
	lEtZWwYsAuJ1/4Zel5xBBJzrGz75BSuS0PolwRiwkLmM7kZLr4
X-Received: by 2002:a17:902:8303:b0:2b9:f8e9:70e2 with SMTP id d9443c01a7336-2bd7e782ec7mr93513875ad.8.1779025939377;
        Sun, 17 May 2026 06:52:19 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fc47sm113873385ad.10.2026.05.17.06.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 06:52:19 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH 0/4] HID: wacom: add report length validation in irq handlers
Date: Sun, 17 May 2026 22:52:11 +0900
Message-ID: <20260517135215.2220117-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several wacom IRQ handler sub-functions access fixed offsets in the raw
HID report buffer without validating the buffer length. wacom_wac_irq()
receives the length from wacom_raw_event() but does not validate it
before dispatching to the sub-functions, which do not receive the length
parameter.

A malicious USB device can declare a small HID report in its descriptor
and send a matching short report that passes the HID core size check
(csize >= rsize), but the driver assumes a full-size hardware report
layout, leading to slab-out-of-bounds reads.

Note: this is not mitigated by the recent HID core bounds checking
series which validates actual_size >= declared_size. An attacker
controls both the descriptor (declared size) and the sent data (actual
size), so the core check passes. Driver-level validation against the
expected hardware report layout is still necessary.

Tested with KASAN on Linux 7.1-rc3 (slab-out-of-bounds confirmed) and
verified kernel panic on a production device via uhid.

Jinmo Yang (4):
  HID: wacom: validate report length for PL and PTU handlers
  HID: wacom: validate report length for DTU handler
  HID: wacom: validate report length for DTUS handler
  HID: wacom: validate report length for 24HDT and 27QHDT handlers

 drivers/hid/wacom_wac.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
2.53.0

