Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDC442EEA7
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949188; cv=none; b=scP98FNK3NqnbURbx+AeB2H2y1n+QaRKHLsech3IT9VWI4R68wsS7KiT6m6kMdojH2sXoivyhkUECNZmfYm0zqT4RFfryByvg+HODlPKwK0O6GNJVq+kK8nwXveinSsD4KTmU3LLfHtKSix8Em7bbr++0t6QcuwyId50FSYEDzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949188; c=relaxed/simple;
	bh=PRXrMhHHmPDmSfezdWtwj6oy53snFDFPa7g4fqzcLx0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=th7TuNBs7+GGcu3l81+kjaMnMwzEil1EC47ALKTg4pREwW4W6x0WRL4cilye80XukcDuwjsd2XiWrD9nL7/90UmTWc2Xhl2yfCfx2yjsQHm+N36PqEkEgjumh5c7AqR8hlj1Ey1fjtSGpxU++ifdiW8i/hnWioNhpDS5NVxQCgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SR2Kk1YX; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SR2Kk1YX"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-848761b5897so1392712b3a.3
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783949186; x=1784553986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PZo/QGvD29siNmPQnaA3AO4F48nI154SXJ006XgsWpM=;
        b=SR2Kk1YXNBm1tGnrfvyMJj89tVKe1cFJa4mAAPFj/dHT2BGIrnYKG4BD0nyDyDXvGu
         mfs3claoYKjHTfdHWW7sfFIU3h6eYftAG//2Ps4g3upiX6gxkyr05+hLH5hnJP5PtmuV
         /sBN03wPlEkB6hbe2JFNJMpitYtFO1Ylr0pI7VIxJFWb4vn261ZQjD5+U8nbVAqgDIiL
         BskYlcgep0NA3CtjHh61mF+KHyNVwhevLnbRK3y8cTqNeg3PTk0nN4dISzbMibsxfbDS
         9Yu9iNQ2GiP5JmmhKLyLcCqvV348jxiF9lgfKEy6b1EZkXszr7H7NjktYBmJISchC6iG
         32/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783949186; x=1784553986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PZo/QGvD29siNmPQnaA3AO4F48nI154SXJ006XgsWpM=;
        b=stPZCutGx0Rv+uKjz9DVhEWxazKnM30cy4MMLHP5S+GcUz9Pj4RCicZcPItnlyC+oZ
         ALPIU7vti5z118ZCs4eGF/nxt0KyNztIDm/wK093Cu1w2c2qaY21j5I1jnwT9NkPRqxt
         8QXeWANzQZMMNK8C3s2GPHq1Sr2beTxnhxgEe4VcJcuZ4IdlIhgUU7uLzKA29OHBobPF
         aRq71xcVQ+exkNXFeoBokhmL0WqaLPeQqYbH2owyKnW1+uLzNsCU7eALwSEGkdDyL578
         OXUr3B/ywg6dS/zoEnA2mb2k1hnsHSpa98CyE2jZ4ZzbZi59l+WGZ25oNhxLLpCzBKzK
         jK4Q==
X-Forwarded-Encrypted: i=1; AHgh+RrwMCw8soVYx8P13ZK69L4Po99QunZBxPdTYGFGqF1RJ5ii6Ymo9NtQsMfhndqmRrkG+OBRGyoa8XFZnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZGzvSWq06AcbVt8l2Hbin9HCyWrrQGmXZHUJqdafnjflwUerq
	9CUDl8yVvSFhLljgKu9o+A1p3OTszPVfRO/AByhAtPd58bzWT9Ao7198
X-Gm-Gg: AfdE7clTWY+lJxOesOnMNJa6ARvWSjlRTquwE79/WTDw9u0Ny/OcH5Ifee75eRDPkE4
	V0NjPISaHiwDP1umsPlurEGx5BQpyQbnfgiadN7PXl6PP06yZSKmoM209CIvjeG7OiFBKy4YaZo
	MzHqqmuZedac2oE1uQlk42oKrV8oTOK3Hqab8SPYDupzuCY/RTtN46icUMsDFkKhAeTPzU2F5Xd
	w6X+JeH5pFOFkWI7DHotoQYEoUU5B1tZo9uFoZY/fPI4psDR/s3jNY8vWoo875NUaGnq4LMhTFC
	J2jrWnl/JRT7nuA+ec9m3SpaiyCDjKaZAQ6wHcTQ9rDbhO1EUuXmB6JjwVRDtHK2IRLWLMunnlR
	CKsSZZ/YskgLRnDfyMNHHEHfx/9CiCbq0GQQDrlwSPXjZ3IrhYmq+C0A3f8348+QwWX7vNpT6NY
	KMPaD8zd+sXg==
X-Received: by 2002:a05:6a00:9094:b0:845:d274:bf8a with SMTP id d2e1a72fcca58-8488977e8eamr8992840b3a.51.1783949185747;
        Mon, 13 Jul 2026 06:26:25 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d4d000sm14194934b3a.34.2026.07.13.06.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:26:25 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2] HID: bpf: Fix signedness bug in hid_bpf_hw_request
Date: Mon, 13 Jul 2026 21:26:08 +0800
Message-ID: <20260713132608.1265541-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hid_bpf_hw_request() clamps the return value of hid_hw_raw_request() to
the size of the caller-supplied buffer before copying data back to the
BPF buffer.

However, ret is signed while size is unsigned. If hid_hw_raw_request()
returns a negative error code, the comparison promotes ret to size_t.
This makes the negative value look like a very large positive value, so
the error is clamped to size. The following memcpy() then treats the
failed request as a successful transfer and copies stale data back to
the caller.

Handle negative return values before comparing ret with size and jump to
the common cleanup path on error. This preserves negative error codes
while still preventing oversized successful returns from overflowing
the caller-supplied buffer.

Fixes: 2b658c1c442e ("HID: bpf: prevent buffer overflow in hid_hw_request")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Handle negative return values before comparing the return length
    with the unsigned buffer size, as suggested by Emil Tsalapatis.
  - Use the common cleanup path for negative return values.

 drivers/hid/bpf/hid_bpf_dispatch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index d0130658091b..520b8f56a514 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -445,12 +445,14 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 					      reqtype,
 					      (u64)(long)ctx,
 					      true); /* prevent infinite recursions */
-
+	if (ret < 0)
+		goto done;
 	if (ret > size)
 		ret = size;
 	if (ret > 0)
 		memcpy(buf, dma_data, ret);
 
+done:
 	kfree(dma_data);
 	return ret;
 }
-- 
2.43.0

