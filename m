Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488270;
	b=Jzth7KUZUAy3Qmtv4yrP75Kg9OWBUOkejCPH4MKJ2Pr1M8IWq9TF8qNe+iKpmi4//eAA
	 YkOYmThLaBeznz2GxBWlevIBkctIIgyEn+Dsa0KrrEbNZARbQm6wXKSML9m4lGgXLrsFp
	 sl9RE5pL5Q+5WjOlijIQU8/71fslw0V7eJLkO9TxNWUgcwMihwHdJpAWU7vRtl6xNbMU1
	 k85rpkk1PmlHbmOqZfMrqqASYOiH2v57X+nH+iccksBmqlc4JSGgOBWz4Gh6sg26FzlpV
	 09oQKoQTXg6AsZPeVw6A0ahrEtK/6lnG/3D7l5Iu0Lygkpqf21fzY567Ex/r1EXvoRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=roQqyNfx8Pypy612wi71JOnX5eZuqCINaeYET6UT91o=;
	b=pjS5Lb00jaeqjeiT4nppgkIacCuCy5AWjOM+emdZjyWjbNuIjzN+GdtEvb2rOpI8VkfQ
	 hdcF3CpIpzTgTXFrwuwiJLTnb+D5i2qY9poTF2dbLlvZ4vSZD5dPIsn/rsZqROHRJGAn1
	 Qwd7iacskpXL1qkSpFqbtJrzXkqDlkpNNh5T/7RNo20ZWW07bpHybEA3YN4fv3CgQUO3P
	 25ATK4L0VnLNZs6U7wrTnv1jsDFAbZFOv/nWOuIwmtRbyZMNRLymbZEvd0ym7wiEM6nhW
	 c6wHbH6Wvw4ne/CtM/2oNO90w+qcl5QXgCeh+0DZ7nqs7WhI2e0qadoX+Y6X/jZ3Fjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eksGq0G5;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2C9606A338
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 09:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA2C9606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eksGq0G5
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so1900410f8f.3
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 02:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792488268; x=1793093068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=roQqyNfx8Pypy612wi71JOnX5eZuqCINaeYET6UT91o=;
        b=eksGq0G5h1n0keQQ4BX+42RP9ZBIUB+OxNrzvFK3v0KLlhn0c1HGzZCjKdMuAqRibW
         NmkGnaJpgNrRJP6rjeXFYLpFdp8EdHtjdXdhxaaMY8YlBn+24v0GMeEIyUr0qiKwj4RS
         Q/zhw+OTCEOrN+LXpcPxkpRCNAevYYgweV0aXB+TDoJww0RhL+BjC6y5dyo64MhqngSM
         Qch1KFUcRNfiTQcxFTqlXyV0U5Wa4KvOyZX8ehplauXQ9ZCkWk/fpwDaw5S32xPHGLts
         Bokq46iJ0Nh1juC0oCJlbcWKOytbS7z2a7aCASOmpapkjD1rRPz0Hdyms12VSCGFQPqE
         BZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792488268; x=1793093068;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=roQqyNfx8Pypy612wi71JOnX5eZuqCINaeYET6UT91o=;
        b=2Ui4q2pByVXI3EYkExZtMPj54PRqP1uyeDnoA71dYPIBvNWj1QSCiK81vd6BPMq1LT
         fkH7MBqB2EfMOXwhTmTpgRbOXRSzD6wwhcoVwEAgAuKUz5CpsfSFw8dReGLaTDJuTDVx
         HDW5apgT1pMWsPDbHOqfWOkVwAwDZgVv5Gb/vhnLX9RN6nw3HuJj8knUZNlnOSdWclnH
         nAnX5yxzUXkC9Vb3K/5DTeWZ69G5cTZbivLApQPVTNOjWJW0735rc2RH5xtWYRNcGQC9
         LCc6vYnXcW4J1xaLmE9sG8SPV8sRb0cONlGfL9u2rreOCbcrWeoDrVNXInB2UHeTwt5V
         Wdzg==
X-Forwarded-Encrypted: i=1; AKwUvBxMQnMCWCJNvTYzcDRPbdDg8QK1p4buVm3kxlc9l9rPzaiR4S8NO64sG3ZiPqqBf86tlYsSm1vMA/WF8A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+fnxmcfRqwVnH+9y6X2Oj3VT/oeXWsVUvuokc5MZhdx+9hxX6
	As7AWF0F4j67byIZ7Ytn9FZNxl9xVS2RcdXpWv35lVaxIjKycfc5e+CZ
X-Gm-Gg: AYBFou3NaxgLlZnGCQ+xGshQN8t+V89hjoq70FrzH47NIVPqYjvjac+GmhlHWkKnaP7
	TUuokYNXY2JLxuTdHXHqSBaQ+A/h6Hb6MUE2vMc66IeljUrlAi9ziRIYC55UJJsRcTaNBWdq+e0
	Q9dB9bPRBuQAnqV75VhxtQENOiY1qEw/YR8ziSoWzdRu+RwTtLuWiy1zS2jee8Q5u4u9AJ/xoi3
	0gYywddafVuC1i/mZRwcQiSXAjbf+eJB/0nOgc8NNAhUS203h+x5BAw1s00wCn2XCWVJrlk19JO
	kOOmk+QmY+/CTAAx9xS2uDsX94GTvwcPDjDwTAfhsskwAF0U+mETW6qdJzB7uOo7x3Y7CIv2m4K
	r/EjOGoR8Bs0Ujy21KlWGfZhZrsPf1Wh8ochUpTMqp1jJIMVHxsn3xs0S2HCpHLriwKupbpAXWP
	eWfz7vK1FT7OksN1hfjmG6qeQhNmW6GWRMVGQkxXkDRxyYvzoaokKxj1ZaOyPKH+PNkkQrS+kM2
	59FwSKAWu/vEqTtjwkPOXzXmocQFhR5AKXnaBwqYSTwy4MhuGSVu0hV
X-Received: by 2002:a5d:6f10:0:b0:48e:390:80cf with SMTP id ffacd0b85a97d-48e07f9e4dbmr20042638f8f.32.1792488268226;
        Tue, 20 Oct 2026 02:24:28 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:f99e:1a52:655b:681])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d820822sm5316731f8f.34.2026.10.20.02.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:24:27 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <denis.benato@linux.dev>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	Luke Jones <luke@ljones.dev>,
	Ivan Levchenko <me@livan.pro>,
	Nathan Chancellor <nathan@kernel.org>,
	Paolo Pisati <p.pisati@gmail.com>
Subject: [PATCH v4 3/7] HID: asus: Force hid-input to bind to the Zenbook Duo hotkey interface
Date: Tue, 20 Oct 2026 11:24:13 +0200
Message-ID: <20261020092423.36380-4-p.pisati@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Joshua Leivenzon <hacker1024@users.sourceforge.net>

The Zenbook Duo USB keyboard reports its hotkeys on a dedicated
interface, separate from the keyboard and consumer control ones, that
only contains ASUS vendor usage collections. hid-input does not
consider those an input application and never binds to the interface,
so the hotkeys are never mapped.

Pass HID_CONNECT_HIDINPUT_FORCE for the interface of Zenbook Duo
keyboards that carries the ASUS vendor collection, which skips that
check, so the vendor usages go through asus_input_mapping() like on
any other ASUS keyboard. The other interfaces either have a proper
input application or nothing worth an input device.

Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
[pisati: use HID_CONNECT_HIDINPUT_FORCE on the vendor interface instead
 of injecting a fake keyboard collection into its report descriptor]
Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
Tested-by: Rebecca Mara Müller <rebecca.mara@posteo.de> # UX8407AA
Reviewed-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 54f4d68eecc7..68211ebe1290 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1514,6 +1514,7 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct asus_drvdata *drvdata;
 	struct hid_report *rep;
 	bool is_vendor = false;
+	unsigned int connect_mask;
 	int ret;
 
 	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
@@ -1609,7 +1610,15 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	/*
+	 * The Zenbook Duo hotkey interface only has vendor collections, which
+	 * hid-input does not bind to on its own.
+	 */
+	connect_mask = HID_CONNECT_DEFAULT;
+	if ((drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) && is_vendor)
+		connect_mask |= HID_CONNECT_HIDINPUT_FORCE;
+
+	ret = hid_hw_start(hdev, connect_mask);
 	if (ret) {
 		asus_worker_stop(drvdata->worker);
 		hid_err(hdev, "Asus hw start failed: %d\n", ret);
-- 
2.43.0

