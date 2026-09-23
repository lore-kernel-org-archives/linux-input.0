Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A204443E4A
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 06:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790146580; cv=none; b=bDrADfBzmO89hZgXLKPqvS4lMvvePkdl97JFljdWPHRM42ZNfZycuGBRMljkw16s+hQk/zb148pnXtDQkTm2Q7HQvz8e3xj+FAy7fwgkxQs16jM4njHGq8trZweo3uUkiCrzTgaAq7vzvUz+hvAclXlkTxVLC229o+pdnHLcM/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790146580; c=relaxed/simple;
	bh=qSM6L8Tt3Bo6L6FvVJnkZL8zE3lNbmNDUjzd5ZZnFUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AXbs1fF9vq58i+wjMLxRprWOKXXYduqO3Io0TfAA/OOH9TkZEjYXZp0+Wlr6L8GgDVzOGLmczM9d4V2OQJPj/cak1Ewc6o9Tn6REkJl6Kqlus96g4RUNJmKKMsQDL5frAmhYolr2+TZ2bwDSpo2fVr08sh0k65ImGOb1IO9Lov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h6bR4ahW; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h6bR4ahW"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc73f47bdcso7469755ad.3
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 23:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790146576; x=1790751376; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=93ESgb5epDnv42DkJ10ZS+s0RrMivyUc06fbtYjyWtw=;
        b=h6bR4ahWE7rcBTDXRq3CVjKuPEu8aVwyXD+umoRXjaUSUmrIogEdxYYcJtk5zJmLXX
         BYskt+n4hYl+spdtR4gzAhlvqrabrg3zZps8wMuYxGoEnTG5U6SKtfJkk1FG3/OFsgRK
         gLIZ4slcZ14hmDb5EaFZ6GRQdVDImx9vrdtxgargKZWh/XRmO4TnqpSZLUr+PN2ZPSlQ
         YvaWS4fgBjhXphgN4k8ueHXI2TGkhvaRYzTuEl9yslPoC3O5UgxWka2vPW9w1074ll0x
         TCCZ7BbETGU2B/L/i/aO0z0AB/qsYKAwQGjZYwVnPxX4cgIPYMOV7cbOZjcTccGsOy8X
         nbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790146576; x=1790751376;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=93ESgb5epDnv42DkJ10ZS+s0RrMivyUc06fbtYjyWtw=;
        b=uoHlMUBq8PLa2yM3B01c/tWT7xeSVR2P0bB+ENciymsaBDrrqb52yB6+3oHNKhlChj
         /u4NyTl6b6MBz2vaBc9FsdFECs7cTzwzknB9s13m0OVQH7PQshkSIb9ZaCoNFf6Ad1N1
         7aN/7vp4IJek13v09DB5zuqZjIczIa+qetb9V+PH0Sk3h7DpPsza83To/4oRL61TBk8j
         31GYGeeoA6MuTt4sYNmlht/BjWxTtMYHqYVXNWoh0PcqewRMeA+vZo/XMKR2M0kgYKg0
         vOyYwPaKK/ige03D4oj/OX7+Yh5NwyyqzLHxQsiTWErJyAj0fyxE3/nLkqh4zrTqH81H
         MCJg==
X-Forwarded-Encrypted: i=1; AKwUvBy18oaTxLz/xHk+vP9jdnpkcm0KJURR4pT1ATKCXrhGkdfPFcWUoIxYGsYzHuVGUF5kP03UC3+4CdfiFg==@vger.kernel.org
X-Gm-Message-State: AFuF++nJXyMcvSvZKhr09tQ/hjlfhv2RqTB57MbgoI461hjmUA+Wlw72
	nCNxrdcx/3/e6YNgpsejUi3gGHCzPHhBlKt5wkxUwNq/TX8GP5E1FIn+WV6WhbR49cIwrV5JVz5
	D
X-Received: from pldy20.prod.google.com ([2002:a17:902:cad4:b0:2df:3fbc:5137])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a6f:b0:2dd:c053:82f3
 with SMTP id d9443c01a7336-2df69dc5153mr13412295ad.42.1790146575481; Tue, 22
 Sep 2026 23:56:15 -0700 (PDT)
Date: Wed, 23 Sep 2026 06:56:12 +0000
In-Reply-To: <20260923063114.2683575-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923063114.2683575-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923065612.2707049-1-morbo@google.com>
Subject: [PATCH v2] HID: bpf: add __counted_by_ptr attribute to device_data
From: Bill Wendling <morbo@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	bpf@vger.kernel.org, Bill Wendling <morbo@google.com>, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"

The 'struct hid_bpf' contains a 'device_data' pointer field (of type
'u8 *') and an 'allocated_data' field (of type 'u32') that specifies the
size in bytes of the allocated memory for 'device_data'. Since
'device_data' is a pointer to 'u8' (elements of size 1 byte),
'allocated_data' represents the exact count of elements allocated for
'device_data'.

Annotate the 'device_data' field of 'struct hid_bpf' with the
'__counted_by_ptr' attribute, pointing to 'allocated_data'. This enables
bounds-checking sanitizers (like KASAN and UBSAN) to detect
out-of-bounds accesses to 'device_data'.

Because the count 'allocated_data' is always set before any access and
accurately tracks the allocated buffer size at all times, adding
'__counted_by_ptr' will not cause runtime panics or false-positive
bounds checks.

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
v2: Reorder the assignment of the buffer and the count field. It won't
    generate an exception during execution, but it's a good coding
    habit that also satisfies LLMs' paranoia.
---
 drivers/hid/bpf/hid_bpf_dispatch.c |  2 +-
 include/linux/hid_bpf.h            | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index d46779b63660..fb302d0b9797 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -255,8 +255,8 @@ static int __hid_bpf_allocate_data(struct hid_device *hdev, u8 **data, u32 *size
 	if (!alloc_data)
 		return -ENOMEM;
 
-	*data = alloc_data;
 	*size = alloc_size;
+	*data = alloc_data;
 
 	return 0;
 }
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 19fffa4574a4..f45fb9cccece 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -185,10 +185,12 @@ struct hid_bpf_ops {
 
 /* stored in each device */
 struct hid_bpf {
-	u8 *device_data;		/* allocated when a bpf program of type
-					 * SEC(f.../hid_bpf_device_event) has been attached
-					 * to this HID device
-					 */
+	/*
+	 * allocated when a bpf program of type
+	 * SEC(f.../hid_bpf_device_event) has been attached
+	 * to this HID device
+	 */
+	u8 *device_data __counted_by_ptr(allocated_data);
 	u32 allocated_data;
 	bool destroyed;			/* prevents the assignment of any progs */
 
-- 
2.55.0.1082.g2b9226bbc0-goog

