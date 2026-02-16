Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79EA2D73AE
	for <linux-input@vger.kernel.org>; Mon, 16 Feb 2026 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771264549; cv=none; b=iotaS0dRvzYdBP3X3nWkXMU+A0LwxQjVOUhKFtkNb0Iy9eDKx5Xw76Gzq9XhP+7uezETgC3BC+4qd9F28iwhYmi02IK062c3MkDZQdHNjausaH+1MlZJQLCvtFJXx2/V6UAwgDvFB0rl3JnG+zHxColSDolhaPuC1NAaJP3V2N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771264549; c=relaxed/simple;
	bh=RAdDhGRzykezhXREadPUKYtvrR74UC9Wu82XDID7kwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dgqa8CIpvgNnfVtWsLHJwU4uCXMNqnmdCYz9CTV4soQ0UQosp8Uxu8v0e5GDaWx8zfYB9wtCiVJtOrH2cYsB2jILJ6yjnA24G3bBu9IqmdFN7eSeVWdI2LeOYmOZoL8DCPP1Cljf9vMPki1Yv2ceKvcWBSNYXQFgpbG4dWqTReo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Iy3QpOv2; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Iy3QpOv2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771264545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bIO6O2MnLzFjWYWkRj51ABG0Hh3mIeRs7kOZxpCp+As=;
	b=Iy3QpOv2czsWjjbZdxGp0ApSOj1sUDlm2cIIwEG/tpFJRXpTZZfA+MfZSt3AEdvZb0yABU
	zSGP8UWdOUgve11S++F6VyCiNPsDC4weaAO17eGlpuyssp5jjRxAiDnU5JZR2+LG07rpYe
	xdRhAbQl121GUZNXZP/dJpUzt6IU/ic=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH 1/2] hid: asus: add xg mobile 2023 external hardware support
Date: Mon, 16 Feb 2026 18:55:38 +0100
Message-ID: <20260216175539.12415-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

XG mobile stations have the 0x5a endpoint and has to be initialized:
add them to hid-asus.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 3 +++
 drivers/hid/hid-ids.h  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 1b9793f7c07e..52efbf75a994 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1483,6 +1483,9 @@ static const struct hid_device_id asus_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X),
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_ROG_ALLY_XPAD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+	    USB_DEVICE_ID_ASUSTEK_XGM_2023),
+	},
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_CLAYMORE_II_KEYBOARD),
 	  QUIRK_ROG_CLAYMORE_II_KEYBOARD },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3e299a30dcde..4ab7640b119a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -229,6 +229,7 @@
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X		0x1b4c
 #define USB_DEVICE_ID_ASUSTEK_ROG_CLAYMORE_II_KEYBOARD	0x196b
 #define USB_DEVICE_ID_ASUSTEK_FX503VD_KEYBOARD	0x1869
+#define USB_DEVICE_ID_ASUSTEK_XGM_2023	0x1a9a
 
 #define USB_VENDOR_ID_ATEN		0x0557
 #define USB_DEVICE_ID_ATEN_UC100KM	0x2004
-- 
2.53.0

