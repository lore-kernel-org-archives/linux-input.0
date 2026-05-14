Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4562848BA;
	Thu, 14 May 2026 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752953; cv=none; b=eXE1RDY5LD0A8vq0lohez2oYLzrttRnJpU0+VfVIKeWb1L4Fkvf5U8bOu6ZO8HyOVLTbVAwJzRqiKhznPCna8plC8d8Bg1Kna5FTeTuQpB39wdt3OZ7FX1Fy28OASFUZQRYQWNCgWdMBE7EIA6K7TwadT2Att45KIwkJ60jFNdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752953; c=relaxed/simple;
	bh=I5LGjB3LPZRTrFXwGMMedAZ0l8A/HmoWWktGrbcMPQQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WswJb8dWi8SWS8/CL/Yz3/MhsNsSO82pb0+vQeaXNfsXVSx1Guzy6XsPbbhIzXoGNNmqFnp2YuDizyXwJ2zYUUky75cA9R4HeTrgZoz2Bw9pZDUnN4oudUpe2MKHRnQPnJqEIiyKcYxMy/s8p+5vegg9NuhDMINWu8mObX5kXtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvtV8Hg3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvtV8Hg3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4775C2BCB3;
	Thu, 14 May 2026 10:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778752953;
	bh=I5LGjB3LPZRTrFXwGMMedAZ0l8A/HmoWWktGrbcMPQQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=lvtV8Hg3FF3mFtVkv62s3NarExlrZoVzcRXoehYpgOkGqsDCqUEXqxx7S1nGlBBBP
	 SN8kooxAyn6POwG1UC358iK7tGKo8vftXupi17b3eYiBQdMdxQt/IB/H6zQj3yAhQp
	 /CNh2Jd/I61/ro72qJ8s2wiR6EKRDZzbMS0ApKyzF8skrtt2PJHYt4GPUMsfl3XeaY
	 KU1cFvXTwPcujQGH7ZokG1KMhmObjxL1sBNdFvc5NFll7WCMWaEjdMV3iLvu/WNInR
	 YrO/l95WiXD62goABfNC5Ca7kmTkYCVMfmGHBvHSG6LHQ/fjCebOCQudSlA10eGhOT
	 EcF9dMlyuxxjQ==
Content-Type: multipart/mixed; boundary="===============3028240220261879341=="
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <998802d0c3bb407e9bcc61e4fe6db2e3eed7ac06c7c6eca0ed0dd5409a8c2801@mail.kernel.org>
In-Reply-To: <20260514-james-perf-llvm-version-v1-1-6cac1a9a4c8d@linaro.org>
References: <20260514-james-perf-llvm-version-v1-1-6cac1a9a4c8d@linaro.org>
Subject: Re: [PATCH 1/6] tools/build: Allow versioning of all LLVM tools defined in Makefile.include
From: bot+bpf-ci@kernel.org
To: james.clark@linaro.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com,jikos@kernel.org,bentiss@kernel.org,shuah@kernel.org,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,mark.rutland@arm.com,alexander.shishkin@linux.intel.com,jolsa@kernel.org,irogers@google.com,adrian.hunter@intel.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev
Cc: linux-kernel@vger.kernel.org,llvm@lists.linux.dev,linux-input@vger.kernel.org,linux-kselftest@vger.kernel.org,bpf@vger.kernel.org,linux-perf-users@vger.kernel.org,james.clark@linaro.org,leo.yan@arm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 14 May 2026 10:02:32 +0000 (UTC)

--===============3028240220261879341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> tools/build: Allow versioning of all LLVM tools defined in Makefile.include
>
> The version of LLVM tools can be given on the build command with
> LLVM=-15, but this isn't applied to all tools. For example $(CC) gets
> versioned, but $(CLANG) doesn't. This causes a Perf build with LTO=1 to
> fail with an error about mixed clang versions:
>
>  ld.lld: error: libperf/core.o: Unknown attribute kind (86)
>    (Producer: 'LLVM18.1.8' Reader: 'LLVM 15.0.7')
>
> This file has two "ifneq ($(LLVM),)" blocks adjacent to each other, so
> merge these blocks making it obvious that all tools should be versioned
> consistently and there is nothing special about each block.
>
> This also reveals that ?= and "allow-override" are used inconsistently
> between the blocks. "allow-override" is technically only required for
> builtin variables, but isn't only used on them, and doesn't do any harm
> if used on a non-builtin. Make them all "allow-override" for
> consistency. The only functional difference this will cause is if there
> is a file level definition of one of the variables followed by an
> "#include of Makefile.include" which will now overwrite. But this isn't
> done and in a later commit some of the duplicate definitions will be
> removed for good measure.
>
> There are also some other LLVM tools that are not defined here and will
> be moved in a later commit.
>
> Signed-off-by: James Clark <james.clark@linaro.org>

This looks like a bug fix that corrects inconsistent LLVM tool versioning
introduced in an earlier commit. Should this include:

  Fixes: e9c281928c24 ("kbuild: Make $(LLVM) more flexible")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25853166705
--===============3028240220261879341==--
