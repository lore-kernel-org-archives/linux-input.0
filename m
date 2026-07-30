Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C80837F8DD;
	Thu, 30 Jul 2026 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441055; cv=none; b=piqunOzCKtTt+2paULOpC6DyXCYxbvBJ7g9SWVRS3WN0Y8OgC/lU0cS3pYK3HI5ag2mBHj5aMufwQtUkQbPFlRG1opIbscXCdaiHcovocwBz0hEpzhEnLyL/p3p4LJvFXnPy/j9pLDHw+H2w5z9tdgtqTyNa1WN628sjtRrTTrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441055; c=relaxed/simple;
	bh=i2/cVmXCrW9BryXa2vAAKLowHunURJoY1H8OwdQ951w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ufr2IH6pRcawa7e/37ogYsp0MUj8+N0DD2NqB/YOqdD1G466iVeGkQ58YGUf88D3thQTrMR7/n0Uq8zZngbzAFUMimt4H9ET/WkN56GXlYXwddflnV0kNGYBnytgBp30BT7qiRFeWsFuYX76FSIAS0w7FtSH6kKVd6SskGHsos8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCe8Kewv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCe8Kewv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EB41F000E9;
	Thu, 30 Jul 2026 19:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785441053;
	bh=8cdlBhGlMUA6Q/pUQ1Hw/rksA2rbbugAxiF6zwjVMe4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iCe8KewvUCBuF0WDps8fnV6U0Sf+5Ob+GP5+UwJn2INWM6/1k5GfLkM/t49+n9DU0
	 Hrg2N6KjeMTaF7KFItpLb/2UwV58wL8PAdJUzjcqBws7XqKspN4o+1115OEC6xpFoJ
	 4GJv5uI4b1XZu6Dc3zmnZ/KYtI8vcj9xiZKlgLeamunqzX7E0ajKM6ZBad3bf/eNe+
	 Cmu/RvMr6Glug+jFZtOM9qYk9qvQiZsLEg8aY0Wyt/CTlAXUcw1aD+/D56uFa1Z9nP
	 LBzoZRFz7itxWlFM4uWp4pNOj2u9f22T1PdgCdgqqh/DJ8+0udfpzO88O5kphCPH1O
	 Vv4p3k+aY8+5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939573811A70;
	Thu, 30 Jul 2026 19:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/8] resolve_btfids: Discover kfuncs from BTF
 ID
 sets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178544101714.4157510.6877511193196128541.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 19:50:17 +0000
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260722233518.778854-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, bentiss@kernel.org, jikos@kernel.org,
 emil@etsalapatis.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-input@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 22 Jul 2026 16:35:10 -0700 you wrote:
> This series develops resolve_btfids in preparation for bringing
> kernel-specific BTF transformations in tree, which will reduce kbuild
> dependency on pahole's features.
> 
> resolve_btfids currently identifies kfuncs by reading the "bpf_kfunc"
> decl tags pahole emits into vmlinux BTF. The series switches the
> source of truth to the BTF ID sets registered with
> BTF_KFUNCS_START()/END() in the kernel, which is the mechanism BPF
> verifier uses.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/8] resolve_btfids: Implement generic ensure_mem() to grow arrays
    https://git.kernel.org/bpf/bpf-next/c/47d62db55043
  - [bpf-next,v1,2/8] resolve_btfids: Index BTF ID symbols by address
    https://git.kernel.org/bpf/bpf-next/c/c5ab68a5fa92
  - [bpf-next,v1,3/8] resolve_btfids: Keep collected kfuncs in a rbtree
    https://git.kernel.org/bpf/bpf-next/c/e4293c31a320
  - [bpf-next,v1,4/8] libbpf: Export btf__find_by_name_kind_own()
    https://git.kernel.org/bpf/bpf-next/c/ef242559eb48
  - [bpf-next,v1,5/8] resolve_btfids: Fix the _impl lookup for module BTF
    https://git.kernel.org/bpf/bpf-next/c/91efe50e3042
  - [bpf-next,v1,6/8] HID: bpf: Make syscall kfunc flags match the struct_ops set
    https://git.kernel.org/bpf/bpf-next/c/5c4923172dae
  - [bpf-next,v1,7/8] resolve_btfids: Discover kfuncs from BTF ID sets
    https://git.kernel.org/bpf/bpf-next/c/f9f60d41ba2c
  - [bpf-next,v1,8/8] resolve_btfids: Enforce consistent kfunc flags across BTF ID sets
    https://git.kernel.org/bpf/bpf-next/c/140a3479ef66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


