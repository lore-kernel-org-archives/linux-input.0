Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E637331213
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120421; cv=none; b=Wh0/vpH8ljevKFSTP+/26fLplyKrD5TCgZHSZEqhL8+7WA3MX3BN4y2llLvbzrn+zCMdGQAj4zZjs1TJ3q/ENQZga/0EjbEGvH/TygGkXqsbhWSJXlFuYC3Z83u3GzD1SAFt2kNQJoUlQ7O5nXl3LHBIL7xPtB8hawndqNUD67Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120421; c=relaxed/simple;
	bh=VPJl+JB1sK44spIQdc+zTSmkH07q5Bp2DpFT/dZSrsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PaCUEfm4IJp8oBPiMY3umB3FnIkpTbNUT1gKgD2+g92o81ybC/5gcPooQA8jPe9iUvP56QWeuTzrshcwrucSCQLbI1lCNnrwSqPMmOovgbNQrb0UWcyMdzr5pWeet75gkG2X2uZgWNc/voFwllCBPVCQLGVsxBTlZnMgV5Igilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=pw1R9Otv; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="pw1R9Otv"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d734223e4so1556356f8f.0
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1779120406; x=1779725206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7ErACoXWhD127Qp4xaJTrfvOnkOxi6EpEfIRcq2bl0=;
        b=pw1R9Otv5DSI4TOuskI/bpcloY+qUdFQ/67biRg/UOLiViqP4ewjwJwzSuboYiA7QN
         yEm0TX/HART6LXr0AMG5qyLOhzW35u7NHYyigH67irrkcJ7VbUn83G496TbROwkX184q
         Gy242aGNM7cs2AFxHKhI3x8x0dYMYGd4Bc3hgZx/Od7mgN7QtGAroB8hTMCxBYv9+QJa
         DzIQrQX0jEV/b05DPqtqOECz/V/J7jGEun78GMRT1JIH3ZgPZoUHBWDrZqWEooVyUwYI
         0q02FuI6yQ3MY+tZL3WwS//g6PA+u3lNJwRyImw9iq74yYZRYN+k3OgWJgQQAZNXw+Nq
         WKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779120406; x=1779725206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n7ErACoXWhD127Qp4xaJTrfvOnkOxi6EpEfIRcq2bl0=;
        b=F28cayxHv/gtlHDalkzGzWy1gk9HEzhPuvkkXk1ilnEI5PhoDOvB+Vo5Dztp7Hc9Ss
         /RUTX+qwpU8p4IRqoQyisILMvLAVVC9YiArZbspRait5bSN8kakej289ghxLKOFe+sxX
         T2hCJWABKgp5nC82BSe/psZsVYC/vNiXfSL99aOQwfwq5ERYktY5ag94qXTxqigPF14L
         C1nfdy9q++q52zmWpCmspSeQlZqGOoKfXG9dPxqymbf5XAe8ftazA5T0pR1oe6hNq5Lc
         RQvwSjHI7X45iuS4eFjoDOz4XwA4aIHAsV7sXuMLR/dCujyjLOZwMewGuGTZfedq98+P
         qlUA==
X-Forwarded-Encrypted: i=1; AFNElJ/srou7i9IJe/wxRVVEiSB59b9T0JGgMKFohnSri1lja1W09KUS08XbP8ccNuLsaOZ0LskOe9pgCVb2Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YykMYSpOnyOJ46mJP9V+ZyaKCVb02xFKREDYLGAg9ncg90bKSy+
	QUaZPm5Jg21+CPnbqoXtrsNnsqr1lZ+gQlNSy3hhRHKq7q96Cxb3z84UDfWGFF8p/2E=
X-Gm-Gg: Acq92OEWQ+mVJLXr9Tka7ICacwulObUBmY1QkXXaqroAMvdNhmMJavqr4H7OJX1FuZQ
	uIIB8E+iA2idQOwPZSRnWaDi4n/cwX6h4p46eoXoo3ycE/TqWu0Nn8lgMQ5V2wIwKNjNY3MLeD+
	74mrsPKx0ueMvFE1tfi0/04uqbMCrVa+5B71kNPNk0YalYFcRMk2RjcJ02q4CT66dOD+3RANiRM
	rInctcuoacZ+ROIxEhzcY0UsaA2qLADU2OyiZ+lHVVqPQREEpU+cHpH8Hi6Z+lmzmUcbLUIWO8K
	+jBN55Q0sXvPXeBSzAcnFcqmLJADvnznho5IDi/+zHb9C4kCySd7oDglTpa2MtAbp4oSGK7lMZP
	fbB7Mpp9akFevS7fQ1HKfcwotkdvTZ+kh4dvOWAd3U2Gog1efAjc9aHuxfL74IV5Ee4v5Q0zoYh
	c7Z7tc/geN+27c1QdPN+f16XdraWzq8Ycz29f3Z8rZU7AOpEnCpWE=
X-Received: by 2002:a05:6000:230b:b0:43d:799c:b2cb with SMTP id ffacd0b85a97d-45d941b0783mr30206592f8f.24.1779120406270;
        Mon, 18 May 2026 09:06:46 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:de11:5404:1c7b:7b76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13b4sm38867318f8f.28.2026.05.18.09.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:06:45 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 18 May 2026 17:06:24 +0100
Subject: [PATCH 05/11] HID: hid-belkin: clean up usage of 'driver_data'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mod-devicetable-hid_device_id-v1-5-a08e3989c283@thegoodpenguin.co.uk>
References: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
In-Reply-To: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, 
 "Christian A. Ehrhardt" <lk@c--e.de>, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779120401; l=1565;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=VPJl+JB1sK44spIQdc+zTSmkH07q5Bp2DpFT/dZSrsA=;
 b=IPUmvK2ytKL4amjX9tpk2IIvXuxxs+Bm0Kuk1azP49TLO+fuXSR1AmIA2SFsnTM2/957tfVX7
 8DsV636tltVCeH5U6651Qa8QUd+U1L0o6LxwCF1IXYi3dxBVMfdVR3V
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

