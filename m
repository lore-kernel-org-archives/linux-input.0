Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004733EFD05
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948272; cv=none; b=jIfdos7+DMB2LflSpa4ik6DXeiVqBzX7dIlWIzAU+ooiBVhx6P9lqaa7vp8aY07XwTKMob493xsxatTCCM3BDmrGR0mhDKJvub6B0VfDlgZeVNF2EBJLo376m1DqXbc41ub0wTW2BqA29mfkGJwo2kirvvkTrcihXGYtqXh0Y2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948272; c=relaxed/simple;
	bh=6g4MFCyn0InZsYBBiZi2fxd9iAJrrdGPEUCAbG9AYTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcinXM8yphWfoztlrbH5MxTFaI9P3LZqtNR37DoH7xqwwxtdJrRWII2Hwvb+RHVtXxWhSO0ckJvUMFfAo+wbrKPUChFWC+dRFwS508y/QXHsQ/dpcjJ4flFuYB7bCyjiL+CIvJgnIryCRtJkLtCoVkMfEpl9P3BQsPDxUKb90dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ItkoCC4o; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ItkoCC4o"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768948264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zwz6Xowq2w+xpgQwCp0JYB93ToE2U9fbiwcFD+udSuM=;
	b=ItkoCC4oP2usaDYzXGu8P3mjEmTJipyfTGZ5CGPuQlsPi3QilxwLus1Ke4c8gvkqbXZ62V
	UfODoABIEX4gTSneXoZHYHANn7wWmBPqh1uW6UVc2RG0O6wxZ6KmGpW65kEnFy2AXo3Ijg
	zCxAD96eeDVpwUfuooi0jP9QQ6EN07M=
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
Subject: [PATCH bpf-next v3 13/13] bpf,docs: Document KF_IMPLICIT_ARGS flag
Date: Tue, 20 Jan 2026 14:30:26 -0800
Message-ID: <20260120223027.3981805-1-ihor.solodrai@linux.dev>
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

Add a section explaining KF_IMPLICIT_ARGS kfunc flag. Remove __prog
arg annotation, as it is no longer supported.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 Documentation/bpf/kfuncs.rst | 49 +++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 3eb59a8f9f34..75e6c078e0e7 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -232,23 +232,6 @@ Or::
                 ...
         }
 
-2.3.6 __prog Annotation
----------------------------
-This annotation is used to indicate that the argument needs to be fixed up to
-the bpf_prog_aux of the caller BPF program. Any value passed into this argument
-is ignored, and rewritten by the verifier.
-
-An example is given below::
-
-        __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
-                                                 int (callback_fn)(void *map, int *key, void *value),
-                                                 unsigned int flags,
-                                                 void *aux__prog)
-         {
-                struct bpf_prog_aux *aux = aux__prog;
-                ...
-         }
-
 .. _BPF_kfunc_nodef:
 
 2.4 Using an existing kernel function
@@ -381,6 +364,38 @@ encouraged to make their use-cases known as early as possible, and participate
 in upstream discussions regarding whether to keep, change, deprecate, or remove
 those kfuncs if and when such discussions occur.
 
+2.5.9 KF_IMPLICIT_ARGS flag
+------------------------------------
+
+The KF_IMPLICIT_ARGS flag is used to indicate that the BPF signature
+of the kfunc is different from it's kernel signature, and the values
+for implicit arguments are provided at load time by the verifier.
+
+Only arguments of specific types are implicit.
+Currently only ``struct bpf_prog_aux *`` type is supported.
+
+A kfunc with KF_IMPLICIT_ARGS flag therefore has two types in BTF: one
+function matching the kernel declaration (with _impl suffix in the
+name by convention), and another matching the intended BPF API.
+
+Verifier only allows calls to the non-_impl version of a kfunc, that
+uses a signature without the implicit arguments.
+
+Example declaration:
+
+.. code-block:: c
+
+	__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct bpf_task_work *tw,
+						      void *map__map, bpf_task_work_callback_t callback,
+						      struct bpf_prog_aux *aux) { ... }
+
+Example usage in BPF program:
+
+.. code-block:: c
+
+	/* note that the last argument is omitted */
+        bpf_task_work_schedule_signal(task, &work->tw, &arrmap, task_work_callback);
+
 2.6 Registering the kfuncs
 --------------------------
 
-- 
2.52.0

