Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793545756;
	b=HQBta+8i1lQ1YOHr3uH5jYp66Hl/ZPqC4d6T9YoiMTnz2Pdmbt515b+7P/MG4OtqvGGX
	 KKK4KNewSmw7WC7eX710GYOGR/FWH36vN2NbWrbTqy4BFiIYq02+eFMijVxlDMavhUHEh
	 eRcDc25bvARcAoiAkxfovtxLcBicYEAglCTCZUDcvdrhWivQvf+FODl41z+4xOHzGTEWx
	 +OmUc7zYk4swHnpyJMh/tV7lTnvuCALV59Al8KvVFAd9l8WxMOn0wTpL3wKhmmr5jQFI5
	 aDGeXs/N42RxOLF+oLqmrJE3F10Na+UwIL9HA7aeb9BmUaxt/L9Z8a0T16vMhDBwIwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793545756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:From:Date:
	 Subject:To:Cc;
	bh=r7sqR2vKS8k46feKmXGRK3DyHQiJEHIGx7m70vFc/3o=;
	b=DvQwJouxK452vhIVx6yq5D/H5qwWFGR/bn2gpUvooJbrzBAD5zu4FYUaYBQ8Urjkr0HQ
	 WLpYxNdNblYA9SW7umU2ZAwhStWxJy7nuBfMtfbXIfsOoErzT17ekNyHPsLQGIGcuAcCT
	 0AOFhp6DF/OnOgFcg33UlgsVqxDEcT2PDPRireXNT+w0JCGQDD3UHbECR7fkmaoakgaKW
	 BBhr5qGzn791Va54AtNfmdbtnOCDDVRtwxkdqmqeEeI92iUnKjuOOIIrKKgKogl7zHQP7
	 uMrFLi5Ana5iDpGWtsECC8ez6fIMVNlDYU0laeROVfGSkFRDlgSq/DR3q3IScjpFRFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V9Xx2hTh;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E74606A324
	for <linux-input@vger.kernel.org>; Sun,  1 Nov 2026 15:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88E74606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V9Xx2hTh
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e8246b13cbso18495295ad.2
        for <linux-input@vger.kernel.org>; Sun, 01 Nov 2026 07:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793545755; x=1794150555; darn=vger.kernel.org;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r7sqR2vKS8k46feKmXGRK3DyHQiJEHIGx7m70vFc/3o=;
        b=V9Xx2hThdKxFw9nADiYlhHfmk3u14emJP/DqNa743jFAxL4IO/2Zx+VtJA1/V4ZKpY
         kp0pASv7rNJWBXPW1vwq3M5hF0qJQQMaPZ+HcSYtivquFrTqDx5xpLQV3FtNMnxq/ieD
         4nEmEd49br5WtlCOf2EKtIBcsmk+3t1LtdH/3OAEsKVpG6gViGd9I1MYRRTg7GV5Y3EN
         TYES+eFfTJrySSEZkf53we70A/vqAgUR1ixY4DIH/BHOl7n9WsjtbBReE3NRbO4q6bop
         dRHn46psXuz+On/gJDNcYnJNnNcH9GgcOpb+6lft7TYdmtW/cBa/jHLQgN96vRIR9IlP
         1rtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793545755; x=1794150555;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r7sqR2vKS8k46feKmXGRK3DyHQiJEHIGx7m70vFc/3o=;
        b=CQyyUNB7jcjoHiIEDoel/MQoNvmtZtB73t6yUuOb0sooqNyYgcp/yRjLM6NiNF6c7e
         7ZzOqqz2hxpbOqntJuQ07Wi5HtqLev4/FbH81CDtA4PAq9JNR1ZZSDrL9V05nSZ1KcRw
         w/tsHGX58kZr9wrijowJ48S0xIzHE51EGs3OIJg+9r8LavhN7d3GeWmD4EAkYhU6gYFs
         wptKapdHxUznpi+ElD9H/KntN1TlKOvT2dtSRZWlawmMVnCWh2oRFb6vxRATMHXhCtXS
         4OIkI5sfbbGPaOXCNxSIzZ+wGutfvqb6rbOs4V593p32+aVfpv+P2pPUDmLZgJRhHgmm
         bumQ==
X-Gm-Message-State: APuU4Z8oUKw05RSkK1s1+E63ihLQzV2i0Yojf3B4zU3TUbZ9Za3eJ/QG
	DgvmrA0Rh+R/I7dOwSQKxOM65mi5IhXPG7fbr9y5zYw3g2wM9Eido9+vy3P/HvsH
X-Gm-Gg: AYBFou0UCHRgtSg1mVnJgI1C5sn+vPa8B+IfKl8dPeh4vZWGdNmj4fVVub23dyrDCPW
	/dEj9tqCC8eIQkE6PxBh5NZR4LrsrtMHDSHnP1NMlxDt+W3MHAAj0YFeJUJddvqRudLy+Vn07HZ
	w4SpalGRqCmZqiM9niTu/vm68K9WuAHzIxR4LXiyYRVarbj9hHrYUdzGMGWQU2BtIYlNh1/a7wJ
	UwsHPCTJPlxii2wCqal6S7zhKowi35zLHxmaFvv4esdPijmkipTWM4yCpsu4Av5cIrZW1W5wlE4
	sgoFp16YI7zjavasL1HmAX7dbfGzSfyFWnJGx11yw2v0OvAef9oHu/R/feVlAjvdAqyepx4Q7PT
	5X8K1dtg3ajS8lTE2pjuK/3r/40DrsOs37/IuzQcEjYnV9pKD7xM/3Bq0Au08xXCI6lBAygTDso
	0MZJTbA801VJoUXQCUUZCv6ursi6lzocQs3t21gGf+vSRG6Ft1unmmJO5IRVWFuuCIvqbhGvbor
	u6DxqkhvLyu2cyrRHM/S0uPf/thvsGfRG+APrRYsDN/4IQr3kYG2Y4FPbzNd2q+uEOtEQ0xkQ/C
	G9NRSATFnY+MYj0octRgl2zNOkA=
X-Received: by 2002:a17:903:1b4c:b0:2e4:b37a:d583 with SMTP id d9443c01a7336-2eb3651554emr70954765ad.61.1793545754372;
        Sun, 01 Nov 2026 07:09:14 -0800 (PST)
Received: from [127.0.1.1] ([240e:b8f:977f:f400:ec2a:b15e:fef8:70a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39266b84sm18746045ad.43.2026.11.01.07.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:09:12 -0800 (PST)
Message-ID: <6ae75618.320b261f.106342.b1ef@mx.google.com>
From: Liang Haowen <nbg2974@gmail.com>
Date: Sun, 1 Nov 2026 20:45:00 +0800
Subject: [PATCH] HID: add ALWAYS_POLL quirk for YJX-CHIP EWEADN a8a4 units
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Replacement receivers with VID 0xa8a4 first appeared here in
October 2026, and the mice themselves use the same VID when
connected by USB cable. The interface layout and endpoint match
the original 0xa8a5 units, and the endpoint carries the same
9-byte report 0x02 payload, so extend the quirk to keep those
pointers alive on boot and replug too.

Link: https://lore.kernel.org/r/20261012154240.33221-1-nbg2974@gmail.com
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Liang Haowen <nbg2974@gmail.com>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 91319aa..1fc77cb 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1654,6 +1654,7 @@
 
 #define USB_VENDOR_ID_YJXCHIP		0xa8a5
 #define USB_DEVICE_ID_YJXCHIP_MOUSE	0x2255
+#define USB_VENDOR_ID_YJXCHIP2		0xa8a4
 
 #define USB_VENDOR_ID_ZEROPLUS		0x0c12
 
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 793db00..362768b 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -225,6 +225,8 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_XIN_MO, USB_DEVICE_ID_XIN_MO_DUAL_ARCADE), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_YJXCHIP, USB_DEVICE_ID_YJXCHIP_MOUSE),
 		HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_YJXCHIP2, USB_DEVICE_ID_YJXCHIP_MOUSE),
+		HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_GROUP_AUDIO), HID_QUIRK_NOGET },
 
 	{ 0 }
-- 
2.55.0


