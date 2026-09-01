Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBEA345725
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 05:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788239022; cv=none; b=DVzPdUHSoy87Oe6F/32FdKeR0xUAar+B8SiitmXZry83pffbiCFV3/eisX5e7ejHhDqyWspVFGljQzt4Bf7CeBZNHl+I77kHj3QMyK/KUY2GDvgG3JAK6HyMHd4EcMIUgXrzIkA/7gXv63oz3Y6UTNU/p1UttYlkhHlx1/UoxM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788239022; c=relaxed/simple;
	bh=0f9ckexkw8YPz6TVt+MF8jibdk1lCgSPeyVwQ1lu2yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2D+geHBnU0E9LvMNtrG96rM+BAZlvWtNnTElhyTb0SUBvzq/yVR+AuqyGyXNjkMWxsOU0ER6kOazJDWDyKdJuQLRQwcv/lu424wtAyloPHa9ePPpNbIxlPzOtYOIlPfi7Ia4nL0a+YKuGxl6DAq3itK9kd147bB87xNa6YvyFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrzbrZu2; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrzbrZu2"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-861a2ae9c51so3844337b3.0
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 22:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788239020; x=1788843820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+wNAReOcI0gA471dYDZ7JuAQax3q2DgP1GPqDgigVLM=;
        b=HrzbrZu2Fxrtv/HB97bHi3KWqcO9FRLnGFhQR8rygYU6Z3pHpLUVPXnLcXvoVjyA+A
         ALIVn0tEy9zTchqcWE87N+Vt57Pz8SqYyiud4d6APJ7cF23J8RmBE+/00jPaEOeF9Udg
         rYzq4D2UTggIi4GHdo5M2vmfQVzw+YviRnQwNb/o1c+AEmt7vR/j6MB4WfbNDi9TuVMK
         PIhoirw/Wg1wGyPj2cpX0MGzWX5JLDW8WF0+mD4JQBWXSOgT6/SIS83yI8UeO0yPABWP
         mM528N3wxPQ2XIFod1pLXqBQlUNkgfioOHsJJDWEHXwL0gvXc5V4T1CaZy2rphSuAkxY
         l8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788239020; x=1788843820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+wNAReOcI0gA471dYDZ7JuAQax3q2DgP1GPqDgigVLM=;
        b=FZBqMv+GA6MCJNnNQQBMbcsPTv+DZZHr8yLLqqM7L1cYzvQkpdTuNpcrNYq7PgcMNK
         jpihZMgdeDwnmP181zD/jLwDkloEMv7oquuNaErHekrWOHdbArynn+JIY5sl0kFRnBX/
         A6IOsaMOOl4pRiRQxAVOGBbLSFlG6jtYIwZGr0gKQL//1VqHeQgNDnchvKt02hB/Jod7
         c/my5IDYrwh1/tvrqD4iDEyu8q2cW5xRAMNat7nzl5HE1Fbq4D0wrXWmwwF2lRWphAA+
         pzfNMx1guA80xVmVIeRdB0jIPJvLdJt/kSCi0ppQEtC1ECLKHakaBgTQNYzpgKieG7N4
         pJPw==
X-Gm-Message-State: AFuF++mZuLsMcPkLWNUMgYdGsE7dBahJgT+WWWuUErPkkMCTfVM47fay
	9UDBhaWlLPGmVrF8cXcmb/TwjwalCoIzf2eNoqz4EFFVySHpDtED1cj8N9wh8HPv
X-Gm-Gg: AYBFou0FNd8gfFx3NJVsSSBdbHKlbNz2KEvAyWGJI/jqBmrt86AHG6TA8cyOaEB97ra
	gAXavZ56CKLOqMKOZOtuKyv6FDO+LxtleCCFPFjN3wUqa1g4vGEZm+rNz4FEeNHb0LWtTRz+1gQ
	zR4ueMx8wVy7twuo+X+E9tiOPXSmQXitbJWVAGFnp5xRCqO2i+ypWU6sIzBZqrslrH3I/c9mUQ4
	LHQMA0zocVUBNis4Iv8Kc3glR4wIFgzDfLJFlQABxxrx/zdgOSQIFBzOj+f++eyZo5tY9jPYc5e
	ax+2ehtt8RuelMVIRHevaYwFYFbr+iawVoegVRU7G9FjyCecPYsOCgNBZiaP5rXdijFHcAgOe31
	R9miXWfw+4ZYpRCJltrj4jU1PhuNcQYfAFupwrKO9YaLsaqaPGeiM9HQy8NZq5ITN59OdWkG5Wv
	AALS5PXnPlWnbuNy0A8G1ashUUUq1B/Ddv7/0BEj9InbtWCCAFw05CV0oUGErz
X-Received: by 2002:a05:690c:a584:b0:833:f9bd:b289 with SMTP id 00721157ae682-85d6c9ea406mr107121877b3.31.1788239019729;
        Mon, 31 Aug 2026 22:03:39 -0700 (PDT)
Received: from Io.lan ([186.151.24.107])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e5e18114bsm67273867b3.7.2026.08.31.22.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 22:03:39 -0700 (PDT)
From: Andres Diaz <andresd.diaz16@gmail.com>
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Andres Diaz <andresd.diaz16@gmail.com>
Subject: [PATCH] HID: logitech-hidpp: Add support for G502 X Lightspeed USB mouse
Date: Mon, 31 Aug 2026 23:01:47 -0600
Message-ID: <20260901050147.123364-1-andresd.diaz16@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The G502 X Lightspeed enumerates as 046d:c098 when connected with its
cable. Add the id so the driver handles the wired device.

Signed-off-by: Andres Diaz <andresd.diaz16@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 1504de3..493763a 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4924,6 +4924,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC08D) },
 	{ /* Logitech G502 X Plus Wireless Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC095) },
+	{ /* Logitech G502 X Lightspeed Wireless Gaming Mouse over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC098) },
 	{ /* Logitech G703 Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC087) },
 	{ /* Logitech G703 Hero Gaming Mouse over USB */
-- 
2.55.0

