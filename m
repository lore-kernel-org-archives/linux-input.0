Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A882199FAB
	for <linux-input@vger.kernel.org>; Fri,  3 Apr 2026 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775208620; cv=none; b=VvBp14GDfzezceeJLl2TIrnBlWm5BlLr6P0J0FqjytLfIFuBacenU4ZBhYakcxP1ii9FgBDyuXHQMn4WOe61cYLfaoakBq+NPtH0GUUTrp2Ckh26zjPknC3VSuEZJcHtkelVs1e2dYZZnqnITnxVuB9aT5Jf29c2VwIrFVzSDvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775208620; c=relaxed/simple;
	bh=pS/3k4pjMy0sxAnSI7aAlDa5mjvfCtVujQ0EbzmtTQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELYSNcG6aHlXTL6g2rmlaX6x+ZN5LKKQrdQHO1TWjrwlY5eGWxRkfioFWhaOaV+oSbj4nIyyjqrtpRDx17+VGAV3aCdfPFT8ML59r/oh5corAyX3r9ZJ7xcRbhDh3lh82l5IT74k7zQhXWPynajP9kyQNlM1UKt4/F4QmNQNIgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwkQhiv6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwkQhiv6"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82cf976ecacso741480b3a.1
        for <linux-input@vger.kernel.org>; Fri, 03 Apr 2026 02:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775208614; x=1775813414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yO5D+j9M5AtRxxt40Si7bosnW9HX1Oj5Mckgto/+0/I=;
        b=QwkQhiv6nKSSD4gCJfT8wUug8c2juPyCyxr5kaIu+9CjzKFElfak3i0pQmx151YNx6
         mFP8RZbmEagj7dKtEu0NvrsSC3MlL4jASkz9hfak1LJbQYFwwAErWDzYnnp4GIdrQz38
         6+TKdTFH8ETx2U/BeSy/gBJKlA3rU3xVsotwWbx62TxYqP8UJ8x7dLOWHuzhXoFjJvEi
         b+jEoX7mwlU4buCMIShr3i/HbaEa25uFEKZqRlmR46nJBuWNzU0tRGhaE85Yp2lpWDWR
         VoGYw4FLhFMKzV3mXIUL0xsE79bGwGPGx2Rbi49Fpgr4zoHod5/bZDfoRo04ReDlWokM
         61hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775208614; x=1775813414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yO5D+j9M5AtRxxt40Si7bosnW9HX1Oj5Mckgto/+0/I=;
        b=iQqoBOuwGjYFlBiGVM3upwXW8DyyEvrYvcO5vwSyOMKaCcGojfA8qLbhoKd2Nlk+qS
         8D2/W06cOLmXo2TyC2Doq6vDDXBneuEnnMU2bkkPy54faJvSTh0hlBg0ZzjfNynqpO5u
         r/h5KfwGS5DsInEHgkd9t8N2LLfEr1lqTfXhY2qW3r+cqCjnEh2rFcAk/DAd970W3HbK
         SNQnurcAla4ob9Gu8/i0DYva7SIrnn3lptt2u6syQnZohdyUJf2lk2jiVccDr1FaNP0t
         OLDrRIHPn9xBQfwkFJfaX4UFtf+zlWO1vjPmDgyZUJnO/KbNrmqTHhnbu/R8ii6s6jry
         x3tg==
X-Gm-Message-State: AOJu0YxJenMyy8mS+PLznZ/9eWGTjqWlCkZH7QHI6DRRaY6gTem6Yf2H
	GNscFieTscBJtjXbk69mdmnzlFiu4sCx+D4no9lhXZT4sfcxKtbTEkcp
X-Gm-Gg: AeBDievLuYAPXyWQQK9UBEbFf4SknSLKHLjf6EVv8qR29uJt1XhSlF2RwLkhwh7k6kl
	aKlbFlORO8hOBJMhpNeTnFwlvv2oeTK3NgjLeLCuS2mroKcC/6FKFzmaAc2A2dY73DNhk7GrOJY
	EGsC6GfdWqSNY4EvYVlq1qFhpgi2jH/2EM16XznSvkhGie+gk4f0V4actQRerxDPdegM7dOL0k0
	KVX5exzuW+HgpsS2DcKD3u2Ih88k/TDbeO+WyBf7nFLt3i8mdNPV+nvT9bD9nSZDIetQa0GUGeb
	t41qP4c1Zx7f/H90cvW0KvaDmt0spprj/yZyhuwjXvlgFYBru9BSTEi2CgSQodBSo2q0miaHUFj
	eQCz5tUFIZRYDWcyovp8pbA40ptkBegMLAbFhzsI9e2he+yXbCVLRXxUF4wKz1O1pgAM6UCS45h
	SWOrloGJ5dXcBq5QBBp6GloRbs
X-Received: by 2002:a05:6a00:808:b0:824:b181:f492 with SMTP id d2e1a72fcca58-82d0dbb0808mr2252746b3a.45.1775208614324;
        Fri, 03 Apr 2026 02:30:14 -0700 (PDT)
Received: from gmail.com ([2405:4802:8548:f4f0:ffff:ffff:ffff:ffa1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca4efesm5498889b3a.61.2026.04.03.02.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:30:12 -0700 (PDT)
From: buingoc67@gmail.com
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hmtheboy154 <buingoc67@gmail.com>
Subject: [PATCH 1/2] HID: multitouch: rename MT_CLS_EGALAX_P80H84 to MT_CLS_EGALAX_WIN8
Date: Fri,  3 Apr 2026 16:28:47 +0700
Message-ID: <20260403092848.10223-2-buingoc67@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403092848.10223-1-buingoc67@gmail.com>
References: <20260403092848.10223-1-buingoc67@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: hmtheboy154 <buingoc67@gmail.com>

The Dell Pro Rugged 12 Tablet RA02260 uses an i2c touchscreen from
eGalax that exposes the same HID_GROUP_MULTITOUCH_WIN_8 as the
P80H84 and also requires the same quirks to make multitouch work.

Rename the class to MT_CLS_EGALAX_WIN8 for more general use.

Signed-off-by: hmtheboy154 <buingoc67@gmail.com>
---
 drivers/hid/hid-multitouch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index e82a3c4e5b44..9e46028746fd 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -235,7 +235,7 @@ static void mt_post_parse(struct mt_device *td, struct mt_application *app);
 #define MT_CLS_SMART_TECH			0x0113
 #define MT_CLS_APPLE_TOUCHBAR			0x0114
 #define MT_CLS_YOGABOOK9I			0x0115
-#define MT_CLS_EGALAX_P80H84			0x0116
+#define MT_CLS_EGALAX_WIN8			0x0116
 #define MT_CLS_SIS				0x0457
 
 #define MT_DEFAULT_MAXCONTACT	10
@@ -450,7 +450,7 @@ static const struct mt_class mt_classes[] = {
 			MT_QUIRK_YOGABOOK9I,
 		.export_all_inputs = true
 	},
-	{ .name = MT_CLS_EGALAX_P80H84,
+	{ .name = MT_CLS_EGALAX_WIN8,
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_IGNORE_DUPLICATES |
 			MT_QUIRK_CONTACT_CNT_ACCURATE,
@@ -2246,7 +2246,7 @@ static const struct hid_device_id mt_devices[] = {
 	{ .driver_data = MT_CLS_EGALAX_SERIAL,
 		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C000) },
-	{ .driver_data = MT_CLS_EGALAX_P80H84,
+	{ .driver_data = MT_CLS_EGALAX_WIN8,
 		HID_DEVICE(HID_BUS_ANY, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C002) },
-- 
2.53.0

