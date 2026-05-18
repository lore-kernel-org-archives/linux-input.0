Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0557231A23
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120428; cv=none; b=khIyHf6ZNSICbdoUCj6/5jErL9HgYseLlTAZN734HVNxvtEwkeOeGSYnQdNAqR1jdIkGk7PupBPVndEDCYbCdRXCbICa5BxxwVV37NTPwj/bhpYt17OVnvXj+hyGw4mCDhxnlLqc49KWv0cE9600gcXJ90Y9nrCOcTHU1hWJO/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120428; c=relaxed/simple;
	bh=DfbZ16dFZ+wAu5tOIFLqBrwHcPlnbizxh3/o+vMD+5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m+4pNTWhJ6M1/Qx2PD9Szz8D2NS2yMqsitc5cuoojCT8dKw3uKG1duE5Qgnt73VcYooxuQZkKIJmTas7wjcLvGOHFcpxSdhqKgnME8yDu57hZ/bOGs7Ybq+derHQXwiW/t7sXcedyK66LA5L54wSVPpEHQ8Xv8H9sQ0rqHpgRU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=t9OFnQ4Z; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="t9OFnQ4Z"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-449de065cb3so2385376f8f.2
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1779120405; x=1779725205; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+noZWa5z9Z6zRaYCOeZRe3oQX+SrPybiYkciD/u336U=;
        b=t9OFnQ4ZtpL6g+oFaQNlqBQdYI/nmVz+f9MPHERwv8ilSAyV9RUEGo2Y4Sk0n6kVUC
         9W9Jms8Wd/4fokVMe3RNZtllyIqa/aSW3cns8lFNm1HyWJ/CVCu6k8T5wFuNeNAyeWnQ
         h5KgLHJCOCljFYsp89OpyNsYRM+p9XY2G5KtzUy75ePKrUCzW9v97g61fG5OkRBbT26E
         xBc+S+pHYPBC8OFOxNn1Ja5HbplFG+rSx3tWgne7pM94NhuwDj3pCkBWSiEj//R+DKYl
         DPtt2n4twJZcr2SKcUw4/EkjA8L5SjEjO6ZvbyzqhwUKJ0MTkPP126vkoxQPV9tJpTsQ
         Yibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779120405; x=1779725205;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+noZWa5z9Z6zRaYCOeZRe3oQX+SrPybiYkciD/u336U=;
        b=fzzo2s4nzmdO2WA+8/BDwqVY8cqbLo3MhwKD5llyMhpUrEushBW9YOlWm5pac+A2pd
         rhWqknLBrU0tuPUiN+symZozrsDCsyK4gugjfZfyjPypHAF1qTxS9FJB6tScfIg5sV0J
         QutzEpC8aTvablVLYqN2G4Cpmf8v2SzMzaj2CagXmo1yBAG4l5xz0GKz0HGUc9NTpeeE
         JuZb3fAs4did3FJeybXM1PNCKQtYejel341buT3vae9X0x8C+4+I8GL1bx4t+1i1Rjrs
         AlMNZy0c6dDh6zL0IgUtJ2cEWV0gPrHIs36fTiw8dZjtxLaxGPRzbPL3zhxa9S67bPON
         DFpA==
X-Forwarded-Encrypted: i=1; AFNElJ8RCyo53m9NfO1jr4tKNPH+vTQduSwJlbq0X44DPS+u5+ky6687vH1nUIQtAtpQs2SVJ+fLRh5HvrbICA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvAAMBmSWWT9yMHYHj5Pm9ILFayKsepivt4hceR1GlKAy1iWI+
	DLgnW5UFDWY3AfZYrdgXe+5ojWdsEKBwpS0ZRQf3e1aVOsX533DQkpRhhzZupn/2Vpc=
X-Gm-Gg: Acq92OGaUOSP+wZbXJgJ/HoOKsZdnHQySjxOm094b+yS9xwxQSGliKEOOcFz/wv9sly
	vZx+VApl+0w/aVbzcIXE1S4t0VfM25FyQfYSu+CZfJDXAgAC61pJe8T1RStr8msyXOghGjp/guS
	j7wHrRihdtfXAIVbztd2HLLhlqd9IGhZXD2ln1o9M6ofzuqSevEnwWv6bBAw69gw5KV5Ub6kEcs
	LoRdzpK/8hKsYOwQntrN+Lw4Zr0QNWbu+wAcvnq9+uImZbD4VY9I+y3DrQIuMEIcr5LGQzUprP1
	cR0OvtkgCY7ggnvlu5uEqmihnl+FIuPl1hKov3UIzQn7Z872zx2adY6StX85Bg/PQsu1ETvrban
	rtjoQ+QjUnS3iektFWiFEZrOvS6UMnGj127CR4nbyKwr+so1dRGQdvMWevTFr0gqa/oO6QgUhGh
	G+3U6JhwOBYx/7WD/ojkmeKvcTzecsb2gtmUNui+MVv6JWcevqVgo=
X-Received: by 2002:a05:6000:290d:b0:43d:7d24:b4ff with SMTP id ffacd0b85a97d-45e5c5dd30cmr25997188f8f.40.1779120405550;
        Mon, 18 May 2026 09:06:45 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:de11:5404:1c7b:7b76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13b4sm38867318f8f.28.2026.05.18.09.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:06:45 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 18 May 2026 17:06:23 +0100
Subject: [PATCH 04/11] HID: i2c-hid-dmi-quirks: use named initializer for
 'i2c_hid_elan_flipped_quirks[]'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mod-devicetable-hid_device_id-v1-4-a08e3989c283@thegoodpenguin.co.uk>
References: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
In-Reply-To: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, 
 "Christian A. Ehrhardt" <lk@c--e.de>, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779120401; l=1071;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=DfbZ16dFZ+wAu5tOIFLqBrwHcPlnbizxh3/o+vMD+5M=;
 b=8Gz/09wEj9NegtN+P6xaxriqYikJVvf4VwqtslF81B3ZOLgV9aPA6oNkJ94od2lrgkseWIPox
 Y/0yIHsjuMEB1FYNvnoF7Gb1T+XIgZuy0NwWkpj0kMvJmT+nyV/Sh+A
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

