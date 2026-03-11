Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC382BD030
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256809; cv=none; b=qmQFcaMaH64flhii0AJIyyGjqloDH4ap86PjAyRRjcfWlBn4QQga+VRHNnMZRueqtPTbTDtIld8BxXdUDJ5Buk0IwxSLnLuFsXWX+6AfKCUpGYkpO3Rf4YHy6Qt2fyC9ZK1kSTa8yLlmk0RssynGM7wcxPGWAQRIXuCnSQQp5TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256809; c=relaxed/simple;
	bh=YxX1sdDMy72DRDltHKACTsLy7W1u7nYfvobxcbVkIGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s85NV5YqdQ1IzFDuBaW0UPUz9wLWbDEh5mcV9MA1TFXRz5AQF/9lvAwqSnBxgduYDKot5B1e3eUkdNqMJUZxOOq3WGWCm3KSOZMAgab54frM9EIqkHzbaD3YxMin08GrOvu3N40gG/s8gcef69vrQKxA4DJqvQ056u0XaiUpjFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freund.io; spf=pass smtp.mailfrom=freund.io; dkim=pass (2048-bit key) header.d=freund.io header.i=@freund.io header.b=F4Z4pE1M; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freund.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freund.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freund.io header.i=@freund.io header.b="F4Z4pE1M"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freund.io; s=key1;
	t=1773256803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x03ZhFp6dSAw7w2Qrs8saYHxqzujz5ZCdU9c8bsksK4=;
	b=F4Z4pE1MBWfVgu2RfNaPOXf3wT/3k0z+LPB0K+htGhP7goKmSJYjg5xa0WcHRA3pGcbzP4
	9VcpYwsxhwhoRxxYAGo9DhMPwxTg4CW9+2Eq++QSql4GIGI6XtWYpiYK/tBjUTZ8yUBczC
	s/b2OtVqaMU3meAbWbEBzSYxKs9GOSsxmBtJbsblI999NXgw1VqJxE8nZZcQSyHA1JgaR1
	O2V/7OT6hGaUkoIhoKJwbtWxoY8KoVvxxgiKXEmaUA9eUriS8DJW3NPv7PtJ9YaW0+lK9P
	smVIPuiVavArmZCqRtOALZ01eyaujYesiLALXEcOEENoLKJMtSTtk95r2pc/Hw==
From: Adrian Freund <adrian@freund.io>
To: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Adrian Freund <adrian@freund.io>
Subject: [PATCH] HID: logitech-hidpp: Enable MX Master 4 over bluetooth
Date: Wed, 11 Mar 2026 20:19:33 +0100
Message-ID: <20260311191933.81007-1-adrian@freund.io>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The Logitech MX Master 4 can be connected over bluetooth or through a
Logitech Bolt receiver. This change adds support for non-standard HID
features, such as high resolution scrolling when the mouse is connected
over bluetooth.
Because no Logitech Bolt receiver driver exists yet those features
won't be available when the mouse is connected through the receiver.

Signed-off-by: Adrian Freund <adrian@freund.io>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index d40932809ce1..cf07660bd85b 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4668,6 +4668,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb038) },
 	{ /* Slim Solar+ K980 Keyboard over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb391) },
+	{ /* MX Master 4 mouse over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb042) },
 	{}
 };
 
-- 
2.53.0

