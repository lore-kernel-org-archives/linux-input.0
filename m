Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A863D4130
	for <linux-input@vger.kernel.org>; Sun, 16 Aug 2026 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786877036; cv=none; b=lsP5cu0k09AmflNtsmnTvLQm+g/kIkActAx5g0K5YuOEI/Me4IXm0nkuaoA2+HFcL2ZGgL58Yeo5bLyvtx1tolRTKRSg5yB/Z4wm/WIqTNaRgVW+8KUSQriXb2W6W8WHKUzen7erRZwt2byVAZoAh2TK/+leIRwamu6sp+lxVSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786877036; c=relaxed/simple;
	bh=k7JRPgZ20sWucQ6HA0PQ9SE3BtmeIfukn5IlLePz8lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQ6bptanW9kCvb2NEIee1ln3wwZfxg0oCsx1NsAGXvAlm+HenTjPnbFqDIDFaUUWyxhqow2kW0t0v6b6du9wRD9XjkOsO/E3mdQzMVuf8qaNFJ16cSiUqJzucFcgLkqztFG+wFxDIWKQBOk+f232zF3hBOEnwTuYeLyK6o/KzQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=idank.dev; spf=pass smtp.mailfrom=idank.dev; dkim=pass (2048-bit key) header.d=idank.dev header.i=@idank.dev header.b=a865mow0; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=idank.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=idank.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=idank.dev header.i=@idank.dev header.b="a865mow0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=idank.dev;
	s=protonmail; t=1786877024; x=1787136224;
	bh=tdWKNup7226XppdKlfASu7kB3qBgHTA0uwn55LmkApA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=a865mow0yl22lsuIeJrQ1+5+i8fU7UDLSIWayq4olKy9Rv8vCLL+7u3aqW7MSG7Y3
	 y9O9xqYzwsRNMgmqIJF22bjZDY5ek2DeshSeLdSSXln8BpyfIGwKMnveD6tGL23vbN
	 NxkSuCP+bJ9oH5CwidUFk6E1f5uuRUx6giy3H3MKwqkKE8sdpwHdvc3MVUrV0r17Va
	 UUpK01MeMIg4KEfUzTPjuxI3wflMLo1WFtsUfk2XYgDMc1VqcyvnxvEXE/zVd9lVjA
	 y+HUlbxZfr7nqLzCxWoX2G+PC2U6zx63A3nxHcsalKoqslwS6B1kjvGFdnVvLoBzpM
	 TyZcjfF2s4hAQ==
X-Pm-Submission-Id: 4hNCHd4vFCz1DFFK
From: Idan Koblik <me@idank.dev>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	bentiss@kernel.org,
	jikos@kernel.org,
	sofia@schn.dev,
	Idan Koblik <me@idank.dev>
Subject: [PATCH v2] HID: hp: Add support for HyperX Cloud II Wireless
Date: Sun, 16 Aug 2026 13:43:08 +0300
Message-ID: <20260816104308.31972-1-me@idank.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813155312.106584-1-me@idank.dev>
References: <20260813155312.106584-1-me@idank.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the device ID for HyperX cloud 2 wireless, which requires
the same handling as the devices support by this driver.

Tested with HyperX cloud 2 wireless.

Signed-off-by: Idan Koblik <me@idank.dev>
Reviewed-by: Sofia Schneider <sofia@schn.dev>
---
 drivers/hid/hid-hp.c  | 2 ++
 drivers/hid/hid-ids.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-hp.c b/drivers/hid/hid-hp.c
index fa53d5f6c..84ea358ea 100644
--- a/drivers/hid/hid-hp.c
+++ b/drivers/hid/hid-hp.c
@@ -381,6 +381,8 @@ static void hp_remove(struct hid_device *hdev)
 static const struct hid_device_id hp_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP,
 			 USB_DEVICE_ID_HP_HYPERX_CLOUD_III_WIRELESS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HP,
+			 USB_DEVICE_ID_HP_HYPERX_CLOUD_II_WIRELESS) },
 	{}
 };
 MODULE_DEVICE_TABLE(hid, hp_devices);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index aa2c3a713..a8a37a936 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -697,6 +697,7 @@
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_0641	0x0641
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_1f4a	0x1f4a
 #define USB_DEVICE_ID_HP_HYPERX_CLOUD_III_WIRELESS 0x05b7
+#define USB_DEVICE_ID_HP_HYPERX_CLOUD_II_WIRELESS 0x0995
 
 #define USB_VENDOR_ID_HUION		0x256c
 #define USB_DEVICE_ID_HUION_TABLET	0x006e
-- 
2.55.0

