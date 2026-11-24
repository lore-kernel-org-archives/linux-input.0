Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529622;
	b=XTgZub5o56J2eiJ2N3WHwlMTCtI7GEQeYGOSenb5XMQHxYYrWWH9Nk3ARfwYHScNLQAz
	 Asd8zoXotkK4LiVAknnFn33VUV5ct0kgbfiMVKin9ekxNXtyD0+T3SbCXSf8W2Fp4Gwc4
	 lsJddWQCIhO2arEBRfapOuKDeMRuhiolTAGNSW1ZBGkGfOFOhdx1yJkBMEijmGN9Tix0Y
	 EzJVzKzMCUGDbtckA/sdeWGw4/SXn9fnsack26aVjkVG4yoS48ckhTTmXb0ZqzEX4BWsV
	 zvAZcZs/OplxkMgZiPIviNIcIY486y03EwQeybzP5QdTnMfec6u8qcwF3fRVSk2Pwyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WLhTI7zU5hqZsg8IeaK1lNb8A3A2MmWyNK3XItwQyrY=;
	b=aPKjiVsnRm/14fmW9jUX9hh0ji31p4Obi3FVDFJZgwLeQMIHbPXkdTHdl2a3QGi2zzRf
	 sqIHO8lyqfWYFT5O/GC49pUdcuyVPqmoGXqNjKd9NS4tXY+loowZMHPwAJjRMDAiUgJba
	 ZZW75QLGHN/ZCyYQPCZ784CEOIKut5LWRaJR2jI4Mw+hhAP8qnP/8E/en7yHRph8FjPep
	 EGwCDch0v3D08QV3OjXuec7rYO0cbkZZEGe6Ijv6J/6L7yZYtTQxmFnVjAsmS3qb9Psna
	 SBZpR47A528PoNEqFLmvNlgQeUY7QyQ3AfI8xjKoI5BCw3AvzpiXNpJNdtxDDEz5+vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=po0QsIyR;
	arc=none smtp.remote-ip=209.85.208.176
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B864A606A321
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 14:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B864A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=po0QsIyR
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ae25dcbd81so39196311fa.3
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 06:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795529620; x=1796134420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WLhTI7zU5hqZsg8IeaK1lNb8A3A2MmWyNK3XItwQyrY=;
        b=po0QsIyR5sR9HSp3kYpyJG0CWaZ7obmhjihqPtLvrVm8M3mkzaGNIMvw/1MCXr0T63
         KDsYMR5DeAdFebC1pmbT33UadJLnaWRRl0iJ57PsaCzOstJbJ02ywnkc34BcWvL//x2O
         EJe2xjyyrqbXJfSk0w0a7HDs5gWVupW0rf4YInh/sEzk+myEA2t8lnsbcz+0vH2zLwcN
         bGtWvhMstfQyVYIwIL0GJ9yNT9HEUT5CufCO2REZK7r02MrS/IP6kyeELcaDES1A7VSQ
         WidSNET6s3cLdSg1WbzWtL8GrL+UJzDREzCB5TrIyfNpk5DvKAPf1HKI4H54yTho6UEf
         efNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795529620; x=1796134420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WLhTI7zU5hqZsg8IeaK1lNb8A3A2MmWyNK3XItwQyrY=;
        b=Axd9lmV7smvrLXutWY5K2+4r2X5Jzu/Bx7e5m8w6iCV31bgl6hRW3Brn/LhGR/oWNv
         rxPWHoCQdTl9t61IbhLBAfEKhltxXi+aKfHoecioyxNO/ZtJ+/HV1B3zZP+2mLOst3Nm
         ctZO0StGKIl/QLMA6rLCDXm2er+ED/FpZZqrE3sigZnGHWXJr2TFez3hP4nm1pJzKFxv
         WkkGm6ptBKJuGui+KDDR+4tTPZqg9+g6zdcTdY8ufk438WqFeqKYnfZhrY5pG+yc5U5e
         5zfU+jI232yOQ0qJ1nygkokYPUCD3ZUVqu8g6kY+TTNr/ePAzBToHYC992w45u3gSv8w
         mOHw==
X-Forwarded-Encrypted: i=1; AL+hErHdFAaeGOxO6I8kECAXuhQ2hregv/+1CvxU6gYmu6B3nAyb/sxS3HvUKCKSrNmnm/42wMZo0L++N4zcGQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Yb72mf3iX/aplqwtTAEIwXoWtWjaN5tGddUaxHw2i2u9G9LX0
	xaRF55L0as2YE/Ft23XqLxNdZpOmIwsWBPeyQw0O+X9WJc4Bfdv6g9R9pDvlKhjT
X-Gm-Gg: AZFdTZcKrQG3abQJYFzvITGvF0CpkKs5O/FARIyMP7007nCSHcg6xi9jHFK0bu1vesn
	XgoX9ft1wymsLigXqO/633WQZMSxv+MVqQvHsogCQCWUDO7Iwt5ujPn//bBdMVaISCSyAKgaHzU
	dTSqgPQKRCu9R7wHA4DUt+RWQ4sx44qAJWjPTmcYfXN2jfEWo7TjxAEmLTnc+/RljR77BjB63ym
	XXlrs9FFRS/v0TsEcrrL4CFrMoWZC/k4APVxosMIAwhHWgQ74zqzujzZkhiMUaNvFprjC6+JZT6
	3TgGxBlVV/ZcbnkBvNXlQd3ijHNXgSpRtiMLkh/pquj9QkmxiJIVdIE6ZUbeQunFZNLqqRwuUvQ
	AzmAvSFB5gNeNFnkvHmMkKHOchM/GVFgao1VXZPw1lN+W69UTNXEE6q63SUxMMJZk3ijJRZnq6g
	YOuZ/rdV7dNztRiUWiCVNPIdIWQTi7NZK707d3t2tHmo+9WuZ61JnOsK6v04ztdmv/v4bQWLMjB
	S5pDpGYt29Y4C0KzFnM90B6sZTOpMpSTclsxGd2If4JfCpoPTgOGx37URe3kSGLrOqVigF5IXLh
	Mh1payJFSGusoT8D
X-Received: by 2002:a05:651c:2103:b0:3ac:ff0a:9d9f with SMTP id 38308e7fff4ca-3ae7f9ef3a3mr41214171fa.5.1795529619590;
        Tue, 24 Nov 2026 06:13:39 -0800 (PST)
Received: from pc-i7 ([192.3.12.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae80536529sm41169621fa.27.2026.11.24.06.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:13:38 -0800 (PST)
From: Aaron Ma <mapengyu@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Nikolas Koesling <nikolas@koesling.info>,
	linux-input@vger.kernel.org
Subject: [PATCH v2 3/3] HID: pulsar: add support for Akko Gaming Mouse
Date: Tue, 24 Nov 2026 22:13:15 +0800
Message-ID: <20261124141315.6745-3-mapengyu@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124141315.6745-1-mapengyu@gmail.com>
References: <20261124141315.6745-1-mapengyu@gmail.com>
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

Add USB device IDs for the Compx Akko Gaming Mouse in wired mode
(3554:fb29) and via its 8K wireless receiver (3554:fb2a). List the
mouse in the driver header and Kconfig help.

Signed-off-by: Aaron Ma <mapengyu@gmail.com>
---
Changes in v2:
- Drop "8K Receiver" from the driver header device list.
- Add Akko Gaming Mouse to HID_PULSAR help text in drivers/hid/Kconfig.

v1: https://lore.kernel.org/all/20261123141542.8128-3-mapengyu@gmail.com/

 drivers/hid/Kconfig      | 3 ++-
 drivers/hid/hid-ids.h    | 4 ++++
 drivers/hid/hid-pulsar.c | 7 +++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 2481bc01c435..4c3cc2339f59 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1375,7 +1375,8 @@ config HID_PULSAR
 	  Provides battery level, voltage, and charging status
 	  monitoring via the power supply framework.
 
-	  Additional supported devices: Kysona M600, ATK VXE R1 SE+
+	  Additional supported devices: Kysona M600, ATK VXE R1 SE+,
+	  Akko Gaming Mouse.
 
 config HID_WACOM
 	tristate "Wacom Intuos/Graphire tablet support (USB)"
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 91319aa6516d..47e4a9cecad4 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -75,6 +75,10 @@
 #define USB_VENDOR_ID_AKAI_09E8		0x09E8
 #define USB_DEVICE_ID_AKAI_09E8_MIDIMIX	0x0031
 
+#define USB_VENDOR_ID_AKKO		0x3554
+#define USB_DEVICE_ID_AKKO_WIRED	0xfb29
+#define USB_DEVICE_ID_AKKO_8K_DONGLE	0xfb2a
+
 #define USB_VENDOR_ID_ALCOR		0x058f
 #define USB_DEVICE_ID_ALCOR_USBRS232	0x9720
 #define USB_DEVICE_ID_ALCOR_MALTRON_KB 0x9410
diff --git a/drivers/hid/hid-pulsar.c b/drivers/hid/hid-pulsar.c
index b3f15ddeb39f..aaacc0550f9d 100644
--- a/drivers/hid/hid-pulsar.c
+++ b/drivers/hid/hid-pulsar.c
@@ -14,6 +14,8 @@
  *		- VXE R1 SE+
  *	- VXE
  *		- Dragonfly R1 Pro
+ *	- Akko
+ *		- Gaming Mouse
  *
  * Copyright (c) 2026 Nikolas Koesling
  */
@@ -59,6 +61,7 @@ enum dev_type {
 	TYPE_KYSONA,
 	TYPE_ATK,
 	TYPE_VXE,
+	TYPE_AKKO,
 };
 
 /* ----- structs ----- */
@@ -759,6 +762,10 @@ static const struct hid_device_id pulsar_table[] = {
 	  .driver_data = TYPE_VXE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_VXE, USB_DEVICE_ID_VXE_DRAGONFLY_R1_PRO_WIRED),
 	  .driver_data = TYPE_VXE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AKKO, USB_DEVICE_ID_AKKO_WIRED),
+	  .driver_data = TYPE_AKKO },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AKKO, USB_DEVICE_ID_AKKO_8K_DONGLE),
+	  .driver_data = TYPE_AKKO },
 	{ }
 };
 
-- 
2.55.0

