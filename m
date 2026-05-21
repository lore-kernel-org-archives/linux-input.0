Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D833B6F6;
	Thu, 21 May 2026 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377441; cv=none; b=iOka7r1dolf7GTsNuT+xWgramC5jsKT5zSKfJIFi+FkxL+nslXOEm2I17BliKzzmYVAWRMKQ0Lnsz/Chgb+4gETCCQk8U71vtrBWI7Kt11SWeJE2VU7IKUXIi1Ev7XkBomfc0OOh6KL1NtkvFHauKIUOgXxvL+nPQ92qv7dFO3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377441; c=relaxed/simple;
	bh=X+LcL4d8IoZEBu4qCH4rWM1ShYAUxLN4lGjDroNcJ6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkNMdJzEURglJWFiU29/7HPP3WU4VPNfWqQxVNxdaRjVYesThUnPatTfsBQ0q0w5FIeWqBlrISQG2cBasyK6+rt8S4Jb0oyQDJoEEsaluyXUgPkI16uuSYYUi5jBzqAaXhynezsLIXEz/W/Y2WPPGlnEfYZEFhA2QTWzLU2W6A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVlNyrL6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVlNyrL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FF21F000E9;
	Thu, 21 May 2026 15:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377440;
	bh=8pXURKq8v8zQW/FW10nRc2NCZs+G7pfHGg21oIYc6E8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IVlNyrL6WYlZUME7Rqr3JrT18HaZuZlXGybQ6rlNzjau/CHsTVmzaNqZL16i0FhO7
	 nH1zfbXMp6Kv83AglEN+zzlKeNB4jM5ttbLZ+ntQoYp2kSFio87P/S9Ih/JXLfZ1J+
	 4qISDZA3UIYrO8fqt14sLbCvRG9Yiy/bdfpRsp3E4I4Afd4xo3dkJEZ1v7Dv2gt7+J
	 khqdnYKHTbEUp97bBBd0ATw4tHngIQtpFZV4tOC6EnuIg88S1hpXfc2rfmbpQ07EOK
	 MDGjJXQlxiZPSjtLQ5so/BiOzbzcycs3v/BqVOtfz9ewVTWf3+bvDOIDQrmHr/4Iyc
	 l6+x6suuFsShQ==
Date: Thu, 21 May 2026 17:30:32 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/6] selftests: Remove unused LLD variable
Message-ID: <ag8k4k6f_dlchcuA@beelink>
References: <20260518-james-perf-llvm-version-v2-0-f12cc4f031d8@linaro.org>
 <20260518-james-perf-llvm-version-v2-3-f12cc4f031d8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518-james-perf-llvm-version-v2-3-f12cc4f031d8@linaro.org>

On May 18 2026, James Clark wrote:
> This file was mostly copied from selftests/bpf/Makefile, but the LLD
> variable is not used here. Also, this copied block didn't get the same
> fixes as the original one did later.
> 
> Remove it to avoid confusion and so future fixes don't have to be in two
> places.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.2/bpf), thanks!

[3/6] selftests: Remove unused LLD variable
      https://git.kernel.org/hid/hid/c/08918b98b02b

Cheers,
Benjamin


>  tools/testing/selftests/hid/Makefile | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
> index 50ec9e0406ab..96071b4800e8 100644
> --- a/tools/testing/selftests/hid/Makefile
> +++ b/tools/testing/selftests/hid/Makefile
> @@ -105,13 +105,6 @@ $(MAKE_DIRS):
>  	$(call msg,MKDIR,,$@)
>  	$(Q)mkdir -p $@
>  
> -# LLVM's ld.lld doesn't support all the architectures, so use it only on x86
> -ifeq ($(SRCARCH),x86)
> -LLD := lld
> -else
> -LLD := ld
> -endif
> -
>  DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
>  
>  TEST_GEN_PROGS_EXTENDED += $(DEFAULT_BPFTOOL)
> 
> -- 
> 2.34.1
> 
