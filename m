Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A9452D2BD
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788866319; cv=none; b=RAZbfmEQdEtnbjVBd/HsRqzJlaI7kUaviZ61l0K3Ea318wqSP0yxlOrndio2D9mOqZRqaxhXs4yRL7RlKTQQGl20VIC6/5nbY1vlZUwTS46tKknFAiKIaFkn2b7ffGWTYBAFh5B7TXhfsRLiS/Y6NtYd/TX6Gbhny9sP6EQRDGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788866319; c=relaxed/simple;
	bh=t/ovtFrISDktBvngN1BFezgR29OO5wT7f3gkFho/p6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNcSQwY4jigPz/0iOVMVAclD2pimKV4/8wqQmea1Cso71axNJQ9X5o+Q4F5SczMsnqOalIHZlHh8qgRg2Hs9jrNzOeeIl/tOtfV/2Y18ahPqePcB+piTODKpeLCE/1gWfEA7bVFEjcanl2LqrV47jGwGXDM1cmFwNEExKeGcCuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXgU2Ube; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXgU2Ube"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48436251906so5067567f8f.0
        for <linux-input@vger.kernel.org>; Tue, 08 Sep 2026 04:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788866307; x=1789471107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gk/nJeJxwPg2pq5tNRM4eCstoAGF0TBlM4pNX6SM0kY=;
        b=kXgU2UbeblVOpJxBU4KLQ61KVyf5ihL461GpQ+KmK5Bv1pQaMrx5EOj23PMfWCDohZ
         IUPXF/ZGU7BljhgKQvEgoXkILy3qDbjBhN6YSH/7cGrns9CWkzKhEvVw2IAR09LTgNYM
         lEv7PDcJQd2dToSZtRDT0eGEzrrZXZK/3C++fMgglfrnHOFleh2wulHX4hkJUpW+1fCM
         2+N5H6RJaRIg+WK4D/bzXVXQgkqromOW6sGyq69fTfsMet3WIaJYl/ZtIoZZ4RcZHPQV
         KiTAhWKWdacGskOd3gQSqZp0jq0LquMxoH2jlfHcdTnkWhMwq5IiSUjFVF+Zh+te7C8C
         6FEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788866307; x=1789471107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gk/nJeJxwPg2pq5tNRM4eCstoAGF0TBlM4pNX6SM0kY=;
        b=pp/3krU0M4PHEu7aEtuHr2lj2lq7MT6oV0yntIJM3Z+cSSKFYHuJZFub1Ucl+5p/g0
         jK9982HystyVyvD+Mzgr5/p/ADY4E4lGGB93mDUO+Nhf2f/AU/ZljXWMiWFUyTdCnwsR
         LBQyBjd7kpLflo4R4sGs4wxSxV067mH1BRp4Wss80077X/o7vRU2Rs1g6twE32Bo2rTv
         SEZGnQ6mHc8tk58oN+IxM3QhNpVQj+5X1wTUVvyQJrXo1+kh7zA4p/at2acO5FEALHCw
         8B2XNhntfu773fA6I2IV6vBF/Mw1WgWXnQFAo9V2WdPap/viG/C58NFk9/dDkpa66sv+
         wNvQ==
X-Gm-Message-State: AFuF++lY6wKhRIFytLauHJRDNOxYeDgjodzx/tp8FHwZWrdqBYv+Vz5N
	0xMQA2Ow6YEA/VlhVyKwHT9enCiMGHaW2Hdy0qb4ACToKk0k11w/Omogc3sfYKqLjewGuw==
X-Gm-Gg: AYBFou0q/fZk9HeITBBzhgZ3iV9je2f+QQ4fX1n5cqJ3EqVijVEghwwF2JoZCseoF/a
	TDUHFGqPtvmN1HUiIPLu6RXQH/QC/NXoSQg8P5BmG2z/UmF0aZLDo6nUSbUgq9Jp5B7pYStJYMp
	2nonSCDf8sZqVhDFz7jPFaZlUILs5G1XAuZ3dyWIGMY+MJEvbufuy8tsnEwWEbUhJPWi0PijDGm
	WTh9vX91FNJ6eYIhEVDuhXmTUXJSJKmzGWL+a0cUg6ZqAMBUkjNI/5sIUNXZqmp/7UzDakNNCJC
	OJcSvOxzlS8f3ickd5xAfk98eBhmoOxNioiNVMqeCilsmT45txa3ozIN46Ov7Q5SCKv3eJh02e3
	xUQPEIK6vQCMK+J2OFYGIsvk/AqOW0LdgUYGwP8V8TRrnVH9Pv00IfBlHzAlNshbdumIHb/BOoo
	Ukc0oS82FDpAvyfn98cBNUfyVA6RcSFuzRzlgHQlnG1ZyB6GGwz0tQKAV2TKHR8BdhY0FOc11cD
	ykWAA0EL0KZ95jq5gAokS13TLI0/rpkTPa+xm3HFHZj
X-Received: by 2002:a05:600c:3485:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-49cf825c119mr619835105e9.16.1788866307154;
        Tue, 08 Sep 2026 04:18:27 -0700 (PDT)
Received: from localhost.localdomain (mob-31-26-103-238.net.vodafone.it. [31.26.103.238])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4858d2693e8sm34422099f8f.3.2026.09.08.04.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 04:18:26 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] HID: lenovo: suppress phantom radio control input on Yoga Slim 7x Gen 11
Date: Tue,  8 Sep 2026 13:18:12 +0200
Message-ID: <20260908111812.43837-3-okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908111812.43837-1-okerixx@gmail.com>
References: <20260908111812.43837-1-okerixx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ITE keyboard controller (048d:83db) declares a Wireless Radio Controls
application collection, which hid-input registers as a second input device
advertising KEY_RFKILL. That collection never reports anything: the
airplane mode key is wired to the embedded controller and reaches the host
as EC event 0x19, where the platform driver emits the key.

Map the collection to nothing so hidinput_has_been_populated() discards it
and userspace is left with a single, real KEY_RFKILL source.

Signed-off-by: Oleg Keri <okerixx@gmail.com>
---
 drivers/hid/hid-lenovo.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 3976d7b53b14..617bba662659 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -476,6 +476,16 @@ static int lenovo_input_mapping_x1_tab_kbd(struct hid_device *hdev,
 	return 0;
 }
 
+static int lenovo_input_mapping_yoga7x_g11_kbd(struct hid_device *hdev,
+		struct hid_input *hi, struct hid_field *field,
+		struct hid_usage *usage, unsigned long **bit, int *max)
+{
+	if (field->application == HID_GD_WIRELESS_RADIO_CTLS)
+		return -1;
+
+	return 0;
+}
+
 static int lenovo_input_mapping(struct hid_device *hdev,
 		struct hid_input *hi, struct hid_field *field,
 		struct hid_usage *usage, unsigned long **bit, int *max)
@@ -510,6 +520,8 @@ static int lenovo_input_mapping(struct hid_device *hdev,
 	case USB_DEVICE_ID_LENOVO_X1_TAB2:
 	case USB_DEVICE_ID_LENOVO_X1_TAB3:
 		return lenovo_input_mapping_x1_tab_kbd(hdev, hi, field, usage, bit, max);
+	case I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD:
+		return lenovo_input_mapping_yoga7x_g11_kbd(hdev, hi, field, usage, bit, max);
 	default:
 		return 0;
 	}
@@ -1568,6 +1580,8 @@ static const struct hid_device_id lenovo_devices[] = {
 		     USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X13_TAB) },
 	{ HID_DEVICE(BUS_I2C, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_KEYBOARD) },
+	{ HID_DEVICE(BUS_I2C, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD) },
 	{ }
 };
 
-- 
2.55.0

