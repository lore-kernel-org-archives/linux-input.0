Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF8B40D598
	for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 00:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781827912; cv=none; b=sb9//SrRjXjsbNulpzVcjnyBbsAZjqHEreCjtJn66Bi3bGnxXQ0JQcVfIFhbANs5wz17m9t1oOii0s7wCzPzQzuJtrHDvB405+GbqDBPjd2AzKLlckq7G3+xZDJrZQbfi3SI4ONLtwjVY187P8QsX71FEWSBExs11IXijJoAHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781827912; c=relaxed/simple;
	bh=bFFMBinOYZ2GWYRf+YdPNwb+yN6mIlSfwEY+Lm9T5Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLmdm3M422gX7pm0BtRC8u6i73rrEIbto+lnVEUN9YTLrkqeOw/MKgkWbrgxCvTH1sytx5ga8aB5j+9J4ZXh6ffhjeVi0wpy8FuyeS+fH6xc8ESNwfSVLB37EtZM6YxtlEFw20YwxMDwk7bp7o6zvwzj3Hp+wXl9U3yS+EvIKUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ssJvX8gg; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ssJvX8gg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781827909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PRX/9RoW/x1szNsLaFOacouvSvC8Ad0FG+5+N+9ydQw=;
	b=ssJvX8ggeEyfDfWMvCEK0majfAAhis3lrGG91x9LontwKe6I6olJbq8bUgsf1hIViJjTiM
	7AuW8Y5a/PuFVVJb5dhj4xAW+/DAC4VN/tT/P3F7AEq9pKk6YGT8RyxGh1qCWoBy9pWTBY
	hrNH2IlYWgnPFAWVGm9fLWDKZDEYVGY=
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
	"Connor Belli" <connorbelli2003@gmail.com>
Subject: [PATCH v5 5/5] HID: asus: add i2c entry for FA808UM and other TUFs
Date: Fri, 19 Jun 2026 00:11:03 +0000
Message-ID: <20260619001103.1189200-6-denis.benato@linux.dev>
In-Reply-To: <20260619001103.1189200-1-denis.benato@linux.dev>
References: <20260619001103.1189200-1-denis.benato@linux.dev>
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
index 06e4888f090c..b155eaf106a5 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1770,6 +1770,9 @@ static const struct hid_device_id asus_devices[] = {
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

