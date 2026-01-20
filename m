Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5826033C1A3;
	Tue, 20 Jan 2026 22:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949720; cv=none; b=EaJfE6fQaJkkb5xyhZRNdiWQW4sEvQ4jeiwhdntuoNa1GcX6nq2Yyv5eoVuHTIOipPKJ+W/bPu75s5ND2kiV+bm+u82uGeEyn1ap9lUH+dYvCPl4205W8HEP7FXr+nTMiFoB+boUhq6e2jVi+eLtyCJQ+lMrHYzzVax+ifvYQug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949720; c=relaxed/simple;
	bh=atj9ZDrlVFqwsuqKBLywRG1xl/dR3yS5PUSMm9ea8eY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GYalfKnNJEWIsZoYF8YbmYdOzWp1zFeuqbB48f9u1bPKos2affCnO24AXNYpt1SXpP6givUb5rAhHsImrn7T2ItmUaKMlWfTtntlmcCCPVq87tb1t4hkacr0wcZUtOXYAOvUxqgZciufnle5Nw62b5SKgA0Xf3ob3rmb4U/ABNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebmnwilp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebmnwilp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517A2C16AAE;
	Tue, 20 Jan 2026 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768949719;
	bh=atj9ZDrlVFqwsuqKBLywRG1xl/dR3yS5PUSMm9ea8eY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ebmnwilpPPTq+vxUd+PvhRSMbvQb6TgdyAYujOTlACXFMHYHC73rLz8zH2cktXpQb
	 Ugpm9CYoO6XZoYT+djfIwWHFw2IZPPNGVXJ2PsRxvmytwsMELCWBMIc7fcWrA14Tv1
	 Bfqf/nm0xHzyiPbKkbaGub/Bon1m3ix1+hGU53XiP7Saga1GkpOz5v/ybjFmO6E93K
	 V7AHUDcxLnfYQ+DvIUsYxkrG8RQm9ZvP8+m0Fqeii3IsNcNDOjiXY7HXaqL4gar/6r
	 ZrUMk4cH96rGr9tFGsZ+ssc1Ixc/RrqHnp4TAdIG9dCugzeUMcYZphI2/bSN+sKgfu
	 euK81znc+bWSQ==
Content-Type: multipart/mixed; boundary="===============8612786677161922109=="
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e8677fdf7cbe2c1174d7047c51f02516d92a91f9a649a30f0041e0f4bfc0b0a6@mail.kernel.org>
In-Reply-To: <20260120222638.3976562-8-ihor.solodrai@linux.dev>
References: <20260120222638.3976562-8-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v3 07/13] bpf: Migrate bpf_wq_set_callback_impl() to KF_IMPLICIT_ARGS
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com
Cc: yatsenko@meta.com,tj@kernel.org,alan.maguire@oracle.com,bentiss@kernel.org,jikos@kernel.org,ameryhung@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-input@vger.kernel.org,sched-ext@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 20 Jan 2026 22:55:18 +0000 (UTC)

--===============8612786677161922109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index 2cd9165c7348..68a49b1f77ae 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -580,11 +580,6 @@ extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
>
>  extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
>  extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
> -extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
> -		int (callback_fn)(void *map, int *key, void *value),
> -		unsigned int flags__k, void *aux__ign) __ksym;
> -#define bpf_wq_set_callback(timer, cb, flags) \
> -	bpf_wq_set_callback_impl(timer, cb, flags, NULL)

The old bpf_wq_set_callback_impl declaration and bpf_wq_set_callback macro
are removed here, but there does not appear to be a replacement declaration
for the new bpf_wq_set_callback kfunc.

Test files wq.c and wq_failures.c include bpf_experimental.h but do not
include vmlinux.h. They continue to call bpf_wq_set_callback() after this
change. Without an extern declaration such as:

    extern int bpf_wq_set_callback(struct bpf_wq *wq,
            int (callback_fn)(void *map, int *key, void *value),
            unsigned int flags) __weak __ksym;

should these test files fail to compile due to the missing declaration?
The kfunc_implicit_args.c test (from the earlier commit in this series)
demonstrates that explicit __ksym declarations are needed for kfuncs that
are not obtained from vmlinux.h.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21190053819

--===============8612786677161922109==--
