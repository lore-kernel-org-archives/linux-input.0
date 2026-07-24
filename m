Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA64432E97;
	Fri, 24 Jul 2026 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906017; cv=none; b=D8U1AIy7gjFJ8ubzCvBUuwO3caua9edc1uacbUPjCUmj3OK4GcmafAkoUkYlTItH+tXTBlQqp5Yb/KHQ8LIbZJTxYPU0BhzXZzSSMS7bbYDKK+qkXNPDF+hpq3rQ0uP4eYGHbpKo0UuAeRxQbyuOoV5eMHzzoNOt/RQS7006ujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906017; c=relaxed/simple;
	bh=HPUpxtCxpINYLEfuU25Z3pvyKyTLddcc+SYmp5XtriM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eCFMvuNjF/TohkKrENeSROKHW4jaOsxHFWnIT+x52XyGwL0dcKa9I4vid6rarA74EjO0H21TZvwaOhv4NNyds72XSkmw0T3QXvZnIUz1Gu+fxq9arqgoKC5emCuC9EgzKGOb3WVkRuwEdDml92d13kchjGY8xUgJNuPBiJ8Y/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=cpuyvyEI; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="cpuyvyEI"
Received: from ShouCheng-Lab.localdomain (unknown [218.2.107.243])
	by smtp.qiye.163.com (Hmail) with ESMTP id 477b224c2;
	Fri, 24 Jul 2026 23:13:25 +0800 (GMT+08:00)
From: Jiancheng Huang <jchuang@seu.edu.cn>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: lg4ff: validate report length before fixed offsets
Date: Fri, 24 Jul 2026 23:13:17 +0800
Message-ID: <20260724151317.1419574-1-jchuang@seu.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f94b03a2f03a2kunm63b44f9445778
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTk5LVh5PSh1DSk5MSE0ZGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVSVVKS0xVSU9IWVdZFhoPEhUdFFlBWU9LSFVKS0hKTk
	xOVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=cpuyvyEIGOt8mYGF/uouhrbjJGm4F5/ciu1ojaUnOYdxj4ZS5iPnLzxTTezhQbOoDUhLySSkhRsOEHXlKXuKX015W6N0DNM5ALcirY0pJ9j/UXKX3VLwkxwCHlpwN74iI+U8w3mdQLgVLmh1poXsFK23HGa4YNKWhFz7K2aimKI=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=mfjyetoRQcuQJG/GPiFFBwofwgVMAPECP+RHTGK4/Tg=;
	h=date:mime-version:subject:message-id:from;

lg4ff_raw_event() rewrites fixed report offsets when combined pedals are
enabled. It currently assumes that each product report contains every
source and destination byte used by the rewrite.

Return without rewriting a short report before each product-specific
access. Apply the same bound to the computed offset path.

Fixes: c832f86effbc ("HID: hid-logitech: Add combined pedal support Logitech wheels")
Signed-off-by: Jiancheng Huang <jchuang@seu.edu.cn>
Assisted-by: Codex:gpt-5.6-luna
---
Changes in v2:
- Add the relevant public mailing lists to Cc; no source changes.

Evidence (v7.2-rc4 KUnit/KASAN oracle under bounded QEMU):
Source: confirmed/hid_lg4ff_short_report_oob_raw_excerpt.log

[    2.638792] KTAP version 1
[    2.638888] 1..1
[    2.641100]     KTAP version 1
[    2.641235]     # Subtest: hid-lg4ff-exploration
[    2.641784]     # module: hid_logitech
[    2.641962]     1..1
[    2.644581] ==================================================================
[    2.645008] BUG: KASAN: slab-out-of-bounds in lg4ff_raw_event+0x2fd/0x410
[    2.645369] Read of size 1 at addr ffff88800229fc63 by task kunit_try_catch/67
[    2.645369] 
[    2.645369] CPU: 1 UID: 0 PID: 67 Comm: kunit_try_catch Tainted: G                 N  7.2.0-rc4-dirty #3 PREEMPT(full) 
[    2.645369] Tainted: [N]=TEST
[    2.645369] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    2.645369] Call Trace:
[    2.645369]  <TASK>
[    2.645369]  dump_stack_lvl+0x53/0x70
[    2.645369]  print_report+0xd0/0x630
[    2.645369]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[    2.645369]  ? lg4ff_raw_event+0x2fd/0x410
[    2.645369]  kasan_report+0xe5/0x120
[    2.645369]  ? lg4ff_raw_event+0x2fd/0x410
[    2.645369]  lg4ff_raw_event+0x2fd/0x410
[    2.645369]  lg4ff_short_report_oob_test+0x14e/0x250

 drivers/hid/hid-lg4ff.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index e901fdb7d..62f99a932 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -336,6 +336,8 @@ int lg4ff_raw_event(struct hid_device *hdev, struct hid_report *report,
 	if (entry->wdata.combine) {
 		switch (entry->wdata.product_id) {
 		case USB_DEVICE_ID_LOGITECH_WHEEL:
+			if (size < 7)
+				return 0;
 			rd[5] = rd[3];
 			rd[6] = 0x7F;
 			return 1;
@@ -343,10 +345,14 @@ int lg4ff_raw_event(struct hid_device *hdev, struct hid_report *report,
 		case USB_DEVICE_ID_LOGITECH_WINGMAN_FFG:
 		case USB_DEVICE_ID_LOGITECH_MOMO_WHEEL:
 		case USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2:
+			if (size < 6)
+				return 0;
 			rd[4] = rd[3];
 			rd[5] = 0x7F;
 			return 1;
 		case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
+			if (size < 7)
+				return 0;
 			rd[5] = rd[4];
 			rd[6] = 0x7F;
 			return 1;
@@ -366,6 +372,8 @@ int lg4ff_raw_event(struct hid_device *hdev, struct hid_report *report,
 		}
 
 		/* Compute a combined axis when wheel does not supply it */
+		if (size <= offset + 1)
+			return 0;
 		rd[offset] = (0xFF + rd[offset] - rd[offset+1]) >> 1;
 		rd[offset+1] = 0x7F;
 		return 1;
-- 
2.43.0
