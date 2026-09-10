Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D0546C835
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038610; cv=pass; b=cP3NPacnczWm3tMtW6Nee4uJX3A0WFLOLFVFjj106PDeKvLDalvXq5b8fn7opzshpO0UYJsaXhfHiQmCogRl6X3VgXlfmf812eWR8Pvpl9rdp85CjcY6LJeUyZoldiF3pOxNDDWh6vQ2Dt5JApCiatKrgmiCKC27oXqmx73b3Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038610; c=relaxed/simple;
	bh=W8rW8MfMaPsqyLtpA5UOYP32hBessOSZWe5oCOi4xCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZYaR6HMDwPiYCKJlM03sGcnBfZfSUCyuhzsHCUIg2TD85i84IJLB93jVQe2lcneEz4tZfJDg9Kftg//CjSNLRkitCD2/xE0p1Nf0faVYbO67KtvUTJq7PT7cBVD24ahaoVIcr+VUc9FcHUrc5ByO66/JurNUTFtDIOW8i6hZ8ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ririn.moe; spf=pass smtp.mailfrom=ririn.moe; dkim=pass (1024-bit key) header.d=ririn.moe header.i=ume@ririn.moe header.b=fkA6272z; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ririn.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ririn.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ririn.moe header.i=ume@ririn.moe header.b="fkA6272z"
ARC-Seal: i=1; a=rsa-sha256; t=1789038601; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BlI7yj2cTzqitcg1RyLjoFez3q6yI5n1FBgHprVEbpeVHuEtODo23S8fMuHVz/rDLwuVpLqUVHwJzUlGkSYUzre3KiTCIHVh9qZtRaTvciL/l+k8Lc18pqgGgg2dImZpTfya6QLOn44Qw/0dGKkYRd0Myj4/cSRSpDXc9X756oY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789038601; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qKKZgbOlQCsryI75PR/9wT+XobNyTyR48dUp/vjmzbk=; 
	b=M+bt9TmJsdCn/XEOmMYL0FscVqGhRSmMA2P9HBoye/YmAns5wSWm716pfJTWWy/nnZSaTQKcph4N8npik/NcMw7Uoh4GN6ZG9lsWVW8LKgUUqIVTn0i/orMrmZlO+NjdcpkmI2fF/sH/yGLBjtUBwPd51rpTN9IlzY6V867rRaQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ririn.moe;
	spf=pass  smtp.mailfrom=ume@ririn.moe;
	dmarc=pass header.from=<ume@ririn.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789038601;
	s=zmail; d=ririn.moe; i=ume@ririn.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=qKKZgbOlQCsryI75PR/9wT+XobNyTyR48dUp/vjmzbk=;
	b=fkA6272zZ7b1Q7OcCMyABUQewzB9rBS4zdQi7JhMd3Gt5MlcYLeogPkHkcucC6Y1
	51TmoU3KQP9c0DyX+MKnQhLBELcObQ5+qAYQapItUwHdGq8UON51grjp0uECEOswOAe
	6xDvrZp6XXe7TNRdhzMv1pPVaUTLqHQ5Cdzjo+Mk=
Received: by mx.zohomail.com with SMTPS id 1789038600669300.837404118411;
	Thu, 10 Sep 2026 04:10:00 -0700 (PDT)
From: Ririn Ume <ume@ririn.moe>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Nikhil Chatterjee <nikhilc1527@gmail.com>,
	linux-input@vger.kernel.org,
	Ririn Ume <ume@ririn.moe>
Subject: [PATCH] HID: bpf: Accept 123-byte pen descriptor in Huion Frego M quirk
Date: Thu, 10 Sep 2026 11:09:00 +0000
Message-ID: <20260910110900.142615-1-ume@ririn.moe>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The L610 pen descriptor is also seen 2 bytes shorter (123 bytes) than
the 125 bytes the quirk expects, so probe() rejects the device and the
fixup is never applied; the second side button stays reported as
Secondary Tip Switch.

The anchor bytes checked (offsets 0-3, 16-17) are the same in both
variants, so accept either length. The fixup still rewrites the usage
only after every anchor matches, leaving other layouts untouched.

Fixes: 857e71cb0a53 ("HID: bpf: Add Huion Inspiroy Frego M button quirk")
Signed-off-by: Ririn Ume <ume@ririn.moe>
---
 drivers/hid/bpf/progs/Huion__Inspiroy-Frego-M.bpf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/bpf/progs/Huion__Inspiroy-Frego-M.bpf.c b/drivers/hid/bpf/progs/Huion__Inspiroy-Frego-M.bpf.c
index e6ba2295dc77..d081b7c0b771 100644
--- a/drivers/hid/bpf/progs/Huion__Inspiroy-Frego-M.bpf.c
+++ b/drivers/hid/bpf/progs/Huion__Inspiroy-Frego-M.bpf.c
@@ -15,6 +15,12 @@
 #define PID_L610			0x2012
 
 #define PEN_RDESC_SIZE			125
+/*
+ * The L610 pen descriptor is also seen 2 bytes shorter (123 bytes); the
+ * anchor bytes checked below (offsets 0-3, 16-17) are the same in both
+ * variants, so accept either length.
+ */
+#define PEN_RDESC_SIZE_SHORT		123
 #define SECONDARY_SWITCH_OFFSET		17
 
 HID_BPF_CONFIG(
@@ -44,7 +50,7 @@ int BPF_PROG(fix_secondary_barrel_rdesc, struct hid_bpf_ctx *hctx)
 	if (!data)
 		return 0; /* EPERM check */
 
-	if (hctx->size != PEN_RDESC_SIZE)
+	if (hctx->size != PEN_RDESC_SIZE && hctx->size != PEN_RDESC_SIZE_SHORT)
 		return 0;
 
 	if (data[0] != 0x05 || data[1] != 0x0d || /* Usage Page (Digitizers) */
@@ -65,7 +71,8 @@ HID_BPF_OPS(fix_secondary_barrel) = {
 SEC("syscall")
 int probe(struct hid_bpf_probe_args *ctx)
 {
-	ctx->retval = ctx->rdesc_size != PEN_RDESC_SIZE;
+	ctx->retval = ctx->rdesc_size != PEN_RDESC_SIZE &&
+		      ctx->rdesc_size != PEN_RDESC_SIZE_SHORT;
 	if (ctx->retval) {
 		ctx->retval = -EINVAL;
 		return 0;
-- 
2.55.0

