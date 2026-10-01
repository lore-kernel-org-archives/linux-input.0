Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C1B377575;
	Thu,  1 Oct 2026 23:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898363; cv=none; b=Wsd3ENd6R1mEZtLqrYo1xk9JhxD+HnSU3tMv+2nxO4QPHNzh6kZMSBEC1M13JonX1TKarNC5unm4lDvBTP2r6NL4xqeLLuhcO8MyVQiuaukuGk6U1st1eIbTB3lDNytwSWanr4V8Dq7O0R/474vLQiuilWMlvIfSkP+gY0lcFrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898363; c=relaxed/simple;
	bh=otatrbpvzgeePBYD7syuCvA3ICSk6SUJoyQaKP2bl6s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RXDPtq/aGYUMzZbHmpFKKvVYH/455a88+PVozghUUElK0nZv3c49bur84Xgm9FF+bdYdi5RjpoGGwO8X+7Oy0YgfglQxQWBAQMLmcbntT3Dj4rgaZAHMkOQ7qletERlQ5Sh4EnZt4LIY54YwyN/A/c+aeK7XTzzQqeFhq/GKf8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n78i2g0G reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n78i2g0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F551F00893;
	Thu,  1 Oct 2026 23:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790898361;
	bh=3A1Ao6AkeQQW21XFx0nCGh+Pf0dIGxxVzzcK/mEcst8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=n78i2g0G/kYMfoqlT2xljKl4d8y+B3CaDZfKOEAJishZpWb36uxgr4a5/vy9R41Sm
	 tjexrfNNfLDt8DS/b/f4j45JX5FMHo9foL1PspMBCnWzo3CTQtAnC7HQnQVKjGfZCz
	 4HjQi6xiQ0osUha/4+saiehsEq5Dv7qqW/bwqPWKoGvlomv9YRHtt10PFkIkIYLxlV
	 HbYUyDxLeK8wqUqbAP1xNrn6+VS0uaDOyW3u2MqjSVDsi744P8PpGdOM3ib/UThWrQ
	 PDc/JbjX64E+3+hb9tLx3n4WiCj7MDF2JCXldu2Z4lcr+ENuKgRPzQ4zAiEXi2oM8L
	 lkHHiccpnH40Q==
Content-Type: multipart/mixed; boundary="===============7077505053475274818=="
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3a7e578809176358fa69c7728fa26fc76cadf93bb216c2caa074d55df0e799e2@mail.kernel.org>
In-Reply-To: <20261001225214.12351-8-wanjay@amazon.com>
References: <20261001225214.12351-8-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next v4 07/12] bpf: keep module BTF until the vmlinux BTF is available
From: bot+bpf-ci@kernel.org
To: wanjay@amazon.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: alan.maguire@oracle.com,martin.lau@linux.dev,yonghong.song@linux.dev,jolsa@kernel.org,ihor.solodrai@linux.dev,qmo@kernel.org,nathan@kernel.org,nsc@kernel.org,linux-kbuild@vger.kernel.org,linux@weissschuh.net,christian@heusel.eu,mcgrof@kernel.org,petr.pavlu@suse.com,samitolvanen@google.com,linux-modules@vger.kernel.org,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,linux-trace-kernel@vger.kernel.org,acme@kernel.org,namhyung@kernel.org,irogers@google.com,linux-perf-users@vger.kernel.org,jikos@kernel.org,bentiss@kernel.org,linux-input@vger.kernel.org,tj@kernel.org,void@manifault.com,arighi@nvidia.com,changwoo@igalia.com,sched-ext@lists.linux.dev,shuah@kernel.org,linux-kselftest@vger.kernel.org,ojeda@kernel.org,rust-for-linux@vger.kernel.org,arnd@arndb.de,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,abuehaze@amazon.com,doebel@amazon.de,mpohlack@amazon.de,jay.wang.upstream@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kern
 el.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  1 Oct 2026 23:45:59 +0000 (UTC)

--===============7077505053475274818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: keep module BTF until the vmlinux BTF is available

TL;DR: Nits only: in kernel/bpf/btf.c, btf_drop_deferred_vmlinux_regs() could
reuse the new btf_free_deferred_regs() helper, and the module and vmlinux
apply loops look duplicated. No bug.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 96241dc62dc3..4d51fb212218 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -10967,6 +11252,16 @@ static void btf_apply_deferred_regs(struct btf *btf, struct list_head *regs)
>  	}
>  }
>
> +static void btf_free_deferred_regs(struct list_head *regs)
> +{
> +	struct btf_deferred_reg *reg, *tmp;
> +
> +	list_for_each_entry_safe(reg, tmp, regs, list) {
> +		list_del(&reg->list);
> +		btf_free_deferred_reg(reg);
> +	}
> +}
> +

This isn't a bug, but could btf_drop_deferred_vmlinux_regs() call the new
btf_free_deferred_regs(&regs) instead of keeping its own copy of the loop?

The tail of btf_drop_deferred_vmlinux_regs() still open-codes the same
thing on its local list:

    list_for_each_entry_safe(reg, tmp, &regs, list) {
        list_del(&reg->list);
        btf_free_deferred_reg(reg);
    }

The splice / unlock / apply / relock loop in btf_module_apply_regs() is
also the same as the one in btf_apply_deferred_vmlinux_regs(), just with a
different mutex.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36938681172
--===============7077505053475274818==--
