Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB4C25B0B8;
	Thu,  1 Oct 2026 22:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895191; cv=none; b=VlgYR7rSMxyTzsuTsxNERxSHLyj5m+3f4NkItX8XxXA3tI4lUa3jYTKOa5KB7VULnAXY2qhQAnElL++TVpKSER1EwXmAeg8inqjNwZHU+TnuIampeh4lvviiTrOkFygi2X02JYmA8JaOl8/LH8fXIYAqhMHeOSu1bDIG2Q2F3g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895191; c=relaxed/simple;
	bh=2v2B3juNDJFptiK/NKFLMZm7soFhrbbPBwzpVRvGGUY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoL9zpnr/lu/cANbt1R5mvc/54YWbdYZNyDGfUZXtY6EtXHUXVvQIdYVCvJxePrsPOIFN8GzM7pc21tut+TCew0QdB+VTFNEhHeq14OR1/Z1z4rdszLrUdnwgBD+meqRZpz9KKj4NKJnVC5bx7D5u21SzO2zzQEQWZw+/vXeNe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=kVabfflT; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="kVabfflT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790895189; x=1822431189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SmKFfA8Vlj1rNLsz3rz2wp0Md5LGKlKwnYajcbq1Zjk=;
  b=kVabfflTJQsJG1QDKIzBbJTXnPqTQH0qdWWBSj/rJOUNDtDZduh51beG
   TXt766tSQOf+/hUeJDgcA1mKALSKCoh7KGOjHHxnjPlxQciI9PCk1aUt/
   jr1BSCPrRymr9MMCX+Wy6i5fyKBcoWvur3v0DLTKj2DgjVrx1rWAXUJcV
   qSIg0cC3Hg/XNNQIDEuxDh/ZXVrxBOdmIYlzGnKbFVLKSfiAa7UtjMzX6
   IzPhkBaHjXnCSe4ImmY4kK/ffoy18JQ9bJ3j1NP6KPYyX1UiBTDNqsI5K
   to7T1rh1zCC4MTHgIhf9olfss0G6wAriL2warFqsGK1dDh1914We2UUmd
   g==;
X-CSE-ConnectionGUID: f3iRKLxnQPCbZpQeumVU7Q==
X-CSE-MsgGUID: qLYlDexmRwKpl0mEjWiw1Q==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="29963803"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 22:53:09 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:12794]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.137:2525] with esmtp (Farcaster)
 id 0433c04b-29ae-46bf-8452-4476878d0a27; Thu, 1 Oct 2026 22:53:09 +0000 (UTC)
X-Farcaster-Flow-ID: 0433c04b-29ae-46bf-8452-4476878d0a27
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:53:08 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:53:08 +0000
From: Jay Wang <wanjay@amazon.com>
To: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>
CC: Alan Maguire <alan.maguire@oracle.com>, Martin KaFai Lau
	<martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	<jolsa@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, Quentin Monnet
	<qmo@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier
	<nsc@kernel.org>, <linux-kbuild@vger.kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>, Christian Heusel
	<christian@heusel.eu>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
	<petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
	<linux-modules@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Masami Hiramatsu" <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	<linux-perf-users@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, "Benjamin
 Tissoires" <bentiss@kernel.org>, <linux-input@vger.kernel.org>, Tejun Heo
	<tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi
	<arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
	<sched-ext@lists.linux.dev>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	<rust-for-linux@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hazem Mohamed
 Abuelfotoh" <abuehaze@amazon.com>, Bjoern Doebel <doebel@amazon.de>, "Martin
 Pohlack" <mpohlack@amazon.de>, <jay.wang.upstream@gmail.com>
Subject: [PATCH bpf-next v4 03/12] bpf: fetch the vmlinux BTF where kernel types enter a program
Date: Thu, 1 Oct 2026 22:52:05 +0000
Message-ID: <20261001225214.12351-4-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261001225214.12351-1-wanjay@amazon.com>
References: <20261001225214.12351-1-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

bpf_check() fetches the vmlinux BTF up front for every program, whether
the program uses kernel types or not.  With the upcoming
CONFIG_DEBUG_INFO_BTF=m the BTF is a module that is loaded on demand,
and since systemd loads socket filters at boot, a program that needs the
BTF only because bpf_check() asked for it would pull it in on every
system, whether anything uses BTF or not.

Stop fetching up front and fetch at the points where kernel types enter
the verifier state instead:

 - bpf_add_kfunc_call(), for the first kfunc call of a program;
 - check_pseudo_btf_id(), for ldimm64 of a kernel variable;
 - check_ptr_to_map_access(), for accessing a map pointer's fields;
 - check_helper_call(), when the helper's prototype takes or returns a
   PTR_TO_BTF_ID, or is bpf_snprintf_btf()/bpf_seq_printf_btf(), which
   take the kernel type id inside a struct btf_ptr instead
   (helper_uses_vmlinux_btf());
 - the program context type table, bpf_ctx_convert, which
   btf_parse_vmlinux() fills in: global subprograms taking the context
   (btf_prepare_func_args()) and context access of tracing and EXT
   programs (btf_translate_to_vmlinux()) go through it, so its readers
   fetch the BTF (bpf_ctx_convert_type()).

Together with the existing fetches in bpf_prog_load() for attach_btf, in
struct_ops map creation and in CO-RE candidate lookup, every way kernel
types enter a program goes through one of these sites.  A program that
uses none of them, such as a socket filter, no longer touches the vmlinux
BTF.

The two callers that used the result of bpf_get_btf_vmlinux() without
checking it, btf_prepare_func_args() and btf_check_kfunc_name(), now do.

bpf_snprintf_btf() and bpf_seq_printf_btf() run in program context, where
the verifier has made sure the BTF is there.  Add bpf_peek_btf_vmlinux(),
which returns the parsed vmlinux BTF or NULL without parsing anything,
and use it there and for the "malformed BTF" check in bpf_check(); the
helpers fail with -EINVAL if the BTF is not parsed, as they do on a
kernel without BTF.

With CONFIG_DEBUG_INFO_BTF=y the vmlinux BTF is parsed at boot by the
first kfunc registration, and without BTF the new helper check is
skipped, so nothing changes for either.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 include/linux/bpf.h      |  1 +
 kernel/bpf/btf.c         | 34 ++++++++++++++++++---
 kernel/bpf/verifier.c    | 66 +++++++++++++++++++++++++++++++++++-----
 kernel/trace/bpf_trace.c |  3 +-
 4 files changed, 91 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4bae3796c42f..e46a14809dd4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3183,6 +3183,7 @@ static inline s32 bpf_call_args_imm(s16 idx)
 #endif
 
 struct btf *bpf_get_btf_vmlinux(void);
+struct btf *bpf_peek_btf_vmlinux(void);
 
 /* Map specifics */
 struct xdp_frame;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index dfd1af8c2ac5..9896a30eeac4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6521,12 +6521,25 @@ static u8 bpf_ctx_convert_map[] = {
 #undef BPF_MAP_TYPE
 #undef BPF_LINK_TYPE
 
+/*
+ * bpf_ctx_convert.t is filled in by btf_parse_vmlinux(), which bpf_check()
+ * does not trigger up front any more.  The program context types are kernel
+ * types too: fetch the vmlinux BTF here, as at the other points where kernel
+ * types enter a program.
+ */
+static const struct btf_type *bpf_ctx_convert_type(void)
+{
+	if (IS_ERR_OR_NULL(bpf_get_btf_vmlinux()))
+		return NULL;
+	return bpf_ctx_convert.t;
+}
+
 static const struct btf_type *find_canonical_prog_ctx_type(enum bpf_prog_type prog_type)
 {
 	const struct btf_type *conv_struct;
 	const struct btf_member *ctx_type;
 
-	conv_struct = bpf_ctx_convert.t;
+	conv_struct = bpf_ctx_convert_type();
 	if (!conv_struct)
 		return NULL;
 	/* prog_type is valid bpf program type. No need for bounds check. */
@@ -6542,7 +6555,7 @@ static int find_kern_ctx_type_id(enum bpf_prog_type prog_type)
 	const struct btf_type *conv_struct;
 	const struct btf_member *ctx_type;
 
-	conv_struct = bpf_ctx_convert.t;
+	conv_struct = bpf_ctx_convert_type();
 	if (!conv_struct)
 		return -EFAULT;
 	/* prog_type is valid bpf program type. No need for bounds check. */
@@ -6801,7 +6814,11 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
 	const struct btf_type *kctx_type;
 	u32 kctx_type_id;
 
-	conv_struct = bpf_ctx_convert.t;
+	conv_struct = bpf_ctx_convert_type();
+	if (!conv_struct) {
+		bpf_log(log, "btf_vmlinux is malformed\n");
+		return -EINVAL;
+	}
 	/* get member for kernel ctx type */
 	kctx_member = btf_type_member(conv_struct) + bpf_ctx_convert_map[prog_type] * 2 + 1;
 	kctx_type_id = kctx_member->type;
@@ -8630,7 +8647,10 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			if (kern_type_id < 0)
 				return kern_type_id;
 
+			/* present: btf_get_ptr_to_btf_id() found the candidate in it */
 			vmlinux_btf = bpf_get_btf_vmlinux();
+			if (IS_ERR_OR_NULL(vmlinux_btf))
+				return -EINVAL;
 			ref_t = btf_type_by_id(vmlinux_btf, kern_type_id);
 			if (!btf_type_is_struct(ref_t)) {
 				tname = __btf_name_by_offset(vmlinux_btf, t->name_off);
@@ -9368,12 +9388,18 @@ static int btf_check_kfunc_name(struct btf *btf, const char *func_name, u32 kind
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	struct btf_module *btf_mod, *tmp;
 #endif
+	struct btf *vmlinux_btf;
 	s32 id;
 
 	if (!btf_is_module(btf))
 		return 0;
 
-	id = btf_find_by_name_kind(bpf_get_btf_vmlinux(), func_name, kind);
+	/* a module BTF only exists once the vmlinux BTF is parsed */
+	vmlinux_btf = bpf_get_btf_vmlinux();
+	if (IS_ERR_OR_NULL(vmlinux_btf))
+		return -EINVAL;
+
+	id = btf_find_by_name_kind(vmlinux_btf, func_name, kind);
 	if (id >= 0) {
 		pr_err("kfunc %s (id: %d) is already present in vmlinux.\n",
 		       func_name, id);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b840b3eb9b22..f375c5dad4b5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2882,7 +2882,8 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	tab = prog_aux->kfunc_tab;
 	btf_tab = prog_aux->kfunc_btf_tab;
 	if (!tab) {
-		if (!btf_vmlinux) {
+		/* kernel types enter the program here, see bpf_check() */
+		if (IS_ERR_OR_NULL(bpf_get_btf_vmlinux())) {
 			verbose(env, "calling kernel function is not supported without CONFIG_DEBUG_INFO_BTF\n");
 			return -ENOTSUPP;
 		}
@@ -6530,7 +6531,8 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 	u32 btf_id;
 	int ret;
 
-	if (!btf_vmlinux) {
+	/* kernel types enter the program here, see bpf_check() */
+	if (IS_ERR_OR_NULL(bpf_get_btf_vmlinux())) {
 		verbose(env, "map_ptr access not supported without CONFIG_DEBUG_INFO_BTF\n");
 		return -ENOTSUPP;
 	}
@@ -12060,6 +12062,24 @@ static int release_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 	return err;
 }
 
+/* Does calling helper @func_id bring kernel BTF types into the program? */
+static bool helper_uses_vmlinux_btf(enum bpf_func_id func_id,
+				    const struct bpf_func_proto *fn)
+{
+	int i;
+
+	/* these take the kernel type id in a struct btf_ptr, not in a register */
+	if (func_id == BPF_FUNC_snprintf_btf || func_id == BPF_FUNC_seq_printf_btf)
+		return true;
+	if (base_type(fn->ret_type) == RET_PTR_TO_BTF_ID)
+		return true;
+	for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
+		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID)
+			return true;
+	}
+	return false;
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -12129,6 +12149,18 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return err;
 	}
 
+	/*
+	 * Helpers that take or return kernel BTF pointers bring kernel types
+	 * into the program, see bpf_check().  Without CONFIG_DEBUG_INFO_BTF
+	 * they keep failing as they always did.
+	 */
+	if (IS_ENABLED(CONFIG_DEBUG_INFO_BTF) && helper_uses_vmlinux_btf(func_id, fn) &&
+	    IS_ERR_OR_NULL(bpf_get_btf_vmlinux())) {
+		verbose(env, "helper %s#%d is not supported without vmlinux BTF\n",
+			func_id_name(func_id), func_id);
+		return -ENOTSUPP;
+	}
+
 	if (fn->might_sleep && !in_sleepable_context(env)) {
 		const char *suggestion;
 
@@ -19812,12 +19844,13 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 			return -EINVAL;
 		}
 	} else {
-		if (!btf_vmlinux) {
+		/* kernel types enter the program here, see bpf_check() */
+		btf = bpf_get_btf_vmlinux();
+		if (IS_ERR_OR_NULL(btf)) {
 			verbose(env, "kernel is missing BTF, make sure CONFIG_DEBUG_INFO_BTF=y is specified in Kconfig.\n");
 			return -EINVAL;
 		}
-		btf_get(btf_vmlinux);
-		btf = btf_vmlinux;
+		btf_get(btf);
 	}
 
 	err = __check_pseudo_btf_id(env, insn, aux, btf);
@@ -21871,6 +21904,17 @@ struct btf *bpf_get_btf_vmlinux(void)
 	return btf;
 }
 
+/*
+ * The vmlinux BTF if it has been parsed already, else NULL.  Unlike
+ * bpf_get_btf_vmlinux() this never parses anything: for a running BPF
+ * program, and for code that only uses the BTF if it happens to be there.
+ */
+struct btf *bpf_peek_btf_vmlinux(void)
+{
+	/* Pairs with the smp_store_release() in bpf_get_btf_vmlinux() */
+	return smp_load_acquire(&btf_vmlinux);
+}
+
 /*
  * The add_fd_from_fd_array() is executed only if fd_array_cnt is non-zero. In
  * this case expect that every file descriptor in the array is either a map or
@@ -22470,7 +22514,13 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret)
 		goto err_prep;
 
-	bpf_get_btf_vmlinux();
+	/*
+	 * The vmlinux BTF is not fetched up front, only at the points where
+	 * kernel types enter the program (attach_btf, kfuncs, ksyms, map
+	 * pointers, BTF-typed helpers, the context type table): with
+	 * CONFIG_DEBUG_INFO_BTF=m it is a module, which a program that uses
+	 * no kernel types must not need.
+	 */
 
 	/* Serialize verification of unprivileged programs. */
 	if (!is_priv)
@@ -22491,10 +22541,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 
 	mark_verifier_state_clean(env);
 
-	if (IS_ERR(btf_vmlinux)) {
+	if (IS_ERR(bpf_peek_btf_vmlinux())) {
 		/* Either gcc or pahole or kernel are broken. */
 		verbose(env, "in-kernel BTF is malformed\n");
-		ret = PTR_ERR(btf_vmlinux);
+		ret = PTR_ERR(bpf_peek_btf_vmlinux());
 		goto skip_full_check;
 	}
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 195f78db9bda..c022b2877f0b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1015,7 +1015,8 @@ static int bpf_btf_printf_prepare(struct btf_ptr *ptr, u32 btf_ptr_size,
 	if (btf_ptr_size != sizeof(struct btf_ptr))
 		return -EINVAL;
 
-	*btf = bpf_get_btf_vmlinux();
+	/* Called from a running program: only use the BTF if it is parsed. */
+	*btf = bpf_peek_btf_vmlinux();
 
 	if (IS_ERR_OR_NULL(*btf))
 		return IS_ERR(*btf) ? PTR_ERR(*btf) : -EINVAL;
-- 
2.47.3

