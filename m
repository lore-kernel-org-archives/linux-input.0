Received: from mail-vs2-f16.google.com (mail-vs2-f16.google.com [74.125.227.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6E764AA4
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 04:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789445559; cv=none; b=peqOZq9S6lSuAfDVv1u4A+f9tWu0q4xvZsSRV16QQv0hK01Pd9FA8RI8TL1Bua5BS4ahlTidAJ7TDx6oP7tD5uCZWOgYrwP1vBLZBNMHeRB67EyqCD0QeauZdf9Jq7sTDMj+UY0DnzXn5LLnsrfUe71SdpKzuCXjW73SNSyqynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789445559; c=relaxed/simple;
	bh=UJLZbdkDEENRPUTN2VBlVmTpQ2jl+rP/oP1ip20tE4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdBrDDfSgMVPALIhKYLIHRRASdHYyC8Fpvh2sGHSYOK7wHp76U1vIK3irslKof1ajKnp2aj2ZLT02XyPk5A1auU2Fa40nM2V+gLIgQIZjKJa3SKdndbO2XgmzAvceMvpioK2zkGdbyDStlU4K9p+d5jsmECzI+i03OP+BmOfxXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPCZyfwf; arc=none smtp.client-ip=74.125.227.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPCZyfwf"
Received: by mail-vs2-f16.google.com with SMTP id 71dfb90a1353d-5c67e5292fdso908285e0c.3
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 21:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789445555; x=1790050355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uO17j0M9UiUVcJWCWfq8oZAdxWyBugYlDi2x4A2dG3E=;
        b=RPCZyfwfIpn80Z2t1NsdZ0m9zjL7POFIhtM+av4b8WYf5CUMesBWOMpI6jAuEr+ZDz
         qEbscx8A7ja56sciAdp35SPpMOIZoeV5VzZCovBWM1ziqUBY56Y0Mo3FmAI/sEh677EO
         /6mQgRip6oRllqfyMU9ZUwZp2gErxLubR5R6L9bC3qZSsk898gVJPMFglK6mmNdpAoBU
         Jl3fAeyVRYZA0DHVgvQTDTuQcO4ls9aY6/ghudVZ7z1QHZDrYrGYbm7ep6Xj3B4W04nv
         Kq2uSAC2yZc6kWFaDKi+d0IREdWFlZ2llcTvSfqYxgpztt+DmFBYOYYYDuGabJ5W1yIa
         3fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789445555; x=1790050355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uO17j0M9UiUVcJWCWfq8oZAdxWyBugYlDi2x4A2dG3E=;
        b=JxDoF8fUz6j6BTNWs3BAf++WFm9IPZ1eVMoIkrMrd9p5ZpZ2FjVmMDDXU4vkAC9lit
         miHcDKKvjcWoCDCkjhKyzGe3umiH+WwYuCmJ4g7XvkzT7MqqAmXe+mHkGRZrfskm1dJS
         huQfppuMbco8wnBxKvJCT73PGN5kc6TojXZPyyCgL5o9XVGU7DFG9iv1xlPgJIUDFbCD
         5MXcW4E844X4TnkFbCX5/bNTAjKnaI17hOuOugArsUR2RLcGF0wzTup8OaRYSf+y3rDi
         jHQ/PV9exOoqaGtSYEMiexqi0So/aSd7TN+dcJoOJzZ7zfs4DfWEdKU/uJUBQ/Gbkjzz
         NSVw==
X-Gm-Message-State: AFuF++niZ+nY608DVT291jeXrnoUbR7n0JdXH5yAB6IqS60WKYjCuv+2
	lrpPNxFV1WESP19avoCkUT191//WW8QhgR7yCfqvWgakF6V/7Wnfd9Hl
X-Gm-Gg: AYBFou1dVtlc+D9+ofYwbflbT45C7cUWcYvPkkIrtN5EkdpUJTXpKK+ewiRDdIPiVXr
	qr4NEGgg7W4FqsJiwwZwoosTVqp+eL4roxFjWeqPkaL4/3DhwmYvaZM9XielQbxTBEgW4ncp5f8
	yqsvyj0sULJ7/nl5b1JuxyhNh8HKEeab47eJMlD1FnpuJgY/8STn89NsKt4+MsuYkhUXSvYFBX2
	LbyIRTPQ7M9xEx+06pDnikAmbEL9cI9KXReeYtXgfBkT7tReowVoK0AMFQ2SRMHnG+Fln105JRG
	0dR1QKaxT1r/evnUWfN1Eo3uDxrGUX7Slh0/yjiICW56r4+bgLaAp+ru0mqY87yo8vfaLzoNu0c
	AqtcbNqLgj6bDwPlf4lC5U/oAzqs7zxO0uF401bgAa0K+jN4usHCi/G336IBsmzFeOesVGk5ECU
	Q4nAscohc5HGi1cFqYyJZot1J0d88epSsmBFU1h54mq6JI6Dswpj2pj9iPehdGjjA9
X-Received: by 2002:a05:6122:f8c:b0:5c6:81c2:5496 with SMTP id 71dfb90a1353d-5c981d65e57mr3390303e0c.4.1789445555369;
        Mon, 14 Sep 2026 21:12:35 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c847122e2dsm14601423e0c.14.2026.09.14.21.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 21:12:34 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] HID: core: avoid signed overflow in multiplier calculation
Date: Tue, 15 Sep 2026 01:12:26 -0300
Message-ID: <20260915041226.2431890-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A HID descriptor can make both logical range subtractions overflow
signed 32-bit arithmetic.  On x86, the resulting INT_MIN / -1
operation can raise a divide exception and crash the kernel.

Promote the operands before subtraction, use the signed 64-bit
division helper, and check the remaining multiply and add operations
for overflow.  Fall back to the default multiplier when the descriptor
cannot be represented safely.

Fixes: 5a4abb36f312 ("HID: core: process the Resolution Multiplier")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/hid/hid-core.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index cf123347a..92d76b789 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/math64.h>
 #include <linux/mm.h>
 #include <linux/spinlock.h>
 #include <linux/unaligned.h>
@@ -1083,7 +1084,11 @@ EXPORT_SYMBOL_GPL(hid_validate_values);
 static int hid_calculate_multiplier(struct hid_device *hid,
 				     struct hid_field *multiplier)
 {
-	int m;
+	s64 logical_range;
+	s64 physical_range;
+	s64 quotient;
+	s64 scaled;
+	s64 m;
 	__s32 v = *multiplier->value;
 	__s32 lmin = multiplier->logical_minimum;
 	__s32 lmax = multiplier->logical_maximum;
@@ -1097,13 +1102,21 @@ static int hid_calculate_multiplier(struct hid_device *hid,
 	 * Resolution Multiplier of zero."
 	 * HID Usage Table, v1.12, Section 4.3.1, p31
 	 */
-	if (lmax - lmin == 0)
+	logical_range = (s64)lmax - lmin;
+	if (!logical_range)
 		return 1;
+
+	physical_range = (s64)pmax - pmin;
+	quotient = div64_s64((s64)v - lmin, logical_range);
 	/*
 	 * Handling the unit exponent is left as an exercise to whoever
 	 * finds a device where that exponent is not 0.
 	 */
-	m = ((v - lmin)/(lmax - lmin) * (pmax - pmin) + pmin);
+	if (check_mul_overflow(quotient, physical_range, &scaled) ||
+	    check_add_overflow(scaled, (s64)pmin, &m)) {
+		hid_warn(hid, "Resolution Multiplier calculation overflow\n");
+		return 1;
+	}
 	if (unlikely(multiplier->unit_exponent != 0)) {
 		hid_warn(hid,
 			 "unsupported Resolution Multiplier unit exponent %d\n",
@@ -1112,11 +1125,12 @@ static int hid_calculate_multiplier(struct hid_device *hid,
 
 	/* There are no devices with an effective multiplier > 255 */
 	if (unlikely(m == 0 || m > 255 || m < -255)) {
-		hid_warn(hid, "unsupported Resolution Multiplier %d\n", m);
+		hid_warn(hid, "unsupported Resolution Multiplier %lld\n",
+			 (long long)m);
 		m = 1;
 	}
 
-	return m;
+	return (int)m;
 }
 
 static void hid_apply_multiplier_to_field(struct hid_device *hid,
-- 
2.43.0

