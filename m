Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370253DA7EC;
	Tue, 20 Jan 2026 22:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948063; cv=none; b=q9GqXnKP/r70zY967QqnN1rhNbuoMSSfIte6g5OSW++B2s7/n7q1VX76x/9J5P8cyeLX0eWvIJRPdSXqffqml1ZsiujHeKvAfpNgr91DvZr4wCtLqBCEwSTHItzcGV3TFPGP01jeGduEvLcMS+psBrsuv1Y2+svHnsdzxwDQzvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948063; c=relaxed/simple;
	bh=Lgi/7TN0nAFd8pQZKq123W62uVpFkclyfvzL1sHFdds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSfqHWs+rG+Re23CUPR5iY/8+9HOEVr8NVmYAcHrZ48xglZedMJ2aAI4Ld201+JfQljSPEIdWwLH2mcSMnA6jzxhojxs1i0qBf6PdwRsFFkxNTesu/kbp4HYNiMuIlaN5shX4vaWmOoIiFkL84yW3JC7DjsbGBPWaRp3PFVm7BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VmPAgdDv; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VmPAgdDv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768948053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8Pd0FWnxLlu1cbnVUCep7TIFu5V8I8OdSQJEDTQooM=;
	b=VmPAgdDvG+ErKED72vCxtq2FasHacXoWoDUOwxXsPa3ZX0CyA6mtTsdLXkQjSpNY1V0C/o
	TKExYY7dsLgdV2dg0Fkmoavb7TjzLpuGMHTWfCYV4X4gt7T0Yvq/TOxo3pBc9b0pN/5/lR
	2FED61IzBDJf/Vv2ZmKvENihv9nVUQg=
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
Subject: [PATCH bpf-next v3 08/13] HID: Use bpf_wq_set_callback kernel function
Date: Tue, 20 Jan 2026 14:26:33 -0800
Message-ID: <20260120222638.3976562-9-ihor.solodrai@linux.dev>
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

Remove extern declaration of bpf_wq_set_callback_impl() from
hid_bpf_helpers.h and replace bpf_wq_set_callback macro with a
corresponding new declaration.

Tested with:
  # append tools/testing/selftests/hid/config and build the kernel
  $ make -C tools/testing/selftests/hid
  # in built kernel
  $ ./tools/testing/selftests/hid/hid_bpf -t test_multiply_events_wq

  TAP version 13
  1..1
  # Starting 1 tests from 1 test cases.
  #  RUN           hid_bpf.test_multiply_events_wq ...
  [    2.575520] hid-generic 0003:0001:0A36.0001: hidraw0: USB HID v0.00 Device [test-uhid-device-138] on 138
  #            OK  hid_bpf.test_multiply_events_wq
  ok 1 hid_bpf.test_multiply_events_wq
  # PASSED: 1 / 1 tests passed.
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
  PASS

Acked-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 drivers/hid/bpf/progs/hid_bpf_helpers.h             | 8 +++-----
 tools/testing/selftests/hid/progs/hid_bpf_helpers.h | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/bpf/progs/hid_bpf_helpers.h b/drivers/hid/bpf/progs/hid_bpf_helpers.h
index bf19785a6b06..228f8d787567 100644
--- a/drivers/hid/bpf/progs/hid_bpf_helpers.h
+++ b/drivers/hid/bpf/progs/hid_bpf_helpers.h
@@ -33,11 +33,9 @@ extern int hid_bpf_try_input_report(struct hid_bpf_ctx *ctx,
 /* bpf_wq implementation */
 extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
 extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
-extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
-		int (callback_fn)(void *map, int *key, void *value),
-		unsigned int flags__k, void *aux__ign) __ksym;
-#define bpf_wq_set_callback(wq, cb, flags) \
-	bpf_wq_set_callback_impl(wq, cb, flags, NULL)
+extern int bpf_wq_set_callback(struct bpf_wq *wq,
+		int (*callback_fn)(void *, int *, void *),
+		unsigned int flags) __weak __ksym;
 
 #define HID_MAX_DESCRIPTOR_SIZE	4096
 #define HID_IGNORE_EVENT	-1
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index 531228b849da..80ab60905865 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -116,10 +116,8 @@ extern int hid_bpf_try_input_report(struct hid_bpf_ctx *ctx,
 /* bpf_wq implementation */
 extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
 extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
-extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
-		int (callback_fn)(void *map, int *key, void *wq),
-		unsigned int flags__k, void *aux__ign) __weak __ksym;
-#define bpf_wq_set_callback(timer, cb, flags) \
-	bpf_wq_set_callback_impl(timer, cb, flags, NULL)
+extern int bpf_wq_set_callback(struct bpf_wq *wq,
+		int (*callback_fn)(void *, int *, void *),
+		unsigned int flags) __weak __ksym;
 
 #endif /* __HID_BPF_HELPERS_H */
-- 
2.52.0

