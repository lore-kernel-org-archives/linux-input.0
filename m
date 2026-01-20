Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA64466B62
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948054; cv=none; b=QRephh6MLLQiIUTX+0k/zqQk37vw+n8TjcqsAQERGzDYbB1i9KVvqYR7v51URzmeUkxQ6pcYPtHLBm+v2U2o4ch/sMCWJEzYeYcPSf1Ml0aV4w0uXyYWNe3vGmcSxJsu2cdJX5bvWWW4Q3N74I+mQPHxAY8NWwkpIFVARF7qkAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948054; c=relaxed/simple;
	bh=gj6reRIBenGEhVSvuRPrvqy7Cr2UXz1ceVpyEXVAJhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3qqhlOvN0ymuqdN91bt1wunzdmxrQ254OiiKsLTt44DGxdP+eDXKXr6HUtFblN3B1jIkip44cjDU+6tOuK7+A8LfmnWUNTZS5cjswUYY0SReC8mibURwIn16gCxlTybg2V60weCtPYh4NpFAm+QwTY3PRIf3NY41+LE8iWqPI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pi/UPrTK; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pi/UPrTK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768948046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97FuF/fff1eb0jGFSo1fap5QARKBSb9jyQQD9qR9ADI=;
	b=pi/UPrTKmm7MFk9AnERixri2hRMwstafTZNFtYaWjAb5eBGehYdixvnp8mENcC+VAYjG5P
	1l5xT/Iw/g8xRDJlLFDKQQMfW9xABOqgXg5Efkf0nstn+LPy8lN2H3cqidBvBlhf6hR6H5
	xjFS4A+4VoFavaG8wepcZYEhXVbzK1Y=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Tejun Heo <tj@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v3 06/13] selftests/bpf: Add tests for KF_IMPLICIT_ARGS
Date: Tue, 20 Jan 2026 14:26:31 -0800
Message-ID: <20260120222638.3976562-7-ihor.solodrai@linux.dev>
In-Reply-To: <20260120222638.3976562-1-ihor.solodrai@linux.dev>
References: <20260120222638.3976562-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add trivial end-to-end tests to validate that KF_IMPLICIT_ARGS flag is
properly handled by both resolve_btfids and the verifier.

Declare kfuncs in bpf_testmod. Check that bpf_prog_aux pointer is set
in the kfunc implementation. Verify that calls with implicit args and
a legacy case all work.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../bpf/prog_tests/kfunc_implicit_args.c      | 10 +++++
 .../selftests/bpf/progs/kfunc_implicit_args.c | 41 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 26 ++++++++++++
 3 files changed, 77 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/kfunc_implicit_args.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args.c b/tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args.c
new file mode 100644
index 000000000000..5e4793c9c29a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "kfunc_implicit_args.skel.h"
+
+void test_kfunc_implicit_args(void)
+{
+	RUN_TESTS(kfunc_implicit_args);
+}
diff --git a/tools/testing/selftests/bpf/progs/kfunc_implicit_args.c b/tools/testing/selftests/bpf/progs/kfunc_implicit_args.c
new file mode 100644
index 000000000000..89b6a47e22dd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kfunc_implicit_args.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+extern int bpf_kfunc_implicit_arg(int a) __weak __ksym;
+extern int bpf_kfunc_implicit_arg_impl(int a, struct bpf_prog_aux *aux) __weak __ksym; /* illegal */
+extern int bpf_kfunc_implicit_arg_legacy(int a, int b) __weak __ksym;
+extern int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, struct bpf_prog_aux *aux) __weak __ksym;
+
+char _license[] SEC("license") = "GPL";
+
+SEC("syscall")
+__retval(5)
+int test_kfunc_implicit_arg(void *ctx)
+{
+	return bpf_kfunc_implicit_arg(5);
+}
+
+SEC("syscall")
+__failure __msg("cannot find address for kernel function bpf_kfunc_implicit_arg_impl")
+int test_kfunc_implicit_arg_impl_illegal(void *ctx)
+{
+	return bpf_kfunc_implicit_arg_impl(5, NULL);
+}
+
+SEC("syscall")
+__retval(7)
+int test_kfunc_implicit_arg_legacy(void *ctx)
+{
+	return bpf_kfunc_implicit_arg_legacy(3, 4);
+}
+
+SEC("syscall")
+__retval(11)
+int test_kfunc_implicit_arg_legacy_impl(void *ctx)
+{
+	return bpf_kfunc_implicit_arg_legacy_impl(5, 6, NULL);
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index bc07ce9d5477..a996b816ecc4 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1142,6 +1142,10 @@ __bpf_kfunc int bpf_kfunc_st_ops_inc10(struct st_ops_args *args)
 __bpf_kfunc int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id);
 __bpf_kfunc int bpf_kfunc_multi_st_ops_test_1_impl(struct st_ops_args *args, void *aux_prog);
 
+__bpf_kfunc int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux);
+__bpf_kfunc int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bpf_prog_aux *aux);
+__bpf_kfunc int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, struct bpf_prog_aux *aux);
+
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
@@ -1184,6 +1188,9 @@ BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epilogue, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10)
 BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1)
 BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1_impl)
+BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy_impl)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
@@ -1675,6 +1682,25 @@ int bpf_kfunc_multi_st_ops_test_1_impl(struct st_ops_args *args, void *aux__prog
 	return ret;
 }
 
+int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux)
+{
+	if (aux && a > 0)
+		return a;
+	return -EINVAL;
+}
+
+int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bpf_prog_aux *aux)
+{
+	if (aux)
+		return a + b;
+	return -EINVAL;
+}
+
+int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, struct bpf_prog_aux *aux)
+{
+	return bpf_kfunc_implicit_arg_legacy(a, b, aux);
+}
+
 static int multi_st_ops_reg(void *kdata, struct bpf_link *link)
 {
 	struct bpf_testmod_multi_st_ops *st_ops =
-- 
2.52.0

