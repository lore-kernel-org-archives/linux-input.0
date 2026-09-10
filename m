Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E867C3403EE
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 23:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789083214; cv=none; b=dB483e4IRCptgCcRSgsOpnCgJ8Mk+C9/1jEUlAZEFUSd040dty+03q3/go483gT/qgR08TbDzDBzpW83fN6wRJuInBkvmy28p5he73z1QzNe94svHF0HeRVAmzJ+P5eyR8XZ9B9r3AZxQ7lQVTpKc9B9oUGhqAsSSuOrT9e1S6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789083214; c=relaxed/simple;
	bh=jDLmLkCeczOtHajVFOa0utVXnzToYKkhGjYJJdHBMOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UP1dStmm96RRQTewxqKEfbHaSK+vg/r/8DyK8wAXJuqfSs8qVYgC038MXdKdc2bqR11/LcPvYBqGNffloeSqRYXIikZLV106+yuOIvqTsjKCrRWx8toKX1QH/D8mc4f+UxkTD4JD4WqwuL/hyH3Pl1kzWKPvXryMWyOxKnnTnSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6cKpfKP; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6cKpfKP"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso322987a12.3
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 16:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789083210; x=1789688010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0E1uJRWOdeWeFR64RXVnaSEl2Q3657otbvouJpAZYtg=;
        b=T6cKpfKPSVFFLbougTCXQWlvwzdIYFHwSIJsu/bxO56408WBmhZB7zBh2m9VAfmpO9
         9tn104D4qRIl+64E1HwGSgCZXtxGoPDT3+oET8cXARM+4jjUB1HaTnMWbhDQYcqCrjk4
         eeqGAzjmxdYa91wtYbUsDhbRij7N9i84AXXEEjE47eEuUrSjDa26X22MbY5vYjFBp2re
         42QREMZDaMcABKh4wXCtSIJjw1+PIiupAla/q2M+9eziLldzo3D9pGsl7StaRoG8MKhN
         g2xgND8rO7G25hHi1MtTINBw9EmldJKFkPrnuYNctMhQU/gIZHXbHiuGDeVerJPILaqE
         jCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789083210; x=1789688010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0E1uJRWOdeWeFR64RXVnaSEl2Q3657otbvouJpAZYtg=;
        b=RvFM9TPGHNLpzyOfK69s0sVxxOuHoxuekquSZUMGayRrGRs6SWt0GiWNVUB0ETyC5j
         3Lg8t7rf0QBMEJjqjMfR1ug0uUFnqLzGle33CIienrADq3h9dw6KcG+zeaqOOqBhsjce
         tMKW0p+dWaeXRLWIR+SEqvQmDLJJOnyWsGCpff/un7DBa9rSrsQ4FdI77bWvRSuKf+bW
         zwN5mPqdH5RBnIsgb0PIGrOHYi+VMp6oVwoNf/Cfm2pP37z4abnibVlxdT/GGDElOddn
         rTgfHy+6DRSm3RUBpU1q/Qk3DSrtBDgu7CR1V5b2TN7HGpDfzPR3Jf78tF8UKP8trAQW
         XgJw==
X-Forwarded-Encrypted: i=1; AKwUvByclYgjC/Q6FyLKcvdZD7y1fvfQVA03kUwRF0wrLxxDbU6GTgl7HzpXVmuE20gQw6lwhkD4RLEphWkhZg==@vger.kernel.org
X-Gm-Message-State: AFuF++l8ew3oc0VOirlnNPr0+v4JlcjX0BBB4n60ISsWLRMD9PCiqlRP
	TCaxIOUBvNVmIL70oPr0IBRBE4DphTzNKhgaPmTWyicZz8ZT8WZm+7nx
X-Gm-Gg: AYBFou13MY0+OXo6d2qAmATmBZMjAq1CwnP6myzrTSB+8KMHNOYvnA4B9wx1bHyaHVg
	xZPQwSrfyBdkpMJud/swaU789uvl2AB/w9/Xfpn8Lp2niZgOfJUv/PQM4jM9gr0lIuOSOckndZ0
	9vB6vKqyRTuI3d0qT8h3t4MjoEp/F3JZLm9ELm7vBq4huiiPELQk5qz2QgJojgX4bN5FywzmNl8
	N8g6DRpTFqZ0+sodpyXfIepiRyFQw3PxYGxI/lYVM2Gvz9YzrwxBgBlvnw5yo7U9FV9YnxdHtzh
	9yub0lbWvydBsYa5JKs17pC2hZCEltYReqF3TJiI0kf9DsTpUFw7QhfaJP8qxkD1ZaR204j2vTa
	xo6fCFodGLZaeT5Xo4m/HtM68szSu4NOH26i9IQ8B66jeuDIwMhOrF9XLzdXp3NBSRfGRfaDhfW
	stCcKLD52Jh3oTf+rZajuTtpGWaqrlt9rRw6hDvhT8FE4DALRrVzUDC8LlQmndhGo7TA==
X-Received: by 2002:a17:90b:4a8d:b0:39d:8222:6436 with SMTP id 98e67ed59e1d1-39d9bd8f51cmr1753897a91.7.1789083210158;
        Thu, 10 Sep 2026 16:33:30 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:43::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e95075sm1330595eec.11.2026.09.10.16.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 16:33:29 -0700 (PDT)
From: Ziyang Men <ziyang.meme@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	David Vernet <void@manifault.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Viktor Malik <vmalik@redhat.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Mykola Lysenko <mykolal@meta.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Ziyang Men <ziyang.meme@gmail.com>,
	kernel-team@meta.com,
	linux-kselftest@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-input@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] selftests: add shared Makefile for BPF selftests and a new memcg test
Date: Thu, 10 Sep 2026 16:32:59 -0700
Message-ID: <20260910233303.1063501-1-ziyang.meme@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series refactors the BPF-related build machinery that is currently
duplicated across selftests/{bpf,sched_ext,hid}/. It adds the shared
tools/testing/selftests/lib.bpf.mk fragment and wires up three consumers,
simplifying both existing BPF selftests and future additions.

The series also adds a cgroup memory-controller selftest that complements
the existing coverage.

Patch 1 adds lib.bpf.mk.

Patch 2 adds selftests/cgroup/test_memcg_stat_cross_cpu, which verifies a
cgroup flush by comparing values read through BPF memcg kfuncs with the
corresponding cgroupfs values. The existing bpf/cgroup_iter_memcg test only
checks whether selected values are non-zero.

Patches 3 and 4 replace the duplicated BPF build machinery in
selftests/{hid,sched_ext} with lib.bpf.mk.

===
Changes since v4:
- Apply Tejun's suggestion: make the vmlinux.h stamp a normal
  prerequisite so dependent BPF objects rebuild in the same make
  invocation when the header changes.
- Fix AI bot suggestion: assert in the BPF selftest that the memcg event
  enum argument types remain unsigned. This assert might not be
  necessary since these enum values are always uint32 on BTF.

===
Changes since v3:
For shared Makefile:
- Track in-tree libbpf headers directly so a single make invocation rebuilds
  BPF objects and skeletons after a header change.
- Restore the target definitions needed by LoongArch and MIPS cross builds.
- Validate output directories and skeleton suffixes, and reject dotted or
  hyphenated source stems before they reach build and cleanup rules.
- Add stamp tracking for vmlinux.h generation while preserving content-based
  header updates.
- Make skeletons and subskeletons explicit outputs, so a missing subskeleton is
  regenerated and both sets participate in the all target.
- Namespace private variables, expand the caller-visible contract, track a
  supplied VMLINUX_H, and remove unnecessary include search paths.

For cgroup selftest:
- Add CONFIG_BPF_EVENTS and probe every required kfunc plus the sleepable
  cgroup iterator before running.
- Bound CPU fanout, cgroup/process count, and total memory use; skip a case
  when the flush threshold would require more than 256 MiB.
- Check CPU discovery, polling, iterator creation, and BPF errors, with clearer
  diagnostics.
- Compare each BPF statistic against two following memory.stat samples, keeping
  exact equality on a quiet subtree while tolerating values that move between
  the two samples.

For hid and sched_ext:
- Remove unused HID locals instead of suppressing warnings, drop obsolete
  variables and comments, tighten cleanup, and correct the generated-output
  description.

===
Changes since v2:
For shared Makefile:
- Use USERCFLAGS and USERLDFLAGS to extend CFLAGS and LDFLAGS.
- Pass OPT_FLAGS/RELEASE and EXTRA_CFLAGS to the libbpf and bpftool sub-makes.
- Use one rule per BPF source instead of a global vpath that also affected the
  caller's normal %.c rules.
- Take HOSTCC/HOSTLD from lib.mk instead of including Makefile.include, which
  also rewrote the caller's AR, LD, and CFLAGS.
- Report a missing vmlinux from the recipe rather than at parse time, so
  "make clean" still works without BTF.

For cgroup selftest:
- Create one cgroup tree, perform one flush, then read through BPF and
  cgroupfs.
- Use common cgroup helpers such as cg_read_key_long() and values_close().
- Use cpu_set_t rather than manually allocated CPU lists.
- Move test_memcontrol.c's anonymous-memory allocator into cgroup_util.
- Address the remaining review feedback.

===
Changes since v1:
- Generalize lib.bpf.mk for source layouts and suffixes, extra headers and
  flags, skeleton suffixes, subskeletons, and configurable output directories.
- Add patch 3 (hid) and patch 4 (sched_ext), converting those directories to
  the shared fragment.

Ziyang Men (4):
  selftests: add shared lib.bpf.mk to build BPF progs and skeletons
  selftests/cgroup: add memcg_stat_cross_cpu correctness test for flush
  selftests/hid: build the BPF program via the shared lib.bpf.mk
  selftests/sched_ext: build BPF schedulers via the shared lib.bpf.mk

 tools/testing/selftests/cgroup/.gitignore     |   8 +
 tools/testing/selftests/cgroup/Makefile       |  46 ++
 tools/testing/selftests/cgroup/config         |   5 +
 .../selftests/cgroup/lib/cgroup_util.c        |  82 ++
 .../cgroup/lib/include/cgroup_util.h          |   3 +
 .../cgroup/memcg_stat_cross_cpu.bpf.c         | 101 +++
 .../selftests/cgroup/memcg_stat_cross_cpu.h   |  18 +
 .../cgroup/test_memcg_stat_cross_cpu.c        | 755 ++++++++++++++++++
 .../selftests/cgroup/test_memcontrol.c        |  29 +-
 tools/testing/selftests/hid/.gitignore        |   1 +
 tools/testing/selftests/hid/Makefile          | 179 +----
 tools/testing/selftests/hid/progs/hid.c       |   7 +-
 tools/testing/selftests/lib.bpf.mk            | 321 ++++++++
 tools/testing/selftests/sched_ext/Makefile    | 149 +---
 14 files changed, 1388 insertions(+), 316 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/memcg_stat_cross_cpu.bpf.c
 create mode 100644 tools/testing/selftests/cgroup/memcg_stat_cross_cpu.h
 create mode 100644 tools/testing/selftests/cgroup/test_memcg_stat_cross_cpu.c
 create mode 100644 tools/testing/selftests/lib.bpf.mk

-- 
2.53.0-Meta

