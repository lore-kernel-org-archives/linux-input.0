Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF5459AFA
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763373; cv=none; b=OxGUvYvyJatuy8uHlOpQ/UhPbqEGDCVYKQUgAhqn30RQxaiiVkf0bDveBii8crrFowJeY73pZbHhAIS2nRbqy8gBf28UEEoNGTSWdcUpAtZu2gGywPlHAFrTkKrCA0JW8Mnqu2w+99neSMGJl8jxz/FV7Evcb+4pbf/cCQAdxn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763373; c=relaxed/simple;
	bh=+OsqSklz+h26lFDiyc0+zkuPZd9F+QtZpoU9ksl7yZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soc+/2zrZMzoAlFtIvAW9fsw0ocNxz/bCOXKvdlah1+fwV1hXutPr314Y5NOKiwoA5AQcjSgtpQ0Jgu7L0xGx0izdJpji7jRWtV2fuE/pI9aliLoPht3aufxhhD8y+3xqeLIZLggR7/UMPyDIajVVgxQzMTrF7jd0vZgoVcvoSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ip3MgW4s; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ip3MgW4s"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784763370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NbFhMw8mTF9XTBaJc+pI6iaYuc6QrdZGM+ilJ1QslIc=;
	b=Ip3MgW4sPl1tXIaZjq0RV4001el+Ki16tkZ8E2oCo0VAndUKM3F75ttKYPUQ6b3SlJhINC
	wwZjAfcxkjwE4BSt8htGCHt3iFuUh+PzYXtr5cY8Hl20VwMKX4Ard+2/FCQkvSESzW9BJ8
	6uGP0lo/nmslwf7i3sBnPjGfR1dyyCk=
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
Subject: [PATCH bpf-next v1 8/8] resolve_btfids: Enforce consistent kfunc flags across BTF ID sets
Date: Wed, 22 Jul 2026 16:35:18 -0700
Message-ID: <20260722233518.778854-9-ihor.solodrai@linux.dev>
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

A kfunc may be listed in several BTF ID sets, which is expected
because different kfuncs are available to BPF programs depending on
their type.

However kfunc flags across different BTF ID sets must be consistent [1].
The flags should be considered a part of the kfunc declaration,
because they influence its BTF representation and verifier handling.

Enforce the kfunc flag consistency in resolve_btifds by hard failing
on error and blocking kernel (or module) build.

[1] https://lore.kernel.org/bpf/9b2196dd-443b-4632-ae11-030cdbdc59b4@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 338d0c0a8e58..85488935909d 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -982,17 +982,26 @@ static int push_kfunc(struct btf2btf_context *ctx, struct kfunc *kfunc)
 	struct rb_node *parent = NULL;
 	struct kfunc *k;
 
-	/* Dedup by BTF ID: collecting the same kfunc twice is a no-op. */
+	/*
+	 * Dedup by BTF ID: collecting the same kfunc twice is a no-op,
+	 * UNLESS the kfunc flags are inconsistent, in which case we
+	 * fail hard because it indicates a bug in a kfunc set declaration.
+	 */
 	while (*p) {
 		parent = *p;
 		k = rb_entry(parent, struct kfunc, rb_node);
 
-		if (kfunc->btf_id < k->btf_id)
+		if (kfunc->btf_id < k->btf_id) {
 			p = &(*p)->rb_left;
-		else if (kfunc->btf_id > k->btf_id)
+		} else if (kfunc->btf_id > k->btf_id) {
 			p = &(*p)->rb_right;
-		else
+		} else if (k->flags == kfunc->flags) {
 			return 0;
+		} else {
+			pr_err("ERROR: resolve_btfids: kfunc %s has inconsistent flags across BTF ID sets: 0x%x != 0x%x\n",
+			       kfunc->name, k->flags, kfunc->flags);
+			return -EINVAL;
+		}
 	}
 
 	k = zalloc(sizeof(*k));
-- 
2.55.0

