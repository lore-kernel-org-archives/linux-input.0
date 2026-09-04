Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C78D3D1AA6
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788509130; cv=none; b=Q5wRH9+YaoTjyStaUyB5Vo6MaMdvrmifhDodvJ4SbJ1WWufPE0m6BQAgpoqM4KNoGjPqfcaGnhzNx33SmIrqQs1ATO8VwLltBh2oEBV9dGIAgljMWdhwrm1aWG5LFLI+HXGeTai3xyVf8FzQVtjjRYrh1W2vgvZ7y0Gto1lBThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788509130; c=relaxed/simple;
	bh=jdiffeHYmFA8DNcP3BNSRC5Yis/Ko2nHBNrnJOxv9Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGiqkXqncx2bmxhIVsWXbhChhuETGxg9toAr0xKlcSxdcbY8craoEU9PuKeORbLTxGqX0cedmDT8I2jB+a6iwufPAR2vM2FH0i0rXBOugok2gYA173M7FwKU1HyHfHB6+AST2IWK1vlIyqoajUhPf4ditP1oGJeuM6ZBAF3vE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQsx8/Qi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQsx8/Qi"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49cd9add88aso4634805e9.3
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 01:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788509127; x=1789113927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aE97C67i/6HILbYP0ZPZ0KdmA5bZduDkmUAlNiBx1QA=;
        b=QQsx8/Qi8XXN5pTV+Jux39lQbM7JXsfxaEY9vf8I4+K4WuyPyy0tpQKj3tqwVMFwhu
         rg9RjKJ/nXkrLQs3jFDm5BVMC7V0v/deoRONLbk1nWb2iYhyF1yxAU05wp19F0THJ0Bc
         Jo+GHA54A5hH3tmFYyR6IakuAkGOivdqhf2tU0H+vIZHzvcX20rxT45UCTDbreh3ptQe
         ujCs07aJJGizIu0W4Vn7igtSeqoFVTp6t6mJVpJi0O5fQU799NBbX9zGyfmKO3i0rcOC
         zS8CUVRdc9SiDJViQE1qMfzg6ie8DvwJH8phklxucMGQScfhlyqyJ+yInN5uwkf4BZIm
         RhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788509127; x=1789113927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aE97C67i/6HILbYP0ZPZ0KdmA5bZduDkmUAlNiBx1QA=;
        b=g3wfxnIZ7Q4nfIWXkIu7gUFd+yrrfXbmZDhcyA14qvBgheCaMDMEbnST/iE2vq3Dce
         i4FsNyeSxLDsWMq9zvlwANFQ2XinbUQxnOoXTRaHmj+Ub8Q8vayU/YA+JOI2+bHQG6VK
         jyqMQo6A7OueQjnS6UTEHKTen3R1e+lIJO4Jim3KBJACX5UJStk84v/7bYeAZQJRVpLI
         ub0Rxw6p1+psHGpSMzT1KSppFJOzu4R7RLhqDhbLS/ktiraPfDRcK5ZGAtTSAsp04HNo
         67D/NDsslNnqe1HwkfJoWdBw3BZ6H3EOx9gXVGOxYdAQRyF5YqKttEtdPZw/SqpQHnhW
         Xv3g==
X-Gm-Message-State: AFuF++mOW8k/r4Mr9rFpMtsRFopOguixiMyA55ZNiZ3OfqG5Kcpb1rWK
	npeHgCRNqZJJQlXYUPO/0dgbs3pJuPTYQdzO35FwwBvRKjE2sBfU8zTWcD8+
X-Gm-Gg: AYBFou0zfF9wljSZpkioOFNF5G01fBfrasnshdz7yU9TwlLkZeCo1d6m5TKwQhBg9cD
	CCpV1n3Rf2KUvUMQHKQ4EFcRzYkY+WMrZWdP/0rb8+NXqFQ3uoRSdYA55lO4dUn0QCbGO1R5Svm
	ewex8YvtNoooLSUmf//C9mf84ZvJhcVdgl86oFQCfXBLFlBVMMlZDoPxpK5ebC/SSKBGYH8vj73
	u1gcu1IPbopCj+zmANZOmUNgO/I9jwHTfQf04qOhHQo+NIB8bqFXQPUVrkr0p+O4uqiCvR7F9g/
	QwcOCdAgjo9g0jTpfEDQ2nIdLbFzk6xBOjugJeV/vzIKaZslA1r0JwmkfkgPhF+VpTQXKS/1Aoe
	o7jF1R061wFWOSuzdeUWBEtGji/Me3pxij970VgP98aGKechO5myokxU9QLTKufCBkGosiZPO75
	xr1+iatEBi2NECQRlIiosfx/j6ZrGasA==
X-Received: by 2002:a05:600c:46cf:b0:49c:fc6e:8cad with SMTP id 5b1f17b1804b1-49cfdb3a26amr7325095e9.17.1788509127332;
        Fri, 04 Sep 2026 01:05:27 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cc7sm53517855e9.4.2026.09.04.01.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:05:25 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: core: fix device cleanup on allocation failure
Date: Fri,  4 Sep 2026 08:05:24 +0000
Message-ID: <20260904080524.3872926-1-tristmd@gmail.com>
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
index a3ff0514f9cdf..d8df23f67f1fd 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -3115,7 +3115,12 @@ struct hid_device *hid_allocate_device(void)
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

