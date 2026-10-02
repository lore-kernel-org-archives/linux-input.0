Received: from mta1.migadu.com (out-213.mta1.migadu.com [95.215.58.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0E35BDAA
	for <linux-input@vger.kernel.org>; Fri,  2 Oct 2026 04:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790915802; cv=none; b=S2FjJSfjXwjdc2Is7izsrN7XPGbDo3rbT6Fm/oCPvaVQ6e/oHzbVSI3Mu86DX3gy2/vatf9XR1wIaMWigrG+ffFCM9+gIBEIvebsZtoyu1TmRrQcfm6pQu5oaVpVbD3gUMS3Xqlwo/uFDjQj3i2x90S/B4nvoD1019Hy1whjp/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790915802; c=relaxed/simple;
	bh=y/0CXx9eIXXSUi0htzgjyz98uoanzac/KLtq3JYsrjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQfCJZVDl8WSDsOr5vNF/s1ija+8soAVsCdyfh0LaPFyLEUCLmN5cQljihAT+0szetoGJqS92lizFCcbMVN//U4IFpQ2DgqcQD/9p/jmQKryZQpknBkx/lEYCx7JUqprwcuG8saw+hFIbYPBL8+5Z6UnUsL7g20K3jJOiydd5k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xP7aSUJC; arc=none smtp.client-ip=95.215.58.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xP7aSUJC"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=y/0CXx9eIXXSUi0htzgjyz98uoanzac/KLtq3JYsrjo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790915796; v=1; x=1791520596;
 b=xP7aSUJCP1VTTt6HWpzfU6gfjbJUEIPtiK8ipSLspAPJnzEqFk/WM+JNBurF6U2QCmVsxMvG
 3PR1iwIg3AKQMVR7+YU7efgObTMGdGBxsTGYBdZZ+wpGtupWp9dgG2wr3Cg9QLQOQHoKY73d1nf
 KBHl4A10s6law16XIbcTgVec=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d68e9918b237ea7b;
	Fri, 02 Oct 2026 04:36:36 +0000
X-Mizu-Trace-ID: d68e9918b237ea7b
X-Migadu-Flow: FLOW_OUT
Message-ID: <596bfb65-db2d-413b-8039-c921031b50fd@linux.dev>
Date: Thu, 1 Oct 2026 21:36:24 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 00/12] bpf: make the vmlinux BTF an on-demand
 loadable module (CONFIG_DEBUG_INFO_BTF=m) to save ~5.4 MB memory
To: Jay Wang <wanjay@amazon.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Quentin Monnet <qmo@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Christian Heusel <christian@heusel.eu>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 linux-perf-users@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 rust-for-linux@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
 Bjoern Doebel <doebel@amazon.de>, Martin Pohlack <mpohlack@amazon.de>,
 jay.wang.upstream@gmail.com
References: <20261001225214.12351-1-wanjay@amazon.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20261001225214.12351-1-wanjay@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-01 3:52 p.m., Jay Wang wrote:
> Based on and tested against bpf-next commit b5a4aa31abd6 ("bpf, cgroup:
> Fix cgroup struct_ops query for a second attach type").
> 
> This series makes CONFIG_DEBUG_INFO_BTF a tristate, so that it can be
> set to =m.  With =m the vmlinux BTF is carried by a module, btf_vmlinux,
> that the kernel loads the first time user space asks for something that
> needs the BTF.  On a system where nothing does, that saves ~5.4 MB of
> RAM with a distribution config; on a system that uses BTF, it behaves as
> with =y.  =y itself is untouched.
> 
> Problem
> -------
> 
> The vmlinux BTF that CONFIG_DEBUG_INFO_BTF=y builds into the kernel
> image takes ~5.4 MB of memory, resident from boot whether anything uses
> it or not.  On small instances that is not negligible.
> 
> A distribution cannot simply turn it off for the users who do not need
> it: it ships one kernel build for all its users, and BTF is not debug
> info anymore.  CO-RE, fentry/fexit, kfuncs, struct_ops, sched_ext and
> bpf-lsm all depend on it, so =n takes those away from everyone who does
> use them.
> 
> Hence this series adds CONFIG_DEBUG_INFO_BTF=m: the BTF becomes an
> on-demand module.  Users who never use BTF get the memory back; for
> users who do, the first request that needs it loads it, and everything
> works as with =y.
> 
> [...]
> 
>   Documentation/bpf/btf.rst                  |   68 ++
>   Makefile                                   |    8 +-
>   include/asm-generic/vmlinux.lds.h          |   32 +-
>   include/linux/bpf.h                        |   15 +
>   include/linux/btf.h                        |   11 +
>   include/linux/btf_ids.h                    |    2 +-
>   include/linux/compiler_types.h             |    2 +-
>   include/linux/module.h                     |    2 +-
>   include/trace/trace_events.h               |    2 +-
>   init/Kconfig                               |    2 +-
>   kernel/bpf/Makefile                        |    6 +-
>   kernel/bpf/bpf_struct_ops.c                |    3 +-
>   kernel/bpf/btf.c                           | 1085 ++++++++++++++++++--
>   kernel/bpf/btf_vmlinux.c                   |   23 +
>   kernel/bpf/inode.c                         |   44 +-
>   kernel/bpf/preload/Kconfig                 |    4 +
>   kernel/bpf/syscall.c                       |   51 +-
>   kernel/bpf/sysfs_btf.c                     |   97 +-
>   kernel/bpf/verifier.c                      |  172 +++-
>   kernel/module/Kconfig                      |    2 +-
>   kernel/module/main.c                       |    4 +-
>   kernel/trace/bpf_trace.c                   |    3 +-
>   kernel/trace/trace_events.c                |   10 +
>   kernel/trace/trace_output.c                |    7 +
>   kernel/trace/trace_probe.c                 |   16 +
>   kernel/trace/trace_syscalls.c              |    6 +-
>   lib/Kconfig.debug                          |   30 +-
>   net/netfilter/Makefile                     |    6 +-
>   net/xfrm/Makefile                          |    4 +-
>   samples/bpf/Makefile                       |    6 +-
>   samples/hid/Makefile                       |    6 +-
>   scripts/Makefile.modfinal                  |   28 +-
>   scripts/Makefile.vmlinux                   |    5 +
>   scripts/gen-btf.sh                         |   53 +-
>   scripts/link-vmlinux.sh                    |   25 +-
>   scripts/package/PKGBUILD                   |    7 +
>   scripts/package/kernel.spec                |    4 +
>   scripts/package/mkspec                     |    7 +
>   tools/bpf/bpftool/Makefile                 |    6 +-
>   tools/bpf/resolve_btfids/main.c            |  217 +++-
>   tools/perf/bpf_skel.mak                    |    8 +-
>   tools/sched_ext/Makefile                   |    6 +-
>   tools/testing/selftests/bpf/Makefile       |    6 +-
>   tools/testing/selftests/hid/Makefile       |    6 +-
>   tools/testing/selftests/sched_ext/Makefile |    6 +-
>   45 files changed, 1936 insertions(+), 177 deletions(-)

This series caught my attention because of the sheer amount of the code
and the iteration speed. I've tried to read the cover (it was
tiresome, please ask your "agent" to be concise), and fed the series
to my bot.

A question I had: is it really worth 2k of complicated kernel code to
*maybe sometimes* save <10Mb of memory?

And then the bot found this:

     What systemd does at every boot

     PID1 loads and attaches a BTF-dependent LSM program at every boot

       src/core/manager.c:1026-1059, in manager_new():

       if (FLAGS_SET(test_run_flags, MANAGER_TEST_RUN_MINIMAL)) {
               ...
       } else {
               ...
               (void) bpf_restrict_fs_setup(m);
       }

https://github.com/systemd/systemd/blob/main/src/core/manager.c#L1026-L1059
https://github.com/systemd/systemd/blob/main/src/core/bpf-restrict-fs.c#L27-L85

Do those tiny VMs that you target run systemd with BPF LSM?
I assume you target concrete VMs, not "small instances" in a vacuum.

You can check this by booting them with =m and then:
   $ lsmod | grep btf_vmlinux
   $ systemctl --version  # look for +BPF_FRAMEWORK
   $ cat /sys/kernel/security/lsm

If the answer is "yes" for the majority of them, the whole project is
moot, because the module will be loaded immediately on boot.

My bot found more stuff implementation-wise...

I suggest to slow down, stop burning tokens for a bit, and first try
to figure out the important details:
   - who will actually benefit from these memory savings and do they care?
   - is it worth it in terms of implementation complexity?

Even for LLM it's easier to deal with a 100 lines of code than with 2k.

pw-bot: cr

>   create mode 100644 kernel/bpf/btf_vmlinux.c
> 
> 
> base-commit: b5a4aa31abd6fe90009b63e35dc18c67d041ec0c

