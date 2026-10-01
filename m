Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635B133A9D6;
	Thu,  1 Oct 2026 22:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895208; cv=none; b=WAysl4WkrBgcAuezbOfI9BslVszZzZwMyT5bR5rJlh1ru/frtVXT9t7HMsCs2+QJZryFLYRBQcVmZQJluAQhq/L49+UBXjYg2DIyTiAgrtQ27WWl4bpUKqMAJwAUpatMVYaR1xlekexLDitDi/x8avwypTy37nFLKHt8B77lZu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895208; c=relaxed/simple;
	bh=40soo8g/TmEgN36+QhsxzHBvpdKiT/69e3aMcXULivU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ztbe9aW/LgQbnOnfAxMW6vnd1lvSKYDg94ui7sITDXLFTZbtrG00VvFULArFOSBotqRnpwuQL6YhzLd6aO9LkL3WFxBJsiZytvUTJyiZvN5SomnWOTewS7PpeIGY3bOzKe83oeJhGGRDwEeBNEK2pLzFyoDq1d3PlzWJ4BxuQS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=VqX6nWhw; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="VqX6nWhw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790895205; x=1822431205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O1rRZe+JiV8y9C7sfYFiNZT7I3nItYIzHPE9RmJXTwA=;
  b=VqX6nWhwTWkeiseFiP/mfQ2X1lYRi6XPYOATXxJQNKDQXsYV2P0X2a0b
   dkt1+AdWPa5iznCC8OsHUI9J4qYV+1eQqB4MtBdElCdEVhK5+0/40mYo9
   hO8LtaL+JkzEmcfB0HokfB7inDHYIZJwNcv7QZadeztqM31K24BPefWt+
   VncvTn2VDHmzBHkPDZQCPKkRcYJ9KwGR+bSCbvsQYO0jPnvrckh2/BxPz
   TDo+aTsY300EgB5cJrPO2EeO+thgHbnCNP/HZnH6brVrrzAxTZXw/rU7X
   X2+Ac9oSLsbqttGdmDgVrxnFpRSbsk8+yuFv4D/cQBOkSd1NBT7Cmc0be
   w==;
X-CSE-ConnectionGUID: 9gQ7scaxTdKD/lS774p1Bg==
X-CSE-MsgGUID: OeSpPnDRThex9M/XNC8uLg==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="29693865"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 22:53:24 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:3984]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.212:2525] with esmtp (Farcaster)
 id 83510c96-b3a3-4859-b67f-8aee307bd797; Thu, 1 Oct 2026 22:53:24 +0000 (UTC)
X-Farcaster-Flow-ID: 83510c96-b3a3-4859-b67f-8aee307bd797
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:53:24 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:53:23 +0000
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
Subject: [PATCH bpf-next v4 04/12] bpf: take the vmlinux BTF from the btf_vmlinux module
Date: Thu, 1 Oct 2026 22:52:06 +0000
Message-ID: <20261001225214.12351-5-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D039UWA001.ant.amazon.com (10.13.139.110) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Add the runtime side of delivering the vmlinux BTF as a module: with
CONFIG_DEBUG_INFO_BTF=m the BTF is carried by a module named btf_vmlinux
and installed by the BTF module notifier when it loads.  Nothing in this
patch is reachable yet: CONFIG_DEBUG_INFO_BTF is still a bool and every
new path is under IS_MODULE(CONFIG_DEBUG_INFO_BTF); the kbuild side and
the Kconfig change follow.

With CONFIG_DEBUG_INFO_BTF=y the vmlinux BTF, 5.4 MiB on x86-64 with a
distribution config, is part of the kernel image and resident from boot
whether anything uses it or not.  Most systems never do.  Carrying it in
a module that is loaded on first use makes the memory a cost of using
BTF rather than of having a kernel that supports it.

btf_vmlinux_data() hands out the raw vmlinux BTF: from __start_BTF with
=y, or with =m from a vmalloc_user() copy that the notifier makes when
the btf_vmlinux module loads.  The kernel is linked with a record of the
BTF the module carries, .BTF.link (struct btf_link, zeroed here and
filled in by resolve_btfids at the end of the link in a later patch),
much as .gnu_debuglink describes a separate debug info file: the name of
the module, and the size and SHA-256 of the BTF.  The verifier trusts
the BTF as the description of this kernel's types, so the notifier only
accepts a payload of that size and SHA-256 from the module of that name.
A carrier from another build is refused with -EINVAL even if vermagic
lets it load, and a second carrier is ignored.  The copy is never freed:
as with =y, the BTF stays for the lifetime of the kernel, and the
carrier has no exit.

Loading the module waits for user space (modprobe), and the module's
notifiers take locks of their own, event_mutex among them.  The callers
of bpf_get_btf_vmlinux() and bpf_find_btf_id() were not written for
that: some hold locks the module load needs, some run with interrupts
disabled.  So neither of them loads anything.  With =m,
bpf_get_btf_vmlinux() returns the BTF if it is loaded and NULL
otherwise, like a kernel without BTF, and counts the miss; it no longer
sleeps at all.  A new function, bpf_load_btf_vmlinux(), is the only one
that loads: it calls request_module() for the carrier outside
btf_vmlinux_lock, so that the notifier never waits for its caller, then
parses the BTF.  The notifier installs the copy before init_module()
returns, so the data is either there afterwards or the module is not
available (yet); that is not cached, the next call tries again.  A parse
that fails for lack of memory is not remembered either; any other
failure is a broken BTF, the same with every attempt, and is remembered
as with =y.

bpf_load_btf_vmlinux() is called only at the start of a request from
user space, in process context, holding no lock that loading a module
needs:

 - on entry to the bpf() system call: a BPF_PROG_LOAD, BPF_MAP_CREATE
   or BPF_BTF_LOAD that fails while the vmlinux BTF was found missing is
   run once more after loading it, the way tc and nf_tables retry a
   request after loading a module.  A failure of these commands leaves
   nothing behind, and bpf_sys_bpf() and kern_sys_bpf() do not go
   through the system call entry, so nothing loads from within a
   running BPF program.  The miss count is global, so a command that
   fails for another reason while a concurrent one misses is retried
   too, and fails again the same way;
 - for BPF_BTF_GET_NEXT_ID, for callers that may enumerate BTF ids
   (CAP_SYS_ADMIN, as bpf_obj_get_next_id() checks): kernel BTFs get
   their ids when the vmlinux BTF is parsed, and whoever enumerates BTF
   ids wants them;
 - when user space loads a syscall program: a light skeleton loader
   loads programs while it runs (bpf_sys_bpf()), and those may need the
   BTF, which cannot be loaded from there;
 - for read() of /sys/kernel/btf/vmlinux, see below.

The next patch adds the tracefs and bpffs entry points.

The module notifier, btf_parse_module() and the btf_data fields in struct
module are compiled for CONFIG_DEBUG_INFO_BTF_MODULES or =m; with =m and
no module BTF, the notifier only recognizes the carrier.

/sys/kernel/btf/vmlinux exists from boot with its final size, which is
known from .BTF.link before the BTF is loaded, so stat() works before the
load, which is what the btf_sysfs selftest does.  The first read() loads
it, and the raw BTF is served even if it does not parse, as with =y.
mmap() does not load it: it runs with the caller's mmap_lock held, and
the module load takes event_mutex (trace_module_notify()), which a task
registering a uprobe holds while it takes the mmap_lock of every mm that
maps the probed file.  Before the BTF is loaded mmap() fails, and libbpf,
which tries mmap() first, falls back to read(); afterwards it maps the
vmalloc_user() copy with remap_vmalloc_range().

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 include/linux/bpf.h    |   9 +++
 include/linux/btf.h    |   1 +
 include/linux/module.h |   2 +-
 kernel/bpf/btf.c       | 177 +++++++++++++++++++++++++++++++++++++++--
 kernel/bpf/syscall.c   |  51 +++++++++++-
 kernel/bpf/sysfs_btf.c |  97 +++++++++++++++++++++-
 kernel/bpf/verifier.c  |  91 +++++++++++++++++++--
 kernel/module/main.c   |   4 +-
 8 files changed, 412 insertions(+), 20 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e46a14809dd4..d812dbc683ae 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3184,6 +3184,15 @@ static inline s32 bpf_call_args_imm(s16 idx)
 
 struct btf *bpf_get_btf_vmlinux(void);
 struct btf *bpf_peek_btf_vmlinux(void);
+struct btf *bpf_load_btf_vmlinux(void);
+#if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+unsigned int bpf_btf_vmlinux_misses(void);
+#else
+static inline unsigned int bpf_btf_vmlinux_misses(void)
+{
+	return 0;
+}
+#endif
 
 /* Map specifics */
 struct xdp_frame;
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 4b63bb91550a..81e6c65fe5f6 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -602,6 +602,7 @@ __u32 *btf_field_iter_next(struct btf_field_iter *it);
 const char *btf_name_by_offset(const struct btf *btf, u32 offset);
 const char *btf_str_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
+void *btf_vmlinux_data(u32 *size, bool load);
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
 u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_prog *prog);
 int btf_kfunc_check_flag(const struct btf *btf, u32 kfunc_btf_id, u32 flag);
diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..82734996a862 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -497,7 +497,7 @@ struct module {
 	unsigned int num_bpf_raw_events;
 	struct bpf_raw_event_map *bpf_raw_events;
 #endif
-#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES) || IS_MODULE(CONFIG_DEBUG_INFO_BTF)
 	unsigned int btf_data_size;
 	unsigned int btf_base_data_size;
 	void *btf_data;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9896a30eeac4..2aa9d4b3f438 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -29,6 +29,7 @@
 #include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/overflow.h>
+#include <crypto/sha2.h>
 #include <linux/bitops.h>
 
 #include <net/netfilter/nf_bpf_link.h>
@@ -6487,10 +6488,83 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr,
 	return ERR_PTR(err);
 }
 
+#if IS_BUILTIN(CONFIG_DEBUG_INFO_BTF)
 extern char __start_BTF[];
 extern char __stop_BTF[];
+#endif
 extern struct btf *btf_vmlinux;
 
+#if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+/*
+ * With CONFIG_DEBUG_INFO_BTF=m the vmlinux BTF is not part of the kernel
+ * image.  The btf_vmlinux module carries it in its .BTF section; when the
+ * module loads, btf_module_notify() copies the section here.  The copy is
+ * made with vmalloc_user() so that /sys/kernel/btf/vmlinux can be mmap()ed
+ * as with the built-in BTF.  Set once, never cleared: like the built-in
+ * BTF, once present it stays for the lifetime of the kernel.
+ *
+ * The kernel is linked with .BTF.link, which describes the BTF the module
+ * carries, much as .gnu_debuglink describes a separate debug info file: the
+ * name of the module, and the size and SHA-256 of the BTF.  It is zeroed
+ * here and filled in by resolve_btfids at the end of the link (see
+ * scripts/link-vmlinux.sh), which also checks that the section is as large
+ * as this struct, whose name field is sized like the one in struct module.
+ * The size makes /sys/kernel/btf/vmlinux report its size before the BTF is
+ * loaded, the hash makes sure only the BTF this kernel was built with is
+ * accepted.
+ */
+struct btf_link {
+	char module_name[MODULE_NAME_LEN];
+	u8 sha256[SHA256_DIGEST_SIZE];
+	u32 btf_size;
+} __packed;
+
+static const struct btf_link __btf_vmlinux_link __section(".BTF.link") __used;
+
+/* Read through the linker symbol, the compiler would fold the zeroes above */
+extern const struct btf_link __start_BTF_link[];
+#define btf_vmlinux_link (__start_BTF_link[0])
+
+static void *btf_vmlinux_raw;
+#endif
+
+/**
+ * btf_vmlinux_data - get the raw vmlinux BTF
+ * @size: where to store the size of the BTF, also when it is not loaded yet
+ * @load: with CONFIG_DEBUG_INFO_BTF=m, load the btf_vmlinux module if the
+ *	  BTF is not present yet; waits for user space, see
+ *	  bpf_load_btf_vmlinux()
+ *
+ * Return: the raw BTF, or NULL if it is not available.
+ */
+void *btf_vmlinux_data(u32 *size, bool load)
+{
+#if IS_BUILTIN(CONFIG_DEBUG_INFO_BTF)
+	*size = __stop_BTF - __start_BTF;
+	return __start_BTF;
+#elif IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+	/* Pairs with the smp_store_release() in btf_vmlinux_module_coming() */
+	void *data = smp_load_acquire(&btf_vmlinux_raw);
+
+	if (!data && load) {
+		/*
+		 * The module notifier installs the BTF before init_module()
+		 * returns, so it is either there after this or the module is
+		 * not available (yet).  Not cached: a later call retries,
+		 * e.g. once the module becomes reachable on the root fs.
+		 */
+		request_module("%s", btf_vmlinux_link.module_name);
+		/* Same pairing as above */
+		data = smp_load_acquire(&btf_vmlinux_raw);
+	}
+	*size = btf_vmlinux_link.btf_size;
+	return data;
+#else
+	*size = 0;
+	return NULL;
+#endif
+}
+
 #define BPF_MAP_TYPE(_id, _ops)
 #define BPF_LINK_TYPE(_id, _name)
 static union {
@@ -6891,15 +6965,22 @@ struct btf *btf_parse_vmlinux(void)
 	struct btf_verifier_env *env = NULL;
 	struct bpf_verifier_log *log;
 	struct btf *btf;
+	void *data;
+	u32 size;
 	int err;
 
+	/* The caller made sure the BTF is present, see bpf_load_btf_vmlinux() */
+	data = btf_vmlinux_data(&size, false);
+	if (!data)
+		return ERR_PTR(-ENOENT);
+
 	env = kzalloc_obj(*env, GFP_KERNEL | __GFP_NOWARN);
 	if (!env)
 		return ERR_PTR(-ENOMEM);
 
 	log = &env->log;
 	log->level = BPF_LOG_KERNEL;
-	btf = btf_parse_base(env, "vmlinux", __start_BTF, __stop_BTF - __start_BTF);
+	btf = btf_parse_base(env, "vmlinux", data, size);
 	if (IS_ERR(btf))
 		goto err_out;
 
@@ -6907,6 +6988,7 @@ struct btf *btf_parse_vmlinux(void)
 	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
 	err = btf_alloc_id(btf);
 	if (err) {
+		bpf_ctx_convert.t = NULL;
 		btf_free(btf);
 		btf = ERR_PTR(err);
 	}
@@ -6926,7 +7008,7 @@ __u32 btf_relocate_id(const struct btf *btf, __u32 id)
 	return btf->base_id_map[id];
 }
 
-#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES) || IS_MODULE(CONFIG_DEBUG_INFO_BTF)
 
 /*
  * Parse split module BTF against @vmlinux_btf.  @data is the module's .BTF
@@ -7032,7 +7114,7 @@ static struct btf *btf_parse_module(const char *module_name, struct btf *vmlinux
 	return ERR_PTR(err);
 }
 
-#endif /* CONFIG_DEBUG_INFO_BTF_MODULES */
+#endif /* CONFIG_DEBUG_INFO_BTF_MODULES || CONFIG_DEBUG_INFO_BTF=m */
 
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog)
 {
@@ -9019,7 +9101,16 @@ enum {
 	BTF_MODULE_F_LIVE = (1 << 0),
 };
 
-#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+/*
+ * The module notifier registers module BTF (CONFIG_DEBUG_INFO_BTF_MODULES)
+ * and picks up the vmlinux BTF from the btf_vmlinux module
+ * (CONFIG_DEBUG_INFO_BTF=m).
+ */
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES) || IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+#define BTF_MODULE_NOTIFIER 1
+#endif
+
+#ifdef BTF_MODULE_NOTIFIER
 struct btf_module {
 	struct list_head list;
 	struct module *module;
@@ -9075,6 +9166,63 @@ static void btf_module_free(struct btf_module *btf_mod)
 	kfree(btf_mod);
 }
 
+#if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+/*
+ * The btf_vmlinux module carries the vmlinux BTF in its .BTF section
+ * (scripts/gen-btf.sh).  Keep a copy; the module is only the carrier and
+ * has no BTF of its own.
+ */
+static int btf_vmlinux_module_coming(struct module *mod)
+{
+	u8 sha256sum[SHA256_DIGEST_SIZE];
+	void *data;
+
+	if (btf_vmlinux_raw)
+		return 0;
+
+	/*
+	 * The verifier trusts the BTF as the description of this kernel's
+	 * types, so a BTF from a different build must not get in even if
+	 * the module otherwise loads (same release string, same vermagic).
+	 */
+	if (mod->btf_data_size != btf_vmlinux_link.btf_size) {
+		pr_err("module [%s]: BTF size %u does not match this kernel (%u)\n",
+		       mod->name, mod->btf_data_size, btf_vmlinux_link.btf_size);
+		return -EINVAL;
+	}
+	sha256(mod->btf_data, mod->btf_data_size, sha256sum);
+	if (memcmp(sha256sum, btf_vmlinux_link.sha256, sizeof(sha256sum))) {
+		pr_err("module [%s]: BTF does not match this kernel\n", mod->name);
+		return -EINVAL;
+	}
+
+	data = vmalloc_user(mod->btf_data_size);
+	if (!data)
+		return -ENOMEM;
+	memcpy(data, mod->btf_data, mod->btf_data_size);
+
+	/* Pairs with the smp_load_acquire() in btf_vmlinux_data() */
+	smp_store_release(&btf_vmlinux_raw, data);
+	return 0;
+}
+
+/* The module named in .BTF.link */
+static bool btf_is_vmlinux_carrier(const struct module *mod)
+{
+	return !strcmp(mod->name, btf_vmlinux_link.module_name);
+}
+#else
+static int btf_vmlinux_module_coming(struct module *mod)
+{
+	return 0;
+}
+
+static bool btf_is_vmlinux_carrier(const struct module *mod)
+{
+	return false;
+}
+#endif
+
 static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			     void *module)
 {
@@ -9083,9 +9231,17 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 	struct btf *btf;
 	int err = 0;
 
-	if (mod->btf_data_size == 0 ||
-	    (op != MODULE_STATE_COMING && op != MODULE_STATE_LIVE &&
-	     op != MODULE_STATE_GOING))
+	if (op != MODULE_STATE_COMING && op != MODULE_STATE_LIVE &&
+	    op != MODULE_STATE_GOING)
+		goto out;
+
+	if (btf_is_vmlinux_carrier(mod)) {
+		if (op == MODULE_STATE_COMING)
+			err = btf_vmlinux_module_coming(mod);
+		goto out;
+	}
+
+	if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES) || mod->btf_data_size == 0)
 		goto out;
 
 	switch (op) {
@@ -9173,7 +9329,7 @@ static int __init btf_module_init(void)
 }
 
 fs_initcall(btf_module_init);
-#endif /* CONFIG_DEBUG_INFO_BTF_MODULES */
+#endif /* BTF_MODULE_NOTIFIER */
 
 struct module *btf_try_get_module(const struct btf *btf)
 {
@@ -10136,6 +10292,11 @@ static void purge_cand_cache(struct btf *btf)
 	__purge_cand_cache(btf, module_cand_cache, MODULE_CAND_CACHE_SIZE);
 	mutex_unlock(&cand_cache_mutex);
 }
+#elif defined(BTF_MODULE_NOTIFIER)
+/* CONFIG_DEBUG_INFO_BTF=m without module BTF: nothing is ever cached */
+static void purge_cand_cache(struct btf *btf)
+{
+}
 #endif
 
 static struct bpf_cand_cache *
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ac52f4ae414c..e5c4c0aa776e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3002,6 +3002,17 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 	if (is_perfmon_prog_type(type) && !bpf_token_capable(token, CAP_PERFMON))
 		goto put_token;
 
+	/*
+	 * CONFIG_DEBUG_INFO_BTF=m: a light skeleton loader is a syscall
+	 * program that loads programs while it runs (bpf_sys_bpf()), and
+	 * those may need the vmlinux BTF, which cannot be loaded from within
+	 * a running program.  Load it now, while user space loads the loader;
+	 * if that fails, the loader works as on a kernel without BTF.
+	 */
+	if (IS_MODULE(CONFIG_DEBUG_INFO_BTF) && type == BPF_PROG_TYPE_SYSCALL &&
+	    !uattr.is_kernel)
+		bpf_load_btf_vmlinux();
+
 	multi_func = is_tracing_multi(attr->expected_attach_type);
 
 	/* attach_prog_fd/attach_btf_obj_fd can specify fd of either bpf_prog
@@ -6435,6 +6446,14 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 					  &map_idr, &map_idr_lock);
 		break;
 	case BPF_BTF_GET_NEXT_ID:
+		/*
+		 * With CONFIG_DEBUG_INFO_BTF=m the kernel BTFs get ids when the
+		 * vmlinux BTF is loaded; whoever enumerates them wants them.
+		 * Only for callers bpf_obj_get_next_id() lets through.
+		 */
+		if (IS_MODULE(CONFIG_DEBUG_INFO_BTF) &&
+		    ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN))
+			bpf_load_btf_vmlinux();
 		err = bpf_obj_get_next_id(&attr, uattr.user,
 					  &btf_idr, &btf_idr_lock);
 		break;
@@ -6525,10 +6544,40 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 	return err;
 }
 
+/*
+ * With CONFIG_DEBUG_INFO_BTF=m the vmlinux BTF is loaded on demand, but never
+ * from within a command: loading waits for user space, and a command may hold
+ * locks or run from a BPF program (bpf_sys_bpf()).  A command that needs the
+ * BTF while it is not loaded fails as it would without BTF.  If the command
+ * is one whose failure leaves nothing behind, load the BTF here, on entry
+ * from user space with nothing held, and run the command once more.
+ */
+static bool bpf_btf_vmlinux_retry(int cmd, unsigned int misses)
+{
+	switch (cmd & ~BPF_COMMON_ATTRS) {
+	case BPF_PROG_LOAD:
+	case BPF_MAP_CREATE:
+	case BPF_BTF_LOAD:
+		break;
+	default:
+		return false;
+	}
+	if (bpf_btf_vmlinux_misses() == misses)
+		return false;
+	return !IS_ERR_OR_NULL(bpf_load_btf_vmlinux());
+}
+
 SYSCALL_DEFINE5(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size,
 		struct bpf_common_attr __user *, uattr_common, unsigned int, size_common)
 {
-	return __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common), size_common);
+	unsigned int misses = bpf_btf_vmlinux_misses();
+	int err;
+
+	err = __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common), size_common);
+	if (IS_MODULE(CONFIG_DEBUG_INFO_BTF) && err < 0 && bpf_btf_vmlinux_retry(cmd, misses))
+		err = __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common),
+				size_common);
+	return err;
 }
 
 static bool syscall_prog_is_valid_access(int off, int size,
diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
index 9cbe15ce3540..296eaf642786 100644
--- a/kernel/bpf/sysfs_btf.c
+++ b/kernel/bpf/sysfs_btf.c
@@ -9,8 +9,13 @@
 #include <linux/sysfs.h>
 #include <linux/mm.h>
 #include <linux/io.h>
+#include <linux/bpf.h>
 #include <linux/btf.h>
+#include <linux/vmalloc.h>
 
+struct kobject *btf_kobj;
+
+#if IS_BUILTIN(CONFIG_DEBUG_INFO_BTF)
 /* See scripts/link-vmlinux.sh, gen_btf() func for details */
 extern char __start_BTF[];
 extern char __stop_BTF[];
@@ -49,12 +54,98 @@ static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
 	.mmap = btf_sysfs_vmlinux_mmap,
 };
 
-struct kobject *btf_kobj;
-
-static int __init btf_vmlinux_init(void)
+static void __init btf_sysfs_vmlinux_init(void)
 {
 	bin_attr_btf_vmlinux.private = __start_BTF;
 	bin_attr_btf_vmlinux.size = __stop_BTF - __start_BTF;
+}
+
+#else /* CONFIG_DEBUG_INFO_BTF=m */
+
+/*
+ * The BTF is carried by the btf_vmlinux module and only loaded when
+ * something needs it.  Its size is known from the start, so the file has
+ * its final size from boot; the first read() loads the BTF, mmap() maps it
+ * once it is loaded.
+ */
+static void *btf_sysfs_vmlinux_load(u32 *size)
+{
+	/*
+	 * Loads the module, parses the BTF and registers module BTFs.  The
+	 * raw BTF is served even if it does not parse, as with =y.
+	 */
+	bpf_load_btf_vmlinux();
+	return btf_vmlinux_data(size, false);
+}
+
+static ssize_t btf_sysfs_vmlinux_read(struct file *filp, struct kobject *kobj,
+				      const struct bin_attribute *attr,
+				      char *buf, loff_t off, size_t count)
+{
+	u32 size;
+	void *data = btf_sysfs_vmlinux_load(&size);
+
+	if (!data)
+		return -ENODEV;
+
+	/* sysfs clamps @off and @count to attr->size, which is @size */
+	memcpy(buf, data + off, count);
+	return count;
+}
+
+static int btf_sysfs_vmlinux_mmap(struct file *filp, struct kobject *kobj,
+				  const struct bin_attribute *attr,
+				  struct vm_area_struct *vma)
+{
+	size_t vm_size = vma->vm_end - vma->vm_start;
+	void *data;
+	u32 size;
+
+	if (vma->vm_pgoff)
+		return -EINVAL;
+
+	if (vma->vm_flags & (VM_WRITE | VM_EXEC | VM_MAYSHARE))
+		return -EACCES;
+
+	if (vm_size > PAGE_ALIGN(attr->size))
+		return -EINVAL;
+
+	/*
+	 * Not loaded from here: this runs with the caller's mmap_lock held,
+	 * and loading the module waits for modprobe, whose module load takes
+	 * event_mutex in the trace module notifier, which a task registering
+	 * a uprobe holds while it takes the mmap_lock of each mm that maps
+	 * the probed file.  Until the BTF is loaded, e.g. by a read(), mmap()
+	 * fails; libbpf then falls back to read().
+	 */
+	data = btf_vmlinux_data(&size, false);
+	if (!data)
+		return -ENODEV;
+
+	vm_flags_mod(vma, VM_DONTDUMP, VM_MAYEXEC | VM_MAYWRITE);
+	/* the copy was made with vmalloc_user() for this purpose */
+	return remap_vmalloc_range(vma, data, 0);
+}
+
+static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
+	.attr = { .name = "vmlinux", .mode = 0444, },
+	.read = btf_sysfs_vmlinux_read,
+	.mmap = btf_sysfs_vmlinux_mmap,
+};
+
+static void __init btf_sysfs_vmlinux_init(void)
+{
+	u32 size;
+
+	/* known before the BTF is loaded, see .BTF.link */
+	btf_vmlinux_data(&size, false);
+	bin_attr_btf_vmlinux.size = size;
+}
+#endif
+
+static int __init btf_vmlinux_init(void)
+{
+	btf_sysfs_vmlinux_init();
 
 	if (bin_attr_btf_vmlinux.size == 0)
 		return 0;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f375c5dad4b5..895e7feb6429 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19847,7 +19847,7 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 		/* kernel types enter the program here, see bpf_check() */
 		btf = bpf_get_btf_vmlinux();
 		if (IS_ERR_OR_NULL(btf)) {
-			verbose(env, "kernel is missing BTF, make sure CONFIG_DEBUG_INFO_BTF=y is specified in Kconfig.\n");
+			verbose(env, "kernel is missing BTF, make sure CONFIG_DEBUG_INFO_BTF is specified in Kconfig (with =m, that btf_vmlinux can be loaded).\n");
 			return -EINVAL;
 		}
 		btf_get(btf);
@@ -21881,11 +21881,26 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
 	return 0;
 }
 
+/* CONFIG_DEBUG_INFO_BTF=m: lookups that found the vmlinux BTF not loaded */
+static atomic_t btf_vmlinux_misses = ATOMIC_INIT(0);
+
+/*
+ * Returns the parsed vmlinux BTF, NULL if the kernel has none, or an ERR_PTR
+ * if it is malformed.  Never waits for user space.
+ *
+ * With CONFIG_DEBUG_INFO_BTF=m the BTF is in the btf_vmlinux module, and
+ * this does not load it: until bpf_load_btf_vmlinux() has, it returns NULL,
+ * as without BTF, and counts the miss for bpf_btf_vmlinux_misses().
+ */
 struct btf *bpf_get_btf_vmlinux(void)
 {
-	/* Pairs with the smp_store_release() on the parse path below. */
+	/* Pairs with the smp_store_release() on the parse paths. */
 	struct btf *btf = smp_load_acquire(&btf_vmlinux);
 
+	if (!btf && IS_MODULE(CONFIG_DEBUG_INFO_BTF)) {
+		atomic_inc(&btf_vmlinux_misses);
+		return NULL;
+	}
 	if (!btf && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
 		mutex_lock(&btf_vmlinux_lock);
 		btf = btf_vmlinux;
@@ -21906,15 +21921,81 @@ struct btf *bpf_get_btf_vmlinux(void)
 
 /*
  * The vmlinux BTF if it has been parsed already, else NULL.  Unlike
- * bpf_get_btf_vmlinux() this never parses anything: for a running BPF
- * program, and for code that only uses the BTF if it happens to be there.
+ * bpf_get_btf_vmlinux() this never parses anything and, with
+ * CONFIG_DEBUG_INFO_BTF=m, does not count a miss: for a running BPF program,
+ * and for code that only uses the BTF if it happens to be there.
  */
 struct btf *bpf_peek_btf_vmlinux(void)
 {
-	/* Pairs with the smp_store_release() in bpf_get_btf_vmlinux() */
+	/* Pairs with the smp_store_release() on the parse paths */
 	return smp_load_acquire(&btf_vmlinux);
 }
 
+/**
+ * bpf_load_btf_vmlinux - get the vmlinux BTF, loading it if necessary
+ *
+ * Like bpf_get_btf_vmlinux(), but with CONFIG_DEBUG_INFO_BTF=m it loads the
+ * btf_vmlinux module if the BTF is not there yet and parses it.  Loading the
+ * module waits for user space (modprobe), and the notifiers of the module
+ * load take locks of their own, event_mutex among them.  So this is only
+ * called at the start of a request from user space, in process context,
+ * holding no lock that loading a module may need; everything else uses
+ * bpf_get_btf_vmlinux() or bpf_peek_btf_vmlinux().
+ *
+ * If the module cannot be loaded, returns NULL like a kernel without BTF;
+ * the next call tries again.
+ */
+struct btf *bpf_load_btf_vmlinux(void)
+{
+	struct btf *btf;
+	u32 size;
+
+	might_sleep();
+	if (!IS_MODULE(CONFIG_DEBUG_INFO_BTF))
+		return bpf_get_btf_vmlinux();
+
+	/* Pairs with the smp_store_release() below */
+	btf = smp_load_acquire(&btf_vmlinux);
+	if (btf)
+		return btf;
+
+	/* Outside btf_vmlinux_lock, the module's notifier must not wait for us */
+	if (!btf_vmlinux_data(&size, true))
+		return NULL;
+
+	mutex_lock(&btf_vmlinux_lock);
+	btf = btf_vmlinux;
+	if (!btf) {
+		btf = btf_parse_vmlinux();
+		/*
+		 * An allocation failure is not remembered, the next caller
+		 * retries.  Anything else is a broken BTF, the same one with
+		 * every attempt, and is remembered as with =y.
+		 */
+		if (IS_ERR(btf) && PTR_ERR(btf) == -ENOMEM) {
+			mutex_unlock(&btf_vmlinux_lock);
+			return btf;
+		}
+		/* As in bpf_get_btf_vmlinux(): publish after the parse */
+		smp_store_release(&btf_vmlinux, btf);
+	}
+	mutex_unlock(&btf_vmlinux_lock);
+	return btf;
+}
+
+#if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+/*
+ * bpf(2) samples this before a command and, if the command failed and the
+ * count moved, loads the vmlinux BTF and runs the command once more.  The
+ * count is global: a command that failed for another reason while a
+ * concurrent one missed the BTF is run again as well, and fails the same way.
+ */
+unsigned int bpf_btf_vmlinux_misses(void)
+{
+	return atomic_read(&btf_vmlinux_misses);
+}
+#endif
+
 /*
  * The add_fd_from_fd_array() is executed only if fd_array_cnt is non-zero. In
  * this case expect that every file descriptor in the array is either a map or
diff --git a/kernel/module/main.c b/kernel/module/main.c
index d0e1e0bd2ad0..694c4bc7e679 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2718,7 +2718,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 					   sizeof(*mod->bpf_raw_events),
 					   &mod->num_bpf_raw_events);
 #endif
-#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES) || IS_MODULE(CONFIG_DEBUG_INFO_BTF)
 	mod->btf_data = any_section_objs(info, ".BTF", 1, &mod->btf_data_size);
 	mod->btf_base_data = any_section_objs(info, ".BTF.base", 1,
 					      &mod->btf_base_data_size);
@@ -3172,7 +3172,7 @@ static noinline int do_init_module(struct module *mod)
 		mod->mem[type].size = 0;
 	}
 
-#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES) || IS_MODULE(CONFIG_DEBUG_INFO_BTF)
 	/* .BTF is not SHF_ALLOC and will get removed, so sanitize pointers */
 	mod->btf_data = NULL;
 	mod->btf_base_data = NULL;
-- 
2.47.3

