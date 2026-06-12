Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8B13839AD
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274222; cv=none; b=Fmq4xX8g5i4Hi750CZnlqoVPE1+2DTAVT3+NyP2NpWgcBTwC8lkHCB7gG3OD97gvo94avCNd7ncqD8Z6txWq5mEPHzz0JR/7STSpUWHlBN4czzSxxW6sIbvzVjc+P2Ite1+GyS46Y7XIgB6mX2af/dIIrK4p77lGgloOVN8Nmyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274222; c=relaxed/simple;
	bh=B50fMS0gE2tzVMEsNaaM4WVi0diIgjoc614+eT6PTj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1FDTVuaOu/80aGImr08PL6t2eV/i0qOwTmFlV/mnk0kX/RoHBYcOSw+5QcCbLdexk1pcJEmw7cyXuc61RWR3BtF1ydrzxJ5Yht8miIJXrjL2CTVPTT6k31JMI7LKhTKeWQWxsOeBstIpm6boCbsZCC0UIZgTlwHqSG4Pa+vFMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OKRT85Y1; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OKRT85Y1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781274219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PlC2vGVmA9sHjk2hg4AjdHe+m+jeFI0gDoptw/3ZOpQ=;
	b=OKRT85Y1p5p+cINdN0QlDBGRSzj4fd++luMGAUraBFbJgm5TFfCjBY1noMoJ9pD9YkUFht
	nIILqYE0Pp0FrTY+McVJQ8NLPgMOFAT4p8mkecH0FDgKYLGR9hZwQZ2u/iRu05pF6KrCdu
	YSLtummGOgmb+Hj7/yVtDG1Hi1uav1w=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>,
	"Antheas Kapenekakis" <lkml@antheas.dev>,
	sashiko-bot@kernel.org
Subject: [PATCH v2 2/4] HID: asus: prevent wrong pointer cast
Date: Fri, 12 Jun 2026 14:23:24 +0000
Message-ID: <20260612142326.1704858-3-denis.benato@linux.dev>
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

The firmware version check for ROG ally devices assumes the parent device
is a USB device, therefore prevent possible out-of-bounds access by using
hid_is_usb() to mitigate possible out-of-bounds access.

Link: https://lore.kernel.org/all/20260612130125.AAAE71F000E9@smtp.kernel.org/

Fixes: 56d1b33e644c ("HID: asus: simplify RGB init sequence")
Suggested-by: sashiko-bot@kernel.org
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 4d7110b892bd..323dc0b7f3ff 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -753,7 +753,7 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 			return ret;
 	}
 
-	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
+	if (hid_is_usb(hdev) && (drvdata->quirks & QUIRK_ROG_ALLY_XPAD)) {
 		intf = to_usb_interface(hdev->dev.parent);
 		udev = interface_to_usbdev(intf);
 		validate_mcu_fw_version(hdev,
-- 
2.47.3

