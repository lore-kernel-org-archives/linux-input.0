Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CBE3491F5
	for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515835; cv=none; b=VOpXnRRDg1p3vbJ412jfRy7gab1SkxXG6tkmvxifwFsH5zWMdh0H9KANBy2uOWCzNJ7+urriep+RpkvahS7DM5M2+SRkbiVfP+l/aD6SmAFyi0IWx1fnHAaPFfLm58I9k/6OGM4iq0zz2/wRnAh09T5UdZs+BgAOOxMMeSsK08s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515835; c=relaxed/simple;
	bh=cUSJCknygC+/rZNVU9qIxxltk2KbFVYUK1d/VUQYy98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZeclsR85M3Y4lgkK7RQ8Knr8pGesknn3jmy0mTmXIZFNht9wrpanxSSLAds7T8dIE81lUncSrdheWm/4Sc3fypw9w/cZ0mQVKuaqkTU4YVbRjEWcCLsqy4sJX8DHMOfbLPmTlfqyyeJaCc3mcrN+ZVwo8b/R9Mxx3ws9sgNC8ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CUNp4dlk; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CUNp4dlk"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-65b93ec5a43so784675a12.2
        for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 07:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771515832; x=1772120632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TgkhJcDrOmi7WULhBZy1laqS/BExdWrs8De6OLys9NE=;
        b=CUNp4dlkkgaAH/M0utpGMCPaqj2DV8N1XFEpkIICPz7G9VHrzryIm7FM0lNMgHN02E
         aym5+vKUXTffVAaMRrLB/uCoCWFSCWOlL/Fo88ucIsYyoHK+Erw1gN1TThDQfgeBZJD9
         Y/W4Y9CUep7rjtqZICemZezJb6VUFfOBs02DI9g4H/WKY+3C9kkpk4piC6Zd+u1xSnuh
         geXoodLDxvl3hT4tfC5VXgH+JpOMz1DF8XnBILeUr7KmVHWDcmxQxG6FRJ3z0VtmVB/0
         UMo0f1vnjKwc7YKPe8XCmNOPKV2SiBy2qxCyUBOfGwKkX+5QtB1xNyuaHcf076GmaRU9
         NrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771515832; x=1772120632;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TgkhJcDrOmi7WULhBZy1laqS/BExdWrs8De6OLys9NE=;
        b=OxEdCVHWDAsQk5XUD8ivJ7lcu189i9FtjvzQshSXCZEIEceWc3gIbsj9sPEe1MeyWa
         cG0sN2s1anY/HY0pCZavEl9jXNObGjMGuabPKTIGibAptKbLd0/pmw9T7ET3L0/wlICi
         Vb5gqEG2A6Dc2A7zzaykhp04hiwLyiyI+SiE+BFRfH5c6f6liPVjuK4yhBDQCScb5H0W
         /0Pb1UfvqkbHgsBBOSXi/sPMcefMV3QiYN2brwE0cmn1yYdYRKKY9gg4Vqwom/p6yjMJ
         O2fyA2tLY0U/HK421JjbiAlUAMvN9/pbFZOp8DCP3BeghvQGHb5YNeJMGa22i+fVfwn4
         gWcQ==
X-Gm-Message-State: AOJu0Yypzi/6dlGvESw9OccgWjWPTwxubn1WQyNED62WLE8yJAqCP+DU
	EtZLazA5OQmE+yWUW/I2K0/YTA+povmfwHu5WhawhWpu46sqZBYcEGJkFXrOsnkI52gVdh0Ju6e
	TFgg3MA==
X-Received: from edok19.prod.google.com ([2002:aa7:c053:0:b0:65b:958b:ff4a])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:34ce:b0:658:b837:7953
 with SMTP id 4fb4d7f45d1cf-65bc78653cemr10329654a12.12.1771515831853; Thu, 19
 Feb 2026 07:43:51 -0800 (PST)
Date: Thu, 19 Feb 2026 16:43:38 +0100
In-Reply-To: <20260219154338.786625-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219154338.786625-1-gnoack@google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260219154338.786625-5-gnoack@google.com>
Subject: [PATCH v2 4/4] HID: asus: avoid memory leak in asus_report_fixup()
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The asus_report_fixup() function was returning a newly allocated
kmemdup()-allocated buffer, but never freeing it.  Switch to
devm_kzalloc() to ensure the memory is managed and freed automatically
when the device is removed.

The caller of report_fixup() does not take ownership of the returned
pointer, but it is permitted to return a pointer whose lifetime is at
least that of the input buffer.

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
2.53.0.371.g1d285c8824-goog

