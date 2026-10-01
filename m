Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3692565192;
	Thu,  1 Oct 2026 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895145; cv=none; b=GUtHKqLu6keC016aliupJG/W0tLUxXZOSp6aUTmRJ8PXuqzjKEGuTNA4Npk77QhraVGE3cP1DtSIgIddXVIwLYe4UsD8e6CtgVyXUTqIJqxDSvBaTKSdNayhOSOMOhwEDceO1oZKC8C16csVM/UjWhEFPA8FGWPNWBbwp4KlvxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895145; c=relaxed/simple;
	bh=iNS3ctST2e9Xi+bNL87CX1oAjR6A8dmz7QBp3BIAx4k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KvqBjpHJQ/WscqW6sfiRb2zDjY1dnGqABClpNr+HiVoCy8aI0qC8Q06wdS0dJe1jZVS7cZA7Yz0wB47sAd2jBjJln9LU5ttc1erb/Ok+IW0DLl9/BhTNPA3vTfKnjuYixQX1v/0ENSU+Q0IIAKIrvT6XR5OutdpT/CuaXehK/oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZnnlJSCV; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZnnlJSCV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790895143; x=1822431143;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nCgCBddihav3QjI3ZfWi2Oon4GbRsUeedJ1MuRysVb0=;
  b=ZnnlJSCVj3RlWJTtnKa+wtvpbeng+PW9s2fsDtdKHiae5SwFWb7oygdv
   NY0nb8JyoRfJJsrbnG1OiCgIIaOt09xrpgqDljNrRdP7koWltk2DpuANe
   J1tZIa4ULQlMhqQSstjM/QlASg/t3fzilc7z/ZERNbNaeP4Oq7lcN4Jkp
   5HaCY/vhU3jD6M67qVAMNj5mfY1vmv7Je9+vfLJLAtbr1Z4V/RDT6StQ9
   az+uryn11uYe/Y0S2wdbet+L6hS92bd3TxHfz6LN6luTe6pFt3E0FeITd
   JKaHchkZqeDqKrhQDc8qUhXJizyz6rRM2XLhWqrj3mUMwbvfIZrLQoLgz
   w==;
X-CSE-ConnectionGUID: QO+29LPnT+e9LlX3DP4nIg==
X-CSE-MsgGUID: jhAQrLZDRbuy/VgSma4EMw==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="30090464"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 22:52:22 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:27125]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.96:2525] with esmtp (Farcaster)
 id db09156d-8e1d-4863-9114-6904bb7f6502; Thu, 1 Oct 2026 22:52:22 +0000 (UTC)
X-Farcaster-Flow-ID: db09156d-8e1d-4863-9114-6904bb7f6502
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:52:22 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:52:21 +0000
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
Subject: [PATCH bpf-next v4 00/12] bpf: make the vmlinux BTF an on-demand loadable module (CONFIG_DEBUG_INFO_BTF=m) to save ~5.4 MB memory
Date: Thu, 1 Oct 2026 22:52:02 +0000
Message-ID: <20261001225214.12351-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Based on and tested against bpf-next commit b5a4aa31abd6 ("bpf, cgroup:
Fix cgroup struct_ops query for a second attach type").

This series makes CONFIG_DEBUG_INFO_BTF a tristate, so that it can be
set to =m.  With =m the vmlinux BTF is carried by a module, btf_vmlinux,
that the kernel loads the first time user space asks for something that
needs the BTF.  On a system where nothing does, that saves ~5.4 MB of
RAM with a distribution config; on a system that uses BTF, it behaves as
with =y.  =y itself is untouched.

Problem
-------

The vmlinux BTF that CONFIG_DEBUG_INFO_BTF=y builds into the kernel
image takes ~5.4 MB of memory, resident from boot whether anything uses
it or not.  On small instances that is not negligible.

A distribution cannot simply turn it off for the users who do not need
it: it ships one kernel build for all its users, and BTF is not debug
info anymore.  CO-RE, fentry/fexit, kfuncs, struct_ops, sched_ext and
bpf-lsm all depend on it, so =n takes those away from everyone who does
use them.

Hence this series adds CONFIG_DEBUG_INFO_BTF=m: the BTF becomes an
on-demand module.  Users who never use BTF get the memory back; for
users who do, the first request that needs it loads it, and everything
works as with =y.

Approach
--------

Do not remove anything, defer it.  The BTF is generated exactly as
before, but with =m it is not part of the kernel image: it is packed
into a module, btf_vmlinux.ko, which the kernel loads itself when the
BTF is first needed.  Once loaded, the BTF stays.

Making that work ran into six problems.  The first is where the module
can be loaded at all; the next three are existing components that rely
on the vmlinux BTF being present from boot, which a loadable module
cannot provide; the last two follow from the BTF no longer being part of
the image.

1. Loading.  Problem: loading btf_vmlinux runs modprobe and waits for
   it, and the module load takes locks of its own (event_mutex, the
   module notifier chain, ...).  bpf_get_btf_vmlinux() and
   bpf_find_btf_id() are called with such locks held, from running BPF
   programs, and with interrupts disabled, so they must not load it.
   Solution: they never do.  With =m they return nothing until the BTF
   is loaded, as on a kernel without BTF, and do not even sleep.  A new
   bpf_load_btf_vmlinux() loads it, and is only called at the start of
   a request from user space, holding no lock that loading a module
   needs: on entry to the bpf() system call, which runs a
   BPF_PROG_LOAD, BPF_MAP_CREATE or BPF_BTF_LOAD that failed for want
   of the BTF once more after loading it, the way tc and nf_tables
   retry after loading a module; for BPF_BTF_GET_NEXT_ID and for
   loading a light skeleton loader; for read() of
   /sys/kernel/btf/vmlinux (mmap(), which runs under the caller's
   mmap_lock, only maps it once it is loaded); and for the tracefs and
   bpffs requests that need the BTF (btf_ids files, probe events with
   BTF arguments, bpffs delegate options that name commands or types).
   It returns once the BTF of the modules loaded before is registered
   too, also to concurrent callers.  Everything else, such as the
   ftrace argument printer, only uses the BTF if it is already there.

2. Verifier.  Problem: bpf_check() fetched the vmlinux BTF for every
   program, so the first socket filter at boot would have needed it on
   every system.  Solution: fetch the BTF only where kernel types enter
   a program (attach_btf, kfunc calls, ksyms, map pointer access,
   helpers that take or return kernel pointers, the program context
   type table).  A program using none of these never touches it.

3. Initcall registrations.  Problem: kfunc, dtor kfunc and struct_ops
   registrations run from initcalls and need the parsed BTF, which
   would again pull it in at boot.  Solution: queue them and apply the
   queue when the BTF is parsed, before it is published, so no program
   can ever see a vmlinux BTF that lacks its kfuncs or struct_ops.

4. Module BTF.  Problem: module BTF is split BTF against the vmlinux
   BTF and was parsed at module load.  A module loaded before the
   vmlinux BTF cannot be parsed yet, and the module notifier cannot
   load btf_vmlinux (that would nest a module load inside a module
   load).  Solution: keep the module's BTF aside (the same copy
   btf_parse_module() makes with =y, so module BTF costs the same in
   both; the saving is the vmlinux BTF only), expose it in
   /sys/kernel/btf right away, and parse and register it, together with
   the module's own kfuncs and struct_ops, once the vmlinux BTF arrives;
   for a module that is still initializing then, before it counts as
   live.  Until that is done, searches of the module BTFs fail and are
   retried rather than miss a module.  Module BTF thus works regardless
   of load order, including out-of-tree modules with a .BTF.base, whose
   sysfs reader waits for the relocation.

5. Trust.  Problem: the verifier treats the BTF as the description of
   the kernel's types, so a carrier from a different build must be
   refused even if vermagic lets it load.  Solution: record the name of
   the carrier and the size and SHA-256 of the BTF in the image, in a
   .BTF.link section that resolve_btfids fills in after the final link,
   and check the module against it when it loads.  The recorded size
   also lets /sys/kernel/btf/vmlinux report its final size before the
   load, which tooling expects.

6. Tooling.  Problem: pahole --btf_base for module BTF and external
   module builds read .BTF from the vmlinux ELF, while no boot image may
   carry it.  Solution: generate module BTF against vmlinux.unstripped,
   which keeps .BTF, and strip it from vmlinux, so that no image made
   from vmlinux carries it; the in-tree tools and samples that generate
   vmlinux.h look for vmlinux.unstripped first, and the pacman and rpm
   packages keep the BTF where it now is.

CONFIG_BPF_PRELOAD is made unavailable with =m: its preloaded programs
attach through the vmlinux BTF, so every bpffs mount, which systemd does
at boot, would load it and defeat the point.

Relation to the inline BTF series
---------------------------------

Alan's inline BTF series [2], now in bpf-next, adds inline function
information to BTF, which is even larger than the BTF itself, and its
cover letter leaves delivering that information on demand, through a
module and sysfs, to a follow-up.  When Alexei suggested taking the
same route for the vmlinux BTF [1], Alan pointed out where the
difficulty would lie [3].

However, that approach cannot be used directly for the vmlinux BTF,
because of what depends on the data:

1. Boot-time consumers.  Nothing needs inline information at boot, so
   loading it late only concerns the sysfs file.  The core vmlinux BTF
   is needed at boot by the verifier, by kfunc and struct_ops
   registrations, and by every module's BTF, and it is looked up from
   contexts that cannot wait for a module to load.  Therefore we need
   to make each of those work without it: the verifier fetches it only
   when a program brings kernel types in, the registrations are queued
   and replayed once it is parsed, and the BTF is loaded only where a
   request from user space starts.  That is most of this series.

2. Module BTF.  Module BTF is split against the vmlinux BTF, so a module
   loaded before it has nothing to be parsed against, and the module
   notifier cannot load btf_vmlinux itself.  Therefore we need to keep
   the module's BTF aside, create its sysfs file right away, and parse
   and register it once the vmlinux BTF arrives; the file of a module
   built against a distilled base (.BTF.base) serves it once relocated,
   the others serve the raw bytes as they are.  Alan named this as the
   hard part; it works here regardless of whether the module loads
   before or after the vmlinux BTF.

The inline information would get a carrier module of its own when that
follow-up comes, since a system may want the one but not the other, and
share the rest: Alan proposed the .BTF.link record and the resolve_btfids
option that fills it in [7] with both in mind, and this series uses them
as proposed (patch 10 is his).

Patches Structure
-----------------

Patch 1 (refactor, no functional change): btf_parse_module() takes the
vmlinux BTF as an argument and can adopt an existing copy of the module
BTF data instead of duplicating it.  Needed so that module BTF kept
aside at load time can be parsed later without moving the buffer the
sysfs file points at.

Patch 2 (refactor, no functional change): splits the kfunc, dtor kfunc
and struct_ops registration functions into "find the BTF for the owner"
and "add the registration to this BTF", so the second half can be
replayed on a queued registration.

Patch 3 (verifier): stops fetching the vmlinux BTF up front in
bpf_check() and fetches it where kernel types enter a program instead.
Adds bpf_peek_btf_vmlinux() for the helpers that run in program
context.  With =y the BTF is parsed at boot anyway, so this is
invisible there.

Patch 4 (carrier and loading): the runtime side of taking the vmlinux
BTF from the btf_vmlinux module: copy it out of the module in the BTF
module notifier after checking it against .BTF.link (struct btf_link:
the carrier's name, and the size and SHA-256 of the BTF);
bpf_get_btf_vmlinux() never loads it, bpf_load_btf_vmlinux() does, from
the bpf() system call entry (with the retry), BTF_GET_NEXT_ID, light
skeleton loaders and read() of /sys/kernel/btf/vmlinux, which has its
size known from boot; mmap() only maps it once it is loaded.  All under
IS_MODULE(CONFIG_DEBUG_INFO_BTF), so unreachable until patch 12.

Patch 5 (tracing, bpffs): loads the BTF at the start of the tracefs and
bpffs requests that need it (btf_ids, probe events with BTF arguments,
bpffs delegate options that name commands or types), before event_mutex
where that matters; the ftrace argument printer and bpffs show_options
only use it if it is there.

Patch 6 (vmlinux registrations): queues kfunc, dtor kfunc and struct_ops
registrations for vmlinux made from initcalls and applies them when the
BTF is parsed, before it is published, by pointer or by id.

Patch 7 (module BTF): keeps the BTF of modules loaded before the vmlinux
BTF, with their own queued registrations, and parses, registers and
publishes it when the vmlinux BTF arrives, before a module that is still
initializing counts as live; bpf_load_btf_vmlinux() returns once that is
done, and searches of module BTFs meanwhile fail and are retried.

Patch 8 (.BTF.base sysfs): gives such a module with a .BTF.base its
/sys/kernel/btf file from load, with a reader that waits for the
relocation.  Patches 4-8 are unreachable until patch 12.

Patch 9 (preparation, no functional change): the #ifdef, Makefile and
Kconfig checks of CONFIG_DEBUG_INFO_BTF that must hold for both =y and
=m use IS_ENABLED(), $(subst m,y,...) and DEBUG_INFO_BTF=n, in bpf,
tracing, netfilter, xfrm, Rust and modules.

Patch 10 (resolve_btfids, Alan's): a --btf_link
<section>:<module>:<raw BTF file> option for the final --patch_btfids
pass, which fills in the <section>.link record: the module name, and the
SHA-256 and size of the BTF, in the byte order of the ELF file.

Patch 11 (tools, samples): the in-tree tools and samples that generate
vmlinux.h from a build tree (bpftool, the bpf, hid and sched_ext
selftests, sched_ext, samples/bpf and hid, perf) look for
vmlinux.unstripped before vmlinux, which has no .BTF with =m; with =y
both have the same BTF.

Patch 12 (kbuild and Kconfig): makes CONFIG_DEBUG_INFO_BTF a tristate;
with =m links .BTF into vmlinux as a non-loadable section, has
resolve_btfids fill in .BTF.link after the final link, builds
btf_vmlinux.ko with the vmlinux .BTF as its payload, strips .BTF from
vmlinux (module BTF is generated against vmlinux.unstripped), keeps the
BTF in the pacman and rpm packages, excludes CONFIG_BPF_PRELOAD, and
documents the option.

Patches 1-3 and 9-11 are independently useful or neutral; 4-8 are dead
code until 12 flips the switch, which keeps each bisect step building
and behaving as before.

Testing
-------

Tested with 1 GiB of memory, same tree, =y against =m, both with
CONFIG_DEBUG_INFO_BTF_MODULES=y.  The on-demand behaviour is easy to
see by hand on an =m kernel:

  # lsmod | grep btf_vmlinux
      -> nothing: the BTF is not loaded at boot.
  # ls -la /sys/kernel/btf/vmlinux
      -> the file exists with its final size (from .BTF.link), although
         the BTF behind it is not loaded yet.
  # modprobe ext4 nf_conntrack
  # ls /sys/kernel/btf/
      -> ext4, nf_conntrack, ... appear immediately, although their
         BTF is only kept aside, not parsed: there is no vmlinux BTF to
         parse it against yet.
  # lsmod | grep btf_vmlinux
      -> still nothing: loading modules does not load the vmlinux BTF.
  # cat /sys/kernel/btf/ext4 > /dev/null
  # lsmod | grep btf_vmlinux
      -> still nothing: a module's BTF file is served from the raw copy,
         reading it does not need the vmlinux BTF.
  # grep VmallocUsed /proc/meminfo
      -> baseline.
  # cat /sys/kernel/btf/vmlinux > /dev/null
  # lsmod | grep btf_vmlinux
      -> btf_vmlinux ... [permanent]: the first use loaded it, and it
         cannot be unloaded.
  # grep VmallocUsed /proc/meminfo
      -> up by ~5.5 MB: the BTF copy, allocated only now.
  # bpftool btf list
      -> vmlinux and every loaded module now have BTF ids; the modules
         loaded before were parsed and registered on the way.

The same with an out-of-tree module (built with M=, so its BTF is split
against a distilled base, .BTF.base), on a fresh boot:

  # insmod btf_extmod.ko
  # ls -la /sys/kernel/btf/btf_extmod
      -> the file exists with its final size, although the BTF behind
         it is only valid once relocated against the vmlinux BTF.
  # lsmod | grep btf_vmlinux
      -> nothing: loading the module does not load the vmlinux BTF.
  # cat /sys/kernel/btf/btf_extmod > /dev/null
  # lsmod | grep btf_vmlinux
      -> btf_vmlinux ... [permanent]: reading this file loaded the
         vmlinux BTF, relocated the module's BTF and then returned it.
  # bpftool btf dump file /sys/kernel/btf/btf_extmod
      -> the module's own types, resolved against the vmlinux BTF.
  # rmmod btf_extmod
      -> unloads normally; its file goes away with it.

Results:

 - MemTotal is ~5.4 MB higher with =m while the BTF is unused, which is
   the size of the .BTF section.  Once the BTF is in use, MemFree is the
   same within run-to-run noise.
 - Each of these, as the first user of the BTF on a fresh boot, loads it
   and works: a kprobe program calling bpf_get_current_task_btf(), a
   syscall program calling kfuncs, a struct_ops map for
   tcp_congestion_ops, BTF and an array map with a kptr to task_struct,
   a light skeleton loader, read() of /sys/kernel/btf/vmlinux, libbpf's
   access to it (its mmap() fails until the BTF is loaded and it reads
   instead), BPF_BTF_GET_NEXT_ID, kprobe events with BTF arguments
   (argument names, $retval, $current), a tracepoint's btf_ids file, a
   bpffs mount with delegate options that name commands, and four such
   programs loaded at once.  With the in-tree bpftool and
   clang-built programs: bpftool btf dump and btf list, a socket filter
   with a global subprogram taking struct __sk_buff *, a raw_tp program
   calling bpf_snprintf_btf(), a CO-RE field read, and a program calling
   a kfunc of an out-of-tree module loaded before the vmlinux BTF.
 - A socket filter, and one that fails verification, do not load it;
   neither do bpffs mounts with delegate_*=any or hex masks,
   /proc/self/mountinfo with bpffs delegate options, the ftrace
   argument printer (also from sysrq-z), and BPF_BTF_GET_NEXT_ID
   without CAP_SYS_ADMIN.
 - Six BPF_BTF_GET_NEXT_ID users and a module tracepoint's btf_ids read,
   started at once right after modules were loaded, all see every
   module BTF.  A module whose kfunc registration was still queued,
   because the BTF arrived during its init, has a working kfunc once it
   is live.
 - Without btf_vmlinux.ko installed, the program, sysfs, BTF id, kptr,
   btf_ids and probe event cases fail or degrade as on a kernel without
   BTF, without delay (a btf_ids file tries once, not once per read);
   once it is installed, the next request loads it.
 - Modules loaded before the trigger (ext4, nf_conntrack, which
   registers kfuncs from its init, xfrm_interface) get BTF ids once the
   BTF is loaded; nf_nat loaded afterwards takes the usual path.
 - stat() of /sys/kernel/btf/vmlinux reports the final size before the
   load; fstat/read/mmap agree afterwards.
 - A carrier with one byte of .BTF changed is refused with -EINVAL.
   The .BTF.link of the kernel names btf_vmlinux and matches the BTF in
   btf_vmlinux.ko, size and SHA-256, on x86-64, on an i386 build and on
   an LLVM=1 build (clang and ld.lld 19).
   resolve_btfids --btf_link fills in the record of 32- and 64-bit,
   little- and big-endian objects (arm, m68k, parisc, arm64, riscv64,
   x86-64), also with two links in one run, and fails with a message
   on a missing or wrongly sized section, a missing or empty BTF file,
   or a module name that does not fit.
 - lockdep and kmemleak kernels are clean in all of the above.
 - =y and =n build and behave as before; =m without module BTF works;
   every patch builds on its own.  make localmodconfig keeps =m when
   btf_vmlinux is loaded; bpftool built from an =m tree takes its
   vmlinux.h from vmlinux.unstripped; the rpm spec refuses a debuginfo
   build whose find-debuginfo cannot keep .BTF.
 - The boot image on disk shrinks by the compressed BTF with =m
   (15.0 MB to 13.2 MB here).

Changes since v3 [6]:

 - Reworked where the BTF gets loaded (Alexei).  v3 loaded it from
   bpf_get_btf_vmlinux() and bpf_find_btf_id(), whose callers were not
   written for a function that waits for user space: the btf_ids file
   under event_mutex, the ftrace argument printer with interrupts off.
   Now neither of them loads; bpf_load_btf_vmlinux() does, only at the
   start of a request from user space, and the bpf() system call runs
   PROG_LOAD, MAP_CREATE or BTF_LOAD once more if it failed for want of
   the BTF (patch 4).  The tracefs and bpffs entry points moved to a
   patch of their own (patch 5).  The CO-RE candidate lookup is back to
   the upstream code: it fetched the BTF before cand_cache_mutex only
   because fetching could load it.
 - A light skeleton loader loads programs from within the running
   program, so it must not rely on them loading the BTF; bpf() loads it
   when user space loads the loader (patch 4).  This also covers
   bpf_btf_find_by_name_kind().
 - Patch 8: the sysfs reader of a kept .BTF.base module no longer loads
   the vmlinux BTF itself but has a work item do it: it holds the file's
   kernfs active reference, which MODULE_STATE_GOING drains with the
   module notifier chain held, and loading btf_vmlinux needs that chain
   (bpf-ci).
 - Patch 8: a kept .BTF.base module whose BTF then fails to parse no
   longer holds on to its raw BTF until it is unloaded; its reader never
   serves that data (Sashiko).
 - Patch 5: the tracefs btf_ids file loads the vmlinux BTF before taking
   event_mutex, which btf_vmlinux's trace module notifier takes; the
   ftrace function argument printer (func-args, funcgraph-args) never
   loads it, it runs from ftrace_dump() with interrupts disabled
   (bpf-ci).
 - Patch 4: with =m only an allocation failure of the vmlinux BTF parse
   is retried, a broken BTF is remembered as with =y; and
   /sys/kernel/btf/vmlinux serves the raw BTF even if it does not parse,
   as with =y (bpf-ci).
 - Patch 4: BPF_BTF_GET_NEXT_ID only loads the BTF for callers that may
   enumerate BTF ids (CAP_SYS_ADMIN).
 - Patch 4: mmap() of /sys/kernel/btf/vmlinux does not load the BTF: it
   runs under the caller's mmap_lock, a uprobe registration holds
   event_mutex while it takes the mmap_lock of every mm that maps the
   probed file, and the module load takes event_mutex.  It fails until
   the BTF is loaded; libbpf then falls back to read().
 - Patch 7: bpf_load_btf_vmlinux() returns only once the BTF of the
   modules loaded before it is registered, also to concurrent callers;
   until then, searches of the module BTFs by name fail and are retried,
   so a kptr to a module type is not taken for a local one and
   BPF_BTF_GET_NEXT_ID does not miss a module.
 - Patches 6-7: the registrations a module made while initializing are
   applied before it counts as live, in order, and applying loops, as
   for vmlinux; the vmlinux BTF and the kept module BTF have their ids
   reserved before their registrations are applied, and installed after.
   A module whose BTF cannot be kept for lack of memory fails to load,
   as with =y.
 - Patch 5: bpffs delegate_*=any and numeric masks do not load the BTF;
   a btf_ids file loads it on the first read only.
 - Patch 5: bpffs shows its delegate_* options (/proc/*/mountinfo, under
   namespace_sem) without loading the BTF.
 - Patches 6-7: the comment and changelog on the vmlinux registration
   queue's lock state the current reason (bpf-ci); when the vmlinux BTF
   fails to parse for good, the queued vmlinux registrations are freed
   and the queue closed, and the kept module BTF entries become dead,
   instead of waiting for ever.
 - Patches 4, 10, 12: the record of the BTF in the image is a section
   named .BTF.link, after .gnu_debuglink, laid out as Alan proposed for
   this series and the inline BTF follow-up alike [7] (struct btf_link:
   the carrier's module name, the SHA-256 and the size of the BTF).
   resolve_btfids fills it in when it patches .BTF_ids after the final
   link, with Alan's --btf_link option (patch 10), instead of gen-btf.sh;
   the kernel takes the name of the module to load from it.  The zeroed
   record is defined in C next to struct btf_link, so the first link
   needs no placeholder object, and resolve_btfids checks that the
   section has the size of the record (Alan).
 - Patch 12: changelog and btf.rst name what does not work with =m as
   with =y (BPF_PRELOAD, users before btf_vmlinux.ko can be loaded, the
   vmlinux BTF id) and list the requests that load the BTF (bpf-ci);
   they also name module loading policy, the check of the BTF of
   modules loaded before it, and tools that look for the BTF in memory.
 - Patch 11 (new): the in-tree tools and samples take the vmlinux BTF
   from vmlinux.unstripped first.  Patch 12: the pacman debug package
   ships vmlinux.unstripped with =m, the rpm spec refuses a debuginfo
   build that would strip the .BTF of btf_vmlinux.ko,
   make localmodconfig maps btf_vmlinux.ko to its option, and the build
   checks that the carrier got a BTF.
 - Rebased onto current bpf-next.

Changes since v2 [5]:

 - Rebased onto current bpf-next; v2 no longer applied there.
 - Patch 8: the RUST and GENDWARFKSYMS pahole restrictions, written as
   "depends on !DEBUG_INFO_BTF", now say DEBUG_INFO_BTF=n, so they
   still hold with =m (found while checking the Sashiko question on
   bool options depending on DEBUG_INFO_BTF, which Kconfig handles:
   a bool whose dependency is m can still be y).

Changes since v1 [4]:

 - Split for review: v1 patch 5 is now patches 5-7 (vmlinux
   registrations, module BTF, .BTF.base sysfs), v1 patch 6 is now
   patches 8-9 (preparation of the existing checks, the switch).
 - Fetch sites added for the program context type table
   (bpf_ctx_convert: global subprograms taking the context, ctx access
   of tracing/EXT programs), for bpf_snprintf_btf()/bpf_seq_printf_btf()
   and for CO-RE candidate lookup, which now fetches before taking
   cand_cache_mutex (Sashiko, bpf-ci, Jiri).  Without
   CONFIG_DEBUG_INFO_BTF the new helper check is skipped, so nothing
   changes there.
 - Module BTF is published only after its deferred registrations are
   applied; only modules past MODULE_STATE_LIVE are replayed, with the
   module pinned; a module still in init has its queue applied at LIVE.
   Fixes the concurrent registration and COMING-module lifetime issues
   (Sashiko, bpf-ci).
 - The sysfs reader of a module with .BTF.base waits for the module's
   BTF to be relocated instead of serving the raw data (bpf-ci); sysfs
   files are no longer removed from the deferred parse path, and
   MODULE_STATE_GOING removes them outside btf_module_mutex.
 - A module whose deferred BTF fails to parse or get an id keeps the
   buffer its sysfs file serves; nothing is freed under a reader
   (Sashiko).
 - The vmlinux registration queue has its own mutex; no lock is taken
   under btf_vmlinux_lock that leads back to it (bpf-ci).
 - A failed parse is not cached with =m (Sashiko).
 - Only the carrier depends on vmlinux in Makefile.modfinal; POSIX dd
   instead of head -c (Sashiko).
 - .BTF stripped from vmlinux with =m, so no boot image carries it,
   also where the image is an ELF copy of vmlinux; module BTF is
   generated against vmlinux.unstripped (Alan).
 - Kconfig help: initramfs note, module BTF accounting (Alan).
 - btf_struct_ops_add() renamed btf_struct_ops_register() (bpf-ci);
   its stub only defined where used.
 - Tests with bpftool/libbpf userspace and an out-of-tree .BTF.base
   module added (Alan).

[1] https://lore.kernel.org/all/20260917000201.25581-2-wanjay@amazon.com/
[2] https://lore.kernel.org/bpf/20260916074118.1007116-1-alan.maguire@oracle.com/
[3] https://lore.kernel.org/all/33592fca-88a8-44aa-8d94-40e1e604554e@oracle.com/
[4] https://lore.kernel.org/bpf/20260923053948.30617-1-wanjay@amazon.com/
[5] https://lore.kernel.org/bpf/20260925211314.5118-1-wanjay@amazon.com/
[6] https://lore.kernel.org/bpf/20260925224229.1850-1-wanjay@amazon.com/
[7] https://lore.kernel.org/bpf/dbbb6cde-9889-4445-abf6-0486c380925d@oracle.com/

Alan Maguire (1):
  resolve_btfids: add --btf_link to fill in .BTF.link records

Jay Wang (11):
  bpf: pass the vmlinux BTF to btf_parse_module() and let it adopt the
    data
  bpf: split the kfunc, dtor kfunc and struct_ops registration bodies
  bpf: fetch the vmlinux BTF where kernel types enter a program
  bpf: take the vmlinux BTF from the btf_vmlinux module
  bpf, tracing: load the vmlinux BTF where tracefs and bpffs requests
    start
  bpf: defer vmlinux kfunc and struct_ops registrations
  bpf: keep module BTF until the vmlinux BTF is available
  bpf: expose deferred .BTF.base module BTF in sysfs from module load
  bpf, trace, net: prepare CONFIG_DEBUG_INFO_BTF checks for a tristate
  tools, samples: take the vmlinux BTF from vmlinux.unstripped first
  kbuild, bpf: allow building the vmlinux BTF as a module

 Documentation/bpf/btf.rst                  |   68 ++
 Makefile                                   |    8 +-
 include/asm-generic/vmlinux.lds.h          |   32 +-
 include/linux/bpf.h                        |   15 +
 include/linux/btf.h                        |   11 +
 include/linux/btf_ids.h                    |    2 +-
 include/linux/compiler_types.h             |    2 +-
 include/linux/module.h                     |    2 +-
 include/trace/trace_events.h               |    2 +-
 init/Kconfig                               |    2 +-
 kernel/bpf/Makefile                        |    6 +-
 kernel/bpf/bpf_struct_ops.c                |    3 +-
 kernel/bpf/btf.c                           | 1085 ++++++++++++++++++--
 kernel/bpf/btf_vmlinux.c                   |   23 +
 kernel/bpf/inode.c                         |   44 +-
 kernel/bpf/preload/Kconfig                 |    4 +
 kernel/bpf/syscall.c                       |   51 +-
 kernel/bpf/sysfs_btf.c                     |   97 +-
 kernel/bpf/verifier.c                      |  172 +++-
 kernel/module/Kconfig                      |    2 +-
 kernel/module/main.c                       |    4 +-
 kernel/trace/bpf_trace.c                   |    3 +-
 kernel/trace/trace_events.c                |   10 +
 kernel/trace/trace_output.c                |    7 +
 kernel/trace/trace_probe.c                 |   16 +
 kernel/trace/trace_syscalls.c              |    6 +-
 lib/Kconfig.debug                          |   30 +-
 net/netfilter/Makefile                     |    6 +-
 net/xfrm/Makefile                          |    4 +-
 samples/bpf/Makefile                       |    6 +-
 samples/hid/Makefile                       |    6 +-
 scripts/Makefile.modfinal                  |   28 +-
 scripts/Makefile.vmlinux                   |    5 +
 scripts/gen-btf.sh                         |   53 +-
 scripts/link-vmlinux.sh                    |   25 +-
 scripts/package/PKGBUILD                   |    7 +
 scripts/package/kernel.spec                |    4 +
 scripts/package/mkspec                     |    7 +
 tools/bpf/bpftool/Makefile                 |    6 +-
 tools/bpf/resolve_btfids/main.c            |  217 +++-
 tools/perf/bpf_skel.mak                    |    8 +-
 tools/sched_ext/Makefile                   |    6 +-
 tools/testing/selftests/bpf/Makefile       |    6 +-
 tools/testing/selftests/hid/Makefile       |    6 +-
 tools/testing/selftests/sched_ext/Makefile |    6 +-
 45 files changed, 1936 insertions(+), 177 deletions(-)
 create mode 100644 kernel/bpf/btf_vmlinux.c


base-commit: b5a4aa31abd6fe90009b63e35dc18c67d041ec0c
-- 
2.47.3

