Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9097918FDDE;
	Thu,  1 Oct 2026 23:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898359; cv=none; b=NvuE9Gbx5TgTBvpP1IQ0DHdl9R+Nw56yXyJWi8bSSbmvUznAbHRRmeoNC+Yy6gjSioCI0pB9Xoh+MeGHR1YrauoYltJ9KNxCyNRSE5qwOU7jewXJqxIYoeUy3isyeMlSD7nU5bpbf+HDtKyFM0395AW6qDW4T4mwXUKSOYEGSco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898359; c=relaxed/simple;
	bh=onoNW7nSh00pNaqmyI5cO+4kptJg87Xle2/B3cYBvdU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ef8LzVGyvNEXg0AXLM/6mzEfsi3k32jGHFtXA1/QjsTLogIkHH41/qeprgMg3US4XBRBmTsghtYP44hXykIx8HnjrAch0VHD5YLNLzUO6nYIWanSMuroE9B/J8TCb4pFIrvUqc1AHkR78Gf+bBj8q5G9pvynVQEAJx3HS6HyTaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Edikgci7 reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Edikgci7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C131F000FF;
	Thu,  1 Oct 2026 23:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790898357;
	bh=N/LCQOBK04vvpX7fsnv3cF5MDnngFEJQ54ZjbTk1ow8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Edikgci7N6UhxUoFhusp67ABDchjrhdEP10eBeaU+hSxNNWIx63xczuYAyJ3om/Th
	 q6e6OBZY5jCli3+01x38cFuBDqygfQnQXMFlBiILnlkvjMLFEKAC+anYhrpAHgi/Py
	 D+j6Rsl8bRSzYKLSYoPXJXBwLSbHVCT4tjUV8b/u3QAyY8OJsY+SMbUbYDnawJrm+9
	 PsrPNqMBJaV7PRYbvMv9V29pZWqkKm6tFywGGKKOG1xHDQu5UvCN781wp7mhDL2TbG
	 mrcTkjo4+3q0WRiRF0bbYTkWqzyI1/K2qbui5yCk0E5xJY+K7iqxw2MpLw2onqLPEl
	 yexpzZinCtHBA==
Content-Type: multipart/mixed; boundary="===============0210627898918852927=="
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02c101b324038913fe17ddd47d66f51774a541d7ed4d04796e643cee7ee65da7@mail.kernel.org>
In-Reply-To: <20261001225214.12351-5-wanjay@amazon.com>
References: <20261001225214.12351-5-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next v4 04/12] bpf: take the vmlinux BTF from the btf_vmlinux module
From: bot+bpf-ci@kernel.org
To: wanjay@amazon.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: alan.maguire@oracle.com,martin.lau@linux.dev,yonghong.song@linux.dev,jolsa@kernel.org,ihor.solodrai@linux.dev,qmo@kernel.org,nathan@kernel.org,nsc@kernel.org,linux-kbuild@vger.kernel.org,linux@weissschuh.net,christian@heusel.eu,mcgrof@kernel.org,petr.pavlu@suse.com,samitolvanen@google.com,linux-modules@vger.kernel.org,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,linux-trace-kernel@vger.kernel.org,acme@kernel.org,namhyung@kernel.org,irogers@google.com,linux-perf-users@vger.kernel.org,jikos@kernel.org,bentiss@kernel.org,linux-input@vger.kernel.org,tj@kernel.org,void@manifault.com,arighi@nvidia.com,changwoo@igalia.com,sched-ext@lists.linux.dev,shuah@kernel.org,linux-kselftest@vger.kernel.org,ojeda@kernel.org,rust-for-linux@vger.kernel.org,arnd@arndb.de,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,abuehaze@amazon.com,doebel@amazon.de,mpohlack@amazon.de,jay.wang.upstream@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kern
 el.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  1 Oct 2026 23:45:55 +0000 (UTC)

--===============0210627898918852927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: take the vmlinux BTF from the btf_vmlinux module

TL;DR: Retrying __sys_bpf() in bpf() may break BPF_PROG_LOAD: the failed first
run can write the kernel's record size into uattr, so the retry may fail with
-EINVAL instead of -E2BIG and libbpf won't recover.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -6525,10 +6544,40 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
>  	return err;
>  }
>
> +/*
> + * With CONFIG_DEBUG_INFO_BTF=m the vmlinux BTF is loaded on demand, but never
> + * from within a command: loading waits for user space, and a command may hold
> + * locks or run from a BPF program (bpf_sys_bpf()).  A command that needs the
> + * BTF while it is not loaded fails as it would without BTF.  If the command
> + * is one whose failure leaves nothing behind, load the BTF here, on entry
> + * from user space with nothing held, and run the command once more.
> + */

[ ... ]

>  SYSCALL_DEFINE5(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size,
>  		struct bpf_common_attr __user *, uattr_common, unsigned int, size_common)
>  {
> -	return __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common), size_common);
> +	unsigned int misses = bpf_btf_vmlinux_misses();
> +	int err;
> +
> +	err = __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common), size_common);
> +	if (IS_MODULE(CONFIG_DEBUG_INFO_BTF) && err < 0 && bpf_btf_vmlinux_retry(cmd, misses))
> +		err = __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common),
> +				size_common);
> +	return err;
>  }

Is it safe to run __sys_bpf() a second time on the same uattr?  The comment
and the commit message say a failed BPF_PROG_LOAD "leaves nothing behind" and
"fails again the same way", but the first run can write into the caller's
attr.

When the func_info, line_info or core_relo records are larger than the
kernel's struct and have a non-zero tail, the failing run writes the
kernel's record size back into the attr, which is an input field:

kernel/bpf/check_btf.c:
	if (ret == -E2BIG) {
		verbose(env, "nonzero tailing record in func info");
		/* set the size kernel expects so loader can zero
		 * out the rest of the record.
		 */
		if (copy_to_bpfptr_offset(uattr,
				  offsetof(union bpf_attr, func_info_rec_size),
				  &min_size, sizeof(min_size)))

The same happens for line_info_rec_size in check_btf_line() and for
core_relo_rec_size in bpf_check_core_relo().

With CONFIG_DEBUG_INFO_BTF=m, suppose the global miss counter moves while
this load runs.  That happens if any bpf_get_btf_vmlinux() call misses, for
example another process loading BPF, or btf_module_notify() for a module that
is loading.  Suppose the carrier module can also be loaded.  Then
bpf_btf_vmlinux_retry() returns true and the second __sys_bpf() copies the
attr in again.

func_info_rec_size (or line_info_rec_size) now holds the kernel's size, but
the user's func_info/line_info array is still laid out with the original,
larger stride.  prepare_btf_func() and check_btf_line() then read record i
from the wrong offset, landing in the previous record's non-zero tail, and
fail with -EINVAL ("same or smaller insn offset", "Invalid
line_info[%u].insn_off") instead of -E2BIG.

libbpf's bpf_prog_load() recovers from E2BIG only here:

	while (errno == E2BIG && (!finfo || !linfo))

which rebuilds the records with the size the kernel wrote back.  With EINVAL
that path is skipped, so a load that works without this patch (E2BIG, libbpf
trims the records, then success) now fails, and the verifier log shows a
misleading message.

A miss in the same run does not trigger this, because it fails earlier
(attach_btf, CO-RE candidates, kfunc).  Only a concurrent miss before the
vmlinux BTF is first loaded does, for example during boot.

Should the retry be skipped when err == -E2BIG, or more generally when the
first run may have written into uattr?  kernel/bpf/syscall.c is not touched
by later commits in the series, so nothing there changes this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36938681172
--===============0210627898918852927==--
