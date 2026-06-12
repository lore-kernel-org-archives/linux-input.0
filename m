Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A773B30F938
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268533; cv=none; b=DQOCPJW71NW/UfQcUUeBsrc7gQmawxTtX3F4cl34qdK4OU1KUqjB7gsl//D5A+mHAwr3dnRefIjPhXZJieSN4PdXX2Kzt6E7A9QllPIPPq1GusZKzczZ05ZZ/+P9yBUrzUNO28FRKYsP4RFu2hPXc686JJGCx3PpnJUnr6e1dYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268533; c=relaxed/simple;
	bh=nBoHEpjoQazuUNeUR1NXG4oQUl7p66r+nV0PVsR0Cz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njkrVks7ve2CfmadgBSbS/iS3n5gOsF5zUrjHP73uUpA1QvUEdv4YcIfWibrqXYA9JlF6U3nAOZCGjgIW2xsP1ZRIiJUxSOsSKIrkjkYJTEaoYMcF21pfXBwGbrNlqgatKAaKc98zLSBZAxfsIwRyzp2fC8BbN0ozgfQqBBQEyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Si1NYRia; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Si1NYRia"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781268529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aU2Gwvk3T5LQRlqvRfdavFJEIKSJzBUhj2Ikuge456k=;
	b=Si1NYRiazvSWDXNpaB4fM778wVJhCnLFZI4w5rzArH2NCSvZ2gyl9TL5BPkcDyYGLgHUr+
	bU7MRS9AaoVg9FTa1Mi/lm8ZG3AFc2NhsVQI5UD6ThwNJ4O3HDoKFPz+fUNwJZTepKFsFZ
	zB6tAxbaHP+lReZMydSW66cgF56cESc=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>
Subject: [PATCH] HID: asus: add i2c entry for FA808UM and other TUFs
Date: Fri, 12 Jun 2026 12:48:30 +0000
Message-ID: <20260612124830.984592-1-denis.benato@linux.dev>
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
index d34d74df3dc0..ef3a49847be2 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1500,6 +1500,9 @@ static const struct hid_device_id asus_devices[] = {
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

