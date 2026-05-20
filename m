Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5868E352026;
	Wed, 20 May 2026 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306645; cv=none; b=EMgFt6QhgKOaNE2Ek+1YHIAVQwUQDU4d/JyIYvY8cLx64wVAC46/bTQzaL5+oLAGullVmwJ5aTFJhJRfj6zadC99OVXcLku0Nj+S9EnXPENhoTnxvNFcR9Wym2wO6dzoMdLqLlZNNBHoe/RjnT64/Ydkkq7zHw34pL+taoz5fac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306645; c=relaxed/simple;
	bh=AXZ8xJNsowxaTzVYTmh1M/5dnlbzZ3GKUtBHTtJxfjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsIUF01/zQNP374AA2D64BI149W+xAEIRF+ebzk6lOG6Ru14yEOOxmVchki1ggMbenhMTIXw9abH59xP88iW9loHaVw6kt5HJxM8YjLvoGYHGsr2z+5pVzRg7fWdSIjHzUC6AUfNqJPgb2OwIALTuTIzLKjQK81jfx5fO7SInSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKeZglcT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKeZglcT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558171F000E9;
	Wed, 20 May 2026 19:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779306644;
	bh=Qx1idctS2JaBxqH1vrfL+qgfWIMqAd6ofslwgR2FEk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UKeZglcTfQStNMMp3vMx60u285iChBAdXJ1UtKfS/4K9gl+3MKaXxNOzsjDE3YHPb
	 jcnAYOe0s5m/ldJNUqn6QsD1z3ZOuM+VZpVZhITwshn4QoNKv5cUdRkbvLhwZWZibU
	 IsLt5CoWxgj0miuV2KN3cCtclBuutESD5nbXuwfRhFZnifiN4p6hKAQPMSqxHy28AH
	 AN1N3hszJfSDKkclIToVUgU5uqDYpp0mV/MMyagEuIqblw/fRsgjQgxW1fZme7WM+F
	 0b3ZT0/9XWVR3w7NIlEaBdT+vRMykbz+MW9AbCGAyTiWfR171uKZG8eWGv+deCX8EC
	 ihmv9xrRizTsQ==
Date: Wed, 20 May 2026 16:50:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: sashiko-reviews@lists.linux.dev, dmitry.torokhov@gmail.com,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH v2 5/6] tools/build: selftests: Allow versioning LLVM lld
Message-ID: <ag4QkPOCQ5LWy-U3@x1>
References: <20260518-james-perf-llvm-version-v2-5-f12cc4f031d8@linaro.org>
 <20260518093237.90640C2BCC6@smtp.kernel.org>
 <ef5688a7-3e1d-47be-aca7-cc6e564e059c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef5688a7-3e1d-47be-aca7-cc6e564e059c@linaro.org>

On Mon, May 18, 2026 at 10:47:53AM +0100, James Clark wrote:
> 
> 
> On 18/05/2026 10:32 am, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] Empty USE_LD variable causes clang build failure in selftests when ld.lld is not in PATH.
> > --
> > 
> > commit 371ca22c55bb0fa6502ac06f7b33d63418ad16ff
> > Author: James Clark <james.clark@linaro.org>
> > 
> > tools/build: selftests: Allow versioning LLVM lld
> > 
> > This commit adds an LLD variable to Makefile.include to allow versioning of
> > LLVM's linker, keeping it consistent with the rest of the LLVM toolchain. It
> > modifies the BPF selftests Makefile to resolve the full path of the linker
> > using the command -v shell utility.
> > 
> > > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > > index 6ef6872adbc3e..836e783f0170e 100644
> > > --- a/tools/testing/selftests/bpf/Makefile
> > > +++ b/tools/testing/selftests/bpf/Makefile
> > 
> > [ ... ]
> > 
> > > @@ -245,9 +245,9 @@ $(OUTPUT)/%:%.c
> > >   # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
> > >   ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
> > > -LLD := lld
> > > +USE_LD := $(shell command -v $(LLD))
> > 
> > Does this cause the build to fail if the toolchain directory is not in the
> > system PATH?
> > 
> > If a user explicitly specifies the compiler using an absolute path like
> > CLANG=/path/to/clang, but does not add the toolchain directory to their PATH,
> > the command -v utility will return an empty string.
> 
> If they don't use LLVM= and use CLANG= with an absolute path then they need
> to set all the tools with an absolute path. That's the problem that setting
> the path with a prefix for all tools with LLVM= solved.
> 
> I suppose this could _technically_ be a regression, but so could adding any
> new build rule that added a new tool that wouldn't be set in someones
> existing build command. Being that strict would mean we can't ever add new
> tools so I don't think this is an issue. And I don't think there's a way to
> solve this and also respect the documented rules of LLVM=

Hey, this touches several tools and libs, did you get acks besides the
one from Ian?

- Arnaldo
