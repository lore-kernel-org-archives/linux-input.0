Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E6F48F825
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636422; cv=none; b=iQI2opJYRJWThT0sX4+DImwMOZIANuCoPhAAxFa3W/StU3oUTOz9TnQamnYqXJeikn9FwsUtmX8rHeO48Njt1ADg4soL7pFTQy4OCnaBmhCMiYVUIV2WBBDH2tBsCC47hKhpnLfZ++gdxlk70VB4vJ4zaQxCrtnN7akUxXHpMLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636422; c=relaxed/simple;
	bh=WGOCeIH9db89TSNRv8b+/b39Cf3yKL+4B/9bkmD/ttY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUdS0YYqtMWBRkOyHDNYr4zQMKBjRpgY7ELiTpUXaX5909U3aU8vSVegN+CnWcHo6xdavSeNNwTXvfnc/LEESzfGW7PcMdufXCBG2oHzwevxfJisUZ/ss9Kfn9KMCy4i6jFDJCa6RuSFbCX9HF7g1gFFX2Okzguz95Sx7WYduzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=idank.dev; spf=pass smtp.mailfrom=idank.dev; dkim=pass (2048-bit key) header.d=idank.dev header.i=@idank.dev header.b=XR0E5Wjr; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=idank.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=idank.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=idank.dev header.i=@idank.dev header.b="XR0E5Wjr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=idank.dev;
	s=protonmail; t=1786636401; x=1786895601;
	bh=XdFAHzdC6gkWJ12O6Ey1hEml/4gf8tNaOqxFYQetxkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=XR0E5WjrDw/qqrGh+ta3dciFM/SrK72bCJ8cnk5R9JEzgNxxPcFE6kSfmIJ6uRXng
	 1DzWWOiRyTmg9ack635R5jLx2R218Td1YJK/TwUvDyLJxWWLjTqsqQzEF+HdUCHW3h
	 T+7+F9cfcmNZgfAafkc+i3q3jqCwve1vY9VpZr/P/Kcsuu0sBkhrOsmYw/nThecLg2
	 +MeT0sww/ZWFydX//5qZM14bLKlUzGwfTb/LNNgKZSPdPFtAd/306J3VQs9gpxaRFu
	 B9CJR+kVU9nKF8SEpNj6/9Q4lkhdezLCqIqOJeV8DVKCiQ/w6RJdBJhOfiernZ8EZi
	 4WHCrcaHsaTPw==
X-Pm-Submission-Id: 4hLVJG6bF8z1DDrM
From: Idan Koblik <me@idank.dev>
To: sofia@schn.dev
Cc: bentiss@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Idan Koblik <me@idank.dev>
Subject: [PATCH] Add support for HyperX cloud 2 wireless.
Date: Thu, 13 Aug 2026 18:53:10 +0300
Message-ID: <20260813155312.106584-1-me@idank.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804032337.315750-1-sofia@schn.dev>
References: <20260804032337.315750-1-sofia@schn.dev>
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

(
I was about to submit a patch for my own driver for HyperX devices
(https://github.com/IdanKoblik/hid-hyperx), but I noticed that you had
already submitted support for the HyperX Cloud III Wireless last week :( 
Anyway, here's a small patch to add support for the HyperX Cloud II
Wireless to the existing driver.
)

Signed-off-by: Idan Koblik <me@idank.dev>
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

base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
prerequisite-patch-id: 8d99df67dab75c0c6cbc887b2ea6be90be288037
-- 
2.55.0

