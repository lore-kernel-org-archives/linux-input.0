Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB1D49E12E;
	Thu, 10 Sep 2026 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789083872; cv=none; b=qqPyS5817bi5HzfnHIEL8frrzmmYQXANFd0016KmeSncU0C8FJdM/D0umdR28Y4ANioDwf2xVJs5FEw/UHw0rWKdSFVXeT+o1PG0SBUuwuKJkY9TVvoD3uPxCe+a8e543pDoY30KeE9V0xZHFys59F6dlvd77P8BfO6FJqepkno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789083872; c=relaxed/simple;
	bh=q5yOCD7bAQN2WnLFxlmTUp///2yOwNcPmzOZd+pOuoQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uNupkdvXaZKb74B9jMGJGwKazb8xrJ3Jz0b9bfUijP+o2HC1ULXHo26t7/i6Kw5eAaSxboZ5uKXoJhHD94qY6QD5TMGhCXy+yJEarddTO5pF2U/MwU0YQuML/ApK1cSlz9kMJrP+rjhdGrNQPl+AizHqWjQLhcXbi8sppPG1ItU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZUfhfow; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZUfhfow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37C31F000FF;
	Thu, 10 Sep 2026 23:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789083871;
	bh=s0SpSGWS6XWmfv9c/2xH8OOL41LcG0eQ7O9HYPwzbRk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LZUfhfowkq/5thXpQbDcb19+4hqtfgR5m2Fio5JqXJNxvmbEVDz/azwRQLTxR/F1G
	 98e/E+MBJ/3esbodQ6iXaidXkgQ/SQqyFh4oQQw2HWKPxOMvyLgsESrOIzDLZqK9nU
	 JT5aSBpAsBNDi6QkbMmpRpU9xEwWMpGke/VQZXY0LHCOM7lg4GesjVYlgZJdrpu/oT
	 i6nXO9XLWmBq8BBwKudFBouM8k7P5E84C/ONAL1F2snyG1NqVyB4jXasVdIQIYpi8r
	 HBUslg57HYaoA2vmZBNyY+EBFYuvGpanQnSEHkWL7xJRlCH3g1tYr6uuPdkLgduFpL
	 +MUE+TrESGiwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] selftests/cgroup: add memcg_stat_cross_cpu
 correctness test for flush
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziyang Men" <ziyang.meme@gmail.com>
Cc: bpf@vger.kernel.org, tj@kernel.org, sched-ext@lists.linux.dev, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20260910233303.1063501-3-ziyang.meme@gmail.com>
References: <20260910233303.1063501-1-ziyang.meme@gmail.com>
 <20260910233303.1063501-3-ziyang.meme@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 23:44:30 +0000
Message-Id: <20260910234430.B37C31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Kfuncs taking enum parameters lack negative bounds checks, allowin=
g out-of-bounds array accesses.
--

commit ba61caf79f3e8d8099a1b75ad1df31bbdc5f2942
Author: Ziyang Men <ziyang.meme@gmail.com>

selftests/cgroup: add memcg_stat_cross_cpu correctness test for flush
   =20
Add test_memcg_stat_cross_cpu, which verifies that flushing a memcg
subtree produces the same statistics through the BPF memcg kfuncs and
cgroupfs.

[ ... ]

> diff --git a/tools/testing/selftests/cgroup/memcg_stat_cross_cpu.bpf.c b/=
tools/testing/selftests/cgroup/memcg_stat_cross_cpu.bpf.c
> new file mode 100644
> index 0000000000000..fff3b9256aa39
> --- /dev/null
> +++ b/tools/testing/selftests/cgroup/memcg_stat_cross_cpu.bpf.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#define BPF_NO_KFUNC_PROTOTYPES
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
> +#include "memcg_stat_cross_cpu.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +/* Ensure the upper-bound checks also reject negative BPF arguments. */
> +_Static_assert((enum vm_event_item)-1 >=3D NR_VM_EVENT_ITEMS,
> +	       "negative vm_event_item must fail the bounds check");
> +_Static_assert((enum memcg_memory_event)-1 >=3D MEMCG_NR_MEMORY_EVENTS,
> +	       "negative memcg_memory_event must fail the bounds check");

[Severity: High]
This is a pre-existing issue, but while these static asserts guarantee the =
BPF
compiler evaluates the check correctly, does the host kernel kfunc itself
still lack negative bounds checks?

Looking at bpf_mem_cgroup_memory_events() in mm/bpf_memcontrol.c:

	if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
		return (unsigned long)-1;

Since the BPF verifier does not validate enum ranges, a BPF program can pas=
s a
negative value as the enum parameter. Because enums can be treated as signed
integers in C, wouldn't a negative value bypass this upper-bound check (e.g.
-1 >=3D MEMCG_NR_MEMORY_EVENTS evaluates to false), leading to an out-of-bo=
unds
array access?

A similar issue appears to exist in bpf_mem_cgroup_vm_events() which calls
memcg_vm_event_item_valid() in mm/memcontrol.c:

	if (idx >=3D NR_VM_EVENT_ITEMS)
		return false;

Could this allow an out-of-bounds array read that leaks kernel memory or
causes a panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910233303.1063=
501-1-ziyang.meme@gmail.com?part=3D2
