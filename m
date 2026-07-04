Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B880D345722
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783181579; cv=none; b=LtD8y/QJiTwtQI5crBVzgnA/qOwqRLhfi/kJxH9QWL59/VIMLwnRbdg1CNYFrSzqr08hfkOYbaaJ8KLvO9TAPLKWF0An6pF/hDJQExMtBeKKg1vjbxM+C/kMQRl48XpWUokVpcC8B167WXUBD79XqBGJ8zNd62sRcc4pyUGU8eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783181579; c=relaxed/simple;
	bh=15YSkLAkQCti5IzcfCpgR1ie8/bhUE9zxOgts1ol0qQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=h/2cJcIEGwrI7dbx6CzearHuasaXC6PtIyp4+lHkYhafMInUjw5b9ZbKdpmUhK4Cvsty/+P2+lcCrwquucCSrC6Wgd3JAe7W23XoZmBmaL33Hs7UukoFTkuQVHITG4hOZ4o+ccsfF/QqH0PtReRppSL+YvG3O0mQGud7lmTtkjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDO1FfoQ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDO1FfoQ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-847a5528b33so797857b3a.3
        for <linux-input@vger.kernel.org>; Sat, 04 Jul 2026 09:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783181578; x=1783786378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kVfJZz8SjrFuy7zkpM4CK8nsRN5F1mP1tDE3AslmNig=;
        b=jDO1FfoQoWl63oe7sQHDR9oAmG9ONvd0B/WM+i8SLvmyEc8wdBoIceTZbVwCXrRegL
         7at93vxFF7c36HD/Hze9aWa5qX5cjrdsJdPtxEsy0JJb8gj5MW/K3xtiY0XQnfSUASmi
         mx/y1PAbGWAWX5+b5elURf7b7fVzD6JgDJbWsEBebe10/62PdUY3fxXFQcfy+fo7q/Ql
         nkAHarHdeq1+FfG613E7rmXg4SmF8VueVbVasmbqCSfcaG7zrTMGCYkaJCibSuvLZ8eq
         SD2d/KILw6ukW/IfNZmgHqA/Ds6Ek0kbUGfCSjF+jS3qm0eONDr08VJ1saIEmvHoe4xO
         G4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783181578; x=1783786378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kVfJZz8SjrFuy7zkpM4CK8nsRN5F1mP1tDE3AslmNig=;
        b=kK7bUxyx0KVlMf3V2lnycaecmYTA3Gqkezc9QHbUHeRtg8xUL+XXjOfbiSrG9UbopS
         ZyP6YtDvNtp+nRgifIMHMjWLyzbP2dyVCmXt79huel8ka0fYPfd8gd6nftXVAEK/v9mU
         wL+WNe0jw7I82XQwwzz7fwMleSDnkEPCKncXB7Ommzkjkk908CZW0SvpJ/Pi+edy9drn
         4c3aZl1iVKXMsuja9t3WBgM2vFjiu1AmONAvKI3KQNZxo/9mqjC1JjYNlk6o/uLjuxij
         N63VGsU/CnPSKhFMLvkB3pZvKb2N6n5cD+m99A1t6sKE0HwoimA2+v2nt6gTYOtgkBEz
         1DyQ==
X-Forwarded-Encrypted: i=1; AHgh+RrN8ina4XDwbMJzxYGMC/vFGOu4kUEuHHM0uV2aH8tZoKdI2WscyP2bDgzQFNQC74JcudeDgBzIlFGCdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv/Qx5vMeZcU4p0p9ARC1nhKlaCEUa0lxLqAnXHGwX/el8Pmy3
	+0zGst4Bd7zSYFEZMJD4gqq2nxFN3BrEFKZxbplOl8TshjK8A4j0puTcXYeQTw6/XaM=
X-Gm-Gg: AfdE7ckiaxhmeLBPgniKI1GAeF5Exxc2A/ByFKJPmohOSAgqvbL2xv0m9VMBLJpGvP/
	Myp4cMkc1EhL7l/tsjQGgemIEmF7hY/g8LxigLXjDI1/rx4H3VHnmVwzGpNM1tVh5zkve7F4bh5
	2+zpBafKxNbB1MNT4FNBKYVCfmJPQaU5qI+IqKPr0zIGlrrUWHopGMAIVmVVjQ9m+CRhyVWeVEj
	aTOLLWUFvqw1LuJ83mO47DXtJZd56/ciARTe1qZ0tG1Mzcqvy6RecduaF3rYqoFD/u/Mx+QRrx+
	N9Fk3GQ2c1q5dVZamhtk08pw9l/lN5N6Qg3ACZg24d95YM4PtjZIH+3qJHbmfonm9gDqyJkcRIj
	UHsIkcIb/LDtcMl28OgSJ4+wg4EngcfoAwxJMLEljrv+aw2eutkLZ3cBOdW4Fdk/2bwwQKFGBp8
	DZf01zuQ==
X-Received: by 2002:a05:6a00:2789:b0:845:e703:e with SMTP id d2e1a72fcca58-847f6dd4a7fmr3713537b3a.19.1783181577928;
        Sat, 04 Jul 2026 09:12:57 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b6162esm1391522b3a.11.2026.07.04.09.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 09:12:56 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] HID: bpf: Fix signedness bug in hid_bpf_hw_request
Date: Sun,  5 Jul 2026 00:07:02 +0800
Message-ID: <20260704160703.156298-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hid_bpf_hw_request() clamps the return value of hid_hw_raw_request() to
the size of the caller supplied buffer before copying data back to the
BPF buffer.

However, ret is signed while size is unsigned. If hid_hw_raw_request()
returns a negative error code, the comparison promotes ret to size_t.
This makes the negative value look like a very large positive value, so
the error is clamped to size. The following memcpy() then treats the
failed request as a successful transfer and copies stale data back to
the caller.

Only clamp positive return values. This preserves negative error codes
while still preventing oversized successful returns from overflowing the
caller supplied buffer.

Fixes: 2b658c1c442e ("HID: bpf: prevent buffer overflow in hid_hw_request")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index d0130658091b..b13f911e5944 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -446,7 +446,7 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 					      (u64)(long)ctx,
 					      true); /* prevent infinite recursions */
 
-	if (ret > size)
+	if (ret > 0 && ret > size)
 		ret = size;
 	if (ret > 0)
 		memcpy(buf, dma_data, ret);
-- 
2.43.0

