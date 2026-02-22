Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F9F13D8B1
	for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 00:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771720648; cv=none; b=l/ybQeEE+zpMj9bqYEJqjWddA6GJ/6Lmts0hrW4zTWTd4ujCHmtuMr28V7lezIlYm3uEfn+pthyCkBnO4FOA3p7drPKDHuAYiokbWcS0Jp/fnT8a7H21vQRORES9rw0uh0vVHl67Q5QMltpfVkeRrHWh7HxKu1UNx7H0TpRqtAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771720648; c=relaxed/simple;
	bh=RjgCz53FUSV7HP/cF2bEAdVK/kU9rXidWruaDkdCbk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QC2HhpbLnawA/EEtxPhcoOftJwsGzwSkJCiJO+tHZDHKKKzVjUdcV5TZNawsnoyEIyeaGTHa5NfmzN84YqnPUuozxT81an5rzyUIYJl+SNzLOplbaVJ4E4xrUkXQf7F4IIC7R1ts8OM/ZJEt3aOcmFTdfQcW+T6SkUH50xqnov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYCCAAsi; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYCCAAsi"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2baab3137bcso2721689eec.0
        for <linux-input@vger.kernel.org>; Sat, 21 Feb 2026 16:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771720646; x=1772325446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0rQ7ex4h2z+8N7dHVq8qvk2wg1mn2OyvK9whQnScvY=;
        b=PYCCAAsiTES+VI3tVQ9sDWA76Bb8tlzeTjZ6fITqKmlz0rSbuOPYSl/cROOAH0YFZX
         751zQyA/Wr1vzYRSIhIl8gc9YeRxiCoRAfb0oAtd0SAIb6apfS1lTXpbxB48rfT8hUwJ
         FVg9BzSQKEGorWjc2r3Vf6DaimW++faPYKNP7V0vsqOmC2NuJ4S1S9B0joFKeGhKmUK2
         T45//CAYpjM3PrwM89VVIjPD2nU4j7yfBRz1rB8PhZK7jAdPOg0WMIKZRbbfe0SeJ0Qf
         S28izL2jyd+uPPREUEcnWJ+3pN/it+RVPxPGmg2MWzVPp32NdHzb+hp2RzTkLfLO5X79
         +SRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771720646; x=1772325446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W0rQ7ex4h2z+8N7dHVq8qvk2wg1mn2OyvK9whQnScvY=;
        b=Z8jD1q62EEWZVXLpyhBdCKIsGkO8jZZ+loOdSN/mkq+jZ/i6xttj/mWaKv5T2xZJ8r
         ZBrrOem8KZUTERCKZ5Pr7U39FNTlUXuwydZZcnRyUYTRRbgZwM4Qd41E+4Usxc2wrrZp
         eOFGAW+sx/dfkE+PGbzuvRwQ+Ma7UehTdIxOcIn0s//RvlOXZNV1Tl2FAZJCgFf62J24
         55ZjSagV/HX72qEHKLzrwvmnswE2hA7O/RzdTXT+ylI+LjLb6AsBcGjTdkuaubijl7Xv
         i5OG5tOmyTemDAkbRC+xb0ImCmT25ofBtx68t0IJte0q2FQl9HgWIijx/cOaZ5JBH6hh
         a+6A==
X-Forwarded-Encrypted: i=1; AJvYcCVDr4ArfnpGrj0B6OHdUlKzyA0NDjYg1UAbpgSDtD6qTuSPPAMwMFsmloNCJrU28A4JOdz+jQymQhCeTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnXJ8isjK6GtiTLnCDsdA+z3TcF4lRfQF5HTxPqjvnOZpIsFmk
	cYYVMY1aPR9diS/3J0Li35AHmNsMbtz87M0V3PXJfw6ozdtOkoCjCc8n
X-Gm-Gg: AZuq6aK1rUv0x4FH/djFG90O5vAuMY9rdKekgm/E9nMqpWkvKYjgr8ZY/UmowJZsslm
	T8+Bdc0aW3PUXcveROqFlYZirWNdMIs1G1Sp/r+jmwpswJSVEdb/QP/Oy4LnKNB0GCsJ4oB6v6X
	CUht9STfGpCR1xAyFmBL0PJ6dMiq/Bdv3V87v+KNVzHcVaeKde63IzX4mkoAnuwd5A7VVYcFbgY
	xjScXa7+idUTSQqM1sF/eKS+HdOGxrz9jwRq7FHuGm6zkGNfDaf0X7g4ytcWKFmf6WMNnTCq2sZ
	5Zcynq9Qi0f2NShS3veIeK5n7daXiX/9RgaWY8yOdGFrwLEjUjDA9uRzJQpjNDcTWJCE1jtVITH
	QUz8COPhbDvqYKSa0hu1OPbE38oEfo82TWm+yHu8ZlsT52nFVTAUHNYuxyMHNzyceNSOfG2qfm6
	0aUXLMGBLttb9KGc4lFquPX4V4gcDexwoXuZ4FietI7oGNgWq1avRe9s5rGTMbxuSqIjv+Lmnxm
	xtZKcd5n1POcQ==
X-Received: by 2002:a05:7301:608c:b0:2b7:13f5:43ac with SMTP id 5a478bee46e88-2bd7bae9fbfmr1697542eec.15.1771720646135;
        Sat, 21 Feb 2026 16:37:26 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:73d:b075:516c:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc167d3sm2383191eec.24.2026.02.21.16.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 16:37:25 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Fabio Baltieri <fabiobaltieri@chromium.org>,
	Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>,
	Simon Glass <sjg@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-input@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] Input: cros_ec_keyb - use u8 instead of uint8_t
Date: Sat, 21 Feb 2026 16:37:11 -0800
Message-ID: <20260222003717.471977-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
In-Reply-To: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
References: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the kernel u8/u16/u32 are preferred to the uint*_t variants.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/cros_ec_keyb.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index bdbfd219f2e8..2f78a19521ab 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -59,8 +59,8 @@ struct cros_ec_keyb {
 	unsigned int cols;
 	int row_shift;
 	bool ghost_filter;
-	uint8_t *valid_keys;
-	uint8_t *old_kb_state;
+	u8 *valid_keys;
+	u8 *old_kb_state;
 
 	struct device *dev;
 	struct cros_ec_device *ec;
@@ -145,11 +145,11 @@ static const struct cros_ec_bs_map cros_ec_keyb_bs[] = {
  * Returns true when there is at least one combination of pressed keys that
  * results in ghosting.
  */
-static bool cros_ec_keyb_has_ghosting(struct cros_ec_keyb *ckdev, uint8_t *buf)
+static bool cros_ec_keyb_has_ghosting(struct cros_ec_keyb *ckdev, u8 *buf)
 {
 	int col1, col2, buf1, buf2;
 	struct device *dev = ckdev->dev;
-	uint8_t *valid_keys = ckdev->valid_keys;
+	u8 *valid_keys = ckdev->valid_keys;
 
 	/*
 	 * Ghosting happens if for any pressed key X there are other keys
@@ -259,8 +259,7 @@ static void cros_ec_keyb_process_key_fn_map(struct cros_ec_keyb *ckdev,
  * press/release events accordingly.  The keyboard state is one byte
  * per column.
  */
-static void cros_ec_keyb_process(struct cros_ec_keyb *ckdev,
-			 uint8_t *kb_state, int len)
+static void cros_ec_keyb_process(struct cros_ec_keyb *ckdev, u8 *kb_state, int len)
 {
 	int col, row;
 	int new_state;
-- 
2.53.0.345.g96ddfc5eaa-goog

