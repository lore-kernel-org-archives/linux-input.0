Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773506;
	b=ibc0f1hUiulvJyVOLGRLn3m2A+J2UDHqGsSNIsc4KwnHKnhC4MkI0Yldjc71DmvXlnl4
	 POAh42LTZH/X3oxQ15WMEl4JfOHbXSqxG6zs7NWJxlfjsPpYC38+7C5aVv9Ne3dXMOir7
	 03MI4Lpl55GUvvYxLjx9UdD2g4wWUPon2soL6Ozd3fznLmgYQA06RfrQrKVbQq63l9VBD
	 uuGbDdSSlKyNSC/uydMlNQtqK8j7BH6NUOTQMBQFrXrTPCUL/HcYvnosiVoXM8QmhW9AT
	 uXVAEAFqDEtIYFngQKQNzDzyWoZn63kTWgo0oNNRVWzsgXHjEdgd66jGGLjHHkDW9aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6aqflyyGibB6JpqtJHNzZdrDhDz9SBMlPar0zuxq8rw=;
	b=m4fKZDRhpCQppAJu5OMoCH0jHsQ09kBdC6yvC33lzfJUUFmizVBABz4xX57iSFiObmEx
	 ntymzU2NlkaYw6IDjlZNs6n7QbU0E6fQDqdI2HMVVsTWThD9ACaOAKL5AN45Rj7iKSOmI
	 EvVbGIbib7qTBahb6X/Gt2iWHkBLWaxlYyEywdzVCk8FXHbywXJoLb3l5MK+RTTc03Y6J
	 2XIS1tEg/jr2wMn5bUbfzhtJQmaEesTwQd6GyL8z6+t4E0vKYMfT1LNsiPMNXLRIs2i0e
	 rNlKb9OnO31Kp8qkgg4u88kgz584yruHDEz/8PXPuEtvGRYTeYQv9tnZngvtftTqkIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S+2n7Ak7;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83A7606A326
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 06:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A83A7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S+2n7Ak7
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so496034eec.0
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 22:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773505; x=1794378305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6aqflyyGibB6JpqtJHNzZdrDhDz9SBMlPar0zuxq8rw=;
        b=S+2n7Ak7tV2EJGZD2ZPpD4lN8xiJfS5kAxeubkDJcpbqw0AFxfAIHpdR5fzsjv0cs+
         i7CUhFQj9ik/a1NcJEP7H7+kR850mD41LPurwO/jH89nmuJG7G70LvXom89npCcGEVSh
         OmqyEQlukw+KPed/wEqrj81aVM4OJ395XPiAEPbGdHJ+lkBD0hRXCJRYqH768oXOG0GC
         RTAuwLizS6+M6y7QISup/pRQqhcoY94bFwFqK/Bi88ygcaaBhs6W7YTmGK+O7TXVkX5s
         59g8jINCi9yykjdI/DwtgU3LbHPEyEuwGY9w4ZDOVb3VyLTr04NmyIGZ/ykzQBSKBV+r
         MYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773505; x=1794378305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6aqflyyGibB6JpqtJHNzZdrDhDz9SBMlPar0zuxq8rw=;
        b=gNfHmjI4j+gNUZBb0ZCPiTJ4dwUyxxpcnSfYlBNaAiy6OtBaBa/GhUJ/k8lPs6sqRH
         22nVBe1v0lSMkRpVf9SdVQ/eVtmIJYVvbOW67d/2VNBNhAOcARFcKQUVR67xm+9ctuvS
         faMeraI6lhLO0XylA1D7QuDHCEysygs1yEiGhKn3lznKyP4SeJhdolIuIcD4BtonOstn
         DYasCFx8Iw8CN3+PGUyVUJcxB4izbsT2gI4vweZ9S2V/emK93UtGZUAGRfo8yjnfuw19
         OGI7cWEykL9BJi6pY9aW8eMGaremL5QxgcfPUmUhzHSIin1PbCHtzn6kA+rKxWKUTFnv
         y/IQ==
X-Gm-Message-State: APuU4Z8u3+eRY+jmyHiQ6TKpcAgZhx185YEfV5Ne36/e2lp99r2baSsg
	PtN3vhQJICh0zYWBUxIhuFUKIL5u9d++RMvjb0VI9QlTWVpzUly3TyO7
X-Gm-Gg: AYBFou39iCLTAx/6xNK7vZH0XMqofsIvKCiIQKDCKqtjIGa4v536BM/andjNpHO9h/V
	msMXcr9vDRNaShIe10Ip5abfCpo8rfQ43z+Y2G8Iie4Zj842uJGHSXhz00cFdOneNPE7edhxmvN
	gDG/lFp53n8N9QEVOiyDl9SPY8cdONsuSQG+e0yrY6UQsmh94xqMEC6ikx0OXfgeC6DOT9N8tv3
	cthLdfF7HD0zhEbo+/cJ+NLlF2e5UpUeVny67+aqHdChPlmQlstn1y2v4YrbcODUzCD2Qpl8oW0
	LvxngeE6nIWhFgviIhPs7G9GbFhD9JYI6XzM0Z7AJNK0k0W41qOuohEmRQ1YTusiEp/LFeuwBjy
	Sz7geYoDnlm+hsfEsirIbSrc7ZNMXpd6m5GrAtNv3ES20y0fa/D9BY5to1x2lVMn3MXZVD0t2SJ
	gWQQlz+2QeaR+jAVcvKNewZb+WRi8lGcE1pp12EOe2V+fW+Nzj5gRxZoKytu8OFsn8SWRumYo/v
	3lFZYNXksY88Utk2HADDtxzXQ2wr167IL8eLUv1+hjPXHlhzvHEpjistE8zneS2XEwxYHnwEYJ2
	5NppJeIK7QA8r+LeBOIfUWUdJX1ciYkdvsD5B0drECRqRU7ouz23+B8eABXzGkZqZ3CuOh9IaIq
	Qvd0w
X-Received: by 2002:a05:7022:5e09:b0:1a4:3169:cb with SMTP id a92af1059eb24-1ac5cfe5610mr20134833c88.17.1793773504605;
        Tue, 03 Nov 2026 22:25:04 -0800 (PST)
Received: from homik.search.charter.net ([2603:8002:ad40:56f0:37bc:b892:b6fa:fd6e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b8eb3sm5615163eec.27.2026.11.03.22.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:25:03 -0800 (PST)
From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org,
	justinstitt@google.com,
	morbo@google.com,
	Mariia Nikitash <nikitash.mariiaw@gmail.com>
Subject: [PATCH] Input: mouse: vsxxxaa: Replace strlcat() with strscpy()
Date: Tue,  3 Nov 2026 22:23:18 -0800
Message-ID: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>
X-Mailer: git-send-email 2.43.0
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

In preparation for removing the deprecated strlcat() API[1], use
strscpy() to initialize the mouse device name.

The destination is zero-initialized, and the constant string fits
within the buffer. Since the return value is unused, this preserves
the existing behavior.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
---
 drivers/input/mouse/vsxxxaa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/vsxxxaa.c b/drivers/input/mouse/vsxxxaa.c
index 042a17fe81db..b3a0d7ff5738 100644
--- a/drivers/input/mouse/vsxxxaa.c
+++ b/drivers/input/mouse/vsxxxaa.c
@@ -463,8 +463,8 @@ static int vsxxxaa_connect(struct serio *serio, struct serio_driver *drv)
 
 	mouse->dev = input_dev;
 	mouse->serio = serio;
-	strlcat(mouse->name, "DEC VSXXX-AA/-GA mouse or VSXXX-AB digitizer",
-		 sizeof(mouse->name));
+	strscpy(mouse->name, "DEC VSXXX-AA/-GA mouse or VSXXX-AB digitizer",
+		sizeof(mouse->name));
 	snprintf(mouse->phys, sizeof(mouse->phys), "%s/input0", serio->phys);
 
 	input_dev->name = mouse->name;
-- 
2.43.0

