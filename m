Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3703439340
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 23:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763361; cv=none; b=n/ApOdxDfeaUnSrWpY4OVnQiAMUlvRxEiKqQ2OHsA//4tNNH3qjp3ged1/4w49uLvryS7a4KKzhfFlSkFAT+tihsOFx+Unp6IOIRwQNkoz1U+bGOf/mwVxPAIVbdAU6jgZYYRTuvbkitw54MccP9jzFM7SRcTofJX11xbNEm+nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763361; c=relaxed/simple;
	bh=bfF8Xr/epAGekemnKUKnya5PQmK64rAMgLvesp7CXp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTBspR+qamkfkkkhFBialAC6vnVXMNYkAK/xTKVrCVYfWZv9H2K6hcr0J1Zs+HzRkjTqZTAc6lEFci2a3d2XO4IvgoBGWJOVIgklm1ME6zgfvdh28GPf7v59KOTrbjv4W2+nP2KrXc4e4v7Sz8ubXhtDcPSo8R4Vqgj2qGfeByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gsvanZI5; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gsvanZI5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784763354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=15L6XY4M4pIKtOjXG1NHAdDbZi98LGH8q01l9N8Azvo=;
	b=gsvanZI5592dnS+8OHSOUU9+tTdzfWLotZKOnQztbJ9UdNssqyBeLXZspcHTF7aJq50XY1
	6D1EQJjn1OR24jZoERNO05IvdXJbYz/xQU97jJVVLdpEOeiX0/QSW7KStkW42OPheaBylg
	+ZGFSjaI89KONwSExqc5G/mLTWJpDhY=
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
Subject: [PATCH bpf-next v1 3/8] resolve_btfids: Keep collected kfuncs in a rbtree
Date: Wed, 22 Jul 2026 16:35:13 -0700
Message-ID: <20260722233518.778854-4-ihor.solodrai@linux.dev>
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

Store collected kfuncs in a rbtree keyed by BTF ID instead of a
dynamically grown array. This allows for efficient deduplication for
kfuncs declared in multiple sets, which is needed for subsequent
patches [1].

[1] https://lore.kernel.org/bpf/CAEf4BzaLzX3mXvQzxv+gbmZOh84XvYofLjMSWFYghNjS-ohEZg@mail.gmail.com/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c | 50 +++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 3198198b03a7..de4986e1bc3d 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -165,6 +165,7 @@ struct object {
 #define KF_IMPL_SUFFIX "_impl"
 
 struct kfunc {
+	struct rb_node rb_node;
 	const char *name;
 	u32 btf_id;
 	u32 flags;
@@ -175,9 +176,7 @@ struct btf2btf_context {
 	u32 *decl_tags;
 	u32 nr_decl_tags;
 	u32 max_decl_tags;
-	struct kfunc *kfuncs;
-	u32 nr_kfuncs;
-	u32 max_kfuncs;
+	struct rb_root kfuncs;
 };
 
 static int verbose;
@@ -979,14 +978,48 @@ static int push_decl_tag_id(struct btf2btf_context *ctx, u32 decl_tag_id)
 
 static int push_kfunc(struct btf2btf_context *ctx, struct kfunc *kfunc)
 {
-	if (ensure_mem(&ctx->kfuncs, &ctx->max_kfuncs, ctx->nr_kfuncs + 1))
+	struct rb_node **p = &ctx->kfuncs.rb_node;
+	struct rb_node *parent = NULL;
+	struct kfunc *k;
+
+	/* Dedup by BTF ID: collecting the same kfunc twice is a no-op. */
+	while (*p) {
+		parent = *p;
+		k = rb_entry(parent, struct kfunc, rb_node);
+
+		if (kfunc->btf_id < k->btf_id)
+			p = &(*p)->rb_left;
+		else if (kfunc->btf_id > k->btf_id)
+			p = &(*p)->rb_right;
+		else
+			return 0;
+	}
+
+	k = zalloc(sizeof(*k));
+	if (!k)
 		return -ENOMEM;
 
-	ctx->kfuncs[ctx->nr_kfuncs++] = *kfunc;
+	*k = *kfunc;
+	rb_link_node(&k->rb_node, parent, p);
+	rb_insert_color(&k->rb_node, &ctx->kfuncs);
 
 	return 0;
 }
 
+static void free_kfuncs(struct rb_root *root)
+{
+	struct rb_node *next;
+	struct kfunc *kfunc;
+
+	next = rb_first(root);
+	while (next) {
+		kfunc = rb_entry(next, struct kfunc, rb_node);
+		next = rb_next(&kfunc->rb_node);
+		rb_erase(&kfunc->rb_node, root);
+		free(kfunc);
+	}
+}
+
 static int collect_decl_tags(struct btf2btf_context *ctx)
 {
 	const u32 type_cnt = btf__type_cnt(ctx->btf);
@@ -1272,14 +1305,15 @@ static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct
 static int btf2btf(struct object *obj)
 {
 	struct btf2btf_context ctx = {};
+	struct rb_node *next;
 	int err;
 
 	err = build_btf2btf_context(obj, &ctx);
 	if (err)
 		goto out;
 
-	for (u32 i = 0; i < ctx.nr_kfuncs; i++) {
-		struct kfunc *kfunc = &ctx.kfuncs[i];
+	for (next = rb_first(&ctx.kfuncs); next; next = rb_next(next)) {
+		struct kfunc *kfunc = rb_entry(next, struct kfunc, rb_node);
 
 		if (!(kfunc->flags & KF_IMPLICIT_ARGS))
 			continue;
@@ -1292,7 +1326,7 @@ static int btf2btf(struct object *obj)
 	err = 0;
 out:
 	free(ctx.decl_tags);
-	free(ctx.kfuncs);
+	free_kfuncs(&ctx.kfuncs);
 
 	return err;
 }
-- 
2.55.0

