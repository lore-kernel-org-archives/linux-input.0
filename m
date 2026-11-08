Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794157289;
	b=d2eP9a7nCblw4E3M6ksWRoatk/HN+75bJpfAsfph99ybt8t2pYpTpHYmBoYrwVs6PUbJ
	 Wo0aAY2jmsGSJK+G6KHpW5H/gDxAp1hcWAMi5H+7MPcgoPoBDcd5eIms2ZRI++56jW5QZ
	 7OVfcev6W6YYUIdvoIYK/ht6JerERTlk73ZTIRm1xvfJBp0QcaNA0D/8pFTbBkyGC9KiK
	 q1ZZjp1auhJz+mZQEvHmIA0WgLbe8TJsECv7S64RK4TopVaKvokprOwo4t4u5eouN1E49
	 sEKsNJbxmzlTsRt2G/6F6V8bMWMbZxsNYT+jgA4cw4klpOLFjBRzQu1Ae6NfqLOoHUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794157289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MKAsdM61jEKpMz5ct4iTIv69NuCExeCV+YQaZKReenY=;
	b=UlEyWm+OvebyxJdPR6YWhf5zrcGsm88ViiThbQz9fUjWwy13e1Bfz+0nZ4Tz184r+WPT
	 aHoa6U0ATcSuyX9E02Zjnl1UaLE2JTQ7BteWY1JdIKvrri9gZ/5GFBFk13Nnjm5d+5aT1
	 dOdKVCu7M2/erRqd3717hbWtwwRC6IvJS0W/gXRx6GAqN+Hdp3DNmO+PbR+aAIFesuOkn
	 iDATT7547biqdAvVSGcINQmA66fxj1QyjjExMUsFINZdCRa95DIzCd+xPuY4e4z/RxV+m
	 od0KzLtZK5gm7fuaEO2RrrRalfW7vo4BonSEAb1uYq4/WVpvD/k1Q7dmLNFJUpkbaiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KwxileHU;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFEA606A31C
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 17:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CFEA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KwxileHU
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so122588f8f.3
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 09:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794157287; x=1794762087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MKAsdM61jEKpMz5ct4iTIv69NuCExeCV+YQaZKReenY=;
        b=KwxileHUBOBOkNi0x5NZXbmqqar9DnxxCbZZupNwCn7rNnStgzlEM2C7cLE4UOu4I9
         +NNv3RrmFHRODVskXSN93O1QQfimDrohWnNfz6GBiabJBaZzsleQH4FZzwY9E5/376Av
         RczE9iTbokYmC2WEaIMu8edYQcW+QNvvTVlYdZ33tOjCzkKlrPCpGXUog9QBUZYAt8qB
         9QoPo6ZLRjHig018qSjgOlufNERoEP8cosJNcC+PWB+mpybPjTD+T4svS02mpPmQKcES
         r046P/DmhH8GDaC0glafUAv4x94XHAjtX12sJgE612tf0ohlAXpd4RcqjG2G5Bk9gLdv
         eoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794157287; x=1794762087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MKAsdM61jEKpMz5ct4iTIv69NuCExeCV+YQaZKReenY=;
        b=XkPQz0llvqFT2E9R3LDlDv9zFcn576Tp4rcAAT0fC88l9EYtfAt+nR4NM3j2F02rdm
         1PD7Yd5hN1xDL3vILM5qvy1fvy/ihE8SGub6sIscRgmXkIDpO6KseDO5zC2xvYilK5HL
         bl+TDOYszJhMHba5ZDoUEQFCxeSiqonsoz8kPFvFcT7jY0Jyv70sM4PFrq03FSymF/Sx
         Gjm/7m/UPwDWn4BPRM/SEPic6Uanuk8Uf7wcUVL/o1Bzjd046X4YWYOcWX+d5xoNPxHx
         Z39jJUgYwNhx/GEwB8ibH9SZ0r22tO7tDhKFBaLjX7r87afdLfgeYfeayEoO9Nv2Hs9N
         X6yQ==
X-Forwarded-Encrypted: i=1; AL+hErEwibZDZSGvsd48fGt0a6/91Bnwf0Z2qwG3WWgMCKQrbCEYlXl55fe3cQuiZvaKJ3PHwWhrcR3AY8VssQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z94puoVe77LLue+OQgBEJtd3lLj8LmQ611bEfvTg0sKAFRf8+CJ
	Z7yh1BUXXRyqnWQxGmaJhGiJhYv6TdKHNmHtjAscOH71qI1Lkffm0ri8
X-Gm-Gg: AYBFou398vdAp7iBGRPImw3jfAqSVre6FgDeZITMSZ+M/8hrDwNmLPtvWeU4dhYG+Ie
	9JNEIj0ILXGJbHxae3SrmGWYyvELTJCOoWdoN0vzaQKI7dfhFjzGiefcuxluZ+TDPXYE5QXRLrJ
	stoh5MTV7d23mJqSmJkhmgO5IaSojKoPp1D9v6lCobaSCbkmkLINDj3MuK8ZP4YXrV4Aj6iQH2u
	pcSwKlpTjB6zauylMyhS2NwdnRf1ufSd07xIf5oIT7h3LxjCs6M2YS8SxflQEucHG/KUWiTwsMg
	LUSYLoBnjHY+4/xgIJt2FXOHb4FBU9nx1uC/4Px3qiPLy2Dqd6ZBOJfKV9hvmpW8cbbsC6ndkij
	4bDo3lCjaSqGl0qU1h4CtbSd4DVf3/WASLlFC52mIYW7r5M0aaD+vO7pJm6jz7T3jerM6HJMtIm
	MEdZs8PUP0pkv5K9OGUHpZFKfkwMmyypHyX/gB5bLpSKN+k0+AdKKldQfRuq15LhZaGkgkRmr00
	4ewCpveEtQjmTJqkVUzwGR3J6mhrxRh6jVMEzx7Y/AikFLi/oUHZ6FNZG3a7AvhKMOelqV1j181
	TNYn0hsdiG/BbP3hHRiJkUfG6ns54w03uo91iwp+F0jundCxW5CUEnjYEOzQL37M8ijwWQ0CxEW
	WgQ2GRWSB70mF7qT+nbGswgUhhY/31lDHKOBs6EHmkkEMenVn6MwRR5+kq9SpBFLGnDi5KnesZO
	M=
X-Received: by 2002:a05:6000:3101:b0:48d:f541:a6e7 with SMTP id ffacd0b85a97d-49583cf6446mr4349143f8f.40.1794157287520;
        Sun, 08 Nov 2026 09:01:27 -0800 (PST)
Received: from sffpc (62-178-153-192.cable.dynamic.surfer.at. [62.178.153.192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49596f9ab09sm4766328f8f.28.2026.11.08.09.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 09:01:27 -0800 (PST)
From: Michael Schwarz <michael.neero@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: lains@riseup.net,
	linux-input@vger.kernel.org,
	Michael Schwarz <michael.neero@gmail.com>
Subject: [PATCH] HID: logitech-dj: Add support for G915 receiver 0xc541
Date: Sun,  8 Nov 2026 18:01:17 +0100
Message-ID: <20261108170117.76927-1-michael.neero@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Logitech G915 keyboard has a lightspeed receiver with a product id of
0xc541. It seems to behave like its smaller brother, the G910 TKL which
has a 0xc545 receiver.

Add a definition for this new receiver id and a mapping for the
recvr_type_gaming_hidpp_ls_1_3 type, the receiver now reports battery
status of the connected keyboard.

Signed-off-by: Michael Schwarz <michael.neero@gmail.com>
---
 drivers/hid/hid-ids.h         | 1 +
 drivers/hid/hid-logitech-dj.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 91319aa65..755fe536e 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -986,6 +986,7 @@
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_3	0xc547
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_4	0xc54d
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_5	0xc545
+#define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_6	0xc541
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_POWERPLAY	0xc53a
 #define USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER	0xc548
 #define USB_DEVICE_ID_SPACETRAVELLER	0xc623
diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 6e8db01d2..230abff5f 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -2114,6 +2114,10 @@ static const struct hid_device_id logi_dj_receivers[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_5),
 	.driver_data = recvr_type_gaming_hidpp_ls_1_3},
+	{ /* Logitech lightspeed receiver (0xc541) */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
+		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_6),
+	.driver_data = recvr_type_gaming_hidpp_ls_1_3},
 
 	{ /* Logitech 27 MHz HID++ 1.0 receiver (0xc513) */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER),
-- 
2.56.0

