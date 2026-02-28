Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2073F9337
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305827; cv=none; b=iG2z6f6hDPJZryqiwrB1dMv8Ssgi/6uzzpAuW065MUzkcE/O8JrZ9wv3FSeM9iaIO7Ogny7E4ZUB5xIyd2LBYDeImRYby/nqqmhP/fzpSN3X28H51ofEdOZ+jC/3WB2TFa0APPSe1NChBZg8nRc4YoQMltcDMP3HzDMNoEngVSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305827; c=relaxed/simple;
	bh=UkDBhIPsFIFYiXHUVq8yfYf8INQMI/qy7cSepFB2xJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZX1osf9oc2l1uworiHuESjYQjHnaheFQUaGVKTcGeLhSL9Av+wm9zpL2MDXVLtrU5r+haV133mpXeaVQbnz5E9Gqx0b4yYk0glDVBFropnWbrmUBBBj+W95Xu2Ug0Q4pRsmSSYjfPAU0J1ucVhHZRn3Odobw+dnNxZA9dwfLb98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZPGPlQ+/; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZPGPlQ+/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772305823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/6nhFAzqdch83HyRN7Z7ZoNORIKsdmbyNN7EKa4jaY=;
	b=ZPGPlQ+/MboKfK/1mb4L11Vps+tMlc3EUQ9Z+PI6kqJs7x0O7p6zjZNob+NhNCQjBrJMV2
	rP11bTYZac51tEMTU3H0QF05O5YN+VZvFvfD+fre5vXSAuVJUabcdU6yG5N7ZmDSNOlFaQ
	1F6gUIPWFdrYjoKP+xlC8vr5YBTui9I=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>
Subject: [PATCH v2 2/7] HID: asus: add xg mobile 2022 external hardware support
Date: Sat, 28 Feb 2026 20:10:05 +0100
Message-ID: <20260228191010.3830758-3-denis.benato@linux.dev>
In-Reply-To: <20260228191010.3830758-1-denis.benato@linux.dev>
References: <20260228191010.3830758-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

XG mobile station 2022 has a different PID than the 2023 model: add it
that model to hid-asus.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 3 +++
 drivers/hid/hid-ids.h  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 5fcb06b16167..fbcf38b15290 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1515,6 +1515,9 @@ static const struct hid_device_id asus_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X),
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_ROG_ALLY_XPAD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+	    USB_DEVICE_ID_ASUSTEK_XGM_2022),
+	},
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_XGM_2023),
 	},
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4ab7640b119a..5e85921049e0 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -229,6 +229,7 @@
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X		0x1b4c
 #define USB_DEVICE_ID_ASUSTEK_ROG_CLAYMORE_II_KEYBOARD	0x196b
 #define USB_DEVICE_ID_ASUSTEK_FX503VD_KEYBOARD	0x1869
+#define USB_DEVICE_ID_ASUSTEK_XGM_2022	0x1970
 #define USB_DEVICE_ID_ASUSTEK_XGM_2023	0x1a9a
 
 #define USB_VENDOR_ID_ATEN		0x0557
-- 
2.53.0

