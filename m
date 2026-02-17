Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5007036AB58
	for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344124; cv=none; b=bpwHv5BFD5Vdelbn8jD4YFyXF15+zDJ0tTu3mvNIVOgnbmxvMjxOcNB5LdtmE3XfZ+ivbwGNrE9PCyqZTu7m20fQqncSUKDWo+5eXdGsMDayU+9V5bVUhLLMB7tMo5sVU0H0bzmytfpedfyVb8Kf938rJAWPeXwcitGnQSCxFvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344124; c=relaxed/simple;
	bh=6wHoJGPxc/bgsQgAP8SAdyvzO2Ye//4fEtok06MhYu4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A7vtnz35TweSQl8ajN1OYNaWE4WIrArG7yaBF76CvZwplNpK0BtL3KiiPVhMl7S4udsY9M1pAHtGDIxyjKqNHi+eaUG7P65d1c4ONmCGq+eBK9xoQfKLUmI3tIVraw+gf2vsMi7y1bjJuJ2y3NckP+s5j4JTH0kJupYzBLfOR4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvtiU8si; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvtiU8si"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4837cee2e9bso25148865e9.3
        for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 08:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771344121; x=1771948921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZSEkVlDQEEWi12zs5UutmmvJgsLSopiUv13OQwX2PY=;
        b=EvtiU8sicQp4ESuA9LHkpoh6p24f5b/MYNFQvRXzTLM971nOtyOw6sjBxSAEM3TWE0
         Nv4vRT4Ful24sjq+3KVfCCD+GjR3js0inocQzTAGKKMLaNAX3ZpviyLDFKD+W3UwADSS
         xWOWDOSeh5X1WDe1g4mCNQl2Hnq17BI0QXDz/ZE9VxR813U8plCckDCSogvDR0vL1G24
         uTbKL2LNQMjV6f4d2i354NsN5xpDiwz05BqtsHAsTA9t7Gn9rQ/nHOIPDMvpsjtgyFIN
         xbRDoBVvyOn+wpRfJ1FY16J3mx5k4gF/uQ/cGbDyy+WyOcl8mPHwvRUTSQtb2wNZR4//
         Zz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771344121; x=1771948921;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZZSEkVlDQEEWi12zs5UutmmvJgsLSopiUv13OQwX2PY=;
        b=EuCEgVaC5kI2SsFEfIAaI3F5Y3OpT2IP56rhhRo7R3OSdCKDXL6x52mG+67LKW95Mm
         PCpqsrMMXwZP0H6Jjxtbdn1Px0t8eOsZE+68kWl/yIOqKw68m5W9MrYWdY4DhLL1gpM5
         agNmmCxPa3oYdH99N2reRhwPI7bjF0rFchm5lXDHi5sPJcvvyJHLT3s4TgzzBEy+agIY
         TpOIE5kXfqzgT459pxq0hIUEen22DGkAdahGa/cBKyOHtQ350lf6SHRaX1DIW/bdjERJ
         dIYzF7DQ3sb1JYAFjnEr41I7G5kEIKGvzUwg8vo6vLDX4c4fhqB5y8SX1+iO1pcz+7yH
         v9BA==
X-Forwarded-Encrypted: i=1; AJvYcCUx3GxHUrpqCD64K/WurnrfULgt7IBOXwqSCbbSDFdLQ6HUMvSHAp9180I1I8Ly77NunWvhdIc2PhdTaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2L0aovFwmTmvnNPk3nxxejz33j/TT6VhwHHIm860l2IQTAjEY
	/PAVt8ObeoUk1Z5OYGDvKpF+oDGA5NqaJ1b+qgfZo2v4uq+jqQjgI4g+YEeRtqZI0f1wXCJoS1Y
	5P14bwg==
X-Received: from wmbjp17.prod.google.com ([2002:a05:600c:5591:b0:483:26c3:383e])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4443:b0:47e:e952:86c9
 with SMTP id 5b1f17b1804b1-48379b318bamr165159675e9.0.1771344120458; Tue, 17
 Feb 2026 08:02:00 -0800 (PST)
Date: Tue, 17 Feb 2026 17:01:25 +0100
In-Reply-To: <20260217160125.1097578-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260217160125.1097578-1-gnoack@google.com>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
Message-ID: <20260217160125.1097578-4-gnoack@google.com>
Subject: [PATCH 3/3] HID: asus: avoid memory leak in asus_report_fixup()
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The asus_report_fixup() function was allocating a new buffer with kmemdup()
when growing the report descriptor but never freeing it.  Switch to
devm_kzalloc() to ensure the memory is managed and freed automatically when
the device is removed.

Also fix a harmless out-of-bounds read by copying only the original
descriptor size.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 drivers/hid/hid-asus.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 8ffcd12038e8..7a08e964b9cc 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1399,14 +1399,21 @@ static const __u8 *asus_report_fixup(struct hid_dev=
ice *hdev, __u8 *rdesc,
 		 */
 		if (*rsize =3D=3D rsize_orig &&
 			rdesc[offs] =3D=3D 0x09 && rdesc[offs + 1] =3D=3D 0x76) {
-			*rsize =3D rsize_orig + 1;
-			rdesc =3D kmemdup(rdesc, *rsize, GFP_KERNEL);
-			if (!rdesc)
-				return NULL;
+			__u8 *new_rdesc;
+
+			new_rdesc =3D devm_kzalloc(&hdev->dev, rsize_orig + 1,
+						 GFP_KERNEL);
+			if (!new_rdesc)
+				return rdesc;
=20
 			hid_info(hdev, "Fixing up %s keyb report descriptor\n",
 				drvdata->quirks & QUIRK_T100CHI ?
 				"T100CHI" : "T90CHI");
+
+			memcpy(new_rdesc, rdesc, rsize_orig);
+			*rsize =3D rsize_orig + 1;
+			rdesc =3D new_rdesc;
+
 			memmove(rdesc + offs + 4, rdesc + offs + 2, 12);
 			rdesc[offs] =3D 0x19;
 			rdesc[offs + 1] =3D 0x00;
--=20
2.53.0.335.g19a08e0c02-goog

