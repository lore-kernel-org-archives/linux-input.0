Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AFF3033D6
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779647043; cv=none; b=htDXx/COtxETZ656xyylme8cN1ZiPuA4Jk/fVzzEEvWzIJtzVJreoDKfX3HrsSXK5OgPrDY5PmXlw4oGctRv7wxMehzadqA9A9c75vrijrKIo6B1oWwJuOQEW4YUgfgqD5Qmt0BkxlR3gW5WaYxHS91Y19oJf2DUKxL9zyW9Fg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779647043; c=relaxed/simple;
	bh=R+ElcQoZlMTaMjyb0gfctea/sh4vXsBf0F0G4P4BLk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nE633orz/f32M7taSxQ9ZoyxTehd0/MPsmtt4+ECFLYfkSlIrCg/mWKSrR0GXWUSo7Ey9wqcJhhhUadcpIoNMFuH7vz5qXUHYdWlnUVd2ixwTTTk3kgLbxJSJMWmqpgPTBvxzZ/EwKt9FZPlNRfBVcyaw39Qh/gVifxlktMAP3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1D89wyA; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1D89wyA"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-366330b6751so7050918a91.1
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779647042; x=1780251842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b/VRKGhpClL2qx91sk96jvJ7Ms8mqjpuQNfM6bhiFpk=;
        b=n1D89wyA/25OwTCi1uGLn0ssL9VXUNEDvgo35J+DfKldJiCnYSYmo0WcNJZ9FqmNzX
         ljfTdM25ncH33x4suzTW2Y4vCb9rhjj2PnAQx9eyCrPYhw452Y+DQxa/VUw7aRXrEJSg
         zoCl7b3BzkPJ1o1rV0sWkLI3bUvxCmci81kEfINfhP3lfFHcsWFfx0FL03fzAaY5Irre
         LLLKC6Foqd8w0kDmNDS7gclHj9wfG6nO4Orny5FP3P1nWDwpFghV4qf37pGcCJrqGNSr
         3q8NjxtwDnsa5m7X5QeiD8P6Ia8szOO08QTqeymbR7eNlEwqIjzrVm7NuaT7yDW4JEQx
         +8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779647042; x=1780251842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/VRKGhpClL2qx91sk96jvJ7Ms8mqjpuQNfM6bhiFpk=;
        b=RdcoVlZTafh/uztlaRLWigkl4bw7gR6mIHFabjoOVyHTSRgjNoODAQ9SD0K8zHdGJ+
         i7LZCGRFBkZFqMSAwMlD71upHpFXcrof3ZFBH+HQd2yeKOtMzhCoN1Wv25KlS5YYb0Tx
         tAIYk81ZiogPJ4zZNfigmvyCNFdSB0UYUNJDAIiSMjsm+/V5rYx8RTmXg5HkrCBoygQR
         i+EEI98aKCr59CRQEROgbTgE1sS0LorK9f6nHHXjvYog8PyURV2afSdLbz2xfSDJtx0o
         yeKoTeY7gqc+n4W4tnGh1VaUP/c6XmGf9x7uImYMXvESecexJ4EjsHNgffKpjdGjb9zc
         Cmrw==
X-Gm-Message-State: AOJu0YzbgnR/Fkx6U+r3owbthuIV3OcNBTacff95XHQkiAE54XVeUe2E
	Pmj4RC9EIoqtzLTo0fflie+d+PF5scVnMlAZtTdlAtZF8AZeGWW0SeU9u7Q9hJYYow==
X-Gm-Gg: Acq92OFTJ4RyGy+Rmreod3PxdnnsRCfSgfPPwdbPxTbep7YHBHsfcF1kPgRekaBk7Ob
	kthWdXQPZe13Imil1fOBzO+50UXJk0tgLDg1CgU3EXc/zFwzhlUHahT1/IllNy9v8atO7evhCLR
	1ctMDa3vXdBP2F7xSFG11usbroPDc1PfHhHn0jDQQPCEKmtbu+yhL56YAZ+/2IDFPn65VlRS1ev
	/9ZdCtn4M94tYf4rTethEGuEAQKZEkprCX8+wdYjUu0TXJYo/oL0HFxmY/jjfovxa5iPjnSgntu
	OWXT9q46zsqLjTZTgSS0zHFaGXLW+K0tAfMVA1PVWW+4rhsMTzxUfirQPuEiGAyP0xRS2E52MaS
	PK3dPpOLYG/DtbWnGT6fvDhUpSohvruHjHT3EtDA2HBEwhWFyJhhoSsKBJx7xndB4aV8UKuLwsG
	CnsMce5Jcu7HBnTuEDx3/DPYa3t2IbJ0Iib2ypDWVhTfqU91g1XbiDuJWOlrAcO0FfZAux8qs=
X-Received: by 2002:a17:90b:5485:b0:36a:aeaf:ab2a with SMTP id 98e67ed59e1d1-36aaeafabf7mr3895058a91.19.1779647041960;
        Sun, 24 May 2026 11:24:01 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c7b4febsm4419208a91.5.2026.05.24.11.23.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 May 2026 11:24:00 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] Input: rmi4 - release F54 queue on video registration failure
Date: Mon, 25 May 2026 03:23:45 +0900
Message-ID: <20260524182351.27658-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rmi_f54_probe() initializes the videobuf2 queue before registering the
video device. If video_register_device() fails, probe only unregisters
the V4L2 device and leaves the initialized queue unwound by neither
remove nor file release paths.

Release the queue before continuing through the existing probe error
path.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54 diagnostics")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/input/rmi4/rmi_f54.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index 61909e1a39..fca7b9fec5 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -722,6 +722,7 @@ static int rmi_f54_probe(struct rmi_function *fn)
 	ret = video_register_device(&f54->vdev, VFL_TYPE_TOUCH, -1);
 	if (ret) {
 		dev_err(&fn->dev, "Unable to register video subdevice.");
+		vb2_queue_release(&f54->queue);
 		goto remove_v4l2;
 	}
 
-- 
2.47.1
