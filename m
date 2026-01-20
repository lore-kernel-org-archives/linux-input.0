Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF4547AF53
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948053; cv=none; b=EWE5YoLnGNGfk7kapkQpwsglKdDlPDL/5TrmM+3gcOvkn4TpVp30uUgVRrI+Jt7ki7EAnbFoKUuyyFkrMam8pTsYuxk4GKNoNnoyy7XVPuIxDj+RD8uLu70tkGNj/UsbfEZw5lmmgPc7YcIeDgqvPfPZacHyesQINPmYviebX2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948053; c=relaxed/simple;
	bh=6hNHCwx4Akrwo4RTc4wSnoTc5t7XLpnB6CNgn0x6Kac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJogdccmQ2PyhEuGWHQUZwtuhE1RORVMxAcw+F6tqPCwyl3/WmJAgECdpJNLvGL83TxeVEoPYNS0fV7Wrm7FwadiM2T/qw7BLx9H9OnGK9aIK1E1p/T1upJw4qV49MFX3APMIf66VSWsuvshIl/U5xd3PZ76whn1oexBN1qiCvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dFpiVfA4; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dFpiVfA4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768948042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHAgc/d0jkD+OKZBq5SBz++xJuavMoXf6dr8qPjdQwA=;
	b=dFpiVfA4+2sqNNMm/68aVgXIi2A9nkIqGWHq5Sbd+VkV/DtpTv4DtnwhpFije+BKA7LP+y
	bTFTf0CM1T/wona6niwQjDElTX3BA7ctZSrQ5RwW5cr0Vo3oGhn/qTInM1Kux1BFAVrYgx
	ME7O/ywKP7dZMb7ikuJN91tIuRoPLS0=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Tejun Heo <tj@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v3 05/13] resolve_btfids: Support for KF_IMPLICIT_ARGS
Date: Tue, 20 Jan 2026 14:26:30 -0800
Message-ID: <20260120222638.3976562-6-ihor.solodrai@linux.dev>
In-Reply-To: <20260120222638.3976562-1-ihor.solodrai@linux.dev>
References: <20260120222638.3976562-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Implement BTF modifications in resolve_btfids to support BPF kernel
functions with implicit arguments.

For a kfunc marked with KF_IMPLICIT_ARGS flag, a new function
prototype is added to BTF that does not have implicit arguments. The
kfunc's prototype is then updated to a new one in BTF. This prototype
is the intended interface for the BPF programs.

A <func_name>_impl function is added to BTF to make the original kfunc
prototype searchable for the BPF verifier. If a <func_name>_impl
function already exists in BTF, its interpreted as a legacy case, and
this step is skipped.

Whether an argument is implicit is determined by its type:
currently only `struct bpf_prog_aux *` is supported.

As a result, the BTF associated with kfunc is changed from

    __bpf_kfunc bpf_foo(int arg1, struct bpf_prog_aux *aux);

into

    bpf_foo_impl(int arg1, struct bpf_prog_aux *aux);
    __bpf_kfunc bpf_foo(int arg1);

For more context see previous discussions and patches [1][2].

[1] https://lore.kernel.org/dwarves/ba1650aa-fafd-49a8-bea4-bdddee7c38c9@linux.dev/
[2] https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai@linux.dev/

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c | 382 ++++++++++++++++++++++++++++++++
 1 file changed, 382 insertions(+)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 1fcf37af6764..db8d1554bdcc 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -152,6 +152,25 @@ struct object {
 	int nr_typedefs;
 };
 
+#define KF_IMPLICIT_ARGS (1 << 16)
+#define KF_IMPL_SUFFIX "_impl"
+
+struct kfunc {
+	const char *name;
+	u32 btf_id;
+	u32 flags;
+};
+
+struct btf2btf_context {
+	struct btf *btf;
+	u32 *decl_tags;
+	u32 nr_decl_tags;
+	u32 max_decl_tags;
+	struct kfunc *kfuncs;
+	u32 nr_kfuncs;
+	u32 max_kfuncs;
+};
+
 static int verbose;
 static int warnings;
 
@@ -837,6 +856,366 @@ static int dump_raw_btf(struct btf *btf, const char *out_path)
 	return 0;
 }
 
+static const struct btf_type *btf_type_skip_qualifiers(const struct btf *btf, s32 type_id)
+{
+	const struct btf_type *t = btf__type_by_id(btf, type_id);
+
+	while (btf_is_mod(t))
+		t = btf__type_by_id(btf, t->type);
+
+	return t;
+}
+
+static int push_decl_tag_id(struct btf2btf_context *ctx, u32 decl_tag_id)
+{
+	u32 *arr = ctx->decl_tags;
+	u32 cap = ctx->max_decl_tags;
+
+	if (ctx->nr_decl_tags + 1 > cap) {
+		cap = max(cap + 256, cap * 2);
+		arr = realloc(arr, sizeof(u32) * cap);
+		if (!arr)
+			return -ENOMEM;
+		ctx->max_decl_tags = cap;
+		ctx->decl_tags = arr;
+	}
+
+	ctx->decl_tags[ctx->nr_decl_tags++] = decl_tag_id;
+
+	return 0;
+}
+
+static int push_kfunc(struct btf2btf_context *ctx, struct kfunc *kfunc)
+{
+	struct kfunc *arr = ctx->kfuncs;
+	u32 cap = ctx->max_kfuncs;
+
+	if (ctx->nr_kfuncs + 1 > cap) {
+		cap = max(cap + 256, cap * 2);
+		arr = realloc(arr, sizeof(struct kfunc) * cap);
+		if (!arr)
+			return -ENOMEM;
+		ctx->max_kfuncs = cap;
+		ctx->kfuncs = arr;
+	}
+
+	ctx->kfuncs[ctx->nr_kfuncs++] = *kfunc;
+
+	return 0;
+}
+
+static int collect_decl_tags(struct btf2btf_context *ctx)
+{
+	const u32 type_cnt = btf__type_cnt(ctx->btf);
+	struct btf *btf = ctx->btf;
+	const struct btf_type *t;
+	int err;
+
+	for (u32 id = 1; id < type_cnt; id++) {
+		t = btf__type_by_id(btf, id);
+		if (!btf_is_decl_tag(t))
+			continue;
+		err = push_decl_tag_id(ctx, id);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+/*
+ * To find the kfunc flags having its struct btf_id (with ELF addresses)
+ * we need to find the address that is in range of a set8.
+ * If a set8 is found, then the flags are located at addr + 4 bytes.
+ * Return 0 (no flags!) if not found.
+ */
+static u32 find_kfunc_flags(struct object *obj, struct btf_id *kfunc_id)
+{
+	const u32 *elf_data_ptr = obj->efile.idlist->d_buf;
+	u64 set_lower_addr, set_upper_addr, addr;
+	struct btf_id *set_id;
+	struct rb_node *next;
+	u32 flags;
+	u64 idx;
+
+	for (next = rb_first(&obj->sets); next; next = rb_next(next)) {
+		set_id = rb_entry(next, struct btf_id, rb_node);
+		if (set_id->kind != BTF_ID_KIND_SET8 || set_id->addr_cnt != 1)
+			continue;
+
+		set_lower_addr = set_id->addr[0];
+		set_upper_addr = set_lower_addr + set_id->cnt * sizeof(u64);
+
+		for (u32 i = 0; i < kfunc_id->addr_cnt; i++) {
+			addr = kfunc_id->addr[i];
+			/*
+			 * Lower bound is exclusive to skip the 8-byte header of the set.
+			 * Upper bound is inclusive to capture the last entry at offset 8*cnt.
+			 */
+			if (set_lower_addr < addr && addr <= set_upper_addr) {
+				pr_debug("found kfunc %s in BTF_ID_FLAGS %s\n",
+					 kfunc_id->name, set_id->name);
+				idx = addr - obj->efile.idlist_addr;
+				idx = idx / sizeof(u32) + 1;
+				flags = elf_data_ptr[idx];
+
+				return flags;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int collect_kfuncs(struct object *obj, struct btf2btf_context *ctx)
+{
+	const char *tag_name, *func_name;
+	struct btf *btf = ctx->btf;
+	const struct btf_type *t;
+	u32 flags, func_id;
+	struct kfunc kfunc;
+	struct btf_id *id;
+	int err;
+
+	if (ctx->nr_decl_tags == 0)
+		return 0;
+
+	for (u32 i = 0; i < ctx->nr_decl_tags; i++) {
+		t = btf__type_by_id(btf, ctx->decl_tags[i]);
+		if (btf_kflag(t) || btf_decl_tag(t)->component_idx != -1)
+			continue;
+
+		tag_name = btf__name_by_offset(btf, t->name_off);
+		if (strcmp(tag_name, "bpf_kfunc") != 0)
+			continue;
+
+		func_id = t->type;
+		t = btf__type_by_id(btf, func_id);
+		if (!btf_is_func(t))
+			continue;
+
+		func_name = btf__name_by_offset(btf, t->name_off);
+		if (!func_name)
+			continue;
+
+		id = btf_id__find(&obj->funcs, func_name);
+		if (!id || id->kind != BTF_ID_KIND_SYM)
+			continue;
+
+		flags = find_kfunc_flags(obj, id);
+
+		kfunc.name = id->name;
+		kfunc.btf_id = func_id;
+		kfunc.flags = flags;
+
+		err = push_kfunc(ctx, &kfunc);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int build_btf2btf_context(struct object *obj, struct btf2btf_context *ctx)
+{
+	int err;
+
+	ctx->btf = obj->btf;
+
+	err = collect_decl_tags(ctx);
+	if (err) {
+		pr_err("ERROR: resolve_btfids: failed to collect decl tags from BTF\n");
+		return err;
+	}
+
+	err = collect_kfuncs(obj, ctx);
+	if (err) {
+		pr_err("ERROR: resolve_btfids: failed to collect kfuncs from BTF\n");
+		return err;
+	}
+
+	return 0;
+}
+
+
+/* Implicit BPF kfunc arguments can only be of particular types */
+static bool is_kf_implicit_arg(const struct btf *btf, const struct btf_param *p)
+{
+	static const char *const kf_implicit_arg_types[] = {
+		"bpf_prog_aux",
+	};
+	const struct btf_type *t;
+	const char *name;
+
+	t = btf_type_skip_qualifiers(btf, p->type);
+	if (!btf_is_ptr(t))
+		return false;
+
+	t = btf_type_skip_qualifiers(btf, t->type);
+	if (!btf_is_struct(t))
+		return false;
+
+	name = btf__name_by_offset(btf, t->name_off);
+	if (!name)
+		return false;
+
+	for (int i = 0; i < ARRAY_SIZE(kf_implicit_arg_types); i++)
+		if (strcmp(name, kf_implicit_arg_types[i]) == 0)
+			return true;
+
+	return false;
+}
+
+/*
+ * For a kfunc with KF_IMPLICIT_ARGS we do the following:
+ *   1. Add a new function with _impl suffix in the name, with the prototype
+ *      of the original kfunc.
+ *   2. Add all decl tags except "bpf_kfunc" for the _impl func.
+ *   3. Add a new function prototype with modified list of arguments:
+ *      omitting implicit args.
+ *   4. Change the prototype of the original kfunc to the new one.
+ *
+ * This way we transform the BTF associated with the kfunc from
+ *	__bpf_kfunc bpf_foo(int arg1, void *implicit_arg);
+ * into
+ *	bpf_foo_impl(int arg1, void *implicit_arg);
+ *	__bpf_kfunc bpf_foo(int arg1);
+ *
+ * If a kfunc with KF_IMPLICIT_ARGS already has an _impl counterpart
+ * in BTF, then it's a legacy case: an _impl function is declared in the
+ * source code. In this case, we can skip adding an _impl function, but we
+ * still have to add a func prototype that omits implicit args.
+ */
+static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct kfunc *kfunc)
+{
+	s32 idx, new_proto_id, new_func_id, proto_id;
+	const char *param_name, *tag_name;
+	const struct btf_param *params;
+	enum btf_func_linkage linkage;
+	char tmp_name[KSYM_NAME_LEN];
+	struct btf *btf = ctx->btf;
+	int err, len, nr_params;
+	struct btf_type *t;
+
+	t = (struct btf_type *)btf__type_by_id(btf, kfunc->btf_id);
+	if (!t || !btf_is_func(t)) {
+		pr_err("ERROR: resolve_btfids: btf id %d is not a function\n", kfunc->btf_id);
+		return -EINVAL;
+	}
+
+	linkage = btf_vlen(t);
+
+	proto_id = t->type;
+	t = (struct btf_type *)btf__type_by_id(btf, proto_id);
+	if (!t || !btf_is_func_proto(t)) {
+		pr_err("ERROR: resolve_btfids: btf id %d is not a function prototype\n", proto_id);
+		return -EINVAL;
+	}
+
+	len = snprintf(tmp_name, sizeof(tmp_name), "%s%s", kfunc->name, KF_IMPL_SUFFIX);
+	if (len < 0 || len >= sizeof(tmp_name)) {
+		pr_err("ERROR: function name is too long: %s%s\n", kfunc->name, KF_IMPL_SUFFIX);
+		return -E2BIG;
+	}
+
+	if (btf__find_by_name_kind(btf, tmp_name, BTF_KIND_FUNC) > 0) {
+		pr_debug("resolve_btfids: function %s already exists in BTF\n", tmp_name);
+		goto add_new_proto;
+	}
+
+	/* Add a new function with _impl suffix and original prototype */
+	new_func_id = btf__add_func(btf, tmp_name, linkage, proto_id);
+	if (new_func_id < 0) {
+		pr_err("ERROR: resolve_btfids: failed to add func %s to BTF\n", tmp_name);
+		return new_func_id;
+	}
+
+	/* Copy all decl tags except "bpf_kfunc" from the original kfunc to the new one */
+	for (int i = 0; i < ctx->nr_decl_tags; i++) {
+		t = (struct btf_type *)btf__type_by_id(btf, ctx->decl_tags[i]);
+		if (t->type != kfunc->btf_id)
+			continue;
+
+		tag_name = btf__name_by_offset(btf, t->name_off);
+		if (strcmp(tag_name, "bpf_kfunc") == 0)
+			continue;
+
+		idx = btf_decl_tag(t)->component_idx;
+
+		if (btf_kflag(t))
+			err = btf__add_decl_attr(btf, tag_name, new_func_id, idx);
+		else
+			err = btf__add_decl_tag(btf, tag_name, new_func_id, idx);
+
+		if (err < 0) {
+			pr_err("ERROR: resolve_btfids: failed to add decl tag %s for %s\n",
+			       tag_name, tmp_name);
+			return -EINVAL;
+		}
+	}
+
+add_new_proto:
+	t = (struct btf_type *)btf__type_by_id(btf, proto_id);
+	new_proto_id = btf__add_func_proto(btf, t->type);
+	if (new_proto_id < 0) {
+		pr_err("ERROR: resolve_btfids: failed to add func proto for %s\n", kfunc->name);
+		return new_proto_id;
+	}
+
+	/* Add non-implicit args to the new prototype */
+	t = (struct btf_type *)btf__type_by_id(btf, proto_id);
+	nr_params = btf_vlen(t);
+	for (int i = 0; i < nr_params; i++) {
+		params = btf_params(t);
+		if (is_kf_implicit_arg(btf, &params[i]))
+			break;
+		param_name = btf__name_by_offset(btf, params[i].name_off);
+		err = btf__add_func_param(btf, param_name, params[i].type);
+		if (err < 0) {
+			pr_err("ERROR: resolve_btfids: failed to add param %s for %s\n",
+			       param_name, kfunc->name);
+			return err;
+		}
+		t = (struct btf_type *)btf__type_by_id(btf, proto_id);
+	}
+
+	/* Finally change the prototype of the original kfunc to the new one */
+	t = (struct btf_type *)btf__type_by_id(btf, kfunc->btf_id);
+	t->type = new_proto_id;
+
+	pr_debug("resolve_btfids: updated BTF for kfunc with implicit args %s\n", kfunc->name);
+
+	return 0;
+}
+
+static int btf2btf(struct object *obj)
+{
+	struct btf2btf_context ctx = {};
+	int err;
+
+	err = build_btf2btf_context(obj, &ctx);
+	if (err)
+		goto out;
+
+	for (u32 i = 0; i < ctx.nr_kfuncs; i++) {
+		struct kfunc *kfunc = &ctx.kfuncs[i];
+
+		if (!(kfunc->flags & KF_IMPLICIT_ARGS))
+			continue;
+
+		err = process_kfunc_with_implicit_args(&ctx, kfunc);
+		if (err)
+			goto out;
+	}
+
+	err = 0;
+out:
+	free(ctx.decl_tags);
+	free(ctx.kfuncs);
+
+	return err;
+}
+
 /*
  * Sort types by name in ascending order resulting in all
  * anonymous types being placed before named types.
@@ -1126,6 +1505,9 @@ int main(int argc, const char **argv)
 	if (load_btf(&obj))
 		goto out;
 
+	if (btf2btf(&obj))
+		goto out;
+
 	if (finalize_btf(&obj))
 		goto out;
 
-- 
2.52.0

