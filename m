Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C45F429825
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772289995; cv=none; b=crRM8MDLVQvNESPT/PSpoS13qj0cZ/1X12Py4j8ZEcLhDwV9zq+2LNAw91rjX/bzVLaJlrsw72hzNwunPgh7BqoQ0rSSf1Qwv7ZOYfFA35fi1iFxOQQ4p94Nc0LIm2gz/LUk5bABSwsllbS74vADFP9vZ0Faf0sJgCOVQma/Jrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772289995; c=relaxed/simple;
	bh=UkDBhIPsFIFYiXHUVq8yfYf8INQMI/qy7cSepFB2xJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inymlE+ly4+izDi2AvVqeca8/pWIahQ35bnBq1WTxteBrKhNRCvLsFXGdT+AzHr3ZSHnG78ME3uyJzekcrKX3XYdloQRo5TnoclxeksDIjtfQ9j3CLyR+ev/f95E7YlgZSDoH1KZ/ieCbJUh0WOnj3UEfqnrhIa3I4LF7J0z2yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fggtjR/4; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fggtjR/4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772289992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/6nhFAzqdch83HyRN7Z7ZoNORIKsdmbyNN7EKa4jaY=;
	b=fggtjR/4h/URziKpVHs5RNnc9s0avTiNYtO3d2MSii/H7rauiDRBlSN3qTnSqchGSb6mYi
	+/7ey8RNdUWh5Qt/zoxOMGEuCV+Jf5+zz4txh06y/osA7fzwEgslDx2McYBio6L8cfnHwI
	pbtnet8ICspLWOvJrwtL+mVhoLIDboM=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>
Subject: [PATCH 2/7] HID: asus: add xg mobile 2022 external hardware support
Date: Sat, 28 Feb 2026 15:46:21 +0100
Message-ID: <20260228144626.1661530-3-denis.benato@linux.dev>
In-Reply-To: <20260228144626.1661530-1-denis.benato@linux.dev>
References: <20260228144626.1661530-1-denis.benato@linux.dev>
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

