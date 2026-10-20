Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488275;
	b=uxo/U01aswyU++FNiux3keVxmZxYFSBcW0ymKaUZzcNP/e8q395ac4RkI8CtnAYr+lHC
	 k611QT3xHbIZMABZg9apWOGMm2klGpSvD6ZOiqIWbq7WPJ1IwCZoOfnThR3ujicfCctAS
	 +oYWhxgNyT8OCfZbTk2dB/ReUtwm6GTJwRmT6COs4RQlNwojM0qC2K04GiO4HReYDqqLv
	 bZDgCud7Wh0ymp+OB3xM7SryPJ8njaz/tGDEQdC90qZ1PEBkoMdvKMRyaqOhmTBbw/bTe
	 Pa/0VXO9TMsSV7pqfjSKVyo2Lo0RioMPnCHoFi6Zao9et5M5S0f4jCHooAda7YjHXHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ICsh5sh6nhrY0eYXKrHtLFEnO/6ICVZodqetvGZNSwY=;
	b=BrPkrMAR/oagSj7A/iG9oab/0Zuixg3HsKETf+yJC4WSMP+wLT3YnqXuckwVp2Mk/CXV
	 mjxn00sZHVd9owA57MlIsOhGWzF4s4hIj0pd5eE9ODaHuQBR15JJ+FYOmWNw7R0S2/rx2
	 h1lVVKmdOgR50dEZboqe7xB3r/FCNYUMI75PWxa+nbTnbetbm66xctMcVHxHUGnBbYwKN
	 IR5cKsqrJSzo1lOx3Xax1zA//87qmRkop2L9MrR3Kgkpa5SxUJOfnZMnBXTyEQc86hf7G
	 T0z04Gm50alvA9PnR8Z9lOpDpircNmEZ2CCXanfQZML5hoCUyPQTFvUFxMihLUNH06g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=inpUOneK;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B2D606A339
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 09:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9B2D606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=inpUOneK
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so14648695e9.1
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 02:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792488273; x=1793093073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ICsh5sh6nhrY0eYXKrHtLFEnO/6ICVZodqetvGZNSwY=;
        b=inpUOneKjBnvK1rYvccx+Jf3O0dImryiH9rl9r0RmuAyh4JERycVEsUWldotNWXXHF
         WVjaXapOrTu5h0KJQsGq/VKjPseXRf67rZQXGXyVqOGq2gN6Akd3FJqrs6vWCi6wgWJa
         FYR0C5sR5+PzmUbe4AbCysdQIJYVj3hU5PeleV7giqAdrMzewgYo1xOdF0US4kx08eFu
         XSdfLvkc8GR6N2maABaD96gcSzKMNWGs8EXsiK6cahImoTNnO303z+btt78Hj8XH3cgw
         +7pXUTjfkgmxhyZkh34WzLckFf/O3DCRanp1rMdYK8VfgScnsHjbS0RqJLnK6usPESaf
         Z3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792488273; x=1793093073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ICsh5sh6nhrY0eYXKrHtLFEnO/6ICVZodqetvGZNSwY=;
        b=2Ajz3/305fZpfsrNFCJ5XwcmAoc+SRUZ2H/oW2MAZNyFsvEtUATDFwCM0WE+4tH+Qp
         aQh6k3qsG5W0cne8Bs90lX2jS04Ikh7PtNYz9QC9tvPJLyyH4odTekCeBcC/hewZten2
         7lBUCUWO/QFYqnl4yowOM2HQ+8RNpuyqy0ElQ3DnAch1Z+0UjNr6QUCgkOlDVUvPrreF
         Y7JAYKs1RUnRlVWBUhkPNKmCW2sToE1llwXGRbjwCn89/ifxGVeBWFPx/iqzNucw5Oyc
         AFI5HSfuxVJafFp2ZLRqeSkpWDxjNd73+OS5sKFq1QXef9j1NJ7U4NcNAMqoPc0jbLOI
         EL0g==
X-Forwarded-Encrypted: i=1; AKwUvBzIcQL6j04hUZyGw3nJf+x5iDo4uIfFAfwfr/s15dGAhE2qAKxUbpkfcbvLPyYP+o2Gc7P70pNxhYn92A==@vger.kernel.org
X-Gm-Message-State: AFq9FYLTfgdTCUTdAZaWqodC714AzgEnq8nrS/5y/eMiWBH6GFkTpo3h
	u5BUgPJggpyrEIOQojetqJtJDSwsWAhUZfKBVVuJfVI5CjjHyoxVBbrpp1BE9YVe
X-Gm-Gg: AYBFou0q/dW2qFk+WiuhOchb4nD0V1BZ8D4DPRnwPxU7GtT9k/CP0YQw5CP/abopdar
	KupLDqy8I9OeLAILrqe/3iRCUluftWmWl7NTFq7pxdwPUy8J6pqd5MgNKVgTLK57ihtHWpSnoLH
	aw/rkmc5gKdgzA9SE1pX4hYXMgCSJBifaC2oZjfJCrGsHVIOTP6AvgIfsk8IHjUkf02UbgAvWBx
	Joo1V46coNss38sGwCJDD8pZN/92UelVTtqT7NhlCvA2UsOtJfgdUFyFeTGo6vZC7u3PBoEcS6e
	zF7ssM0Ty4Xt8/DBW0+Y2Tusz6kCkn+XNCrdPOSDqEHemd/hheQZedZIe49JJkf8itYk52CVgPY
	oGsweVOtWV652VjasyQN4VrSLcQgcC7AnaqvKVOLX/pDpSOcjcbSP5M0jAVRpTeO+Dqn79BvOZB
	HPTr/ELaD7zklBd5GXxTIR2RiDCyVQ1Z2SIRTeDtevClqQf10BOJ9ZxJH3gdVti23h75x1c0XXg
	iNkTkme4UUT/tErPSq+jPeAalYOTpCj3qtGXN1MkiivDABaAyV43YSK
X-Received: by 2002:a05:600c:3b17:b0:49f:dd9f:6038 with SMTP id 5b1f17b1804b1-4a1d7612c55mr210686475e9.25.1792488272739;
        Tue, 20 Oct 2026 02:24:32 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:f99e:1a52:655b:681])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f6631abfsm40767315e9.1.2026.10.20.02.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:24:32 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Paolo Pisati <p.pisati@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <denis.benato@linux.dev>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	Luke Jones <luke@ljones.dev>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	Ivan Levchenko <me@livan.pro>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v4 7/7] HID: asus: Keep the Zenbook Duo input device names
Date: Tue, 20 Oct 2026 11:24:17 +0200
Message-ID: <20261020092423.36380-8-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020092423.36380-1-p.pisati@gmail.com>
References: <20261020092423.36380-1-p.pisati@gmail.com>
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

hid-asus renames the input devices of the keyboards it handles to
"Asus Keyboard", except for the ROG N-Key ones, which keep the names
the devices report. New devices are not renamed any more, so skip the
rename for the Zenbook Duo keyboards too: their input devices keep the
"ASUS Zenbook Duo Keyboard" names they get without this driver.

Suggested-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 drivers/hid/hid-asus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 6ee2ecca864d..69894de8f6ce 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1712,10 +1712,10 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hid_warn(hdev, "Failed to initialize backlight.\n");
 
 	/*
-	 * For ROG keyboards, skip rename for consistency and ->input check as
-	 * some devices do not have inputs.
+	 * For ROG and Zenbook Duo keyboards, skip rename for consistency and
+	 * ->input check as some devices do not have inputs.
 	 */
-	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD)
+	if (drvdata->quirks & (QUIRK_ROG_NKEY_KEYBOARD | QUIRK_ZENBOOK_DUO_KEYBOARD))
 		return 0;
 
 	/*
-- 
2.43.0

