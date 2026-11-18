Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003980;
	b=Lm8WJIkTqvilhHsGMrZQXfeWa5WezyA3zYBQEsiq0jIoSWzwcJDhWWFUzpH2PJ9F0lrN
	 lCgTB7FcDIOh8awcKeAuZi7en+S+/C0CgC1/owEf3qP2Rq1+XYbuyOlSo6TtSQEl/Di+h
	 Fh8JQnFLxJVD01NVf8OsC/cOjDcfyBsINaXIIkkVCXEbO1B6cenvRzuTG5PlX0iI4+j1v
	 uOtFn6uElbnz6tDafNbsCXyl6m2bfZ4GAuZjVCtl8CehS5udN20TDz1RxZjRPKZIdT5VY
	 szSumd645cviV8R4V1DWLeuO3ILy0uYooea7OhpJkLeKBLq0E1up3cLylP90klDOVnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VToF9amWTCrNW1AvfVMc3RB1WXmBdknEErgNhEgj6zw=;
	b=ChIQ9W60xIWoIk7eeizuawGfELvD8gjAg1Z8hpXr7nKeT4SkgPtivqpdbvfzDLRKC5wK
	 6AvsBlabDd9wO6V+xpmDOMHBPehFGwKi5QYCyrXqO3dY1bf8f956hrGGWZ0pNYBWM7qdZ
	 KR9E1rX9RRfKOLHH1sQ0+TW1ZIJRhpI7n0sDMrFmGC+UuhyF6vs9Knfkfk12jUXcrx9RX
	 X45os+eQwsQgxXcIKp/vvyrFPvuG7S3E5buxB33yKeQVjaOLw/L9sgN8DDT4F7BA2kn7s
	 pE4H9FodoXaTaNc9ZLHuX7DTbqqtutV1GFCxX5BFtQ80FJTQxkpTgK6odL0zpbtkBVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F5XNLxSp;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C0606A33E
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 12:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 930C0606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F5XNLxSp
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b3bf3bef9aso828817a91.1
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 04:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795003978; x=1795608778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VToF9amWTCrNW1AvfVMc3RB1WXmBdknEErgNhEgj6zw=;
        b=F5XNLxSpHySTF+ld3i9RFIcPWLa1BLVpQca8ENIgXFtCD+DgnIKR1q7WV1SqX5rkcE
         yZB+VicZ7r8xKwIsaNkjfDeY3vyPoGRMZ63139IofXj8hJw3VPd7HVHN2JVkmJgTrW5G
         i68SXrVRISqis0XYmUHaOxfy7OhXl8TyOJa+K+oIffqJVoz3qSLJr5zTB+9wRkVshVgK
         mtM26jqrhVR1gtFP3W8qdFQq27JnHS8vXF7I+gnLz4XUHgJaAOTTGGetS+I2c4te5j6M
         QtAkOc1qaDXpvLZrMOqyjPVoEiJbqq43h8Hi0/g+oOT7jZhf/SvEWmY3XTq3cc+H3eP7
         X+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795003978; x=1795608778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VToF9amWTCrNW1AvfVMc3RB1WXmBdknEErgNhEgj6zw=;
        b=smNEA+mtXUYkgmdEnleXLFvg4y/585j7cu5G+Lz5V4/vcoLuskUmvMLRYfmjq2mb73
         peKSSjCJuLs6dpfy0eJ2KRwnUMaZpl6oHUmpawOBFRg5/PnriNcdUFjcz1+26hfbQU8a
         PkDY9RIBP7PIEZlOV6PBaAZXtOaRSa4PfSsJ6607O3MavJAjDmhn6IvZ1T0eIuc+HdH5
         m694ivAvFcHpPrJ1nFqOICv8Wn87bXY6KOKiHYVe+rgwvZfxO8xiscK3AIt/KsHOLJB3
         7k8j6/AXfD2ym3jhtt1JvApgRP2u7C0HqaoPqITroDx8KYgbJBHc25nGIGFI4UPnicnJ
         gGHg==
X-Gm-Message-State: APuU4Z94sP4UQfpFG9uxSlB9zZROaveekiiv7tC1tEHhp1M1QmqFeUoj
	5VsOmRU8CYtH6kaQjARVDlpk5OeCivDglw8NjlC9nrQx1azGMRtHiWwF
X-Gm-Gg: AZFdTZcecidejuRk2PSPAedgWQlKU0ddIN4/xCy4pwjt7M79ri5VmrlVBFKmfLGoEuJ
	ycM6M1ovbhnls32M+XThyu7613OYamqlXUu+0xEscdQX+WO8EOy5aoYkPVNx0V8rE6x2BcTjRJ1
	Lyucbu1pPDni7jPDInwdu82i49/MMkA4Co5jws7AouBF9ee1cZRcmBodRerN2yBZ0Pri+Eq/CjJ
	x4D3t0Fo1vaw3SDd7ycNOFwaOK7GrzMbBGx/5AIkzJRvi2KjPMvdXh1oum0mKG0I/+kdxDlvzGM
	SwsUE5oqFZx+8t2Ap0X1efYGMfuAWPfx4nlaW6/xkzAaFM4nCtmgq427QtPkNMet0pAh4rBPk1B
	fwwQXTG/0js2CrYMAy8ImV45KRKNKv4VOL8ngoJ6o4842tXRJYVqEO4H45ww02K3dMTqeB/chuU
	VjXqMxwtw6ecjpaABIbt6R50HNQb4Tmo316ez90pTHQhboynwRmT23zQxwe7p2kbV2Ig9d77kCD
	1uJbFcodEAlTzuExDvvso4vgIuo/osvw4LBmozjAB5PPr9XzBIetDJg5pZZKDq/PpGYvT+CBdR5
	/39uOWqfDDc/ZFzSOVLS6fGq4J/LqDgWwgwY8M4Vsj5j5+F8rVZ35w==
X-Received: by 2002:a17:90b:558e:b0:3b3:b453:2453 with SMTP id 98e67ed59e1d1-3b3d07c842cmr2806712a91.37.1795003978466;
        Wed, 18 Nov 2026 04:12:58 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d1c03e04sm4095609a91.15.2026.11.18.04.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:12:58 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Input: cyapa - check the panel scan response against its length
Date: Wed, 18 Nov 2026 20:12:14 +0800
Message-Id: <20261118121214.3571621-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cyapa_gen5_read_panel_scan_raw_data() takes the element count and the
element size from the trackpad's response. It walks read_elements *
data_size bytes of resp_data[] without checking that length against
resp_len. A large count reads past the 256-byte buffer on the stack,
and an element size of 0 divides by zero.

Return -EINVAL when the elements do not fit in the received bytes or
the element size is 0.

Found with a CodeQL-based static analysis tool that we are developing.
Both reproduce in a userspace harness under ASan and UBSan, which
report neither with this patch. Not tested on hardware, only
compile-tested with W=1.

Fixes: 6499d390a166 ("Input: cyapa - add gen5 trackpad read baseline support")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

I have no PIP data sheet. I assumed that the element count of a
response covers only the elements in that response.

 drivers/input/mouse/cyapa_gen5.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
index 59f6e97d54827de..c346f16961cc97a 100644
--- a/drivers/input/mouse/cyapa_gen5.c
+++ b/drivers/input/mouse/cyapa_gen5.c
@@ -2265,6 +2265,11 @@ static int cyapa_gen5_read_panel_scan_raw_data(struct cyapa *cyapa,
 			break;
 
 		data_size = (resp_data[9] & GEN5_PWC_DATA_ELEMENT_SIZE_MASK);
+		if (!data_size ||
+		    read_elements * data_size >
+		    resp_len - GEN5_RESP_DATA_STRUCTURE_OFFSET)
+			return -EINVAL;
+
 		offset += read_elements;
 		if (read_elements) {
 			for (i = GEN5_RESP_DATA_STRUCTURE_OFFSET;

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.34.1

