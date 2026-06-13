Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F2E369D57
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781364646; cv=none; b=j69jarpir8eyxViV5riznWovrAbaD0oHTDqo+E7gTSLxzm5P3dqYmYeiNq0EpbRpAKceXVf6v6LSaQC49F0GyM3pPMzD9ApZiJB6WWwAxHPYT3KMsjOmgbIJhenuOcsRGvLLXa2ExkDgkW+yL1y7dJWg5Ps/aS+DIswf/NlDbBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781364646; c=relaxed/simple;
	bh=sUnXM1OWVjMiDZeUu56Ec1S5vGLpq97dioVKbPR7OBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFdtgvyGabb3+0FF47FfxtOVZvUm3H9A0Xr+3kdp8zSlleToMS46MuVnsfov/XKKi4ugY3klZZJyI1QF8evZZKaiF4ogF/RYpdl5R9/cxmXZ7iPkkdH8CuZFDAOa1wBBMI8XDyzF3VARv8/WmBOsJ2Cizy+9XutlL7dHn9QEmiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XHY/pHxr; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XHY/pHxr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781364635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0gCNjc6f2KrHDHK++JxynXo6mhqWfC/Nh8DPkONGza0=;
	b=XHY/pHxr0QySCjTlb0TJUYTV94Dn19nEm6InL6XwCxwrKFDl5rbyNlUBpjlFCbJqgxZqwA
	TQtoIqcYaly5GSvYLPvGcQB8TSYuSYMc6ZN8XDCAGqcHA/T7YFPVafU9lnljqw9ztVd+vh
	KrM8f0NCecB1eBJzVN1AARjyrYuwL3E=
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
	"Connor Belli" <connorbelli2003@gmail.com>,
	sashiko-bot@kernel.org
Subject: [PATCH v3 2/8] HID: asus: prevent wrong pointer cast
Date: Sat, 13 Jun 2026 15:30:23 +0000
Message-ID: <20260613153029.2559774-3-denis.benato@linux.dev>
In-Reply-To: <20260613153029.2559774-1-denis.benato@linux.dev>
References: <20260613153029.2559774-1-denis.benato@linux.dev>
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

Fixes: 00e005c952f7 ("hid-asus: check ROG Ally MCU version and warn")
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

