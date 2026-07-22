Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239FA30F815
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 23:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763350; cv=none; b=N3UjTPiVJTEYeqN1be45Opf4iDydAaeTjJoNy1LIG0lgRyC/fO8XsfRT/upTLHFbS3zwrXhVDPr9ZJFhqMSNGtShh6lEtsCoITZz0fi2c1gIRlzCtd9xGQnbRXF3CAO1mOQxmFmnHbbGFNno4092FCnRB3Vcw/bRPfTyK95e9ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763350; c=relaxed/simple;
	bh=HGLL8iEtKoPazAgYMdd6JwOomGZoxBUaYT4bBAUg+hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQVHbFWz2oZJTNnKG1No3cx7WuqDNYxFiRkXtma7+JsquF0X4ozpRv3Yg3USpftkz1aNGeQU1FRrc+lNLfZB4tHia/pi2RE/brnldTcC6BFuUP0R3jfAvGvqskkLKLcpkqcVQpzBf3zF7Xu8OQxuuXbzjsGNKwUia878jS7PNgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EHCP75gU; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EHCP75gU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784763345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0kK1VoNlyNmI+SDL0cH0j475bfmahdLmPUVC/MgMsk=;
	b=EHCP75gUCApadzAruxX72yrKFsdYpFcWl/94yGN6aCLG0/2Aoo81JZrJWpVAhsynfXVGgN
	dtN/ct7/X/IKux1R7lkY9pbfutVTkET54Wj15t1ei3nvJKtkklenzM2u/Zc7cGRWLshmhI
	sxVIrVI/kGFtnV9dvLAt/i/kPpeQwGI=
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
Subject: [PATCH bpf-next v1 1/8] resolve_btfids: Implement generic ensure_mem() to grow arrays
Date: Wed, 22 Jul 2026 16:35:11 -0700
Message-ID: <20260722233518.778854-2-ihor.solodrai@linux.dev>
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

push_*() helpers in resolve_btfids contain copy-pasted array growth
logic.  Factor it out into ensure_mem() - a simplified variant of
libbpf_ensure_mem(), and use it in the helpers.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c | 55 ++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index f8a91fa7584f..183466ddc5f9 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -201,6 +201,35 @@ static int eprintf(int level, int var, const char *fmt, ...)
 #define pr_info(fmt, ...) \
 	eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
 
+/*
+ * Grow *data so it can hold at least cnt elements of elem_sz bytes each.
+ * *cap is the capacity in elements and is updated on growth.
+ */
+static int __ensure_mem(void **data, u32 *cap, u32 cnt, size_t elem_sz)
+{
+	u32 new_cap, old_cap = *cap;
+	void *arr;
+
+	if (cnt <= old_cap)
+		return 0;
+
+	new_cap = max(old_cap + 256, old_cap * 2);
+	if (new_cap < cnt)
+		new_cap = cnt;
+
+	arr = realloc(*data, elem_sz * new_cap);
+	if (!arr)
+		return -ENOMEM;
+
+	*data = arr;
+	*cap = new_cap;
+
+	return 0;
+}
+
+#define ensure_mem(arr_ptr, cap_ptr, cnt) \
+	__ensure_mem((void **)(arr_ptr), (cap_ptr), (cnt), sizeof(**(arr_ptr)))
+
 static bool is_btf_id(const char *name)
 {
 	return name && !strncmp(name, BTF_ID_PREFIX, sizeof(BTF_ID_PREFIX) - 1);
@@ -890,17 +919,8 @@ static const struct btf_type *btf_type_skip_qualifiers(const struct btf *btf, s3
 
 static int push_decl_tag_id(struct btf2btf_context *ctx, u32 decl_tag_id)
 {
-	u32 *arr = ctx->decl_tags;
-	u32 cap = ctx->max_decl_tags;
-
-	if (ctx->nr_decl_tags + 1 > cap) {
-		cap = max(cap + 256, cap * 2);
-		arr = realloc(arr, sizeof(u32) * cap);
-		if (!arr)
-			return -ENOMEM;
-		ctx->max_decl_tags = cap;
-		ctx->decl_tags = arr;
-	}
+	if (ensure_mem(&ctx->decl_tags, &ctx->max_decl_tags, ctx->nr_decl_tags + 1))
+		return -ENOMEM;
 
 	ctx->decl_tags[ctx->nr_decl_tags++] = decl_tag_id;
 
@@ -909,17 +929,8 @@ static int push_decl_tag_id(struct btf2btf_context *ctx, u32 decl_tag_id)
 
 static int push_kfunc(struct btf2btf_context *ctx, struct kfunc *kfunc)
 {
-	struct kfunc *arr = ctx->kfuncs;
-	u32 cap = ctx->max_kfuncs;
-
-	if (ctx->nr_kfuncs + 1 > cap) {
-		cap = max(cap + 256, cap * 2);
-		arr = realloc(arr, sizeof(struct kfunc) * cap);
-		if (!arr)
-			return -ENOMEM;
-		ctx->max_kfuncs = cap;
-		ctx->kfuncs = arr;
-	}
+	if (ensure_mem(&ctx->kfuncs, &ctx->max_kfuncs, ctx->nr_kfuncs + 1))
+		return -ENOMEM;
 
 	ctx->kfuncs[ctx->nr_kfuncs++] = *kfunc;
 
-- 
2.55.0

