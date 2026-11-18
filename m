Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794965958;
	b=s++MqRicZ2zLPJSdkcNPWUQxhyOGuT05qpIDrkFzBtGPDE+FBGzdhIbxBzhY2lGPMo2L
	 JkkoG0JYVXLJ7IgiyhdV63rLNkZ7nNQdDsFNybdlyob3hPUaM75niVyJkuQrei9fERixu
	 Hrky+GXn+Z0yyv84v8YaR4fxY+mAu3J/I+tFVM0Saq86CYCJNwUC3vrBi7o7K061yUnlY
	 Cypv+3WXCfvZAs7k/nqC1CMxGF66YScvQjOWfh8jkipdWDrbZi570akBciPCkIXvXiHL4
	 TulOhZ34DQRYOk8k9lMoa+9OKNujkG+IgNWoM4GuzXNlJRVUyDVWUEG+vYm0C7fK3yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794965958;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=sSpSJ5wXnKKj4djOodlY+VVOZugZ41sTNKQIxuJGolI=;
	b=ICO6POW0H+4SfT4xDD3p2myLb89ao5cpAY8cL+WYDkc9HB29pVMyeb1vJXqKQosdTkbh
	 lWAx/SDyd0Utz5obPnqKtVmmuRlZCnw//tJDxyglGB79NvCwLscTWyhnuUeuUVHfwnDE6
	 bEY552fs/c+VewP1UYGM9tciXzJDnZ+dSpHEAR63lQtrQUjXFEXBGClnRF8gYKG9UfuYk
	 NYJfHsWlooMwD98/JevWRKDpTPn28IvygDMytLRSgjXdpNU1V6kwOqiXJfhZe46xRj4sx
	 VxFycS2gdouHYzSuq/OkqzXJ+kYiCv8KfgXpXfMwrwmw8fd6UQwam2krWpp6KodJlvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=igorsousa.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E65606A31C
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 01:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0E65606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=igorsousa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b4b9ba815bso2691747b3.3
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 17:39:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794965957; x=1795570757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sSpSJ5wXnKKj4djOodlY+VVOZugZ41sTNKQIxuJGolI=;
        b=MiYReyiLSGXeBK6xbaMnIicBZYMCrcL+Ai1qcjGlIfGaxDlxh2O2IKA2z0mG7WaDZT
         sLxjPYUst7ze8ID08N0yATcWz+16QBea4VWL6iLzQqDTpcf6rHcHdEwvky2KEyoeO5mG
         Rtciuk22yA1ZQf55TNH4TQJwGRuMMPBnYnQVj6Drb7d6FVNMKj2oAN0gPvW5RksebRWw
         JWOje7nnDHSTAJIYLypKLK+7ODfblQH/9cXVghmHtfanQgc3bv/vDUbE1Ov5rfG6WkG/
         2i+Vi42C+g8T0Y3W35ASV7/GJpT0lB+Fq6rYa5XhzQjS7RFfkq182npfH/VgNCvwuiLH
         gbKg==
X-Gm-Message-State: APuU4Z/6DOYbP6mrDKwbfvp3NJ2LLBFQlCocD+dXFdxLV2PPukjn6C7H
	fYftuO+4Y10lnvkl/Yt0UUsHzyYszLQmMXRG406+YBN9hliVuz/2uPIp
X-Gm-Gg: AZFdTZcVwCnQPSzk2m+rms2SvXN/z6xqyJFKjrKyno15RuFDFrpOb3Pv3F7zu6KD9oR
	kwfnwdS1/D9Lh4po8cRAfFsemwlZodWFT8BPIZmajYj66dcNdIIv8f20PfgtqRe00+JEkYXMBGi
	e/EbJLBBMlx1u8FikVL+KB2Umrbr+gQQe5HnhDfIH/ZHrz+pQpJQJQWRHs0Kzxtc6CnU1CDn0YW
	GWlYczTsnrA4EhxVhDXy44HGhmil3pA182QqOHgUqYFtGNhVA6IE+WheRFdsJDTNh9GoEB33EiX
	m+CE8qiAcaVsy9KBJWDdOfvIh8kuIaXrxvaCqRYhXj3CYBsAe5SAZixsaEWiavSBVrIU7Rct0b9
	pW4lLtFqspaRV2/NXN0yYtl4qm5cbwoc4SadbqdhzQ8Fs/ndUOp1BnQStwq45pT4NAIx+eZQIzs
	s1qrRIgKoyIXatjwLLiLur0Dh1vGNOXe1dv+xozyFgtExgaK2uuS0xou0rqA/NXQrzHirvVE96B
	yCHgBpm9PgMBUZppy90A0luUiF5ARb8mHov1Lm0HU98u+IAKF5m77ES+4hkyC+BzSHcHOjBycZa
	jf9BLxJpqXX6ceIVHpqP9jO2K8w=
X-Received: by 2002:a05:690c:4d09:b0:8b3:5451:3702 with SMTP id 00721157ae682-8b4fed89ebamr5728487b3.37.1794965956872;
        Tue, 17 Nov 2026 17:39:16 -0800 (PST)
Received: from fedora ([2804:d59:8687:a500:6418:f958:e1ad:d4b8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4fe031343sm10314287b3.9.2026.11.17.17.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 17:39:15 -0800 (PST)
From: Igor Sousa <contato@igorsousa.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Igor Sousa <contato@igorsousa.com>
Subject: [PATCH] Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3 15IWC11 (83WA)
Date: Tue, 17 Nov 2026 22:39:02 -0300
Message-ID: <20261118013902.10467-1-contato@igorsousa.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Lenovo IdeaPad Slim 3 15IWC11 (DMI code 83WA) requires skipping
keyboard deactivation in atkbd, similar to the existing "83RR" variant,
otherwise the internal keyboard won't work unless the
i8042.dumbkbd=1 option is passed.

Added a DMI quirk for the "83WA" variant using atkbd_deactivate_fixup.
Tested on the hardware without i8042.dumbkbd=1.
Fixes typing and keyboard LEDs even after suspend/resume.

Cc: stable@vger.kernel.org
Signed-off-by: Igor Sousa <contato@igorsousa.com>
---
 drivers/input/keyboard/atkbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 019cfa855..8de262d8a 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1943,6 +1943,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* Lenovo IdeaPad Slim 3 15IWC11 (83WA) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83WA"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{
 		/* Xiaomi Book Pro 14 (TM2424) */
 		.matches = {
-- 
2.56.1

