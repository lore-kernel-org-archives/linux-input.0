Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FE828CF52;
	Wed, 21 Jan 2026 00:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955423; cv=none; b=M/E90NYu/t0Fe32lpjjdJ+vcRpJIEcxvlNvO/E0FOLlM7GognW/6sxkPQSe3AuLVi0v5sBh2ibYBbN4MwpiYIcCpi6FVnm3cJ702wfbcNGDNcjKqna+yAXJvaiN+1+eB77vGqs8BK65ysjVFHu2l5QAHGrYkICcrc4773sCOLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955423; c=relaxed/simple;
	bh=7ew0OeFA5OWg7NT/ep6GgikhWR8sE1QTqvlos0exUls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=keeO/MM49vftxONOj6j4fC/qQy/dZIUog/CmT/vDuAujh7yeK/thLAWdJd637IpSLgN0VdzHqyu1mKa87bQ0nxdl8Y9vIy/6RPvNTkmcrfNGmpP8YuP7ZPQhkGli4vpjKHxQCaU1RTFpIypKcSYq41ih1VgL+Y9oJOerPtLb784=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2meccM4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2meccM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8328C16AAE;
	Wed, 21 Jan 2026 00:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768955422;
	bh=7ew0OeFA5OWg7NT/ep6GgikhWR8sE1QTqvlos0exUls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C2meccM4kxo4xRmmRErh43h/g4YPKKnioPjFgbvTp2kj6qrSKFMjfWYj2wV+uuDXZ
	 z8NbkRSSrMmsHL2yboS+IsZZglX6lmwBDfGNM7bEfLa1M4CJ7+SUawtt8yhrDnFjyK
	 IHETW0Aw28W6ly7CqJha2eZGe6kmRbdmXx4PqhZNaJM2ZrY1wILSZgCuXNJnLTELjF
	 /scSPgXjUj+gw6YtE39Et3Ymu9NWmqVnWYKbnaaI9scIq4ptvyVo5UQT/4aKj/dtn1
	 8KwF6VmxnVGUfWP/kQIfiMNhoioQGBxAdZAxS26RbIePS7KW3IwbistIKWjjDty03f
	 mtntCcdWwRPQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EBCE380820D;
	Wed, 21 Jan 2026 00:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 00/13] bpf: Kernel functions with
 KF_IMPLICIT_ARGS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176895542010.663774.16633470038935987737.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 00:30:20 +0000
References: <20260120222638.3976562-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260120222638.3976562-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yatsenko@meta.com, tj@kernel.org,
 alan.maguire@oracle.com, bentiss@kernel.org, jikos@kernel.org,
 ameryhung@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, sched-ext@lists.linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 20 Jan 2026 14:26:25 -0800 you wrote:
> This series implements a generic "implicit arguments" feature for BPF
> kernel functions. For context see prior work [1][2].
> 
> A mechanism is created for kfuncs to have arguments that are not
> visible to the BPF programs, and are provided to the kernel function
> implementation by the verifier.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,01/13] bpf: Refactor btf_kfunc_id_set_contains
    https://git.kernel.org/bpf/bpf-next/c/ea073d1818e2
  - [bpf-next,v3,02/13] bpf: Introduce struct bpf_kfunc_meta
    https://git.kernel.org/bpf/bpf-next/c/08ca87d63243
  - [bpf-next,v3,03/13] bpf: Verifier support for KF_IMPLICIT_ARGS
    https://git.kernel.org/bpf/bpf-next/c/64e1360524b9
  - [bpf-next,v3,04/13] resolve_btfids: Introduce finalize_btf() step
    https://git.kernel.org/bpf/bpf-next/c/2583e81fd885
  - [bpf-next,v3,05/13] resolve_btfids: Support for KF_IMPLICIT_ARGS
    https://git.kernel.org/bpf/bpf-next/c/9d199965990c
  - [bpf-next,v3,06/13] selftests/bpf: Add tests for KF_IMPLICIT_ARGS
    https://git.kernel.org/bpf/bpf-next/c/e939f3d16d77
  - [bpf-next,v3,07/13] bpf: Migrate bpf_wq_set_callback_impl() to KF_IMPLICIT_ARGS
    https://git.kernel.org/bpf/bpf-next/c/b97931a25a4b
  - [bpf-next,v3,08/13] HID: Use bpf_wq_set_callback kernel function
    https://git.kernel.org/bpf/bpf-next/c/8157cc739ad3
  - [bpf-next,v3,09/13] bpf: Migrate bpf_task_work_schedule_* kfuncs to KF_IMPLICIT_ARGS
    (no matching commit)
  - [bpf-next,v3,10/13] bpf: Migrate bpf_stream_vprintk() to KF_IMPLICIT_ARGS
    https://git.kernel.org/bpf/bpf-next/c/d806f3101276
  - [bpf-next,v3,11/13] selftests/bpf: Migrate struct_ops_assoc test to KF_IMPLICIT_ARGS
    https://git.kernel.org/bpf/bpf-next/c/bd06b977e02d
  - [bpf-next,v3,12/13] bpf: Remove __prog kfunc arg annotation
    https://git.kernel.org/bpf/bpf-next/c/aed57a363871
  - [bpf-next,v3,13/13] bpf,docs: Document KF_IMPLICIT_ARGS flag
    https://git.kernel.org/bpf/bpf-next/c/74bc4f612720

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


