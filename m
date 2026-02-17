Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241AF3612C5
	for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344111; cv=none; b=Ao/BYl+Z3ZPLaD1NcgLwXAb7g57S8Wrt1lSjmH/GZvvWPYZr9nrdKK/ZZK235VHhxlO9iHtINCV8qd0yl+ZRtplKeEdg8v72Jg+lXA3eaupGxGJCyEiUkG6BuZSzxAiiiYGLn1b6MwVtdRbSKrx/uVMIaDub8+DLiOuTZxNbtJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344111; c=relaxed/simple;
	bh=Ud+XGMu6AkUW3LrlHDAURXAUgcp23XINbGFrcaqaYuk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kernEj2FuyLqtDe9PEdBsrltX0fVaIrs3F3RMzco3g4wrk095D3qqGj7bYmTVLqTSikUc+7xAts30zh6Q1nj0WbMJe5AoBGeb8xerK+3LbVj6y2LtJln8hhh9gcF3fFtsB4uXSryk7mm3JeSdHSOB40TL0HvxdpjhEtMDSx7lyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BPLEQldn; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BPLEQldn"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-435db8ebc98so4186796f8f.0
        for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 08:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771344108; x=1771948908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rbpj+Bbkqn2IuTm32qCsXgbOnINoBejA1Y9YI9+bl8Y=;
        b=BPLEQldnfQSdm860fEHIY3FC3qFsqByp+yBSxp2hhD1bK9fmk3G7TdwWR7+G3HGzyD
         hPvzJDaw7P41qf2h9NFwkcq/DlxR/k7YAQzmgMSVkuUDBTWYXoq6yopSObiVQNNMOpRX
         C8ZCyCChSJiMWZOk2R2kwR93cQHQqeEeFZxWFOPZj4cmVDPwdLsovaf0nuCa6hDNFcNN
         Dm+grNc/0B3gYgiOvPjH6QW+rUvu5l4xLtM5pWgkTZbHjuSVX947Eqt1uPVAZI6tVGSU
         4uQSijL0pbFiUn7VXdZq738kQJagxcYnebhU+7FM3F9pujbvhvXEv0pwCNDtXlV/CeKu
         eiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771344108; x=1771948908;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rbpj+Bbkqn2IuTm32qCsXgbOnINoBejA1Y9YI9+bl8Y=;
        b=rSZmxe6ChPxqmXJRCosRXSywrWXdaFEoE2jEoOzE8f9Qf0QCmpD3Jo5KRoVGMRY7lD
         AWf/ECmXm4myWjOGTZ8UnUmSXlwKSiEmYniIDjp+wA89CgUDq+iTTCSEQSiJEJeDbhxi
         nVhhANZQ0sVqm+j1mXAP3PCCY5uHbxi+lkHw0H7HjK5q5cI2gBpFmwqlmtjlb3rPwSZ5
         ITCikqPjtcJplLZ+kETIzox2ZE9w7Up/INLtMyboKdOL5lKrl5VUlP71qre4lYwKFy/g
         pt0Hi3+Ln+2YozQ0UuCP1psOUQc5mb5PbhC5R2QDj4uqbGHtApsD62lcnXDRc4AsnRO3
         86vw==
X-Forwarded-Encrypted: i=1; AJvYcCVeTcLzdsifmj5xlwGHCMMWo9CVeckIdAtkdQh8LsXNYkw7FamSF76C0Mm3yf/BC8NDhMmWgNPeeTC/RQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRj7CKpJpnKG8rT/k5iWlqVHdCyahaJP4j70JofTiN+TU0lyRv
	fbx6hsivrTdthYkuvP6/f8tyzyukHss96qcBuq6aXnjKD3DlEi0Uwf84iWvMCYTT9DpDSAvRJD6
	6y5JdPw==
X-Received: from wmhi21.prod.google.com ([2002:a05:600c:14d5:b0:483:6e28:c182])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3496:b0:477:fcb:2256
 with SMTP id 5b1f17b1804b1-48373a5ba90mr245605825e9.17.1771344108136; Tue, 17
 Feb 2026 08:01:48 -0800 (PST)
Date: Tue, 17 Feb 2026 17:01:23 +0100
In-Reply-To: <20260217160125.1097578-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260217160125.1097578-1-gnoack@google.com>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
Message-ID: <20260217160125.1097578-2-gnoack@google.com>
Subject: [PATCH 1/3] HID: apple: avoid memory leak in apple_report_fixup()
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The apple_report_fixup() function was allocating a new buffer with
kmemdup() but never freeing it. Since the caller of report_fixup() already
provides a writable buffer and allows returning a pointer within that
buffer, we can just modify the descriptor in-place and return the adjusted
pointer.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 drivers/hid/hid-apple.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 233e367cce1d..894adc23367b 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -686,9 +686,7 @@ static const __u8 *apple_report_fixup(struct hid_device=
 *hdev, __u8 *rdesc,
 		hid_info(hdev,
 			 "fixing up Magic Keyboard battery report descriptor\n");
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

