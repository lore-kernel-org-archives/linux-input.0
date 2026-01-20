Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053D527AC45
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948035; cv=none; b=j1fTrcciQfbZcCl9WPgupk8yLuntSobTvVJEM+l+tSTFn33SEh3NuDVfCg7OnOtLP8HJ1d7lXLXUuM4q2N+bVplF7D2/kO58Q0iUZNu4iELBHL8ilKEDM2M9FG9qiCrv0Lz5NRQsAAP9GxUE+adIzHNFPU5T8DYuZEXVbUVd088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948035; c=relaxed/simple;
	bh=ClhH40r2qfYsIreHdARgsBSvy9Qb0e6K/7x9TqwoVHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHm09Z6MDr/5Mf9w2Vu2G09P/RdemVdcRyHECZ0XcSStws0MQkqIfjKmpvR9C04BFpmuu7s1YdMM9m8O6xR0jHl+a4C0qhDdQwc0Ihx0yCy2SxmJjx7Y8Rud9EGXOBQ1I1/GOQ/UKZkKdtCT74aNn8lKqGh2D5NI2UOjs40D/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j9Kz2Rbg; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j9Kz2Rbg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768948026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZ2yXRnXBmCz9EszVIjaiZik6bhhhIp7PotMx22ewjI=;
	b=j9Kz2RbgR5R27pDDnhfInrqTkViCsBP8825kPM/LFkcZF/T65iZshoalbtiExHX6cqR2vC
	/UXg9yHUwBkjRA9/+zXlztsvCIgqZBzH9A9lnYtPah3iO0h/qiQ/Ox/mS+GLjds0f/EDjE
	1JT6dF0BurpKwjywjT6KjGc01fPj3ug=
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
Subject: [PATCH bpf-next v3 01/13] bpf: Refactor btf_kfunc_id_set_contains
Date: Tue, 20 Jan 2026 14:26:26 -0800
Message-ID: <20260120222638.3976562-2-ihor.solodrai@linux.dev>
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

btf_kfunc_id_set_contains() is called by fetch_kfunc_meta() in the BPF
verifier to get the kfunc flags stored in the .BTF_ids ELF section.
If it returns NULL instead of a valid pointer, it's interpreted as an
illegal kfunc usage failing the verification.

There are two potential reasons for btf_kfunc_id_set_contains() to
return NULL:

  1. Provided kfunc BTF id is not present in relevant kfunc id sets.
  2. The kfunc is not allowed, as determined by the program type
     specific filter [1].

The filter functions accept a pointer to `struct bpf_prog`, so they
might implicitly depend on earlier stages of verification, when
bpf_prog members are set.

For example, bpf_qdisc_kfunc_filter() in linux/net/sched/bpf_qdisc.c
inspects prog->aux->st_ops [2], which is initialized in:

    check_attach_btf_id() -> check_struct_ops_btf_id()

So far this hasn't been an issue, because fetch_kfunc_meta() is the
only caller of btf_kfunc_id_set_contains().

However in subsequent patches of this series it is necessary to
inspect kfunc flags earlier in BPF verifier, in the add_kfunc_call().

To resolve this, refactor btf_kfunc_id_set_contains() into two
interface functions:
  * btf_kfunc_flags() that simply returns pointer to kfunc_flags
    without applying the filters
  * btf_kfunc_is_allowed() that both checks for kfunc_flags existence
    (which is a requirement for a kfunc to be allowed) and applies the
    prog filters

See [3] for the previous version of this patch.

[1] https://lore.kernel.org/all/20230519225157.760788-7-aditi.ghag@isovalent.com/
[2] https://lore.kernel.org/all/20250409214606.2000194-4-ameryhung@gmail.com/
[3] https://lore.kernel.org/bpf/20251029190113.3323406-3-ihor.solodrai@linux.dev/

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 include/linux/btf.h   |  4 +--
 kernel/bpf/btf.c      | 70 ++++++++++++++++++++++++++++++++-----------
 kernel/bpf/verifier.c |  6 ++--
 3 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 78dc79810c7d..a2f4f383f5b6 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -575,8 +575,8 @@ const char *btf_name_by_offset(const struct btf *btf, u32 offset);
 const char *btf_str_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
-u32 *btf_kfunc_id_set_contains(const struct btf *btf, u32 kfunc_btf_id,
-			       const struct bpf_prog *prog);
+u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_prog *prog);
+bool btf_kfunc_is_allowed(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_prog *prog);
 u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 				const struct bpf_prog *prog);
 int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 364dd84bfc5a..d10b3404260f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8757,24 +8757,17 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 	return ret;
 }
 
-static u32 *__btf_kfunc_id_set_contains(const struct btf *btf,
-					enum btf_kfunc_hook hook,
-					u32 kfunc_btf_id,
-					const struct bpf_prog *prog)
+static u32 *btf_kfunc_id_set_contains(const struct btf *btf,
+				      enum btf_kfunc_hook hook,
+				      u32 kfunc_btf_id)
 {
-	struct btf_kfunc_hook_filter *hook_filter;
 	struct btf_id_set8 *set;
-	u32 *id, i;
+	u32 *id;
 
 	if (hook >= BTF_KFUNC_HOOK_MAX)
 		return NULL;
 	if (!btf->kfunc_set_tab)
 		return NULL;
-	hook_filter = &btf->kfunc_set_tab->hook_filters[hook];
-	for (i = 0; i < hook_filter->nr_filters; i++) {
-		if (hook_filter->filters[i](prog, kfunc_btf_id))
-			return NULL;
-	}
 	set = btf->kfunc_set_tab->sets[hook];
 	if (!set)
 		return NULL;
@@ -8785,6 +8778,28 @@ static u32 *__btf_kfunc_id_set_contains(const struct btf *btf,
 	return id + 1;
 }
 
+static bool __btf_kfunc_is_allowed(const struct btf *btf,
+				   enum btf_kfunc_hook hook,
+				   u32 kfunc_btf_id,
+				   const struct bpf_prog *prog)
+{
+	struct btf_kfunc_hook_filter *hook_filter;
+	int i;
+
+	if (hook >= BTF_KFUNC_HOOK_MAX)
+		return false;
+	if (!btf->kfunc_set_tab)
+		return false;
+
+	hook_filter = &btf->kfunc_set_tab->hook_filters[hook];
+	for (i = 0; i < hook_filter->nr_filters; i++) {
+		if (hook_filter->filters[i](prog, kfunc_btf_id))
+			return false;
+	}
+
+	return true;
+}
+
 static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 {
 	switch (prog_type) {
@@ -8832,6 +8847,26 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 	}
 }
 
+bool btf_kfunc_is_allowed(const struct btf *btf,
+			  u32 kfunc_btf_id,
+			  const struct bpf_prog *prog)
+{
+	enum bpf_prog_type prog_type = resolve_prog_type(prog);
+	enum btf_kfunc_hook hook;
+	u32 *kfunc_flags;
+
+	kfunc_flags = btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_COMMON, kfunc_btf_id);
+	if (kfunc_flags && __btf_kfunc_is_allowed(btf, BTF_KFUNC_HOOK_COMMON, kfunc_btf_id, prog))
+		return true;
+
+	hook = bpf_prog_type_to_kfunc_hook(prog_type);
+	kfunc_flags = btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
+	if (kfunc_flags && __btf_kfunc_is_allowed(btf, hook, kfunc_btf_id, prog))
+		return true;
+
+	return false;
+}
+
 /* Caution:
  * Reference to the module (obtained using btf_try_get_module) corresponding to
  * the struct btf *MUST* be held when calling this function from verifier
@@ -8839,26 +8874,27 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
  * keeping the reference for the duration of the call provides the necessary
  * protection for looking up a well-formed btf->kfunc_set_tab.
  */
-u32 *btf_kfunc_id_set_contains(const struct btf *btf,
-			       u32 kfunc_btf_id,
-			       const struct bpf_prog *prog)
+u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_prog *prog)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(prog);
 	enum btf_kfunc_hook hook;
 	u32 *kfunc_flags;
 
-	kfunc_flags = __btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_COMMON, kfunc_btf_id, prog);
+	kfunc_flags = btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_COMMON, kfunc_btf_id);
 	if (kfunc_flags)
 		return kfunc_flags;
 
 	hook = bpf_prog_type_to_kfunc_hook(prog_type);
-	return __btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id, prog);
+	return btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
 }
 
 u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 				const struct bpf_prog *prog)
 {
-	return __btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_FMODRET, kfunc_btf_id, prog);
+	if (!__btf_kfunc_is_allowed(btf, BTF_KFUNC_HOOK_FMODRET, kfunc_btf_id, prog))
+		return NULL;
+
+	return btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_FMODRET, kfunc_btf_id);
 }
 
 static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b67d8981b058..c344371feb33 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13723,10 +13723,10 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 		*kfunc_name = func_name;
 	func_proto = btf_type_by_id(desc_btf, func->type);
 
-	kfunc_flags = btf_kfunc_id_set_contains(desc_btf, func_id, env->prog);
-	if (!kfunc_flags) {
+	if (!btf_kfunc_is_allowed(desc_btf, func_id, env->prog))
 		return -EACCES;
-	}
+
+	kfunc_flags = btf_kfunc_flags(desc_btf, func_id, env->prog);
 
 	memset(meta, 0, sizeof(*meta));
 	meta->btf = desc_btf;
-- 
2.52.0

