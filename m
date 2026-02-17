Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA8338F52
	for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344118; cv=none; b=MQrrFKyZdlqRKO4h+b+mXO5FsocYSNY0WDys0vFuKGJIt1pe7bRbQuhHxSJfCfdjkb2Q3saeIMHGgVJaIahrz8S/ndmcvqVtyuwT8ebOGmZnaQz9Qx5pCMiTHOA33aSSIDmTJIWXbjw/ewY4q/OguYgkRiCVtIaLVievziekrV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344118; c=relaxed/simple;
	bh=Pz4lfEfYS4nyE/SQUqp3w27aSTJnY160w0WTT8a8SnM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bcAdBOrZKpjl4lTP2WjxP4LfUMqSkEcoNrpkqbmRcZ/+WTbWK0oNMLFi34rbDoPDAub3ssOnLj2fMvyKkKVudKIxWJZwB7GmP+CZFMFtddTpdb9pwaZtPWvTDG02xeVz1h5uKnL+EYo6V3ebKlhoSier/IVYTcIT/vyPMlUFXrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FKalUF5i; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FKalUF5i"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-4363333c102so2915068f8f.1
        for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 08:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771344115; x=1771948915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmHbHptT/xQLvcgY8qMF4oxcaID/3KLnmaRfPxMJwO0=;
        b=FKalUF5iO9+SSJphELBuNcNCB/8Mf/OBTBYb6GwzGyp63Mtb7Ka6r1R6iBUyaDxs0v
         vsboTvUUdqpw9CRpiiwGQPVb06TR4gXzPg9kkEL6KjhMYnf3VOTLgfYn0764GSB0mf8s
         f1wCTbke0g4fINm58ztaFg3LSk/XH2w3MTwJTT7b8PrGGU2a0cmIAa0X+4cwUWc/EAvP
         oQEHm0Chm0q6b37/rTRM2wzrXUn3P04eo0od1AoRD2RIn9YCzmlfUnCuBwytsRkQY763
         VoQ9pGDdSOpeqO38OM1gjXNTT1KQlKBUWMo0+9i8ZEEE3RkV6h8NjiNKa7vd/hLnM3CN
         UY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771344115; x=1771948915;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vmHbHptT/xQLvcgY8qMF4oxcaID/3KLnmaRfPxMJwO0=;
        b=jTMS5cgmkU2IhBOjpJWWK9l2Uy1z8HSZTr/Ea9eZJVDlufO2munG3XMp+Y20w/7lFQ
         n/62PG2R6zA0eWeS6OX12HbzaG2UmyczyyDwY7qM5Nzf4lJ2/ULxjYTulKp0bdNF+keB
         SBkpQ8RSpBDx2y/3xIuYZnDkrP+5z9Bb45/awsU+Ecqxh3eTCE6/NNi/PO3qmzNG7SSI
         9vqHwFTod0ZNljq7UE+jJy1Uvi025NGt7kQ2zdluhxEg2J6YqBY/7g/aHIvamhbOCCG8
         I2WQC1PzseAdl7NvluKP+9GvzXOdYHsYXpM//zkwD0RisuB801AwXkDmPfL1/iG7qJLF
         yZIw==
X-Forwarded-Encrypted: i=1; AJvYcCUuf7ejO9mWeAZDf+BeHjupMj9wlqjNtVIqrAJG7ArqybIGVDFqDDc7QmSVHmDY+FXeGiKi675b64i59g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzB/JVOU259zYArwfjZOzcfU7+LRzpAU2j03AaxwMdYTh2PAqyE
	0IgErqHcRxT79Qg6FpozpNjIeT4GQhOveCqD3Ong/A9njs8h2g0Cl+CSWDKyfL5gjvh8IcAF7FQ
	jofQEbA==
X-Received: from wmbhc11.prod.google.com ([2002:a05:600c:870b:b0:47e:da9a:d7da])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1907:b0:479:3a86:dc1c
 with SMTP id 5b1f17b1804b1-48373a7a0eamr239685595e9.36.1771344115180; Tue, 17
 Feb 2026 08:01:55 -0800 (PST)
Date: Tue, 17 Feb 2026 17:01:24 +0100
In-Reply-To: <20260217160125.1097578-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260217160125.1097578-1-gnoack@google.com>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
Message-ID: <20260217160125.1097578-3-gnoack@google.com>
Subject: [PATCH 2/3] HID: magicmouse: avoid memory leak in magicmouse_report_fixup()
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The magicmouse_report_fixup() function was allocating a new buffer with
kmemdup() but never freeing it. Since the caller already provides a
writable buffer and allows returning a pointer within it, modify the
descriptor in-place and return the adjusted pointer.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 drivers/hid/hid-magicmouse.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 91f621ceb924..17908d52c027 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -994,9 +994,7 @@ static const __u8 *magicmouse_report_fixup(struct hid_d=
evice *hdev, __u8 *rdesc,
 		hid_info(hdev,
 			 "fixing up magicmouse battery report descriptor\n");
 		*rsize =3D *rsize - 1;
-		rdesc =3D kmemdup(rdesc + 1, *rsize, GFP_KERNEL);
-		if (!rdesc)
-			return NULL;
+		rdesc =3D rdesc + 1;
=20
 		rdesc[0] =3D 0x05;
 		rdesc[1] =3D 0x01;
--=20
2.53.0.335.g19a08e0c02-goog

