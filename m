Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218125;
	b=rm53VNgWAgQkz7bbE6FrBnj4qglAw5ykmUtVz2493l9Q6Fj3DWelg/pD2P++1z/h1OnW
	 Ra0xlvlwRrWv/Cx32IIGQSf+4ToMsOtlfP8nKrYAVtSPozpmK4WwZHx8/97Wjj9hf2GVc
	 JHST5oOTYxJEG6QyVdyJJ4f4Dq5mUhQPQGHFaCU8JCIdZrhPOqdv5zA/dpvUe2KY6CenL
	 5N/vo3nd/AesfmEI4W/HmsQEJB8qw1y8GisW4tDfQQLS7yfenMokbP2Gv91pOIG9Ti+Jm
	 ussCsKLLU5J3CiV8LpPlH41uqZU58HDyo4HeDDmsyvDEA9Iqfx+o5fewOwH/ReYfR8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=d+5HBhkNFeyDx3qyEQJ5AhFw9+RggXPzV0LcOtob1yU=;
	b=C9Cjl2xywaHoxJF0YNebbA+yw0vPkxVvTzN7x2pMsfZ5qTfNI1ZiuQnX+xuxA1U23ClV
	 PVkVIt2jFGVkD7uZWymh095oiQQsQZ3nYtZ2frMF93QAYWm/krYetA+pYNDN75g/uxVZu
	 o03rTrH0H5bB65Pok2DC59Poy8ANB5d9Ise751e4qhDmwJ3xHoRV74S904WxQSpU5zlpC
	 +EUr7mwFvJHLx/niRnRmqklINIufUZhQAorVl1T/lh2PAFL0/UO149lKOrWvTm35H8k/0
	 5r0yTrSLkOr6sR1ER6xESkjYD2YdysX7cSzqt0I4EVWtKCjlkwHJWSGdSMLTkyrKpkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uar8ghj4;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD0606A31A
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 20:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EAD0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uar8ghj4
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4be28b82so1243913f8f.2
        for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 13:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793218123; x=1793822923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d+5HBhkNFeyDx3qyEQJ5AhFw9+RggXPzV0LcOtob1yU=;
        b=Uar8ghj4+6eXnxT1nKfQnOY536xiE/FG7IlKPVu65A0nq+rzliG5J6+NlZQTAB/BvG
         Vaqd1GbhFT1CMQ6rptk016vz83AF2tpHnNsZBVWmUsadlVjPJrR1pGCF9QKRTX0C3rch
         YIdT7YsnbrOuwjJg+Os4TQ/ilpUCVMa+ocFLpBd+WWMf6OClrcCyJ8ttkG6SU9DaE/wa
         sc1orZyl7rdoV2fV04amh7HK44RXEPFHvEyXeZ3UjnQoDN9eX1Cl7GFHKuc43jn2FuTM
         p9WutA+9obT09wdPj0hMDnLRxOEtNV1ppsn7/b12lQxrT60CBrNjXBldiefo2J/rs3DR
         72HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793218123; x=1793822923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d+5HBhkNFeyDx3qyEQJ5AhFw9+RggXPzV0LcOtob1yU=;
        b=LfkxdGC9IR4acmctXnLGACRS8ZMhxEaCxF7bQL8oPA98FgMkI+vlXx0qYEmCz5DwBW
         jELyawSnVv7QJtcyEVcaG7krXEp7sZa2pMAxziPTUZNtL22i2CUTp2B4Og/sUP/RDeRe
         rG/D0wRjvurP1CZW2qk/ojACJboO3g12UERoyjy4CBnLl72DUVtugsNCcO1NCXGyufmk
         ttsodEmUggpuR8mYCZtBKqON8qNdTiG7FR44ltuNpxJ8BSlz6K8s3zoqpmNT8iKkr9zW
         7hahSdqTcV384o5Y1nBAkEZcrxfpC9QJNPw6A6dmfLxXDIC1d2UcmxgG/o8hp1pGXXbk
         HO0w==
X-Forwarded-Encrypted: i=1; AKwUvBz8anq/BGuD+C3dYjc1i6LnwoWNCxUDcni/8pK0BjLgh7Gfb9+mWoKs6O6d/BAY5a1xs3WPP5/1sFEbVw==@vger.kernel.org
X-Gm-Message-State: AFq9FYK2Vj88Sg1pQ0VClW1CwyI9eUr/S/oVPebF5aMeD6ZPnyeIHLus
	Yrdxw4rlCpJlDEPeN1KghUFnXNUwillASl2Bm4eSvJ3EbTVfPF77d9pA
X-Gm-Gg: AYBFou3KxQ0PQW/LN62djb/Tp1JRT1w+OLKDuzamiALHEeM+3DClsXBr0defCn/SYrI
	piMkYdqcP3YYdmp/urn/VCChZgMpglWMKvGP4PuCjazNoDnOA+DcDHU7fek9n4YWuC183Mp8/vc
	NJNGHLt/IN2uXJ49mPXytG79IxcQpmtpvnyOg1wys943os5gyyBTvPcMHOgVloXmOgc5WCpj/+f
	3uY5+TiZTCDGwl9bT6pgbPi2Np8+Ygc6B0yFPluKgf423CK4Fq5tFIx0LTMfUNQOo3D648chq0m
	ObJaSbNdw/yBB5XBTAyB4EUr1gjel5PY2QAdmAxNho6eZLD2ddSBxrTret1Qr9pEJHfr0JHyevI
	ltwCPjEUbGjpm8hYS/ho0TTH8UHjuiQPXu6sIXqR35yd9ynNzdgzVlrKyb3EEKvxhfawX3Ib6em
	+P7srMi3PqoT2GvkBKDM8gw9WAuN1BgPBgQ0jhgILv+wlI2PN93fpGWCJlCNFQ8G0Ne9YJVshaO
	8ZgzqXoiNpulrk5U2jvTxniMHduqpIC0R03rsgrFCuQIaz9EiiH03J6uYcS6dqClW5vOUlCp5jS
	q7ox246JUOButcU3+w==
X-Received: by 2002:a05:6000:26d1:b0:487:27f9:834 with SMTP id ffacd0b85a97d-48e5d2f9845mr8356353f8f.41.1793218123270;
        Wed, 28 Oct 2026 13:08:43 -0700 (PDT)
Received: from fedora ([2a02:587:85d1:a500:5135:1deb:a9ab:fb3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f387sm30134320f8f.4.2026.10.28.13.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 13:08:42 -0700 (PDT)
From: George Karagounis <taterraster@gmail.com>
X-Google-Original-From: George Karagounis <mail@taterr.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mail@taterr.org
Subject: [PATCH v2 0/3] HID: Replace deprecated create_singlethread_workqueue
Date: Wed, 28 Oct 2026 22:08:36 +0200
Message-ID: <20261028200839.202670-1-mail@taterr.org>
X-Mailer: git-send-email 2.56.0
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

Hi maintainers,

This patch series replaces the deprecated create_singlethread_workqueue()
with the more efficient alloc_ordered_workqueue() in three HID drivers.

Changes in v2:
- Addressed Sashiko bot review regarding WQ_MEM_RECLAIM misuse. Changed
  flags to 0 since these queues do not participate in memory reclaim.
- Fixed a critical format string vulnerability in hid-haptic.c by passing
  the format string directly to alloc_ordered_workqueue() and removing
  the unnecessary kmalloc/sprintf.
- Verified runtime behavior by compiling a minimal kernel and booting in
  QEMU. Confirmed successful initialization and safe HID descriptor parsing
  via a uhid fuzzer. But needs testing on real hardware.

Best regards,
George

George Karagounis (3):
  HID: haptic: Replace create_singlethread_workqueue with
    alloc_ordered_workqueue
  HID: elo: Replace create_singlethread_workqueue with
    alloc_ordered_workqueue
  HID: logitech-hidpp: Replace create_singlethread_workqueue with
    alloc_ordered_workqueue

 drivers/hid/hid-elo.c            | 2 +-
 drivers/hid/hid-haptic.c         | 8 +-------
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)

-- 
2.56.0

