Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B3B47043E;
	Thu,  1 Oct 2026 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895269; cv=none; b=NRmDNZrdfupxcay93kuzkICIwQP85Onbe577bPu25Wsj8aiJAbpBzNulBuXtlAA/ewGtZEh/CsySelrUnOCmfF+eM9KJLLWxVngon6TmuFJHscfddUuSzSBItBpHGRupZMF8LR3PCukOE/SwZqSMG4TlDn30CjHMVt6Q0OyvI8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895269; c=relaxed/simple;
	bh=WYvB3vxlCypsfGO6Z+Rk03vWdSulBxMi9aFNlrtHeyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGudQ9dsQ7dEu/7mvHy45jxUchQ3EL1owjfHPDZyHaA6rUBrDzQmaM8vyifXAd8uUKyIuGaV8RESjZuDlPkZ0JFgc7unY/O/nQQmXMCFLcSxa3MUw9bGWSFkAHB4zazUd7M9ziO6BEY8gReUEmoJtWB1yqxhjnzIIw5Cc3j5vRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=iyYV+tFz; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="iyYV+tFz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790895267; x=1822431267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XSOXQR2aF0FWLiUU1JBe4TVGAB2eewiIiRSsqi0AijI=;
  b=iyYV+tFzb4u3aFLWZCBtLsJjoM9pKav7OI/pD9CdNDJK/KzSWufJnl+I
   7vdj5U+RW8UGjA8G+ntJ2UVbbaigvgg2r7YZSfKH56qmZUhiNRN2HF8eD
   NtNqXLbaRmyUQPjjwZST2ajtKoJ3uqd6zdtut/HYJTqtC57EpPxOt7jfS
   H2o3smX7SCbp58NVuoF5IzCMrKLvpU/fp3WX/5/aSPw5IyCAvLXEg0v6Q
   1pbSIQFNrn4+NySHVK6eIPY/R1FrCO+Cns3gNQXB6Q39gdRisjGKHSNvr
   4no7RduuG4M0W/vfrihu9YAiUvxxbz0npPkylkUw6UBsn5930yD9iMcPG
   Q==;
X-CSE-ConnectionGUID: UcpoF2f/Tg6F47/uzaQAZg==
X-CSE-MsgGUID: S7ZNjHFGS2uwdcL2vukpzg==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="30160846"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 22:54:27 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:5859]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.21:2525] with esmtp (Farcaster)
 id 40debb75-f672-46c2-8c4e-c050884a2d5e; Thu, 1 Oct 2026 22:54:26 +0000 (UTC)
X-Farcaster-Flow-ID: 40debb75-f672-46c2-8c4e-c050884a2d5e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:54:26 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:54:26 +0000
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
Subject: [PATCH bpf-next v4 08/12] bpf: expose deferred .BTF.base module BTF in sysfs from module load
Date: Thu, 1 Oct 2026 22:52:10 +0000
Message-ID: <20261001225214.12351-9-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

A module with a .BTF.base section (built out of tree) that is loaded
before the vmlinux BTF only gets its /sys/kernel/btf file once the
vmlinux BTF has been loaded and its BTF relocated, because the raw .BTF
is only valid against the distilled base and relocation rewrites it in
place.  Until then the module is missing from /sys/kernel/btf, unlike
with =y, and reading its file cannot trigger the load.

Create the file at module load instead, with its final size: relocation
only rewrites type ids and string offsets, never the length.  Its reader,
btf_module_sysfs_read_deferred(), has the vmlinux BTF loaded, which parses
and relocates the kept modules, then waits until this module's BTF is
published (btf_mod->ready) before serving it, so no unrelocated or
half-relocated data is ever visible.  If the module goes away or its BTF
turns out unusable first (btf_mod->gone), or the vmlinux BTF cannot be
loaded, the read fails with -ENODEV.

The reader does not load the vmlinux BTF itself but queues a work item
that does: it holds the file's kernfs active reference, which
MODULE_STATE_GOING waits for when it removes the file, with the module
notifier chain held; loading btf_vmlinux takes that chain, so with a
writer queued on it the two would wait for each other.  The reader's own
wait ends when the module goes.

Because that reader may be waiting for btf_parse_deferred_modules(), and
removing a sysfs file waits for its readers, nothing removes a sysfs file
from that path (a failed entry
stays dead until the module goes, which the previous patch already
arranged), and MODULE_STATE_GOING removes the file after dropping
btf_module_mutex, which the reader may need to get there.  A dead entry
keeps its raw data only for a file that serves it as is, the deferred
reader never does.

Modules without .BTF.base are unchanged: their data is final and is
served as is.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 kernel/bpf/btf.c | 144 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 124 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4d51fb212218..3c3aba0fc4cb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9208,17 +9208,27 @@ struct btf_module {
 	u32 data_size;
 	u32 base_data_size;
 	struct list_head deferred_regs;
-	/* the kept BTF turned out unusable; the entry stays until the module goes */
+	/*
+	 * For the sysfs reader of a module whose data is only final once its
+	 * BTF is relocated: @ready once @btf is published, @gone once the
+	 * entry is dead (parse failed or module going).  Both only ever go
+	 * from false to true; waiters sleep on btf_module_wq.
+	 */
+	bool ready;
 	bool gone;
 };
 
 static LIST_HEAD(btf_modules);
 static DEFINE_MUTEX(btf_module_mutex);
+static DECLARE_WAIT_QUEUE_HEAD(btf_module_wq);
 
 static void purge_cand_cache(struct btf *btf);
 
 static int btf_module_sysfs_add(struct btf_module *btf_mod, const char *name,
-				void *data, size_t data_size)
+				void *private, size_t size,
+				ssize_t (*read)(struct file *, struct kobject *,
+						const struct bin_attribute *,
+						char *, loff_t, size_t))
 {
 	struct bin_attribute *attr;
 	int err;
@@ -9233,9 +9243,9 @@ static int btf_module_sysfs_add(struct btf_module *btf_mod, const char *name,
 	sysfs_bin_attr_init(attr);
 	attr->attr.name = name;
 	attr->attr.mode = 0444;
-	attr->size = data_size;
-	attr->private = data;
-	attr->read = sysfs_bin_attr_simple_read;
+	attr->size = size;
+	attr->private = private;
+	attr->read = read;
 
 	err = sysfs_create_bin_file(btf_kobj, attr);
 	if (err) {
@@ -9249,8 +9259,14 @@ static int btf_module_sysfs_add(struct btf_module *btf_mod, const char *name,
 	return 0;
 }
 
+/*
+ * Called with btf_module_mutex NOT held: removing the sysfs file waits for
+ * readers to leave, and a deferred reader may need the mutex to get there.
+ */
 static void btf_module_free(struct btf_module *btf_mod)
 {
+	WRITE_ONCE(btf_mod->gone, true);
+	wake_up_all(&btf_module_wq);
 	if (btf_mod->sysfs_attr)
 		sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
 	if (btf_mod->btf) {
@@ -9311,15 +9327,87 @@ static bool btf_is_vmlinux_carrier(const struct module *mod)
 	return !strcmp(mod->name, btf_vmlinux_link.module_name);
 }
 
+/*
+ * sysfs reader for a module kept aside with a .BTF.base section: its .BTF is
+ * split against the distilled base and only becomes valid split BTF against
+ * the vmlinux BTF once relocated, which rewrites the buffer in place.  So
+ * have the vmlinux BTF loaded (which parses and relocates the kept modules),
+ * then wait until this module's BTF is published.  The size does not change:
+ * relocation only rewrites ids and string offsets.
+ *
+ * The reader does not load the vmlinux BTF itself: it holds the file's
+ * kernfs active reference, which MODULE_STATE_GOING waits for when it
+ * removes the file with the module notifier chain held, and loading
+ * btf_vmlinux needs that chain.  A work item loads it, and the reader waits
+ * in a way that the module going away (@gone) ends.
+ */
+static bool btf_module_published(struct btf_module *btf_mod)
+{
+	/* Pairs with the smp_store_release() of @ready after btf_mod->btf is set */
+	return smp_load_acquire(&btf_mod->ready);
+}
+
+/* Bumped after each load attempt by btf_vmlinux_load_work */
+static atomic_t btf_vmlinux_load_seq = ATOMIC_INIT(0);
+
+static void btf_vmlinux_load_workfn(struct work_struct *work)
+{
+	bpf_load_btf_vmlinux();
+	atomic_inc(&btf_vmlinux_load_seq);
+	wake_up_all(&btf_module_wq);
+}
+
+static DECLARE_WORK(btf_vmlinux_load_work, btf_vmlinux_load_workfn);
+
+/* The vmlinux BTF could not be had: a load attempt ended without it. */
+static bool btf_vmlinux_load_failed(int seq)
+{
+	return atomic_read(&btf_vmlinux_load_seq) != seq &&
+	       IS_ERR_OR_NULL(bpf_peek_btf_vmlinux());
+}
+
+static ssize_t btf_module_sysfs_read_deferred(struct file *filp, struct kobject *kobj,
+					      const struct bin_attribute *attr,
+					      char *buf, loff_t off, size_t count)
+{
+	struct btf_module *btf_mod = attr->private;
+	int seq = atomic_read(&btf_vmlinux_load_seq);
+	struct btf *vmlinux_btf = bpf_peek_btf_vmlinux();
+	int err;
+
+	if (IS_ERR(vmlinux_btf))
+		return -ENODEV;
+	if (!vmlinux_btf)
+		queue_work(system_unbound_wq, &btf_vmlinux_load_work);
+
+	/*
+	 * Another thread may still be relocating and publishing it; if the
+	 * module goes away or its BTF turns out unusable, btf_module_free()
+	 * or btf_parse_deferred_modules() set @gone and wake us.
+	 */
+	err = wait_event_interruptible(btf_module_wq,
+				       btf_module_published(btf_mod) ||
+				       READ_ONCE(btf_mod->gone) ||
+				       btf_vmlinux_load_failed(seq));
+	if (err)
+		return err;
+	if (!btf_module_published(btf_mod))
+		return -ENODEV;
+
+	/* sysfs clamps @off and @count to attr->size == btf->data_size */
+	memcpy(buf, btf_mod->btf->data + off, count);
+	return count;
+}
+
 /*
  * The vmlinux BTF is not available yet and must not be loaded from the
  * module notifier (that would nest a module load into a module load).  Keep
  * the module's BTF for btf_parse_deferred_modules().
  *
- * Without a .BTF.base section the .BTF data is final and can be exposed in
- * sysfs right away, it needs no parsing.  With one, parsing relocates the
- * data in place against the vmlinux BTF, so the file is created afterwards,
- * as with =y where it also only appears once the BTF is parsed.
+ * The sysfs file is created right away with its final size, as with =y.
+ * Without a .BTF.base section the .BTF data is final and is served as is;
+ * with one, it is only valid once relocated, so its reader waits for that
+ * (btf_module_sysfs_read_deferred()).
  */
 static int btf_module_defer(struct btf_module *btf_mod, struct module *mod)
 {
@@ -9338,10 +9426,12 @@ static int btf_module_defer(struct btf_module *btf_mod, struct module *mod)
 			return -ENOMEM;
 		}
 		btf_mod->base_data_size = mod->btf_base_data_size;
-	} else {
 		/* not fatal, the module BTF is usable without the sysfs file */
+		btf_module_sysfs_add(btf_mod, mod->name, btf_mod, btf_mod->data_size,
+				     btf_module_sysfs_read_deferred);
+	} else {
 		btf_module_sysfs_add(btf_mod, mod->name, btf_mod->data,
-				     btf_mod->data_size);
+				     btf_mod->data_size, sysfs_bin_attr_simple_read);
 	}
 
 	list_add(&btf_mod->list, &btf_modules);
@@ -9469,7 +9559,8 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 		mutex_unlock(&btf_module_mutex);
 
 		/* not fatal, the module BTF is usable without the sysfs file */
-		btf_module_sysfs_add(btf_mod, btf->name, btf->data, btf->data_size);
+		btf_module_sysfs_add(btf_mod, btf->name, btf->data, btf->data_size,
+				     sysfs_bin_attr_simple_read);
 		break;
 	case MODULE_STATE_LIVE:
 		mutex_lock(&btf_module_mutex);
@@ -9507,8 +9598,10 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			if (btf_mod->btf)
 				btf_free_id(btf_mod->btf);
 			list_del(&btf_mod->list);
+			mutex_unlock(&btf_module_mutex);
+			/* off the list, nobody else can find it now */
 			btf_module_free(btf_mod);
-			break;
+			goto out;
 		}
 		mutex_unlock(&btf_module_mutex);
 		break;
@@ -9536,23 +9629,34 @@ static bool btf_deferred_modules_done;
 /*
  * A kept module whose BTF cannot be used after all.  The module is loaded
  * and stays, so there is no way to reject it: the entry stays on the list,
- * dead, until the module goes.  A sysfs file it has keeps serving the raw
- * data, which is kept for that.
+ * dead, until the module goes.  Its sysfs file stays too, its reader, or
+ * the caller of this function, may be inside it right now: a .BTF.base
+ * reader wakes up and fails without touching the data, which can go; a
+ * plain one keeps serving the raw data, which is kept for that.
  */
 static void btf_module_dead(struct btf_module *btf_mod, const char *what, int err)
 {
 	pr_warn("failed to %s module [%s] BTF: %d\n", what, btf_mod->module->name, err);
+	if (!btf_mod->sysfs_attr ||
+	    btf_mod->sysfs_attr->read != sysfs_bin_attr_simple_read) {
+		kvfree(btf_mod->data);
+		btf_mod->data = NULL;
+	}
 	kvfree(btf_mod->base_data);
 	btf_mod->base_data = NULL;
 	btf_free_deferred_regs(&btf_mod->deferred_regs);
-	btf_mod->gone = true;
+	WRITE_ONCE(btf_mod->gone, true);
+	wake_up_all(&btf_module_wq);
 }
 
 /*
  * CONFIG_DEBUG_INFO_BTF=m: the vmlinux BTF has just become available.  Parse
  * the BTF of the modules that were loaded before it, and apply the
  * registrations that waited for them.  Called from bpf_load_btf_vmlinux()
- * once btf_vmlinux is published, serialized by it, with no locks held.
+ * once btf_vmlinux is published, serialized by it, with no locks held.  The
+ * sysfs reader of one of these modules may be waiting for it (see
+ * btf_module_sysfs_read_deferred()), which is why no sysfs file is removed
+ * here.
  *
  * A module's BTF is published (btf_mod->btf set, id installed) only after
  * its queued registrations are applied, so nobody sees a module BTF without
@@ -9617,12 +9721,12 @@ void btf_parse_deferred_modules(void)
 		if (btf_mod->flags & BTF_MODULE_F_LIVE)
 			btf_module_apply_regs(btf_mod, btf);
 
-		/* modules with .BTF.base get their sysfs file now, the data is relocated */
-		if (!btf_mod->sysfs_attr)
-			btf_module_sysfs_add(btf_mod, btf->name, btf->data, btf->data_size);
 		btf_mod->data = NULL;
 		btf_mod->btf = btf;
 		btf_install_id(btf);
+		/* Pairs with the smp_load_acquire() in btf_module_sysfs_read_deferred() */
+		smp_store_release(&btf_mod->ready, true);
+		wake_up_all(&btf_module_wq);
 		parsed = true;
 		/* the list may have changed while the mutex was dropped */
 		goto restart;
-- 
2.47.3

