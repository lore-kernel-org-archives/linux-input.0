Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC9441A91B
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164142; cv=none; b=Nu+nx0VWLPpCuwpeK7DSujwakxAOhX2xKpQHx6Env2EHx8xeaclEhOG+Emp+oHoqdU0nf+K3LoYEefX8o5zNVpEj1hjPyycxJ98eEDgOnz7uxxleGG6LsA/4Bh4j+/XMnAF1ZoPkFOyHCgiow3Pu014SysfXklBK1BD46GdX0+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164142; c=relaxed/simple;
	bh=m9MSMwmSRFrb+0utEEabi43DN1/3D9k9Ra2l7OMEf6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bia5wUJlTU1UONy5dvs2K5I6PJ6eaXYKvbKPbw+84wqnobuLLG1/fBA3WQq2l0lcKoj2hLnZAq3Z4fKcT5Hrnm32GGqi+NRPUmcngrToo8WWL3Mv8NMEUqos9JrjWPO+XbnHMzUFsJgProBi1Xw4WWVUcqokysdHp5Fp4aHeXXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=zuLWEbNI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="zuLWEbNI"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495590dde14so31014175e9.0
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785164139; x=1785768939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+bBiSl5oXr7BHMtFgh9YZBcTIwrMok/i2fB0mXs7bU=;
        b=zuLWEbNIskhrQJcb76l5TslUOutgXGaEfeyhzJiN0OBZPDXq4URODhnPp4xtbhiS+L
         8jNf+iwd65ASyNRX3wPwNLl8/65ISzDANxJYGivWy+qPDyRyu0EMapzm+ZHiRH80Q6xj
         bIVxPwKK965u4iI4fWfAJROnEFKafozW686tKrwjjGBDgeleeGdg/qJkJ6YCd9emoAPr
         KOoBIxV7w8VMMo5mh9N3b5f7N7qmsoLQAKlWCFoeLPhapwZ7XN1kRKsN2hpWYVO/a+YS
         9C0Ilp+1KexIz/I3PnvXkm1qXJyqZTkYxGycJ0brRDxLqO9gnhDPAzzBHNW3ar7blfuj
         YBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785164139; x=1785768939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2+bBiSl5oXr7BHMtFgh9YZBcTIwrMok/i2fB0mXs7bU=;
        b=BQ5tQTuhyATiQfDKC2VT2cI3NXhTG+F3PZpnXdW07uA1Ulgnqf6lj+dmX4ePVA2oUf
         4OlYuNa/fdvZ83C/nBTScqKMwe4UmHiHdQ2TwtkzNoPM2z5CrvAOUYro0/nO1xRmd6Fw
         cktBQ1uXNxaR73Wg2c7SYxznB/AaYqk19i/p1EYJvcifDHbKJ3eQoiLdup41V7iQ95iK
         WflbiXS+gDV8mIJhx3qtcdyaTwzlbwhesngxHvPglFwKhjImI/0CHDTu9pt2IIPjMQv8
         OBd/1irguE/KlTyinqmVDYPVnTbKvWZiJMdFY+fh1tGPbyuR1tmeTgsLCnkROGbalUIx
         bhlA==
X-Forwarded-Encrypted: i=1; AHgh+RqH9qAYHlTuoWQDmjdLehT5lxkwmZM1a0qPiX9VUs91mQ0njNsbjsO8FDFaT3e69KSEbcAHxzQIYs0FKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5XDDxOAGz8IjhH+yry1rixTHYtLizJhHhFWeeXVEfLsTshycS
	0QgjDmiwGLsKPR1ebL4BNEALGCvt2+ATe9p04wgztPgKVMJ2TCCxg3NT/5ZyMvI1ybE02vmEJoP
	S5ggxw3s=
X-Gm-Gg: AR+sD125FVK2yloftqEWwSCUoVGz6IrtcroN/AtKygMtWGcbu0Zio9CG8e+CWW7/HbM
	+SAgptBLeoVcuInG08jS2PDfAC/5nfHRu1pGJkdnAQ/UC1IcJouxIep74n4aHJMZ7LuOS1KcZKc
	Rne5oqCdXn10HI0fVQTQK0bPvzPELsVwcS/FiGgfdktQjEKypH62tqJcxGJ/ZANgHrJap5X5k4k
	xRv/6GfCqMab0ZiZYkwek3V+BVR5iuYNAXrd4RAvQAlRiKNqdT63DtY+wErcbDOCKofMldUPEai
	jBMxdlbPKnEduUCeUgBdSO7e0I0Ua1WbHY4NPSVy/I+lbRZ/8e4HfL3VZuli5eSAue/L4iJMtwk
	rJYsgVctTFj1I+6oa4GgETp8skdSF9zNS9wjRG9KCpKWG0+8jA6FzO2B/XEhCMzupr67ZP1fkJt
	4oiep9Mlk0MYJPry4ZuBM=
X-Received: by 2002:a05:600c:4ec6:b0:495:4859:8f9b with SMTP id 5b1f17b1804b1-496c3a0bd8amr14037095e9.9.1785164138747;
        Mon, 27 Jul 2026 07:55:38 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:7aab:bc55:e039:4aac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9928fdsm254241585e9.1.2026.07.27.07.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:55:38 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 27 Jul 2026 15:55:29 +0100
Subject: [PATCH v3 4/8] HID: i2c-hid-dmi-quirks: use named initializer for
 'i2c_hid_elan_flipped_quirks[]'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mod-devicetable-hid_device_id-v3-4-980896ca283e@thegoodpenguin.co.uk>
References: <20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk>
In-Reply-To: <20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785164134; l=1071;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=m9MSMwmSRFrb+0utEEabi43DN1/3D9k9Ra2l7OMEf6c=;
 b=RQAZ5wzwAijkteewBKJn7osELWOcSO6+E0VkE1b2OqoDrHFEyXFYvD6PTAQu5btsDSruFFAM0
 ixAGJjfyNkWAHsWuWkz1PQZWQzjqe2QDnn1LSA95DT8V59xpPXyL2A2
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
index 83b9bc4b02e6..c1f81154f6ab 100644
--- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
+++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
@@ -419,7 +419,7 @@ static const struct dmi_system_id i2c_hid_dmi_desc_override_table[] = {
 
 static const struct hid_device_id i2c_hid_elan_flipped_quirks = {
 	HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8, USB_VENDOR_ID_ELAN, 0x2dcd),
-		HID_QUIRK_X_INVERT | HID_QUIRK_Y_INVERT
+	.driver_data = HID_QUIRK_X_INVERT | HID_QUIRK_Y_INVERT,
 };
 
 /*

-- 
2.43.0

