Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F847423EB7
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 21:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199770; cv=none; b=SCs1f34NmbbetkrjkmIK8G5q8p3UyU+bSEL1VvjGi+1mGMXGT/WM0kHfd3hp/zP998AnoNiQmeTZVn0JNPZHwgtynQbq+csP/8IWXAN0HgSBbuwbtilPn8ik92ViYc9qemFpw2Ku23NZMcSNnJAVCjQ3AXysbFLKjEvKhtMPj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199770; c=relaxed/simple;
	bh=P8UxBoi3c6dfgfFRuUvBQXAQn7T0thA4jbPoLoodgvI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ifDcJOPxCwvT9AdC+xV32nkFchhuuC0OThINFyJnan7tfMzY0OEWV9yGQxk1PPSwJsjjGi/tQOSJ4WpMn5lvsuK7IP8dFCZZifSx9p1gX9bHPVrs5BvNC71vwNF2Lg4Oz48NAY76NfvaizTiO1KGU/e8QFOB9du6myTkAjs8q/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vtpYaRwK; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vtpYaRwK"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfc52ddc55so12201855ad.3
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 14:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790199769; x=1790804569; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZbPFPeyTORjeOg7jOjV9V6Jywp+gStr7Zp4FX6jbmec=;
        b=vtpYaRwKMnDKkkv+qH9dmDu92b2wMpl1EQHO9V/FsQrDx9+mWE8KgCQ8O/1NxJy9IC
         W8PG8Zzjjus8DmrEAgn2h+eT0awYFoZNpd3Dqo8s9RVQLr3P4kdBChhn4DmWp5W7/UTm
         Y4E9MHvAsns9gaUeNV5ybqrPSeiER6xHFhEIaIH9oTOayuMLvmovN5Rke06T3tvsdkkV
         oj0LWx/hE0eAd2oWyFNgbXKkEexjeyRwgnst7ViL6Dk/0AKYlCuJgUKFdYR2m+pw2tOc
         Oe+n1C7HuVVBXZ3DeSJFpLDwkFw0uQFhxAvqYKhzdLuBBnBp0yV4e7w9gHUlyuAOygY/
         qvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790199769; x=1790804569;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZbPFPeyTORjeOg7jOjV9V6Jywp+gStr7Zp4FX6jbmec=;
        b=ju42afy7B29PkE96pBEiFqDXWCw2Ks4YDAbZg/02GXHKmOHVx6WI6zrSFTlQecWrKQ
         TW2Gk50/DwByFOkRIegxvnfaxFpH1cJB3TQ2TURoTsVfS0VRL0QY61xJa1KnqnT2rPq3
         kjv0ZJBGR3wzc3gZFZGKw519vsikMujMUvaMahChdW2tnQZ6pxQyowAVjuXbotvWZB0b
         jwhMTkY80tImkDlAGw/SrKl/jOTke/mo/rRw0Rf9+XWGABy5a7rpHzNyz2F3NusRFNjj
         AfGbfToMHbv7wGFz+51irAy1XZM8Wq8OAz5eRhdtB2MclgMmb4cM72Xc+JyTpqbddH1h
         ogYA==
X-Forwarded-Encrypted: i=1; AKwUvBxAAobzyDxwucrPj116erc95L12jAPkYfnXOGTUo8HwBifj1CfDvyUBTKyj1GXc6oZ3gXWaGJfcImzwdA==@vger.kernel.org
X-Gm-Message-State: AFuF++mnq4oLXAHZSgsXZMLXD4XMatr606NAbspNGmzBZxoCLKsWLSrE
	WAjGQ9fAHOmawXo/zgEr7Hwind+y8fbQrExxhaqAkQGa36AJcsfY8wa0aQZ6dptmDgzPFokIH9s
	O
X-Received: from plrd9.prod.google.com ([2002:a17:902:aa89:b0:2dd:bf7a:f211])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b4e:b0:2c8:2808:3ec9
 with SMTP id d9443c01a7336-2df7e26759fmr3174125ad.12.1790199768442; Wed, 23
 Sep 2026 14:42:48 -0700 (PDT)
Date: Wed, 23 Sep 2026 21:42:46 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923214246.3098156-1-morbo@google.com>
Subject: [PATCH] HID: bpf: fix lockless race on device_data allocation
From: Bill Wendling <morbo@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"

When attaching a hid_device_event BPF program to an already-connected
HID device, hid_bpf_reg() calls hid_bpf_allocate_event_data() while
holding only hdev->bpf.prog_list_lock. Concurrently, incoming HID
reports invoke dispatch_hid_bpf_device_event() while holding only
hdev->driver_input_lock.

Previously, __hid_bpf_allocate_data() assigned *data (device_data)
before *size (allocated_data) without release semantics, and
dispatch_hid_bpf_device_event() loaded hdev->bpf.allocated_data and
initialized ctx_kern before checking whether hdev->bpf.device_data was
non-NULL. A concurrent reader could therefore observe device_data != NULL
with allocated_data == 0, skipping the memset() clear and dropping the
report with -EINVAL (or dereferencing NULL if device_data was reloaded
for the NULL check).

Use WRITE_ONCE() and smp_store_release() in __hid_bpf_allocate_data() so
allocated_data and the zeroed buffer are visible before device_data becomes
non-NULL, and pair it with smp_load_acquire() in
dispatch_hid_bpf_device_event() before reading allocated_data and
initializing ctx_kern.

Fixes: 658ee5a64fcf ("HID: bpf: allocate data memory for device_event BPF programs")
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 38 +++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index d46779b63660..1a0c4fa6ed86 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -28,16 +28,10 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type
 			      size_t *buf_size, u32 *size, int interrupt, u64 source,
 			      bool from_bpf)
 {
-	struct hid_bpf_ctx_kern ctx_kern = {
-		.ctx = {
-			.hid = hdev,
-			.allocated_size = hdev->bpf.allocated_data,
-			.size = *size,
-		},
-		.data = hdev->bpf.device_data,
-		.from_bpf = from_bpf,
-	};
+	struct hid_bpf_ctx_kern ctx_kern;
 	struct hid_bpf_ops *e;
+	u8 *device_data;
+	u32 allocated_data;
 	int ret;
 
 	if (unlikely(hdev->bpf.destroyed))
@@ -46,11 +40,26 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type
 	if (type >= HID_REPORT_TYPES)
 		return ERR_PTR(-EINVAL);
 
-	/* no program has been attached yet */
-	if (!hdev->bpf.device_data)
+	/*
+	 * No program has been attached yet. Pairs with smp_store_release()
+	 * in __hid_bpf_allocate_data().
+	 */
+	device_data = smp_load_acquire(&hdev->bpf.device_data);
+	if (!device_data)
 		return data;
 
-	memset(ctx_kern.data, 0, hdev->bpf.allocated_data);
+	allocated_data = READ_ONCE(hdev->bpf.allocated_data);
+	ctx_kern = (struct hid_bpf_ctx_kern){
+		.ctx = {
+			.hid = hdev,
+			.allocated_size = allocated_data,
+			.size = *size,
+		},
+		.data = device_data,
+		.from_bpf = from_bpf,
+	};
+
+	memset(ctx_kern.data, 0, allocated_data);
 	memcpy(ctx_kern.data, data, *size);
 
 	rcu_read_lock();
@@ -255,8 +264,9 @@ static int __hid_bpf_allocate_data(struct hid_device *hdev, u8 **data, u32 *size
 	if (!alloc_data)
 		return -ENOMEM;
 
-	*data = alloc_data;
-	*size = alloc_size;
+	WRITE_ONCE(*size, alloc_size);
+	/* Pairs with smp_load_acquire() in dispatch_hid_bpf_device_event() */
+	smp_store_release(data, alloc_data);
 
 	return 0;
 }
-- 
2.56.0.rc1.310.g51773c2048-goog

