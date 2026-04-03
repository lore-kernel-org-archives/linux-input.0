Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2231C3D0913;
	Fri,  3 Apr 2026 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232761; cv=none; b=NFRUxZYpktI9e+bLvIlkfVJPPinLK0ItRqZ2c0w1EDoSPSoCEtzVM2vyTror+xXKmAJ/n8ClS2hnxlMfjaE3ens1xkz/+QUpUmRdQbfsQwZ3+Tus07kFBvPp4MYfmyWXWB1jOH85GZqKjbcGWaBSkuXilzzPq7Ny3FCX6tgQy2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232761; c=relaxed/simple;
	bh=cHZREyYrsFNqOhPwySqLSzevS3ZHhGrGCN/d8Ot2D1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mtawm7XkfDOtS1Rp0WqAJP+bAJnoOThCEZ4XlK54vzKczzgXQ+xooAdr5w5DIh3V5UeHp4TqMArRnSFi3cAGrLDqVGjMRAOtbJbBtizngQHFKajvZp4V4R3dYyFAHDubefWPPLfVO3yDcpRHQnzaQ/DmAcK3S24lUjyPYsS1l0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQMxuvRl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQMxuvRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EECCC19421;
	Fri,  3 Apr 2026 16:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775232760;
	bh=cHZREyYrsFNqOhPwySqLSzevS3ZHhGrGCN/d8Ot2D1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dQMxuvRlOuV/FLXkFj98pg4xNaGRkP+DMdBGTar3taiDthDCB0rqheS+grwFyfwQ6
	 76hIIZGnGSD9yzQrtcWya9lVLPh2+GneA4fJKyjBsXeakw6SZ9w6aqbZ/DCwIhzxBF
	 hTXugztTUFGf62ygukdaCrbGAT6oeTLSIWfXnooH6Z4EzlGBEtFojIZGCXOEtv/IHi
	 rGH+m61UvWo+H/SaM/RL1QIgakH37ab5hp5gZRfUGd1vA5YdRzO3vgL+Io2SbTOdVP
	 kLlz+IYfQ65B0QN+wZBxU1mIjBYnjS1oRbxyTlWqMxDfxj7QToToWCI40Zu6Dgrb97
	 CUOpcHbKfc0Hg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 03 Apr 2026 18:12:24 +0200
Subject: [PATCH 6/8] HID: bpf: add a BPF to get the touchpad type
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-6-978cedb9a074@kernel.org>
References: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-0-978cedb9a074@kernel.org>
In-Reply-To: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-0-978cedb9a074@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775232750; l=3000;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=cHZREyYrsFNqOhPwySqLSzevS3ZHhGrGCN/d8Ot2D1Y=;
 b=0iNt2vQkgRafLotFlNGfDg27CWqnMUdGo0Ly+ZDFtlL7BaZQsCXXR146hS/3Mpdpzww28ZAdM
 Rkm0vQMuru1CNOW4+njgV40mqqwaRu6JT+vXV2pIqpcmmqudT3F5wfL
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Currently the kernel is scheduled to do this call by itself, but it
requires a kernel v6.18 at least to have the INPUT_PROP set. For older
kernels, we can try to query the property from a HID-BPF probe, and set
a udev property based on that. This way we can provide the information
to old kernels without modifying them.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Link: https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requests/220
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/progs/Generic__touchpad.bpf.c | 90 +++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/hid/bpf/progs/Generic__touchpad.bpf.c b/drivers/hid/bpf/progs/Generic__touchpad.bpf.c
new file mode 100644
index 000000000000..b9f2cac91724
--- /dev/null
+++ b/drivers/hid/bpf/progs/Generic__touchpad.bpf.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2025 Benjamin Tissoires
+ */
+
+#include "vmlinux.h"
+#include "hid_bpf.h"
+#include "hid_bpf_helpers.h"
+#include "hid_report_helpers.h"
+#include "hid_usages.h"
+#include <bpf/bpf_tracing.h>
+
+HID_BPF_CONFIG(
+	HID_DEVICE(BUS_ANY, HID_GROUP_MULTITOUCH_WIN_8, HID_VID_ANY, HID_PID_ANY),
+);
+
+EXPORT_UDEV_PROP(HID_DIGITIZER_PAD_TYPE, 32);
+
+__u8 hw_req_buf[1024];
+
+/* to be filled by udev-hid-bpf */
+struct hid_rdesc_descriptor HID_REPORT_DESCRIPTOR;
+
+SEC("syscall")
+int probe(struct hid_bpf_probe_args *ctx)
+{
+	struct hid_rdesc_report *pad_type_feature = NULL;
+	struct hid_rdesc_field *pad_type = NULL;
+	struct hid_rdesc_report *feature;
+	struct hid_bpf_ctx *hid_ctx;
+	char *pad_type_str = "";
+	int ret;
+
+	hid_bpf_for_each_feature_report(&HID_REPORT_DESCRIPTOR, feature) {
+		struct hid_rdesc_field *field;
+
+		hid_bpf_for_each_field(feature, field) {
+			if (field->usage_page == HidUsagePage_Digitizers &&
+			    field->usage_id == HidUsage_Dig_PadType) {
+				pad_type = field;
+				pad_type_feature = feature;
+				break;
+			}
+		}
+		if (pad_type)
+			break;
+	}
+
+	if (!pad_type || !pad_type_feature) {
+		ctx->retval = -EINVAL;
+		return 0;
+	}
+
+	hid_ctx = hid_bpf_allocate_context(ctx->hid);
+
+	if (!hid_ctx)
+		return -1; /* EPERM check */
+
+	hw_req_buf[0] = pad_type_feature->report_id;
+
+	ret = hid_bpf_hw_request(hid_ctx, hw_req_buf, sizeof(hw_req_buf),
+					HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+	hid_bpf_release_context(hid_ctx);
+
+	if (ret < 0) {
+		ctx->retval = ret;
+		return 0;
+	}
+
+	ctx->retval = 0;
+
+	switch (EXTRACT_BITS(hw_req_buf, pad_type)) {
+	case 0:
+		pad_type_str = "Clickpad";
+		break;
+	case 1:
+		pad_type_str = "Pressurepad";
+		break;
+	case 2:
+		pad_type_str = "Discrete";
+		break;
+	default:
+		pad_type_str = "Unknown";
+	}
+
+	UDEV_PROP_SPRINTF(HID_DIGITIZER_PAD_TYPE, "%s", pad_type_str);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.53.0

