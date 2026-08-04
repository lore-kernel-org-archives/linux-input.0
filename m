Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0CF3D6CA3
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 01:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785807715; cv=none; b=e4hHEx6iH17l780t7pLwumuduuU0QJAp6EKhlPjxnBYgeDtdiMHQ85aFG0PuEAEMD49kFNVS/5GYAPVE027GzExZhMcxfivpyJiF80AUPEKUm6KR+Fw+pDeusVDzkg2P/SvEvAvYR3wG1k3eDJv4X47hviBxKsciHWWQuYg7inw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785807715; c=relaxed/simple;
	bh=ro+Wx+hreEXUc1+FbWqBmslCj+PhsGQeaz9tmn3EjCs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PXuZClZEBGY6VTmxgH0vb/jEQxrA1sDGhmv7jYr+bALJf/gZzMm50MuBEsSTjbXEtYCgjfvx4U1isZJ+EKrkiLrzzPCM1zWCP6UGqgAQG7cN6m/T0ztu5X3ziMHv5A3RRecaxPqlaLVvkHuIIzHnrfEAKcNlppVW46njE7F9VX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFxgri2o; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFxgri2o"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8423f236418so3235142b3a.1
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 18:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785807713; x=1786412513; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CNPgSNpSCLs8Fm5mEm2tT9XyZGyB1J0tABlRmKt+IFM=;
        b=EFxgri2o4sXW+RL44Ls0BKKaFporJwe6REDeBBcLPTxnZH8uFmYj5rlp0RlfUZ/0ts
         Nn4dxceJ8hzlv4pxOQ9w45Oa4vlJ134qTcUgopHDVw4tufuBN1kdjI8ZXMKXQPRRdc71
         qyG42aqCWEdd6q+btz9eBBH23inZc0VvAO36x1Ig+Zy2X2LMqnn57Z8A90g2uAulNPPi
         GiLp7+Fz0PlPNuhCoKgSGGTm7tyuYGGLLt4pRQYiexNavf9YXtl4QOftiyGQoSDOP7Qg
         mytfnriVsSngwmA2TRfZ643uaPVA3XNCDngs+Ifsj1ZcQmvKQNx2bP2ptZ+ceqxbqoFF
         ZK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785807713; x=1786412513;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CNPgSNpSCLs8Fm5mEm2tT9XyZGyB1J0tABlRmKt+IFM=;
        b=QFRaD6+EoDRCD0tKzJ2GsxnZSRJX578kB3kegcSzg9SkioallrEogu9evLboTXHsE6
         /wGlENfVzfOxutRoahNtDRy7dId7HsWEw4/2ymJvqI1W9w42rXdB37kkPCYwfn5NC6CG
         ohqcnN2ZzZPdY7m1WbzSIwgEzN6ohn6b/epGt33FZg3k8+e96eMfMfuCcd9cbmVPEfoI
         FAUN2ihKvVD2Qx2JNTSA9xMfirMhKQjsDFLjJEjoyv47QUMws7QiWn9sUn/qZ6paSWn/
         9jLZzYL44pTa59qYE36UWDtWH3yYFJbsHq0+jSVye1bydgpm83jSlRmGzvFAgNRUJG0x
         69uQ==
X-Gm-Message-State: AOJu0YzhfiAxyuxQnAxdlFj61bgeA/8K02Nx7cbOO+ZGxb7eXjaX7rfY
	wJLgZf31FjGxbwswzZ8xLYC4WaIxI2s0Y45p7b9s4ZY1ni5QJe5EjJf/8izkFw==
X-Gm-Gg: AR+sD10fIqj6rZa0ZRx5sY0yn/jvV4He6gtLvpSl/fpnMatYEZhKO6/azEHXxzpKGf/
	g5Vbz+jUfCU80UrwBxSa67mNO1JO09ygfZiRNThuA5xfYznV6c4ydS+UKuifBEmlW3zwA8416vu
	ka2Lc2IOqNnvBL4IXOLrqD5Jnx7k4H4MURB2j3c4oUE/Kq2bWPL5sRmOWm0VK/dgxmM3sAet1ra
	sOGYIkU6eBYJ5tW58q0KJ5J3jiSbBLm0pWCMZpJkjak3PPjyOdE27zIJHBtk8WSHtwfQe8zDkAG
	tOrKCcd3ib2z4S5xSaSp+lHo48hf1Disop2h78DpNQyS9XLvAaHZyCOs7gUml9EfwZaCZDdOVQg
	Gb4PdOYYEi0h7xNzd8I9SC2I/+kwOWbH2sncxXBvCk/JwkQ9S7iF1CCWs8L43f0b4TG6QGvpj2E
	ZxuN0pVrypTM9EvbqZqjt3mnd9IajYnyP1diDcgSkpEme9ez1i5eUtqZJ1Cz7RBWK4/TSNwQXrr
	IyqtWSIcCHjEfESTjZhFku2/oyMsQ==
X-Received: by 2002:a05:6a21:111:b0:3c8:e313:8d2a with SMTP id adf61e73a8af0-3c92a9c70dfmr11518181637.43.1785807713318;
        Mon, 03 Aug 2026 18:41:53 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab1334cfsm39924803c88.1.2026.08.03.18.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 18:41:52 -0700 (PDT)
Date: Mon, 3 Aug 2026 18:41:49 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	"Wagenaar, C.C.J. (Chris)" <c.c.j.wagenaar@vu.nl>, Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH] Input: evdev - sanitize event type index when fetching event
 masks
Message-ID: <anFCAfvxwXB5eJF1@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The user-supplied event type index passed to EVIOCGMASK / EVIOCSMASK
ioctls is used to index the static counts array in evdev_get_mask_cnt()
and client evmasks array in evdev_get_mask().

While the event type is architecturally bounded by EV_CNT, speculative
execution may mispredict bounds checks and perform out-of-bounds loads.

Sanitize the event type index in evdev_get_mask_cnt() branchlessly using
array_index_mask_nospec(). This clamps the index to 0 for safe array
access and forces the returned count to 0 speculatively when the index
is out of bounds.

We do not need additional array_index_nospec() calls in evdev_get_mask()
because evdev_get_mask_cnt() speculatively forces the count (and
resulting xfer_size) to 0 for out-of-bounds types, preventing any
speculative memory access to client evmasks array.

Reported-by: "Wagenaar, C.C.J. (Chris)" <c.c.j.wagenaar@vu.nl>
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/evdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 5764c98b4f1f..796ac7ac2b8c 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/input/mt.h>
 #include <linux/major.h>
+#include <linux/nospec.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include "input-compat.h"
@@ -67,8 +68,10 @@ static size_t evdev_get_mask_cnt(unsigned int type)
 		[EV_SND]	= SND_CNT,
 		[EV_FF]		= FF_CNT,
 	};
+	unsigned long mask = array_index_mask_nospec(type, EV_CNT);
 
-	return (type < EV_CNT) ? counts[type] : 0;
+	/* Returns 0 for out-of-bounds types, including speculatively */
+	return counts[type & mask] & mask;
 }
 
 /* requires the buffer lock to be held */
-- 
2.55.0.629.g250fe7f194-goog


-- 
Dmitry
