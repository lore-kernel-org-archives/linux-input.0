Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304D93D6CA7
	for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424657; cv=none; b=NqJX8x3FGpN0WzYwm16qLTWx04+kGE4t5zLht+jhqtuWgI/dYXcsL86Mrlu3RuoYCrKnJlE9xhdNKPelzOQ5cp8FoWDHHh7Z+qvsrN7eLQ7DfJ3r5vMa00sC1MrOa9bCVTbkwO6g159YhGOxTEmzkZgzrAt45tsnd0FVBiPjXR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424657; c=relaxed/simple;
	bh=HS/Z+AH39qfldBqX0ociWmwkWElukYrDs05mtH/qmyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElqfP+DN81DOOl79HoeNERDyXZcqYeZrJvCehDagblH7UVs0SltCRDKaNJpzEnjjy6EpnXd+EEFYW5yjDQJbeiUbRZPnmr+xlgH8dQVqouqF2VCoUfI8rsViqKCgaF5W2+pNRc2YCBOTamB422eeSgoCrF3VHATeeIMYMHuAuUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work; spf=pass smtp.mailfrom=frame.work; dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b=qbjo0itB; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frame.work
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b="qbjo0itB"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-824c9da9928so1647590b3a.3
        for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 10:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=frame.work; s=google; t=1773424652; x=1774029452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/71wsF7NJlSlhGizAzS3I8ewMhCvkUW4LARJAK5MVU=;
        b=qbjo0itBEKCsgGx1dNdmlvz/M62gUqYch+TNEygXBQpH2SY2Anvhj+H7R7AD1IeklN
         EX1K6gkVKFAY6vHgteVEJu4FWrIo1SAnrk42GDEVT5rduHZaAClLf+f5QYHyb1YDWArD
         9NfnffToHVLl167VQIJAuUi1IUSxG4IUQl/HeNzNfZ3FVUntnV76AUk3lHADRKuZBTlZ
         m3zccgsx26aGUtYH9b1Ax5hF+EgnboCNzJWMAQhVe9MnWWHcB2EoCsiezc7Vqxix4qMz
         wU1rHOZL0OgboxjaPZmpSfy8PN+aMlaVtnSZGWoOSqtH7F53MlMZ+iLoXY8o4TEPXfLB
         j2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773424652; x=1774029452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y/71wsF7NJlSlhGizAzS3I8ewMhCvkUW4LARJAK5MVU=;
        b=hIDBzyp4Oww9iZRwmyhoRXyzKBWVI98ODgd1GXfWunMfgCDjmmzDh7Y7CfFORjxPE5
         aBkpRr66vgVo2jFdUWtJAYoII3pLukSz6VnfjiZjl5K+vYem7eL2sh9kKUB5JxMwppsl
         BlKF7B1Iysh/PZ6Xt3Ufe7zGnB6BwutMftqHZRZ7ZMoQC7yMIdVTtbjQhN4GvIoi/Hkf
         MKw12kSrvDR9yajB3bS7HQTzqiW8JsIb59S1gY3neU4fDiilQF46BjBdUICrxBs8NE/A
         MloRujeISxI0Z/6BHgZEAUF8nktH8bO8gSBQzLcBBa4DEgfIoCQHDMYW9xHTwUajiTkN
         nQow==
X-Gm-Message-State: AOJu0YxoxaxPrvGPHTd6AN1eyquJFdMxQou594pjUYrqxEOQUAOUpnWc
	nijygj1PTWlBy/cfqWAzTMbA0KqJhS2dBlokKKLqKrFkuHoABvUPZ5vWBv90U/J2eAfBwBzxXqm
	JEwJa
X-Gm-Gg: ATEYQzzmHjzSaJBds8YjSIknSs9wFvmUzjyazllmJFu3PkJuJ+hLC5jGh+d7s5SmuwB
	SydxhNTwSM/z1AKOMoZMNOFSsAnpZsiY4j0A9Ces7vkhtrjzz7UVHIwSC3HuZydunEtuNlzA1p1
	JFyShZx4nxJavllsm7cbtxZ1xLpUdJtNO7v51KeS5Ep5KYaXXIMnLNy1UGv1WShu83wvNnoak56
	E2tk7LkY0Hyy82O2uedWmdkZxD0Q0neF2cq1JGxajuCD5A9OpFTZrB3B+TwtMrCIOahdRSBl//U
	jPhXbF7rD3dO1sk98qNKNOU7bMNXuLlYG0/5nfrAM1khACZtDz57ZZ7AJAgaY/EDdSm+3rrC3k1
	JRUBd+vlqwg0g9IWSDoNJyX1CqI+rh1NvfvFhyMmuGuURH1f+MowC7dVDyW5K2fdTpdla5ybBX1
	7adpdFOkyRWBaHexf7RKcmFsRs+K4Wj/uto+Im2ki4Stv6ZeY7o54QprPnWmG+OGuhg8ObOy6yA
	m7nG6y4HyXwZTA/IWFAFYxWr4RsGJmN9Mp1B76qihwzxTzlftUYTutFtizc98MP2xmc5Ud0hJ88
	kqU9FOW1Hes=
X-Received: by 2002:a05:6a00:3687:b0:81e:f1c3:89df with SMTP id d2e1a72fcca58-82a1990dcc2mr3398310b3a.50.1773424652365;
        Fri, 13 Mar 2026 10:57:32 -0700 (PDT)
Received: from nixos.home (2001-b011-0001-3a55-372a-4d8b-a513-4837.dynamic-ip6.hinet.net. [2001:b011:1:3a55:372a:4d8b:a513:4837])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0724407csm6265488b3a.8.2026.03.13.10.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 10:57:32 -0700 (PDT)
From: Daniel Schaefer <dhs@frame.work>
To: linux-input@vger.kernel.org
Cc: Daniel Schaefer <dhs@frame.work>,
	Charles Wang <charles.goodix@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 2/4] HID: goodix-spi: Use version_id for device version
Date: Sat, 14 Mar 2026 01:56:57 +0800
Message-ID: <20260313175659.268094-3-dhs@frame.work>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313175659.268094-1-dhs@frame.work>
References: <20260313175659.268094-1-dhs@frame.work>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use version_id instead of bcd_version for hid->version. The HID
descriptor contains two version fields:

  - bcd_version: HID specification version (e.g., 0x0100 for HID 1.0)
  - version_id: Device-specific version number

The current code incorrectly uses bcd_version, which reports the HID
spec version rather than the actual device/firmware version.

Cc: Charles Wang <charles.goodix@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org
Signed-off-by: Daniel Schaefer <dhs@frame.work>
---
 drivers/hid/hid-goodix-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-goodix-spi.c b/drivers/hid/hid-goodix-spi.c
index 80c0288a3a38..cbe95e0f6ce4 100644
--- a/drivers/hid/hid-goodix-spi.c
+++ b/drivers/hid/hid-goodix-spi.c
@@ -653,7 +653,7 @@ static int goodix_hid_init(struct goodix_ts_data *ts)
 	hid->bus = BUS_SPI;
 	hid->dev.parent = &ts->spi->dev;
 
-	hid->version = le16_to_cpu(ts->hid_desc.bcd_version);
+	hid->version = le16_to_cpu(ts->hid_desc.version_id);
 	hid->vendor = le16_to_cpu(ts->hid_desc.vendor_id);
 	hid->product = le16_to_cpu(ts->hid_desc.product_id);
 	snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X", "hid-gdix",
-- 
2.52.0

