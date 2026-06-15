Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8866E428849
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542274; cv=none; b=g8onL9oGooTc8VJ99iTdFYKRWklazkJk3/Ewj3xu97Xxq1AzKOo4fFWF7zxjBtlDGs5FdIXal0LHtcd87I1Cz2rRKY1bVQNbzMLVi++Ytb5qv2YICIrJZCGl8THcOZUDzMS82IaVJv0BmlEZqCpvSLiPf1LO1SreyGDHv+n/rCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542274; c=relaxed/simple;
	bh=zy/uX04Em1qOYAkXQiNB2zxmwmc+aXjmAhhjqZfnnmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ruf4hh9driaakAXk1hexfsyzRlMRlkIF3ndiTK20feKqZlmAzJ+GrNlVxtWR+FQNHLRKAvy32afyB/7ZojjNxJBAQZpg2GfTUB0RG1cpRnDTqiaIFsPnIo2e0OZS4nRvjKbc8UFtA84UFqNs59wLPntAg8LKR6Z8GtY4fCrFP+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q+uV/Yu3; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q+uV/Yu3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781542272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0N8D41nDn0GGt/+Jf/i/9d86ipthIUVzMzEEbwqCq8A=;
	b=Q+uV/Yu3vtr/tsh1T9xKmb+h7lcOSAe08v6/ppQm6Q3jltVDRyLDNr33MwyAZncTsTwMm3
	ob68Mxpy8cIbxt9BcRVDvn5XOym9n3/0dcpKSQa5qg3JVSEsQRyyjwkSOItiilNgsNXLhv
	JwZk2UCpkRFfSU1SPTxHsRW4MdFHI58=
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
Subject: [PATCH v4 5/5] HID: asus: add i2c entry for FA808UM and other TUFs
Date: Mon, 15 Jun 2026 16:50:58 +0000
Message-ID: <20260615165058.3845-6-denis.benato@linux.dev>
In-Reply-To: <20260615165058.3845-1-denis.benato@linux.dev>
References: <20260615165058.3845-1-denis.benato@linux.dev>
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
index e68a6d93369d..cdfc8ec7d47e 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1760,6 +1760,9 @@ static const struct hid_device_id asus_devices[] = {
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

