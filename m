Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10328DF72;
	Wed,  9 Sep 2026 00:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788912169; cv=none; b=HTLLSuYjianeJeMpNLIqZivc7qhnedx02CjgJn3Rfx35YgBeeeldzbtNurAJSxz9YU+PlS1pke3Wh28aHunu61+Y18ZAreRLn3AjtP4az4vhz3bwUtRIJ7TaE5mHCc144JdSinraN5gNB2/noWdnziJ7mGDHJVGXG5RsNnT1+0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788912169; c=relaxed/simple;
	bh=ChcQNcdPLfslLwMVlx1G7L+B8V7ILeLhEwbMeIvcaAs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dn8p3CvE63FmunBD6fYKIwj8Y+BJlpz4YBLAt7QHw5u6/84PzScFPNSeVhrwzMCksjlMfe/w/UgRQSwc5xCcrICTRhXoJdBnlomIJqRAVvKLTbRJg/gQA1HpNtWTRY9xZcj58BsAzPP8aRXlVDA45v7AVqKhaUDWAvyMaOe55QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L76Xm1Ou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L76Xm1Ou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495EF1F00A3A;
	Wed,  9 Sep 2026 00:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788912167;
	bh=VzKdCnyW6uGC76UHbbXQUQENeNBgJQUw40Jw8koap8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L76Xm1Ou3CMhvp81jX1f/xf7fa3EyOEcdcgA6vb9QCZuOadIli7vrxX+l6yKpijLF
	 bU5d+3kYegtfKynkGwKHGobMVlZGylXaZN31jw1vLZ5SKIN2OUywIs11sAtkved0sY
	 ZT9ueodxiIcqPND8rRO54Y1pQ8g1GLliMkFm+u6isdGUWNIqYvHSclQlRjuYpAwqYl
	 kdYnGCM0GY1+dfmNhnCKJURsMpRvGeCFzMN6JvlZb+obNDRQ8IJbBk7REJSWAtnKrL
	 d/u0wZl5KIGe8eQzW7WKp4+bWIVsOnVvht1exsIynKs/2WFRmAseqB7W4pYllXO8hX
	 3LWaVb4Q6/PRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] selftests: add shared lib.bpf.mk to build BPF
 progs and skeletons
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziyang Men" <ziyang.meme@gmail.com>
Cc: sched-ext@lists.linux.dev, linux-input@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, dmitry.torokhov@gmail.com, bpf@vger.kernel.org
In-Reply-To: <20260908235552.2610256-2-ziyang.meme@gmail.com>
References: <20260908235552.2610256-1-ziyang.meme@gmail.com>
 <20260908235552.2610256-2-ziyang.meme@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 00:02:46 +0000
Message-Id: <20260909000247.495EF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Order-only prerequisite on stamp file prevents rebuilding dependent=
 objects when vmlinux.h changes.
--

commit f7b71013493f3d0a8611d16b18e727d7b737042f
Author: Ziyang Men <ziyang.meme@gmail.com>

selftests: add shared lib.bpf.mk to build BPF progs and skeletons

This patch adds a shared Makefile fragment (lib.bpf.mk) to standardize the
build tool-chain for BPF programs and skeletons across selftests. It
centralizes the build logic to reduce duplication as more subsystems adopt
BPF-based tests.

> diff --git a/tools/testing/selftests/lib.bpf.mk b/tools/testing/selftests=
/lib.bpf.mk
> new file mode 100644
> index 0000000000000..f27cd1889e7ff
> --- /dev/null
> +++ b/tools/testing/selftests/lib.bpf.mk

[ ... ]

> +# ---- build vmlinux.h -------------------------------------------------=
-----
> +lib_bpf_vmlinux_h     :=3D $(INCLUDE_DIR)/vmlinux.h
> +lib_bpf_vmlinux_stamp :=3D $(INCLUDE_DIR)/vmlinux.h.stamp
> +
> +# Preserve vmlinux.h's timestamp when its contents do not change.
> +ifeq ($(wildcard $(lib_bpf_vmlinux_h)),)
> +# Regenerate if the header is missing but its stamp remains.
> +.PHONY: $(lib_bpf_vmlinux_stamp)
> +endif
> +
> +# Use an order-only edge so the stamp's mtime does not propagate.
> +$(lib_bpf_vmlinux_h): | $(lib_bpf_vmlinux_stamp) ;

[Severity: Low]
Does using an order-only prerequisite here prevent rebuilding dependent
objects when vmlinux.h changes?

Using an order-only prerequisite means GNU Make might not re-stat
vmlinux.h after the stamp recipe updates it. To allow single-pass rebuilds
while avoiding redundant rebuilds when the contents haven't changed, would
it be better to use a normal dependency with the empty recipe `;`?

> +
> +$(lib_bpf_vmlinux_stamp): $(lib_bpf_vmlinux_deps) | $(INCLUDE_DIR)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908235552.2610=
256-1-ziyang.meme@gmail.com?part=3D1
