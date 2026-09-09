Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75E54086A;
	Wed,  9 Sep 2026 00:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788912332; cv=none; b=GFrhiOyba7WKmedaLiabf3O+K9nFqRg4hxT6UQJYBRBD2fUSpf5kxL18Zi2KVEZqnKn9kbApL926CZjDgEeLvdcvvPWlmDrtANRft5KMUoqIX6pTS94ArYP6Q8IN6xhIeNulr2+Wy+nxUtSJAJ0FDhRcd7Av79FewKJX+OvYuEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788912332; c=relaxed/simple;
	bh=kBzw3pxc32aLqolGSwPmG9YAfQE01zYj+P0QRH0Z8NI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=icUFqZCgV326tsn/vjVJy4AsteX9Up7mkgm4R54cwZiLdnwFK73rd/WMHpuyMMzD8TKFEHA4zntR0q8u7tGWCGw7HJqs4M/N42P3rEXdMTlvATXl5AxitfOnrcChtnkYSlQBpe0a+ukr+gvM4rgNWY2PS6CCdA0NsZDnX8o67T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DG7nfEx5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DG7nfEx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531611F00A3A;
	Wed,  9 Sep 2026 00:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788912328;
	bh=o+4+eepLawqjQxcXllnGq9c1bbxANN86JSsUpg13s8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DG7nfEx5QxSHdwTawVOlXiLJrsxs//RBRQ7lJjQ0zKI69/MnOs9OdyWOZ008kDj+E
	 Lxt7TAynls1Mq5EwgcAfSvZvv6b9iVYpWn2Dj4VGq9brEkay1m9QzOdgHbfyUCiW4c
	 sU7HGFOrhGlbVD99mnvjRd2ui6wbP55yeYJtMCgANA84gGb6kHjiTgJABoYFZssGH8
	 28xj96XgYClKyLGO/446Rt/Q7LdmDpVozu+/gr+d0TQHVMWZklHXJGq72mDCRvH4WI
	 TMO4qvej4Jx87CWjGHgDE0fMRiMPj5Qmh0g1tdFWRDgHAbbTd0AJS6zLnJPMxAoIGT
	 ft1lNpQOi7w9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] selftests/cgroup: add memcg_stat_cross_cpu
 correctness test for flush
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziyang Men" <ziyang.meme@gmail.com>
Cc: tj@kernel.org, bpf@vger.kernel.org, mkoutny@suse.com, sched-ext@lists.linux.dev, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, hannes@cmpxchg.org
In-Reply-To: <20260908235552.2610256-3-ziyang.meme@gmail.com>
References: <20260908235552.2610256-1-ziyang.meme@gmail.com>
 <20260908235552.2610256-3-ziyang.meme@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 00:05:27 +0000
Message-Id: <20260909000528.531611F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check for negative enum values in memcg BPF kfuncs =
(`bpf_mem_cgroup_memory_events` and `bpf_mem_cgroup_vm_events`), leading to=
 potential out-of-bounds array reads.
--

commit 75dfb2e14e4c5552066e9fdeb8f96969135f991d
Author: Ziyang Men <ziyang.meme@gmail.com>

selftests/cgroup: add memcg_stat_cross_cpu correctness test for flush

Add test_memcg_stat_cross_cpu, which verifies that flushing a memcg
subtree produces the same statistics through the BPF memcg kfuncs and
cgroupfs.

> diff --git a/tools/testing/selftests/cgroup/memcg_stat_cross_cpu.bpf.c b/=
tools/testing/selftests/cgroup/memcg_stat_cross_cpu.bpf.c
> new file mode 100644
> index 0000000000000..c3c69ecd888f0
> --- /dev/null
> +++ b/tools/testing/selftests/cgroup/memcg_stat_cross_cpu.bpf.c
> @@ -0,0 +1,95 @@
[ ... ]
> +int memcg_kfuncs_probe(struct bpf_iter__cgroup *ctx)
> +{
> +	struct cgroup *cgrp =3D ctx->cgroup;
> +	struct mem_cgroup *memcg;
> +
> +	if (!cgrp)
> +		return 0;
> +
> +	memcg =3D bpf_get_mem_cgroup(&cgrp->self);
> +	if (!memcg)
> +		return 0;
> +
> +	bpf_mem_cgroup_flush_stats(memcg);
> +	bpf_mem_cgroup_page_state(memcg, 0);
> +	bpf_mem_cgroup_vm_events(memcg, 0);

[Severity: High]
This isn't a bug introduced by this patch, but can this kfunc and related
memcg kfuncs be exploited by passing negative enum values to read
out-of-bounds memory?

In mm/bpf_memcontrol.c, the bpf_mem_cgroup_vm_events() kfunc takes an enum
event parameter:

mm/bpf_memcontrol.c:bpf_mem_cgroup_vm_events() {
	if (unlikely(!memcg_vm_event_item_valid(event)))
		return (unsigned long)-1;
	...
}

The helper memcg_vm_event_item_valid() in mm/memcontrol.c uses a signed
comparison that doesn't catch negative values:

mm/memcontrol.c:memcg_vm_event_item_valid() {
	if (idx >=3D NR_VM_EVENT_ITEMS)
		return false;

	return !BAD_STAT_IDX(memcg_events_index(idx));
}

Similarly, bpf_mem_cgroup_memory_events() lacks a negative check:

mm/bpf_memcontrol.c:bpf_mem_cgroup_memory_events() {
	if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
		return (unsigned long)-1;

	return atomic_long_read(&memcg->memory_events[event]);
}

Since the BPF verifier treats enums as plain integers and doesn't enforce
their valid ranges, a negative index can bypass these validations and lead =
to
a backward out-of-bounds read from the target array.

> +	bpf_put_mem_cgroup(memcg);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908235552.2610=
256-1-ziyang.meme@gmail.com?part=3D2
