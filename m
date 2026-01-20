Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FFB47B439
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 22:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948079; cv=none; b=AQI8jhedyt+JmH43FwF5xH4xLzuVhKnnfCNZygSJLFVfZw4eFfmmvHn2Sf9aqts7SNfpKyFetXzx1jfCbnMegS4a6+Rrf6C+PMV8wQdKT+BPzKFrbeybMdVkKFm8nYSLXV8gFIyujCQAGGHpbfBiDwyheRBM9gk3cxGk4kaJM1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948079; c=relaxed/simple;
	bh=eUAfPdGXyQRz0rjVGmi96XftVSrHwzVs3caJiX5V8UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gf10XLDeMUSf4JTfQSgqiar0GKbRA634FLP+Sb6lCRMpPAS7hVkWYdW3dglwGPQhrivr6dTtKzZsReRQjhuWX5fqfkjARGI/a/NYvc5CR0bMaVD4KRnFYsKhDrx7LhIf5I0ZdTgt8Xtja6rP70QrFTwwaF+kqKcMTVx1yY5f8Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W8Vk+SYW; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W8Vk+SYW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768948070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGoBQkuCKCEj5+fAzaxNTPG8h5blUlfGkfdUxh4ZxsQ=;
	b=W8Vk+SYWYzOqW+DjUgah8PAGO9XIZ97fQSF33bF6AxpTUfrFRTvQrRwEBCLgeYXCR1e3nD
	dcIyrywUSNKJZXj6gvb+3LSe51XoECNefwW7RjUcdishYYh+sjQKmBFJt4gaocDhf8C/4Y
	bKP+M+RysOsCM0czUY9ZLoLyi+6mM2k=
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
Subject: [PATCH bpf-next v3 12/13] bpf: Remove __prog kfunc arg annotation
Date: Tue, 20 Jan 2026 14:26:37 -0800
Message-ID: <20260120222638.3976562-13-ihor.solodrai@linux.dev>
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

Now that all the __prog suffix users in the kernel tree migrated to
KF_IMPLICIT_ARGS, remove it from the verifier.

See prior discussion for context [1].

[1] https://lore.kernel.org/bpf/CAEf4BzbgPfRm9BX=TsZm-TsHFAHcwhPY4vTt=9OT-uhWqf8tqw@mail.gmail.com/

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/verifier.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8e8570e9d167..919556614505 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12211,13 +12211,6 @@ static bool is_kfunc_arg_irq_flag(const struct btf *btf, const struct btf_param
 	return btf_param_match_suffix(btf, arg, "__irq_flag");
 }
 
-static bool is_kfunc_arg_prog_aux(const struct btf *btf, const struct btf_param *arg);
-
-static bool is_kfunc_arg_prog(const struct btf *btf, const struct btf_param *arg)
-{
-	return btf_param_match_suffix(btf, arg, "__prog") || is_kfunc_arg_prog_aux(btf, arg);
-}
-
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name)
@@ -13280,8 +13273,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		if (is_kfunc_arg_ignore(btf, &args[i]))
 			continue;
 
-		if (is_kfunc_arg_prog(btf, &args[i])) {
-			/* Used to reject repeated use of __prog. */
+		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
+			/* Reject repeated use bpf_prog_aux */
 			if (meta->arg_prog) {
 				verifier_bug(env, "Only 1 prog->aux argument supported per-kfunc");
 				return -EFAULT;
-- 
2.52.0

