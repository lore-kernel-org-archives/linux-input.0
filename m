Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=71.18.227.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203475;
	b=NVd6TGXac9+WmVf/WFCUP1D7rfIh2KyMR3C1SoiYR4qHcx8VdKsCMMvvQ/eDiH1GMmqW
	 B1Q/uGcK77aPaU4xRzVcsHZetUmIR/yw1QvwbD2rGZGO9uw0qEq9wV8HyFqFUOtLN+uWL
	 fY++sSSSQa7dPyfiCcWkBW6oYRrHghg3LMexqMAdykaFE9U+WbN5mrU6omb9Xar5zQQg2
	 3qtVpnlUKd1pQQjw0QCqIu2DGFi/znLzcv53C4dkHn5kFanbebeJn+SwH6xnPDIv6hgzT
	 BhXm0FzwkJF84dGw28zYv5iXekysV3yKjLIGN+eaIEAhmZ3b2Bx/s7VNiZcue+QyQ5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203475;
	h=DMARC-Filter:DKIM-Signature:X-B4-Tracking:Content-Type:Received:
	 X-Change-Id:Mime-Version:X-Original-From:From:Subject:Date:Message-Id:
	 X-Mailer:X-Lms-Return-Path:To:Cc:Content-Transfer-Encoding;
	bh=vXNF6Bzv4Y//zIOSrBv1uEGQDZqbWWmh+iIAzb9peio=;
	b=yor0D8tkqze7eqb1iQktlECebS46KbKA9x+1iCJa3YxC2gZd8dctATokPhZsH5r9JQAg
	 20MNtJ/eiQjpig41NHZ/4uxZb1Zw9tb1te4q88KQa9bQhPfJrTN+ofP5MRtE5V9dc9Fq6
	 mqRpfwwHbNXKwgp/Y3wO6npSNZ1v9bCJ3sJicdez6EJMdkbGgd+htQUCgm0RDXpM91Lzf
	 hXabo0X3E3b5sO29yxD0Lx9mxB/EqJEKfhfkusONCb2Y2o47BJUyejqIESJ7L2mS2MnHo
	 OTSXdd6sPftSWDOWK9LTBp4k8DLjvESy3vpbM2b+6AueYifjh+BUQdQrQbW7GqfswDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cherr.cc;
	spf=pass smtp.mailfrom=cherr.cc;
	dkim=pass header.d=cherr.cc header.i=@cherr.cc header.a=rsa-sha256 header.s=feishu2604220257 header.b=k+XjCVTZ;
	arc=none smtp.remote-ip=71.18.227.4
Received: from sg-2-4.ptr.blmpb.com (sg-2-4.ptr.blmpb.com [71.18.227.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0463B606A320
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 16:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0463B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cherr.cc header.i=@cherr.cc header.a=rsa-sha256 header.s=feishu2604220257 header.b=k+XjCVTZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1793203456; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=vXNF6Bzv4Y//zIOSrBv1uEGQDZqbWWmh+iIAzb9peio=;
 b=k+XjCVTZMsD65B7ZTc0HCmk2D832CnzhnQcnl/1q+07jnBdiNUbxeG4paFJVLu1C+XBgqs
 u6ICnoOdAMYkmyV0f+NzSMLkm8FLRBTHvxMsTvOg3lXBIvKNYsCacaZqV8WJaw5r10dXk4
 t2V4S8sI3GvbXN2k7P5luFCzshlyty0XppRaYMlAQFkhI6AcuFmuFTDfFAKntT/BIbcn2f
 MBeqs/6xHwajvdV8Y3kMgKI64rivY4YDsqL7bogdf98pI9jygF8SdDQLUY4A7XedXYTFUG
 aeo0LAdGvo1kGjKUOeA24jrIsovMtgbLZPe+tc1wIv6jbPAxRvVhBKC6ayjnUg==
X-B4-Tracking: v=1; b=H4sIAPoc4moC/yXMQQqDMBBG4avIrDtggor0KqULk/xpp5QYMloE8 e6N7fJbvLeTogiUrs1OBR9RmVOFuTTkn1N6gCVUk23tYFo7sus4S4iRC9RPbzC2PCekhU3ofQd rRgyBap8Lomy/9+3+t67uBb+cQzqOL89qKll9AAAA
Content-Type: text/plain; charset=UTF-8
Received: from [127.0.1.1] ([111.42.148.29]) by smtp.feishu.cn with ESMTPS; Thu, 29 Oct 2026 00:04:14 +0800
X-Change-Id: 20261028-b4-pidff-rescale-exponent-1d5c4e218e6d
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Original-From: Shengzhuo Wei <me@cherr.cc>
From: "Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH] HID: pidff: bound the unit exponent rescaling loop
Date: Thu, 29 Oct 2026 00:04:11 +0800
Message-Id: <20261029-b4-pidff-rescale-exponent-v1-1-3ba54accf767@cherr.cc>
X-Mailer: b4 0.16.0
X-Lms-Return-Path: <lba+26ae21cff+6dea84+vger.kernel.org+me@cherr.cc>
To: =?utf-8?q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>, 
	"Oleg Makarenko" <oleg@makarenk.ooo>, "Jiri Kosina" <jikos@kernel.org>, 
	"Benjamin Tissoires" <bentiss@kernel.org>, 
	=?utf-8?q?Micha=C5=82_Kope=C4=87?= <michal@nozomi.space>, 
	"Paul Dino Jones" <paul@spacefreak18.xyz>
Cc: <linux-input@vger.kernel.org>, <linux-usb@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Content-Transfer-Encoding: 7bit

pidff_rescale_time() walks the device-provided unit exponent one step
at a time, allowing extreme values to cause billions of iterations
while ff->mutex is held. In a UHID test with an INT_MIN exponent,
EVIOCSFF took 3.1 to 4.3 seconds to upload a finite-duration effect.

Stop rescaling once scaled_time becomes zero, since further
multiplication or division by 10 cannot change the result. The u32
value becomes zero within 32 multiplications by 10, and the u16
input within 5 divisions. This bounds the loops while preserving
their results for all exponents, including wraparound.

Fixes: 8713107221a8 ("HID: pidff: Rescale time values to match field units")
Cc: stable@vger.kernel.org
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
 drivers/hid/usbhid/hid-pidff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 22951b7ecd17..1a2fffcf204e 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -354,9 +354,9 @@ static u32 pidff_rescale_time(u16 time, struct hid_field *field)
 	int exponent = field->unit_exponent;
 
 	pr_debug("time field exponent: %d\n", exponent);
-	for (; exponent < FF_TIME_EXPONENT; exponent++)
+	for (; scaled_time && exponent < FF_TIME_EXPONENT; exponent++)
 		scaled_time *= 10;
-	for (; exponent > FF_TIME_EXPONENT; exponent--)
+	for (; scaled_time && exponent > FF_TIME_EXPONENT; exponent--)
 		scaled_time /= 10;
 
 	pr_debug("time calculated from %d to %d\n", time, scaled_time);

---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20261028-b4-pidff-rescale-exponent-1d5c4e218e6d

Best regards,
--  
Shengzhuo Wei <me@cherr.cc>
