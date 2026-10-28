Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186345;
	b=jESyz+bWrIuaMptGdSvrQnJIChR7RAacGLMUBVD+1VHPxTR8rAhhTFHkFOG7pJQr8OIE
	 x6pQslVOpxxPaPLXV3BfpRtAlrap38BxNAf4d0QbhB1W+/C1zC3HNLpcukk/W02oA58rl
	 pKI5Iyyi+3dMLNNMsgjieVPPUvtnEbRtQDbguPlslecXIuO8y3j/QlFP5iLLxnyxP6JND
	 LjcJrUITZpHAiMKVDKam0hbmv/h0nfYtuZX8dREFVokC4r4+qFsK40I3kmY0qwkki2uUj
	 yVDuQZwkteRZY97NF8cZ2Fcks2PmK6JxrcwPGPS+6NjzlfvDvW+SyiMnJfdPXPAZ39Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NZpAsNc3aC2Ydf5DrbJRymJ/w3CBvaG5ANPMqZgnkm4=;
	b=Qm4+KYfr9YVStSJ079e9OYKv4ZYq9Bm6OI0a3lKKQmdg/YjjdAG4+H7OoMB+/6go22DH
	 6cHONGj5b4fHjocDv+vOxgCi1Y+R4qYU1Qh41DAYjYazjOiZ0Rksh1HZkIv3aXDWZpI0E
	 jye+DSXN1/O5HJL1SOK3R7vwnpZESvMdJyy7crG/P7GzjOYbz6+vcJXRmWei8rEIbfnm2
	 whFy7zW1b5GSvHGYivZ9eXyvm2ldaWHXfblJuX3rQLVBAnH5jPo4ikV8WSJHXdOdv20vX
	 qJsA/Th0UFs/Q4dwvLJMH1Pp5cwqmvYR96znhLq4bzy+dEywSHqGQcRirMqkqmM9gIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F1bYFQAo;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516BB606A325
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 11:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 516BB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F1bYFQAo
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so7141805e9.0
        for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 04:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793186344; x=1793791144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NZpAsNc3aC2Ydf5DrbJRymJ/w3CBvaG5ANPMqZgnkm4=;
        b=F1bYFQAoUcJwRfQdmKkSXusKU7Fx/9t66rBSaVjqFBK+ZOshaDMvuOIXybN164s2tf
         gAHLOpEaaRdTii21+MSIt8LR0dx0GQ3//g0Bp7FK1BBRkxQBH+SUNAd/iAUgkwvXcoR3
         caXh8yR/6oGAXCQzGp06afsQZa9IfX3taOWF6RJkZNf4rb5R76fAegSxmZm9itHW3q2v
         ol8x4IWV3BRFGwh/pO9RpXTm2V3cFL5mDTzJLVU8cJDTjXLcUKZ43EBgRHMrHv7AfTVm
         AweRNC9Kgj5hihxMa1nHgQqz1GDc9kQU2IfheHo0pvh60SQoFECMvioFlzOT1tV8wrem
         3K2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793186344; x=1793791144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NZpAsNc3aC2Ydf5DrbJRymJ/w3CBvaG5ANPMqZgnkm4=;
        b=V35U3v4xcHiAQebWoMEo1y6q3hAcxIK+FPQjxYxKUpDRseDWa9ifTir03Dk0PuwFbG
         iQB0K9XY6XmQII1zj9or1veeFpzDZQRPZlJQKnfkaV130CoS7MudUDDmfeIG0hrLP9zr
         cbufhTJthQGPpJqtLmxyB2wVKJa44LW/cEMvrD4RfNIcePMOey/HQwiGhjf6zrByZJUN
         WlDfsT4i2qldcvXAPXOU0M3AaU2PYAdJgw8hmI0QLHG81Ss9/zCrm3/+yJkUKXxDRyg3
         GY2F4PGFkBZglMs1KP/NhqYQv21qy0KySZmys72YSowI6I0QmHgrLJDkgA2HQ+puFtXo
         rv8w==
X-Forwarded-Encrypted: i=1; AKwUvBxshcledDggeA9k5GNkCi0wXJXxudGZ0JEusY9Ig1wvYed8jM0cP+8lboFN9pkfyQo7oCTlxAokwpRgeQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJHSeObGnaVjeIRfsban59VmU0MnbC4lgDS2QOS24XvMTNpbKF1
	Q/WBXdpokh/4C2CA3pKzCA2vFy3dAN3to1OHwdNDP56FRRi3n0nwRw3m
X-Gm-Gg: AYBFou0/C8YXbW4jeoGkR+vi1s+3irw7TwVIIeP4JRhe7gbKEKVUryQBbxPJ2aAkCxr
	LFjBVZ6vnd+dM46m7B5kpGYi9xFNnBcQaNS98y1wqcIODh0ORoj1EyQD3+AO+S3WZ9BxFs+bxpr
	3nXy5D6kTpDeaysYNXbYCi5NWGyUPQrOXPanR3eUla4BpxLN9e3FzUAK/6hs94+bC93g/gji2ay
	FSmqo8f5aT876RhW/ID0WlnkTlHBVH/WFatC26LdykDvhdb6wud1+iK5BFI0A+jsj0kI4j+Wm8o
	q/O/puzwOZ1uLPqoWNURXSyxceHGr6e4+LNOs9eA/Py379vfKYmUXM+OCzBUy93h+ouP2HGpLxT
	/sGKRnzS2qApt0Y/2Vc3GaFpPatkJbbuw3M6l72QYoIL76r8Z2yaGbT62RoH9x2lc7Elyi9Z9ot
	ZLNr59TY571JbToAHACwX0mqoXaWR/NcrsId7eIiYCaRK39sRzdVq3EuTRmzsgTCZjoVvAuqAZK
	skohuG5ceWplWPD70npRgyStEbjU1E8osk/Ge4llGaeTcaE+4zVS+4wNgWpXhobEiLeUlWuAnNK
	pXb4F3fiDyoQkLlwDm1wxjb5GN/yI3kZjUg4hxc=
X-Received: by 2002:a05:600c:354a:b0:4a2:47:b79c with SMTP id 5b1f17b1804b1-4a9678c3ca2mr40478565e9.32.1793186343622;
        Wed, 28 Oct 2026 04:19:03 -0700 (PDT)
Received: from fedora ([2a02:587:85d1:a500:5135:1deb:a9ab:fb3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a978d57b39sm64197635e9.10.2026.10.28.04.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:19:03 -0700 (PDT)
From: George Karagounis <taterraster@gmail.com>
X-Google-Original-From: George Karagounis <mail@taterr.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mail@taterr.org
Subject: [PATCH 1/3] HID: haptic: Replace create_singlethread_workqueue with alloc_ordered_workqueue
Date: Wed, 28 Oct 2026 13:18:51 +0200
Message-ID: <20261028111853.22429-2-mail@taterr.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028111853.22429-1-mail@taterr.org>
References: <20261028111853.22429-1-mail@taterr.org>
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

create_singlethread_workqueue() is deprecated. Replace it with

alloc_ordered_workqueue() for the haptic workqueue. WQ_MEM_RECLAIM

is added to ensure hardware events can be processed under memory

pressure.

Signed-off-by: George Karagounis <mail@taterr.org>
---
 drivers/hid/hid-haptic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 8760eeb08b2c..2f4fcb56aba1 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -460,7 +460,7 @@ int hid_haptic_init(struct hid_device *hdev,
 	name = kmalloc(strlen(prefix) + strlen(hdev->name) + 2, GFP_KERNEL);
 	if (name) {
 		sprintf(name, "%s %s", prefix, hdev->name);
-		haptic->wq = create_singlethread_workqueue(name);
+		haptic->wq = alloc_ordered_workqueue(name, WQ_MEM_RECLAIM);
 		kfree(name);
 	}
 	if (!haptic->wq) {
-- 
2.56.0

