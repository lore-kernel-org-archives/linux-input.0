Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC9730F815
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763359; cv=none; b=C7xQb3R/dLxsjferXVU6GbCCkWBtVAb7MBYmc5JwUdkRi05UGHy+NthuKTsLFUjS41P5PRwWY0VOGF3ifdhTRF6/7VjqroLcL7gI2B5G9Jdpoc1+VPDR844wdJ5Lo79sNz33rvyuSV/iFLSB5vThAAHZA4ngNQoNmUJrG36w4zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763359; c=relaxed/simple;
	bh=+6nrRUl+nb6CB46Ki0q8u2QV2ArmuiE/a3sk7aPHJ+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XIFKsar+M58Nz7V2HlDh4LyO8d9p4+b9mKQda0N7JOcJZ/ZZS6oHakPSsdPKQL7W1sgtubXWQETM8vfwiKI3MBLcfSzsz5tOpzMlu0ZkjA82IWyIqjyjn36fpvEb7wPdFbGrbBOlBUMwvlf8xb/BblEST1aD+d9Y1AHCxmbF+1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vKWa+FfJ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vKWa+FfJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784763342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NgI+gfup+TjKVDPQyrdgKmtyikCiowwWkOH+vs8Rbvw=;
	b=vKWa+FfJ6G9Gal/45CaDpS4JjRBefAKseHNonF4KB3fjRCvwbn8/maMYU/aFIyJx52+FqE
	KUWdawIM+Ang6ayfoScaVIeRWJahqxCNtdibHcxHisyyqT3IGgcM46T0gza3CZhjh/F6Vs
	0qX727uDqnSxS5I1f18MpEvcyD+I3Ss=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-input@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/8] resolve_btfids: Discover kfuncs from BTF ID sets
Date: Wed, 22 Jul 2026 16:35:10 -0700
Message-ID: <20260722233518.778854-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series develops resolve_btfids in preparation for bringing
kernel-specific BTF transformations in tree, which will reduce kbuild
dependency on pahole's features.

resolve_btfids currently identifies kfuncs by reading the "bpf_kfunc"
decl tags pahole emits into vmlinux BTF. The series switches the
source of truth to the BTF ID sets registered with
BTF_KFUNCS_START()/END() in the kernel, which is the mechanism BPF
verifier uses.

The series is based on patches #5 and #6 from the original
"resolve_btfids: Implement BTF tags emission for kfuncs" series [1],
and includes a few significant additions. Particularly the build time
enforcement of kfunc flags consistency [2].

The series consists of:
  - patches #1-#3 implement supporting infrastructure for the proper
    kfunc discovery and deduplication
  - patches #4-#5 expose btf__find_by_name_kind_own() and use it to
    fix a latent bug in _impl func lookup
  - patch #6 fixes inconsistent kfunc flags for HID kfuncs
  - patch #7 implements kfunc discovery from BTF ID sets
  - patch #8 adds enforcement of kfunc flags consistency

The resolve_btfids selftests patches have landed earlier [3].

[1] https://lore.kernel.org/bpf/20260601221805.821394-1-ihor.solodrai@linux.dev/
[2] https://lore.kernel.org/bpf/9b2196dd-443b-4632-ae11-030cdbdc59b4@linux.dev/
[3] https://lore.kernel.org/bpf/20260617210619.1562858-1-ihor.solodrai@linux.dev/

---

Changes compared to [1]:
  - Drop the idempotency (ensure_*) machinery: assume valid input BTF (Andrii)
  - Use rbtree to store the kfuncs (Andrii)
  - Enforce full KF_* flag consistency as a build error (Eduard)
  - Various cleanups and nits (Andrii, Emil, Jiri)

---

Ihor Solodrai (8):
  resolve_btfids: Implement generic ensure_mem() to grow arrays
  resolve_btfids: Index BTF ID symbols by address
  resolve_btfids: Keep collected kfuncs in a rbtree
  libbpf: Export btf__find_by_name_kind_own()
  resolve_btfids: Fix the _impl lookup for module BTF
  HID: bpf: Make syscall kfunc flags match the struct_ops set
  resolve_btfids: Discover kfuncs from BTF ID sets
  resolve_btfids: Enforce consistent kfunc flags across BTF ID sets

 drivers/hid/bpf/hid_bpf_dispatch.c |  10 +-
 tools/bpf/resolve_btfids/main.c    | 275 ++++++++++++++++++-----------
 tools/lib/bpf/btf.h                |   2 +
 tools/lib/bpf/libbpf.map           |   1 +
 tools/lib/bpf/libbpf_internal.h    |   2 -
 5 files changed, 181 insertions(+), 109 deletions(-)

-- 
2.55.0

