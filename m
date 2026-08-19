Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89075238C2A
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 01:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787103115; cv=none; b=Um6lKxCVi6htnrXaWXGM7mCdq19aoB3liKPbDQLPWcV6OPOomFYm+X7HWptCQmeEf3BDzI/jGTByiiaUtlpz70Jd1uw//QijnHQ/Oo9aNHAUFYOj0MZAxX05ILH1Ay5sFPrqgC4jVCldUSOwu9VYJoBNj252Dl7pTma6wnhiga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787103115; c=relaxed/simple;
	bh=xRhRnFNGyGsCRlADbq6VymtiPG/3zbPLjzpg1CiFb+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MnPLrBf0Gk1S49jsxzlXZWgMACwuA33/+zUvCPG+hqobrpu0x+fFQE2oxRDcx3XBcydsapUkh9WHboCIDGqZwIzBVs+D9sSUNJ3WP3ke1xvbKilPxL4+1eqQvc3z7zCUCGB0fZ8VFHi4HjgqtWT8wqh/gDhCkkxdFtkDtJg4sU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeS9kWjQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeS9kWjQ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso2227435e9.3
        for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 18:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787103112; x=1787707912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VZWwFr/ahtVTYXNjGEhBULVMAl3ANX5lBtLyh4+lS7o=;
        b=XeS9kWjQUdFvaPGbJv/NhupXBI5IcUmFWKZb3S7PL17T+iD4K5W/PGtcw83BDdJiqG
         VVZhvBV8DHe3nRP0PkOsnVjogWnezreJQIow5Z31Gizs0B+iKOOllOKXau8neaVqJB32
         U+ygp/l/bwCIP681ppCqSf9RMoFU4SCLQ83ey1jqtiP0SMt2g2WPkTnolhzFwl9AdEVt
         veZhVgg3UU1p/p4Y42MoDjOwPMd2wq+8U9KoZU0+plalfnzyTJquT/FkjeJNTQVFTuoQ
         dwbl3SoYL4wCaae1QCCKk/HDOSHMgr4h35ETGpHqckiHqSHRMjrYIXSqvEhwH89E+1b0
         qmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787103112; x=1787707912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VZWwFr/ahtVTYXNjGEhBULVMAl3ANX5lBtLyh4+lS7o=;
        b=Z5M3+atD7FWEktMkNjC3MFZdFk5dXFb0L0R/mEqzsxR06Xh1EpTgOeHr6+D0hv8Gs3
         qx2E+/NICHwxV+5t060egF99ObMzIAB+3mQoz1VmASCC2Ff6eJXGtUeidOB4wH+POscD
         nGTXOFpGNNk34dQqg2CUZYHFA/wbPZebMepLtjr6RpkwKx2vk6rqOcmGDiWtVKHKxE+E
         41Igr1GyLMqlwfihd80gf/vTXyV9m7ODbsXROGkjooXEprPVUOmcgJq82831h8uTlcmp
         fvlLAhLioZHHDSnku4v1OeozFUI6q9zz4g4k+Xd6uJbksI7XmjRN8ZziitIvBTTO01SU
         XYcQ==
X-Gm-Message-State: AOJu0YxrFn3X93QCj2vfZcS0/TjRSBKfXzp3HvTfrFomftDgKPNs1t2w
	ORYVQE5nCWhuDojqKEMT9OkqpkywVtBJcQ2WJU8yq/8Lzvncq+3Tzio=
X-Gm-Gg: AR+sD118DgPH4KFoKntJK76Zx7yQcPoTytNJHIN857tQGLMj8nwnR4ha5a/DSdu9Rqd
	q2QjHcYtDzmHUJE2BB5c3GyhNn4iIqgy30qYONJxGhAx3N6702LXUlCAeP5jh4wH5sgfbtBtN0v
	UFKTAhpbN2fEQmhy1jsuTvh7rnNnMcWVt7pClYf4neVVQxJ1WPM/03GVjqK7bmvVRmHyTNT+gAW
	L4yIwbKwDIomINWhO+ChcyF4z63b2nOEyY+cb/5zNSLtAborjUYTtY8HNvQy2U/UCr8qUB7qE/1
	fzhfa3i34A2GvxNP26q57v+7ZxAC0cDq9+woH/GWhhXdgQiZWNlYL9vkvX5h5XHqiBrruGmvobo
	YmChd0AEJeGDLZR8A7XW9d8Aa5F1FK7YjVA7qXPuohy/dbNOLIAP5oHvJBZZXUf5gmSjRMU6h3+
	Se4wntoFTaY9bQu8ANgpvbHUZe661BzP2nl6fca1/H/OXNYg==
X-Received: by 2002:a05:600c:8b27:b0:499:7024:9d4a with SMTP id 5b1f17b1804b1-499aa16a958mr20867835e9.8.1787103111569;
        Tue, 18 Aug 2026 18:31:51 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0d6964sm15807215e9.9.2026.08.18.18.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 18:31:50 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] HID: core: fix device cleanup on allocation failure
Date: Wed, 19 Aug 2026 01:31:49 +0000
Message-ID: <20260819013149.889913-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

hid_allocate_device() calls hid_destroy_device() in its error path when
hid_bpf_device_init() fails.  hid_destroy_device() in turn calls
hid_bpf_destroy_device() which invokes synchronize_srcu() and
cleanup_srcu_struct() on the SRCU structure.  However, at this point
init_srcu_struct() has not been called (or has failed), so the SRCU
internal pointers are all zeroed from kzalloc.  Dereferencing them
causes a general protection fault:

  general protection fault in check_init_srcu_struct
  KASAN: null-ptr-deref in range [0x00000000000001c0-0x00000000000001c7]
  Call Trace:
   synchronize_srcu+0x1c/0x2b0
   hid_bpf_destroy_device+0x64/0x90
   hid_destroy_device+0x29/0x240
   hid_allocate_device+0x420/0x4e0
   uhid_dev_create2+0x161/0x890

Fix this by replacing hid_destroy_device() with put_device() in the
error path.  At this point in hid_allocate_device(), the device has
been initialized (device_initialize) but not yet added (device_add),
so put_device() is the correct cleanup call.  It triggers the release
callback which frees the hid_device without attempting to clean up
resources that were never set up.

Found by syzkaller on Ubuntu 6.14.11 KASAN.

Fixes: 6cd735f0e57a ("HID: bpf: protect HID-BPF prog_list access by a SRCU")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index cf123347a2af7..9534de5317783 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -3060,7 +3060,12 @@ struct hid_device *hid_allocate_device(void)
 	return hdev;
 
 out_err:
-	hid_destroy_device(hdev);
+	/*
+	 * hid_destroy_device() cannot be used here because
+	 * hid_bpf_device_init() failed and the SRCU struct was never
+	 * initialized.  Release the device directly.
+	 */
+	put_device(&hdev->dev);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(hid_allocate_device);
-- 
2.47.3

