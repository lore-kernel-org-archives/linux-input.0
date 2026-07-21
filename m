Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFAC471271;
	Tue, 21 Jul 2026 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656876; cv=none; b=oonrtGTDoMeN+ptXb2Et6gRG4mZg3YqHZtuEXVALAhe6Nk7kccDQ8sDSB2fZ+it3LB5NKm4zcBj4QFG1X1G9SpASqL86c1uGgsxQvvH6ny1H7en78GkNWRDi1CP222DT8PdBCBCje+9IX1Wbf757r0894CM+v52dsWeLz9AQUhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656876; c=relaxed/simple;
	bh=aMdVHFWOjdt9sNRXz7ug+YEO0TY0v++sERQYjXMFuHc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TSluetbpdHtN7vNoYHgk3186v1QeYiXfyYjRSmGIl0UGaYUxu/wanh072EujZp21lJRJm45hzZT9aZ9MvAaf8aQU8O6dtthsveAO/nsVyuW4xNsR2mAX3nWqINF4QCXIy78rILeqPfZIC3WsVbS3kAq9fkcrW3PGAkcdldE1gco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ktr5xxqu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ktr5xxqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E371F000E9;
	Tue, 21 Jul 2026 18:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784656874;
	bh=HAw8yGO+kEjoloJJlRZk6yiwHI97En9OnFtOaZzmoLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ktr5xxquME169Ijvs97cec6UNyYLJLiutri5Ih/PrmdkOelfrPQl4iPkVEnHlbHT9
	 pEP4y4k5hlhQsULx8vsolDagZ3Olmkk7caOsyRGd5rm7ZRAnicZKgVhMXoaqkcfNAn
	 s1Oi0SVVfhiz/2DwIV8E9whJrftszFXXKu4gkN/lchEbHFm6m4orvmic5PUrW85pI5
	 fv1o9LBMrpKzET+J9coMv8wJdb9c62uy8E7MnEJER9EMjcLVAxC3kQDUdMZH2TuiJ3
	 05UJHlczvF+nYA5vyKmfGqJUN9Y+Z/1d5Kz7YQAsIByIpFuDgtYQ6qKGU9yfkKzmjv
	 0prXcTlNie5tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] selftests/cgroup: add memcg_stat_cross_cpu
 correctness test for flush
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziyang Men" <ziyang.meme@gmail.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, bpf@vger.kernel.org, dmitry.torokhov@gmail.com, mkoutny@suse.com, linux-input@vger.kernel.org
In-Reply-To: <20260721174833.1232771-3-ziyang.meme@gmail.com>
References: <20260721174833.1232771-1-ziyang.meme@gmail.com>
 <20260721174833.1232771-3-ziyang.meme@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 18:01:12 +0000
Message-Id: <20260721180114.34E371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Cross-CPU charge scattering fails to trigger page faults on all =
K CPUs when resident_bytes / k < PAGE_SIZE.
- [Medium] Commit message contains inaccurate claims regarding the test fra=
mework and utility helpers.
- [Low] Multi-line comment does not follow the required BPF subsystem style.

Pre-existing issues:
- [High] Missing bounds checks for negative enum values in kfuncs bpf_mem_c=
group_vm_events and bpf_mem_cgroup_memory_events allow out-of-bounds array =
access.
--

--- Patch [2]: [PATCH v2 2/4] selftests/cgroup: add memcg_stat_cross_cpu co=
rrectness test for flush ---
commit c0bc72e5d098a9cdecf85dcaee9fd0bb8671e354
Author: Ziyang Men <ziyang.meme@gmail.com>

selftests/cgroup: add memcg_stat_cross_cpu correctness test for flush

This commit adds a memory-cgroup BPF selftest that verifies if the
memory-cgroup BPF kfuncs return values that match what userspace reads
from cgroupfs. It builds a cgroup tree, charges memory across multiple
CPUs, and compares the flushed kfunc stats to the traditional memory.stat
reads.

> Add a test_progs selftest that verifies the memory-cgroup BPF kfuncs
[ ... ]
> The traditional path reads memory.stat / memory.current through a new
> read_cgroup_file() helper added to cgroup_helpers (the read counterpart
> of write_cgroup_file).

[Severity: Medium]
The commit message states that a test_progs selftest was added and a new
read_cgroup_file() helper was introduced. However, the patch implements a
standalone kselftest via TEST_GEN_PROGS and relies on the pre-existing
cg_read() helper instead. Could the commit message be updated to accurately
reflect the implemented code?

[ ... ]
> diff --git a/tools/testing/selftests/cgroup/memcg_stat_cross_cpu.bpf.c b/=
tools/testing/selftests/cgroup/memcg_stat_cross_cpu.bpf.c
[ ... ]
> +	snap.file =3D bpf_mem_cgroup_page_state(memcg, idx_file);
> +	snap.shmem =3D bpf_mem_cgroup_page_state(memcg, idx_shmem);
> +	snap.file_mapped =3D bpf_mem_cgroup_page_state(memcg, idx_fmapped);
> +	snap.pgfault =3D bpf_mem_cgroup_vm_events(memcg, idx_pgfault);

[Severity: High]
This is a pre-existing issue, but the called kfuncs
bpf_mem_cgroup_vm_events() and bpf_mem_cgroup_memory_events() in
mm/bpf_memcontrol.c lack negative bounds checks for their enum arguments.

Since the BPF verifier does not enforce enum ranges, a BPF program could
pass a negative enum value which bypasses the upper-bound check (e.g.,
idx >=3D NR_VM_EVENT_ITEMS). This happens because the C code evaluates the
signed integer, leading to an out-of-bounds array access.

Can we add the required negative bounds checks to these kfuncs?

> +
> +	/* page_counter fields need no kfunc; read them off the trusted ptr. */
[ ... ]
> diff --git a/tools/testing/selftests/cgroup/test_memcg_stat_cross_cpu.c b=
/tools/testing/selftests/cgroup/test_memcg_stat_cross_cpu.c
[ ... ]
> +	/*
> +	 * Fault the region in K slices, each on a different CPU, so the charge
> +	 * for this leaf is scattered across K per-cpu rstat trees.  A correct
> +	 * flush must gather all K slices.
> +	 */
> +	per =3D resident_bytes / k;
> +	for (j =3D 0; j < k; j++) {
> +		off =3D (size_t)j * per;
> +		if (pin_cpu(cpu_list[(base + j) % n_cpu]))
> +			_exit(3);
> +		memset(region + off, 1,
> +		       (j =3D=3D k - 1) ? resident_bytes - off : per);
> +	}

[Severity: Medium]
If the system has a large number of CPUs, can per (resident_bytes / k)
become smaller than the page size?

For example, in the cross_cpu_large_tree test case with 256KB
resident_bytes and >64 CPUs, multiple CPUs would be assigned offsets
within the same 4KB page. The first CPU writing to the page causes a page
fault, but subsequent CPUs writing to the same page will find it already
mapped and won't trigger faults, defeating the cross-CPU scattering
mechanism.

> +
> +	/* Ready: the charge is in place and spread across K CPUs. */
> +	if (write(charge_ready[1], "x", 1) !=3D 1)
> +		_exit(4);
> +	close(charge_ready[1]);
> +
> +	/* Hold the charge (region stays mapped) until the parent tells
> +	 * us to exit by closing the control pipe.
> +	 */

[Severity: Low]
Does this multi-line comment format match the BPF subsystem style? The BPF
subsystem requires multi-line comments to have the opening /* on its own
line, even in selftests.

> +	while (read(charge_ctrl[0], &c, 1) > 0)
> +		;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721174833.1232=
771-1-ziyang.meme@gmail.com?part=3D2
