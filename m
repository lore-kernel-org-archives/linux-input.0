Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C661D3CF673;
	Fri,  3 Apr 2026 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232756; cv=none; b=gKKFJS3EbCXe1VxMwnu2fjH/QrYJgsUXCVXLAHFI5QYFKYLZKo9xM1MNV/4MbXiW+N4ffPcrGN2mrKkb3OPCNmzbqlhMpP5Vzm1iVXAmYAwHqysJVVTpBDvSU0BvXNzHOqXN5uA7M0Pc5ICFb9LbhYq1Aa4ABbsFz9Armhh9xD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232756; c=relaxed/simple;
	bh=oTzJx4TGLkAb64Ts6MQn7QYIZdcx61tz57ztiNvNZ7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CgBIiCyQOw0GURiVBtVF8E58WGmBCH9U+Dg2l9eHUbzZ/KQfU5PKDLWyy9q2puTUsf20yCj6TlI1fgXBCZ6wzmvN+edUfVY0OBD9K93aOycXYyc3bI4WWWguYj/ifH2wzeEUKUTZJcJU75G/nPQPxK0cwNOlHlgcy3nvdtB022s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0iCakjZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0iCakjZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853A0C19421;
	Fri,  3 Apr 2026 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775232756;
	bh=oTzJx4TGLkAb64Ts6MQn7QYIZdcx61tz57ztiNvNZ7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i0iCakjZVMIy1jnabsZxbJtvPqKaWFofcGKEVhC8ve2YbHPgF01YgMEYqhLB919L8
	 gQ2CjolpmPDSkHPT3AYcHxzq9E4lS3LfeYvNBo4KSyvF5Phnhb6pswFnsR5TZQ1KmB
	 8145cKA21z00yGiYBZAX0nCnFIzBfP1uGVNY59aqM3V/4L/gCtpqB58hab/eDvBjvi
	 llJmks2gBCmyuNYGHigp3AMW2/dVYX9+J76txcvOrEpQFO1/P2+n1N1gwpUI5Ap778
	 t7wrK/vuj0O/FonzAMmbu/NFnqz6k2kgbMpzbsriIuDUHj0BiNTO/4hRFzd//cQlZ9
	 /8inc5HS9WtCA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 03 Apr 2026 18:12:21 +0200
Subject: [PATCH 3/8] HID: bpf: add helper macros for LE/BE conversion
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-3-978cedb9a074@kernel.org>
References: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-0-978cedb9a074@kernel.org>
In-Reply-To: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-0-978cedb9a074@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775232750; l=3829;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=9njiCApk6Gx042A/Eg3M37IHKmB5diYrBQXA1AeCaFM=;
 b=mtqWgtODlpTqIvDPIevVn2/RsvpQRrlkLYb1vbMtKNnYaVXe6QO6x4SC+wrwCc1EgH3uEb247
 sHOMO7GgEI4AXHAkoc2ad+RbPPjunzSYyet7XPEs73s3lCrEu9t2yhj
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

From: Peter Hutterer <peter.hutterer@who-t.net>

BPF has bpf_htons and friends but those only work with data in Big
Endian format. HID is little endian so we need our own macros.

Link: https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requests/221
Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/progs/hid_bpf_helpers.h | 67 +++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/hid/bpf/progs/hid_bpf_helpers.h b/drivers/hid/bpf/progs/hid_bpf_helpers.h
index 5e3ffca1ed7b..f9071444c938 100644
--- a/drivers/hid/bpf/progs/hid_bpf_helpers.h
+++ b/drivers/hid/bpf/progs/hid_bpf_helpers.h
@@ -7,6 +7,7 @@
 
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
 #include <linux/errno.h>
 
 extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
@@ -263,4 +264,70 @@ DEFINE_GUARD(bpf_spin, struct bpf_spin_lock, bpf_spin_lock, bpf_spin_unlock);
 	_EXPAND(_ARG, __VA_ARGS__) \
 } _device_ids SEC(".hid_bpf_config")
 
+
+/* Equivalency macros for bpf_htons and friends which are
+ * Big Endian only - HID needs little endian so these are the
+ * corresponding macros for that. See bpf/bpf_endian.h
+ */
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+# define __hid_bpf_le16_to_cpu(x)		(x)
+# define __hid_bpf_le32_to_cpu(x)		(x)
+# define __hid_bpf_le64_to_cpu(x)		(x)
+# define __hid_bpf_cpu_to_le16(x)		(x)
+# define __hid_bpf_cpu_to_le32(x)		(x)
+# define __hid_bpf_cpu_to_le64(x)		(x)
+# define __hid_bpf_constant_le16_to_cpu(x)	(x)
+# define __hid_bpf_constant_le32_to_cpu(x)	(x)
+# define __hid_bpf_constant_le64_to_cpu(x)	(x)
+# define __hid_bpf_constant_cpu_to_le16(x)	(x)
+# define __hid_bpf_constant_cpu_to_le32(x)	(x)
+# define __hid_bpf_constant_cpu_to_le64(x)	(x)
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+# define __hid_bpf_le16_to_cpu(x)		__builtin_bswap16(x)
+# define __hid_bpf_le32_to_cpu(x)		__builtin_bswap32(x)
+# define __hid_bpf_le64_to_cpu(x)		__builtin_bswap64(x)
+# define __hid_bpf_cpu_to_le16(x)		__builtin_bswap16(x)
+# define __hid_bpf_cpu_to_le32(x)		__builtin_bswap32(x)
+# define __hid_bpf_cpu_to_le64(x)		__builtin_bswap64(x)
+# define __hid_bpf_constant_le16_to_cpu(x)	__bpf_swab16(x)
+# define __hid_bpf_constant_le32_to_cpu(x)	__bpf_swab32(x)
+# define __hid_bpf_constant_le64_to_cpu(x)	__bpf_swab64(x)
+# define __hid_bpf_constant_cpu_to_le16(x)	__bpf_swab16(x)
+# define __hid_bpf_constant_cpu_to_le32(x)	__bpf_swab32(x)
+# define __hid_bpf_constant_cpu_to_le64(x)	__bpf_swab64(x)
+#else
+# error "Invalid __BYTE_ORDER__"
+#endif
+
+#define hid_bpf_le16_to_cpu(x)				\
+	(__builtin_constant_p(x) ?			\
+	 __hid_bpf_constant_le16_to_cpu(x) : __hid_bpf_le16_to_cpu(x))
+
+#define hid_bpf_le32_to_cpu(x)				\
+	(__builtin_constant_p(x) ?			\
+	 __hid_bpf_constant_le32_to_cpu(x) : __hid_bpf_le32_to_cpu(x))
+
+#define hid_bpf_le64_to_cpu(x)				\
+	(__builtin_constant_p(x) ?			\
+	 __hid_bpf_constant_le64_to_cpu(x) : __hid_bpf_le64_to_cpu(x))
+
+#define hid_bpf_cpu_to_le16(x)				\
+	(__builtin_constant_p(x) ?			\
+	 __hid_bpf_constant_cpu_to_le16(x) : __hid_bpf_cpu_to_le16(x))
+
+#define hid_bpf_cpu_to_le32(x)				\
+	(__builtin_constant_p(x) ?			\
+	 __hid_bpf_constant_cpu_to_le32(x) : __hid_bpf_cpu_to_le32(x))
+
+#define hid_bpf_cpu_to_le64(x)				\
+	(__builtin_constant_p(x) ?			\
+	 __hid_bpf_constant_cpu_to_le64(x) : __hid_bpf_cpu_to_le64(x))
+
+#define hid_bpf_be16_to_cpu(x)	bpf_ntohs(x)
+#define hid_bpf_be32_to_cpu(x)	bpf_ntohl(x)
+#define hid_bpf_be64_to_cpu(x)	bpf_be64_to_cpu(x)
+#define hid_bpf_cpu_to_be16(x)	bpf_htons(x)
+#define hid_bpf_cpu_to_be32(x)	bpf_htonl(x)
+#define hid_bpf_cpu_to_be64(x)	bpf_cpu_to_be64(x)
+
 #endif /* __HID_BPF_HELPERS_H */

-- 
2.53.0

