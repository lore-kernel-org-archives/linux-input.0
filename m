Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E0E253B73
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140743; cv=none; b=b76tMS0+I2vfLzbmHvZopngz9vAiL1d0WMJX+4QUKNiei9keDOj5FB0c1cOvW77CxuVLaTu6f4qR9AulrJ7nFLjkxACZSAEgHwDe1xVFl0DJIehZZMZPdDgfXXgiHTHxGY047NkH3u1vXCJIjJRxroDVpes5/64RO7ejOR8RtJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140743; c=relaxed/simple;
	bh=5aoSMvKznFVnaihLMmeqnPjS5F/JOZrkmo6E3ohwZPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjZprFaA90/SVsvYqp+A7lSjPbHAWAjKLxCc8ve7/14QuAhEVn+JPD5lYSQuVwDJAz1esHUCBVgI0uVK3Ur/hp8DicBrUGl4Coq0VLIlvK8+SiIGMcSJFxneQFb20M697Bu4ovSJp+0lHNgNsPYw8BifZR/UdvL0OQ4OUqVTZ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlMx3PJJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlMx3PJJ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b86ff9ff9feso65086366b.1
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2026 09:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770140738; x=1770745538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iP2EYq6wOV8jA1cEPaHzJUJnuDiRfLgK32jRdcwRTOw=;
        b=KlMx3PJJMg65Pj/8S3MnWzoC3CqwNHjpDH+aJWITqEcBhEZkz9leBkKrKIgxXO5bD/
         4wxxXuEYEGzlmIDn2I0GIIkz59m8e6OIB6OKBB5zifQ1Yb8PZYqPXjx67sMyTaC8RhgD
         ezY78eNQCOflCWxhmydo9FN2BDodHwJLCyDoapGSaCh8ipnISlnFfrbWFN3ce5KDzDZz
         YfkPVnjuZDLv88MYp3/HLL2EnknzAuD88l1YnEpvnA4xnLrd00UdJu0/OSBVPDIcqRNs
         yXqh44jT842/iy5y009KB2VvGx/Bqf9fiSonuBrNLSUtEOBfn3qbAd6Ll/8FzcvOBEj0
         rdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770140738; x=1770745538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iP2EYq6wOV8jA1cEPaHzJUJnuDiRfLgK32jRdcwRTOw=;
        b=uhgVy1tiOov/Ft9SqArymybuWyOAyBDK6UFjHBJjxPhVvi/UnrkXETY5HCOeDvTUCp
         SbvY0xXFAX46cMBLKaCOJuFHsN946lURyAW0AgmmNWljX04jVW+HAEp/vnaqqR7ZO3jS
         uMaIxUrhCnNItIuoig3LMlF36vugp170yHu6mSIIFHi1mDLdJJYZ4vsYK8zX/w+8vIm4
         4Ep/3sfda7629H2lScK47CACG0gbmzTOSrggJh2x4+sH5K0pJlgqW/il6MAGHN4iW5/m
         49ZCCm1njh+fyM7dqhKPz94b7lz+Q9Pq28v0iFycZbMKnlOdcOx9jhjWz735YJ9gK5iC
         BIEA==
X-Forwarded-Encrypted: i=1; AJvYcCV5ZH2+a+SaiQoFPJcpAu6XLPAQ7C1dVz6gJacDl0TGR9oJ+3C7Zw9oGRi3pAK5HuUui6N1u9+tzrVcew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkHgQ7VXiz+wTo8PGQDRepGrKxHtAn3/QXcomY87II4rkoiY0G
	2X7tdq0r1vSqID9YSaUS3gZ934vE06LvB6y7sYdcTltb1s0BETXP25DV
X-Gm-Gg: AZuq6aLZl2r7BSceCQ3u7gwE5GadEKj/gE+zsw2mvO4pIVtAB/UyHLxSsFR+Ys1LcIL
	SmOzUM+HtPixMy/535dOf8KcVdkMGzBsC4zLh9ByV3fXnlRYrw4lVie4Cs1kbeFM7xILT+Dhrhn
	MOOx10ApwvHCP75KyKG+dbWyVmhhc+gXCIUdXhRQXZMLV2ABA5HL5E5g9bopnis+MbQq/HYlf8l
	kdSSQJCG8ZyNN6vm3uegTtJcUbaWrQRV37cGmOcn/CG9uX5i5x29XAT3YfoTOGUIENo27hADPJX
	LCbFTgG1AhgFPm1f1FbR9vzexLk3XxqIcE8dwozQIYxixFJqaS9QD/BgaOipDHKs/XfTQKMJVU+
	GAzjagDL6xJE4xr5zzF8hyjeG9Ka9INgUSA8ODuU+I0u6FJtDXthgSFylp0ehdgJqxziOrieBKR
	WmAmGqBeEKhOWMiIu7xyholkS0tN8hcz5LsW69u4vLqRo554iwawI0IPw55EShPpXQ0fiXO21Oi
	7Y=
X-Received: by 2002:a17:907:d78b:b0:b8d:e6d2:6440 with SMTP id a640c23a62f3a-b8e9f176cb7mr14986366b.2.1770140738159;
        Tue, 03 Feb 2026 09:45:38 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fef001csm5078866b.44.2026.02.03.09.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:45:37 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: oleg@makarenk.ooo,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tomasz.pakula.oficjalny@gmail.com
Subject: [PATCH 2/5] HID: pidff: Add MISSING_NEG_COEFFICIENT quirk
Date: Tue,  3 Feb 2026 18:45:28 +0100
Message-ID: <20260203174531.2866644-3-tomasz.pakula.oficjalny@gmail.com>
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

Windows/Directinput allows devices with missing negative coefficient for
conditional effects. Negative coefficient is ignored in such cases.

Donot fail set_condition usage search if negative coefficient is missing.
Fixes conditional effect playback on Asetek wheelbases.

https://learn.microsoft.com/en-us/previous-versions/windows/desktop/ee416601(v=vs.85)

Co-developed-by: Oleg Makarenko <oleg@makarenk.ooo>
Signed-off-by: Oleg Makarenko <oleg@makarenk.ooo>
Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/hid/usbhid/hid-pidff.c | 11 +++++++++--
 drivers/hid/usbhid/hid-pidff.h |  3 +++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 68049d5d76b3..aebf6c89643f 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -619,8 +619,12 @@ static void pidff_set_condition_report(struct pidff_device *pidff,
 				 effect->u.condition[i].center);
 		pidff_set_signed(&pidff->set_condition[PID_POS_COEFFICIENT],
 				 effect->u.condition[i].right_coeff);
-		pidff_set_signed(&pidff->set_condition[PID_NEG_COEFFICIENT],
-				 effect->u.condition[i].left_coeff);
+
+		/* Omit Negative Coefficient if missing */
+		if (!(pidff->quirks & HID_PIDFF_QUIRK_MISSING_NEG_COEFFICIENT))
+			pidff_set_signed(&pidff->set_condition[PID_NEG_COEFFICIENT],
+					effect->u.condition[i].left_coeff);
+
 		pidff_set(&pidff->set_condition[PID_POS_SATURATION],
 			  effect->u.condition[i].right_saturation);
 		pidff_set(&pidff->set_condition[PID_NEG_SATURATION],
@@ -1090,6 +1094,9 @@ static int pidff_find_fields(struct pidff_usage *usage, const u8 *table,
 		else if (table[i] == pidff_set_condition[PID_PARAM_BLOCK_OFFSET])
 			PIDFF_MISSING_FIELD(PBO, quirks);
 
+		else if (table[i] == pidff_set_condition[PID_NEG_COEFFICIENT])
+			PIDFF_MISSING_FIELD(NEG_COEFFICIENT, quirks);
+
 		else if (strict) {
 			pr_debug("failed to locate %d\n", i);
 			return -1;
diff --git a/drivers/hid/usbhid/hid-pidff.h b/drivers/hid/usbhid/hid-pidff.h
index f321f675e131..5bf54e981543 100644
--- a/drivers/hid/usbhid/hid-pidff.h
+++ b/drivers/hid/usbhid/hid-pidff.h
@@ -21,6 +21,9 @@
 /* Force all periodic effects to be uploaded as SINE */
 #define HID_PIDFF_QUIRK_PERIODIC_SINE_ONLY	BIT(4)
 
+/* Allow devices with missing negative coefficient in the set condition usage */
+#define HID_PIDFF_QUIRK_MISSING_NEG_COEFFICIENT	BIT(5)
+
 #ifdef CONFIG_HID_PID
 int hid_pidff_init(struct hid_device *hid);
 int hid_pidff_init_with_quirks(struct hid_device *hid, u32 initial_quirks);
-- 
2.52.0

