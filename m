Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA3B397922
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175918; cv=none; b=GU2UtGDC58ZFtaaPqK+IzzylbIKIpglQqvUb27Whoi1WyaBJBMeQ/63Ala6pLgQCYNzNDCfONT1pKEmw3XRgOupzH3oNeJq7LR4wj24szfNhTLAWUNOjzoK1Gp0yb+b4t2U1SSy+shJwV40Mw2wy0+1Hi/+p/42Z0RjDsn74blc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175918; c=relaxed/simple;
	bh=rp1KQ2VRmhfqZU9qSd57CBPBNtwA3aQtI0YNPDTfp7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBZyAOv9gdKltnGjLu8+nj+o8US5hD46q1BsjWAT9pG4huN0SAeHa1D9taGkPJy4EL0df7DAEYQOqDaGv2LpbEnq1NZ2FibrreV2d5EopY80Nj00P4+Q7juSKS8Z+ncWZsnVVjIoLSuoWNlyaA278vmSy0nj7SFnTpA5opQVZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LijUIpRs; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LijUIpRs"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f6c7a58so167411866b.2
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 08:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790175911; x=1790780711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JUga4eXtCVg9VRjH/WIKSFqPpCVH1XzzVx2Gw8aeOLA=;
        b=LijUIpRsXJZmBnxAmbrUMvq7r2YTvW9xpob6IPHL+98gR/RPGiJKU5VA7TJWkEunBC
         m22egctjJDGMs0ED8kBm5aJsnuc7dvVl8J4W3hwA4PlPsbsvY7dZz4XnwCQAWbinQHqW
         lSmOt+gzSOfTEgGSiIkQaUqjvzOIMHJDOpiV5C3KCSt0QfKpIAQBcjTRx02lnIF9moP6
         So6vj0r5gTe/n45DS0fEL/f4dghLA/lEz3xHpH+zLs0G82ZlVDsts/qnw7uGfEAo6RQr
         SrjHiQoaDbVXStepZuf1L5jW+sDo+srkXNTPf+wXMiSHGHfoy6451hdSnT4XN4oXfITY
         QogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790175911; x=1790780711;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JUga4eXtCVg9VRjH/WIKSFqPpCVH1XzzVx2Gw8aeOLA=;
        b=q0Jol3gaWNvIcZH5XPZFG+hRGbEmMAb3v3s2McHP1e5XDO2ypK59ZWGk8JV+1irYoP
         D+/kAW9mJ7yu54jiXO9qZM56ztfpaabnPB8BoLyBueYoAHQ8eVZxGAfw2+1kieOK0k37
         OCmrZREWLaZ4+nNnNqcMSLZhJiNfALvt1AIFScrGqWwfWzwQZk199mKtTuom4ADC+MBE
         w1GLwfEfYpyAFuJ6OfjtIkLl+6j1HmhTUnNfbOpzPFFBzj0xfg6Da9rJo3MJZCw6nvzE
         4KZDqczyD7FAPjK/qccGA4YiXSfzdeU73dtUQH157ewJuU16PORiYeyRO/0ew3MiDN8C
         p72g==
X-Forwarded-Encrypted: i=1; AKwUvBw8+ytja/pQg956VTWKXDkkF/KiQo8QSpULPKYuiB3mFZiVpnMlak6N5amJtT+n9LSzfTDYRZEp9u+qjA==@vger.kernel.org
X-Gm-Message-State: AFuF++nsvKk1gGBHSSGm/4nbQhzTv+HehQ/hdXPc/7C2Uej/Qdao+Doh
	+4ZgUj9y/axHv/xB4AfGFAnSJIbX6SbBMvmz2zUkacTOWldIjR117cfreXahLysxIWU=
X-Gm-Gg: AYBFou30G13ekKH22eeFP/iFaZXQJVlCwgCzgUmH7a+uJbKC+ek+7ilySdtPSxg/eYo
	CfndYRZEvHfGYU2+VXAsMphhX5V9S+duamNaHbCrNhHKHmqEYESLQvBHBNj4Tmh8HtVbpk4OVKQ
	/emeN/b9E9dKqW78uab2Y7KdpMfhuhTXJkKevjXVXLHyKyXAMDqarE5TBYkK4gFQIhPGyltISa0
	1qDupQKHSsanRA/iesEIe/NdmCvj+w80CfyIpUq7LoZo1RiPPb1lZMLqNoDEwKaIWjohHP+n2Id
	fatat2yKZ8PnUiLnuXH3ewbj6JkkS8s2s8ddknLDsexuTlHR+xpg0qjOYVynzA8rGcO1mJ0YvOg
	9L0HxPjy4rHt6Xtu2ugs9WGQg7+gKocL0uqW7IIcw+uVyfXJehDy5q05SXZ1YpZdyiWV0D2PAtp
	0jDyHmqsIDTTcG/L9hW+IDW++l2lxh/SCGnz1n0v7HBStPN+OSgIk4fOLb1ueNRAgqaT0hMScrI
	2ay/5zAYKCO
X-Received: by 2002:a17:907:7287:b0:c29:d31f:7d7a with SMTP id a640c23a62f3a-c2aadf37c48mr248950266b.21.1790175911358;
        Wed, 23 Sep 2026 08:05:11 -0700 (PDT)
Received: from [138.92.0.0] ([104.28.254.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c5524sm144401066b.21.2026.09.23.08.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 08:05:10 -0700 (PDT)
Message-ID: <1edaa3cf-f3bb-4408-8777-3ff44a4a2209@gmail.com>
Date: Wed, 23 Sep 2026 18:05:08 +0300
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] HID: multitouch: add support for Goodix GXTP7863
 touchpad
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: jikos@kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260814171247.16707-1-daminovruzal7@gmail.com>
 <20260819123326.3242-1-daminovruzal7@gmail.com> <aquWNXpJuQr8HLBU@beelink>
 <51055e02-5bf1-4b1e-b430-382d00d3d004@gmail.com> <aqwUYWPz_nORoFr6@beelink>
 <33a7c239-ede5-4091-ba72-ff429d97013c@gmail.com>
 <816a300c-1f63-4d4a-a0f9-8eef5bd7e748@gmail.com> <arJ-vvEvd93l_aAp@beelink>
 <41f8ed8e-1466-4002-8411-bf9871da2adc@gmail.com> <arPT9zIoypn5V3PT@beelink>
Content-Language: en-US
From: Ruzal <daminovruzal7@gmail.com>
In-Reply-To: <arPT9zIoypn5V3PT@beelink>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/26 4:31 PM, Benjamin Tissoires wrote:
> If you could work on it yourself that would be great
> 
> FWIW, I tried playing with the new HID_REPORT_DESCRIPTOR but if this
> allows to read the current report descriptor, this doesn't allow to
> amend it, making things a little bit too complex to implement properly.
> So it would be simple enough to use the same old bits checking and
> changing so you get the BPF quickly out.
> 
> Cheers,
> Benjamin


Hi Benjamin,

I implemented the BPF fix and verified it by toggling with `udev-hid-bpf remove`
and `add`: without the BPF program the UNKNOWN keyboard node appears
immediately, and with the BPF loaded it completely disappears.

I wanted to open a Merge Request on GitLab, but my new account
(@mounkastel) hit the anti-spam project limit barrier ("Limit reached:
You cannot create projects in your personal namespace"). I have filed a user
verification issue on freedesktop/freedesktop.

In the meantime, here is the git patch below so you can review or apply it
directly to udev-hid-bpf.

Cheers,
Ruzal

From d585a7cdb2f75dd0d22dda9d7701147d4290d191 Mon Sep 17 00:00:00 2001
From: Ruzal Daminov <daminovruzal7@gmail.com>
Date: Wed, 23 Sep 2026 17:42:10 +0300
Subject: [PATCH] HID: bpf: Add Goodix GXTP7863 touchpad telemetry fix

The Goodix GXTP7863 touchpad found on Honor MagicBook laptops emits a
periodic 1-Hz telemetry heartbeat report on vendor page 0xFF01.

Because page 0xFF01 is historically mapped to HP vendor hotkeys in
hid-input, changing telemetry payload bytes are misinterpreted as
brightness keypresses, resulting in an endless KEY_BRIGHTNESSUP loop.

Remap the vendor telemetry page to an ignored vendor page to prevent
hid-input from creating a bogus keyboard node, while keeping the raw
reports available through hidraw for firmware updates.

Tested on Honor MagicBook X14 Plus (FMI-76, AMD Ryzen 8845HS).

Signed-off-by: Ruzal Daminov <daminovruzal7@gmail.com>
---
 src/bpf/testing/0010-Goodix__GXTP7863.bpf.c | 66 +++++++++++++++++++++
 src/bpf/testing/meson.build                 |  1 +
 2 files changed, 67 insertions(+)
 create mode 100644 src/bpf/testing/0010-Goodix__GXTP7863.bpf.c

diff --git a/src/bpf/testing/0010-Goodix__GXTP7863.bpf.c b/src/bpf/testing/0010-Goodix__GXTP7863.bpf.c
new file mode 100644
index 0000000..84372c7
--- /dev/null
+++ b/src/bpf/testing/0010-Goodix__GXTP7863.bpf.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Ruzal Daminov */
+
+/*
+ * Goodix GXTP7863 Touchpad Telemetry Fix
+ *
+ * Problem: The touchpad sends periodic 1-Hz heartbeat reports on Report ID 8
+ * with Vendor Usage Page 0xFF01. hid-input treats Usage Page 0xFF01 as
+ * HID_UP_HPVENDOR2, misinterpreting changing telemetry bytes as phantom
+ * KEY_BRIGHTNESSUP events.
+ *
+ * Fix: Remap the vendor telemetry collection to an ignored vendor usage page.
+ * This prevents hid-input from creating a bogus keyboard input node while
+ * keeping raw reports accessible via hidraw for firmware updates.
+ */
+
+#include "vmlinux.h"
+#include "hid_bpf.h"
+#include "hid_bpf_helpers.h"
+#include <bpf/bpf_tracing.h>
+
+#define I2C_VENDOR_ID_GOODIX		0x27c6
+#define I2C_DEVICE_ID_GOODIX_01E0	0x01e0
+
+HID_BPF_CONFIG(
+	HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01E0)
+);
+
+SEC(HID_BPF_RDESC_FIXUP)
+int BPF_PROG(hid_fix_rdesc_goodix_touchpad, struct hid_bpf_ctx *hctx)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0, 4096);
+
+	if (!data)
+		return 0;
+
+	if (hctx->size == 705) {
+		/*
+		 * Report 8: Change Usage Page from 0xFF01 (HID_UP_HPVENDOR2)
+		 * to 0xFF09 (HID_UP_LOGIVENDOR2) at index 625.
+		 */
+		if (data[625] == 0x06 && data[626] == 0x01 && data[627] == 0xff &&
+		    data[632] == 0x85 && data[633] == 0x08) {
+			data[626] = 0x09;
+		}
+	}
+
+	return 0;
+}
+
+HID_BPF_OPS(goodix_touchpad_ops) = {
+	.hid_rdesc_fixup = (void *)hid_fix_rdesc_goodix_touchpad,
+};
+
+SEC("syscall")
+int probe(struct hid_bpf_probe_args *ctx)
+{
+	if (ctx->rdesc_size != 705) {
+		ctx->retval = -EINVAL;
+		return 0;
+	}
+	ctx->retval = 0;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/src/bpf/testing/meson.build b/src/bpf/testing/meson.build
index 73158c9..97435ad 100644
--- a/src/bpf/testing/meson.build
+++ b/src/bpf/testing/meson.build
@@ -11,6 +11,7 @@ tracing_sources = [
     '0010-Iiyama__ProLite-TE9804MIS.bpf.c',
     '0010-XPPen__DecoSE.bpf.c',
     '0010-Corsair__K70-CORE.bpf.c',
+    '0010-Goodix__GXTP7863.bpf.c',
 ]
 
 # 'sources' are BPF programs only compatible with
-- 
2.55.0
