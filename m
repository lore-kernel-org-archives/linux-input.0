Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440F32D838E
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664572; cv=none; b=PAAmGPNqaG3uC5/eBhZdwjatXzdkp16uan66vN1bzluH0n/BIhPcQCgxOOb6iLjRuJqIVfEZnj61JRBeme4abeuSPmiF29hDR0c0I4SOXh/jHqD89Xbi/ucjIhYRdTvjzNxKNk5drWaGxk7d4SeFhujqh3ygl4SDSFzObI9nyO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664572; c=relaxed/simple;
	bh=yQ8R9XastH+8pcsnk+pfrf9crWGnkt0cSrwN5AmkL1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBECo80151JC81l2TM7CFG4AAVBjLPGEl8EIbn4S9F4yTjQcD20pwRhI4RiyKwtI0IVynh0K+FaWhaPGJY/3KKViFCo9se2aFKs7G7UA6C1XBhh8jIfGvi8D577XTVqn5i+5otz9a6WFmMMNq8e3lidYvSL7OcUScvN5T4bE8hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyK8zvFU; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyK8zvFU"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-80f5edd1858so966117b3.3
        for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 09:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782664569; x=1783269369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e219h/uwYCvJXbihsmOl9SQTRnIhmov8xkiDNn7Zm2s=;
        b=DyK8zvFU5jX4iQL5uV88gpzHuSvHoio1f+QfsRWDdMQyAVaUc6RhQ4K8pwXvdr1Ezc
         ZANEDjtLn6kkm6YhneytxNS1hy4i0jSq1BvaArQsQTc+upZVwoCeQoQl8L8nvQMxZ1E1
         3ZqrmQlxsgbceMdS9sN/ymT4M2cwv2m6IrSIkVVy0ODI+uz3swpnvJsCwCN7lUm3nBIU
         VqfZ47nPK2gWFwvLN4yAvadTwIGcczLZjYob2BXjFIZaYxzdd40IHgNPZUFqSUB/eFbs
         ufEk785sZtgQ7Gin4OzdysfM9ZPxeHg0EYvrb0SvaZmlYXod8V92DchLD4k7pgZXI4mv
         meiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782664569; x=1783269369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e219h/uwYCvJXbihsmOl9SQTRnIhmov8xkiDNn7Zm2s=;
        b=VZhj4AgApB9yc68AgXOrK/lfwBF7R2nLn09bZZjneVf4K8Llb51oOydusGIroQB/iK
         8tGOHBvjEe67dYZ+AP4FoIEXPIcj9Kw7SlIL7LSplLtZrLzfSTs48uJK9rUpyh/PwKpJ
         CGhQUDOJLpgo3dxzCmkwS6jHDxShswC+ehXWfT3fRyKHpQFOL4XiXRkJF6xxYZdRokW/
         8spxVIATx+MF+YwRH9Nd3ugHjnHf4azUp0zoViyQs6gfwL+rA3x3S8x3qP4fhhei3+rM
         gJWG9B5bhIb5GmBFDld49MTa/t2FdeWTNUTq8OMhh26yl1/Yh+sgFII0H/DyRHrzqRxc
         4Mrg==
X-Forwarded-Encrypted: i=1; AHgh+RqgkQehsFR0Ej/TmeL92FAjD5t8zPX0fZUegT1EBq3eSeMgIEEHifQMaGpn3Wdkv9Eh/80eQzhXKQ2rQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOwem0femL2mhscJ86yJMU+duOvdXUUyit/+nBv28rVwpcuGRu
	0hV5isY+55OYZNgHVXz9Dhskx6qc+uRYe9ROgCQWsFr6aaZ20nW9teEA
X-Gm-Gg: AfdE7cnuS3CnwBIH9le29XBUr3YzaJbm2DHx9h1opgc7Ab2EGTQDKK+mgd9bheyI4M3
	uTAnVjnN69V0kKRRBma9h1uyoVKzsXIJZd9c0R2tupyxYyh1zWR7iym0tX7ydM7BMp7YZPu5sY4
	lt3kV4IEMGHfJCiKPxAqi6i5vWN6G08ELnsWBhRRIDyTrAkE7c8FWavaKV+wMeUeKcX6srmaFW0
	Kmaa6nkFGXmUXK4EuHoRYWmEk79JMX3FlBxkw/ZRaYi5RDMzP4Yc03xgmYyN739HU9tJBhig76O
	iYX4Y9cWt48cOdeq4lnPUqTIKja5pGBPZcq2t0HKSnwX2LMJddxDCQPRSp9tuTl5y0967GS7qSM
	YuFeInah9rUfI/LUyisMUVgX1hPbDmPOhYljsPDfSmjObfpRH6ju5IM7IrtXfd/TfVueSF9Wzjz
	5vgqFKh6GCH4aan2AhHoMTdfk0Mg==
X-Received: by 2002:a05:690c:c4e6:b0:80d:f376:5bc5 with SMTP id 00721157ae682-80df3765e93mr37710887b3.0.1782664569174;
        Sun, 28 Jun 2026 09:36:09 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-80ea903f74fsm6294817b3.21.2026.06.28.09.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:36:08 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Stefan Achatz <erazor_de@users.sourceforge.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 2/4] HID: cougar: reject short vendor reports
Date: Sun, 28 Jun 2026 18:35:25 +0200
Message-ID: <20260628163527.14279-2-alhouseenyousef@gmail.com>
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

cougar_raw_event() reads the key code and action from bytes one and two
of every enabled vendor-interface report. A malformed USB device can
send a shorter report and make both accesses run beyond the received
buffer.

Consume short vendor reports without parsing them.

Fixes: b8e759b8f6da ("HID: cougar: Add support for the Cougar 500k Gaming Keyboard")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-cougar.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-cougar.c b/drivers/hid/hid-cougar.c
index ad027c45f162..7156658166f5 100644
--- a/drivers/hid/hid-cougar.c
+++ b/drivers/hid/hid-cougar.c
@@ -270,6 +270,9 @@ static int cougar_raw_event(struct hid_device *hdev, struct hid_report *report,
 	if (!shared->enabled || !shared->input)
 		return -EPERM;
 
+	if (size <= COUGAR_FIELD_ACTION)
+		return -EPERM;
+
 	code = data[COUGAR_FIELD_CODE];
 	action = data[COUGAR_FIELD_ACTION];
 	for (i = 0; cougar_mapping[i][0]; i++) {
-- 
2.54.0

