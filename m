Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B862F7EED
	for <linux-input@vger.kernel.org>; Sun,  5 Jul 2026 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783277461; cv=none; b=QqtpPaT0REjmzBcDd8fxE8E3zMyBv6yLigBlsFO2TOtEEbKxA5IpeCrhT6xDPLDvJOsbwNXOh7YFk1mK2KBM7DbIFGTFx9sBYni2oIHQkLRpPdp0YlTqKKcMH8KUTyihbksHhnn9bZ1vDhLsi8wdlOK53yoWWDZoxhtoylSPZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783277461; c=relaxed/simple;
	bh=+bvonHxMTsh4xUTSbgwAdRgcDE/qkbKnJrnNj129NRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SyxusTfnGU9gTl3RQqAhAf0rb+XGk/ith0L0gN49f4/PsOI9dZlaAVJhdg0C/WRPRtLPNFDu9FrPzhIEO2CWgT7aBfYo9L/UOEdduEhZKN55ZGyHVlj75rmpctOBTdCvN50I9ae3D0Qx2MpTemY3EXGbBjSXzlvlTcGYtjgb4/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUr6dUGt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUr6dUGt"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493ba701891so17660765e9.3
        for <linux-input@vger.kernel.org>; Sun, 05 Jul 2026 11:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783277459; x=1783882259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eLjscO2UIl1sWNPCP/RFWM/HMV25zEtIGmfe5ZLJECA=;
        b=lUr6dUGty3uRglR9uAihCOmuBEpAm8uGR7LZMIVWfVpttOscZWC9wfXDL8Y/7XVLVA
         pGiC//HXhvLnB0sB0NhKYLXtj8hY5wbH2lDs0sRCp9jirdxJRoUKxlwngLBDck+uR1n3
         eJ8Ic+4Y24W+zC4fUGxKLvorSXmfxiuWkE73a4X3rgx5P9/jKe+Kl2DNT4wcN1bt4gic
         WgCUdvzkoTFqaQ2pvX49X521lWGhkq0UIA571vuJtRF5rS/Juia5yLneVX47QjDVfptz
         vlkeaYhV+D46TGu4ZRFgB7mTgJrluMS/vwwO0Y4zo2MmOlDC5xDl8e/YoeWrXiISnw4y
         tQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783277459; x=1783882259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eLjscO2UIl1sWNPCP/RFWM/HMV25zEtIGmfe5ZLJECA=;
        b=p4u2PTbMod0An+19GwPHZYO1erGJPLzh5hbEqXF4KiQlKCFQq+h51lmP1YxR/5rHHx
         pmfEEK+RAsZyikG7S2xKyWY7bjhgpcyZmgD7ujxSWaGe89KWmMiBK7IB5GlVlbFWu+T2
         huQ/bLT9qPfGd+Uwu6hfHJthEj2YGgB/Vte+s+LxvupQcH1I77tYPFPcwTY6gFMAQ7sh
         IVOxcOxUwhv9N5XzvsmbW3RNzVORTG5cleZdIOh3scJebIr0ulu6RZjM1Vjdm7jpGxFV
         E/9vlmQB1Z8mStqWhQH+bgQ3kr7jhpOVT3+n/4wX/5hqG96p1bnf4Rp3EPHFzmkwU8Q0
         NeMw==
X-Gm-Message-State: AOJu0YzakmxPbXigclgyi/gzeJot0xLANHLwbsHrTbtaEoiXAL3b3Vts
	Hg//8/LrmOA9irA+WFu5CtAcW0PJpBqEti6UaS+WmF8nsHdzVlsPAs6S4vYv9gCxA6k=
X-Gm-Gg: AfdE7clhBeG0glZiVqOyT9LH1BO4QSVPdIQr7defzykn4is6h5d5XvpIgt9YYq7x0cO
	fFQ6+k/uq9nrn3DNN6VgtxLZ2YCfEGMZhK6O9xVSf1tJ8W9BfZTS/bz4UR1tIxw4WN4zqB8oGe6
	HFuE+rW7sMvOJZPtVF+wJh18z90ElBMA//kO+GCxs3quEzCGn3geGmfNTjibqbLSfx/0mJiy3x+
	CqWOnog5rUY1Gncp4p0IOSqJ6Sq7WjOULuzbfUOLkNxoHSJKeQUQdhii/rV3+dTnBePfsRZrb7L
	s3P2Dx6AhM5EEGtask4bX6Wb2j0IeWy3vruE7CXtGCY2GRt0kDhzB1s2h+YMvcTfvEWc24faTN4
	Nq+oM8dHCTY8pO3Z6xYw3OUpEDfUEvqXwVGSMQzEkIzIGiBqw1x046dhKOt8ZQaQaUfjMq/fL0X
	SThKGlrQ3tSdp0ivN7Hx9c/7pm1TZSrB5X/GIcegCiTH15H/1E4XONVe3JIXqJxBjkM8vPkmlvK
	5p74m4buipnP+eDw5WxktNwQRKF8iSgz8CIdDjNdA==
X-Received: by 2002:a05:600c:8b6c:b0:493:b6d5:72df with SMTP id 5b1f17b1804b1-493d11fed9amr86416415e9.35.1783277458536;
        Sun, 05 Jul 2026 11:50:58 -0700 (PDT)
Received: from slusta-pc.lan ([212.20.115.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccd9d620sm234134605e9.1.2026.07.05.11.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 11:50:57 -0700 (PDT)
From: Michal Slustik <michal.slustik@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Slustik <michal.slustik@gmail.com>
Subject: [PATCH] HID: apple: Add Endorfy Thock TKL Wireless to the non-apple keyboard list
Date: Sun,  5 Jul 2026 20:50:48 +0200
Message-ID: <20260705185052.1539976-1-michal.slustik@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Endorfy Thock TKL Wireless uses the same device ID as an
Apple keyboard (05ac:024f), but its F1-F12 function keys do
not work correctly by default.

Adding two entries to the non-apple keyboard list:
one for Bluetooth mode, identified as "Thock TKL Wireless"
one for 2.4GHz wireless mode, identified as "USB Dongle"

Signed-off-by: Michal Slustik <michal.slustik@gmail.com>
---
 drivers/hid/hid-apple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index bf7dd0fbf249..0bd1af58d837 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -368,6 +368,8 @@ static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
 	{ "TH87" },			/* EPOMAKER TH87 BT mode */
 	{ "HFD Epomaker TH87" },	/* EPOMAKER TH87 USB mode */
 	{ "2.4G Wireless Receiver" },	/* EPOMAKER TH87 dongle */
+	{ "Thock TKL Wireless" },	/* ENDORFY THOCK TKL BT mode */
+	{ "USB Dongle" },		/* ENDORFY THOCK TKL dongle */
 };
 
 static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
-- 
2.53.0

