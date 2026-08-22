Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F8225F7A9
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787402740; cv=none; b=P4GTayV2Gj9Bg79gEbgzGBtVBBY6Q/JxanG3OIbXMqJBKYO9NWMNGdx7reRrRbZFI28gZYhnkwrvHLEVrbnmq2JyAJlWUCzS0ILH7nnsQ/95M9Dnv0QvD3aI8+jWnmARWWX+s2DTsvqQidONZ5imLrB3QrTzfKdZw8Jc5kBQsQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787402740; c=relaxed/simple;
	bh=LZJbmfQ2dqHw1iRvUikp1f1wAvVzItuWaTYQMuOX9hM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rKMgoyXzhnO74vlyYXvR8dXB9O8pAJ/jAWxy3vrMNAmy7FitXbe16wm8K7JI77g+GPMMou9TcUkPW1OkmJGFUPs/N0iJU2wnCGSkt6gM5vLpLIhhmT4YyphPEMx7aHph3H45qdowmgKdfaEI+4tU0Ve8Bxw5dIdfuCLyb3NDPcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rzTQ5df+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzTQ5df+"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8518b3ff3e9so1570469b3a.2
        for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 05:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787402739; x=1788007539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3hf5OrcpcITaT5sgCq/QOiAck55Lc6nxzm/MZWxuqlc=;
        b=rzTQ5df+EUmDslXEGTlCOEYA8vfXMt1hTx3w5TcS7zVvoJBVTjlYH2ALDYMl6+v4Q3
         nEWqhgSlGN3G6vGSH0r0tjXWoyYmdMMtFnjMk5XAMRxvPaTvOvgl3rbzEWp0aUCOJlTb
         jcypzL66ph+hYTmdnfGwkDQtr1zTIlHw6Mx+U6qwUo4bMZLPB5E9jrilCbCTAIsYX0as
         zHFmFfk/Y3Ucy3+sERw66iOsa/qX1KwKHHvgyN5I6n6itt0RhguuPSuR0zPylc3fGElE
         9F1K6s2KIIxoWJsnZINMnYffa6CmMPs0oHMaRKcqQPYq7Al0jgdx9I7Mobr6TD7ZiTkV
         dPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787402739; x=1788007539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3hf5OrcpcITaT5sgCq/QOiAck55Lc6nxzm/MZWxuqlc=;
        b=ZlksbYSOxbsnCUJhiBL7D979y/4n0fa+r6VRB23pZEqoN5shBGIi2nCAjoTPSzXXZX
         uoD5L7rC0gRn2tDHqyy8hGTO6rDlWFXJkM+/SVB6bLdbmN4XjpZWbVHuUWafv6cbvM0K
         8X/Wp7P1AG99xczSeunz+oASYf6o92stHLJN7arDmbTm0/tngLmJYjHW2Y8Ll/bhv87D
         SrCpwuf/ZGARN2Fpzwuc+wxiyz/+Z/jm8NhBCziWPznJjbfaPTLnGYln7WJmJ/bzqbb7
         72CqLrOK9BzN1jVV4EWChnFk4ok6poXlsA1wzzMXn6mGTCIIZd9WWxImddl4HifsCCxK
         tD+g==
X-Gm-Message-State: AFuF++lVPjeGP5wnK6oSZhia0nZRcMH0TrdcTosagR1/dYg/JHSoEsgJ
	2ZHcOQj5Sxbfy+z5kSYs+LrrWPnFjkR/w8sn0pi0cGIdTgL8xqRqU8UN
X-Gm-Gg: AR+sD10/w4cznsdSsuT4n/hhfKa90vkSnWXfAhuiUnz0eEsniRjZ09jKDFzqnW12KpD
	EPCW+WGFMg5H40KPGddcwUpVToQdTi7DB67MZrBCVC2EgAEErJu0/szHqmUw5RIIQ+1ok+WbfLZ
	2hw+NssoWjUs9XL06rI2WrwMphaXl00rCoJteAZ42CW0S8mTPLHzFeHmwWN25t18OAxakkzfdrG
	iN+QSisQmJv1pTpssxUutscAYF4Vz4NHShNWRJQQh2nVFZeoYw2VIzwBQt9evhlPwVVBBRZIcEL
	XMBpwLZOZ989qWC2jMr5UMFVxidxEcdiXgfKnxZIl1vebq2QQKCG2e8MGAPykcOIftWWkexhrJ0
	FpFq4S5RzQzXhw1nK3JvwdaCed6qeH1PsNMcBCJ+PzoJL2LQNtnt4t2708aT/hVLmau1s2i7PbP
	0yypPH/cOTWJYObS2JjJajN/D6MOH8KkjCbXTCVljYtiJzgDkM5awqe0bfCLW1cpqT/fQ1MtSE9
	SDwwvADf75IF3tguUe6ZlEclP8C91ElThQOpFxoj1bFRL0RF3AKTA==
X-Received: by 2002:a05:6a21:1583:b0:3c4:511e:26ab with SMTP id adf61e73a8af0-3cd2fdb9115mr25629725637.3.1787402738686;
        Sat, 22 Aug 2026 05:45:38 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15523489fsm3842078a12.5.2026.08.22.05.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 05:45:38 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH] HID: intel-thc-hid: intel-quicki2c: size the input buffer for the DMA
Date: Sat, 22 Aug 2026 21:45:31 +0900
Message-ID: <20260822124531.644834-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

quicki2c_alloc_report_buf() sizes input_buf as max(max_input_len, SZ_4K),
but two channels deliver into it and dma_set_max_packet_size() rounds both
up: RxDMA2 to ALIGN(max_input_len, SZ_4K) and SWDMA to
ALIGN(max(max_input_len, report_desc_len), SZ_4K).  read_dma_buffer()
bounds the copy against those, not against the allocation.

quicki2c_get_report() reads into input_buf with prd_tbl_len NULL, so
nothing programs a length, and a device declaring report_desc_len 5000
with max_input_len 64 overruns the 4K buffer by 4096 bytes.  The RxDMA2
leg additionally needs the I2C max input size clamp to be off.

Size input_buf from the SWDMA packet size and keep the 4K floor.

Fixes: 66b59bfce6d9 ("HID: intel-thc-hid: intel-quicki2c: Complete THC QuickI2C driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
Not reproduced on hardware.  Triggering it needs a controller that sends
more than the lengths it declared, which is the case the existing comment
was already written for.

max_report_len is reused for the report_buf allocation below, so that
buffer and qcdev->report_len grow with input_buf whenever the SWDMA
ceiling is the larger term.  Both stay bounded by that ceiling.

 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 0d2ad7bc3648..f6f9f95296d3 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -602,9 +602,12 @@ static int quicki2c_alloc_report_buf(struct quicki2c_device *qcdev)
 
 	/*
 	 * Some HIDI2C devices don't declare input/output max length correctly,
-	 * give default 4K buffer to avoid DMA buffer overrun.
+	 * give default 4K buffer to avoid DMA buffer overrun.  Both RxDMA2 and
+	 * SWDMA land here, so cover the larger SWDMA packet size.
 	 */
-	max_report_len = max(le16_to_cpu(qcdev->dev_desc.max_input_len), SZ_4K);
+	max_report_len = max(le16_to_cpu(qcdev->dev_desc.max_input_len),
+			     le16_to_cpu(qcdev->dev_desc.report_desc_len));
+	max_report_len = max_t(size_t, ALIGN(max_report_len, SZ_4K), SZ_4K);
 
 	qcdev->input_buf = devm_kzalloc(qcdev->dev, max_report_len, GFP_KERNEL);
 	if (!qcdev->input_buf)
-- 
2.43.0

