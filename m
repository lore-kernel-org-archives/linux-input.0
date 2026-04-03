Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E753D090E;
	Fri,  3 Apr 2026 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232764; cv=none; b=FzFkWB1EaK3cdeKV2+JaTUgsHVwOTmJJLfOVolaqXOpPHw61YlLnMg40FkFAh2X2QzO+p28+PWd3a4qYqFEbrZoDPrKnFoGo/KqwHGUJQTD7veP+y7YR8mGpvJNSI/f3kqEPGcnIZu2RXKa8OvNbglQ2hVfpMOcaHdymEAzBqK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232764; c=relaxed/simple;
	bh=HAxZt6ifKT6B1C/BLFjTm4I+37kB1udyT2D4TFJa1Wk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YxSjdtflQSh84saDUhBghMvlCXALk5XLx3/BtBIJRdghbdeAd+e6NgL2d3RuLtT997RzYHz49/ag3wUqM/FUolRH0uWQjNwfJUdd43zgcCNecETq28bFfsoQREsYBPtJNpC0Exw72MvHu3o5489KJ/ILbLGOq0suoEJEAZcQWAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwE9AI0h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwE9AI0h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81EFC19421;
	Fri,  3 Apr 2026 16:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775232764;
	bh=HAxZt6ifKT6B1C/BLFjTm4I+37kB1udyT2D4TFJa1Wk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QwE9AI0hOmKA8pVX3wCbT7RJUhAelOQjm0ndq4/+Mo7lr9gQIvLzy1vnAjmOIeeXz
	 6BhbKeivXLLdl8PIxy4Z3DJiMLXwWrfFt4BV7Ci+OP2UYbgNAMIePNtZTMvIrO+ZRt
	 p8yPLRZ7IDzJHGOwvz9e25xtBpKNoEhEG/Qi1z3miZ+jaBBIVlLnFZ84GZvsd0eNlU
	 xMctR8W+6CwyHiV6OTTsequedwNjgZhT2SyS3qOvVeozqfBgH+X9V4kAWu7nmV2X/S
	 hlNvEg2uu07V6C3B7B2nC+qy6SJN5a5cd+UmmUKBykm+umJ2tGKU7upzx+kiB2XVvq
	 i0nFOPjjE0khg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 03 Apr 2026 18:12:26 +0200
Subject: [PATCH 8/8] bpf: Add fix for Trust Philips SPK6327 (145f:024b)
 modifier keys
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-8-978cedb9a074@kernel.org>
References: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-0-978cedb9a074@kernel.org>
In-Reply-To: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-0-978cedb9a074@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 muhammed Rishal <muhammedrishal7777777@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775232750; l=2118;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=HAxZt6ifKT6B1C/BLFjTm4I+37kB1udyT2D4TFJa1Wk=;
 b=nwC98AkAfbzhIuXDonXrL+3u8eyYZK8ELieqbUV3I4AwWN3Wn5ElhcuDdfvj5trYjk/9KrhH7
 80h8cS4y9jQATNE/8pcGbJFxYAnraQfa0xyU8kDRVS06Y/G8O5uRHSf
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

The Trust Philips SPK6327 keyboard (USB ID 145f:024b) has a broken HID
descriptor on interface 1. Byte 101 is 0x00 (Input Array) but should be
0x02 (Input Variable), causing LCtrl, LAlt, Super, RAlt, RCtrl and
RShift to all report as LShift on Linux.

This BPF fix patches byte 101 at runtime fixing all affected modifier
keys.

Link: https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requests/234
Signed-off-by: muhammed Rishal <muhammedrishal7777777@gmail.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/progs/Trust__Philips-SPK6327.bpf.c | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/hid/bpf/progs/Trust__Philips-SPK6327.bpf.c b/drivers/hid/bpf/progs/Trust__Philips-SPK6327.bpf.c
new file mode 100644
index 000000000000..bc7ff27eac9f
--- /dev/null
+++ b/drivers/hid/bpf/progs/Trust__Philips-SPK6327.bpf.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Fix for Trust Philips SPK6327 (145f:024b)
+ * Modifier keys report as Array (0x00) instead of Variable (0x02)
+ * causing LCtrl, LAlt, Super etc. to all act as LShift
+ */
+#include "vmlinux.h"
+#include "hid_bpf.h"
+#include "hid_bpf_helpers.h"
+#include <bpf/bpf_tracing.h>
+
+#define VID_TRUST 0x145F
+#define PID_SPK6327 0x024B
+
+HID_BPF_CONFIG(
+	HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, VID_TRUST, PID_SPK6327)
+);
+
+SEC(HID_BPF_RDESC_FIXUP)
+int BPF_PROG(hid_fix_rdesc, struct hid_bpf_ctx *hctx)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0, 4096);
+
+	if (!data)
+		return 0;
+
+	/* Fix modifier keys: Input Array (0x00) -> Input Variable (0x02) */
+	if (data[101] == 0x00)
+		data[101] = 0x02;
+
+	return 0;
+}
+
+HID_BPF_OPS(trust_spk6327) = {
+	.hid_rdesc_fixup = (void *)hid_fix_rdesc,
+};
+
+SEC("syscall")
+int probe(struct hid_bpf_probe_args *ctx)
+{
+	/* Only apply to interface 1 (169 bytes) not interface 0 (62 bytes) */
+	if (ctx->rdesc_size == 169)
+		ctx->retval = 0;
+	else
+		ctx->retval = -EINVAL;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.53.0

