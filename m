Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC50365192;
	Thu,  1 Oct 2026 22:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895223; cv=none; b=UUrtqddyN7WK0i5RUrsz4FlKcCC9ljE1Yu14ER6t5ruqhqeiTrNfzarizEAj7LEd7sHGhsvZdfIcOUtEZMZ3eQAc/Rgq8uG6WGhCViGH3qv5qbigfK1rGdWf4a2NfO2K1jLsUrZ67QZr8BbKCaiK6Y+MwFCIDmLpslzVbvREs54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895223; c=relaxed/simple;
	bh=T43jUJi2kR/rX5xIRdsVTQQF8erXtEIOLoPVyhU91As=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+5SGNx5v/XfsrXjOB/dbUBQKIKFJxfvF9pcZtMTEB9m5NBKZGoFgWVR1CW5Ro/x9l0aSNe6BP9iWDJdGdl/DALWMFG0QTiLen6SSobBqW5OJcpxV9LUstAM55TnjOZ3bU7TG9lRnz8MWU3UQRTDTVn2w4t8AJYCDcOO6yfOaCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=KD373dBd; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="KD373dBd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790895220; x=1822431220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5VvPPVPWMXiqIcqmtv3/HdT5S1eE1Fvx9dtRsICpElQ=;
  b=KD373dBdZb/g/JwST5UPUbxUd4Hhlwa8nUd/vH2iatYixAsYCV466G1K
   kqppGOC0mXsO2tp5FU6zPbzPhSicoc7Rgj91VCPCV+Vzu9mlOk/H5rISV
   LWgAWfEpAS2HjLKsRg4A8Ev+1jFHl1hI3BlAHCr86pZaxaVlgztFkb1i4
   PZmGWY/wP7AF78oNaC6qnUFdikG3YkgZRRuEwVgScKYuIUAxWCbkpadxW
   qlN6JcyXTHMk6p8EGjivcYivcSzVCdxCmenmI2QOHbWTPp6ppjoLmhB6i
   dYZ/7FNq0Tfe/iwK1utRE5aHF4jqe7JC9kwyYFAAQeW5zySsQicbZcl/j
   w==;
X-CSE-ConnectionGUID: A4PC98ueQAGMvC6ojp1PVw==
X-CSE-MsgGUID: 7appViYMTciK14eh3fBgag==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="30175436"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 22:53:40 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:1307]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.141:2525] with esmtp (Farcaster)
 id 5c4f78e8-b119-45c3-a048-13aaeb9d79e7; Thu, 1 Oct 2026 22:53:40 +0000 (UTC)
X-Farcaster-Flow-ID: 5c4f78e8-b119-45c3-a048-13aaeb9d79e7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:53:39 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:53:39 +0000
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
Subject: [PATCH bpf-next v4 05/12] bpf, tracing: load the vmlinux BTF where tracefs and bpffs requests start
Date: Thu, 1 Oct 2026 22:52:07 +0000
Message-ID: <20261001225214.12351-6-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

With CONFIG_DEBUG_INFO_BTF=m, bpf_get_btf_vmlinux() and
bpf_find_btf_id() do not load the vmlinux BTF: loading waits for user
space, and their callers were not written for that.  Besides the bpf()
system call and /sys/kernel/btf/vmlinux, some tracefs and bpffs requests
need the BTF.  Load it at the start of those, with
bpf_load_btf_vmlinux(), and have the code that only uses the BTF if it
happens to be there peek:

 - Reading a tracepoint's btf_ids file (events/*/btf_ids): built-in
   events use the vmlinux BTF, and module BTF is only registered once
   that is loaded.  event_btf_ids_read() looks the BTF up under
   event_mutex, which the trace notifier of the btf_vmlinux module
   takes, so load it before taking the mutex, on the first read() of
   the file (not again for the one that returns EOF).
 - Probe events with BTF arguments ($argN, argument names, $retval,
   $current, typecasts): the parser loads the BTF before looking a
   function or struct up.  It holds dyn_event_ops_mutex, which loading
   a module never takes: besides event creation, only
   dyn_event_register() takes it, from built-in init code.  Loading
   here also keeps a $retval from silently losing its type.
 - The ftrace function argument printer (func-args, funcgraph-args)
   runs in the trace output path, which includes ftrace_dump() with
   interrupts disabled.  It only prints the arguments if the BTF is
   already loaded, and never loads it: that also avoids one modprobe
   per trace line when the module is not installed.
 - bpffs: parsing delegate_* mount options (fs_context) loads the BTF
   when a value names commands or types, which are looked up in it;
   "any" and numeric masks need no BTF and do not load it.  Showing the
   options in /proc/*/mountinfo runs under namespace_sem; it only uses
   the names if the BTF is already there and falls back to hex, as it
   already does without BTF.

With CONFIG_DEBUG_INFO_BTF=y bpf_load_btf_vmlinux() is
bpf_get_btf_vmlinux() and the BTF is parsed at boot, so nothing changes.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 kernel/bpf/inode.c          | 44 ++++++++++++++++++++++++-------------
 kernel/trace/trace_events.c | 10 +++++++++
 kernel/trace/trace_output.c |  7 ++++++
 kernel/trace/trace_probe.c  | 16 ++++++++++++++
 4 files changed, 62 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 7837968c0842..d05bbb61a593 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -658,7 +658,11 @@ struct bpffs_btf_enums {
 	const struct btf_type *attach_t;
 };
 
-static int find_bpffs_btf_enums(struct bpffs_btf_enums *info)
+/*
+ * @load: load the vmlinux BTF if necessary (CONFIG_DEBUG_INFO_BTF=m), see
+ * bpf_load_btf_vmlinux(); otherwise only use it if it is already parsed.
+ */
+static int find_bpffs_btf_enums(struct bpffs_btf_enums *info, bool load)
 {
 	struct {
 		const struct btf_type **type;
@@ -674,7 +678,7 @@ static int find_bpffs_btf_enums(struct bpffs_btf_enums *info)
 
 	memset(info, 0, sizeof(*info));
 
-	btf = bpf_get_btf_vmlinux();
+	btf = load ? bpf_load_btf_vmlinux() : bpf_peek_btf_vmlinux();
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
 	if (!btf)
@@ -795,8 +799,11 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
 	    opts->delegate_progs || opts->delegate_attachs) {
 		struct bpffs_btf_enums info;
 
-		/* ignore errors, fallback to hex */
-		(void)find_bpffs_btf_enums(&info);
+		/*
+		 * ignore errors, fallback to hex; this runs under
+		 * namespace_sem, so do not load the BTF from here
+		 */
+		(void)find_bpffs_btf_enums(&info, false);
 
 		mask = (1ULL << __MAX_BPF_CMD) - 1;
 		seq_print_delegate_opts(m, "delegate_cmds",
@@ -1052,35 +1059,33 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case OPT_DELEGATE_MAPS:
 	case OPT_DELEGATE_PROGS:
 	case OPT_DELEGATE_ATTACHS: {
-		struct bpffs_btf_enums info;
-		const struct btf_type *enum_t;
+		struct bpffs_btf_enums info = {};
+		const struct btf_type **enum_t;
+		bool enums_tried = false;
 		const char *enum_pfx;
-		u64 *delegate_msk, msk = 0;
+		u64 *delegate_msk, msk = 0, num;
 		char *p, *str;
 		int val;
 
-		/* ignore errors, fallback to hex */
-		(void)find_bpffs_btf_enums(&info);
-
 		switch (opt) {
 		case OPT_DELEGATE_CMDS:
 			delegate_msk = &opts->delegate_cmds;
-			enum_t = info.cmd_t;
+			enum_t = &info.cmd_t;
 			enum_pfx = "BPF_";
 			break;
 		case OPT_DELEGATE_MAPS:
 			delegate_msk = &opts->delegate_maps;
-			enum_t = info.map_t;
+			enum_t = &info.map_t;
 			enum_pfx = "BPF_MAP_TYPE_";
 			break;
 		case OPT_DELEGATE_PROGS:
 			delegate_msk = &opts->delegate_progs;
-			enum_t = info.prog_t;
+			enum_t = &info.prog_t;
 			enum_pfx = "BPF_PROG_TYPE_";
 			break;
 		case OPT_DELEGATE_ATTACHS:
 			delegate_msk = &opts->delegate_attachs;
-			enum_t = info.attach_t;
+			enum_t = &info.attach_t;
 			enum_pfx = "BPF_";
 			break;
 		default:
@@ -1089,9 +1094,18 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 
 		str = param->string;
 		while ((p = strsep(&str, ":"))) {
+			/*
+			 * Only names need the vmlinux BTF: "any" and numbers do
+			 * not load it.  Ignore errors, fallback to hex.
+			 */
+			if (strcmp(p, "any") && kstrtou64(p, 0, &num) && !enums_tried) {
+				(void)find_bpffs_btf_enums(&info, true);
+				enums_tried = true;
+			}
+
 			if (strcmp(p, "any") == 0) {
 				msk |= ~0ULL;
-			} else if (find_btf_enum_const(info.btf, enum_t, enum_pfx, p, &val)) {
+			} else if (find_btf_enum_const(info.btf, *enum_t, enum_pfx, p, &val)) {
 				msk |= 1ULL << val;
 			} else {
 				err = kstrtou64(p, 0, &msk);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 30c0ddf90887..c887ac6a4857 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -23,6 +23,7 @@
 #include <linux/sort.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/bpf.h>
 #include <linux/btf.h>
 
 #include <trace/events/sched.h>
@@ -2245,6 +2246,15 @@ event_btf_ids_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppo
 	char buf[128];
 	int len;
 
+	/*
+	 * Built-in events use the vmlinux BTF, and with CONFIG_DEBUG_INFO_BTF=m
+	 * module BTF is only registered once that is loaded.  Loading it loads
+	 * a module, whose trace notifier takes event_mutex: load it before
+	 * taking that, and only for the first read, not again for the EOF one.
+	 */
+	if (!*ppos)
+		bpf_load_btf_vmlinux();
+
 	/* Module unload could free call->class and ids[] mid-read. */
 	scoped_guard(mutex, &event_mutex) {
 		file = event_file_file(filp);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index a5ad76175d10..1f346e524ee6 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -739,6 +739,13 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
 	if (lookup_symbol_name(func, name))
 		goto out;
 
+	/*
+	 * This can run with interrupts disabled (ftrace_dump()): only use
+	 * the vmlinux BTF if it is parsed, never load it from here.
+	 */
+	if (IS_ERR_OR_NULL(bpf_peek_btf_vmlinux()))
+		goto out;
+
 	/* TODO: Pass module name here too */
 	t = btf_find_func_proto(name, &btf);
 	if (IS_ERR_OR_NULL(t))
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 804442b2f7d2..d53ee1ef820c 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -531,6 +531,19 @@ static const char *fetch_type_from_btf_type(struct btf *btf,
 	return NULL;
 }
 
+/*
+ * Arguments described by BTF need the vmlinux BTF.  With
+ * CONFIG_DEBUG_INFO_BTF=m it may not be loaded yet, so load it before looking
+ * anything up.  Parsing holds dyn_event_ops_mutex, which loading a module
+ * never takes: besides event creation, only dyn_event_register() takes it,
+ * from built-in init code.
+ */
+static void trace_probe_load_btf(void)
+{
+	lockdep_assert_held(&dyn_event_ops_mutex);
+	bpf_load_btf_vmlinux();
+}
+
 static int query_btf_context(struct traceprobe_parse_context *ctx)
 {
 	const struct btf_param *param;
@@ -544,6 +557,7 @@ static int query_btf_context(struct traceprobe_parse_context *ctx)
 	if (!ctx->funcname)
 		return -EINVAL;
 
+	trace_probe_load_btf();
 	type = btf_find_func_proto(ctx->funcname, &btf);
 	if (!type)
 		return -ENOENT;
@@ -762,6 +776,7 @@ static int parse_btf_arg(char *varname,
 	if (!strcmp(varname, "$current")) {
 		code->op = FETCH_OP_CURRENT;
 		/* If no typecast is specified for $current, use task_struct by default */
+		trace_probe_load_btf();
 		ret = bpf_find_btf_id("task_struct", BTF_KIND_STRUCT, &ctx->struct_btf);
 		if (ret < 0) {
 			trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
@@ -890,6 +905,7 @@ static int query_btf_struct(const char *sname, struct traceprobe_parse_context *
 		ctx->struct_btf = NULL;
 	}
 
+	trace_probe_load_btf();
 	id = bpf_find_btf_id(sname, BTF_KIND_STRUCT, &btf);
 	if (id < 0)
 		return id;
-- 
2.47.3

