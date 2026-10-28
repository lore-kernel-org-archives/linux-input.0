Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=71.18.227.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793184924;
	b=pWkk8iCFsFsdaOEh6IS03Ul9wxJxLXfm3BpdpI7UA1XJXUohkYoRZxOQF0sn1bZ3/PR1
	 ++YYXPTV0dZV9mHIZp2/3khzWLcR/kiJlMrruxZ9DKrexVatE6JJYclytxvGNqXX7VZQH
	 Ik8G+iiYDNBX+P4p5o5LFNki0kIGLcVqKERDM1Dunt5tBpujT4wJbUnW9Sb2w8PhqqVq4
	 mQC07FcZgbDO7w2BONbA6Hxy+ws6lXJDN6QilTtM8uoVdZG7jnPfoKNR2509+8MWfEtBy
	 8o57c3wxkPaPD2btVolWzhppuknRHlrLrWtehXus8czyv9cJPJJBtbox4LM5E4MiFRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184924;
	h=DMARC-Filter:DKIM-Signature:Content-Type:Content-Transfer-Encoding:
	 X-Change-Id:X-Original-From:Received:X-Lms-Return-Path:To:From:
	 Subject:X-Mailer:X-B4-Tracking:Cc:Date:Message-Id:Mime-Version;
	bh=xk/LGmqAVOIr9rJ8TkRSY178UNjfbyNnpVZUhnBPxj8=;
	b=N8SjiAGNTAgeGH2luZ8JElOh9cLnJt1Yvv7X3QATpUz+xv2JxSGzCQe48XLpWmtQi0+a
	 GlR2jI4q7r3S5hJO1M/VXXqJh401KX0Z3LpdMAYDFKZBvBLpo4iAXOVdccGIg2cKSKf1I
	 cPrpeffb5KuEFWrVl22DG5MAabyPw65CXhbSPEgPPhNa6EVyH5EFnfuCufUAJdx58jyLR
	 IyEyik7OmcSLRk2yhuyE/WU4YaBcMu1clni73cwIOeTdPXVOXEf0Uo8pL5UzPOWVEdNJb
	 kZ+0n8/HR1Lmim7Dn6CFSMuaB5oo5ac+sQ/3oRtqIy56zYfpBmF3muoJiCLm6q2ch3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cherr.cc;
	spf=pass smtp.mailfrom=cherr.cc;
	dkim=pass header.d=cherr.cc header.i=@cherr.cc header.a=rsa-sha256 header.s=feishu2604220257 header.b=y33nZB4j;
	arc=none smtp.remote-ip=71.18.227.1
Received: from sg-2-1.ptr.blmpb.com (sg-2-1.ptr.blmpb.com [71.18.227.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A77606A31C
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 10:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4A77606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cherr.cc header.i=@cherr.cc header.a=rsa-sha256 header.s=feishu2604220257 header.b=y33nZB4j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1793184912; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=xk/LGmqAVOIr9rJ8TkRSY178UNjfbyNnpVZUhnBPxj8=;
 b=y33nZB4j75a1Z+47KFsLP3yOAEcqAul7Q7z6QXbzm7npLLDNd0mBzD6cqnoAvECSmCUCh9
 mwkf5j9dBZuX1zbRFGYly/iTvG1uble6BdniNBwM+rYYPzSfU1MYzFeGx6sjtyc7yTJVjc
 pghjk3JsKEI4yrWSEM6RYB1sOANGswe+7kzB+0exhOayc3aPVA5AIF1A4KBnvkPksKDczP
 pCxqgLvGHEdjABp+w62KoZ9HHqjTGpxinOZSY0p6e49bc4qGSRKLlzsJqJnUiOR6DzEdiB
 juMTf49GpXeF3Cf/Vq/K1VdyQAAjcINhjxIMAlb65oZejusKLr/XG9KJ17g7qg==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Change-Id: 20261028-b4-pidff-duration-shift-8df4f6451448
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Received: from [127.0.1.1] ([111.42.148.12]) by smtp.feishu.cn with ESMTPS; Wed, 28 Oct 2026 18:55:09 +0800
X-Lms-Return-Path: <lba+26ae1d48e+516177+vger.kernel.org+me@cherr.cc>
To: =?utf-8?q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>, 
	"Oleg Makarenko" <oleg@makarenk.ooo>, "Jiri Kosina" <jikos@kernel.org>, 
	"Benjamin Tissoires" <bentiss@kernel.org>
From: "Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH] HID: pidff: fix undefined shift for infinite duration
X-Mailer: b4 0.16.0
X-B4-Tracking: v=1; b=H4sIAIXU4WoC/yXMQQqDQAyF4atI1g04QyqDVyldqJNoXFiZjKUg3 t2xLj9479/BOCkbtNUOib9q+lkK3KOCYeqWkVFjMfjaN672AXvCVaMIxi11uazRJpWMIQpJQ09 HFKC818Siv3/59b5tWz/zkK8cHMcJBidogHsAAAA=
Cc: <linux-input@vger.kernel.org>, <linux-usb@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Date: Wed, 28 Oct 2026 18:55:02 +0800
Message-Id: <20261028-b4-pidff-duration-shift-v1-1-65028c6b4a37@cherr.cc>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0

pidff_set_duration() computes the infinite duration as
(1U << report_size) - 1, but report_size comes from the device's
report descriptor and can be 32 or greater. This causes an undefined
shift. A UHID test on x86-64 triggers UBSAN and programs a 32-bit
duration field as zero instead of 0xffffffff.

For report sizes of 32 or more, store -1 in the s32 field value to
set all 32 bits without shifting. Keep the existing calculation for
smaller fields.

Fixes: 1a575044d516 ("HID: pidff: Compute INFINITE value instead of using hardcoded 0xffff")
Cc: stable@vger.kernel.org
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
HID: pidff: fix undefined shift for infinite duration
---
 drivers/hid/usbhid/hid-pidff.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 22951b7ecd17..25b82e7d0b9e 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -394,7 +394,11 @@ static void pidff_set_duration(struct pidff_usage *usage, u16 duration)
 {
 	/* PID defines INFINITE as the max possible value for duration field */
 	if (pidff_is_duration_infinite(duration)) {
-		usage->value[0] = (1U << usage->field->report_size) - 1;
+		if (usage->field->report_size >= 32)
+			usage->value[0] = -1;
+		else
+			usage->value[0] =
+				(1U << usage->field->report_size) - 1;
 		return;
 	}
 

---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20261028-b4-pidff-duration-shift-8df4f6451448

Best regards,
--  
Shengzhuo Wei <me@cherr.cc>
