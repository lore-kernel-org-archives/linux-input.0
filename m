Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2DB3A9001
	for <linux-input@vger.kernel.org>; Sun,  3 May 2026 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777793234; cv=none; b=KQ4j2MUItRe4Fyrghoc02cmMeIvjDeAMa0wy3Vll7pk/slTxLs9C2K88l/BwuF4KhwEk9fvvclVEk3wjmCQsgTz8Ie6lDHO87pUQI6BtM0A0c6PJp0Pib0xSntJ8w4PCJr6bNkz8ByK3xd2OklVYW4QcXrm5wjaHDqHoXkA0Mm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777793234; c=relaxed/simple;
	bh=Mz+1pplQ0JIsxE7949cAUpL6y+IvtSik4EpUdewqA24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShnaiKU3B1mb+aOmcbAeFVpHYrNAXORncP5vpIiat1mlIDdFiOTfjNHotEHg953pwDEOWOPMAItDAPPhcSJ2m930XnN4zNw4MbQzDApt8bw8ziZv9g7EJIkRubxnVK2MdhB6QQHJHitTaQp1ax3qskg54hbrsPJ47QSvrGMxJko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csb2zVQ1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csb2zVQ1"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b788a98557so26766855ad.2
        for <linux-input@vger.kernel.org>; Sun, 03 May 2026 00:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777793232; x=1778398032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTEfk4Xq7IA6AAhVE3/F26Caaw0jUui+q3LfKcseDq8=;
        b=csb2zVQ1IFT9pQ2effwko2T+Nl9BWkjXsPRwe43B96+jWS6/z/zT2xlLZasrrhu5nQ
         SyYPMaBEuenaxsLlLv6QaHegZ2y9S7QWNOiDChbnSgSsAnxRZ/uJC0YmtVEIjpXQQ+eQ
         3kbizxK584+t7La8mDd2LYMOCZ5FI5Oimzn1UIlN/xQSRXLCXImeIagVHe2c3Jps+aLN
         c9mD1OsLhnA7dVYfWWep62Q13/BM+9531qy5ef8OiuacU4ytg3ha9M9uf58u4s74qfPA
         qYISvWwg7/kI1+4CW0odawvE61wMbko1rTRarBqrULjP1F1aKL9OpoXk7bpqtPSBrDib
         9ddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777793232; x=1778398032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vTEfk4Xq7IA6AAhVE3/F26Caaw0jUui+q3LfKcseDq8=;
        b=FgCSdn3BTtHOztXRGpcy10foKRViL3MZvqbyKTAHyn1WfixeEJBH+RlZ9ccMcwTGEE
         QEbd7YeIQDgIH1NelKIU9rCmaz4QRjEVaO7wXQ7pOm/GKGfNaff8ms66SwW0g01kCKQ1
         dTCuZ0ZZ8MicWFwaLwuh2+0FN1ZAXtxbxa+ZWCSKM90AlIJiQ0Q310mrh7yO//x84yrT
         iW9KOuddMrBTdAbwwKR/FcYE9mgFwHF51e/U9/tutS0FprxQ/AzsNXLXxTlmC76/WSEF
         ggnY3V20s9t9MBsFIxT+nHca1MWzpSbvJiNZxzWnzlJETArl5+gv0UBa2Pr3WbuCKWmT
         YiSA==
X-Gm-Message-State: AOJu0YzbNJXD4TTjTYJAeslKDsHroKK3zz4uokPI0581UBoMk4sqUenY
	3NEjo07qIA2EM97cWL4a9QHKLJ7u5qA95xWXMV8+kEshWL1tzaK9XW/G
X-Gm-Gg: AeBDieveWiyzR/IEbjyMLGwGUePY3Tw8mvfr6HnRTbBNxQk1iwfvQu65+3lrl99kxsk
	3qt3hrIKD+qq0h0gT9ixlnwzhthOnIeZK8JXuM2GcljnapJLqkXmBRIB1T66gxFdZO0WyJRYfl5
	91LV0s94BYWcUs3FPAZ1FSK04l5zQuXju6m8oAcehB4NilXbDk8S1yFYpVtrFQyz5fnfxwdAfhn
	S9UK3nnkJYmCrqVZL5qQu4u4xyIQcTCLLqM38d2zmGod/3wljON1FjA9Qloe/cXnsDVaOeRUiXC
	p7sDQzP1LtjgJkwvCQaCg9r1qqHPAASpON9JeGAulIjewNXg5n8Ns986Z+qt9+sz6B5wQSIlAMO
	8C7XkistjFQl/mLRdU+quS1ZsjUzoVzwyPhpF9dDo0KqHa8V+W8PJhTykYMnRtKDz6rIYy4Nx4S
	AG+awoV/BCCa4iFMFATpU76lHBp/5l/xoGxdgDlNNSvRntd4zl5TxlRNB9tcz3mI3qVmUktA==
X-Received: by 2002:a17:903:1ab0:b0:2ba:1202:4fa8 with SMTP id d9443c01a7336-2ba1202518emr12938835ad.20.1777793232110;
        Sun, 03 May 2026 00:27:12 -0700 (PDT)
Received: from tranquility.wa.lan (60-241-74-71.static.tpgi.com.au. [60.241.74.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae16a9esm64942945ad.50.2026.05.03.00.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 00:27:11 -0700 (PDT)
From: James Ye <jye836@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	lee@kernel.org,
	pavel@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	denis.benato@linux.dev,
	James Ye <jye836@gmail.com>
Subject: [PATCH 4/6] HID: multitouch: add support for ASUS T3304 media keys
Date: Sun,  3 May 2026 17:26:41 +1000
Message-ID: <20260503072643.2774762-5-jye836@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260503072643.2774762-1-jye836@gmail.com>
References: <20260503072643.2774762-1-jye836@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Touchpad functionality already works with hid-multitouch, but media key
events are emitted from the touchpad interface. Add MT_CLS_ASUS to
handle these, and also add missing key mappings.

Signed-off-by: James Ye <jye836@gmail.com>
---
 drivers/hid/hid-multitouch.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index e82a3c4e5b44..a49930496c5b 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1510,6 +1510,10 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		case 0x35: mt_map_key_clear(KEY_DISPLAY_OFF);		break;
 		case 0x6b: mt_map_key_clear(KEY_F21);			break;
 		case 0x6c: mt_map_key_clear(KEY_SLEEP);			break;
+		case 0x7c: mt_map_key_clear(KEY_MICMUTE);		break;
+		case 0x4e: mt_map_key_clear(KEY_FN_ESC);		break;
+
+		case 0x86: mt_map_key_clear(KEY_PROG1);		break; /* MyASUS key */
 		default:
 			return -1;
 		}
@@ -2145,6 +2149,12 @@ static const struct hid_device_id mt_devices[] = {
 			USB_VENDOR_ID_ASUSTEK,
 			USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD) },
 
+	/* Asus T3304 */
+	{ .driver_data = MT_CLS_ASUS,
+		HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_ASUSTEK,
+			USB_DEVICE_ID_ASUSTEK_T3304_KEYBOARD) },
+
 	/* Atmel panels */
 	{ .driver_data = MT_CLS_SERIAL,
 		MT_USB_DEVICE(USB_VENDOR_ID_ATMEL,
-- 
2.54.0

