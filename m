Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793230228;
	b=pFJaSBg4HjDsvAAVZhAdk5hY2me96Be9eHlD2N2Ab87/zlgqraVh1od2DIrpOezyFB92
	 2/dBzoCVPLDMZy/tJLlXrph8KH6ArcwWz+UU+h55RmZ28Xg5mivZSaHaSHUGhYOPNkSbG
	 z3KUs/myL+cG7vG5cqncdY1gQI73KhMDaFDCX2rzTUvCrxXVoP+KKXBGYIZMSmTptqeOG
	 s3bIPUfDVhZqujEPBxEuxjciDhkJwaTcuhi7phAcr1AG/9v/WF7zv7y3n0oDCAite2HTH
	 gPuCJVYhVCfSr1FjfKur94/2HBeHm0KJtfyRM4xrto1APN2FROfWT4mtFXBQD5/2sFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793230228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ib1ZcMXput/XpyZyTI5HHPBrtgceutvMQD9cp5NCdq4=;
	b=f/xCzRm6PWuebRx551uNDQifW6JEyFAuI1hjiAaKmAtpaWyHJ0O5hLfd7/wqbMCprFma
	 BsQddGtjUMjcZQok9FMfAGp1NR8ggAzDxuhSSmWt773M6Xt7ri3ViK0VI193ZT3S/iDiP
	 ydkxYm/si8Km0eubS64KslAcSJa5nwfGCN4OaPY+UWe4FxekEDMztM62xGFoD9GGCAcCu
	 HC7KcTtwceVYOIbvIgIzovAB69OOvY9e1QqXn6ghSoYu8B3LF+/TY2i1XnCcWUrBq4x4V
	 T4lt07Go1zFrbC/XyihfTFCImIMVqxdcAFoHjG5gUFbZk1OxbrklYO5T/CR6k4HGxQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yXeG5uCB;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B51606A31E
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 23:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97B51606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yXeG5uCB
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso10510695e9.0
        for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 16:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793230226; x=1793835026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ib1ZcMXput/XpyZyTI5HHPBrtgceutvMQD9cp5NCdq4=;
        b=yXeG5uCB6sRZpQ2nDhZmmvZoTKhj5pO47nqFEZiDlbytbYjS9u+1wOMClNnQj/KXqL
         VqpsowpPLsBhEKCL43lXCPjDwvz++paymk5nlmN9tVh2NnR6ycgGqOApYNM8vFzGXgYM
         32GbVKxb1l4OGk39LtgVvrTUL7BUSTzVwM4HnhqaiYk2hvqEKdzQohDzx/DAxLcUX9rg
         h8ndPczKO97NdhB1/ab1GrPSlIT6p6fzTkWSjrOHdgcfC1Ksoadz/MNyVK7gp7j4iH6u
         DN51abFnRVezKisb/kjx/R50K2gfYbBUvE22laYeCMDzM6c96kuhTCYR8Y2WEqXlKXgG
         P7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793230226; x=1793835026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ib1ZcMXput/XpyZyTI5HHPBrtgceutvMQD9cp5NCdq4=;
        b=CUTFe2ZMWy+t863oO1z1v7Id8IlSqll1a75Y22srnjmsa66VRZzkxzN9GMmhHNcJrP
         /qu9ms1FY0biY3f/yFentmLteGQaFlMgq2QOBA8tG+bJoxTJFPiT6aCgqBWMHDbcheOB
         rh4L0lsmdgu/7/hgjSm1PIatkgIQsOw/RxS4CTmr74BtAga4HMkKWzHevGvJEAzL83bK
         xaBGWLGOCVfKscsIRdsPt0e+xr68c/it/obEaWz2yrLrktw61wH1LRqv0G3wi1l0ZQGP
         KvHNu6Tzc2ObMCYcNKcqZhoZc+WursJOJa0yYYt6Q0jbN9wORI2E1WjP5KyjVR/FYAy1
         6cyA==
X-Gm-Message-State: AFq9FYIaHjDeBYZ0kdRD8bT3flsYemM7ejk3qk42Lascl2m6A4KpR2hk
	P6QGmlSid9vPOWU9B9T4x8A/Bp864HBAvu+8MCuoqC3AbwYX9/KNs8/t
X-Gm-Gg: AYBFou1vtj8mGxEm4RRRqdtfegruexMA2d5mPsjFOBK8WuYblPiajNnZu4Iy3rP6UUy
	vBsKM2foGyCGgsWgDa3OAATSrPoNbDowY6x6MvsE5VbIPhXufpivobC0/aIF4BCt+TXwlTTvMHK
	ek/vD68NCACXOwS6JRRsCEle1XL0R5d8+54bnBe+U99iPPu1GLWPtV1RxjKAaQPbgsSvEESenmy
	lbYf9IRymPEIf2sUscKTR/dehlhYYrv9kvP8c8jw3gbhcL6BkjC0xYV+6Qk81gMm8DDolmLmzHy
	JqRSwzsBFOgA+mNe5JjB3OEJSGInOB+KSCE39hwPV63758HjLGG1zOjKO/Rd8XpmhoqZn4Lo8DB
	/KXZ0jV0YkumsDzoA0Guf/e1KNYQjqA0W8v/Ptug+zT21b43gqGXVOBWlnfnazyoFZDcMWvnSXh
	VRsu2n7zcirHyBw4HdmDItVPC/bXsfIxBp0U0LXvwkZwr25gBnr2dyWf2aW0i/Yv/bQ1X+BHn6i
	XtXWajUjV113xAMai5zRUDDs8h68GsEVdlbw/gLoMrWmz4lDqrEUr/628olF+mNY3ZXQITfZvUh
	VwVggbE1IfsKoA7bMH7i
X-Received: by 2002:a05:600c:a48:b0:4a2:1196:db0e with SMTP id 5b1f17b1804b1-4a9678c010dmr83851295e9.30.1793230225943;
        Wed, 28 Oct 2026 16:30:25 -0700 (PDT)
Received: from cachyos ([205.147.29.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a92e104d8csm48192785e9.0.2026.10.28.16.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 16:30:24 -0700 (PDT)
From: Viktor Sharha <vsharha07@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Viktor Sharha <vsharha07@gmail.com>
Subject: [PATCH] HID: quirks: add ALWAYS_POLL quirk for Keychron Link receiver
Date: Wed, 28 Oct 2026 23:29:45 +0000
Message-ID: <20261028232945.20169-1-vsharha07@gmail.com>
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

The Keychron Link 2.4 GHz receiver (3434:d030) exposes a joystick on an
interface of its own. Keychron's Hall-effect keyboards, such as the
K4 HE, send a burst of joystick reports on that interface every time
the user switches actuation profile, even when no profile uses the
joystick.

Desktop environments do not open joystick devices, so usbhid does not
poll that interface and the reports are never read. The receiver then
stops delivering keyboard input on its other interfaces until the host
re-enumerates it or the keyboard is switched to wired mode and back. A
key held during the switch also keeps auto-repeating, because its
release never arrives.

Holding the joystick device open, or booting with
usbhid.quirks=0x3434:0xd030:0x00000400, avoids the problem. Windows is
not affected, as it polls every HID interface.

Link: https://github.com/Keychron/qmk_firmware/issues/532
Signed-off-by: Viktor Sharha <vsharha07@gmail.com>
---
 drivers/hid/hid-ids.h    | 3 +++
 drivers/hid/hid-quirks.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 91319aa65..856181478 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -802,6 +802,9 @@
 #define USB_VENDOR_ID_KENSINGTON	0x047d
 #define USB_DEVICE_ID_KS_SLIMBLADE	0x2041
 
+#define USB_VENDOR_ID_KEYCHRON		0x3434
+#define USB_DEVICE_ID_KEYCHRON_LINK	0xd030
+
 #define USB_VENDOR_ID_KWORLD		0x1b80
 #define USB_DEVICE_ID_KWORLD_RADIO_FM700	0xd700
 
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 793db001a..d56516aad 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -116,6 +116,8 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_INNOMEDIA, USB_DEVICE_ID_INNEX_GENESIS_ATARI), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_AULA_MINI_60_HE_PRO),
 		HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KEYCHRON, USB_DEVICE_ID_KEYCHRON_LINK),
+		HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE_ID2), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M406), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M506), HID_QUIRK_MULTI_INPUT },
-- 
2.56.0

