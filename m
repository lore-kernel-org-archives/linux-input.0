Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC24D378815
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2026 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772649575; cv=none; b=dRM5UJH6a/yQjZ8jg3WXm1tKVQSOYVei12x6aBqw4jOTvQNoUBPS+2PoV+gRjgzAOtZuIsWWn23BP37kDbMCpF9NNvHbp2isrvYrDcyE/UdyA4GqRqiR7Kan95PSqfqGL57C2OUMdEblags1X/qm0TbSoNLs608U4fqn0j+jevE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772649575; c=relaxed/simple;
	bh=SlXJgVlLcXW2/VvlnJbIUNe2MwLiJ2ymC2ZvM1vVQiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AEFi8U12QGqAHKNGLDJRJ3v0J8ijYn/khIVFkB7aupVH5sUvymG8o+qjF8BLOEY6qVdbwmfBLAfrCEl7FQsMLCOyqiG7fzGw9+F+JIW1ZGEkXnWAjWmyVrBjy3tpiUnvkkAYAX04KaQalt6jwbXzr0lVf3K3EPuiLTu2ApaEdxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=60228.dev; spf=pass smtp.mailfrom=60228.dev; dkim=pass (2048-bit key) header.d=60228.dev header.i=@60228.dev header.b=fhpJX0CY; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=60228.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=60228.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=60228.dev header.i=@60228.dev header.b="fhpJX0CY"
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-64ad8435f46so6828634d50.1
        for <linux-input@vger.kernel.org>; Wed, 04 Mar 2026 10:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=60228.dev; s=google; t=1772649573; x=1773254373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LdH+/2vA+MZr4xbWd5GfCnhwRGt6Mm7ZUEksueZFcsw=;
        b=fhpJX0CY8BCbe1OdqQvqnJWAB2nure7VAyjQN771/3xpkWMHqpNxtnStouCLSoK3UO
         DikSwMPXkHGEyyoqBk/QFac3Q3TdyuWuD2n27IKSRN7UewsMdd4Z93dBvkTzJIUEL+6j
         OPibpUfcJTyv/XLHFcZQCogCan7DwH/iSxnstsFh0kxGVfoW8GmdrzdKyRGCHuatDldv
         i9ypBx0502/Tf5VnUlXHzWFtFiGI4JDFouiexLmg1krILSMQ1kTm6AgbBEWW73qWpDFV
         6kFqMxGfW0MCm5wtb4gQcW5xRRSUDPVUkq9/L2gftamFSg+p+2yV+OGDZsVy3LcQerx0
         s24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772649573; x=1773254373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdH+/2vA+MZr4xbWd5GfCnhwRGt6Mm7ZUEksueZFcsw=;
        b=iKKZq4Uo6nXsuqjhGmFVDKQ2IITQxOAKwK/NLuJRQkKgx0elCqQv3VcmBfIkDl5ksp
         npi90fm5iTy6knGa6o/RcdY/RHuuZPdLX/HnymgSFZh+nlz8LMKQ7SsqNqOFDw0p4MJI
         /laA0ftRqQqBOV6LgXVQ2EFrQ4PF3obVUuoWdc4TizgdXZcezoKtAQ5QhtCTBJLa8o4i
         cqRQGj8ybSGAv63Xsf6qk79Z+IPdA6LKhaRXgzdMPWNBNGx6RRdFHqAuf6woBCSDUoPG
         52MQFR2dkSn086reMrO7dnIGlxYJfoMbFdVdBSaxXVXRLF9S+ieDnmyEl/Lyog81JndY
         81kg==
X-Gm-Message-State: AOJu0YwKgy0tb0qozOn70dfYJLSxFoi0qicGeucRW5CQP4qlYFjrLYpY
	WKJxyQSg0SG4NoEPP5ysz8Sm5duU1FOSU2eETBxfWgBCoubviqWmDW+iAyazMS53Kr9216qdXI6
	Wdox/6v0j4x0yDyI=
X-Gm-Gg: ATEYQzykgv1BetwlPdoHbjQbUd1VhiQZDmmWj2uS2SpyAwgbCTO3yRDcUdL6jbhs4AZ
	zsN56LffdYwi2s44SSQSx4rkaKqVZCTHG+ubPsewWQ9aPot6sSdfc7rDBlIBuEnrsLWANvvl3nD
	XksyDr+P254Y5qMXKsIt8QguE2nIJAuXpKoD9Id8nFO2eGSzKUIW++1HKQ9PuPbKmSEqOVgAWXv
	/dBrftQD4V2CdQbnKzkSmD6SmUlixMWKueAdi+kcQDQWY/oUAEZfDEzzXpFneNpkTQm/wY5qCR7
	iwOXwFaIMq2ZLYydB6i7aGdFvMgZCFlaKKPDlpOA0D4thxW1u7eQ8nZPZGSY1EL/Iny0URBKL56
	3oEzTPJ2hbTb3Q6G2qDx9fG1mzJIBdnrEXgE/yIi0qJXUyveMe1w0bcyZ8YjR3Uw5vMz2kyOn96
	DN2PSEWuZohVn7p9wy
X-Received: by 2002:a05:690e:2042:b0:649:b2cd:eb7d with SMTP id 956f58d0204a3-64cf9bd8ee1mr2058833d50.68.1772649572546;
        Wed, 04 Mar 2026 10:39:32 -0800 (PST)
Received: from localhost ([2600:1700:2760:3c1f:8653:d57b:8d78:ca9d])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb763d7fbsm8018513d50.16.2026.03.04.10.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:39:31 -0800 (PST)
From: leo vriska <leo@60228.dev>
To: linux-input@vger.kernel.org
Cc: leo vriska <leo@60228.dev>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: quirks: add HID_QUIRK_ALWAYS_POLL for 8BitDo Pro 3
Date: Wed,  4 Mar 2026 13:36:59 -0500
Message-ID: <20260304183727.538405-1-leo@60228.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to a mailing list report [1], this controller's predecessor
has the same issue. However, it uses the xpad driver instead of HID, so
this quirk wouldn't apply.

[1]: https://lore.kernel.org/linux-input/unufo3$det$1@ciao.gmane.io/

Signed-off-by: leo vriska <leo@60228.dev>
---
 drivers/hid/hid-ids.h    | 3 +++
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4ab7640b119a..8c1f41a9e5f6 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -22,6 +22,9 @@
 #define USB_DEVICE_ID_3M2256		0x0502
 #define USB_DEVICE_ID_3M3266		0x0506
 
+#define USB_VENDOR_ID_8BITDO		0x2dc8
+#define USB_DEVICE_ID_8BITDO_PRO_3	0x6009
+
 #define USB_VENDOR_ID_A4TECH		0x09da
 #define USB_DEVICE_ID_A4TECH_WCP32PU	0x0006
 #define USB_DEVICE_ID_A4TECH_X5_005D	0x000a
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 3217e436c052..f6be3ffee023 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -25,6 +25,7 @@
  */
 
 static const struct hid_device_id hid_quirks[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_8BITDO, USB_DEVICE_ID_8BITDO_PRO_3), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_GAMEPAD), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ADATA_XPG, USB_VENDOR_ID_ADATA_XPG_WL_GAMING_MOUSE), HID_QUIRK_ALWAYS_POLL },
-- 
2.53.0

