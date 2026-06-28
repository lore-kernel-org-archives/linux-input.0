Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4012D9EE4
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664576; cv=none; b=Qu36qwdwnxkmh5ARv6LIKTSmUKLhSs2PO+GeVniu2gHevvdpB8SH8eK2A7W+ou1K1KOGRL+l7b/KsXNdFKouB4dm1073Ymgk6LKOfPLlV/WxVcu35elcU7TmIPVI8XCs9SW/DAped5peP1hhHiQG/PUtIBetMIqsN+PMwcM2ODI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664576; c=relaxed/simple;
	bh=Dzm/2Mq150RuPlaAtMlFI0lpKRikrDTWDtmhd2EHuZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgE05M5w/TiT7NAh9kjG5HMHej2hJ+rI2NyX9CHnfALFctbZuQ6j63aa5l6mHux/ZdA/6JO9sLRBZREJ41MJsZVuVBzGUJ34FjmG6pS5tYBgwfcNV8xUxmmZi6cVSp6jCuBtvXRnroeEXw6KKPfMd7eNKp/97L3rmVOTqBFnfW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sCnou9TD; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCnou9TD"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80bab6cf5ebso22610417b3.1
        for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 09:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782664574; x=1783269374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cK20Prk6Ya4IGoxcL3yINT5DZ9onNoyQ930594kHMCg=;
        b=sCnou9TDaw/osbNb4Nbmo5WlwIaGjdsLb86o6KpdxM9mgwHicXcrBejxZCjZXz9SAt
         YMJB9/9TNXPIYr2w7ovNycI/ezd1/AiwI2KJDhOwzi8BdXC0lExg3aa7AcMmzI/HvNQl
         TRep2IXzpPOzp+UokpDSrA1ldFXZHF7ciAGz7smGwB6cYNj7yaM0EJt2Jr6esCVAoP+g
         dVkVGTAgYOgZMlVAD/duDC2Qt8e5qyjZM/5YMdQ8DUFj53l3ev7Ax323B9EugGYpUBIO
         uFWb4Q7SklpUz+pcDsKmhk2tkBpq1o0OQc6MvlIHhppvnToMOW94AuZWq2MC+QX397o1
         /e3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782664574; x=1783269374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cK20Prk6Ya4IGoxcL3yINT5DZ9onNoyQ930594kHMCg=;
        b=R0XcdCFr8y4twBScD8tPibhnGc6Wu0bxLZjpS3je1FxR92o7dTRcz0cG7+LbsxsGM0
         i38m5rJch+KaHCvQwkT99Jb7g/mP/C24/yB/Vxn0riT3QiQOHuQKOb8dpOLxemXwiMUw
         Iw1MsG8dnY5Wrz/WAXTm/BRwtkEQbw2BXSYJRea7SVD2lqKvd4JT6VG+XB+shVuLbYCn
         KvEHhNoDrjPYZb2CPj6hkBFD4MUy1bV8ZPj/+G0Xmg4VvJ+uNTlGKuuwVBY4VdoZBeuV
         oCVi/UMnZWR4TYX9Gzes3Gv0YEGhebEInk80NsGPXG+TAt8fsolxmurrLUEJkcvPv9mm
         qg8Q==
X-Forwarded-Encrypted: i=1; AHgh+RqGQ1FhKn3mGelHKbk4xkj2u+x73AZ3nYCrTH1FKOCsKrc0aI1K8Y2jV+vl8DFZMjSIHikSKkivIhSDug==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbiiDw5HXmwVDs8XNnjXF7SVH/OglwXRdpdpM7pde2mSSAp3lG
	fPUkY1MjG8sU29PdSMJjNV2Hsqwh5Z2psmWF1p7nvgGemBLKl3NITNCw
X-Gm-Gg: AfdE7clYPBpAuaHIsBDj+ZtDSwCHsKH5mQ1diNsD1ZVArX5oysijTj5UHdxl0gOYJvF
	sZO4zs4T39LXOFQK4Y58ZKX1FK1g1P8GA0NfoLU7AB5fT9Ahn4yT6u4oSc3N6uSqBLk/HE7u1Fp
	HjlHVIqrjJUPuDEeJx1VvS5Kl+6iSzJpIsdlnu59jW4CVqlWTeAAgqu/1Gh29G6kUuyfy0GO0hu
	PR07rtjvE8RUEP4RR4brOnWu5bSncEKDrzlQenrqZgAxsR6EeN7SSIEcAdJjhXUrO1tKJVBgZpA
	C/JW5e0DSiZE+yXPZathvblKoLFpUp7BR1woBqz0uZ+oulMoFzke4QqGZEkO3BV6cfmgIfIVvAt
	QCpetFzlC9yhrfV4spq0jcBhz8YVOT2Md6j0ceWclaIoiFyJGADHujUAlO0YBXLzJ1TYf57KUXi
	HUmiQKt1VkvSbQrgVapxlBzjfMSA==
X-Received: by 2002:a05:690c:6b01:b0:80b:b76d:650 with SMTP id 00721157ae682-80bb76d0704mr85139297b3.31.1782664574020;
        Sun, 28 Jun 2026 09:36:14 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-80ea903f74fsm6294817b3.21.2026.06.28.09.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:36:13 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Stefan Achatz <erazor_de@users.sourceforge.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 4/4] HID: roccat-savu: reject short special reports
Date: Sun, 28 Jun 2026 18:35:27 +0200
Message-ID: <20260628163527.14279-4-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628163527.14279-1-alhouseenyousef@gmail.com>
References: <20260628163527.14279-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

savu_report_to_chrdev() casts special reports to a five-byte structure and
reads all of its payload fields without checking the received size. A
malformed USB device can therefore trigger out-of-bounds reads from the
input buffer when the character device is claimed.

Pass the report size into the helper and require the complete structure.

Fixes: 6a2a6390cf09 ("HID: roccat: add support for Roccat Savu")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-roccat-savu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-roccat-savu.c b/drivers/hid/hid-roccat-savu.c
index 679136933560..04fa4c50cfa4 100644
--- a/drivers/hid/hid-roccat-savu.c
+++ b/drivers/hid/hid-roccat-savu.c
@@ -152,12 +152,13 @@ static void savu_remove(struct hid_device *hdev)
 }
 
 static void savu_report_to_chrdev(struct roccat_common2_device const *savu,
-		u8 const *data)
+		u8 const *data, int size)
 {
 	struct savu_roccat_report roccat_report;
 	struct savu_mouse_report_special const *special_report;
 
-	if (data[0] != SAVU_MOUSE_REPORT_NUMBER_SPECIAL)
+	if (data[0] != SAVU_MOUSE_REPORT_NUMBER_SPECIAL ||
+	    size < sizeof(*special_report))
 		return;
 
 	special_report = (struct savu_mouse_report_special const *)data;
@@ -183,7 +184,7 @@ static int savu_raw_event(struct hid_device *hdev,
 		return 0;
 
 	if (savu->roccat_claimed)
-		savu_report_to_chrdev(savu, data);
+		savu_report_to_chrdev(savu, data, size);
 
 	return 0;
 }
-- 
2.54.0

