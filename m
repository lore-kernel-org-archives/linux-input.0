Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C636271464
	for <linux-input@vger.kernel.org>; Sun, 26 Apr 2026 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777173517; cv=none; b=i2jYQXzQLPPdzCKe1Wq6EPuSjgrWzOsFUx9XIVAE/rFVpByl+805Dgn5HlnJKAnENDMmnNO35fulpyaojTFVNA5HDwPLlDZUas1706pjiMNnYAu2t+5/87amOQqE5ia0fxcTA3H+/eBmQ4cFYJ535audboTVJcr2+jvfm79zvtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777173517; c=relaxed/simple;
	bh=ytpZS2Ma4tFKNX6RrgtmGAZMrRcjOrWuzslU2uyrAKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P0GFotqaT9bv8+ICdrjcWfwIcTvwougvnJ1FSKyFyfKoMyoI3H4oTkVIffJotkhFwgo+1lhVDLxpdQMALht4jZgxSMOnnNjd/A+Tgm3fTdhvpgPU2RzxoYTZksC7yO5AYXIlrC5txRweeab3FOCifTVki1Z6GtM6clqUS24lp5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYEcXyy8; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYEcXyy8"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so12834778eec.1
        for <linux-input@vger.kernel.org>; Sat, 25 Apr 2026 20:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777173515; x=1777778315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BOpEXIF2g2G1Ob1yI6Lq6IwecSOhOIJp2ENXAioyHuI=;
        b=LYEcXyy8MhWotFQY8xt0oLk79Suf77itzM8DqsK8T6b9zrIzAFfHkEx2mZWXsb/BzO
         NZRMMOzi64u2kAhjdbfwxPzmTf4iuN4nN4lTIZOrsmCxMNccW3Wr/zRw9pVB/27+low3
         3ygITopAIn1rgPfEHng2aL0K4URVGf4khYNN1KZZ7GjjD6RUw7rR4Icymm4wUO7WBp4M
         qMMVcVkT+rbdxGl5g7gR7/U+jeAf1DYWLK4qM3NWhlJwFHD8YW9VBtabnIigD+LjRMZP
         WVH6sZtewsL7toGA4vOMhkeY0JQ4w+CMVuOq1UAnjiuCbRuMPVT754jahOWVx2wHRn4y
         eJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777173515; x=1777778315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOpEXIF2g2G1Ob1yI6Lq6IwecSOhOIJp2ENXAioyHuI=;
        b=fsnYYadETP2W4HKJ0mNwJFWHswZqaxgdcnj8qqkGrU1GLGVa/rNiEpaEyJwlyNK3hA
         6hh4/1mrgyJFUr7cIpgssWuWz6iXlzWQAnHkRTHgFGpyGkq15m+KpmYutblF8janIKnL
         z3/L0Ke/mFsK91bABy+eM8UVbyFfYO9sr6LvG4KfqMUT9ypEd4+8bORp3aqK/IoTZiFG
         NDpyHy0m8dbuqf4vEP56iNKIfZ6ysRGwEuNxTPzz0+iFbIbb05NZUkQGTM7HqhcLq+9x
         k6+FlEqdTX6SwftIdR0zVwAdLxlsOlVBs9HBbqxETJFFLcY/YFyR+yr7oiq7sMS6g/9A
         o2Jg==
X-Forwarded-Encrypted: i=1; AFNElJ9et8rT1O4Q1R8TdzLasc6rQeST7bKBuDHEc5Atson9S6rnK4zTvnK/gBK6DwwInT6l/3mZ1SvFm+fV5w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3PQsGswKCaGavCt9yq4fvV8FfwgQ+OHeCY9ThHyipxYi6JFJg
	9/SxXx+nmi6GAaWmlKK3V2x1NXfxGeat2vcUzLxw6qWyJmft3rGBbDoO
X-Gm-Gg: AeBDiestZ9/GBIJLyYoJZq9Iny0yT+N6eCeUxtPRo8P0h/asTZvqYN4ABgQZ8ZDCihc
	QwpDeYNPeYLJ9S1T2hDZ+DxfQdG5CGhrxmYpgLeOqrahY2ljAt5G1AJvJ4fVfcB2J6PA4feQV3a
	KcYYucUz4wahSurEAIMhgVqbVuXDBquArh2zyz9cO36VP/n4vR/+Db84Qm6ACe52CNbGszQwc18
	iAREjRTYIgx4ISz9IIhl3iZV60Vqpchk+lJuvKYRsyOzMi4kOdCiZRJhyBBJJWyxMEg50B5f/1b
	0wjGg7fFCYtw7KGUv2l8WvzeyO10mGc0Vz7wImUUMAxi+LYduxJbf/ePMxv7Bo88LkbU6RnDkT1
	e5zLx9xQpH+qrqruq0wQhRhRR3Mx6hOD57dTPjDua1Y4cOpSi+vLnlNGqIWh5odwnp1glaahaOQ
	PdyodThHy1zcnMcdDniGDTt50QDXMPRucbp0M+l49X4AVYLCoAsYzRP8Li5zUgL+XVGKieKJt6y
	idsVb9J
X-Received: by 2002:a05:7301:5784:b0:2de:c5ca:c1f3 with SMTP id 5a478bee46e88-2e465293dfdmr20058158eec.4.1777173514934;
        Sat, 25 Apr 2026 20:18:34 -0700 (PDT)
Received: from gigachadarch.hsd1.ca.comcast.net ([2601:647:4482:bbd0::89b2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8b944bsm38501554eec.28.2026.04.25.20.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 20:18:34 -0700 (PDT)
From: Nikhil Chatterjee <nikhilc1527@gmail.com>
To: jikos@kernel.org
Cc: bentiss@kernel.org,
	linux-input@vger.kernel.org,
	Nikhil Chatterjee <nikhilc1527@gmail.com>
Subject: [PATCH] HID: bpf: Add Huion Inspiroy Frego M button quirk
Date: Sat, 25 Apr 2026 20:18:19 -0700
Message-ID: <20260426031819.808555-1-nikhilc1527@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Huion Inspiroy Frego M pen report descriptor exposes the second
side button as Secondary Tip Switch instead of Secondary Barrel Switch.
This makes userspace see the control as the wrong pen button.

Add a HID-BPF report descriptor fixup for the Bluetooth 256c:8251
device and USB 256c:2012 L610 variant. The fixup matches the expected
pen descriptor and rewrites the offending usage from Secondary Tip
Switch to Secondary Barrel Switch.

Tested by building the HID-BPF object with:

  make -C drivers/hid/bpf/progs Huion__Inspiroy-Frego-M.bpf.o

Signed-off-by: Nikhil Chatterjee <nikhilc1527@gmail.com>
---
 .../bpf/progs/Huion__Inspiroy-Frego-M.bpf.c   | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 drivers/hid/bpf/progs/Huion__Inspiroy-Frego-M.bpf.c

diff --git a/drivers/hid/bpf/progs/Huion__Inspiroy-Frego-M.bpf.c b/drivers/hid/bpf/progs/Huion__Inspiroy-Frego-M.bpf.c
new file mode 100644
index 000000000000..e6ba2295dc77
--- /dev/null
+++ b/drivers/hid/bpf/progs/Huion__Inspiroy-Frego-M.bpf.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "vmlinux.h"
+#include "hid_bpf.h"
+#include "hid_bpf_helpers.h"
+#include <bpf/bpf_tracing.h>
+
+/*
+ * Huion Inspiroy Frego M Pen Tablet
+ * Model L610
+ * 256c:8251 (Bluetooth)
+ * 256c:2012 (USB)
+ */
+#define VID_HUION			0x256C
+#define PID_INSPIROY_FREGO_M		0x8251
+#define PID_L610			0x2012
+
+#define PEN_RDESC_SIZE			125
+#define SECONDARY_SWITCH_OFFSET		17
+
+HID_BPF_CONFIG(
+	HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_GENERIC, VID_HUION, PID_INSPIROY_FREGO_M),
+	HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, VID_HUION, PID_L610)
+);
+
+/*
+ * The pen descriptor reports the second side button as Secondary Tip Switch
+ * instead of Secondary Barrel Switch.
+ *
+ * Relevant part of the original pen report descriptor:
+ *
+ * 0x09, 0x42,       // Usage (Tip Switch)                  12
+ * 0x09, 0x44,       // Usage (Barrel Switch)               14
+ * 0x09, 0x43,       // Usage (Secondary Tip Switch)        16 <- change to 0x5a
+ * 0x09, 0x3c,       // Usage (Invert)                      18
+ * 0x09, 0x45,       // Usage (Eraser)                      20
+ * 0x15, 0x00,       // Logical Minimum (0)                 22
+ * 0x25, 0x01,       // Logical Maximum (1)                 24
+ */
+SEC(HID_BPF_RDESC_FIXUP)
+int BPF_PROG(fix_secondary_barrel_rdesc, struct hid_bpf_ctx *hctx)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, HID_MAX_DESCRIPTOR_SIZE /* size */);
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	if (hctx->size != PEN_RDESC_SIZE)
+		return 0;
+
+	if (data[0] != 0x05 || data[1] != 0x0d || /* Usage Page (Digitizers) */
+	    data[2] != 0x09 || data[3] != 0x02 || /* Usage (Pen) */
+	    data[16] != 0x09 ||
+	    data[SECONDARY_SWITCH_OFFSET] != 0x43) /* Secondary Tip Switch */
+		return 0;
+
+	data[SECONDARY_SWITCH_OFFSET] = 0x5a;
+
+	return 0;
+}
+
+HID_BPF_OPS(fix_secondary_barrel) = {
+	.hid_rdesc_fixup = (void *)fix_secondary_barrel_rdesc,
+};
+
+SEC("syscall")
+int probe(struct hid_bpf_probe_args *ctx)
+{
+	ctx->retval = ctx->rdesc_size != PEN_RDESC_SIZE;
+	if (ctx->retval) {
+		ctx->retval = -EINVAL;
+		return 0;
+	}
+
+	if (ctx->rdesc[0] != 0x05 || ctx->rdesc[1] != 0x0d || /* Usage Page (Digitizers) */
+	    ctx->rdesc[2] != 0x09 || ctx->rdesc[3] != 0x02 || /* Usage (Pen) */
+	    ctx->rdesc[16] != 0x09 ||
+	    ctx->rdesc[SECONDARY_SWITCH_OFFSET] != 0x43) { /* Secondary Tip Switch */
+		ctx->retval = -EINVAL;
+		return 0;
+	}
+
+	ctx->retval = 0;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

