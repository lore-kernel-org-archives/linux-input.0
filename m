Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A6D25B0B8;
	Thu,  1 Oct 2026 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895284; cv=none; b=Hi6GlCJRHl/t+I9LWF8eQDwhXn7SE5XaidwtZB+TZAOSgmaiLkNo5mpRqXCsLCMbT9n3srKoBbTdoBnBouNtkuCCOMsaIH1usRTZD2v0lJ85XSiDBzD9PGqQlpVABYTk9Bk8a7KQq706RHdDIDMTJtikE0R08yxuiV+YtqHikDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895284; c=relaxed/simple;
	bh=nnMejE+pPhm6nlELtL96ZT+rATgCIsZWxJDBMflL3f0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSEP/EQf4RRfKA8PkALI+7WgCZDMI1S/r7PktN0Ipxr562qiuJiYDG+sEoAbvSaCyyY+2YUqke5LoxkjNf0Ooeff5pc1DWcA88WatG+878cDddyDfV/LjUg6cgqrEKp2VPbV6RSHyRQ30E294cF1L//8yKLhLQb4cUqUUytp7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=JW9yiMEH; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="JW9yiMEH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790895283; x=1822431283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=skyvb0OYvU/UgzRmEi/KiT+zwrNZCvM0501pt/7wNbw=;
  b=JW9yiMEHq7n/qcEvSxccn/5pF4CecbU5bhGOMBZgCR6tBaX550zPOIE/
   i1STljE6uNLZDdGRn8VQVwj+24gG3a8qzjJ4Ift9LRp7Vj8VseoqB66yH
   0TwtJsnJF5GpCRx9cXgCanljSTIJc6pvnzWmu+GfK04ECTMiRkbA7XexP
   z2x10XMX3puwsXBdI+b3zR0AcFaknUxDRFyfW2NrTTE/garHvm8s/kkhZ
   VWAt37XjPnuJJLlLErCbYZx9Noh6c1zocUvMIG9NTU3thb93lxR87T7to
   zb/FzcpjJeHzsKwS2AQDNjkqUFd5zedQiIyePeQMpVKIMm/ODAx7gAnt3
   g==;
X-CSE-ConnectionGUID: 2ca7hCwvQuC10ydqfBrbiQ==
X-CSE-MsgGUID: OUS04/1lSfiTnClgKFVLhg==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="30175471"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 22:54:42 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:15953]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.153:2525] with esmtp (Farcaster)
 id b7be0711-fe04-48b8-8170-606574b22eda; Thu, 1 Oct 2026 22:54:42 +0000 (UTC)
X-Farcaster-Flow-ID: b7be0711-fe04-48b8-8170-606574b22eda
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:54:42 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:54:41 +0000
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
Subject: [PATCH bpf-next v4 09/12] bpf, trace, net: prepare CONFIG_DEBUG_INFO_BTF checks for a tristate
Date: Thu, 1 Oct 2026 22:52:11 +0000
Message-ID: <20261001225214.12351-10-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The next patch makes CONFIG_DEBUG_INFO_BTF a tristate.  With =m, Kconfig
defines CONFIG_DEBUG_INFO_BTF_MODULE instead of CONFIG_DEBUG_INFO_BTF,
so every check that must hold for both =y and =m has to be written for
it:

 - #ifdef CONFIG_DEBUG_INFO_BTF becomes #if IS_ENABLED(...) where the
   generated BTF and its id tables must be the same for =y and =m: the
   .BTF_ids tables (btf_ids.h), the BTF type tags (compiler_types.h), and
   the tracepoint and syscall BTF ids (trace_events.h, trace_syscalls.c).
   Leaving them would silently produce empty id sets with =m.

 - obj-$(CONFIG_DEBUG_INFO_BTF) and include-$(CONFIG_DEBUG_INFO_BTF)
   become $(subst m,y,...) where the object is built into the kernel
   regardless: sysfs_btf.o, the netfilter and xfrm kfunc objects, and
   scripts/Makefile.btf.  Otherwise =m would try to build them as
   modules (xfrm_state_bpf.o fails modpost for lack of MODULE_LICENSE)
   or skip the BTF generation flags.

 - "depends on !DEBUG_INFO_BTF" becomes "depends on DEBUG_INFO_BTF=n"
   for RUST and GENDWARFKSYMS: with =m the BTF is generated as with =y,
   so the pahole restrictions they express still apply, but !m is m,
   which a bool option takes as y.

No functional change: CONFIG_DEBUG_INFO_BTF is still a bool, for which
IS_ENABLED() and #ifdef agree, $(subst m,y,y) is y and "=n" is "!".

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 Makefile                       | 3 ++-
 include/linux/btf_ids.h        | 2 +-
 include/linux/compiler_types.h | 2 +-
 include/trace/trace_events.h   | 2 +-
 init/Kconfig                   | 2 +-
 kernel/bpf/Makefile            | 2 +-
 kernel/module/Kconfig          | 2 +-
 kernel/trace/trace_syscalls.c  | 6 +++---
 net/netfilter/Makefile         | 6 +++---
 net/xfrm/Makefile              | 4 ++--
 10 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 751a08643bf8..f561516e1735 100644
--- a/Makefile
+++ b/Makefile
@@ -1208,7 +1208,8 @@ endif
 # include additional Makefiles when needed
 include-y			:= scripts/Makefile.warn
 include-$(CONFIG_DEBUG_INFO)	+= scripts/Makefile.debug
-include-$(CONFIG_DEBUG_INFO_BTF)+= scripts/Makefile.btf
+# CONFIG_DEBUG_INFO_BTF is a tristate; BTF is generated for both y and m
+include-$(subst m,y,$(CONFIG_DEBUG_INFO_BTF)) += scripts/Makefile.btf
 include-$(CONFIG_KASAN)		+= scripts/Makefile.kasan
 include-$(CONFIG_KCSAN)		+= scripts/Makefile.kcsan
 include-$(CONFIG_KMSAN)		+= scripts/Makefile.kmsan
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 8b5a9ee92513..c665afff100e 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -22,7 +22,7 @@ struct btf_id_set8 {
 	} pairs[];
 };
 
-#ifdef CONFIG_DEBUG_INFO_BTF
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
 
 #include <linux/compiler.h> /* for __PASTE */
 #include <linux/compiler_attributes.h> /* for __maybe_unused */
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c5921f139007..a90a99849cee 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -34,7 +34,7 @@
  * Skipped when running bindgen due to a libclang issue;
  * see https://github.com/rust-lang/rust-bindgen/issues/2244.
  */
-#if defined(CONFIG_DEBUG_INFO_BTF) && defined(CONFIG_PAHOLE_HAS_BTF_TAG) && \
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF) && defined(CONFIG_PAHOLE_HAS_BTF_TAG) && \
 	__has_attribute(btf_type_tag) && !defined(__BINDGEN__)
 # define BTF_TYPE_TAG(value) __attribute__((btf_type_tag(#value)))
 #else
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 93011f800d0f..2a0098929771 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -398,7 +398,7 @@ static inline notrace int trace_event_get_offsets_##call(		\
 #define _TRACE_PERF_INIT(call)
 #endif /* CONFIG_PERF_EVENTS */
 
-#if defined(CONFIG_BPF_EVENTS) && defined(CONFIG_DEBUG_INFO_BTF)
+#if defined(CONFIG_BPF_EVENTS) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
 /*
  * Per-template BTF id list, populated at link time by resolve_btfids:
  *   [0] FUNC   __bpf_trace_<call>     (the BPF dispatcher)
diff --git a/init/Kconfig b/init/Kconfig
index 8583d9f06c52..9f9562f813c5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2257,7 +2257,7 @@ config RUST
 	depends on !MODVERSIONS || GENDWARFKSYMS
 	depends on !GCC_PLUGIN_RANDSTRUCT
 	depends on !RANDSTRUCT
-	depends on !DEBUG_INFO_BTF || (PAHOLE_HAS_LANG_EXCLUDE && !LTO)
+	depends on DEBUG_INFO_BTF=n || (PAHOLE_HAS_LANG_EXCLUDE && !LTO)
 	depends on !CFI || HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC
 	select CFI_ICALL_NORMALIZE_INTEGERS if CFI
 	depends on !KASAN || CC_IS_CLANG
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index c1f9b0d3468d..0b7db88f1bed 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -41,7 +41,7 @@ ifeq ($(CONFIG_INET),y)
 obj-$(CONFIG_BPF_SYSCALL) += reuseport_array.o
 endif
 ifeq ($(CONFIG_SYSFS),y)
-obj-$(CONFIG_DEBUG_INFO_BTF) += sysfs_btf.o
+obj-$(subst m,y,$(CONFIG_DEBUG_INFO_BTF)) += sysfs_btf.o
 endif
 ifeq ($(CONFIG_BPF_JIT),y)
 obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 43b1bb01fd27..da49cb984b0d 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -197,7 +197,7 @@ config GENDWARFKSYMS
 	# X86, requires pahole before commit 47dcb534e253 ("btf_encoder: Stop
 	# indexing symbols for VARs") or after commit 9810758003ce ("btf_encoder:
 	# Verify 0 address DWARF variables are in ELF section").
-	depends on !X86 || !DEBUG_INFO_BTF || PAHOLE_VERSION < 128 || PAHOLE_VERSION > 129
+	depends on !X86 || DEBUG_INFO_BTF=n || PAHOLE_VERSION < 128 || PAHOLE_VERSION > 129
 	help
 	  Calculate symbol versions from DWARF debugging information using
 	  gendwarfksyms. Requires DEBUG_INFO to be enabled.
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index e35744049e3f..7a0d59c308c2 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -1304,7 +1304,7 @@ struct trace_event_functions exit_syscall_print_funcs = {
 	.trace		= print_syscall_exit,
 };
 
-#if defined(CONFIG_BPF_EVENTS) && defined(CONFIG_DEBUG_INFO_BTF)
+#if defined(CONFIG_BPF_EVENTS) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
 /* BTF id lists for the shared sys_enter/sys_exit dispatcher tracepoints. */
 BTF_ID_LIST(syscall_enter_btf_ids)
 BTF_ID(func,   __bpf_trace_sys_enter)
@@ -1321,7 +1321,7 @@ struct trace_event_class __refdata event_class_syscall_enter = {
 	.fields_array	= syscall_enter_fields_array,
 	.get_fields	= syscall_get_enter_fields,
 	.raw_init	= init_syscall_trace,
-#if defined(CONFIG_BPF_EVENTS) && defined(CONFIG_DEBUG_INFO_BTF)
+#if defined(CONFIG_BPF_EVENTS) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
 	.btf_ids	= syscall_enter_btf_ids,
 #endif
 };
@@ -1336,7 +1336,7 @@ struct trace_event_class __refdata event_class_syscall_exit = {
 	},
 	.fields		= LIST_HEAD_INIT(event_class_syscall_exit.fields),
 	.raw_init	= init_syscall_trace,
-#if defined(CONFIG_BPF_EVENTS) && defined(CONFIG_DEBUG_INFO_BTF)
+#if defined(CONFIG_BPF_EVENTS) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
 	.btf_ids	= syscall_exit_btf_ids,
 #endif
 };
diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
index 6bf74d488a29..a2c7f00794d2 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -18,7 +18,7 @@ nf_conntrack-$(CONFIG_NF_CT_PROTO_GRE) += nf_conntrack_proto_gre.o
 ifeq ($(CONFIG_NF_CONNTRACK),m)
 nf_conntrack-$(CONFIG_DEBUG_INFO_BTF_MODULES) += nf_conntrack_bpf.o
 else ifeq ($(CONFIG_NF_CONNTRACK),y)
-nf_conntrack-$(CONFIG_DEBUG_INFO_BTF) += nf_conntrack_bpf.o
+nf_conntrack-$(subst m,y,$(CONFIG_DEBUG_INFO_BTF)) += nf_conntrack_bpf.o
 endif
 
 obj-$(CONFIG_NETFILTER) = netfilter.o
@@ -65,7 +65,7 @@ nf_nat-$(CONFIG_NF_NAT_OVS) += nf_nat_ovs.o
 ifeq ($(CONFIG_NF_NAT),m)
 nf_nat-$(CONFIG_DEBUG_INFO_BTF_MODULES) += nf_nat_bpf.o
 else ifeq ($(CONFIG_NF_NAT),y)
-nf_nat-$(CONFIG_DEBUG_INFO_BTF) += nf_nat_bpf.o
+nf_nat-$(subst m,y,$(CONFIG_DEBUG_INFO_BTF)) += nf_nat_bpf.o
 endif
 
 # NAT helpers
@@ -147,7 +147,7 @@ nf_flow_table-$(CONFIG_NF_FLOW_TABLE_PROCFS) += nf_flow_table_procfs.o
 ifeq ($(CONFIG_NF_FLOW_TABLE),m)
 nf_flow_table-$(CONFIG_DEBUG_INFO_BTF_MODULES) += nf_flow_table_bpf.o
 else ifeq ($(CONFIG_NF_FLOW_TABLE),y)
-nf_flow_table-$(CONFIG_DEBUG_INFO_BTF) += nf_flow_table_bpf.o
+nf_flow_table-$(subst m,y,$(CONFIG_DEBUG_INFO_BTF)) += nf_flow_table_bpf.o
 endif
 
 obj-$(CONFIG_NF_FLOW_TABLE_INET) += nf_flow_table_inet.o
diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
index 5a1787587cb3..b7f6e5046a0e 100644
--- a/net/xfrm/Makefile
+++ b/net/xfrm/Makefile
@@ -8,7 +8,7 @@ xfrm_interface-$(CONFIG_XFRM_INTERFACE) += xfrm_interface_core.o
 ifeq ($(CONFIG_XFRM_INTERFACE),m)
 xfrm_interface-$(CONFIG_DEBUG_INFO_BTF_MODULES) += xfrm_interface_bpf.o
 else ifeq ($(CONFIG_XFRM_INTERFACE),y)
-xfrm_interface-$(CONFIG_DEBUG_INFO_BTF) += xfrm_interface_bpf.o
+xfrm_interface-$(subst m,y,$(CONFIG_DEBUG_INFO_BTF)) += xfrm_interface_bpf.o
 endif
 
 obj-$(CONFIG_XFRM) := xfrm_policy.o xfrm_state.o xfrm_hash.o \
@@ -23,4 +23,4 @@ obj-$(CONFIG_XFRM_IPCOMP) += xfrm_ipcomp.o
 obj-$(CONFIG_XFRM_INTERFACE) += xfrm_interface.o
 obj-$(CONFIG_XFRM_IPTFS) += xfrm_iptfs.o
 obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o
-obj-$(CONFIG_DEBUG_INFO_BTF) += xfrm_state_bpf.o
+obj-$(subst m,y,$(CONFIG_DEBUG_INFO_BTF)) += xfrm_state_bpf.o
-- 
2.47.3

