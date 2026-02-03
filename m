Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215E4364EAF
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140744; cv=none; b=Z9V68rwocVQbf+tRTffOQTC4lZvP3+WR2Gz2uQDB+85M3QJBkpFyuLQo/VDgs/psHpqKtmaLHXNLxWxbmWIDstD9ddj6Rp8mHU4jh+y9R5pwMYYx7ToB8MVILS07/8j7MmTfn2Y6CKgrfZDswxENPCp4dJ1sgPHqw1s96t6h8cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140744; c=relaxed/simple;
	bh=WC7vTdE0V5inRfysRtaKguIuqy5jxY6pjLSsGNC5nes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0DbFUtz8sTHAHFIPaX8SLTGMNyzncYIuhcX+LfgW6pypuVinxbUZlwRe1Gu2W6PzpcrfYIOh813yEzC7Z2f/uajxE7b+INbqjdKoWMi+XSh+YczvY9GKZiYTAu84FgiqyzaCtS8q5I9hUkRzDduAN65Z7/EjW6tG3HeY8UeXnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebmlWGmS; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebmlWGmS"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8e0e812c27so58085566b.3
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2026 09:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770140740; x=1770745540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDmSOMi9rPLmJevA5a3Ub4TrO81JP/3m0ZQjcokpIEw=;
        b=ebmlWGmSQ9GdfUvsxsfwiR5ju+EUWwaX/a9VqcbwNs0V5gkAjvx9v28nEWV6itOCAv
         hLIcThXUXiqc1+K8Gxu9izfVhP7hRxbS9FENcY9Q3WJrvN1UlI3/fVCvPIMWdj/d9wqo
         6XcbiPujFHNuSqo5TOltZa6WE4LscUn5hK+0xelZMP3SkE/KUHnz+sg4zDuqkKBEC7Di
         //6zViPp4DtT+W7LjvZ3nW96aeF8fCT+W2AONw9G4dv6JjxjHnWBpdr+9oqkLAKBN75J
         Yov+f3NPz5/uiP7n4SXSL9C64+SrfuGtGdoPfenxYDfQahJgJeWHsZ3qruUIM6jU2Qgm
         Gmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770140740; x=1770745540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bDmSOMi9rPLmJevA5a3Ub4TrO81JP/3m0ZQjcokpIEw=;
        b=hYiOP+iCAj9d4mQmUVGdoNRqLSf6Us0PBAtBA6xIk/PuIj193fSzN38atgPNamPzrZ
         DXE5snZSo71lO898mzB5t5GKVliypPaOCnXnkaHnb+2cnaB3s6evX1CjeawW4GyANNnW
         V22Cd/lSX9khslmhiid9tPJgJgHHdXreaAJkcMyrsYbAydmIzM4ps9xq/EzAbq7ZSNhs
         lQryhm/hG3LLSLbBZgIq9clQgMtjW7hZvb0ZQcGYlKH37G0+0V7/j9v6+TR8rwK5Wn28
         DgVgOV4nEE6XHXMKt6IRb5xbpfV5Y+KKXUQFJ+PjYPz5gz2R0IcQCeClDnhpaVgflZ61
         fo3A==
X-Forwarded-Encrypted: i=1; AJvYcCVNZBK2riZViiYYGesi64xPyFrIt+wypTS4cP4ofwg6aVtDxrk26z9eSQcLZUU8VuQL2jWenh/YfXCytQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZV483g2az5HP6/WLwHO2r5Bf7mEk8jO/gUEA3xx48dwwY2wt/
	B3hejRH7z/ZDCdouB9N5z2aesKW8a2wSYtJ161SqZ2IfBJo06c9/mM2s
X-Gm-Gg: AZuq6aJivUsC454XBYI4PK2sWgLRdv/vx3GogN17pw7kGkbmojuXt5qhRUFO9Z822ln
	7RgBIXmm2BSK1nT8EXlSN5e4xCu8hv/vHxi35J6m6y7XQVSa0DiuxFW4iqLbnvxYNquui+mMZwV
	YQUBZsu0D3nVEHweTW3CVln+6P3343JQk8BKnrCGxG838PAQGKc6cDUlXeLp4RVREk8Ea4ccYGW
	piYDn+WAQUbkQD/bwyDvj8L7BdpS8/na4D6TfQmoe4rxx4KamXNRFy4zZcUmVRH0UPcIWghq4LY
	KbxfkBbAGIVX7hmF9C34y/YVK5CKP/XYxUbt4QpbjP8SzRjamvN62K0cxdkGyNorIreBWPoPwbV
	JWyaOBtjQKWW6l85seJ6c0Hb35ed/IfTtUy7juThAVdhAhxR0S/jM0KoDIxq1oYe4UCnbCSQ94e
	IX8UTUgvEXXioowysbelQj1vcRXyCnWGKujRF271tsyv68VRMIzgPi6rWeFj78JVoFju9vAm247
	2M=
X-Received: by 2002:a17:906:99c5:b0:b8e:92e:d2ef with SMTP id a640c23a62f3a-b8e9f3f70famr11017466b.5.1770140740017;
        Tue, 03 Feb 2026 09:45:40 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fef001csm5078866b.44.2026.02.03.09.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:45:39 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: oleg@makarenk.ooo,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tomasz.pakula.oficjalny@gmail.com
Subject: [PATCH 4/5] HID: pidff: Add MISSING_DEADBAND quirk
Date: Tue,  3 Feb 2026 18:45:30 +0100
Message-ID: <20260203174531.2866644-5-tomasz.pakula.oficjalny@gmail.com>
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

Some devices (mainly Asetek) do not have deadband field in set
conditional usage. Do not fail set conditional usage search if it's
missing. Allows conditional effect playback on Asetek wheelbases.

Deadband is practically never used in simracing anyway.

Align property name in the whole driver to use 'deadband' without space.

Co-developed-by: Oleg Makarenko <oleg@makarenk.ooo>
Signed-off-by: Oleg Makarenko <oleg@makarenk.ooo>
Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/hid/usbhid/hid-pidff.c | 12 +++++++++---
 drivers/hid/usbhid/hid-pidff.h |  3 +++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 17bdc36d1908..8106b045a8f7 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -82,7 +82,7 @@ static const u8 pidff_set_envelope[] = { 0x22, 0x5b, 0x5c, 0x5d, 0x5e };
 #define PID_NEG_COEFFICIENT	4
 #define PID_POS_SATURATION	5
 #define PID_NEG_SATURATION	6
-#define PID_DEAD_BAND		7
+#define PID_DEADBAND		7
 static const u8 pidff_set_condition[] = {
 	0x22, 0x23, 0x60, 0x61, 0x62, 0x63, 0x64, 0x65
 };
@@ -632,8 +632,11 @@ static void pidff_set_condition_report(struct pidff_device *pidff,
 			pidff_set_signed(&pidff->set_condition[PID_NEG_SATURATION],
 					effect->u.condition[i].left_saturation);
 
-		pidff_set(&pidff->set_condition[PID_DEAD_BAND],
-			  effect->u.condition[i].deadband);
+		/* Omit Deadband field if missing */
+		if (!(pidff->quirks & HID_PIDFF_QUIRK_MISSING_DEADBAND))
+			pidff_set(&pidff->set_condition[PID_DEADBAND],
+				effect->u.condition[i].deadband);
+
 		hid_hw_request(pidff->hid, pidff->reports[PID_SET_CONDITION],
 			       HID_REQ_SET_REPORT);
 	}
@@ -1103,6 +1106,9 @@ static int pidff_find_fields(struct pidff_usage *usage, const u8 *table,
 		else if (table[i] == pidff_set_condition[PID_NEG_SATURATION])
 			PIDFF_MISSING_FIELD(NEG_SATURATION, quirks);
 
+		else if (table[i] == pidff_set_condition[PID_DEADBAND])
+			PIDFF_MISSING_FIELD(DEADBAND, quirks);
+
 		else if (strict) {
 			pr_debug("failed to locate %d\n", i);
 			return -1;
diff --git a/drivers/hid/usbhid/hid-pidff.h b/drivers/hid/usbhid/hid-pidff.h
index 8d879067718f..c413aa732842 100644
--- a/drivers/hid/usbhid/hid-pidff.h
+++ b/drivers/hid/usbhid/hid-pidff.h
@@ -27,6 +27,9 @@
 /* Allow devices with missing negative saturation in the set condition usage */
 #define HID_PIDFF_QUIRK_MISSING_NEG_SATURATION	BIT(6)
 
+/* Allow devices with missing deadband in the set condition usage */
+#define HID_PIDFF_QUIRK_MISSING_DEADBAND	BIT(7)
+
 #ifdef CONFIG_HID_PID
 int hid_pidff_init(struct hid_device *hid);
 int hid_pidff_init_with_quirks(struct hid_device *hid, u32 initial_quirks);
-- 
2.52.0

