Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4134CFCF
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140741; cv=none; b=CVcNxSE1Qar54MD5FuoZt90U7EB2a3JVEoh9QX2JnWVwVLzuSti6r2EZAahclaM6V1m8NmsIFpAwMCcfHUq78pXu1n8ktSddEpGz81SS1HLMQmUaruEbMYPFosCrhBcMJ6YPz7G5WugEc4MCJWA3DK9IgVRkquyH1V/T8COyGko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140741; c=relaxed/simple;
	bh=UmM/EFR5p4e/Ka3/5sJVIS3R5eLWlyTt1qf6h8ubdhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VcahuYtx3vOnhuniO4AyYzEqEMOKUfIkUka0xCmmkC6W9RMJnD6Mp6rCwlGd+ktUKSXF7c5iVXADTVLiYFqsTE1pK6lvKi97/dUAgZfuo6etNxkfre0Pm7MMia2VcIIMcAyJGmKKl6xXEFHQC2DmDr42fQR5Q0f99mcGTc/UwgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQtFNiDX; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQtFNiDX"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8ea0a386cdso96366b.2
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2026 09:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770140738; x=1770745538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQaGsVyRIVNSv/UVCCLU9KGE4wXIMnAIjksSPCQ051Y=;
        b=dQtFNiDXkPORaZc9pQyWffgpG14BhXRqw7oqcT+ptcLF+LayPkqzJBYUF424w1SZeD
         lAOxJkpsCzFOv9OMaeL44OnKal1PZotokGuqjMGZFTxBtIQ5gqdw1aW7HT81n7Yc49XZ
         o2EFuHdo52C0GOd53DEHfMlYpnYfSwnS1TkfD1I02iitJCPVHqBsXlcrUNHrG1ao/OFV
         hdKYZhD83uxywteBfdIcyK7D5b+UzXcKANJ63HLLa0YfW7nMef6W3NU1QaLk4MDfgdYC
         O1O+3Aql2amgJNj0m2osVMwdm1lk74Bf4h+eOOUPlrb9Y390NMOrIi4qHT6JJiK0GP3M
         R8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770140738; x=1770745538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BQaGsVyRIVNSv/UVCCLU9KGE4wXIMnAIjksSPCQ051Y=;
        b=dkCUWW5pC0a7S6bs004BSwDvrrtTB7nJ2x0mrPJrL9z4q1DbTE/IxPIwOZlenB8XOm
         C0FHb5rlMhJz5t3oAbbbyWgEBskJ9GjFDmPEWy4AN2Djeu+/5vPAHR4opiL7M9iHT6LW
         mOTij6eZEPiAGQBTsiGGf8jj1DByGFZLAnCQnaV29KD4Yl1jvMWGRVCgPLlzbhRuZuT5
         8XawB/ACRGzgaLOOCGBCclivvssgS4q7MeKJj5bpHGZT7bUoZBzvRI1BA+//UMy+9S6A
         8dxAj3mkkjdCQa4pW8GqpRVBCZtFN4W1WfiuHalCz0S41M8rTlR8A7do6nZ0wvUbMUtU
         QtVw==
X-Forwarded-Encrypted: i=1; AJvYcCVjY3+bTrmw1lo+S+o8JSlyAMl5EkXJ8XbizpQd2cmLO0QFS7SveWYgMP6xjDR8wJkhP60n4GFnd1V+LA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwammbwrGZ3wCoFIdKU2Np0nyb+qqrz50J1cbpSualAyW2qeWDF
	7bq9cGYrBdy9e1DEbyc6wbViOv8UQ3laMBDzuKOjYiEzSpBabbLpWI0P
X-Gm-Gg: AZuq6aJuG+7jrHf+wxxtCjpuVOUowqw+RB+SLJJc3GmPhyof2UCYx1NYGJE+Pcw8D8c
	HjvT1mLOQSYKCJ3wbmdXmQFqu20sekT1jcx7jQT9reB6tpmJmF3GPLJWmop6uvk34vaWS/qHp4I
	wdiGxkbetf/BLQb0apdjTyAk/+nWqCVW7VLp6dyUE3qepZ7+GwuuEQgElFKOiBhyqzgoBCVNZSM
	cy84SlR+iK5j8+Ae5Vboh8x1/W35a55VuDqBhujLOIknXu/DkrRvEFAz6k7LVqR7D3tIrj3jCIf
	GDBcXIyw7Z88ciCZxLqQ5Xl4w5scwEmxuWZBHR97BxIkyvvkxE84u1o67w9ckn3uSbH5gZpTjEk
	NgfXLlEFzyTRb0ijH/4euHijy3o++Nh25ArFIFKAOOtTxzdJoUU3QIbMuhKErlvzGGBMFbfJhaq
	Uv8Qzrwt3+lSD7VZlI32cNYFbPyRYVsfxxMYWewgZEf5AXRFy1tsGX1qfNIiXlQBcN
X-Received: by 2002:a17:907:1b09:b0:b87:3c3a:cb7e with SMTP id a640c23a62f3a-b8e9f658f89mr9316066b.6.1770140737315;
        Tue, 03 Feb 2026 09:45:37 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fef001csm5078866b.44.2026.02.03.09.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:45:36 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: oleg@makarenk.ooo,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tomasz.pakula.oficjalny@gmail.com
Subject: [PATCH 1/5] HID: pidff: Refactor field quirks detection
Date: Tue,  3 Feb 2026 18:45:27 +0100
Message-ID: <20260203174531.2866644-2-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203174531.2866644-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260203174531.2866644-1-tomasz.pakula.oficjalny@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In preparation for additional quirks

Co-developed-by: Oleg Makarenko <oleg@makarenk.ooo>
Signed-off-by: Oleg Makarenko <oleg@makarenk.ooo>
Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/hid/usbhid/hid-pidff.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index a4e700b40ba9..68049d5d76b3 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -13,6 +13,7 @@
 #include <linux/input.h>
 #include <linux/minmax.h>
 #include <linux/slab.h>
+#include <linux/stringify.h>
 #include <linux/usb.h>
 
 #define	PID_EFFECTS_MAX		64
@@ -1053,6 +1054,11 @@ static int pidff_find_field_with_usage(int *usage_index,
 	return -1;
 }
 
+#define PIDFF_MISSING_FIELD(name, quirks) \
+	({ pr_debug("%s field not found, but that's OK\n", __stringify(name)); \
+	   pr_debug("Setting MISSING_%s quirk\n", __stringify(name)); \
+	   *quirks |= HID_PIDFF_QUIRK_MISSING_ ## name; })
+
 /*
  * Find fields from a report and fill a pidff_usage
  */
@@ -1060,9 +1066,6 @@ static int pidff_find_fields(struct pidff_usage *usage, const u8 *table,
 			     struct hid_report *report, int count, int strict,
 			     u32 *quirks)
 {
-	const u8 block_offset = pidff_set_condition[PID_PARAM_BLOCK_OFFSET];
-	const u8 delay = pidff_set_effect[PID_START_DELAY];
-
 	if (!report) {
 		pr_debug("%s, null report\n", __func__);
 		return -1;
@@ -1080,17 +1083,14 @@ static int pidff_find_fields(struct pidff_usage *usage, const u8 *table,
 			continue;
 		}
 
-		if (table[i] == delay) {
-			pr_debug("Delay field not found, but that's OK\n");
-			pr_debug("Setting MISSING_DELAY quirk\n");
-			*quirks |= HID_PIDFF_QUIRK_MISSING_DELAY;
+		/* Field quirks auto-detection */
+		if (table[i] == pidff_set_effect[PID_START_DELAY])
+			PIDFF_MISSING_FIELD(DELAY, quirks);
 
-		} else if (table[i] == block_offset) {
-			pr_debug("PBO field not found, but that's OK\n");
-			pr_debug("Setting MISSING_PBO quirk\n");
-			*quirks |= HID_PIDFF_QUIRK_MISSING_PBO;
+		else if (table[i] == pidff_set_condition[PID_PARAM_BLOCK_OFFSET])
+			PIDFF_MISSING_FIELD(PBO, quirks);
 
-		} else if (strict) {
+		else if (strict) {
 			pr_debug("failed to locate %d\n", i);
 			return -1;
 		}
-- 
2.52.0

