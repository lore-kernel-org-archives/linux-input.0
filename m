Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0443B426698
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104304; cv=none; b=iAnfquXXk75QmqSwMjefRFFbTy30iw89v+17xhS7jL4zPauNKEj4IovqEjOKXelbNgUEtZ4gSi6Ea+R2F3kFWmSJqU3Ba6XggqOLh8J7sB7O/U7ZBmYme2Kux5Gs1/6R9Ade70cPIJSl599WHSgZvAVVKFTCI1cFM98/rQgCuBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104304; c=relaxed/simple;
	bh=f4DCuRMIiQ+r5mstE+Zb8QQiasX5Wm50BsvucMUuCFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h1cx0eWQxHtmzhBqmzdj7Rd9QKi3bsN5hkHIynCh3wcDEAOknHw6bxnZdaHqzKtDiMebMzeC8+rLfkF0LnKH/HWxVWoNKCaGsr9xpnYLCAWu4CjDXmsMB4fbLXtTc6IAUCydLk49ZGu9CzBs4UdVDm4kYPI3S5+eoO/ojuppF9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=vGr7macy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="vGr7macy"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490be03d47bso60828115e9.0
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 08:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1781104300; x=1781709100; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CI76wlVqEv+h2doC3kGTlKypNnsOzMa3uqhTJs+Jf9E=;
        b=vGr7macyM3Am7ZjlVkCCGPcu2dcfib0+NZJEV3RCAo7EbyvjO+nIhSusV3O2a9Fr4F
         rTzkXz2KPathh+DBq/fAD+eOUJboWmjgZEksWTS+N7t2UcYas481eLftWW5askf7aqEr
         FgpgEcVPNRj4oQO0xVNUvuD2vbjOnpaD0PQUaWbfA7qonToMsxTcs9NgJjcLwyMRTQhK
         DAnaJfg15o230Vd0ibZzXUcwblVuptx9DgpMEGSTuJkC+4rGGS1SVOi0htI0oWDxI6B1
         DW2W3G34EcIrXgoVZadRcCEw2oc3VKjjNH1B2gXZyPeSXfYnUYA/4bFgRj521aJY9Fqu
         vBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104300; x=1781709100;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CI76wlVqEv+h2doC3kGTlKypNnsOzMa3uqhTJs+Jf9E=;
        b=EZ9WjYeZwRLVKRSDNgj/2NkYR54r4ZwXPzSaHQsgkXh5fbIidWFzgWyEBDfyNauYSm
         SK+LX+byMIk4gHWLc1pl8BKPYOC5di1ItkQfRs9A7lMbOg25tlo+oVqcheQHrWtJF87k
         rKWY6MmuUkPG/EnpAdOIB6Lz5DCuPutpvs1rIxmUtUdpnvOA7huWixsRU2AaTSpqlfa4
         0h+28SBjzYruVbAK8MYse+20YNxxlAIsx4lp5rWXx+hs/G4zwQe/MhJupi20m3wA5LJy
         t31D6fXtjloG9Zv4kLYFUVOdNBHIMOjlPdkwbk7zTbeLMkQ7DbFQGeylpiojQ8iJmHn/
         yTqw==
X-Forwarded-Encrypted: i=1; AFNElJ8DlOhSL6sJVHI/CSNsu38gt8011SMxovZSaSkTldOXfoYif3RwYHDDdkcssnHJo8xBQpy7aTi7jWaVhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwskIHCREQDPKKuVKlELu3VjsSfhcTAn+BaXdI/X/GsOXAdfUq3
	TGyicNG71vxvzk1dbgUYEulSXvRv5+vNgoL4+QJMx3kTvrjkfpjYNzSQNhq9HyMhT6k44RUX5Y+
	FsOHJ
X-Gm-Gg: Acq92OEnJebkj4Zj2ismFv3AkJoZVuS10HcdqoMNShbsPJke3DKnYueBAgcB6S3mAa1
	qlaTm3MB55H8bg1S+dlNYpW/Z6C4EC38UUMOVQE2+/74dKtDMyEVyoxUXCHY+SYa+C6O7mq7OWE
	m8dwmNP3Ytm6+gdQF8hJ4bnrmjjIKr1mEylO43S90ehjElv5fBTWaxLTYmjltM9wutgjjBICsSa
	wxtEiwBLJtXVsrJoD69W/x8nJc976LLQV85B4/1c+0O23K+t2T3kcXpuRok4JaiOLO/viEhGxfP
	bmKv0SsJEhQHeidN8Y/ML837BbpLzcH+sSxddhROJsl9n+62vYtzAmxRnNe5gnMrB5gEhq6tSA/
	ZlonW4umFM9niXeXfIjaT/lhwMdf2u2RGjAL/1BqpHQMi1LZSOY52qrS4Gk+8bRpeonSpNw7ivC
	W2wBcgCp+cniC3n0Ne3EhkE+a/cBIT0EoyZGG6RMXS4d8JvehAYlc=
X-Received: by 2002:a05:600c:35ca:b0:490:bc46:1a58 with SMTP id 5b1f17b1804b1-490c25dea14mr441660315e9.18.1781104300365;
        Wed, 10 Jun 2026 08:11:40 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:1a6e:6004:a565:d3cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm585537575e9.7.2026.06.10.08.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:11:40 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Wed, 10 Jun 2026 16:11:28 +0100
Subject: [PATCH v2 05/12] HID: hid-belkin: clean up usage of 'driver_data'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-mod-devicetable-hid_device_id-v2-5-a1d7473ccd9c@thegoodpenguin.co.uk>
References: <20260610-mod-devicetable-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk>
In-Reply-To: <20260610-mod-devicetable-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781104294; l=1621;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=f4DCuRMIiQ+r5mstE+Zb8QQiasX5Wm50BsvucMUuCFQ=;
 b=NMCiakeEULIxfhAlhh+I3Jxzj1mXNANdxrCQhZQtZDpxteGGFjj3ckNqOV1MO+dcbnpM0AFdp
 WW+akCOjic2Cg7GSR5Zc0GP5WESLbaR9+szknSCMhbXDwC3dv3lNc3g
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

The module is storing an integer inside the drvdata pointer, which is
confusing, lets fix this and set the whole of 'hid_device_id' struct
as the drvdata and then simply use its integer 'driver_data' field for
quirks, which shall make the code cleaner, type-safe, consistent and
more readable.

This makes the cast to (void *) during storage a bit safer (just to
suppress the const qualifier warning) and the cast to (unsigned long)
during retrieval is removed.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hid-belkin.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-belkin.c b/drivers/hid/hid-belkin.c
index 75aaed35ee9f..84695115d37b 100644
--- a/drivers/hid/hid-belkin.c
+++ b/drivers/hid/hid-belkin.c
@@ -27,7 +27,8 @@ static int belkin_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	const struct hid_device_id *id = hid_get_drvdata(hdev);
+	unsigned long quirks = id->driver_data;
 
 	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_CONSUMER ||
 			!(quirks & BELKIN_WKBD))
@@ -48,7 +49,7 @@ static int belkin_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	unsigned long quirks = id->driver_data;
 	int ret;
 
-	hid_set_drvdata(hdev, (void *)quirks);
+	hid_set_drvdata(hdev, (void *)id);
 
 	ret = hid_parse(hdev);
 	if (ret) {

-- 
2.43.0

