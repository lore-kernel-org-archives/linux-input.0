Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50513E51E2;
	Mon, 18 May 2026 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096758; cv=none; b=aAV3seLatIbaZOjR+9qZKPDS48xLe58Xpk5KgAaFd99X2iMuyW7RIrewLp2YyrW/jEiGsWU8KIdAeGUFCMXHNGKuGe2cfeCziiIeVJAzUnry7XnIDfMqP6nLxUr4OLc+dvpJUmDP1hZBPL8CKvfwZNEQh4R5XHDZzgEuucLoSOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096758; c=relaxed/simple;
	bh=h8WqaqnXFVpZHJBalsPzcHPChf2cfku1qZS0RwmOeb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UHvgmpHu5zaiXRqepRgrdecrMxBgzN7JWSn73zHtFNU/pthMZ2xFn8b4Qy06WBCWSlMGYOwTPX5wg08qEiYdjMKoay1GOm86BaBr8uwrX3XjqdxWaLRNcSDatL3x3Sk9FYlRNI/rwl6KadaQ9xcq8U0DYWetN6x5tI2cU9E66Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAA3GlUI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAA3GlUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90640C2BCC6;
	Mon, 18 May 2026 09:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779096757;
	bh=h8WqaqnXFVpZHJBalsPzcHPChf2cfku1qZS0RwmOeb4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AAA3GlUI+4dzitzKp3CkdbWy2Go4AYrCNBvFT8BEaaduT8CDiBOR9iArdt59c5avP
	 Fs3aHuk9OsiXR4c/aoHHV6HLV9JQnvJcc76iJu+S4ht4fuDyQ4jLzjO1w4CRlRENcm
	 h+C8jJXwifG002vtAtILCMK5R1G2/U8qE/BwUawSZJbcFkpgBaiFDbbLKfMtxe/J1s
	 Exrfr3ZEnEm+bvirlQTagEzvN8oek7sTuEtGnlqnUJJd8k9gvmKXOpHxvAFwgTxZVi
	 uJRYl8aXsNYZFw+6bb7pxY6j7RVY5KhWC3CUvdf4GtnabP1+eojucy9zM6l15sWJHG
	 Vyl8Aecyg6B7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] tools/build: selftests: Allow versioning LLVM
 lld
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: dmitry.torokhov@gmail.com, linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260518-james-perf-llvm-version-v2-5-f12cc4f031d8@linaro.org>
References: <20260518-james-perf-llvm-version-v2-5-f12cc4f031d8@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 09:32:37 +0000
Message-Id: <20260518093237.90640C2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Empty USE_LD variable causes clang build failure in selftests wh=
en ld.lld is not in PATH.
--

commit 371ca22c55bb0fa6502ac06f7b33d63418ad16ff
Author: James Clark <james.clark@linaro.org>

tools/build: selftests: Allow versioning LLVM lld

This commit adds an LLD variable to Makefile.include to allow versioning of
LLVM's linker, keeping it consistent with the rest of the LLVM toolchain. It
modifies the BPF selftests Makefile to resolve the full path of the linker
using the command -v shell utility.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 6ef6872adbc3e..836e783f0170e 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -245,9 +245,9 @@ $(OUTPUT)/%:%.c
> =20
>  # LLVM's ld.lld doesn't support all the architectures, so use it only on=
 x86
>  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
> -LLD :=3D lld
> +USE_LD :=3D $(shell command -v $(LLD))

Does this cause the build to fail if the toolchain directory is not in the
system PATH?

If a user explicitly specifies the compiler using an absolute path like
CLANG=3D/path/to/clang, but does not add the toolchain directory to their P=
ATH,
the command -v utility will return an empty string.

This would cause USE_LD to be empty, leading to a malformed argument like
-fuse-ld=3D being passed to clang later in the Makefile, which then fails w=
ith
an invalid linker name error.

Previously, passing the hardcoded lld allowed clang to natively resolve the
linker relative to its own binary location. Is there a way to support both
versioned linker names and absolute compiler paths without relying entirely
on the system PATH?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518-james-perf=
-llvm-version-v2-0-f12cc4f031d8@linaro.org?part=3D5
