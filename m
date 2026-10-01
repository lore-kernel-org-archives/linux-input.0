Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598BA4B828D;
	Thu,  1 Oct 2026 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895238; cv=none; b=Vb3vyONj2EV1Viunc6BF+meeF9Y/40bsz2zCwjNE9M/RR3OaDf1fPV+YT5/WX2jUvc59fnsXO0J7MVaHmiqICM3449dyoH/S5ugGhDUzV7PsEcUY/VZYK9qXrMd+F4J+5FSgJeGwxkQyTAS1JBczoxg1uPtTRTnsrHbymQXk9yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895238; c=relaxed/simple;
	bh=RMsqgCD7Mx2tYSltlpaqJFtVB6ImEwaLj0C/belD0o0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1zNzS953BNx3INClaFILwwXNRxa23f7Ko9JcJW6+tx3XHNvi27Kuim5Ppxn8zGdM0uItRJqcEXvR3GcUOzZTPh86LE7Yd7btcTAWXfrIZGBQ5NozYCtPyY6rVd56tqrumz3h29F5TM2Yu1GgNYJq3jroESYe9vWfvLimuPkcJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=IB9ve49k; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="IB9ve49k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790895236; x=1822431236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xsVBl4lbVXYKvc84DcomMFE+JKw551Jx6qM17D38wUc=;
  b=IB9ve49k6Q5iknVh13HrDk02U/SYKyZ/vHTYZiMpZq/OoDs2+yFqbwOn
   ytEFSjxPUnz3DhHNdkmZBQfdpLd8Q/OFcZV2cIGPPz+7aOsb+xKljuyM5
   I88H0rCnD3xOKynbLRFgd5t4NSNRoLIovVHMdofYJphHup2McEO86LCSi
   eE+Z8ONQ8e+6uNqiFu7fmnaLVFsGX5e9E5Y/iGf4Xa/mkpdeAVuKuPBwm
   i+g1ZtutOtnC+HusGLuyOORXySt+inpa1EeU29aDtuJ/6pKn0c1vRZPgd
   yq+tHqBfk1oAM4p11X2haMy0UqeL6dPtB0NSTthUOoZiI9HXxd6V/MYwF
   Q==;
X-CSE-ConnectionGUID: FxGqClP3QIeyFecIMM3Etw==
X-CSE-MsgGUID: +Y3hfgP4SPiGyYHMWZs3iQ==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="30175450"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 22:53:56 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:3008]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.153:2525] with esmtp (Farcaster)
 id 781587d9-7db1-412c-b237-3f814f310e21; Thu, 1 Oct 2026 22:53:55 +0000 (UTC)
X-Farcaster-Flow-ID: 781587d9-7db1-412c-b237-3f814f310e21
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:53:55 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:53:55 +0000
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
Subject: [PATCH bpf-next v4 06/12] bpf: defer vmlinux kfunc and struct_ops registrations
Date: Thu, 1 Oct 2026 22:52:08 +0000
Message-ID: <20261001225214.12351-7-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

With CONFIG_DEBUG_INFO_BTF=m the vmlinux BTF is loaded on first use.  For
that to save anything, nothing may pull it in at boot.  The verifier no
longer does since the previous patches, but register_btf_kfunc_id_set(),
register_btf_id_dtor_kfuncs() and register_bpf_struct_ops() for vmlinux
run from initcalls and need the parsed BTF.

Queue them instead (btf_defer_reg()) and apply them in
btf_parse_vmlinux(), before the BTF is published, so that no program can
see a vmlinux BTF without its kfuncs and struct_ops, not even by id: the
id is reserved before the queue is applied, so that nothing can fail once
it is, and installed afterwards (btf_reserve_id(), btf_install_id()).
Applying a struct_ops runs its ->init(), which registers the kfunc sets
of its hook; those land back on the queue, so it is drained in a loop
until a pass adds nothing, and only then are new registrations applied
directly.  The dtor arrays are copied: every caller in the tree builds
them on the stack of its initcall.

The queue has its own lock, btf_vmlinux_regs_mutex: it is drained under
btf_vmlinux_lock, and with its own lock btf_module_mutex, which the
module notifier takes, is never taken under btf_vmlinux_lock, so the two
stay unordered.

A parse failure other than -ENOMEM is remembered by
bpf_load_btf_vmlinux(), so nothing would ever apply the queue: it is then
freed and closed, and later registrations fail as they do with =y.

Module registrations are not queued yet; the next patch does that
together with deferring the module BTF itself.  With =y the BTF is
present from boot and nothing is queued.  Nothing here is reachable
until the Kconfig symbol becomes a tristate.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 kernel/bpf/btf.c | 271 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 268 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2aa9d4b3f438..96241dc62dc3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1786,13 +1786,13 @@ static int btf_add_type(struct btf_verifier_env *env, struct btf_type *t)
 	return 0;
 }
 
-static int btf_alloc_id(struct btf *btf)
+static int __btf_alloc_id(struct btf *btf, struct btf *entry)
 {
 	int id;
 
 	idr_preload(GFP_KERNEL);
 	spin_lock_bh(&btf_idr_lock);
-	id = idr_alloc_cyclic(&btf_idr, btf, 1, INT_MAX, GFP_ATOMIC);
+	id = idr_alloc_cyclic(&btf_idr, entry, 1, INT_MAX, GFP_ATOMIC);
 	if (id > 0)
 		btf->id = id;
 	spin_unlock_bh(&btf_idr_lock);
@@ -1804,6 +1804,29 @@ static int btf_alloc_id(struct btf *btf)
 	return id > 0 ? 0 : id;
 }
 
+static int btf_alloc_id(struct btf *btf)
+{
+	return __btf_alloc_id(btf, btf);
+}
+
+/*
+ * A BTF that gets registrations applied after it is parsed, with
+ * CONFIG_DEBUG_INFO_BTF=m, has its id reserved before, so that nothing can
+ * fail once they are applied, and installed after, so that nobody finds it
+ * by id in the meantime (btf_get_fd_by_id() and idr_get_next() skip NULL).
+ */
+static int btf_reserve_id(struct btf *btf)
+{
+	return __btf_alloc_id(btf, NULL);
+}
+
+static void btf_install_id(struct btf *btf)
+{
+	spin_lock_bh(&btf_idr_lock);
+	idr_replace(&btf_idr, btf, btf->id);
+	spin_unlock_bh(&btf_idr_lock);
+}
+
 static void btf_free_id(struct btf *btf)
 {
 	unsigned long flags;
@@ -6960,6 +6983,9 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	return ERR_PTR(err);
 }
 
+static void btf_apply_deferred_vmlinux_regs(struct btf *btf);
+static void btf_drop_deferred_vmlinux_regs(void);
+
 struct btf *btf_parse_vmlinux(void)
 {
 	struct btf_verifier_env *env = NULL;
@@ -6986,13 +7012,29 @@ struct btf *btf_parse_vmlinux(void)
 
 	/* btf_parse_vmlinux() runs under btf_vmlinux_lock */
 	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
-	err = btf_alloc_id(btf);
+	err = btf_reserve_id(btf);
 	if (err) {
 		bpf_ctx_convert.t = NULL;
 		btf_free(btf);
 		btf = ERR_PTR(err);
+		goto err_out;
 	}
+
+	/*
+	 * With CONFIG_DEBUG_INFO_BTF=m, kfunc, dtor kfunc and struct_ops
+	 * registrations for vmlinux made before the BTF was available were
+	 * queued; apply them now, before the BTF becomes visible to anyone,
+	 * by id or through bpf_get_btf_vmlinux().
+	 */
+	btf_apply_deferred_vmlinux_regs(btf);
+	btf_install_id(btf);
 err_out:
+	/*
+	 * Any failure but -ENOMEM is remembered by bpf_load_btf_vmlinux(), so
+	 * the queued registrations would never be applied.
+	 */
+	if (IS_ERR(btf) && PTR_ERR(btf) != -ENOMEM)
+		btf_drop_deferred_vmlinux_regs();
 	btf_verifier_env_free(env);
 	return btf;
 }
@@ -9110,6 +9152,33 @@ enum {
 #define BTF_MODULE_NOTIFIER 1
 #endif
 
+/*
+ * CONFIG_DEBUG_INFO_BTF=m: a kfunc, dtor kfunc or struct_ops registration
+ * made while the BTF it applies to is not available yet.  Kept until the BTF
+ * arrives, see btf_defer_reg().
+ */
+enum btf_deferred_reg_kind {
+	BTF_DEFERRED_KFUNC_SET,
+	BTF_DEFERRED_DTOR_KFUNCS,
+	BTF_DEFERRED_STRUCT_OPS,
+};
+
+struct btf_deferred_reg {
+	struct list_head list;
+	enum btf_deferred_reg_kind kind;
+	union {
+		struct {
+			enum btf_kfunc_hook hook;
+			const struct btf_kfunc_id_set *kset;
+		} kfunc;
+		struct {
+			const struct btf_id_dtor_kfunc *dtors;
+			u32 cnt;
+		} dtor;
+		struct bpf_struct_ops *st_ops;
+	};
+};
+
 #ifdef BTF_MODULE_NOTIFIER
 struct btf_module {
 	struct list_head list;
@@ -9905,12 +9974,22 @@ static int btf_kfunc_id_set_add(struct btf *btf, enum btf_kfunc_hook hook,
 	return btf_populate_kfunc_set(btf, hook, kset);
 }
 
+static int btf_defer_reg(struct module *owner, const struct btf_deferred_reg *tmpl);
+
 static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 				       const struct btf_kfunc_id_set *kset)
 {
+	struct btf_deferred_reg tmpl = {
+		.kind = BTF_DEFERRED_KFUNC_SET,
+		.kfunc = { .hook = hook, .kset = kset },
+	};
 	struct btf *btf;
 	int ret;
 
+	ret = btf_defer_reg(kset->owner, &tmpl);
+	if (ret)
+		return ret > 0 ? 0 : ret;
+
 	btf = btf_get_module_btf(kset->owner);
 	if (!btf)
 		return check_btf_kconfigs(kset->owner, "kfunc");
@@ -10079,9 +10158,17 @@ static int btf_dtor_kfuncs_add(struct btf *btf, const struct btf_id_dtor_kfunc *
 int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
 				struct module *owner)
 {
+	struct btf_deferred_reg tmpl = {
+		.kind = BTF_DEFERRED_DTOR_KFUNCS,
+		.dtor = { .dtors = dtors, .cnt = add_cnt },
+	};
 	struct btf *btf;
 	int ret;
 
+	ret = btf_defer_reg(owner, &tmpl);
+	if (ret)
+		return ret > 0 ? 0 : ret;
+
 	btf = btf_get_module_btf(owner);
 	if (!btf)
 		return check_btf_kconfigs(owner, "dtor kfuncs");
@@ -10751,9 +10838,17 @@ static int btf_struct_ops_register(struct btf *btf, struct bpf_struct_ops *st_op
 
 int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
 {
+	struct btf_deferred_reg tmpl = {
+		.kind = BTF_DEFERRED_STRUCT_OPS,
+		.st_ops = st_ops,
+	};
 	struct btf *btf;
 	int err;
 
+	err = btf_defer_reg(st_ops->owner, &tmpl);
+	if (err)
+		return err > 0 ? 0 : err;
+
 	btf = btf_get_module_btf(st_ops->owner);
 	if (!btf)
 		return check_btf_kconfigs(st_ops->owner, "struct_ops");
@@ -10765,8 +10860,178 @@ int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
 	return err;
 }
 EXPORT_SYMBOL_GPL(__register_bpf_struct_ops);
+#elif defined(BTF_MODULE_NOTIFIER)
+static int btf_struct_ops_register(struct btf *btf, struct bpf_struct_ops *st_ops)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
+/*
+ * CONFIG_DEBUG_INFO_BTF=m: registrations for vmlinux made before its BTF is
+ * available wait in btf_vmlinux_deferred_regs until btf_parse_vmlinux()
+ * applies them.
+ */
+#ifdef BTF_MODULE_NOTIFIER
+/*
+ * The queue has its own lock: it is drained under btf_vmlinux_lock, and
+ * with its own lock btf_module_mutex, which the module notifier takes, is
+ * never taken under btf_vmlinux_lock, so the two stay unordered.
+ */
+static DEFINE_MUTEX(btf_vmlinux_regs_mutex);
+static LIST_HEAD(btf_vmlinux_deferred_regs);
+/* Set when the vmlinux BTF is parsed; new registrations apply directly */
+static bool btf_vmlinux_regs_closed;
+
+/*
+ * Queue @tmpl if the BTF for @owner is not available yet.  Returns 1 if the
+ * registration was queued and is to be considered done, 0 if the caller has
+ * to apply it, or -ENOMEM.  Only vmlinux registrations are queued so far.
+ */
+static int btf_defer_reg(struct module *owner, const struct btf_deferred_reg *tmpl)
+{
+	struct list_head *head = NULL;
+	struct btf_deferred_reg *reg;
+
+	if (!IS_MODULE(CONFIG_DEBUG_INFO_BTF) || owner)
+		return 0;
+
+	guard(mutex)(&btf_vmlinux_regs_mutex);
+	if (!btf_vmlinux_regs_closed)
+		head = &btf_vmlinux_deferred_regs;
+	if (!head)
+		return 0;
+
+	reg = kmemdup(tmpl, sizeof(*reg), GFP_KERNEL);
+	if (!reg)
+		return -ENOMEM;
+	/*
+	 * kfunc id sets and struct_ops are static data of their owner, but
+	 * the dtor arrays are commonly built on the stack of the initcall.
+	 */
+	if (reg->kind == BTF_DEFERRED_DTOR_KFUNCS) {
+		reg->dtor.dtors = kmemdup_array(tmpl->dtor.dtors, tmpl->dtor.cnt,
+						sizeof(*tmpl->dtor.dtors), GFP_KERNEL);
+		if (!reg->dtor.dtors) {
+			kfree(reg);
+			return -ENOMEM;
+		}
+	}
+	list_add_tail(&reg->list, head);
+	return 1;
+}
+
+static void btf_free_deferred_reg(struct btf_deferred_reg *reg)
+{
+	if (reg->kind == BTF_DEFERRED_DTOR_KFUNCS)
+		kfree(reg->dtor.dtors);
+	kfree(reg);
+}
+
+static const char *btf_deferred_reg_name(const struct btf_deferred_reg *reg)
+{
+	switch (reg->kind) {
+	case BTF_DEFERRED_KFUNC_SET:	return "kfunc set";
+	case BTF_DEFERRED_DTOR_KFUNCS:	return "dtor kfuncs";
+	case BTF_DEFERRED_STRUCT_OPS:	return "struct_ops";
+	}
+	return "?";
+}
+
+static int btf_apply_deferred_reg(struct btf *btf, const struct btf_deferred_reg *reg)
+{
+	switch (reg->kind) {
+	case BTF_DEFERRED_KFUNC_SET:
+		return btf_kfunc_id_set_add(btf, reg->kfunc.hook, reg->kfunc.kset);
+	case BTF_DEFERRED_DTOR_KFUNCS:
+		return btf_dtor_kfuncs_add(btf, reg->dtor.dtors, reg->dtor.cnt);
+	case BTF_DEFERRED_STRUCT_OPS:
+		return btf_struct_ops_register(btf, reg->st_ops);
+	}
+	return -EINVAL;
+}
+
+/* Apply and free the registrations in @regs to @btf. */
+static void btf_apply_deferred_regs(struct btf *btf, struct list_head *regs)
+{
+	struct btf_deferred_reg *reg, *tmp;
+	int err;
+
+	list_for_each_entry_safe(reg, tmp, regs, list) {
+		err = btf_apply_deferred_reg(btf, reg);
+		if (err)
+			pr_warn("failed to register deferred %s for [%s] BTF: %d\n",
+				btf_deferred_reg_name(reg), btf->name, err);
+		list_del(&reg->list);
+		btf_free_deferred_reg(reg);
+	}
+}
+
+/*
+ * The vmlinux BTF has just been parsed; apply the registrations that waited
+ * for it.  Runs under btf_vmlinux_lock, before @btf is published, so nothing
+ * can observe a vmlinux BTF without its kfuncs and struct_ops.
+ *
+ * Applying a registration can queue further ones: a struct_ops ->init()
+ * registers the kfuncs of its hook.  Those cannot be applied directly, the
+ * BTF is only published once we are done, so the queue stays open until a
+ * pass applies nothing new, and only then are registrations applied directly.
+ */
+static void btf_apply_deferred_vmlinux_regs(struct btf *btf)
+{
+	LIST_HEAD(regs);
+
+	if (!IS_MODULE(CONFIG_DEBUG_INFO_BTF))
+		return;
+
+	mutex_lock(&btf_vmlinux_regs_mutex);
+	while (!list_empty(&btf_vmlinux_deferred_regs)) {
+		list_splice_init(&btf_vmlinux_deferred_regs, &regs);
+		mutex_unlock(&btf_vmlinux_regs_mutex);
+		btf_apply_deferred_regs(btf, &regs);
+		mutex_lock(&btf_vmlinux_regs_mutex);
+	}
+	btf_vmlinux_regs_closed = true;
+	mutex_unlock(&btf_vmlinux_regs_mutex);
+}
+
+/*
+ * The vmlinux BTF will not become available: free the queued registrations
+ * and close the queue, so that later ones fail as they do with =y.
+ */
+static void btf_drop_deferred_vmlinux_regs(void)
+{
+	struct btf_deferred_reg *reg, *tmp;
+	LIST_HEAD(regs);
+
+	if (!IS_MODULE(CONFIG_DEBUG_INFO_BTF))
+		return;
+
+	mutex_lock(&btf_vmlinux_regs_mutex);
+	list_splice_init(&btf_vmlinux_deferred_regs, &regs);
+	btf_vmlinux_regs_closed = true;
+	mutex_unlock(&btf_vmlinux_regs_mutex);
+
+	list_for_each_entry_safe(reg, tmp, &regs, list) {
+		list_del(&reg->list);
+		btf_free_deferred_reg(reg);
+	}
+}
+#else
+static int btf_defer_reg(struct module *owner, const struct btf_deferred_reg *tmpl)
+{
+	return 0;
+}
+
+static void btf_apply_deferred_vmlinux_regs(struct btf *btf)
+{
+}
+
+static void btf_drop_deferred_vmlinux_regs(void)
+{
+}
+#endif /* BTF_MODULE_NOTIFIER */
+
 bool btf_param_match_suffix(const struct btf *btf,
 			    const struct btf_param *arg,
 			    const char *suffix)
-- 
2.47.3

