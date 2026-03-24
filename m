Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047A63D5258
	for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774373735; cv=none; b=qAGyUhiV38MOesWQUI/FmiEpNqty3ix8RUsuoT8AXnOvatOVj6Q8riL3hsS5EfVvD0OsrFU8RtRtOrA7Xfs561CFxdiXW4rkDQnzf3Jjre2rUQNW8Qh8Nf6hrC0k9kUP5dIclTqF8Uwv2VIobNPHNvt1cKeOZCE0WxCWleJIV/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774373735; c=relaxed/simple;
	bh=ovVs3AWOZjlyKru7AE1DWVSZIN+/WI9oHTLy46VoejQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3lWbynps1wuA3ccHJnXCl2FvNSDVUbwihwKB1vvi8isgbwUYiZzuqYblMpMrmXEY6A8qhn/5I80TfsDDoVa2c+vg2vwbD68Qbrmx+CCFhJ7nfuL+wkAzjq8xSdEm4iJjKIoTJw6JLX6ZnQwh9sPpYewBUuFun0Ktboi0mVZ1Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oxkX9Zi9; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxkX9Zi9"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56ce1384618so975599e0c.1
        for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 10:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774373733; x=1774978533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KyYn06XDchtaJ0qC9SwQHF6RATVlz66/knGROoEPpBE=;
        b=oxkX9Zi9HxEiKfCtqdjJhPdCph1anegLeatQSlYHx4pTYvB1m+aTJqxB0kCZsOtEVY
         cFIGDEluvoklptcI1FMS2TaeMDPevGpxYDAToj7UjA0czz4jcLkyJ23ZfJNgJQNvo0wc
         D/Glaeg4XDyXu75Vl/y3tzVqQC6QiVuShvS6bTaKD3P/Yq6r1p8XUAFQmyLe+Ndf3yYX
         jeT5R2F7Zu0ZrrTQC6u1/jb6vuUUmnZqyWU52sFiJNtHC32DHdE7UhQHeg27RN+E7M3h
         5dBMwaJtrhiUALSstvMF6ifbC/wb/nINIK6PHHjts2Martw7e1bRhjq5jQOsKqq6E7N1
         ifgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774373733; x=1774978533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyYn06XDchtaJ0qC9SwQHF6RATVlz66/knGROoEPpBE=;
        b=eCsNhFzmonpxmnlfpk0ngZH3sm30cXm5DOhVtwS3fhb9Miq1h6sy9P9D0R0y08wSIE
         51ZXBfxgZPytWTFB1Cf4nDVwe1lBW7uVr/L3a1ibcQ7jG1X3X+m53TNssGNXP3U5um/A
         m/TAbvOvHQIS95w//gjUGItxbC0hUnayG2F9GRvLWJ0USfp0zGuT/csB9mnpdAiBLNsg
         KJZ+X/a1oa0zh0YgfjkUpP0ifZS98d5T+24UOnR2t8Y6UTJLcZo2po0Djq3Vg5WmBVvu
         12WpGZ2SNnrD3SKxSusFF71+mUkKktOwhsTrZ0trgfpoWFpYbyxPr4XeAVIQP7kXBwUn
         hbpA==
X-Forwarded-Encrypted: i=1; AJvYcCVnnuGxqj1LD6IUk0kE/2RNVsqNJ5JrW71t9USNzRWlC5Nv2dSSbzicgOui/AoF4N7RsrMs9tqKx0yt3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0IcdKEvNjbwQAYV/2syivelypXmQbkqEgvxyosxNZYBdzQcyS
	FYMoaQT49RgVLKL7aUNXYqhUbIpkWfDBhAdInobV3f1eBjQUU0X7npb6
X-Gm-Gg: ATEYQzyXkRdZUmWUaBVZ0+GAW9s+7S69PvtmVp1VLBTFk43kW3bwEpcFhbjJCVTvKKa
	E4WboM5jZi/8+e88FoGvE9yJ4642bmWU/dkUNUgVmKEIyrHYc2G2vuhx860pjbcyi0YNL1DQAls
	AUirGnbHLndpiUD5+mIx6ixwhoJpW9POq8/i9beES0J43SUgadz1zmIuLiidmGOJXQrrw5+CFJR
	vwQRLQNPJg2BCzByPXA6gp5CPgD3GAm+yhLwdgiDzwV05vYA6uWF5x+7eGPJNrmeT+NpHH3L6f3
	rmjRwpKVpGCm/d337MMoLjDR5SjMvlINSG8O4jU1GSBsrssPEvoQwQG7ymG7PGlwy68ZfTszJ8w
	PYjnYI4GOhmrKwdzfXtxAOk7dS1536YrbxT7clbZdKkgDJS6Zboy7mR24ksglJdQzYqsyuKEkra
	pg5Biv0we+yRS/dYgSNWxWjlS5
X-Received: by 2002:a05:6122:e1ae:b0:56b:5893:d042 with SMTP id 71dfb90a1353d-56d2207aecamr479688e0c.12.1774373733002;
        Tue, 24 Mar 2026 10:35:33 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6dd:aa::11:17b])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56cdd9f7c6fsm16844594e0c.0.2026.03.24.10.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 10:35:32 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: michael.zaidman@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH] HID: ft260: validate report size in raw_event handler
Date: Tue, 24 Mar 2026 11:35:27 -0600
Message-ID: <20260324173527.11321-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ft260_raw_event() casts the raw data buffer to a
ft260_i2c_input_report struct and accesses its fields without
validating the size parameter. Since __hid_input_report() invokes
the driver's raw_event callback before hid_report_raw_event()
performs its own report-size validation, a device sending a
truncated HID report can cause out-of-bounds heap reads in the
kernel.

In the I2C response path, xfer->length (data[1]) is used as the
length for a memcpy into dev->read_buf. While xfer->length is
checked against dev->read_len, there is no check that size is large
enough to actually contain xfer->length bytes of data starting at
offset 2. A malicious USB device could therefore cause an OOB read
from the kernel heap, with the result accessible from userspace via
the I2C read interface.

FT260 devices use 64-byte HID reports. Add a check at the top of
the handler to reject any report shorter than expected, and log a
warning to aid debugging.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
---
 drivers/hid/hid-ft260.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 333341e80..7ca323992 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1068,6 +1068,12 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct ft260_device *dev = hid_get_drvdata(hdev);
 	struct ft260_i2c_input_report *xfer = (void *)data;
 
+	/* FT260 always sends 64-byte reports */
+	if (size < 64) {
+		hid_warn(hdev, "report too short: %d < 64\n", size);
+		return 0;
+	}
+
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
 		ft260_dbg("i2c resp: rep %#02x len %d\n", xfer->report,
-- 
2.43.0

