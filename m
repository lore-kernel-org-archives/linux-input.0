Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E30342C8B
	for <linux-input@vger.kernel.org>; Mon,  1 Jun 2026 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321294; cv=none; b=j7QU98f8IGMXH0m/5Eyo16NVbzXhf4d5yKT0GxXxvpoE4S4PUnq+XaFgt15VsU7XkIFK/rTujmIENU9HIp0e5iyjhWf7pwYrzU0Z4YlFnDfE5cY1NNhny+jefyNsBRULcKlUpc0zK0TFxD43/PY8BJ5uVNiGckdcf3xps/vJyc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321294; c=relaxed/simple;
	bh=aqgDoKG5VukJzyghkBryFWSabrvKwvQSuPUR+4Tw/n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgWGPrvW6C0vFAGEHt4YH8h6nCUNw1g9mjZD1uVXnZfvxgQU+E/alUNS7pl03Rw6hW++n/iXfHaZdCWiwE9cAfaXR+P0UrtvkUEYzsqJwjq3xU2/JnA2/S2CfleZOh006e8CUtB1AxxF7hbhsfzPZTxgZV92X9+no4FuICva8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7OskF6c; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7OskF6c"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36dac5d5d05so516706a91.2
        for <linux-input@vger.kernel.org>; Mon, 01 Jun 2026 06:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780321292; x=1780926092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfS5OoTJgnXFf4esSAMb4Qchj1zhL9EQ+SZTd3nWYUk=;
        b=R7OskF6cfOfoErYuE5K1lV+kHI4z9wolrxMCVxz1R1kNYys3XKHnjJ/B3the3HAAzX
         9bfUYUUJlnoHaM65kpxCvsHCbQpgmo1BMwfkKjK2wJz/VsnAASJhn3WNSpTDSINkBqHz
         qdi94Eg0uTHMgeka3Y5rsu9jFlX1ulM/KeeF+DCHPMHWv+YwBgCzFRK07E8SmLPecpnD
         PdP0M6JIxF7bPviLfWv8t2kgsB7jKMHGfs32bDiKrKNLHwUr/qlnzgsAxxpRyWKeQaLG
         pjptbsJgszubeBiJ2a5GDH2U7RQF92kxBLZLZnhA4RSirnySA0zsTKpicG+/v0UJ5M71
         uDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321292; x=1780926092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cfS5OoTJgnXFf4esSAMb4Qchj1zhL9EQ+SZTd3nWYUk=;
        b=RK4tgd1Z3KUBacm29JhXE4XOlYdkhWhUks0Wu0pM1datpLXNKv1ZLAMWSyTAnuHupH
         SbUpL57vIgkN+a09T1vsFDkeu6WkbvD8Cv3dhLW3UIk1kcfPCiihNetUbvm0gdWeoKZI
         4Vbrb9OFOa6HL3uq0zG6cvNKGEBqJ8u7Ra9XWEPwLrG8MT4BZ3IaXNslWj+RH6Ch+bey
         XR/7nZdp3+8ytbFrzPJoSgpMz97cXTaHQilqntW8PWOHDTTbYf/TB59GgmDQTVqS31Qd
         GZH9HzFkToYfRWW7FNW1AHAgA7ZXwIZmx045qPkp8ypVja4Y1jF11EFJLPCeT+8u94/I
         IE4Q==
X-Gm-Message-State: AOJu0Yx2OlNn1Cv/G5N688dmCXR07bSnA0XBiQtK5xgZS4RqisMbb9LX
	LckvieviDvJQNyQveVNVOWLpSBm2qXWIMVkQPYnhwAR1eGj9DRZrDOFxWCaBvLiz7OhMaw==
X-Gm-Gg: Acq92OEUEbLr18DpHGt4b/kllzJ+zKeqXcKnXBDnZafouFEGwVbzLYN8tAhHzkGX0bx
	YoEPonyask8aMFHX6ZS1vDku7Y0C1YxLKUYPOknLZGqObciTd6pwfz/MxnlsidsS6RXpovxZs+i
	HuYaNS2I/DdMTFBaGDUT0GphpQJArcRG7CWWSNicG1+NrLwTKkDKe3FoW0Kf5T8QzGMPV6uJTfP
	MS2qZyrquSPqcJckokopije8YR14t5Jyj+lWYpBwhm+WTnGQgszM6yHzt9u4yDPF86f1rZJj/4F
	XBSQbDGFaMqdUSpSBuwgqqWdiUlBVpsc7Ba580HefAiAhTmWL+mUeXBRZTIcCej+gILAw+cVoc1
	r2PP6IAiszxiKIyvKigqLU6vmRHFblynpBPC7Is3GLUOJx9AoUAhivC1bjcU9z4MxQfSzICWB3O
	JKbJHDcTpNLmmts1F5r6sT36hdwGU9xa+lIZkvE4vvLCFwHDrouC2rmi/yVbw=
X-Received: by 2002:a17:90b:3c92:b0:365:a5f6:4a5c with SMTP id 98e67ed59e1d1-36c4ff2c8c0mr10234658a91.1.1780321292225;
        Mon, 01 Jun 2026 06:41:32 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc65e8490sm11496959a91.3.2026.06.01.06.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 06:41:31 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	stable@vger.kernel.org,
	jinmo44.yang@gmail.com
Subject: [PATCH v2 2/2] HID: wacom: use cleanup.h for wacom_wac_queue_flush() buffer management
Date: Mon,  1 Jun 2026 22:41:24 +0900
Message-ID: <20260601134124.1560886-3-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601134124.1560886-1-jinmo44.yang@gmail.com>
References: <ahu2oxLwkgMlwXu7@google.com>
 <20260601134124.1560886-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use __free(kfree) cleanup facility for the temporary buffer in
wacom_wac_queue_flush() to simplify error paths and ensure the buffer
is freed automatically when it goes out of scope.

Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_sys.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 2e237bdd2..edc24fe2e 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -70,11 +70,10 @@ static void wacom_wac_queue_flush(struct hid_device *hdev,
 {
 	while (!kfifo_is_empty(fifo)) {
 		int size = kfifo_peek_len(fifo);
-		u8 *buf;
+		u8 *buf __free(kfree) = kzalloc(size, GFP_ATOMIC);
 		unsigned int count;
 		int err;
 
-		buf = kzalloc(size, GFP_ATOMIC);
 		if (!buf) {
 			kfifo_skip(fifo);
 			continue;
@@ -87,7 +86,6 @@ static void wacom_wac_queue_flush(struct hid_device *hdev,
 			// to flush seems reasonable enough, however.
 			hid_warn(hdev, "%s: removed fifo entry with unexpected size\n",
 				 __func__);
-			kfree(buf);
 			continue;
 		}
 		err = hid_report_raw_event(hdev, HID_INPUT_REPORT, buf, size, size, false);
@@ -95,8 +93,6 @@ static void wacom_wac_queue_flush(struct hid_device *hdev,
 			hid_warn(hdev, "%s: unable to flush event due to error %d\n",
 				 __func__, err);
 		}
-
-		kfree(buf);
 	}
 }
 
-- 
2.53.0

