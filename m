Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124C93CA48E;
	Thu,  1 Oct 2026 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895254; cv=none; b=Kwk/3P+2rzFmhIED/A0uIgZ0wd9jMNi4w455A5i/y07JCqXR0dkn3zi1/K2rIR6Lt4VU64iPllMVLhqX501L1Z3fjUtpe3fn6lotR8AXjzGy012EMFKuSkxvKPiASeb0cG2Fl8CJKej8l9+eqQWLw+CICAZ6Dan9tQTs/LKmFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895254; c=relaxed/simple;
	bh=lYD7IH6vOyE4ZxxLIBaA7HTdcJUfkvg9i0GQqQybZgQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AaWIzvNFwvLghBeUieiF7Fyf78KiYRJ1iWlbs4DbJt4oisuL6qwobCTRhOTGV5yXtX3qleAY9oc8WXCeFpo3Zzaq/MjxqKZSGsnQJ/p/512L/LatTfPoY5UkYYtRFHHiDUM4trq/1EbqSSpDKy/E51g4gUHQJVMxg/2BQpADkCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=rUay+QoX; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="rUay+QoX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790895252; x=1822431252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=deVFXoSjRYj5cTkpAHGuqEEztm/V1OlL3wku/70ZOgE=;
  b=rUay+QoXifGhweA0xSKKRRhYko/Xw9cdbgTC7FiEaSkc6OqodVcHYFzp
   2b5VConYUv7Tv7j3ez9lhxq+Erfk3MJ9OkJUhAgPSHtY103B84kWIFKFe
   LrEppotsrXGRQ22RmgKivGe72hl3iVj7a2kPKocrvlS2N+hWN/dL9tphw
   oSDGKGZ1dG82z3szTf0JIskuwfEBuOw3BtBqEqr3BCsmZ0arme3VJ4E/q
   IYvVO79Wel+L8m2dfoWEVuxEo0ebFuTphV/lxo5+LtNqWOYhRKeYO0kO9
   wEr6q/E8RPtgbKSx9gkA5GZVC6+NEuWmOQeT/gpc13wraPTPW3KMG6eAZ
   Q==;
X-CSE-ConnectionGUID: f3vhE18sT7e74kSek55BLQ==
X-CSE-MsgGUID: uLO/+vi2QwmKOkG/vd6sZg==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="30095107"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 22:54:11 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:16953]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.164:2525] with esmtp (Farcaster)
 id 987dd74d-134e-4e48-89f0-037ed39f82d1; Thu, 1 Oct 2026 22:54:11 +0000 (UTC)
X-Farcaster-Flow-ID: 987dd74d-134e-4e48-89f0-037ed39f82d1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:54:11 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:54:10 +0000
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
Subject: [PATCH bpf-next v4 07/12] bpf: keep module BTF until the vmlinux BTF is available
Date: Thu, 1 Oct 2026 22:52:09 +0000
Message-ID: <20261001225214.12351-8-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Module BTF is split BTF against the vmlinux BTF and is parsed in the
module notifier.  With CONFIG_DEBUG_INFO_BTF=m the vmlinux BTF may not be
loaded yet when a module loads, and the notifier cannot load btf_vmlinux
(that would nest a module load in a module load).

So a module loaded before the vmlinux BTF keeps a copy of its .BTF and
.BTF.base and gets a list entry with btf == NULL; its kfunc, dtor kfunc
and struct_ops registrations wait on that entry.  Without a .BTF.base
the data is final and is exposed in /sys/kernel/btf right away (the raw
bytes need no parsing); with one, parsing relocates the data in place,
so its file is created once parsed, as with =y.  The next patch creates
that file earlier.

When the vmlinux BTF arrives, btf_parse_deferred_modules() parses the
kept copies (the copy is the one btf_parse_module() makes anyway, so an
existing sysfs file keeps pointing at valid data), applies the waiting
registrations and only then publishes the BTF, so nobody sees a module
BTF without its kfuncs; its id is reserved before the registrations are
applied and installed after.  Applying walks the module list
(btf_check_kfunc_name()) and so happens with btf_module_mutex dropped
and the module pinned, and it loops, as for vmlinux, because a struct_ops
->init() registers kfuncs in turn.  A module that is still initializing
when the vmlinux BTF arrives is only published; its init is still
queueing registrations, later ones queue behind them so that the order
is kept, and MODULE_STATE_LIVE applies them once init is done, before
the module counts as live, as with =y.  This also keeps a module whose
init fails from being touched after it is freed.

bpf_load_btf_vmlinux() returns only once the kept module BTF is
registered, also to callers that come while another one is doing it.
Until then a search of the module BTFs by name (bpf_find_btf_id(), and
in-kernel CO-RE candidate search) may miss a module that is loaded;
rather than taking a missing type for a local one, or caching the
candidates, it counts a vmlinux BTF miss and fails, and bpf() runs the
command again after waiting.

A module whose BTF cannot be kept for lack of memory fails to load, as
with =y when its BTF fails to parse, unless
CONFIG_MODULE_ALLOW_BTF_MISMATCH.

A module whose BTF turns out to mismatch at that point is already
running and keeps running without BTF, with a warning; its entry stays,
dead, until the module goes, and keeps the raw data a sysfs file may
serve.  With =y such a module would have been refused at load time
unless CONFIG_MODULE_ALLOW_BTF_MISMATCH; that check only applies to
modules loaded after the vmlinux BTF.  If the vmlinux BTF itself fails
to parse for good, every kept module becomes such a dead entry.

Walkers of the module BTF list skip entries whose BTF is not parsed yet.
With =y the BTF is present from boot and the notifier takes the existing
path.  Still nothing is reachable until the Kconfig symbol becomes a
tristate.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 include/linux/bpf.h   |   5 +
 include/linux/btf.h   |  10 ++
 kernel/bpf/btf.c      | 333 +++++++++++++++++++++++++++++++++++++++---
 kernel/bpf/verifier.c |  39 +++--
 4 files changed, 359 insertions(+), 28 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d812dbc683ae..f6634600467e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3187,11 +3187,16 @@ struct btf *bpf_peek_btf_vmlinux(void);
 struct btf *bpf_load_btf_vmlinux(void);
 #if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
 unsigned int bpf_btf_vmlinux_misses(void);
+void bpf_btf_vmlinux_miss(void);
 #else
 static inline unsigned int bpf_btf_vmlinux_misses(void)
 {
 	return 0;
 }
+
+static inline void bpf_btf_vmlinux_miss(void)
+{
+}
 #endif
 
 /* Map specifics */
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 81e6c65fe5f6..b546531dd6f4 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -603,6 +603,16 @@ const char *btf_name_by_offset(const struct btf *btf, u32 offset);
 const char *btf_str_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
 void *btf_vmlinux_data(u32 *size, bool load);
+#if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+void btf_parse_deferred_modules(void);
+bool btf_deferred_modules_pending(void);
+#else
+static inline void btf_parse_deferred_modules(void) {}
+static inline bool btf_deferred_modules_pending(void)
+{
+	return false;
+}
+#endif
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
 u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_prog *prog);
 int btf_kfunc_check_flag(const struct btf *btf, u32 kfunc_btf_id, u32 flag);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 96241dc62dc3..4d51fb212218 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -719,6 +719,12 @@ s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
 		return ret;
 	}
 
+	/* the modules loaded before the vmlinux BTF may not be registered yet */
+	if (btf_deferred_modules_pending()) {
+		bpf_btf_vmlinux_miss();
+		return -EINVAL;
+	}
+
 	/* If name is not found in vmlinux's BTF then search in module's BTFs */
 	spin_lock_bh(&btf_idr_lock);
 	idr_for_each_entry(&btf_idr, btf, id) {
@@ -9155,7 +9161,7 @@ enum {
 /*
  * CONFIG_DEBUG_INFO_BTF=m: a kfunc, dtor kfunc or struct_ops registration
  * made while the BTF it applies to is not available yet.  Kept until the BTF
- * arrives, see btf_defer_reg().
+ * arrives, see btf_defer_reg() and btf_apply_deferred_regs().
  */
 enum btf_deferred_reg_kind {
 	BTF_DEFERRED_KFUNC_SET,
@@ -9180,12 +9186,30 @@ struct btf_deferred_reg {
 };
 
 #ifdef BTF_MODULE_NOTIFIER
+static void btf_free_deferred_regs(struct list_head *regs);
+static void btf_apply_deferred_regs(struct btf *btf, struct list_head *regs);
+
 struct btf_module {
 	struct list_head list;
 	struct module *module;
 	struct btf *btf;
 	struct bin_attribute *sysfs_attr;
 	int flags;
+	/*
+	 * CONFIG_DEBUG_INFO_BTF=m: a module loaded before the vmlinux BTF is
+	 * available cannot have its BTF parsed yet.  Its .BTF and .BTF.base
+	 * sections are copied here and parsed once the vmlinux BTF arrives
+	 * (btf_parse_deferred_modules()); @btf is NULL until then.
+	 * Registrations of the module's kfuncs, dtor kfuncs and struct_ops
+	 * wait in @deferred_regs.
+	 */
+	void *data;
+	void *base_data;
+	u32 data_size;
+	u32 base_data_size;
+	struct list_head deferred_regs;
+	/* the kept BTF turned out unusable; the entry stays until the module goes */
+	bool gone;
 };
 
 static LIST_HEAD(btf_modules);
@@ -9229,8 +9253,14 @@ static void btf_module_free(struct btf_module *btf_mod)
 {
 	if (btf_mod->sysfs_attr)
 		sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
-	purge_cand_cache(btf_mod->btf);
-	btf_put(btf_mod->btf);
+	if (btf_mod->btf) {
+		purge_cand_cache(btf_mod->btf);
+		btf_put(btf_mod->btf);
+	} else {
+		kvfree(btf_mod->data);
+		kvfree(btf_mod->base_data);
+	}
+	btf_free_deferred_regs(&btf_mod->deferred_regs);
 	kfree(btf_mod->sysfs_attr);
 	kfree(btf_mod);
 }
@@ -9280,6 +9310,66 @@ static bool btf_is_vmlinux_carrier(const struct module *mod)
 {
 	return !strcmp(mod->name, btf_vmlinux_link.module_name);
 }
+
+/*
+ * The vmlinux BTF is not available yet and must not be loaded from the
+ * module notifier (that would nest a module load into a module load).  Keep
+ * the module's BTF for btf_parse_deferred_modules().
+ *
+ * Without a .BTF.base section the .BTF data is final and can be exposed in
+ * sysfs right away, it needs no parsing.  With one, parsing relocates the
+ * data in place against the vmlinux BTF, so the file is created afterwards,
+ * as with =y where it also only appears once the BTF is parsed.
+ */
+static int btf_module_defer(struct btf_module *btf_mod, struct module *mod)
+{
+	btf_mod->data = kvmemdup(mod->btf_data, mod->btf_data_size,
+				 GFP_KERNEL | __GFP_NOWARN);
+	if (!btf_mod->data)
+		return -ENOMEM;
+	btf_mod->data_size = mod->btf_data_size;
+
+	if (mod->btf_base_data) {
+		btf_mod->base_data = kvmemdup(mod->btf_base_data,
+					      mod->btf_base_data_size,
+					      GFP_KERNEL | __GFP_NOWARN);
+		if (!btf_mod->base_data) {
+			kvfree(btf_mod->data);
+			return -ENOMEM;
+		}
+		btf_mod->base_data_size = mod->btf_base_data_size;
+	} else {
+		/* not fatal, the module BTF is usable without the sysfs file */
+		btf_module_sysfs_add(btf_mod, mod->name, btf_mod->data,
+				     btf_mod->data_size);
+	}
+
+	list_add(&btf_mod->list, &btf_modules);
+	return 0;
+}
+
+/*
+ * Apply the registrations queued for @btf_mod to @btf, and those that
+ * applying them queues in turn: a struct_ops ->init() registers the kfuncs
+ * of its hook.  Called and returns with btf_module_mutex held, which is
+ * dropped while applying, as that walks btf_modules
+ * (btf_check_kfunc_name()); the module is pinned meanwhile, so the entry
+ * stays.  A module that is going has its queue freed with the entry.
+ */
+static void btf_module_apply_regs(struct btf_module *btf_mod, struct btf *btf)
+{
+	LIST_HEAD(regs);
+
+	if (list_empty(&btf_mod->deferred_regs) || !try_module_get(btf_mod->module))
+		return;
+	while (!list_empty(&btf_mod->deferred_regs)) {
+		list_splice_init(&btf_mod->deferred_regs, &regs);
+		mutex_unlock(&btf_module_mutex);
+		btf_apply_deferred_regs(btf, &regs);
+		mutex_lock(&btf_module_mutex);
+	}
+	module_put(btf_mod->module);
+}
 #else
 static int btf_vmlinux_module_coming(struct module *mod)
 {
@@ -9290,6 +9380,15 @@ static bool btf_is_vmlinux_carrier(const struct module *mod)
 {
 	return false;
 }
+
+static int btf_module_defer(struct btf_module *btf_mod, struct module *mod)
+{
+	return 0;
+}
+
+static void btf_module_apply_regs(struct btf_module *btf_mod, struct btf *btf)
+{
+}
 #endif
 
 static int btf_module_notify(struct notifier_block *nb, unsigned long op,
@@ -9321,6 +9420,26 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			goto out;
 		}
 		btf_mod->module = module;
+		INIT_LIST_HEAD(&btf_mod->deferred_regs);
+
+		if (IS_MODULE(CONFIG_DEBUG_INFO_BTF)) {
+			mutex_lock(&btf_module_mutex);
+			/* Pairs with the publication in bpf_load_btf_vmlinux() */
+			if (!smp_load_acquire(&btf_vmlinux)) {
+				err = btf_module_defer(btf_mod, mod);
+				mutex_unlock(&btf_module_mutex);
+				if (err) {
+					pr_warn("failed to keep module [%s] BTF: %d\n",
+						mod->name, err);
+					kfree(btf_mod);
+					/* as a module BTF that fails to parse with =y */
+					if (IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH))
+						err = 0;
+				}
+				goto out;
+			}
+			mutex_unlock(&btf_module_mutex);
+		}
 
 		btf = btf_parse_module(mod->name, bpf_get_btf_vmlinux(),
 				       mod->btf_data, mod->btf_data_size, false,
@@ -9358,6 +9477,16 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			if (btf_mod->module != module)
 				continue;
 
+			/*
+			 * The vmlinux BTF arrived while this module was
+			 * initializing: btf_parse_deferred_modules() parsed its
+			 * BTF but left the registrations its init queued to us.
+			 * Apply them before the module counts as live: with =y
+			 * all of them are done by then, and nothing may use the
+			 * module's kfuncs or struct_ops while they are added.
+			 */
+			if (IS_MODULE(CONFIG_DEBUG_INFO_BTF) && btf_mod->btf)
+				btf_module_apply_regs(btf_mod, btf_mod->btf);
 			btf_mod->flags |= BTF_MODULE_F_LIVE;
 			break;
 		}
@@ -9375,7 +9504,8 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			 * btf_try_get_module() on such BTFs will fail. This may
 			 * be called again on btf_put(), but it's ok to do so.
 			 */
-			btf_free_id(btf_mod->btf);
+			if (btf_mod->btf)
+				btf_free_id(btf_mod->btf);
 			list_del(&btf_mod->list);
 			btf_module_free(btf_mod);
 			break;
@@ -9398,6 +9528,127 @@ static int __init btf_module_init(void)
 }
 
 fs_initcall(btf_module_init);
+
+#if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+/* The modules kept aside have been registered, see btf_parse_deferred_modules() */
+static bool btf_deferred_modules_done;
+
+/*
+ * A kept module whose BTF cannot be used after all.  The module is loaded
+ * and stays, so there is no way to reject it: the entry stays on the list,
+ * dead, until the module goes.  A sysfs file it has keeps serving the raw
+ * data, which is kept for that.
+ */
+static void btf_module_dead(struct btf_module *btf_mod, const char *what, int err)
+{
+	pr_warn("failed to %s module [%s] BTF: %d\n", what, btf_mod->module->name, err);
+	kvfree(btf_mod->base_data);
+	btf_mod->base_data = NULL;
+	btf_free_deferred_regs(&btf_mod->deferred_regs);
+	btf_mod->gone = true;
+}
+
+/*
+ * CONFIG_DEBUG_INFO_BTF=m: the vmlinux BTF has just become available.  Parse
+ * the BTF of the modules that were loaded before it, and apply the
+ * registrations that waited for them.  Called from bpf_load_btf_vmlinux()
+ * once btf_vmlinux is published, serialized by it, with no locks held.
+ *
+ * A module's BTF is published (btf_mod->btf set, id installed) only after
+ * its queued registrations are applied, so nobody sees a module BTF without
+ * its kfuncs and struct_ops, as with the vmlinux BTF; its id is reserved
+ * before, so that nothing can fail once they are.  Applying walks
+ * btf_modules (btf_check_kfunc_name()) and so needs the mutex dropped; the
+ * module is pinned for that, and the scan restarts afterwards.  A module
+ * that is still initializing is only published: its init is still queueing
+ * registrations, and MODULE_STATE_LIVE applies them once it is done.
+ *
+ * Until this has run, a search of the module BTFs may miss one of these
+ * modules: see btf_deferred_modules_pending().
+ */
+void btf_parse_deferred_modules(void)
+{
+	/* Pairs with the publication in bpf_load_btf_vmlinux() */
+	struct btf *vmlinux_btf = smp_load_acquire(&btf_vmlinux);
+	struct btf_module *btf_mod;
+	bool parsed = false;
+	struct btf *btf;
+	int err;
+
+	if (!vmlinux_btf || !btf_deferred_modules_pending())
+		return;
+
+	mutex_lock(&btf_module_mutex);
+	if (IS_ERR(vmlinux_btf)) {
+		/* remembered failure: the kept modules can never be parsed */
+		list_for_each_entry(btf_mod, &btf_modules, list) {
+			if (!btf_mod->btf && !btf_mod->gone)
+				btf_module_dead(btf_mod, "parse", PTR_ERR(vmlinux_btf));
+		}
+		mutex_unlock(&btf_module_mutex);
+		goto done;
+	}
+restart:
+	list_for_each_entry(btf_mod, &btf_modules, list) {
+		if (btf_mod->btf || btf_mod->gone)
+			continue;
+
+		btf = btf_parse_module(btf_mod->module->name, vmlinux_btf,
+				       btf_mod->data, btf_mod->data_size, true,
+				       btf_mod->base_data, btf_mod->base_data_size);
+		if (IS_ERR(btf)) {
+			/* on failure the caller keeps the data */
+			btf_module_dead(btf_mod, "validate", PTR_ERR(btf));
+			continue;
+		}
+		/* btf->data is btf_mod->data now, the sysfs file keeps pointing at valid data */
+		kvfree(btf_mod->base_data);
+		btf_mod->base_data = NULL;
+
+		err = btf_reserve_id(btf);
+		if (err) {
+			/* give the data back to the entry, the sysfs file may serve it */
+			btf->data = NULL;
+			btf_free(btf);
+			btf_module_dead(btf_mod, "register", err);
+			continue;
+		}
+
+		if (btf_mod->flags & BTF_MODULE_F_LIVE)
+			btf_module_apply_regs(btf_mod, btf);
+
+		/* modules with .BTF.base get their sysfs file now, the data is relocated */
+		if (!btf_mod->sysfs_attr)
+			btf_module_sysfs_add(btf_mod, btf->name, btf->data, btf->data_size);
+		btf_mod->data = NULL;
+		btf_mod->btf = btf;
+		btf_install_id(btf);
+		parsed = true;
+		/* the list may have changed while the mutex was dropped */
+		goto restart;
+	}
+	mutex_unlock(&btf_module_mutex);
+
+	if (parsed)
+		purge_cand_cache(NULL);
+done:
+	/* Pairs with the smp_load_acquire() in btf_deferred_modules_pending() */
+	smp_store_release(&btf_deferred_modules_done, true);
+}
+
+/*
+ * The vmlinux BTF is published before the BTF of the modules loaded ahead of
+ * it is registered by btf_parse_deferred_modules().  Until then, a search of
+ * the module BTFs may miss a module: such searches count a miss and fail, so
+ * that bpf() runs the command again after bpf_load_btf_vmlinux(), which
+ * waits for the modules.
+ */
+bool btf_deferred_modules_pending(void)
+{
+	/* Pairs with the smp_store_release() in btf_parse_deferred_modules() */
+	return !smp_load_acquire(&btf_deferred_modules_done);
+}
+#endif /* IS_MODULE(CONFIG_DEBUG_INFO_BTF) */
 #endif /* BTF_MODULE_NOTIFIER */
 
 struct module *btf_try_get_module(const struct btf *btf)
@@ -9450,8 +9701,11 @@ struct btf *btf_get_module_btf(const struct module *module)
 		if (btf_mod->module != module)
 			continue;
 
-		btf_get(btf_mod->btf);
-		btf = btf_mod->btf;
+		/* NULL while waiting for the vmlinux BTF (CONFIG_DEBUG_INFO_BTF=m) */
+		if (btf_mod->btf) {
+			btf_get(btf_mod->btf);
+			btf = btf_mod->btf;
+		}
 		break;
 	}
 	mutex_unlock(&btf_module_mutex);
@@ -9634,7 +9888,8 @@ static int btf_check_kfunc_name(struct btf *btf, const char *func_name, u32 kind
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	guard(mutex)(&btf_module_mutex);
 	list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
-		if (btf_mod->btf == btf)
+		/* skip ourselves and, with CONFIG_DEBUG_INFO_BTF=m, unparsed BTF */
+		if (btf_mod->btf == btf || !btf_mod->btf)
 			continue;
 		id = btf_find_by_name_kind(btf_mod->btf, func_name, kind);
 		if (id >= 0) {
@@ -10492,6 +10747,12 @@ bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id)
 		return cc;
 
 check_modules:
+	/* the modules loaded before the vmlinux BTF may not be registered yet */
+	if (btf_deferred_modules_pending()) {
+		bpf_btf_vmlinux_miss();
+		return ERR_PTR(-EINVAL);
+	}
+
 	/* cands is a pointer to stack here and cands->cnt == 0 */
 	cc = check_cand_cache(cands, module_cand_cache, MODULE_CAND_CACHE_SIZE);
 	if (cc)
@@ -10868,15 +11129,17 @@ static int btf_struct_ops_register(struct btf *btf, struct bpf_struct_ops *st_op
 #endif
 
 /*
- * CONFIG_DEBUG_INFO_BTF=m: registrations for vmlinux made before its BTF is
- * available wait in btf_vmlinux_deferred_regs until btf_parse_vmlinux()
- * applies them.
+ * CONFIG_DEBUG_INFO_BTF=m: registrations made before the BTF they apply to
+ * is available.  Registrations for vmlinux wait in btf_vmlinux_deferred_regs
+ * until btf_parse_vmlinux() applies them; registrations for a module wait in
+ * its struct btf_module, under btf_module_mutex, until
+ * btf_parse_deferred_modules() does.
  */
 #ifdef BTF_MODULE_NOTIFIER
 /*
- * The queue has its own lock: it is drained under btf_vmlinux_lock, and
- * with its own lock btf_module_mutex, which the module notifier takes, is
- * never taken under btf_vmlinux_lock, so the two stay unordered.
+ * The vmlinux queue has its own lock: it is drained under btf_vmlinux_lock,
+ * and with its own lock btf_module_mutex, which the module notifier takes,
+ * is never taken under btf_vmlinux_lock, so the two stay unordered.
  */
 static DEFINE_MUTEX(btf_vmlinux_regs_mutex);
 static LIST_HEAD(btf_vmlinux_deferred_regs);
@@ -10886,19 +11149,38 @@ static bool btf_vmlinux_regs_closed;
 /*
  * Queue @tmpl if the BTF for @owner is not available yet.  Returns 1 if the
  * registration was queued and is to be considered done, 0 if the caller has
- * to apply it, or -ENOMEM.  Only vmlinux registrations are queued so far.
+ * to apply it, or -ENOMEM.
  */
 static int btf_defer_reg(struct module *owner, const struct btf_deferred_reg *tmpl)
 {
 	struct list_head *head = NULL;
 	struct btf_deferred_reg *reg;
+	struct btf_module *btf_mod;
 
-	if (!IS_MODULE(CONFIG_DEBUG_INFO_BTF) || owner)
+	if (!IS_MODULE(CONFIG_DEBUG_INFO_BTF))
 		return 0;
 
-	guard(mutex)(&btf_vmlinux_regs_mutex);
-	if (!btf_vmlinux_regs_closed)
-		head = &btf_vmlinux_deferred_regs;
+	guard(mutex)(owner ? &btf_module_mutex : &btf_vmlinux_regs_mutex);
+	if (!owner) {
+		if (!btf_vmlinux_regs_closed)
+			head = &btf_vmlinux_deferred_regs;
+	} else {
+		list_for_each_entry(btf_mod, &btf_modules, list) {
+			if (btf_mod->module != owner)
+				continue;
+			/*
+			 * Wait until the entry's BTF is published, and after that
+			 * behind registrations that are still queued (a module
+			 * that was initializing when its BTF was published), so
+			 * that they are applied in order.  A dead entry has no BTF
+			 * to register with, as with =y.
+			 */
+			if (!btf_mod->gone &&
+			    (!btf_mod->btf || !list_empty(&btf_mod->deferred_regs)))
+				head = &btf_mod->deferred_regs;
+			break;
+		}
+	}
 	if (!head)
 		return 0;
 
@@ -10951,7 +11233,10 @@ static int btf_apply_deferred_reg(struct btf *btf, const struct btf_deferred_reg
 	return -EINVAL;
 }
 
-/* Apply and free the registrations in @regs to @btf. */
+/*
+ * Apply and free the registrations in @regs to @btf.  For a module BTF the
+ * caller holds a reference on @btf and makes sure the owning module stays.
+ */
 static void btf_apply_deferred_regs(struct btf *btf, struct list_head *regs)
 {
 	struct btf_deferred_reg *reg, *tmp;
@@ -10967,6 +11252,16 @@ static void btf_apply_deferred_regs(struct btf *btf, struct list_head *regs)
 	}
 }
 
+static void btf_free_deferred_regs(struct list_head *regs)
+{
+	struct btf_deferred_reg *reg, *tmp;
+
+	list_for_each_entry_safe(reg, tmp, regs, list) {
+		list_del(&reg->list);
+		btf_free_deferred_reg(reg);
+	}
+}
+
 /*
  * The vmlinux BTF has just been parsed; apply the registrations that waited
  * for it.  Runs under btf_vmlinux_lock, before @btf is published, so nothing
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 895e7feb6429..f6205894fe11 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21935,18 +21935,22 @@ struct btf *bpf_peek_btf_vmlinux(void)
  * bpf_load_btf_vmlinux - get the vmlinux BTF, loading it if necessary
  *
  * Like bpf_get_btf_vmlinux(), but with CONFIG_DEBUG_INFO_BTF=m it loads the
- * btf_vmlinux module if the BTF is not there yet and parses it.  Loading the
- * module waits for user space (modprobe), and the notifiers of the module
- * load take locks of their own, event_mutex among them.  So this is only
- * called at the start of a request from user space, in process context,
- * holding no lock that loading a module may need; everything else uses
- * bpf_get_btf_vmlinux() or bpf_peek_btf_vmlinux().
+ * btf_vmlinux module if the BTF is not there yet, parses it, and registers
+ * the BTF of the modules that were loaded before it; it returns once all of
+ * that is done, also to a caller that comes while another one is doing it.
+ * Loading the module waits for user space (modprobe), and the notifiers of
+ * the module load take locks of their own, event_mutex among them.  So this
+ * is only called at the start of a request from user space, in process
+ * context, holding no lock that loading a module may need; everything else
+ * uses bpf_get_btf_vmlinux() or bpf_peek_btf_vmlinux().
  *
  * If the module cannot be loaded, returns NULL like a kernel without BTF;
  * the next call tries again.
  */
 struct btf *bpf_load_btf_vmlinux(void)
 {
+	/* Held from loading until the module BTF kept aside is registered */
+	static DEFINE_MUTEX(load_mutex);
 	struct btf *btf;
 	u32 size;
 
@@ -21956,13 +21960,14 @@ struct btf *bpf_load_btf_vmlinux(void)
 
 	/* Pairs with the smp_store_release() below */
 	btf = smp_load_acquire(&btf_vmlinux);
-	if (btf)
+	if (btf && !btf_deferred_modules_pending())
 		return btf;
 
-	/* Outside btf_vmlinux_lock, the module's notifier must not wait for us */
-	if (!btf_vmlinux_data(&size, true))
+	/* Outside the locks, the module's notifier must not wait for us */
+	if (!btf && !btf_vmlinux_data(&size, true))
 		return NULL;
 
+	mutex_lock(&load_mutex);
 	mutex_lock(&btf_vmlinux_lock);
 	btf = btf_vmlinux;
 	if (!btf) {
@@ -21974,12 +21979,22 @@ struct btf *bpf_load_btf_vmlinux(void)
 		 */
 		if (IS_ERR(btf) && PTR_ERR(btf) == -ENOMEM) {
 			mutex_unlock(&btf_vmlinux_lock);
+			mutex_unlock(&load_mutex);
 			return btf;
 		}
 		/* As in bpf_get_btf_vmlinux(): publish after the parse */
 		smp_store_release(&btf_vmlinux, btf);
 	}
 	mutex_unlock(&btf_vmlinux_lock);
+
+	/*
+	 * Until this is done, the module BTFs may lack a module, which
+	 * btf_deferred_modules_pending() tells the searches of module BTFs,
+	 * and which is why concurrent callers wait for it on the mutex.
+	 */
+	btf_parse_deferred_modules();
+	mutex_unlock(&load_mutex);
+
 	return btf;
 }
 
@@ -21994,6 +22009,12 @@ unsigned int bpf_btf_vmlinux_misses(void)
 {
 	return atomic_read(&btf_vmlinux_misses);
 }
+
+/* A lookup that needs the BTF of a module that is not registered yet */
+void bpf_btf_vmlinux_miss(void)
+{
+	atomic_inc(&btf_vmlinux_misses);
+}
 #endif
 
 /*
-- 
2.47.3

