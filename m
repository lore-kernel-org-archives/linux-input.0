Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488269;
	b=nvT2MHkt6Hw2v5Qhudi7wmJ+na2g3OxjuQyWaZn082ldg9IXUQ15lThZzBW1M2kYyucX
	 VJa8s9QJLROvFHE0Z/twndTaUnlYPRzvEoRo+d3TnMmpIjghYP7wca2zjy6ONbAvsIAZ/
	 ihbXFyOlpOpQME0W9zNkl04bwf3L0FEAX8nzZOUeqqYPDhN/8G/Ji6lBgzZGjQ+wogOXh
	 55h5tnu3QKkwZEtE/wCN5aTBfSiIXHC2btJygHarqlRCE1s05JlwYcw2cOISSLNrrxi8K
	 j5squzfupbwxW/BqXT8/GlNLir3M31dwAt4u+OrQ4MojtZXj2JcaMBsvZ29HkIMIzYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dVjbRfDBC6IhOA3xVvnHX/kj1Doa8q6i4SsVeUJtYdc=;
	b=yDF3/7EL0gD2FJJBrHsGMAb8DOPa24G+nRSJEPW93dllXerIlkVALCrHWa91maKWU0Sr
	 nYTnt+Dh/t4XDp3qpk9DR5xljDhBlFwC0Q2bwdJlmCD+wiYVBwQHuRDda/NbIbISGXhZO
	 Wha6nJoOcv4ecpfz0lbSd2LRrwn5y1+F4+T7aFLBINlRjji9RvHhu0NrAR6Huz0pd87OD
	 Y1ecNy6DY4dIhcGhAeMtDFbc9uVXufJ6HGvaouyL0lWE0SoGR84DpJbwCeGPtjeSnkuHf
	 k1LWuKIkxf4hd/4ozIqzomk7k5wZAphu9no445pdNXa7o/se99TpItPPzG/anhgJCAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XoSspQxJ;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C1D606A32C
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 09:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8C1D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XoSspQxJ
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1df4c0966so3161165e9.1
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 02:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792488267; x=1793093067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dVjbRfDBC6IhOA3xVvnHX/kj1Doa8q6i4SsVeUJtYdc=;
        b=XoSspQxJOZKWAjDyKhKqSgSK/Gg5Sc6cI2wXOnky0npA/YHyMWtGObjYHp0SX++sWi
         xJVzvkjg7QrcoDhgZ2HAYx+tYqGCmVZa9/3ZqdAsgTRlVy6plEZTeEG/bsU9kuOT0SOq
         KDLk3OF1Pi/uIPJOL7nB/sGVN4FCZ4ba2gvs3KbiH9Fv0AKORy1dfmLouhE+vbmPtojU
         W6rIl3r/6t+Rrgzou1begEUY5XB65+66i5FIczzAK/kuPC8pQnFIPbhMwS6lzgSgq2+4
         BTGERK7APFeABaXkSMZn0ijR+NyaEzPZJvbD7FS/IDI3tXWZW169MxXfHWk3uC5nf8U3
         SrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792488267; x=1793093067;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dVjbRfDBC6IhOA3xVvnHX/kj1Doa8q6i4SsVeUJtYdc=;
        b=tWVjbbe4ejGphB7rjnvL0so/YBUZeovd+3ort1ur20+VnLtwubVzWmb6BUH6CJlHeI
         4K2Ra/6Ffqj5LDRss5Kj5MNLfAz4BNvfSzzVHRwDl8dVec1uB4M9ZzyN+Z+rNsGsIZO6
         oZFI1f3ylAzIbUkSlkRmS0oG9rf9xkrEkjNh8jVCqjnztN0aSUW+ioV56Qzaw5jYIJMo
         scyrzMX/Agkc2CfFSOvAHs8ciPaHajAmGPRifcFm+qb+E8Rs5fEOkcRjVSA2DuC6tgRb
         9JX9Tt6FaGlijmtz8ehhebW+VgIn93sLTlD53+ErhLBH/z8rQ9OIHCFDcIwe6ijqF4tE
         c+nQ==
X-Forwarded-Encrypted: i=1; AKwUvBzgRaqdFEGB0ga3k5AaIqIyHnROlWtqHu/Gk5FgW87HqChqH1vlkGCJrDyv8E1IUvoOLvERx93FBAbA4Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYK06W7M7kMpavnOR3rvUjxjevtzL1yvb86nwhkY+Ph2rIXIpMNF
	T0xT6UXAgp/2jJFQMG0wV+T/km6JJa+Z4CXW7zcOKHo2wIo+0HpXdBTb
X-Gm-Gg: AYBFou1iH0Vyb9clEZeoh8elGGaRMyn1DJrPAM28l5F5zM87yBMshvcWP7WC6sz8kSP
	fJmDy+l2BChhal4slNU5y8H3FmYRgPGQ5zZh9J2Ifj7S4qSkc1XXhPDL/KC7tp7vJjYQz9jUJj3
	r9PtQYL7ZiGmyNuccclKcMJ82hfdhJry8n4Lbn47pdMTZSgfAOdMNHH4RiqOy2/66YKAEqF+/W5
	j4MCWtXV0yBHgJJXS8wIAPsmby0gSYDd0wbg2QoEV/wTaj0SVvXON6Z592nHYxj4v21QGUQ7R9S
	r7f9IsOn5X0xcHJYyXw5Xa5MZFaQDqI+ORefffM0HqbY63N7Lju4h3PDCf/qy3pGOrVLDWI9DPo
	X5HXm/a0N+7MrY5MYn2jdmPVIrBVca6TA7JrqVMAZqx9Zo6PuTPcT/wvWlBmznZAqk+tWiQZcTG
	wKm1oObr9ucuDajloJj0VPWgE/Nm+R5hDiH/puISFxxb936ekVk5tAsmPqHZqkI4nWysRijn3hD
	cXJ/OFk344Y1frZk67h021140MDgcmTXO+7rcRvCtIukCxFgTl+VCV68avycSFO2qI=
X-Received: by 2002:a05:600c:4455:b0:4a1:c6f5:2450 with SMTP id 5b1f17b1804b1-4a1f50a260amr29984455e9.17.1792488267098;
        Tue, 20 Oct 2026 02:24:27 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:f99e:1a52:655b:681])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2c242dcsm54873985e9.0.2026.10.20.02.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:24:26 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <denis.benato@linux.dev>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	Luke Jones <luke@ljones.dev>,
	Ivan Levchenko <me@livan.pro>,
	Nathan Chancellor <nathan@kernel.org>,
	Paolo Pisati <p.pisati@gmail.com>
Subject: [PATCH v4 2/7] HID: asus: Add missing Zenbook Duo hotkeys
Date: Tue, 20 Oct 2026 11:24:12 +0200
Message-ID: <20261020092423.36380-3-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020092423.36380-1-p.pisati@gmail.com>
References: <20261020092423.36380-1-p.pisati@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Joshua Leivenzon <hacker1024@users.sourceforge.net>

Map the Zenbook Duo "screen swap" hotkey (vendor usage 0x9c) to
KEY_F19, like the other ASUS vendor keys that have no dedicated
keycode, so that userspace can bind it.

Unlike the keys of devices with built-in keyboards, which can share
keycodes freely, this one has to stay unique: the Zenbook Duo keyboard
is a standard USB/Bluetooth device and can be connected to another ASUS
machine handled by this driver. Say so next to the mapping.

Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
[pisati: drop the MyASUS key (0x86) mapping, 2061075360182 ("HID:
 asus: support the Zenbook A16 (UX3607OA) keyboard") maps it to
 KEY_PROG1 like asus-nb-wmi does, and shorten the comment]
Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
Tested-by: Rebecca Mara Müller <rebecca.mara@posteo.de> # UX8407AA
---
 drivers/hid/hid-asus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index c2ba2d825191..54f4d68eecc7 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1316,6 +1316,8 @@ static int asus_input_mapping(struct hid_device *hdev,
 		case 0xb3: asus_map_key_clear(KEY_PROG3);	break; /* Fn+Left next aura */
 		case 0x6a: asus_map_key_clear(KEY_F13);		break; /* Screenpad toggle */
 		case 0x4b: asus_map_key_clear(KEY_F14);		break; /* Arrows/Pg-Up/Dn toggle */
+		/* Keep unique: the Zenbook Duo keyboard also pairs with other laptops */
+		case 0x9c: asus_map_key_clear(KEY_F19);		break; /* Screen swap */
 		case 0xa5: asus_map_key_clear(KEY_F15);		break; /* ROG Ally left back */
 		case 0xa6: asus_map_key_clear(KEY_F16);		break; /* ROG Ally QAM button */
 		case 0xa7: asus_map_key_clear(KEY_F17);		break; /* ROG Ally ROG long-press */
-- 
2.43.0

