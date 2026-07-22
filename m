Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C00C459AC1
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 23:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763364; cv=none; b=I9nAntfV7O2lzpdoEt0+K7lIvlEzRyBSjdkbDtFbkauuUNcDCSWS2krWT0t1Xz2B29m/RHealW0lrQH8njopo2ApFaxivROJu4CiGSzmHHvgRW549mZevl7CMfTNIeHfU2Yw7OJMy/0sJMrpZMVzuO3cnbKGgcdAIlVNQGCwOU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763364; c=relaxed/simple;
	bh=GamW1VwKvhKJeT/6CK2u8DdO2/TMjN3bJls3oHrWt/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q89IYOlt+VcdzKgddfE0f9itIoPESQIg672WZOpyoo4NWl/tk1P8vMWySB2M30/BzTqjGRr8PdFu44cVCOKtkPujn3uEomL3j0C2NMgcZOCFrqkLVX7jhcK4CTMN2Zn8TQ1Oe51/bnYDwlPJ1FNE8RL+C6/JANQp1FHpD2qQZdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TeXRZVl6; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TeXRZVl6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784763361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTfkRdtMdkcOuL/IvPO/EoGmDNTqaSXpsalOp4NmLbs=;
	b=TeXRZVl6WmqHLCDF/CYf6nJzSLRQXgIfIBSB5IGXNXfqvGwloPMynXjwCDzXhZkSI3Ntc4
	U0Wo1cuJSs0APCB2QTiSVHJFybnh5bIl9N6ElKBEjBNcwEqSnxoWtBjZNKQShsMzMuca7u
	BxBXXM3ZtiWjk2OcdAqVO3z/G/IAABQ=
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
Subject: [PATCH bpf-next v1 5/8] resolve_btfids: Fix the _impl lookup for module BTF
Date: Wed, 22 Jul 2026 16:35:15 -0700
Message-ID: <20260722233518.778854-6-ihor.solodrai@linux.dev>
In-Reply-To: <20260722233518.778854-1-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

process_kfunc_with_implicit_args() skips generating <name>_impl
function when one already exists for backwards compatibility.

It uses btf__find_by_name_kind(), which searches the base BTF before
the split BTF. When resolve_btfids processes a module, a same-named
_impl in vmlinux would be found and the module's own counterpart would
not be created.

Fix by using btf__find_by_name_kind_own() for the lookup.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index de4986e1bc3d..ab3ab3045592 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -1232,7 +1232,7 @@ static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct
 		return -E2BIG;
 	}
 
-	if (btf__find_by_name_kind(btf, tmp_name, BTF_KIND_FUNC) > 0) {
+	if (btf__find_by_name_kind_own(btf, tmp_name, BTF_KIND_FUNC) > 0) {
 		pr_debug("resolve_btfids: function %s already exists in BTF\n", tmp_name);
 		goto add_new_proto;
 	}
-- 
2.55.0

