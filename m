Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0420545D5D4
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 23:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763367; cv=none; b=sn8zp3gclX+dpMeFk+Bw4izTJtBJvb0ld06W9OTrSvz8k/LqrH9UMT2XeNTHCHZLgdytdEzVmyg3o63GJ4KlAGqb0ArCkmtUcu99blHeBZMTZoUdZuBkHeFPuyWWWu3KJ+szMjIwhD144kSdZeHd0iw15RHQox5cJtpBVxOXmdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763367; c=relaxed/simple;
	bh=CkQapMU7ip8Q/AiSUcZQa8vyjB1ZD/YF3KA2pc3esLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDWJN7+kauJ+4PcvDKCo3XRn+3AQeiH5T/VXDDfl/qqvzDeTTQgPr2MqJE0AMp56sOihH5kI/DxWXVJFNhlXGOQHE2OTf8fzAKww1DIO/kzYvn6Wivf3/PcF4eFZuUQv99bv0iYvfWOGltKDzKu5Cs3WCtGUko0OU7+Fts5QD5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b15J2eIc; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b15J2eIc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784763364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2T+isjPT/GJdA9Tsts/N0C10ThVZvNgmj2JTqHYN6vI=;
	b=b15J2eIcEIzwvwKgEVfyij80PsM4vP6KdHH5T1DaI6kpu+6qGr1fxfgvWUX69BksPXhV7c
	JVB8GiLFfU0+SgjOU2GycEZ0W+WEX2Z4EghZz7uGbOKKjBXXhgGxGrKHAXLlehH5p8+Gcs
	6QbtRnOIa2gH4PTmL0KlMius9ZTnL6E=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-input@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 6/8] HID: bpf: Make syscall kfunc flags match the struct_ops set
Date: Wed, 22 Jul 2026 16:35:16 -0700
Message-ID: <20260722233518.778854-7-ihor.solodrai@linux.dev>
In-Reply-To: <20260722233518.778854-1-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Update kfunc flags for hid_bpf_syscall_kfunc_ids set to exactly match
hid_bpf_kfunc_ids set by adding KF_SLEEPABLE flag.

The syscall set omitted the flag because syscall programs are always
sleepable (the verifier rejects a non-sleepable syscall program).

However the upcoming resolve_btfids change enforces per-kfunc flag
consistency across BTF ID sets at build time, which is why this change
is necessary.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 536f6d01fd14..44671dbdeca8 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -590,11 +590,11 @@ static const struct btf_kfunc_id_set hid_bpf_kfunc_set = {
 
 /* for syscall HID-BPF */
 BTF_KFUNCS_START(hid_bpf_syscall_kfunc_ids)
-BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE)
-BTF_ID_FLAGS(func, hid_bpf_hw_request)
-BTF_ID_FLAGS(func, hid_bpf_hw_output_report)
-BTF_ID_FLAGS(func, hid_bpf_input_report)
+BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_hw_request, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_hw_output_report, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_input_report, KF_SLEEPABLE)
 BTF_KFUNCS_END(hid_bpf_syscall_kfunc_ids)
 
 static const struct btf_kfunc_id_set hid_bpf_syscall_kfunc_set = {
-- 
2.55.0

