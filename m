Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1524B388E59
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274224; cv=none; b=ZW+IZjMidmAXUiwfYPHcm2E0rdYlMbqyAt71WrCwmEeX4p2ljxgy3A0eiyCvLxNsjme/KJ6HTeBSNeLzBh2zaDmbBhXmCT8T8Sk/bHF2qHV31496B6OWbGbHRdyVaTnPnbydvaPZtNuUZVODxyKp1mTkn4JDPRAlD3tq4YOl/yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274224; c=relaxed/simple;
	bh=XhwIbjGalD5lEZAODSRPBD9iIe1luOfSzS+YYOSd7hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uD8isPZ5IuI1ECNnET808TYUHRWbzUxXz7fCXLYD/3NQTvDXeU2d0yH7TR7AbK6T2OuizIJBpoPor8RPn/dANnPFEEOBFvyP0iQ537piWCWFOXjw8Mr2YorQXTnisbedGfIQ2jg36BGsLdgromG2dr/Lbiu4cDc42U1MfMh1Bcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O+BDiHiQ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O+BDiHiQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781274221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9nxV2i2YLQZZuZAKZwV3K7h2IEWGbVlR+VMiebTnf0=;
	b=O+BDiHiQbMd0WyTalptwI8AyiFh5TvOK4+143OtXRpODjAIsE+y6UEJ87lYr6x3hFPX8wC
	9B6x5iZPsBj0zw3HbkWOlA6PYQZ6kv1Ed9O1q5bgWFyqIU/eW85Ukm5c56Y95XZ+SxBYrN
	E22hDlsYd2BJxJUTaKfmVkGx6ERz734=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>,
	"Antheas Kapenekakis" <lkml@antheas.dev>
Subject: [PATCH v2 4/4] HID: asus: add i2c entry for FA808UM and other TUFs
Date: Fri, 12 Jun 2026 14:23:26 +0000
Message-ID: <20260612142326.1704858-5-denis.benato@linux.dev>
In-Reply-To: <20260612142326.1704858-1-denis.benato@linux.dev>
References: <20260612142326.1704858-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On newer TUF laptops the keyboard HID device uses the same PID/VID of a
USB device that was found in ROG laptops: add it to hid-asus as i2c too.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 21c4a60d224e..b24222fdb319 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1571,6 +1571,9 @@ static const struct hid_device_id asus_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_HID_FN_LOCK },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
+	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_HID_FN_LOCK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR),
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
-- 
2.47.3

