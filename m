Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68A0477E3F
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948073; cv=none; b=YJt6de5xLpV9dSZxsRE/J6ZrchxxObT0+wAohx8TDtyubVS+Cui6CzCXtFVe9nM13m3mxn2HZ3BGqQQAyYf4WnFoTb/kfzt4JH1nxTrPB9zBieCFcVEKzXmvshoh/IbHdxAKWl2GoWTEsm4T+BEYrFyDzFn16MBfmKB08BsUFDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948073; c=relaxed/simple;
	bh=IBU1b9T8tZlYk7zSYZEFYWOooygB9A6rB9lcQdEFYE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGMChTRthiweANYJkAk3ry0z5jMi4OKtqOVS0ifq4hZZm0f3omHSBZv4pbW1fbDAC9LM46vc/pXVuwzWUSTfHCy66F8MnZI10q2Gf9Z7a6d3PIMgqOrdt87wNrjoCgkj+0TnKHIuaMUNXphOROlGp3alSrrFefLM12LuVd0ZsJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SCbJm2V3; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SCbJm2V3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768948062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tGIEXChcIhv4Pr6wfHSmGHw+KH4GK6DXoM2pv/rWE1M=;
	b=SCbJm2V3TxiWK1C5JiEK6nB+4n8toJHZbr+igRAmXNLB3vXmXCbBXc+mwJ97RCF8a3xC05
	rIsV5UIXOuPgLiJphonWni8YilvOL5ad4IQj+JtJUsI4IpafZVL/ZAOc2RSZ3LyU0mQdLm
	T7DcbF6VfVX/olQuTnv9oR0v0W+atn4=
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
Subject: [PATCH bpf-next v3 10/13] bpf: Migrate bpf_stream_vprintk() to KF_IMPLICIT_ARGS
Date: Tue, 20 Jan 2026 14:26:35 -0800
Message-ID: <20260120222638.3976562-11-ihor.solodrai@linux.dev>
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

Implement bpf_stream_vprintk with an implicit bpf_prog_aux argument,
and remote bpf_stream_vprintk_impl from the kernel.

Update the selftests to use the new API with implicit argument.

bpf_stream_vprintk macro is changed to use the new bpf_stream_vprintk
kfunc, and the extern definition of bpf_stream_vprintk_impl is
replaced accordingly.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/helpers.c                            | 2 +-
 kernel/bpf/stream.c                             | 5 ++---
 tools/lib/bpf/bpf_helpers.h                     | 6 +++---
 tools/testing/selftests/bpf/progs/stream_fail.c | 6 +++---
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f2f974b5fb3b..f8aa1320e2f7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4533,7 +4533,7 @@ BTF_ID_FLAGS(func, bpf_strncasestr);
 #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
-BTF_ID_FLAGS(func, bpf_stream_vprintk_impl)
+BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 0b6bc3f30335..24730df55e69 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -212,14 +212,13 @@ __bpf_kfunc_start_defs();
  * Avoid using enum bpf_stream_id so that kfunc users don't have to pull in the
  * enum in headers.
  */
-__bpf_kfunc int bpf_stream_vprintk_impl(int stream_id, const char *fmt__str, const void *args,
-					u32 len__sz, void *aux__prog)
+__bpf_kfunc int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
+				   u32 len__sz, struct bpf_prog_aux *aux)
 {
 	struct bpf_bprintf_data data = {
 		.get_bin_args	= true,
 		.get_buf	= true,
 	};
-	struct bpf_prog_aux *aux = aux__prog;
 	u32 fmt_size = strlen(fmt__str) + 1;
 	struct bpf_stream *stream;
 	u32 data_len = len__sz;
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index d4e4e388e625..c145da05a67c 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -315,8 +315,8 @@ enum libbpf_tristate {
 			  ___param, sizeof(___param));		\
 })
 
-extern int bpf_stream_vprintk_impl(int stream_id, const char *fmt__str, const void *args,
-				   __u32 len__sz, void *aux__prog) __weak __ksym;
+extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
+			      __u32 len__sz) __weak __ksym;
 
 #define bpf_stream_printk(stream_id, fmt, args...)					\
 ({											\
@@ -328,7 +328,7 @@ extern int bpf_stream_vprintk_impl(int stream_id, const char *fmt__str, const vo
 	___bpf_fill(___param, args);							\
 	_Pragma("GCC diagnostic pop")							\
 											\
-	bpf_stream_vprintk_impl(stream_id, ___fmt, ___param, sizeof(___param), NULL);	\
+	bpf_stream_vprintk(stream_id, ___fmt, ___param, sizeof(___param));		\
 })
 
 /* Use __bpf_printk when bpf_printk call has 3 or fewer fmt args
diff --git a/tools/testing/selftests/bpf/progs/stream_fail.c b/tools/testing/selftests/bpf/progs/stream_fail.c
index 3662515f0107..8e8249f3521c 100644
--- a/tools/testing/selftests/bpf/progs/stream_fail.c
+++ b/tools/testing/selftests/bpf/progs/stream_fail.c
@@ -10,7 +10,7 @@ SEC("syscall")
 __failure __msg("Possibly NULL pointer passed")
 int stream_vprintk_null_arg(void *ctx)
 {
-	bpf_stream_vprintk_impl(BPF_STDOUT, "", NULL, 0, NULL);
+	bpf_stream_vprintk(BPF_STDOUT, "", NULL, 0);
 	return 0;
 }
 
@@ -18,7 +18,7 @@ SEC("syscall")
 __failure __msg("R3 type=scalar expected=")
 int stream_vprintk_scalar_arg(void *ctx)
 {
-	bpf_stream_vprintk_impl(BPF_STDOUT, "", (void *)46, 0, NULL);
+	bpf_stream_vprintk(BPF_STDOUT, "", (void *)46, 0);
 	return 0;
 }
 
@@ -26,7 +26,7 @@ SEC("syscall")
 __failure __msg("arg#1 doesn't point to a const string")
 int stream_vprintk_string_arg(void *ctx)
 {
-	bpf_stream_vprintk_impl(BPF_STDOUT, ctx, NULL, 0, NULL);
+	bpf_stream_vprintk(BPF_STDOUT, ctx, NULL, 0);
 	return 0;
 }
 
-- 
2.52.0

