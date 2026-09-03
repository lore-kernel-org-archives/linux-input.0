Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA833DDB07
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788462429; cv=none; b=rup/5uPTXH7msQ1OIUsNLzPw5p83/LcvMrqolDOwOXeuB5OBEyaMMDZf9M26P+WhmfLePKQCTm5GB9pT2Zy2c+O19z+YpkCYFRkouh9sD4AQ2J5PDkhkQJhx0oC06hCxv8QL8VSgEcA04B6h6w9pjd4wR5yIdnNDMrx5rzmlcrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788462429; c=relaxed/simple;
	bh=w7omx3YMyTcaH1ogVGWPdU12UICmtznTiUT+lio+t/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DOGFhxm31eJdiUW2uEITRMavmsfGC0Q1HzogqQGi+aGcLqWIMLdYqsiNPhOW1I2nyBuRQG9IEzvbVQ+aXGXLSAZDiyzyal1oxuj6xBoKmKFzM/sdgEO812vkYKRdYwDTWvtGTiUxduwm140D99wzROlmGukwFI6azJQ+rxQY7H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAj+DXpy; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAj+DXpy"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-398b3d66515so209878a91.0
        for <linux-input@vger.kernel.org>; Thu, 03 Sep 2026 12:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788462415; x=1789067215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dDib65S8CFIQhIYI6LWgQWUD0MUxHEqD0COA8UQlWu0=;
        b=hAj+DXpyDDMJxJp4v8yTSkHKrs6OumVlKYWzDPOV8GK6Xgbnw5chCk1Vo5n6F9Bc9V
         0/+Alg7MSkqBFkxeqfDFwpqB9qOTO3Jq5uWPl6ZXswWJKqZdY9QfBwewz084jGRqLZ7c
         VkjRdiyAkErHpIo46Kt6RQ9H2ZQCHa5N8XrAz0hoqHeRxShRp++6d8DGOvxwb2X5nEQW
         Bpzb76iFoU/st6yYR02D8zMVT3y1AyU+PH9NWh62FGxkpkEjXxRRrww+YYmS9WTca9lm
         aGGAYu7BERzwSN4ABs07pX8F6DIMHRIyTWr0V0L2c52KcTmjcph/WuSw1iQglsi1LVqM
         JBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788462415; x=1789067215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dDib65S8CFIQhIYI6LWgQWUD0MUxHEqD0COA8UQlWu0=;
        b=ZOn/csmY58PXo+vpVKpHLNBgSYo3aXiLdH2XiHeJLSkz8IfHItwK3BeR5ZEAl9qKCt
         rCNPH7GwQQGRCHDiTXfVSYrinEU5cADFrS0MckHw44CUnS/x5q3pGdck+8/2Xmp8yK1k
         Uc3iM8kVCDV2Pc2lnsXtHq2C6t0C111+wOXn8OgRJJPlkhXG+cROU86n1O+VXD/sFcUw
         P2ntV54c4O2JyYihGNnoTbsXZ0CZpfSXVLo1hXUT6RcecY1kkqeiQw3BKeSv8H7J8aum
         6EsJ/zXf58mbCDo7uYd+XfFUExebMvbF269uGwWuzQrtmR6g1TUwe+BPko4DvT3s6lu5
         npZg==
X-Gm-Message-State: AFuF++lpCq8IPHI9zW/W83uzqntad8juXAZyALZ1o11Rfrtlk4Wx4iAR
	iGA62iFMSqWIN0rLYRMWipaTMvFlD0r/Y0gpNTRQ0x9vfNeDZk5XXNLS2P3c46qo
X-Gm-Gg: AYBFou2kyrw7RcVD0nzTrT6mNUbfk9CpgEV4zh4zf4NY27EgMGryDzaUDLGWO0hOqH8
	f3l2BqroL4WPTWi2Skbc6nxNp4XYOliwsvXsOhtbXYucP2rBwBJIZ1Y8/U/6gJXnPWUpN/2hmC4
	2jN9NSUUE16cdgiryT/d0Tu1xTMJLE9jxMHnPeTcsd+RABMXhl7G/v4fqt9ieokLd09cSC4I3Nx
	kPJmHm5tgg1Egrd3hdy7mVIPmWjSZpwaUt1XcQ6w82XtLocaPqSb5n5JrDlqQQPoqTjdYjk0fjF
	Ddzfan6yz2fNMWauGHAlYx2w6kSrLDvkB3PDMFGg2ZGdBS9kHbcY7WLnj03ExeDGDKzLiQoNh1u
	dXuTpJVsFVayWjpL01XAvixW/XJvHzK/vrz/oQG1aRJvbp7ewXewfZRMtEffgDab0Ha4xI85ie1
	/iEc68OvzHAtGcsiuYqR2svOV6SJ5SDLpQKwcQ2aId9rY/4r79J7eKj/rIV056
X-Received: by 2002:a17:90b:2e0c:b0:38d:b36e:9813 with SMTP id 98e67ed59e1d1-39b26169b1fmr1012620a91.11.1788462414813;
        Thu, 03 Sep 2026 12:06:54 -0700 (PDT)
Received: from mothership ([2406:7400:43:dc90:37cc:75ad:6506:3043])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm982389eec.1.2026.09.03.12.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:06:54 -0700 (PDT)
From: Hani B <itshanibee@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hani B <itshanibee@gmail.com>
Subject: [PATCH for-next] Input: xpad - add support for Flydigi Direwolf 4 paddles
Date: Fri,  4 Sep 2026 00:36:39 +0530
Message-ID: <20260903190639.344878-1-itshanibee@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Flydigi Direwolf 4 clones Microsoft's Xbox 360 controller (045e:028e),
identifies itself via its USB product string, and reports two rear paddles
(M1 and M2) in byte 19 of its input reports.

Add a probe quirk to detect the controller by string descriptor, expose its
true vendor and product IDs (0x37d7:0x2414) for userspace recognition, and
decode rear paddles in xpad360_process_packet().

Signed-off-by: Hani B <itshanibee@gmail.com>
---
 drivers/input/joystick/xpad.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 2da0b7f1722a..f738a409d139 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -401,6 +401,7 @@ static const struct xpad_device {
 	{ 0x3651, 0x1000, "CRKD SG", 0, XTYPE_XBOX360 },
 	{ 0x366c, 0x0005, "ByoWave Proteus Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE, FLAG_DELAY_INIT },
 	{ 0x3767, 0x0101, "Fanatec Speedster 3 Forceshock Wheel", 0, XTYPE_XBOX },
+	{ 0x37d7, 0x2414, "Flydigi Direwolf 4", MAP_PADDLES, XTYPE_XBOX360 },
 	{ 0x37d7, 0x2501, "Flydigi Apex 5", 0, XTYPE_XBOX360 },
 	{ 0x413d, 0x2104, "Black Shark Green Ghost Gamepad", 0, XTYPE_XBOX360 },
 	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", 0, XTYPE_XBOX },
@@ -938,6 +939,12 @@ static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
 		input_report_abs(dev, ABS_RZ, data[5]);
 	}
 
+	/* paddle handling */
+	if (data[1] >= 20 && (xpad->mapping & MAP_PADDLES)) {
+		input_report_key(dev, BTN_GRIPL, data[19] & BIT(3));
+		input_report_key(dev, BTN_GRIPR, data[19] & BIT(2));
+	}
+
 	input_sync(dev);
 
 	/* XBOX360W controllers can't be turned off without driver assistance */
@@ -1949,6 +1956,12 @@ static int xpad_init_input(struct usb_xpad *xpad)
 		input_dev->id.product = 0x02a1;
 	}
 
+	if (xpad->udev->product && strstr(xpad->udev->product, "Flydigi Direwolf 4")) {
+		/* expose true vendor and product id for Direwolf 4 */
+		input_dev->id.vendor = 0x37d7;
+		input_dev->id.product = 0x2414;
+	}
+
 	input_dev->dev.parent = &xpad->intf->dev;
 
 	input_set_drvdata(input_dev, xpad);
@@ -2085,6 +2098,15 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	if (xpad_device[i].flags & FLAG_DELAY_INIT)
 		xpad->delay_init = true;
 
+	/*
+	 * Direwolf 4 enumerates with generic Microsoft Xbox 360 VID/PID
+	 * in PC mode; detect via product string to enable paddles.
+	 */
+	if (udev->product && strstr(udev->product, "Flydigi Direwolf 4")) {
+		xpad->mapping |= MAP_PADDLES;
+		xpad->name = udev->product;
+	}
+
 	xpad->packet_type = PKT_XB;
 	INIT_WORK(&xpad->work, xpad_presence_work);
 
-- 
2.55.0

