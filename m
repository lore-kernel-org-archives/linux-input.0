Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF79493D4A;
	Thu,  1 Oct 2026 22:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895332; cv=none; b=lFXRss5zNXfcFoFFAp1ZRnmpG+yGJo10LHzd5wUk0mPAIA60AA1lv5DOLhuvClI8ieo2V2/XENTJVbepD/BwikXa3JsEb3Q3WN//vFv+bWEW7woIILrAej05caS9/zkwnYvFE2JiGdPbPqaceNa/b2FkXX3ThxfKxzXL+x5XuOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895332; c=relaxed/simple;
	bh=YjHfBYurFBx7GBv/ZpxXsjWMkOcdJ1cM0hVgq94iM7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJkMoDOmtVUf/56HnygKv+yh97Qw7eEnmJpseRWE4fDmkPE+QVdObM+k8N3k7hpyZixiz0eFxviYHfm8a6JQiKw7td19QIt0rhXVvG3AvKgASupl/zGQggmBQR9WnlDGtZE7GTZVAMazeOTE3bqwJdsyxylYEW/IqOCGLXuPfkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PAfNERjX; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PAfNERjX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790895330; x=1822431330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K6Tu+sJMpgCMtCc7vuxGY8MPrDNEdxYojQx1+9RWpLw=;
  b=PAfNERjXpwybkgGwsETI4j2S4SvOzKpApDD/DjyNDMAuWx/0C4oN/5GY
   z7ib5dzGuddFmtl2zhZCa4UzmoMViQYeZ9+U4aF0in89H7V4wnYte6Rfw
   pTUOndd/IFkgkmfq/+GLv2krMDBkUXAQUC9KDsh9okWbk6Yj3xEA5QSd+
   Gh9sjqFycvcus9tDUYFNwrmDOjjWZblGTdS5+SbZvi8UEOPYUm8S3mp2/
   ihA1ayPWJOltV8pJYZPXKJ1cvp+b1vxzfYb2l53EYVQtQ65zsrLOztXZK
   AJYz9z1UoXCLisv5qcRJFfodhee1Kkg/sdiGLIVBT0HQ8FlhgGlQjzgKM
   Q==;
X-CSE-ConnectionGUID: OnSNTV9pQoOA3wnd/m0iRA==
X-CSE-MsgGUID: Z11vznGlQdSabAocSyuTlw==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="30217027"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 22:55:29 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:18396]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.141:2525] with esmtp (Farcaster)
 id 0655e5d0-1389-4977-b655-33b641b20738; Thu, 1 Oct 2026 22:55:29 +0000 (UTC)
X-Farcaster-Flow-ID: 0655e5d0-1389-4977-b655-33b641b20738
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:55:28 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:55:28 +0000
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
Subject: [PATCH bpf-next v4 12/12] kbuild, bpf: allow building the vmlinux BTF as a module
Date: Thu, 1 Oct 2026 22:52:14 +0000
Message-ID: <20261001225214.12351-13-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Make CONFIG_DEBUG_INFO_BTF a tristate.  With =m the vmlinux BTF is not
part of the kernel image: it is carried by a new module, btf_vmlinux, and
loaded the first time user space asks for something that needs it.
Otherwise it behaves as with =y, with the exceptions btf.rst lists:
BPF_PRELOAD; users of kernel types that run before the module can be
loaded (from the kernel command line or the boot configuration, or
before the root file system is mounted if btf_vmlinux.ko is not in the
initramfs), or on a system that does not let them load modules; the BTF
check of modules loaded before the vmlinux BTF; code that assumes the
vmlinux BTF has id 1; and tools that look for the BTF in vmlinux or in
kernel memory.  The 5.4 MiB of read-only data (distribution config) is
simply not there on systems where nothing uses it.

The only way to save that memory today is CONFIG_DEBUG_INFO_BTF=n, which
a distribution cannot ship: one binary goes to every user, and off takes
BTF away from the users of CO-RE, fentry/fexit, kfuncs, struct_ops,
sched_ext or bpf-lsm.  Whether BTF is used is a property of the
workload, not of the build, so let the first user decide.

The BTF is generated as before, but with =m the .BTF section is linked
as a non-loadable section (like .comment), so the kernel image does not
load it, and the final step that makes vmlinux from vmlinux.unstripped
strips it: every boot image made from vmlinux, whether a raw binary or
an ELF copy, is without it.  Module BTF is generated against
vmlinux.unstripped, which keeps it.  .BTF_ids stays loadable, the
verifier needs it once the BTF is loaded.  The zeroed .BTF.link record
of the kernel (struct btf_link, checked by the module notifier) is filled
in where .BTF_ids is patched, after the final link: resolve_btfids
--btf_link .BTF:btf_vmlinux:.tmp_vmlinux1.BTF writes the name of the
carrier and the size and SHA-256 of the BTF into it, so with =m
gen-btf.sh keeps .tmp_vmlinux1.BTF for that step.
kernel/bpf/btf_vmlinux.c is an empty carrier module, built through
obj-$(CONFIG_DEBUG_INFO_BTF) so that make localmodconfig maps it to its
option; scripts/gen-btf.sh gives it the vmlinux .BTF as its own .BTF
section instead of generating split BTF for it, and fails if it found
none, so that one module depends on vmlinux with =m; with
CONFIG_DEBUG_INFO_BTF_MODULES all of them do, as before.

The packages keep the BTF where it now is: make pacman-pkg puts
vmlinux.unstripped into the debug package next to vmlinux with =m, for
the BTF of external modules, and make rpm-pkg refuses to build a
debuginfo package with a find-debuginfo that cannot keep .BTF (no
--keep-section), which would strip the payload of btf_vmlinux.ko.

CONFIG_BPF_PRELOAD is not selectable with =m: its iterator programs
attach through the vmlinux BTF, so every bpffs mount (systemd does one
at boot) would load it and defeat the point.  Module BTF is still kept
when a module loads, as with =y; the saving is the vmlinux BTF only.
Programs that need kernel types before the root file system is mounted
need btf_vmlinux.ko in the initramfs; the Kconfig help says so.

The module has no exit: once loaded the BTF stays, as with =y.  The
runtime side -- loading the module at the start of the requests that need
it, checking it against .BTF.link, deferring kfunc and struct_ops
registrations and module BTF until it arrives -- and the
IS_ENABLED()/$(subst m,y,...) preparation of the existing checks are in
the preceding patches; this one makes it selectable.

Tested with 1 GiB of memory, same tree, =y vs =m, both with
CONFIG_DEBUG_INFO_BTF_MODULES=y:

 - MemTotal is ~5.4 MB higher with =m while the BTF is unused: the size
   of the .BTF section.
 - stat() of /sys/kernel/btf/vmlinux reports the BTF size before it is
   loaded, as the btf_sysfs selftest expects.
 - With BTF in use, MemFree is the same within run-to-run noise.
 - Modules loaded before the trigger (ext4, nf_conntrack and its kfuncs,
   xfrm_interface) appear in /sys/kernel/btf immediately and get BTF ids
   once the BTF is loaded.  A socket filter, and one that fails
   verification, load without loading the module.  Each of these, as the
   first user of the BTF, loads it and works: a kprobe program calling
   bpf_get_current_task_btf(), a syscall program calling kfuncs, a
   struct_ops map, BTF and a map with a kptr to task_struct, a light
   skeleton loader, read() of /sys/kernel/btf/vmlinux, mmap() of it as
   libbpf does it (it fails, then libbpf reads), BPF_BTF_GET_NEXT_ID,
   kprobe events with BTF arguments, a tracepoint's btf_ids file, a
   bpffs mount with delegate options that name commands, and four
   programs loaded at once.  /proc/self/mountinfo, bpffs mounts with
   delegate_*=any or hex masks, the ftrace argument printer (also from
   sysrq-z) and BPF_BTF_GET_NEXT_ID without CAP_SYS_ADMIN do not load it.
 - Six BPF_BTF_GET_NEXT_ID users and a module tracepoint's btf_ids read
   at once, right after modules were loaded, all see every module BTF.
 - Without btf_vmlinux.ko installed, all of these fail or degrade as on a
   kernel without BTF, promptly; once it is installed, the next request
   loads it.
 - A carrier module with one byte of its .BTF changed is refused with
   "BTF does not match this kernel" and leaves no state behind.
 - After the load: fstat/read/mmap of /sys/kernel/btf/vmlinux, a
   struct_ops map for tcp_congestion_ops, a syscall program calling the
   bpf_task_from_pid()/bpf_task_release() kfuncs, and modules loaded
   afterwards (nf_nat) all work as with =y.
 - =m without DEBUG_INFO_BTF_MODULES, and =y, build and pass the same
   tests.
 - An i386 kernel builds with =m; its .BTF.link, 96 bytes there against
   92 on x86-64, also matches its carrier.  So does that of an LLVM=1
   build (clang and ld.lld 19).
 - make localmodconfig keeps =m with btf_vmlinux loaded; the rpm spec
   parses, and refuses a find-debuginfo without --keep-section.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 Documentation/bpf/btf.rst         | 68 +++++++++++++++++++++++++++++++
 Makefile                          |  5 ++-
 include/asm-generic/vmlinux.lds.h | 32 ++++++++++++++-
 kernel/bpf/Makefile               |  4 ++
 kernel/bpf/btf_vmlinux.c          | 23 +++++++++++
 kernel/bpf/preload/Kconfig        |  4 ++
 lib/Kconfig.debug                 | 30 +++++++++++++-
 scripts/Makefile.modfinal         | 28 +++++++++----
 scripts/Makefile.vmlinux          |  5 +++
 scripts/gen-btf.sh                | 53 ++++++++++++++++++++++--
 scripts/link-vmlinux.sh           | 25 +++++++++---
 scripts/package/PKGBUILD          |  7 ++++
 scripts/package/kernel.spec       |  4 ++
 scripts/package/mkspec            |  7 ++++
 14 files changed, 276 insertions(+), 19 deletions(-)
 create mode 100644 kernel/bpf/btf_vmlinux.c

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 29de1222c3e7..7d44374b67ba 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -1276,6 +1276,74 @@ format.::
             .long   58
             .long   8206                    # Line 8 Col 14
 
+6.1 Kernel BTF
+--------------
+
+With CONFIG_DEBUG_INFO_BTF=y the BTF of the kernel is generated at link time
+from its DWARF and placed in the .BTF section of vmlinux, which is read-only
+data of the kernel image. It is available as /sys/kernel/btf/vmlinux and, if
+CONFIG_DEBUG_INFO_BTF_MODULES is set, module BTF is generated as split BTF
+against it and available as /sys/kernel/btf/<module>.
+
+With CONFIG_DEBUG_INFO_BTF=m the same BTF is generated, but it is not part of
+the kernel image or of the vmlinux ELF file (vmlinux.unstripped in the build
+tree keeps it, for module BTF generation). It is delivered by the
+btf_vmlinux module, which the kernel loads the first time user space asks for
+something that needs the BTF: reading /sys/kernel/btf/vmlinux, enumerating
+kernel BTF objects (BPF_BTF_GET_NEXT_ID, with CAP_SYS_ADMIN), a BPF program,
+map or BTF object that uses kernel types (an attach_btf_id, a kfunc call, a
+ksym, a map pointer, a helper that takes or returns a kernel BTF pointer, a
+struct_ops map, a kptr to a kernel type), loading a light skeleton loader (a
+syscall program), a kprobe or fprobe event with BTF arguments, a tracepoint's
+btf_ids file, or mounting bpffs with delegate_* options that name commands or
+types. mmap() of /sys/kernel/btf/vmlinux does not load it and fails until it
+is loaded; libbpf then reads the file instead.
+
+Loading the module waits for user space (modprobe), so it only happens at the
+start of such a request, holding no lock that loading a module needs. The code
+that uses the BTF never loads it: bpf_get_btf_vmlinux() and bpf_find_btf_id()
+return nothing while it is not loaded, as on a kernel without BTF, and a bpf()
+command that fails because of that is run once more after the system call has
+loaded the BTF. Until then no memory is used for it; afterwards it behaves as
+with =y, except as described below. In particular:
+
+  * /sys/kernel/btf/vmlinux exists from boot with its final size.
+  * Modules loaded before the vmlinux BTF are exposed in /sys/kernel/btf right
+    away, their BTF is parsed and gets a BTF id once the vmlinux BTF is
+    loaded, together with their kfunc and struct_ops registrations. A request
+    that loads the vmlinux BTF returns once that is done.
+  * kfunc, dtor kfunc and struct_ops registrations of the kernel itself are
+    applied before the BTF becomes visible.
+  * The kernel only accepts the BTF it was built with: the name of the module,
+    and the size and SHA-256 of the BTF, are recorded in the kernel when it is
+    linked (.BTF.link), and the module is checked against them.
+  * Once loaded the BTF stays; the module cannot be unloaded.
+
+If the module is not available (not installed, or the root file system is not
+mounted yet), the kernel behaves as one built without BTF and tries again next
+time; probe events defined on the kernel command line or in the boot
+configuration cannot use BTF arguments for that reason. The module is also not
+loaded where the system does not let the task that needs the BTF load modules:
+with kernel.modules_disabled set, when the security policy does not allow the
+module request, or when modprobe is configured not to load it. Such systems can
+load btf_vmlinux at boot instead, e.g. through modules-load.d.
+
+CONFIG_BPF_PRELOAD is not available with =m: its iterators attach through the
+vmlinux BTF, so mounting bpffs would load it. Some users only use the BTF if it
+is already loaded: bpf_snprintf_btf() and bpf_seq_printf_btf(), which run in
+program context, the ftrace function argument printer (func-args,
+funcgraph-args), which can run with interrupts disabled, and the names of bpffs
+delegate_* options in ``/proc/*/mountinfo``. The vmlinux BTF gets its BTF id
+when it is loaded, so it is not necessarily id 1. Tools that look for the BTF
+in kernel memory, or in a crash dump, through the __start_BTF and __stop_BTF
+symbols do not find it.
+
+A module loaded before the vmlinux BTF is loaded cannot have its BTF checked
+against it yet. Its BTF is checked when the vmlinux BTF arrives, and if it
+does not match, the module keeps running without BTF, with a warning: without
+CONFIG_MODULE_ALLOW_BTF_MISMATCH such a module is only refused if it loads
+after the vmlinux BTF.
+
 7. Testing
 ==========
 
diff --git a/Makefile b/Makefile
index f561516e1735..7ce5d478abd3 100644
--- a/Makefile
+++ b/Makefile
@@ -1745,8 +1745,9 @@ endif
 #
 
 # *.ko are usually independent of vmlinux, but CONFIG_DEBUG_INFO_BTF_MODULES
-# is an exception.
-ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+# is an exception, and so is the btf_vmlinux module with CONFIG_DEBUG_INFO_BTF=m,
+# which carries the vmlinux BTF.
+ifneq ($(CONFIG_DEBUG_INFO_BTF_MODULES)$(filter m,$(CONFIG_DEBUG_INFO_BTF)),)
 KBUILD_BUILTIN := y
 modules: vmlinux
 endif
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2988aa12f66..cf5a3b35b33b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -674,8 +674,19 @@
 
 /*
  * .BTF
+ *
+ * With CONFIG_DEBUG_INFO_BTF=y the vmlinux BTF is loaded as read-only data and
+ * bounded by __start_BTF/__stop_BTF.  With CONFIG_DEBUG_INFO_BTF=m it is
+ * linked as a non-loadable section (see BTF_NONALLOC in ELF_DETAILS), so that
+ * module BTF generation can read it from vmlinux.unstripped; it is stripped
+ * from vmlinux (scripts/Makefile.vmlinux), and the btf_vmlinux module carries
+ * a copy and provides it on demand at runtime.
+ * What is loaded instead is .BTF.link (struct btf_link in kernel/bpf/btf.c):
+ * the name of that module and the size and SHA-256 of the BTF, which
+ * resolve_btfids fills in after the final link (scripts/link-vmlinux.sh).
+ * .BTF_ids is needed by the kernel in both cases.
  */
-#ifdef CONFIG_DEBUG_INFO_BTF
+#if IS_BUILTIN(CONFIG_DEBUG_INFO_BTF)
 #define BTF								\
 	. = ALIGN(PAGE_SIZE);						\
 	.BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {				\
@@ -685,10 +696,28 @@
 	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
 		*(.BTF_ids)						\
 	}
+#elif IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+#define BTF								\
+	. = ALIGN(8);							\
+	.BTF.link : AT(ADDR(.BTF.link) - LOAD_OFFSET) {			\
+		BOUNDED_SECTION_BY(.BTF.link, _BTF_link)		\
+	}								\
+	. = ALIGN(PAGE_SIZE);						\
+	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
+		*(.BTF_ids)						\
+	}
 #else
 #define BTF
 #endif
 
+#if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+/* quoted: BTF is a macro, an unquoted .BTF here would expand it */
+#define BTF_NONALLOC							\
+		".BTF" 0 : { *(".BTF") }
+#else
+#define BTF_NONALLOC
+#endif
+
 /*
  * Init task
  */
@@ -849,6 +878,7 @@
 /* Required sections not related to debugging. */
 #define ELF_DETAILS							\
 		.comment 0 : { *(.comment) }				\
+		BTF_NONALLOC						\
 		.symtab 0 : { *(.symtab) }				\
 		.strtab 0 : { *(.strtab) }				\
 		.shstrtab 0 : { *(.shstrtab) }				\
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 0b7db88f1bed..bde2ae68908f 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -43,6 +43,10 @@ endif
 ifeq ($(CONFIG_SYSFS),y)
 obj-$(subst m,y,$(CONFIG_DEBUG_INFO_BTF)) += sysfs_btf.o
 endif
+# With CONFIG_DEBUG_INFO_BTF=m the vmlinux BTF is carried by this module
+ifeq ($(CONFIG_DEBUG_INFO_BTF),m)
+obj-$(CONFIG_DEBUG_INFO_BTF) += btf_vmlinux.o
+endif
 ifeq ($(CONFIG_BPF_JIT),y)
 obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
 obj-$(CONFIG_BPF_SYSCALL) += cpumask.o
diff --git a/kernel/bpf/btf_vmlinux.c b/kernel/bpf/btf_vmlinux.c
new file mode 100644
index 000000000000..8d89b4bb3c43
--- /dev/null
+++ b/kernel/bpf/btf_vmlinux.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Carrier module for the vmlinux BTF when CONFIG_DEBUG_INFO_BTF=m.
+ *
+ * This module has no code of its own.  Its .BTF section is a copy of the
+ * vmlinux BTF (see scripts/gen-btf.sh), which the BTF module notifier in
+ * kernel/bpf/btf.c recognizes by module name and installs as the vmlinux BTF.
+ * The kernel loads it on demand, the first time the vmlinux BTF is needed.
+ *
+ * There is deliberately no module_exit(): once the BTF is in use it cannot
+ * be taken away again, exactly as with CONFIG_DEBUG_INFO_BTF=y.
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+
+static int __init btf_vmlinux_init(void)
+{
+	return 0;
+}
+module_init(btf_vmlinux_init);
+
+MODULE_DESCRIPTION("BTF type information for vmlinux");
+MODULE_LICENSE("GPL");
diff --git a/kernel/bpf/preload/Kconfig b/kernel/bpf/preload/Kconfig
index aef7b0bc96d6..b1600bdce7a0 100644
--- a/kernel/bpf/preload/Kconfig
+++ b/kernel/bpf/preload/Kconfig
@@ -6,6 +6,10 @@ menuconfig BPF_PRELOAD
 	# The dependency on !COMPILE_TEST prevents it from being enabled
 	# in allmodconfig or allyesconfig configurations
 	depends on !COMPILE_TEST
+	# The preloaded iterators attach through the vmlinux BTF, so with
+	# CONFIG_DEBUG_INFO_BTF=m every bpffs mount would load the BTF, which
+	# defeats the point of =m on any system that mounts bpffs at boot.
+	depends on DEBUG_INFO_BTF!=m
 	help
 	  This builds kernel module with several embedded BPF programs that are
 	  pinned into BPF FS mount point as human readable files that are
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 134b15a44625..8c671621006f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -396,7 +396,7 @@ config DEBUG_INFO_SPLIT
 	  Incompatible with older versions of ccache.
 
 config DEBUG_INFO_BTF
-	bool "Generate BTF type information"
+	tristate "Generate BTF type information"
 	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
 	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
 	depends on BPF_SYSCALL
@@ -408,6 +408,30 @@ config DEBUG_INFO_BTF
 	  Turning this on requires pahole v1.22 or later, which will convert
 	  DWARF type info into equivalent deduplicated BTF type info.
 
+	  If built as a module (=m), the vmlinux BTF is not part of the
+	  kernel image.  It is carried by the btf_vmlinux module, which is
+	  loaded on demand the first time the BTF is needed: when a BPF
+	  program requires kernel type information, or when
+	  /sys/kernel/btf/vmlinux is read.  Until then, no memory is
+	  spent on it.  The vmlinux ELF file does not carry the BTF
+	  either; module BTF is generated against vmlinux.unstripped, and
+	  tools that read the BTF from a file can use that or
+	  /sys/kernel/btf/vmlinux.
+
+	  Module BTF (DEBUG_INFO_BTF_MODULES) is kept when a module loads,
+	  as with =y, and registered once the vmlinux BTF is available; the
+	  saving is the vmlinux BTF only.
+
+	  If BPF programs that use kernel types run before the root file
+	  system is mounted, put btf_vmlinux.ko into the initramfs: until
+	  the module can be loaded, such programs fail as on a kernel
+	  without BTF.  The kernel requests the module itself, so the
+	  processes that use BTF must be allowed to cause a module load
+	  (kernel.modules_disabled, the security policy's module_request);
+	  otherwise load btf_vmlinux at boot, e.g. through modules-load.d.
+	  Not compatible with BPF_PRELOAD, whose iterators would load the
+	  BTF at every bpffs mount.
+
 config PAHOLE_HAS_BTF_TAG
 	def_bool PAHOLE_VERSION >= 123
 	depends on CC_IS_CLANG
@@ -442,6 +466,10 @@ config MODULE_ALLOW_BTF_MISMATCH
 	  this option will still load module BTF where possible but ignore
 	  it when a mismatch is found.
 
+	  With DEBUG_INFO_BTF=m, a module loaded before the vmlinux BTF can
+	  only be checked once that is loaded; it is then kept without BTF
+	  on a mismatch, as with this option.
+
 config GDB_SCRIPTS
 	bool "Provide GDB scripts for kernel debugging"
 	help
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 01a37ec872b9..201444f51b7d 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -38,20 +38,34 @@ quiet_cmd_ld_ko_o = LD [M]  $@
 		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
 		-T $(objtree)/scripts/module.lds -o $@ $(filter %.o, $^)
 
+# The ELF file with the vmlinux BTF: with CONFIG_DEBUG_INFO_BTF=m the BTF is
+# stripped from vmlinux (scripts/Makefile.vmlinux), vmlinux.unstripped keeps it.
+btf-vmlinux := $(objtree)/vmlinux$(if $(filter m,$(CONFIG_DEBUG_INFO_BTF)),.unstripped)
+
 quiet_cmd_btf_ko = BTF [M] $@
       cmd_btf_ko = 							\
-	if [ ! -f $(objtree)/vmlinux ]; then				\
-		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
+	if [ ! -f $(btf-vmlinux) ]; then				\
+		printf "Skipping BTF generation for %s due to unavailability of %s\n" $@ $(notdir $(btf-vmlinux)) 1>&2; \
 	else	\
-		$(CONFIG_SHELL) $(srctree)/scripts/gen-btf.sh --btf_base $(objtree)/vmlinux $@; \
+		$(CONFIG_SHELL) $(srctree)/scripts/gen-btf.sh --btf_base $(btf-vmlinux) $@; \
 	fi;
 
-# Re-generate module BTFs if either module's .ko or vmlinux changed
-%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
-	+$(call if_changed,ld_ko_o)
+# Modules that get a .BTF section: all of them with CONFIG_DEBUG_INFO_BTF_MODULES,
+# otherwise only the vmlinux BTF carrier module with CONFIG_DEBUG_INFO_BTF=m.
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
-	+$(if $(newer-prereqs),$(call cmd,btf_ko))
+btf-modules := $(modules:%.o=%.ko)
+else ifeq ($(CONFIG_DEBUG_INFO_BTF),m)
+btf-modules := $(filter %/btf_vmlinux.ko,$(modules:%.o=%.ko))
+# Only the carrier depends on vmlinux, not every module
+ifdef KBUILD_BUILTIN
+$(btf-modules): $(btf-vmlinux)
+endif
 endif
+
+# Re-generate module BTFs if either module's .ko or vmlinux changed
+%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(btf-vmlinux)) FORCE
+	+$(call if_changed,ld_ko_o)
+	+$(if $(and $(filter $@,$(btf-modules)),$(newer-prereqs)),$(call cmd,btf_ko))
 	+$(call cmd,check_tracepoint)
 
 targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o) .module-common.o
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index fcae1e432d9a..557db1ee1f3b 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -86,6 +86,11 @@ remove-section-$(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS) += '.rel*' '!.rel*.dyn'
 # for compatibility with binutils < 2.32
 # https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=c12d9fa2afe7abcbe407a00e15719e1a1350c2a7
 remove-section-$(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS) += '.rel.*'
+# With CONFIG_DEBUG_INFO_BTF=m the btf_vmlinux module carries the vmlinux BTF;
+# only vmlinux.unstripped keeps it, for module BTF generation.
+ifeq ($(CONFIG_DEBUG_INFO_BTF),m)
+remove-section-y += .BTF
+endif
 
 remove-symbols := -w --strip-unneeded-symbol='__mod_device_table__*'
 
diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
index 8ca96eb10a69..780f7b4bb214 100755
--- a/scripts/gen-btf.sh
+++ b/scripts/gen-btf.sh
@@ -22,6 +22,14 @@
 #   - ${1}.btf.o ready for linking into vmlinux
 #   - ${1}.BTF_ids with .BTF_ids data blob
 # This output is consumed by scripts/link-vmlinux.sh
+#
+# With CONFIG_DEBUG_INFO_BTF=m the .BTF section in ${1}.btf.o is not
+# allocatable, so the kernel image does not carry the BTF; vmlinux.unstripped
+# does, for module BTF generation, and scripts/Makefile.vmlinux strips it from
+# vmlinux.  ${1}.BTF is kept too: scripts/link-vmlinux.sh has resolve_btfids
+# record its size and SHA-256 in .BTF.link (struct btf_link).  The
+# btf_vmlinux module gets no BTF of its own; its .BTF section is a copy of the
+# vmlinux BTF, extracted from --btf_base.
 
 set -e
 
@@ -60,6 +68,10 @@ is_enabled() {
 	grep -q "^$1=y" ${objtree}/include/config/auto.conf
 }
 
+is_module() {
+	grep -q "^$1=m" ${objtree}/include/config/auto.conf
+}
+
 case "${KBUILD_VERBOSE}" in
 *1*)
 	set -x
@@ -83,13 +95,21 @@ gen_btf_o()
 {
 	btf_data=${ELF_FILE}.btf.o
 
+	# CONFIG_DEBUG_INFO_BTF=m: .BTF stays non-allocatable, kept in
+	# vmlinux.unstripped for module BTF but not loaded; the btf_vmlinux
+	# module provides it at runtime.
+	btf_flags=alloc,readonly
+	if is_module CONFIG_DEBUG_INFO_BTF; then
+		btf_flags=readonly
+	fi
+
 	# Create ${btf_data} which contains just .BTF section but no symbols. Add
-	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
+	# SHF_ALLOC (=y) because .BTF will be part of the vmlinux image. --strip-all
 	# deletes all symbols including __start_BTF and __stop_BTF, which will
 	# be redefined in the linker script.
 	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CPPFLAGS} ${KBUILD_CFLAGS} -fno-lto -c -x c -o ${btf_data} -
 	${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
-		--set-section-flags .BTF=alloc,readonly ${btf_data}
+		--set-section-flags .BTF=${btf_flags} ${btf_data}
 	${OBJCOPY} --only-section=.BTF --strip-all ${btf_data}
 
 	# Change e_type to ET_REL so that it can be used to link final vmlinux.
@@ -120,7 +140,10 @@ embed_btf_data()
 cleanup()
 {
 	rm -f "${ELF_FILE}.BTF.1"
-	rm -f "${ELF_FILE}.BTF"
+	# CONFIG_DEBUG_INFO_BTF=m: vmlinux's .BTF is needed for .BTF.link
+	if [ "${BTFGEN_MODE}" = "module" ] || ! is_module CONFIG_DEBUG_INFO_BTF; then
+		rm -f "${ELF_FILE}.BTF"
+	fi
 	if [ "${BTFGEN_MODE}" = "module" ]; then
 		rm -f "${ELF_FILE}.BTF.base"
 		rm -f "${ELF_FILE}.BTF_ids"
@@ -133,6 +156,30 @@ if [ -n "${BTF_BASE}" ]; then
 	BTFGEN_MODE="module"
 fi
 
+# CONFIG_DEBUG_INFO_BTF=m: the btf_vmlinux module carries the vmlinux BTF
+# itself.  Its own types are of no interest, so instead of generating split
+# BTF for it, copy the (non-loadable) .BTF section of --btf_base
+# (vmlinux.unstripped) into the module.
+# The kernel recognizes the module by name and treats its .BTF as base BTF.
+case "${BTFGEN_MODE}:${ELF_FILE}" in
+module:*/btf_vmlinux.ko)
+	if is_module CONFIG_DEBUG_INFO_BTF; then
+		# -O binary only emits allocatable sections; make .BTF one for
+		# the extraction.  ${BTF_BASE} itself is not modified.
+		${OBJCOPY} -O binary --only-section=.BTF			\
+			--set-section-flags .BTF=alloc,load,readonly	\
+			"${BTF_BASE}" "${ELF_FILE}.BTF"
+		# objcopy succeeds with an empty file if there is no .BTF
+		if [ ! -s "${ELF_FILE}.BTF" ]; then
+			echo >&2 "error: no .BTF section in ${BTF_BASE}"
+			exit 1
+		fi
+		${OBJCOPY} --add-section .BTF="${ELF_FILE}.BTF" "${ELF_FILE}"
+		exit 0
+	fi
+	;;
+esac
+
 gen_btf_data
 
 case "${BTFGEN_MODE}" in
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index ab0b8125c8cb..68b99234eab8 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -37,6 +37,15 @@ is_enabled() {
 	grep -q "^$1=y" include/config/auto.conf
 }
 
+is_module() {
+	grep -q "^$1=m" include/config/auto.conf
+}
+
+# =y or =m
+is_set() {
+	grep -q "^$1=[ym]" include/config/auto.conf
+}
+
 # Nice output in kbuild format
 # Will be suppressed by "make -s"
 info()
@@ -195,6 +204,7 @@ fi
 
 btf_vmlinux_bin_o=
 btfids_vmlinux=
+btf_link=
 kallsymso=
 strip_debug=
 generate_map=
@@ -211,17 +221,17 @@ if is_enabled CONFIG_KALLSYMS; then
 	kallsyms .tmp_vmlinux0.syms .tmp_vmlinux0.kallsyms
 fi
 
-if is_enabled CONFIG_KALLSYMS || is_enabled CONFIG_DEBUG_INFO_BTF; then
+if is_enabled CONFIG_KALLSYMS || is_set CONFIG_DEBUG_INFO_BTF; then
 
 	# The kallsyms linking does not need debug symbols, but the BTF does.
-	if ! is_enabled CONFIG_DEBUG_INFO_BTF; then
+	if ! is_set CONFIG_DEBUG_INFO_BTF; then
 		strip_debug=1
 	fi
 
 	vmlinux_link .tmp_vmlinux1
 fi
 
-if is_enabled CONFIG_DEBUG_INFO_BTF; then
+if is_set CONFIG_DEBUG_INFO_BTF; then
 	info BTF .tmp_vmlinux1
 	if ! ${CONFIG_SHELL} ${srctree}/scripts/gen-btf.sh .tmp_vmlinux1; then
 		echo >&2 "Failed to generate BTF for vmlinux"
@@ -230,6 +240,11 @@ if is_enabled CONFIG_DEBUG_INFO_BTF; then
 	fi
 	btf_vmlinux_bin_o=.tmp_vmlinux1.btf.o
 	btfids_vmlinux=.tmp_vmlinux1.BTF_ids
+	if is_module CONFIG_DEBUG_INFO_BTF; then
+		# The btf_vmlinux module carries the BTF; .BTF.link names it and
+		# holds the size and SHA-256 of the BTF (struct btf_link).
+		btf_link="--btf_link .BTF:btf_vmlinux:.tmp_vmlinux1.BTF"
+	fi
 fi
 
 if is_enabled CONFIG_KALLSYMS; then
@@ -287,9 +302,9 @@ fi
 
 vmlinux_link "${VMLINUX}"
 
-if is_enabled CONFIG_DEBUG_INFO_BTF; then
+if is_set CONFIG_DEBUG_INFO_BTF; then
 	info BTFIDS ${VMLINUX}
-	${RESOLVE_BTFIDS} --patch_btfids ${btfids_vmlinux} ${VMLINUX}
+	${RESOLVE_BTFIDS} --patch_btfids ${btfids_vmlinux} ${btf_link} ${VMLINUX}
 fi
 
 mksysmap "${VMLINUX}" System.map
diff --git a/scripts/package/PKGBUILD b/scripts/package/PKGBUILD
index 66e4b6a37783..b66b5e9f1ef1 100644
--- a/scripts/package/PKGBUILD
+++ b/scripts/package/PKGBUILD
@@ -122,6 +122,13 @@ _package-debug(){
 	mkdir -p "${builddir}"
 	ln -sr "${debugdir}/vmlinux" "${builddir}/vmlinux"
 
+	# With CONFIG_DEBUG_INFO_BTF=m only vmlinux.unstripped has the BTF, which
+	# external modules need for theirs (scripts/Makefile.modfinal)
+	if grep -q CONFIG_DEBUG_INFO_BTF=m include/config/auto.conf; then
+		install -Dt "${debugdir}" -m644 vmlinux.unstripped
+		ln -sr "${debugdir}/vmlinux.unstripped" "${builddir}/vmlinux.unstripped"
+	fi
+
 	echo "Installing unstripped vDSO(s)..."
 	${MAKE} INSTALL_MOD_PATH="${pkgdir}/usr" vdso_install
 }
diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index 46e80970f723..c884308d1e85 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -76,6 +76,10 @@ This package provides debug information for the kernel image and modules from th
 %if %{with_keep_section}
 %global _find_debuginfo_opts -r --keep-section .BTF --keep-section .BTF.base
 %else
+%if %{with_btf_vmlinux_module}
+# With CONFIG_DEBUG_INFO_BTF=m, btf_vmlinux.ko carries the vmlinux BTF in .BTF
+%{error:find-debuginfo cannot keep .BTF, which btf_vmlinux.ko needs; build without debuginfo (--without debuginfo)}
+%endif
 %global _find_debuginfo_opts -r
 %endif
 
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index c604f8c174e2..d28d77ef8b73 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -65,6 +65,13 @@ fi
 echo "%define with_debuginfo_manual $with_debuginfo_manual"
 echo "%define with_debuginfo_rpm $with_debuginfo_rpm"
 
+# the btf_vmlinux module must keep its .BTF section (see kernel.spec)
+if grep -q CONFIG_DEBUG_INFO_BTF=m include/config/auto.conf; then
+echo '%define with_btf_vmlinux_module 1'
+else
+echo '%define with_btf_vmlinux_module 0'
+fi
+
 cat<<EOF
 %define ARCH ${ARCH}
 %define KERNELRELEASE ${KERNELRELEASE}
-- 
2.47.3

