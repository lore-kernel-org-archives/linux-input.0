Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43416346A11;
	Fri, 14 Aug 2026 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694967; cv=none; b=mfgsDMCeXC9aJPGnMxHtLS3/czbBKTWfLj89DKCGEZFEzT9+r4fiN3z+72xqkL+h7ExF6O7014Dkw7WTqYQlbTBvJGDHVkMcHQgyl0SehkC6DPBL2ouqyFEs6sB9BSQLWgWrlASuYnPzC+/c9rKKye4ZM31fu/12e+8c6Kdebsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694967; c=relaxed/simple;
	bh=TA8NjPkJg/wxekqgyP6kvAcIcsIdSbdDYTKUHdghBjE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q1GBc//GZ7i/72uU66etn80FzCoPDSvJcY28hcIq41DqyQdSZJ0ZnUwkxFwkFF1eIwx5eflxwIz3jzs06nq9dfSOVMJZIiVJkdxmFNA6M6VLTbyWz9rK24UXAmS3c9000InOlts22dDJeHK9jzdduNPsoVhT5fryt1BQQaRU82A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj1IbOej; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj1IbOej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FA31F000E9;
	Fri, 14 Aug 2026 08:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786694965;
	bh=JTndrLd9EgESq3MQ2z80GBzpquS37Tpitiqhdh59XX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fj1IbOej9hAKuf/WBxehvkR7L+gY8OyJKW91rxtE7wW79QSzQN4rvZh9+9nGx7jcr
	 SiXuhqDPwMRLYeexSS6JS3GUli9N5SXwGOr5qDt8EzXwh0tm4fu9u6mepbt8fdX0sO
	 IF4EXeozPhd+9PuRJv7iAYiCprBYP+xNpRYgRU37ksgHVtEhBwVBl7m5ahdFT5h+Gj
	 dhha2DbKM1bLP5gU/Trw/Je6RGnjEcYBHQlf1ccfjgO191irHDq3d0B6wXJUwtVh5H
	 XJyfduQ6PpuIhUaOKwYs5FNjHmYqQgJ6MO579A1S62KdKxmAgOKBQi+RetIkCtPs8T
	 ASDqs9WouEoTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] selftests/cgroup: add memcg_stat_cross_cpu
 correctness test for flush
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziyang Men" <ziyang.meme@gmail.com>
Cc: mkoutny@suse.com, sched-ext@lists.linux.dev, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, bpf@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org
In-Reply-To: <20260814075054.507089-3-ziyang.meme@gmail.com>
References: <20260814075054.507089-1-ziyang.meme@gmail.com>
 <20260814075054.507089-3-ziyang.meme@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 08:09:24 +0000
Message-Id: <20260814080925.11FA31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Multi-line comment does not follow the correct BPF/kernel style.

Pre-existing issues:
- [High] The kfuncs bpf_mem_cgroup_memory_events and bpf_mem_cgroup_vm_even=
ts lack negative bounds checks for their enum parameters, leading to out-of=
-bounds array reads.
--

--- Patch [2]: [PATCH v3 2/4] selftests/cgroup: add memcg_stat_cross_cpu co=
rrectness test for flush ---
commit aa1f4cd8dd58a883c661755d56a15bc86e70795f
Author: Ziyang Men <ziyang.meme@gmail.com>

selftests/cgroup: add memcg_stat_cross_cpu correctness test for flush

This patch adds a new selftest, test_memcg_stat_cross_cpu, to verify
that cgroup flushes happen correctly by ensuring BPF read values match
cgroupfs file readings. It also strengthens test coverage by scattering
charges across multiple CPUs.

> diff --git a/tools/testing/selftests/cgroup/memcg_stat_cross_cpu.bpf.c b/=
tools/testing/selftests/cgroup/memcg_stat_cross_cpu.bpf.c
> new file mode 100644
> index 0000000000000..3c2acd49c16ba
> --- /dev/null
> +++ b/tools/testing/selftests/cgroup/memcg_stat_cross_cpu.bpf.c
> @@ -0,0 +1,86 @@
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
> +/*
> + * Declared here rather than taken from vmlinux.h, which only has them i=
f the
> + * build host's own kernel does.  A kernel without them is caught at run=
 time.
> + */
> +struct mem_cgroup *bpf_get_mem_cgroup(struct cgroup_subsys_state *css) _=
_ksym;
> +void bpf_put_mem_cgroup(struct mem_cgroup *memcg) __ksym;
> +void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg) __ksym;
> +unsigned long bpf_mem_cgroup_page_state(struct mem_cgroup *memcg, int id=
x) __ksym;
> +unsigned long bpf_mem_cgroup_vm_events(struct mem_cgroup *memcg,
> +				       enum vm_event_item event) __ksym;

[Severity: High]
This is a pre-existing issue, but does this kfunc allow an out-of-bounds ar=
ray
read?

The kfuncs bpf_mem_cgroup_memory_events() and bpf_mem_cgroup_vm_events() la=
ck
negative bounds checks for their enum parameters. A BPF program can pass a
negative integer as the enum parameter to bpf_mem_cgroup_vm_events().

This passes the negative enum to memcg_vm_event_item_valid() in mm/memcontr=
ol.c:

    if (idx >=3D NR_VM_EVENT_ITEMS)

This validation function omits a negative bounds check (e.g., missing an
unsigned cast). Because the BPF verifier evaluates enum parameters as signed
integers without an explicit lower bound check, negative values bypass the
check. This reaches memcg_events_index() and allows arbitrary memory offsets
to be read relative to the memcg arrays.

[ ... ]

> diff --git a/tools/testing/selftests/cgroup/test_memcg_stat_cross_cpu.c b=
/tools/testing/selftests/cgroup/test_memcg_stat_cross_cpu.c
> new file mode 100644
> index 0000000000000..9946c41c7a908
> --- /dev/null
> +++ b/tools/testing/selftests/cgroup/test_memcg_stat_cross_cpu.c

[ ... ]

> +static int add_node(const char *path, bool is_leaf)
> +{
> +	struct cg_node *n =3D &nodes[n_nodes];
> +
> +	if (cg_create(path))
> +		return -1;
> +
> +	strncpy(n->path, path, sizeof(n->path) - 1);
> +	n->id =3D cg_get_id(path);
> +	n->is_leaf =3D is_leaf;
> +	if (is_leaf)
> +		n_leaves++;
> +	n_nodes++;
> +	return 0;
> +}
> +
> +/* Create # @levels more levels below @path.
> + * Only the last level is charged.
> + */

[Severity: Low]
Does this multi-line comment style follow the BPF and kernel guidelines?
The preferred style requires the opening /* to be on its own line:

/*
 * Create # @levels more levels below @path.
 * Only the last level is charged.
 */

> +static int build_children(const char *path, int fanout, int levels)
> +{
> +	char child[PATH_MAX];
> +	int i;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814075054.5070=
89-1-ziyang.meme@gmail.com?part=3D2
