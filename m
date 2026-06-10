Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10567426EA2
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104304; cv=none; b=MTruUnTBH7gsHvVta/sxSKpJVMgpiRzxDBryLn1H2AZEIIOpbPB+/xZCPhLUROULgH3kVvNbN1NQhs6R0VXTb+Mv11EcsfqSV5tbHAaI04A6zu6A80DgpKEUFLryYCszlkbEgsLrX10xK0KcHK9p+/6235jPqcetNa09yI7dtpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104304; c=relaxed/simple;
	bh=DfbZ16dFZ+wAu5tOIFLqBrwHcPlnbizxh3/o+vMD+5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RQsFGoeV2eF3y6Bcd4fZekMuQlLKHSNfHG8l9uhgM75gb0cS2T4P0J55noxehiuOv2cQ5z6hVQalnAnwQfWV4aswjCEIb3IG5NHbvEuN2axyOQmZf5ZPJxQSfj0O9FXYkAYz/MNZdqM2IU+TO3EEJuh48+h+j7CzcoAGGR1sKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=e7Y5xLQb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="e7Y5xLQb"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so45129215e9.1
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1781104299; x=1781709099; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+noZWa5z9Z6zRaYCOeZRe3oQX+SrPybiYkciD/u336U=;
        b=e7Y5xLQbvTZAG2/98Mycrw/8Y4os0cUdhxZhQy0fywlIU1aCwhxmwSL6wrdD1YwZSN
         u8fgnbgEePtrv42AgXyBVD7AyRW9HuUsIy2AfTPDO91VYI0txSBcgqLzmTAxiOrrZweB
         5g1TxWGpXiDj30PHuvX340X1UZeVBEvq1KPXaO9FXhx/Eny94rBwl3ukcCONSH4nwCt1
         dbqk2M+W7oZxlNJ8ce3nKqId4tX8/R1PLze3Vzon2qsZRuneq16G7CkaglvfHfRWKg9T
         wQGKCvKxGa59ODKb+iRMh0ltmANvj5tTAzqgapEkUnoIFxpZOGq9/JwNrotQ09yZwZrx
         ZWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104299; x=1781709099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+noZWa5z9Z6zRaYCOeZRe3oQX+SrPybiYkciD/u336U=;
        b=OicK1d2nCN4aSJ4io4XxNVvR63v7Icxiie3QelggX5XOw9EOVetaBYuJsvF+esNlfD
         5CT15X72F9WnqppbOGF9aOtLrH6gp4GY7QEaZMn8zmKfF7YuF5A3X2+b6wNAkQOnBi+7
         Ler43e95rVfo5LBVJa4qeaRwgzbeveof+05Jq+X7oWse+3eQr3o3FYOcs5s1o3/tV9NM
         Hk+6sxy24A2Rj3usSweg1vO01mOS+QUfQGQWoKPCO/fFly/I86gXXlVf11DeCBkp+1SS
         s9ogHn7CoUPmIM19GVGkkKyDkxHPhjXK6qVDgnKBEqosx/J4g/dv9cf5mU1zAzANStMF
         h5BA==
X-Forwarded-Encrypted: i=1; AFNElJ84VsUXvrRwuq1znBaGPT7Qhi/4F4VRfvO7HLLzmd/zOt9x7m9Qx2wHw0AzACySXB9P2RBvuBUnR8QHjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxN5zm/k3tUPBkVFO8t9BjLOaHhs3kVfFLNMF1/mo4QViBrpunx
	agkaePhqsDvrbdU2Tywx1o3czcvr1KSgiRe2vF6Q+QAd9elxMrIo2Naa6zg+WelzZKKjGUSkLGy
	++eLv
X-Gm-Gg: Acq92OEiou9XK8drnyOorjWmm2y8Xn4XsXwgwIAcGQmWktr1lT8xQyuBogwnwiOZ+k2
	bW5E8LNXy1NMNahd3WszGPn/4Y6n4tjWK7cX8bYohWxYW59sJQoICLC7zyoZ2z9NolhYkMd5m8N
	u5xRZAsSk6r9S5krglDgdxiN30ZwSJuSM9Wwq94tfB1RMrjCImxK7H2phf+7NVibIYq8TSg88ca
	o7YbpMiYCejzgQlc5wKucNUJ0amLD9RLspU9ZiyNJoWDvKFJ+zkxWwIy5UqUtq9kO6l/mW7t60S
	/rTCOuBEhoY5VmqTquSHgYQQf/zGD120pZt1meJ0idvv+Z9LptEzUTBkf1AJU9mjUQam7j2UYZd
	35qvTUaRv2TXwrePsoCRYOU1l3VjCvkA1fEzsHT9nMjUH3DxkUnZ1iLsP2/5b0mTpgWZRlDAV9r
	Ox50Mk7pObAseX8odPoWmgznl2vCjKlrP5j/sU+VVrQL4BmK0vwpU=
X-Received: by 2002:a05:600c:19d2:b0:488:d6eb:e63c with SMTP id 5b1f17b1804b1-490c25ae46bmr436691955e9.15.1781104299467;
        Wed, 10 Jun 2026 08:11:39 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:1a6e:6004:a565:d3cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm585537575e9.7.2026.06.10.08.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:11:39 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Wed, 10 Jun 2026 16:11:27 +0100
Subject: [PATCH v2 04/12] HID: i2c-hid-dmi-quirks: use named initializer
 for 'i2c_hid_elan_flipped_quirks[]'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-mod-devicetable-hid_device_id-v2-4-a1d7473ccd9c@thegoodpenguin.co.uk>
References: <20260610-mod-devicetable-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk>
In-Reply-To: <20260610-mod-devicetable-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781104294; l=1071;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=DfbZ16dFZ+wAu5tOIFLqBrwHcPlnbizxh3/o+vMD+5M=;
 b=vudzAt3S4/YZrk28ApyCMn+JYUXPvgjdUJZQtE6aLu3Fw67L7hjJ9loxCW0eucRWLw5gQPdcT
 0/jh+R2PyIHCIjVDr94RieJeyL7PSmr07NvDqY2GKjcwLVl5v0vqrR0
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

This makes the code a little bit more readable and consistent
with other drivers in the HID subsystem that assign the
'driver_data' field in the 'hid_device_id' struct explicitly.

It was confirmed that i2c-hid-dmi-quirks.o pre/post patch are equal
using diffscope.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
index 210f17c3a0be..f3e3cf73641e 100644
--- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
+++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
@@ -420,7 +420,7 @@ static const struct dmi_system_id i2c_hid_dmi_desc_override_table[] = {
 
 static const struct hid_device_id i2c_hid_elan_flipped_quirks = {
 	HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8, USB_VENDOR_ID_ELAN, 0x2dcd),
-		HID_QUIRK_X_INVERT | HID_QUIRK_Y_INVERT
+	.driver_data = HID_QUIRK_X_INVERT | HID_QUIRK_Y_INVERT,
 };
 
 /*

-- 
2.43.0

