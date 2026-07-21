Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE674D90BE
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 17:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656119; cv=none; b=mn4ZvscsfqmpzZkMk46DFRLjKS8Ff3qfR0LZg+UKppr2HXKNLuzrPGP8/fFfUO7u8nQ5uh/tr+RWlaoFT56ieTM3iwtnbaI8mSyuUBcmPYQ4rH4hzbag4HxEqGJbZ7H88WYT6fboh8WfuoGHFFfMyPY94qS3/UkeiuRGd30fEuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656119; c=relaxed/simple;
	bh=uxpBSxsdvw9bPVWAq3FN82g9IP6N274Ej/qPp1bMJpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nusOs530RvdBdWdlD1gP2NJvzLVUm0/+PW/TRJbIABvi2MkiThp7rJTbrZtVLK8GsNLu6lEQj/3l1itnXTAQC9i+I7ttvNuzk018IrUEK8LWVzbTG1Qb2Xln4QefDhd3lh9T+0EEHjQyBpQVoUsoSsWs47pGP97aQd0abqDPuaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adc95vtt; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adc95vtt"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3810f0aba07so6527313a91.1
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 10:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784656117; x=1785260917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ocH8UcOo4UY0LfArAy9N9P4eBtmhXMCHbqhRio/RB1c=;
        b=adc95vttj0/YNjk4MoS4Zb8a3M5zg/8jr0y73daEoFbRMFM0P2ix2+VzbCCIAGtH8E
         uGhl9n8BXZuJd/vHLZytXIPXkIIENYn0DdoYfE+VoVgkhA4ecMNlH8iBGhBXiLSRE1x2
         PS5RvT8xm5X4i12zKUkZtoN5ef2lSTYWbEhDSD1yBn0rZ9LSUV6Zw1hx9GVuM3+rk3IW
         2UrhzoicubpKG1QwVcAVRSYaJbs4R9DnCzDGHqcfC3zXptVZv9MRcxXXSl+4WzzNDhQU
         tfNTkAfGJGrOlRhoFtuafM/IFvxdH6ZWfv468xGNALByVs61O5wg5DGeJGYFmkJpxHPQ
         dKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656117; x=1785260917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ocH8UcOo4UY0LfArAy9N9P4eBtmhXMCHbqhRio/RB1c=;
        b=SOxqdC/NDnLveYHdoeGz8xR8kkQ6EyTtDT9PNbe20igHMArFFtd3BKhuOu9wUc/ld9
         1+GXhEaC1rX2rOYba42YhwbuKZnqRuOtKAoWJklnirDu/MAiAB0OmqY0TTPMzqJhl9ya
         B0oR5gH9Ocf4evW/94t9ssAsO1gW8THfxJtzPivKe/5gOVjpVPRU3An7xi3pYLq/fSHD
         r56mUF0n7OLbi0bja1lEbLwLChE7yYQ0/4mtnm7Jy4NXGZc6zZ+2CWvDPcxGyxNluQcN
         0D+8deZWlTIGYVfraf7t3lFSdl7XZeOLvw6sjHVshKqj/2mx+j+31BPzYcGyG1m+12ss
         8Tpw==
X-Forwarded-Encrypted: i=1; AHgh+RrHWb8uVe4mVR0/2Zkuzsydn+sTgyDYJhbSSaFzSbfVIV3WoKDeo9VG9hGEjR1p567OmlFdf3C2QoIUaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsSzdwOxcEd0ujWD0m48oiPS5coOR0DWN0yOf2xH001hMlNVts
	1Zl7M+wU4Bb16D27Gye6MB1wIvrs7ukuvNT0IZxJwVJt1aHtZcfDbGyb
X-Gm-Gg: AR+sD10QqCd/Beyopl4q05K5irJNRLLcj9DL7a29uElcZAfhei3R0zKyWy+8N1YOMB9
	PP+05KwfRDED6lnZUI8lOTUi8vbWWtK+7BfguwkwJvuB5Mxv7YF4NudcF4JCLrySwbrBJSFUtZ3
	PhiCOGdubzfbHxtDkdETiQ7CflL8K3QpfZR79q0Vh1XQGACsiPfzy1lqcdM8li4oxysR7eSt6TJ
	Yfn7Y8NY1GvGIvYe2xjwNUEnayjDzDufSiehccTyeL9Fz9QNV0w6d7LIAZr5/kkGvT5HND77xQz
	9j43WoS5cYurDXNxey5Axytt4fZFRI8l+pJBi7L/zKiF7/wSf0KGEuHVKEcCKHdSAY+Zo75xQsQ
	EkfTsfro3dkXhVDrAd+8/MFcy1s+60kzYD6mx9v4W0VNCP0AKWaoVzwz5GqrA14glWOGRRGvt
X-Received: by 2002:a17:90b:3ccd:b0:38e:11ba:992e with SMTP id 98e67ed59e1d1-38e4b57dd07mr19138219a91.35.1784656116703;
        Tue, 21 Jul 2026 10:48:36 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:68::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29c2c93sm47964768c88.3.2026.07.21.10.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:48:36 -0700 (PDT)
From: Ziyang Men <ziyang.meme@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	David Vernet <void@manifault.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Mykola Lysenko <mykolal@meta.com>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-kselftest@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-input@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ziyang Men <ziyang.meme@gmail.com>
Subject: [PATCH v2 0/4] selftests: shared lib.bpf.mk for building BPF progs and skeletons
Date: Tue, 21 Jul 2026 10:48:29 -0700
Message-ID: <20260721174833.1232771-1-ziyang.meme@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series re-factors the bpf-related toolchain for selftests, which
currently duplicated across selftests/{bpf,sched_ext,hid}/. Unify them
into a single includable fragment, tools/testing/selftests/lib.bpf.mk,
and wires up three consumers. We believe this will simplify the work for
configuraing selftests with the bpf, for both the existing and future ones.

Patch 1 adds lib.bpf.mk: it builds the in-tree libbpf.a and a host
bpftool, generates vmlinux.h from the kernel's BTF, compiles *.bpf.c into
BPF objects and skeletons, and exports the include paths, a bpf_link
helper, and BPF_LDLIBS.  Use can control the behavior by several knobs
(source layout/suffix, extra headers/cflags, skeleton suffix,
subskeletons, output dirs) that can be used commonly in general cases.

Patch 2 adds a new selftest, test_memcg_stat_cross_cpu, under
selftests/cgroup. This test is a memory-cgroup statistics correctness
test that compares the memcg BPF kfuncs against memory.stat over a whole
cgroup subtree charged across many CPUs, and checks the cross-CPU rstat
flush. It is the first in-tree consumer of lib.bpf.mk outside
selftests/bpf.

Patches 3 and 4 convert the duplicated parts in Makefile for two
existing duplicating bpf consumers, the selftests/hid and
selftests/sched_ext, to lib.bpf.mk.  The generated skeletons keep
a byte-identical public API and land in the same locations as before.
The folders build cleanly under both plain make and LLVM=1.

Changes since v1:
  - Generalized lib.bpf.mk (source layout/suffix, extra hdrs/cflags,
    skeleton suffix, subskeletons, configurable output dirs) so it can
    serve hid and sched_ext, not just cgroup.
  - Added patch 3 (hid) and patch 4 (sched_ext), converting those folders
    to the shared fragment.

Ziyang Men (4):
  selftests: add shared lib.bpf.mk to build BPF progs and skeletons
  selftests/cgroup: add memcg_stat_cross_cpu correctness test for flush
  selftests/hid: build the BPF program via the shared lib.bpf.mk
  selftests/sched_ext: build BPF schedulers via the shared lib.bpf.mk

 tools/testing/selftests/cgroup/.gitignore     |   6 +
 tools/testing/selftests/cgroup/Makefile       |  21 +
 tools/testing/selftests/cgroup/config         |   4 +
 .../selftests/cgroup/lib/cgroup_util.c        |  48 ++
 .../cgroup/lib/include/cgroup_util.h          |   1 +
 .../cgroup/memcg_stat_cross_cpu.bpf.c         |  86 ++
 .../selftests/cgroup/memcg_stat_cross_cpu.h   |  27 +
 .../cgroup/test_memcg_stat_cross_cpu.c        | 780 ++++++++++++++++++
 tools/testing/selftests/hid/Makefile          | 182 +---
 tools/testing/selftests/lib.bpf.mk            | 247 ++++++
 tools/testing/selftests/sched_ext/Makefile    | 153 +---
 11 files changed, 1275 insertions(+), 280 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/memcg_stat_cross_cpu.bpf.c
 create mode 100644 tools/testing/selftests/cgroup/memcg_stat_cross_cpu.h
 create mode 100644 tools/testing/selftests/cgroup/test_memcg_stat_cross_cpu.c
 create mode 100644 tools/testing/selftests/lib.bpf.mk


base-commit: 6eb8711ece2ce27e52e327a5b7a628ed39b97f45
-- 
2.53.0-Meta

