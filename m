Received: from mta0.migadu.com (out-22.mta0.migadu.com [91.218.175.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A27C86341
	for <linux-input@vger.kernel.org>; Mon,  5 Oct 2026 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226895; cv=none; b=DAIaAlzeoQ3wSXKG6K4enHIv4/c1dxVGLBKOdi5ALwAdzQdTlJx6XU3bLCXAZirjpJCLdDdMdWIGjOIH6G65b+170U2wAZDML8oTWVMZcMWAxn8+langpkKcPL66nF8Rby1sE9NqX7Pp/+3gq1AxR1I8D4M1E3QcGpCgzZX5D1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226895; c=relaxed/simple;
	bh=rJT8G0sgga4UeEHY50WFHahh2k7AQRpW/V4C83LPcM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T++hxqVn/V8H76KlBdRyIxV0VGTzLhNgZRbvHyDElImvve90Wpl2vQD1/LpMHIRlRsZh/4n1ARWt/rXwEWrZp2EOQfhkP3lpwK5FDGvXiZ2dXQyJ57m0cbBWbkib9sLdz4B+/hZjxB81xq1CL9kBoPB6CmZjYhokc62ucKeXtxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rpgOxRCu; arc=none smtp.client-ip=91.218.175.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rpgOxRCu"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rJT8G0sgga4UeEHY50WFHahh2k7AQRpW/V4C83LPcM4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791226891; v=1; x=1791831691;
 b=rpgOxRCuBdRBG9Cruva0qem46KyAXqHLWajd0ZjIRz0kgD8tNqxyOJ2IoAc2uiVFYp0AWqwU
 fYK9s+nOEwPq6TEVKyQTb7ZG9spRm+B0UmWQ9BG569oC3jH+5BUQFc768yIcjo1AEuCsOtbT9Nt
 bjqyL+C+m3j1OwXepyyLRNU0=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3eee9485e3972e9f;
	Mon, 05 Oct 2026 19:01:30 +0000
X-Mizu-Trace-ID: 3eee9485e3972e9f
X-Migadu-Flow: FLOW_OUT
Message-ID: <7844ef03-d9b2-4a10-8f14-1b498ada9043@linux.dev>
Date: Mon, 5 Oct 2026 12:01:17 -0700
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
References: <44315425-c505-46fe-8379-f19d78ff3abb@linux.dev>
 <20261004222127.31128-1-wanjay@amazon.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20261004222127.31128-1-wanjay@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/26 3:21 PM, Jay Wang wrote:
>>    - If I know I don't need BPF on the workload, and these 5.4 MB
>>      bite me, I can just turn off BPF
> 
> They cannot, even when they know they do not need it.  As the cover
> letter says, the cloud provider usually ships one kernel build to all of
> its customers. [...]

Ah, I get it now. Thanks.

So the constraint is that the cloud provider ships a single kernel
revision to all users, and there is currently no mechanism to on/off
BPF other than a kernel build flag.

I'd be tempted to say "just ship two kernels", it's simpler than the
upstream change. But I understand the downsides of that as well.

And obviously a good upstream feature may benefit many more users.

> [...]
>>      Keep zstd-compressed blob in the kernel image and decompress and
>>      parse it synchronously on first use.
> 
> Thanks for putting this forward.  This compression approach is simpler 
> than loading a module.  I expect the overall code complexity to stay similar
> to v3, since both need to find the first user and defer the module BTF parsing
> until then, but it should be easier to merge into mainline because it avoids
> the request_module() deadlocks.
> 
> Would you like to prepare it for a formal submission, or would you
> like me to do so?  Either works for me.  Ideally it lands in time for
> the next LTS kernel, so that we can adopt it there.

Please go ahead and submit the compression approach. Looks like we are
converging on that. Feel free to use the prototype code if it's
useful, it uses parts of your series anyway.

> 
> From what I can see, most of the work left is in that deferral.
> Whoever needs the BTF first also parses the waiting module BTFs and
> replays the queued registrations, struct_ops ->init() included, under
> whatever locks it holds at that point, e.g. event_mutex or
> bpf_verifier_lock, or inside the module notifier.  So the
> cand_cache_mutex ABBA you found may not be the only deadlock.  Besides
> that, only x86_64 was touched so far, so it needs extending to the
> other architectures as well.

Yes, I think you are right that the hard part here is the deferral,
because everything expects vmlinux BTF to just be there.  I don't
think this is avoidable whatever memory saving approach we choose.

