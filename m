Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E01E3BB681
	for <linux-input@vger.kernel.org>; Thu,  4 Jun 2026 04:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780549038; cv=none; b=SVOnEkcZQEj8NKwRbMWZPV6EIDGRSQfqRfGYMLAUDtssvSJOeo4Z06PFnai9WDJzrZJWK/QNEOFoZfhUT4kcf5Bzv3IBxVKNYDwoTvT37B3pJ4L6zMrIwDM3XzfYlzdZKiVWsZybIYJsPEF3zT1dojGG0ArKXuiD+TKhFJ8tUeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780549038; c=relaxed/simple;
	bh=j1TsrSGVxYBm1jQ3emIIustL8ZIWqvlzqty45m3obe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCtduemZrXC07uMnUgszqT16b8uI/SfS7IbxEvtDQvrwu+Is7IZsuYlpXICYZZNpkkvn78B+Qv4ENEUBH8xEHzXL4gTR6FyzU9d50DW/YjUgFxpWA68Ar5YUkJoywLDUOxBBv8cUK9t9qFeUMJsu6S00OgwhH7E2pHX11+DSFxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF6OIog6; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF6OIog6"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36b9033d230so142493a91.1
        for <linux-input@vger.kernel.org>; Wed, 03 Jun 2026 21:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780549037; x=1781153837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clFoRCTex3UVtZAdZQ3zUqGdq5Ta8P+C8hNL3cjgQIw=;
        b=cF6OIog64iAMRWtwEIZxs3BPUaTnsC6zd2wk6Of4TexvhUvsp7PZihuMvlQTDJ7vtA
         Bhb6A0izCP9UXZSIcFQsNpB2aelpGwR1AkN7esD9A02dIjHDXTc+ilq8/DqDGvfRHawF
         mEiy/j5Z/to/9I1X396S3jwNJM0mwfY1VyZLtoYTnD/1qUuGEXVdenYJ4DufLX2MqqcH
         CWvvhsXJvqAgTRPNvYWvTgiXfusQxLp1r5u8XAcYsZqVUYrQbHm9Q374SGWWGfyJlgLG
         eUzh3qo4QGceo0pV8044yAaUuwo2ALj4y0joz46ttcr28jWHHO3R3KtjQOPTYZf29vRH
         N8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780549037; x=1781153837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=clFoRCTex3UVtZAdZQ3zUqGdq5Ta8P+C8hNL3cjgQIw=;
        b=EAZoRGH0rXgL9DCVWmnhvP13LQqYLHikuY8zH2fnoiuE6bA10y8l3QmBRWbfD3dx5d
         phOKFXCQPRRuakodDdJz8gbXjyk585FgFxOss5zX/nnTwS7dqOooM6Xp/AYKJ203A/wl
         B52n769k+0mjbzu57XdnDkqQ4BTeqcK5mEDOegasF1HmfP3SAwAuFSW3Kn+nwPFlAubn
         dlpd5oGtglLr+UHb2MuCU5QyNVAuRk2hbOKXTiRhVSUbP0kwMFE0i8DPe90Yi1NcF/UA
         F3/pQhZG0izTHMUClw6P2kFWXewPcd8gHnLYA/PNcf/ozQE4P6sTFmrtljJDSSRp3GIY
         J2qA==
X-Forwarded-Encrypted: i=1; AFNElJ/bKbV3S6jiURngEa5tOun33waokeOdjIoyq7bzEkA79NB4xv6zqFcYg+xt4PExtPdMig15x0eebKwXdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSaXfyxG4q75708sUT6OtTpNRYYtOGUW9SqDZ8o5aVUBaGP9At
	9hS4x5DN99r/xeaNfiXE8VYyog2YwWMJN9mzR9TxC/X+DL4rMkief7U=
X-Gm-Gg: Acq92OFZKI+pq+PeKm8UASlx+RaLlHDNZEnizGMjWIwpQpoK1xD7SCNAiTNPX3EIS0S
	ij+AA55TebGJ/VpD852TDNtU/7iw8t6Pb196Y3c1JRKNf4HZbn+VolHxqoXNv/rOzYBwjpNdaDA
	0DIq6uCtbpGZ/awW1VDiPSwLMWZaKQLqQvvoVVjk6yzmCjXRDuI4O4l+rnFXbnZgiq9p7aew7SC
	ewnMNuyg4NAFO61xqPgrXh4TK5CK+5XB8pLNY3sQYJBLDEqVH+CedRSI6H1V/4FxJch/J1b4qXJ
	au2wFmlHFBTK2IPRUeQ007YPFfISUwRUpTcpEM4bS6OnHbIWCFtcBndL8TNjTbJZsAMc3TC2p3t
	Wmvcg5iOzY4T64OJ4Td4kAriS8wZzl/4y46yLcPTXxVhNCxbj+/SxANDzDFrVt8WPs7Ojml/0yr
	9nZCmS8gUMwK0ckS9DoknN5T4BE4WhqzTe0LbWEUgqP3my6MaGsuDYrZvwodXu5WOR7UVyDQG5p
	B7OwtroRxY=
X-Received: by 2002:a17:90b:2c8c:b0:368:65d1:893 with SMTP id 98e67ed59e1d1-36f75f9c22bmr1912437a91.5.1780549036594;
        Wed, 03 Jun 2026 21:57:16 -0700 (PDT)
Received: from localhost.localdomain ([1.226.174.181])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0be0f0sm3495660a12.30.2026.06.03.21.57.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Jun 2026 21:57:15 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2] HID: wacom: stop hardware after post-start probe failures
Date: Thu,  4 Jun 2026 13:56:58 +0900
Message-ID: <20260604045710.25512-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260524175552.1973-1-mhun512@gmail.com>
References: <20260524175552.1973-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_parse_and_register() starts HID hardware before registering inputs
and initializing pad LEDs/remotes. Those later steps can fail, but their
error paths currently release Wacom resources without stopping the HID
hardware.

Route post-hid_hw_start() failures through hid_hw_stop() before
releasing driver resources.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: c1d6708bf0d3 ("HID: wacom: Do not register input devices until after hid_hw_start")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Changes in v2:
- Drop fail_quirks and use fail_hw_stop for every post-hid_hw_start()
  failure path, as suggested by Dmitry.

 drivers/hid/wacom_sys.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 0d1c6d90f..ee53186e0 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2456,16 +2456,16 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 
 	error = wacom_register_inputs(wacom);
 	if (error)
-		goto fail;
+		goto fail_hw_stop;
 
 	if (wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PAD) {
 		error = wacom_initialize_leds(wacom);
 		if (error)
-			goto fail;
+			goto fail_hw_stop;
 
 		error = wacom_initialize_remotes(wacom);
 		if (error)
-			goto fail;
+			goto fail_hw_stop;
 	}
 
 	if (!wireless) {
@@ -2479,14 +2479,14 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 		cancel_delayed_work_sync(&wacom->init_work);
 		_wacom_query_tablet_data(wacom);
 		error = -ENODEV;
-		goto fail_quirks;
+		goto fail_hw_stop;
 	}
 
 	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR) {
 		error = hid_hw_open(hdev);
 		if (error) {
 			hid_err(hdev, "hw open failed\n");
-			goto fail_quirks;
+			goto fail_hw_stop;
 		}
 	}
 
@@ -2495,7 +2495,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 	return 0;
 
-fail_quirks:
+fail_hw_stop:
 	hid_hw_stop(hdev);
 fail:
 	wacom_release_resources(wacom);
 	return error;
-- 
2.47.1
