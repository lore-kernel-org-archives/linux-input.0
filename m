Received: from mta1.migadu.com (out-94.mta1.migadu.com [95.215.58.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3E438655D
	for <linux-input@vger.kernel.org>; Fri,  2 Oct 2026 20:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790974708; cv=none; b=M9bpMAazUuKdX1ygakU6J4/jGr3Dxw0uXbhVPxWqrtRv7gNstd6KJ13Hz8L9DVD0dl8BGkhKcz3NqFEIO+k3ItTQtfy+CzT91bvZn3fOwtgSlGX4HycSqw0w//6l1E06PJhzAuq7Ockjwx6dDxz1DSQhFm71J8UW9TAK7BIi2Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790974708; c=relaxed/simple;
	bh=cyE7xCmOBBATCOr27hlaYfNiIVy0ZG/W7o34fqS3PW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1xUuSeFJYz7NqeRzpcwC1HjzdJoBTyKcrIA3oMBCordSf//gWQAg9cZcHnPRUW6H7BjqDJS91jEOxoijJq2xlH+WBId2kb1dfSe322fC80CRmbXiHHpqND7iFF76YKHJ6AIPFpajZ2g6AUb8SaegYNBOwzlHP9e3fGjtTdJPFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ax+vZviq; arc=none smtp.client-ip=95.215.58.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ax+vZviq"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cyE7xCmOBBATCOr27hlaYfNiIVy0ZG/W7o34fqS3PW0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790974701; v=1; x=1791579501;
 b=ax+vZviqSRu1XPDQEGrAVT+HGPvUUq/pOwLuAN59kN0XrzQ0GMdPmtqRWmTKqVzKLzBFj5Ar
 VG1+QumlCqDH0np/SydZbLM0hXAuBSkFKaLCyQbsm1jdTGV5zx+j/MyZ/bTFOv3Nuf3mCl8oU/r
 diH3WnacJGosTjeavKbQZdXQ=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 16a5b7b703a7aea2;
	Fri, 02 Oct 2026 20:58:20 +0000
X-Mizu-Trace-ID: 16a5b7b703a7aea2
X-Migadu-Flow: FLOW_OUT
Message-ID: <44315425-c505-46fe-8379-f19d78ff3abb@linux.dev>
Date: Fri, 2 Oct 2026 13:58:06 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 00/12] bpf: make the vmlinux BTF an on-demand
 loadable module (CONFIG_DEBUG_INFO_BTF=m) to save ~5.4 MB memory
To: Jay Wang <wanjay@amazon.com>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: alan.maguire@oracle.com, martin.lau@linux.dev, yonghong.song@linux.dev,
 jolsa@kernel.org, qmo@kernel.org, nathan@kernel.org, nsc@kernel.org,
 linux-kbuild@vger.kernel.org, linux@weissschuh.net, christian@heusel.eu,
 mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com,
 linux-modules@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 linux-perf-users@vger.kernel.org, jikos@kernel.org, bentiss@kernel.org,
 linux-input@vger.kernel.org, tj@kernel.org, void@manifault.com,
 arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, arnd@arndb.de, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, abuehaze@amazon.com, doebel@amazon.de,
 mpohlack@amazon.de, jay.wang.upstream@gmail.com
References: <596bfb65-db2d-413b-8039-c921031b50fd@linux.dev>
 <20261002073422.14253-1-wanjay@amazon.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20261002073422.14253-1-wanjay@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jay, thank you for taking the time to reply.

On 2026-10-02 12:34 a.m., Jay Wang wrote:
>> A question I had: is it really worth 2k of complicated kernel code to
>> *maybe sometimes* save <10Mb of memory?
> 
> There are many reasons this is worth it.  The main ones:
> 
> 1. This did not start from a number we picked, but from a real use
>     case: users who run large fleets of small instances, 1 GiB of
>     memory or less, with their workloads sized to fit.  We are not able
>     to disclose more detail, but for them 5.4 MB on every instance is
>     real money, and it can be exactly what pushes a workload over its
>     memory budget and onto the next instance size.  That is why we took
>     this on, even though we knew it would not be a small change.

Ok, good to know there is a real customer for this.

Obviously I don't know any details of the use-case apart from what
you've shared. But bear with me trying the customer's hat on:

   - I am running a workload on a legion of 1GiB instances
   - I care about memory footprint a lot, because it directly
     translates into the amount of compute I pay for
   - If I know I don't need BPF on the workload, and these 5.4 MB
     bite me, I can just turn off BPF
   - If I know I need BPF, then those 5.4 MB must be loaded anyways, so
     I have to look for savings elsewhere

What I find strange is for a user of this scale *to not know* whether
BPF will be used in the workload or not, which is what lazy load may
solve.

One thing I can imagine is an opaque workload: untrusted (AI agents
etc), end-user-defined (including BPF usage), or confidential.  But in
these cases, what are the chances that BPF is used there? They are
high, BPF is very widespread.

I can also imagine normal workload not needing BPF, but when something
goes wrong an observability or security thing turning on that loads
BPF programs. But this contradicts the "5.4 MB may push workload over
1GiB" premise: you still need to reserve/swap memory for just-in-time
BPF-based tools, otherwise you OOM.

I of course may be missing something, happy to be corrected.

> 
> 2. Loading code and data only when a system needs them is what kernel
>     modules exist for.  And most of them take well under ~1 MB once
>     loaded (nf_conntrack, overlay, vfat); even big ones like ext4, kvm
>     and btrfs stay around 1-2.5 MB.  The vmlinux BTF is 5.4 MB.

True. At the same time BPF without vmlinux BTF is barely useful. And
it is trusted by the verifier. Both are addressed by BTF being
built-in in the kernel image.

> 
> 3. We are not alone in trying to keep BTF out of memory until it is
>     needed.  The inline BTF work [1] plans to deliver its data, which
>     is even larger, through a module too.  The .BTF.link record and the
>     resolve_btfids option that serve both are already part of this
>     series (patch 10), so this is not machinery for the vmlinux BTF
>     alone.

The inline data is different. It's bigger by it's nature, and it has
more specific users: tracing tools. The userspace tools are able to
themselves decide whether to use that data. The kernel only needs to
make it available.

In comparison, as you yourself noted in the cover:

     CO-RE, fentry/fexit, kfuncs, struct_ops, sched_ext and bpf-lsm
     all depend on vmlinux BTF

> 
>> Do those tiny VMs that you target run systemd with BPF LSM?
> 
> Not necessarily, and that is the image's choice.  Even with BPF LSM
> built in and bpf in CONFIG_LSM, memory-conscious users can turn it off
> at boot with an lsm= list that leaves it out, and then systemd does not
> load restrict_fs at all.
> 
> And even where user space is in the way, which as above it does not
> have to be, the answer is to fix user space so it gets this win too,
> not to give up on it.
> 
>> If the answer is "yes" for the majority of them,
> 
> "The majority" is also hard to pin down here: what runs at boot
> depends on the user space packages built into each image, and on the
> workload.

Yes, it is hard to pin down. Which is why we first need to figure out
whether the alleged memory savings actually help anyone.

Adding code to the kernel is not free. More complexity means bigger
bug surface: more opportunities for concurrency bugs, security bugs
etc. Especially runtime loads with retries and stuff. I'm sure you
understand the future cost of all that.

So the bias shouldn't be "let's implement a big thing that might
hypothetically help someone". It's backwards IMO.

> 
> So the question should be what it takes to make this work, not whether
> to drop it because it is complicated.  If there are ways to cut it
> down, or issues found in the implementation, we would be happy to take
> them and go through every one.

The question is in the trade-off.

Would you run a million line python program to search for a string in
a text file? No, that's absurd. But you could.

I'm not saying 2k line patch series is unacceptable in principle. It
may be justified. But I am not convinced it is justified in this case.

Let's say we (as in kernel devs) decided that we want to reduce
vmlinux BTF size, and only load it when necessary. Here are a couple
of alternatives, simpler in comparison to CONFIG_DEBUG_INFO_BTF=m,
although still a bit complex:

   * Compress it.

     $ ls -lah /sys/kernel/btf/vmlinux
     -r--r--r-- 1 root root 6.7M Jul 18 01:54 /sys/kernel/btf/vmlinux
     $ tar --zstd -cf /tmp/vmlinux.btf.zstd -C /sys/kernel/btf vmlinux
     $ ls -lah /tmp/vmlinux.btf.zstd
     -rw-r--r-- 1 isolodrai users 2.2M Oct  2 10:11 /tmp/vmlinux.btf.zstd

     3x win right there.

     Keep zstd-compressed blob in the kernel image and decompress and
     parse it synchronously on first use.

     Here is a prototype (vibe-coded, obviously):
  
https://github.com/kernel-patches/bpf/compare/bpf-next_base...theihor:bpf:vmlinux.btf.zstd-20261002

   * Use an external blob.

     Ship /lib/modules/$r/vmlinux.btf, checked against a SHA-256
     recorded in the image. The catch is a synchronous file I/O under
     caller locks, so this is less straightforward.
     But this should cover embedded case that Alan has mentioned.

     Here is a prototype:
  
https://github.com/kernel-patches/bpf/compare/bpf-next_base...theihor:bpf:vmlinux.btf.external-20261002

Both alternatives avoid kernel-module loading machine. If we think
harder, we may come up with something even more clever.

I don't particularly prefer one approach over the other, including the
module one. Maintainers probably have a better intuition on that.

The point I'm trying to make is that if you could achieve similar
memory savings with say 500-line well encapsulated diff (or even
better: by refactoring, simplifying, deleting code) it would have
already landed.

And if it was a 50-line patch, the discussion on whether anyone cares
wouldn't be relevant, because it's so cheap.

As it stands, it's not clear (to me at least) in what circumstances
we'll get the promised memory savings at all.

> 
> 
> [1] https://lore.kernel.org/bpf/20260916074118.1007116-1-alan.maguire@oracle.com/

