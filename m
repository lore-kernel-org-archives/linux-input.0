Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18F81624DF
	for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 00:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771720649; cv=none; b=R63uxXl+VpvU7bHI+J99YOu9eqn5/GHNC+Jlv9dSpzuv34NOhK0YKszxTLkc/CTGkDPBHD3K2bpcd/kjHkaRwXZHd0VUzizgE883jIruevORYTqilkh8Xs5h7dfEvAxjs/P87s/eLLZASrPkyaQO2MZzhjiSgzSGm3scnby/ZAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771720649; c=relaxed/simple;
	bh=r0A2ny7fUmzrQIcNfjZ7JLTjyjv9jTD2LYXdPbqdGN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKiOTGq9uULpzSu1oyFUP0IzcLowEbdb9nry/mPs92d0xxcdLnig843EXAV2vF5wiJVRNRx4pjMCmM088yueo2yDVXK45RgJu+5YuoTZwK0u3oqGIbxVcM7nHHR3izS6ezOK6/kssN/opdaJBy0RkfWfMzFugysHAiYw0gCGnrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShiIcvKq; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShiIcvKq"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b6b0500e06so3953243eec.1
        for <linux-input@vger.kernel.org>; Sat, 21 Feb 2026 16:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771720647; x=1772325447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiffRHsDZVfAH6A/NkIUz5txjzfoEADk0TaeYHBIaa0=;
        b=ShiIcvKqqwvrqixYGMujyLGWOgYL9jci22R1LAfKp2EX0RWiKBR7SgQpJX7xXsyzBO
         K+sz6UIyuY5j78ElAtEPwG2TRwp3BxgQ0lu5ICpeJmZzUjucxG9jPpHPrrM4Paq3yfuP
         Z58Q/pIHz5uS/SmVLaVfF0CKkkT+rML5NewBP+wuBSnZIJFcZ+IcTO07VbBuVBOONVyk
         zD7mpQlBalAUTgwHN4qcPU3IU8ErhzLE6sz/hlujjbp5UUR+hRHnZQ5u9s/QYfSUwebK
         s/dMEWPIej7J/1Wlk9Ky4l4fsf9U+ZVcSJdhwh9OHadLTK9joPiPFTNL//ZIlbEB6X4u
         EMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771720647; x=1772325447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HiffRHsDZVfAH6A/NkIUz5txjzfoEADk0TaeYHBIaa0=;
        b=AZtttCnfzpavbx4O1RBVTG0H6EdChzr7I5EX/D6hlAsbRqbnBy1ZAVfuqPq4/PAfao
         YVhaH6mHgm3JkMjS3haw+ifnoqZZPzNUG4Kn4mKpelwF/NvukFKaBK8EuKWil6ksMCxH
         cyHoB92rKM/zs1W8FUKgWv2Xh1FjywCj3hLgyhKXt0kEk+lsG4lgIGBLDDVwQSTYSpVx
         Jq/MWDN4H5lYg8XvKXloV1fcGfdQifwWnWLxGhHs8S+B9YrpwPES0obN1OXV9EEyluhs
         OmAMe+n+DUu6njWwCNcDDFOItfQZU8HQ+Y40gAhXeQJYk11hmQQb6Y2EWY8gq5dJcthV
         0puQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBZRgFTCKEoIsL4sz4nLgpR5o60XOTjt1w0qUx2CNTKNJJxU0iKBERSwETvIoWdp4QCHkaKyXq+6KUkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJFIQKLPd2Hiy6GsTaGIgm8Ext8tJRmoJFbrTLQRnhkZ4hHoq0
	eHm8qf0KK7PsxTvI4yMjeJlSjwtCxD+abucz02pMUWeD57OmlGJkU4cq
X-Gm-Gg: AZuq6aJi0HrooU/RorHTQldDqEfMnOVOZVwGjmF8tWqML1ymJDy9RNlGJHizlnE0mtF
	5uNz+vZtDB+Y7xGDBNuNLF2QJ6YBQ/ZDcPuaPUC/lLbluQFdN/PN0cO/lfGEGYibrRMVjPX8cRC
	P0w39tURZXqFy1GhapJciLDTnlhHYPyEmKLGmOASkFtwq1DaB6IvcBfZLjsFTCGpCdh/RD1ls92
	PJ1/lkxWzBz0wfwX7jPh67Dz7bTuGlmLQrbxuglA+xGF/ushgm8rtGjVWnUi7JQxqqQC5y9J2K9
	dnYk8Q/oUWsa/q2ciHcHIvqZWhZDZ++bawGIw5PGeWwLMsXh7WUDWBRpLo2b3eEfBp95K2RxPab
	OC2eor7vkMqEXBHVqgaPiw/ejCNistfdEdlAr9XYQPMBEIkTWrQxP1eiYl/pXKnFIJRpdBHH75E
	T24mx6aqTKCPZs8bHCSapC9UPsP3jiQQNnHrCX8+07L1wT3GJIkYxcUfrtraNN2K0HGnr21/9qI
	QCBe6qUljqdYA==
X-Received: by 2002:a05:7300:3b03:b0:2ba:974c:4949 with SMTP id 5a478bee46e88-2bd7bd5e3c0mr1732505eec.34.1771720647138;
        Sat, 21 Feb 2026 16:37:27 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:73d:b075:516c:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc167d3sm2383191eec.24.2026.02.21.16.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 16:37:26 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Fabio Baltieri <fabiobaltieri@chromium.org>,
	Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>,
	Simon Glass <sjg@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-input@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] Input: cros_ec_keyb - use BIT() macro instead of open-coding shifts
Date: Sat, 21 Feb 2026 16:37:12 -0800
Message-ID: <20260222003717.471977-4-dmitry.torokhov@gmail.com>
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

Using the macro clarifies the code.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/cros_ec_keyb.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 2f78a19521ab..fabbdbc22785 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -277,8 +277,8 @@ static void cros_ec_keyb_process(struct cros_ec_keyb *ckdev, u8 *kb_state, int l
 
 	for (col = 0; col < ckdev->cols; col++) {
 		for (row = 0; row < ckdev->rows; row++) {
-			new_state = kb_state[col] & (1 << row);
-			old_state = ckdev->old_kb_state[col] & (1 << row);
+			new_state = kb_state[col] & BIT(row);
+			old_state = ckdev->old_kb_state[col] & BIT(row);
 
 			if (new_state == old_state)
 				continue;
@@ -411,7 +411,7 @@ static void cros_ec_keyb_compute_valid_keys(struct cros_ec_keyb *ckdev)
 		for (row = 0; row < ckdev->rows; row++) {
 			code = keymap[MATRIX_SCAN_CODE(row, col, row_shift)];
 			if (code && (code != KEY_BATTERY))
-				ckdev->valid_keys[col] |= 1 << row;
+				ckdev->valid_keys[col] |= BIT(row);
 		}
 		dev_dbg(ckdev->dev, "valid_keys[%02d] = 0x%02x\n",
 			col, ckdev->valid_keys[col]);
@@ -780,8 +780,7 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
 	idev->dev.parent = dev;
 	idev->setkeycode = cros_ec_keyb_setkeycode;
 
-	ckdev->ghost_filter = device_property_read_bool(dev,
-					"google,needs-ghost-filter");
+	ckdev->ghost_filter = device_property_read_bool(dev, "google,needs-ghost-filter");
 
 	err = matrix_keypad_build_keymap(NULL, ckdev->rows * 2, ckdev->cols,
 					 NULL, idev);
-- 
2.53.0.345.g96ddfc5eaa-goog

