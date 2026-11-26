Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723691;
	b=4AvJiYDbMkhuoPduC57iMVnwJeSBa5PTds4mDabT2OrO62d8xFhrKcuVrxrzNOi5eVtf
	 3sy61hY63Q7Gjf/gd33xZBlAwVpfQ/gOFLzebi97/hS1/7jf7PZ7BnvvEhMErmcEYei5g
	 HFq4iQiB18xQYB5qzkd0hGMFyOPn4nHTgTu2hJVDskj+Z7PXouiqIxtkevhES0UA8vmSj
	 DzMSqqgxdCvr/YBhkabZzzUqsrj5PMH+4xpvZk29LUquqpMcORL06NMxwYKUfOr9wZzjO
	 24ySDo44o8LyP9IW6rPbm0jVlGG5C5zGf/5GQKnVGjRnVmL5oq/37URYsuLN63gC0jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=uLqWBBlD9sWHuj/q7x3/6dvATP1P6dXJhD0nvFViC8c=;
	b=hHvH1PBJklzUYgVLr8unm9CCi8IxWig1RXCsCU3xxRmiEQt3XiD/6qtsCKgD6rYrUiVo
	 S9pP2ZBaLmi7m6FzznN964VADvSrXkZd+1QKYAl57L98U4N1mgcQKKdW4nSRHia9hQyBC
	 efU5uOOgXc40nyo2fNYHFvWgqEb6F42K2mCuMsjZf6UCVoZVhwGvHnryajrhgY9tt5ZZD
	 7FSD7spx21x01ckfniuC49bT9Nz8R5h0v6eg3/4px7Wzm33/ZUdXg31jWWksFr7ZCYAtf
	 piWGo9wU6GbH6XP5q1kRgmo5WrT8Gj7NlUhtaK5OwYdd40WgVzXW89YNCNjfkU4TGSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=et9UYc6I;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA3F606A31E
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 20:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CA3F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=et9UYc6I
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4cac7a7d3cso1098446566b.3
        for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 12:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795723689; x=1796328489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uLqWBBlD9sWHuj/q7x3/6dvATP1P6dXJhD0nvFViC8c=;
        b=et9UYc6IVKul1QaHts9/mT2CQvZn3tQGTzj1HjxfgWwTOJIrSjdX2YJL59556Ifezs
         2fAD2qSc2MlAj9Q0I1+pTO9vg2Jlwubyv9KPUwJ/Ar85nkF+g57UvhO0Z/LOaUP2Qee8
         twfZlesxAybyrG3koc5BuyOuwYsjjDNoMwCH+UI3zzmeOjXpVJVs7pXcVk1amwQG96dP
         DJqoRsVAX7tyWdLJexvsIyeTbyL0FR5WDUfF7klz4qLf0G55GjxH1XjYverzz/XymrtQ
         NH8g8+zWyQs9w1NrefAjAeBZrttGmUtmqZaR4Lhv5ZxGtoZgBfxfAezcrcpm4YJn6hWD
         EfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795723689; x=1796328489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uLqWBBlD9sWHuj/q7x3/6dvATP1P6dXJhD0nvFViC8c=;
        b=Qgic93Qh+DH1wjwJBoXOINwtp1Kb4NSJGkJFPKyabdhbQPObXv+S73ErYON6Z5oBJH
         kw6HCUJO9xYw4ASwFxBKXCJy5zURXAEoFyQiKWulkPdgJZQh3NH8bIQXh1VmjrGGxBWN
         ZsGtoMf0PoRxg/6LJP3M9PFTWp+krvLH+HReE02AxRmtrhu15XOZnpV+K6Wpifn2EOOY
         nR0r88LtH8YIALKK/a/VG+aRVEdq+LkCGjvNUhFfi5OxIvlxvTjar2LrAp09OHJdPn2n
         +WPClYajy5dpkm52H8E1MCUQFVK7dZ8EJ025CNm+IABPj3IbuZZMRg3GLwrwcQZXTpmj
         SCrA==
X-Gm-Message-State: APuU4Z/mpwtIe/2Fbl398Gfak/RiynChd4ZmttIyrBR4PmkxbtpBXHMj
	4LIt6hzmj+2GOdZViyT9lQ12mWNnLBhsrm7XcD5+JRAAZ5Aq9p5Kh0Ly
X-Gm-Gg: AZFdTZe0RXv5ARB3ajjwgVBxSo5r4CGmF5qt6wcS85WSc1crbUKSW68azNgfZyf/YaW
	Ukg0sqEi7vNYukyEPmPhrUhys1mRoGjir3oPP/icfz6VkG0mr0EPrdju558KcOixUKv2DlfObp0
	fy0Kbc0iq4tABPkixFLuwgtB826FQnhPTO56QKI4iCnKg50OXDMWBAkN3GhjVKB3E9JQx/nqDg8
	yjF2T4zxi9AAzMyoHndnAdrQPiElDX9dvhDvPmYHCfUWOIasKh6Tpp4tU7B61usXO4LIQqFXUgT
	PlCk4gUBfDXB3uyEqFmX+J8oaeevE1rP/pobFhcbHKWxQ9HnhDv65sYLatCbP3FBN/RzuDwiCVW
	NRmCyBYQ9gZIKV9NGL250+MOvIexLTUvl5xHhA8VRYSR654UKnNwFoeX8nE+YFdBmXMs4vuis0R
	jCcLwpgJbrc+k6IeorX3ieKmWr0AhUS5QkurUCJEJDl5tvgc6+4UY+ewokbATmBO0u60I2opl57
	P5KS1eo78zaInZfaN6BrDJtqLc18+UhCWZ4yFhhsjJ4e+voKHEPPTzW4jzXmvkhJdxFdIHPVGq1
	ojdGWvCx3cxmX/Ix5FgDf8CQT2EMDjzjt6LPuVKunrQg40PHjhn1X2erxrRyGWiHFHOFSMdQrgz
	BerRrzfU8nVEZ/u2CcIfo8noBAWN5owx8+RgWf3937pEaa9+PFCmE1j045hGME0XBOcYir0igYi
	BH
X-Received: by 2002:a17:906:7ac6:b0:c40:4965:72bd with SMTP id a640c23a62f3a-c513a9ae10cmr1297992966b.19.1795723689407;
        Thu, 26 Nov 2026 12:08:09 -0800 (PST)
Received: from desktop.home.arpa (2a02-1810-1e16-ac80-898e-1938-27eb-b890.ip6.access.telenet.be. [2a02:1810:1e16:ac80:898e:1938:27eb:b890])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85fdsm799348766b.69.2026.11.26.12.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 12:08:09 -0800 (PST)
From: Stijn Cleynhens <stijncleynhens@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: quirks: add ALWAYS_POLL quirk for Ajazz AK820 Pro 2.4G dongle
Date: Thu, 26 Nov 2026 21:08:02 +0100
Message-ID: <20261126200802.3717356-1-stijncleynhens@gmail.com>
X-Mailer: git-send-email 2.56.1
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

The 2.4 GHz dongle of the Ajazz AK820 Pro keyboard (0c45:fdfd) exposes
five HID interfaces: keyboard, mouse, a consumer/system control
collection, and two vendor-defined interfaces (usage pages 0xff60 and
0xff59) used by the vendor's configuration software.

Nothing opens the vendor interfaces during normal use, so usbhid does
not poll them. After a while of use the dongle stops delivering any
keyboard input, while it stays enumerated, until it is unplugged and
plugged in again. This happens behind several different USB hubs and
docks, and not on Windows, which polls every HID interface.

The AULA F75 Max ships the same dongle hardware and firmware (bcdDevice
1.38, byte-identical report descriptors) but enumerates as 05ac:024f.
That ID already has HID_QUIRK_ALWAYS_POLL, and that dongle never stops
working on the same machine.

Booting with usbhid.quirks=0x0c45:0xfdfd:0x00000400 avoids the problem:
the dongle has kept working for several days, where it used to stop
after about an hour and a half.

Signed-off-by: Stijn Cleynhens <stijncleynhens@gmail.com>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c40d818417a2..cab0b3fc21e5 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -799,6 +799,7 @@
 #define USB_DEVICE_ID_JESS_YUREX	0x1010
 #define USB_DEVICE_ID_ASUS_MD_5112	0x5112
 #define USB_DEVICE_ID_REDRAGON_ASURA	0x760b
+#define USB_DEVICE_ID_AJAZZ_AK820_PRO_DONGLE 0xfdfd
 #define USB_DEVICE_ID_AULA_MINI_60_HE_PRO 0xfefe
 
 #define USB_VENDOR_ID_JESS2		0x0f30
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 39e93b1383b1..e7773c946bcc 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -116,6 +116,8 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_1f4a), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_IDEACOM, USB_DEVICE_ID_IDEACOM_IDC6680), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_INNOMEDIA, USB_DEVICE_ID_INNEX_GENESIS_ATARI), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_AJAZZ_AK820_PRO_DONGLE),
+		HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_AULA_MINI_60_HE_PRO),
 		HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KEYCHRON, USB_DEVICE_ID_KEYCHRON_LINK),
-- 
2.56.1

