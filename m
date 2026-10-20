Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488268;
	b=XbAK8dGANSBKa6dsBWc9oIGWaY6TwoCi9kzO9ijEhgUeFksXKrxXnb63+lI3Ms/N/Pwv
	 EOK9OIVGE9Yqq+8mbLU00udY/uvC4Xf4bMJ7duAkXCtxnWppD2ndlT1N6bbytZqb+ZKjE
	 HsYGsvUp/K4elzimGfDd/RtlZ4CMn60hpp0yDt25t3PaD/pMYSHzauVMcndbTcHyougmU
	 TWpE5kE8lnBr5ODkPGuJfCNVRVKH+AeJZ/wOazNjIsDlUbevX9l7hIWpSBGqTtlP5kRkI
	 kdPzKkqD6O0KYysk35+k1TIgoGYF0PSPrMJ184dFqSL0YP/sqKEiYlKyfmxVpGZeZRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=m7FiN2KPZTZS6gSUsuYcj9vcXPLqLFKq5outJkEv+Ms=;
	b=odzwFfG/y8PLsyYANQfmpRHiAGp0uOvsz9JrMRrfMl+/0l4Y46CKk8TEecOAtP04BSb5
	 C1Ukr1S4RpwAFtmkA870jgpO9RMU/ya0c4cPkLM4TvO8jBHvuPtpctFSQ0X/eCpDGnnrD
	 obKuN0BmmyBwEgU82mP4t/Q80Hg5CH2GLMQvOOxar+6Vq5NxQGpSwtGsDybC6E7QCuWsR
	 No1+Rg5OPF+X99y+RZBl9Zaemb6GqWQNm4DegtCrREsEedkQfQCE8Eo+Jeyx9T7PXYckP
	 3e8/pQbyP4AKZLsV2BpqXnWA3yyczNQV8gHU0xGDULKdZ5hDVV5y/3ebOTkLSFHPaTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TBIY5GzK;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5F2606A323
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 09:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C5F2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TBIY5GzK
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48df4f540ebso1668500f8f.3
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 02:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792488266; x=1793093066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m7FiN2KPZTZS6gSUsuYcj9vcXPLqLFKq5outJkEv+Ms=;
        b=TBIY5GzKyRGS/5ZfJ0sFgxp1Ctk+jJMpGD09OGcYPtx0Nnl0JZl2i3EKvOjofSZ42c
         4oAORm2CfuIvWLZQxN2Exz78653+3searAySWfxjlptiyFIFXcNLZKqdJeJ7LbjmyKRM
         8c48p9kjEqLbClrPdNTmwCYeQPP7bELg4NyOsXpX9n5kX0Y1WcgXfsu3WlOV6V4d32wm
         5XeNlBt1LQdWPnFnFdrRWdQr2m1z4FtoW7T3uS4ye5o7rSowZqsGApuIISoxa+uMyzRz
         tm1+Oh81Z/XPYp2jseT1R+jLFGemjHdsX0NxbAU1iBEVxV94m8iO7k1hLobkmWyXOrLM
         anUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792488266; x=1793093066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m7FiN2KPZTZS6gSUsuYcj9vcXPLqLFKq5outJkEv+Ms=;
        b=CJJVZ15su2ZUgNx6JiAvt0pCC9pr61o27afWivO2cXHr98AD7YEEanL0m+JbHNviRw
         uyrTDmzgyRcHBq+hvYVBnDoOy6p3PwqYdyCLH6GKgFMv5XHQuFEo+VwFAtRyiS6XsGTA
         5JU4BfrasvnRSc4ARX0Lx+0SsBhIk1Yz6H4ApTtBcrAjckvv2lK3qstKDjShMJsGjsTw
         u/+ZrgsPufUMp0mbq2PVuzGGHQhW3EA7RLwhDGuJWKm71VmbtwEfJ7HghkCvlsBtetaM
         mqxQ0Jm0+FGRpmYJyHRKGaj3HPPI9Dd9lBBIPm1+bpkbZimZDzfWnyltHHIGr9TmVc3o
         g0IQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+JA3/G7upQY8yg0+6ETbsDbQDOohlufufy1uAyb1Gs1tqCROC4yGAeFNw5KtXYsdIOZ3FEGd7i9XBOw==@vger.kernel.org
X-Gm-Message-State: AFq9FYI3eptfi2uomlNk0xtMHl/utiveZomdUL4rYcC+Pk5dDqRr5HpB
	A7wics18kBisN0DecehSXGgXHOraEmidve7KYK4f7lyFjqvWaxdGNXMZ+mX1Zh8I
X-Gm-Gg: AYBFou2N2xqU6FPg0yKr8XSBfTg11oJMssZxSPn8RNo+aOXv4dKIiCZ4kiLaY4Y4TwJ
	XNAcQrzLWCLpgkp4ujyUqeq8qjLb455XYr7FQAMwsXYYoglU5oRe8TD9H0SLDfxfd1wzTlR+L0w
	QcgfhAuTiekYsdblpKwQIlvAqDn/nPVOR/mUvnrF/wk+WQE3kvs/hdf7hvOYP8UJrXUWfwR/TSZ
	aFOlSYJKtYmxiP1eoKzZfcxmpBxzVyq5Ha4bYmio/S+FzS06N1uPdhAp9hOrUclQMpjQj0RnwFW
	OzU3WWh16dQ5dk6WQHBbBm5Uo2tP4yavcQB3Y9w5GkG7Knn76OX9D9YQ0DCtnvYggSJMkWvgYEw
	oOQoqMf7RCSAfiTgIMgiVT3uiJmdlYEWno5dkL0DGmlFsWCITrGGInuZIgqu1iIKeOvaxupmfPr
	UO0s2meBh5mGKGel77ZHf1ZoOJk5wISNoBt6Dl0cPSYvl87+r5YlNycSfD6YnRbGWUCckQmMz3P
	qGknEkS68+57VjxDE/JWDbiq8uaz+gvM9ytxNFX799d3T+9AsmJaBd1
X-Received: by 2002:a05:600c:1389:b0:4a1:d2e5:aa35 with SMTP id 5b1f17b1804b1-4a1d76057d6mr232873225e9.19.1792488266047;
        Tue, 20 Oct 2026 02:24:26 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:f99e:1a52:655b:681])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d1e8ebsm52940735e9.3.2026.10.20.02.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:24:25 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <denis.benato@linux.dev>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	Luke Jones <luke@ljones.dev>,
	Ivan Levchenko <me@livan.pro>,
	Nathan Chancellor <nathan@kernel.org>,
	Paolo Pisati <p.pisati@gmail.com>
Subject: [PATCH v4 1/7] HID: asus: Fix up Zenbook Duo report descriptors
Date: Tue, 20 Oct 2026 11:24:11 +0200
Message-ID: <20261020092423.36380-2-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020092423.36380-1-p.pisati@gmail.com>
References: <20261020092423.36380-1-p.pisati@gmail.com>
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

From: Joshua Leivenzon <hacker1024@users.sourceforge.net>

The Zenbook Duo keyboards (UX8406MA, UX8406CA, UX8407AA) ship the same
broken vendor hotkey collection as the T100CHI/T90CHI keyboard docks:
the Input item of report 0x5a is preceded by a single Usage (76h)
instead of a Usage Minimum/Maximum range, so none of the hotkey codes
get mapped and every key press logs

  Unmapped Asus vendor usagepage code 0x76

Extend the T100CHI/T90CHI fixup to the Zenbook Duo: the descriptor is
90 bytes long with the bogus usage at offset 66 on the USB hotkey
interface, and 257 bytes long with the usage at offset 176 over
Bluetooth.

The dock fixup only moves the 12 bytes between the usage and the End
Collection item, as nothing but a bogus trailing 0 byte follows them.
That is not true of the Zenbook Duo: the collection goes on with a 15
byte feature report (also ID 0x5a) after the Input item, and over
Bluetooth a further collection follows it, which a 12 byte move
corrupts, leaving stray 0 bytes at the end. Move everything after the
usage instead, after dropping any trailing 0 bytes, and allocate the
two bytes the usage range adds. The result for the T100CHI/T90CHI is
unchanged.

Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
[pisati: fold the USB offsets and the padding removal into this patch,
 bound the padding removal, move the whole tail of the descriptor, and
 initialize rsize_orig and offs so clang does not warn that they may
 be used uninitialized]
Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 drivers/hid/hid-asus.c | 44 ++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 27c1c3188513..c2ba2d825191 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -102,6 +102,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_ROG_ALLY_XPAD		BIT(13)
 #define QUIRK_HID_FN_LOCK		BIT(14)
 #define QUIRK_FILTER_CAMERA_COMPANION	BIT(15)
+#define QUIRK_ZENBOOK_DUO_KEYBOARD	BIT(16)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
@@ -1707,43 +1708,58 @@ static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		hid_info(hdev, "Fixing up Asus T100 keyb report descriptor\n");
 		rdesc[74] &= ~HID_MAIN_ITEM_CONSTANT;
 	}
-	/* For the T100CHI/T90CHI keyboard dock */
-	if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI)) {
-		int rsize_orig;
-		int offs;
+	/* For the T100CHI/T90CHI keyboard dock and Zenbook Duo keyboards */
+	if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI | QUIRK_ZENBOOK_DUO_KEYBOARD)) {
+		u16 rsize_orig = 0, offs = 0;
+		u16 new_rsize;
 
 		if (drvdata->quirks & QUIRK_T100CHI) {
 			rsize_orig = 403;
 			offs = 388;
-		} else {
+		} else if (drvdata->quirks & QUIRK_T90CHI) {
 			rsize_orig = 306;
 			offs = 291;
+		} else if (drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) {
+			if (hid_is_usb(hdev)) {
+				rsize_orig = 90;
+				offs = 66;
+			} else { /* Bluetooth */
+				rsize_orig = 257;
+				offs = 176;
+			}
 		}
 
 		/*
 		 * Change Usage (76h) to Usage Minimum (00h), Usage Maximum
-		 * (FFh) and clear the flags in the Input() byte.
-		 * Note the descriptor has a bogus 0 byte at the end so we
-		 * only need 1 extra byte.
+		 * (FFh) and clear the flags in the Input() byte, shifting
+		 * the rest of the descriptor by the 2 bytes that adds. Drop
+		 * the bogus 0 bytes some descriptors end with first, but
+		 * never the Input() item that follows the usage.
 		 */
 		if (*rsize == rsize_orig &&
 			rdesc[offs] == 0x09 && rdesc[offs + 1] == 0x76) {
 			__u8 *new_rdesc;
 
-			new_rdesc = devm_kzalloc(&hdev->dev, rsize_orig + 1,
+			new_rsize = rsize_orig;
+			while (new_rsize > offs + 14 && rdesc[new_rsize - 1] == 0)
+				--new_rsize;
+
+			new_rdesc = devm_kzalloc(&hdev->dev, new_rsize + 2,
 						 GFP_KERNEL);
 			if (!new_rdesc)
 				return rdesc;
 
 			hid_info(hdev, "Fixing up %s keyb report descriptor\n",
-				drvdata->quirks & QUIRK_T100CHI ?
-				"T100CHI" : "T90CHI");
+				drvdata->quirks & QUIRK_T100CHI ? "T100CHI" :
+				drvdata->quirks & QUIRK_T90CHI ? "T90CHI" :
+				"Zenbook Duo");
 
-			memcpy(new_rdesc, rdesc, rsize_orig);
-			*rsize = rsize_orig + 1;
+			memcpy(new_rdesc, rdesc, new_rsize);
+			*rsize = new_rsize + 2;
 			rdesc = new_rdesc;
 
-			memmove(rdesc + offs + 4, rdesc + offs + 2, 12);
+			memmove(rdesc + offs + 4, rdesc + offs + 2,
+				new_rsize - (offs + 2));
 			rdesc[offs] = 0x19;
 			rdesc[offs + 1] = 0x00;
 			rdesc[offs + 2] = 0x29;
-- 
2.43.0

