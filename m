Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=71.18.227.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735080;
	b=k1M2B5IofzECg9pqS0AoLX+vOt76iJoJX8+h2LAKNP24JxktH6xxzWh+B09L95ZRjjh+
	 4mrK1V9ABJPZyRNsf30CYW47gZL4Kfjp/qjGfnNbUG1uYVoIpUi8+17JqLZXpphKRCFIG
	 j/yGQikumOG2Jqaf9VUjvMmiJ9OW/Uz7SD6RZgNjkPkU+cP9TbkQ5OskeGVc0BQjNwxJc
	 WdU1EsVzs7Xp/CM4rG5C1TBT/D3KSPepA9pmFtYBZt+JH8zf4lRCkIthA5bQfSvJO7HeA
	 z3OAdlZ0Vo0eO3iqLHlyYmADng7h6uXFIVXC8zVr04IIcNA35df4JBjQxj/tnyqsMVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735080;
	h=DMARC-Filter:DKIM-Signature:To:Mime-Version:X-B4-Tracking:
	 Content-Type:Cc:Subject:Message-Id:X-Change-Id:X-Mailer:From:
	 X-Lms-Return-Path:Received:Content-Transfer-Encoding:Date:
	 X-Original-From;
	bh=vcnq1DeugB7564b1ifNJtZSg+TFpvqDt2FpNBOnwADo=;
	b=0E610/GQ03uXbk8OFNmEXG83UxvaKbMRVGoerbsLNkRw8x4X6l9vRlxwp/GnsZcRX9XQ
	 Fn8jwivgKDeGQzbEQJFQSPD9hRoccAmXMR5QFRjuA1Uj0SIyiRnOma2ZyOmXVzMWugSRX
	 WEg9hiMrADg/ROKgkpaPNYECIPaBWNnYaquV7zs7axdtjqbZKeZorq6gorITrp/txkfFn
	 SUp36l/lT90+liyM0jH5qjotq44jMoB0dgvR+KigSYK/0RdtT4pYgpBB7QZ1S112roIxI
	 jfWfb/zBQYU3xCX6B7++WGG7L1f8ZUqXcxiCjelMy/t4iW10T0HVQWccCJmpnCkaSWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cherr.cc;
	spf=pass smtp.mailfrom=cherr.cc;
	dkim=pass header.d=cherr.cc header.i=@cherr.cc header.a=rsa-sha256 header.s=feishu2604220257 header.b=LPBLVSQt;
	arc=none smtp.remote-ip=71.18.227.4
Received: from sg-2-4.ptr.blmpb.com (sg-2-4.ptr.blmpb.com [71.18.227.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88B8606A32D
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 19:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A88B8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cherr.cc header.i=@cherr.cc header.a=rsa-sha256 header.s=feishu2604220257 header.b=LPBLVSQt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1793735068; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=vcnq1DeugB7564b1ifNJtZSg+TFpvqDt2FpNBOnwADo=;
 b=LPBLVSQtQ6b50vGVU4UXRLyUg0wWUEJX5+D+RDbZcGXi1b+UhOTaQHoybwtijPC1UBbG/C
 h1gtlzRmJ6y9KjJnYq4OwDyeWXK3QEif+kAt+yUG5aTFT9wzVfxfrv99aKgYRrAGJnixBW
 rnXKFVmGTxbnNq/nbiYIeWhIDBNN4/ZBFVWMrRLBbIfFwGiqKWYEEbdJzWHfchhDonRLxv
 xSj9rw0ANCUze98DFfb1Pz5zoLni2lhV0NcqCDIuKPV24nDNp5TKM/7pW+vSNZv0EO8xOl
 Eo61W9wibQ2dLheNfUUVxlXVAEggfZYc0cBUyN0xvJq35AHWqsxqqOWvhqFavA==
To: =?utf-8?q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>, 
	"Oleg Makarenko" <oleg@makarenk.ooo>, "Jiri Kosina" <jikos@kernel.org>, 
	"Benjamin Tissoires" <bentiss@kernel.org>, 
	=?utf-8?q?Micha=C5=82_Kope=C4=87?= <michal@nozomi.space>, 
	"Paul Dino Jones" <paul@spacefreak18.xyz>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJU56moC/32NQQ6CMBBFr0K6dgytgMSV9zAsynQqY0whUyQYw t0tsHf5kv/fW1QkYYrqli1KaOLIfUhwOWUKOxueBOwSK5ObSuemhraAgZ33IBTRvgloHvpAYQT tSizI6Joqp9J/EPI87+5Hc3D8tC/CcRNui47j2Mt3j09m2x2dFPrTmQxosNeyRbRV6V1+x45Ez oiqWdf1ByPLW57TAAAA
Content-Type: text/plain; charset=UTF-8
Cc: <linux-input@vger.kernel.org>, <linux-usb@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH v3] HID: pidff: bound the unit exponent rescaling loop
Message-Id: <20261104-b4-pidff-rescale-exponent-v3-1-f45e64cf488c@cherr.cc>
X-Change-Id: 20261028-b4-pidff-rescale-exponent-1d5c4e218e6d
X-Mailer: b4 0.16.0
From: "Shengzhuo Wei" <me@cherr.cc>
X-Lms-Return-Path: <lba+26aea399a+0699dc+vger.kernel.org+me@cherr.cc>
Received: from [127.0.1.1] ([111.42.148.145]) by smtp.feishu.cn with ESMTPS; Wed, 04 Nov 2026 03:44:25 +0800
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Nov 2026 03:44:22 +0800
X-Original-From: Shengzhuo Wei <me@cherr.cc>

pidff_rescale_time() walks the device-provided unit exponent one step
at a time, allowing extreme values to cause billions of iterations
while ff->mutex is held. In a UHID test with an INT_MIN exponent,
EVIOCSFF took 3.1 to 4.3 seconds to upload a finite-duration effect.

Stop rescaling once scaled_time becomes zero, since further
multiplication or division by 10 cannot change the result. The u32
value becomes zero within 32 multiplications by 10, and the u16
input within 5 divisions. This bounds the loops while preserving
their results for all exponents, including wraparound.

Also warn during initialization if the duration field's unit exponent
is outside the range -8 to 0. This helps identify unusual device
descriptors without logging on every effect upload or changing the
rescaling result.

Fixes: 8713107221a8 ("HID: pidff: Rescale time values to match field units")
Cc: stable@vger.kernel.org
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
Changes in v3:
- Declare and initialize exp at its point of use, as requested by
  Tomasz.
- Remove Tomasz's Reviewed-by at his request, since his v1 review
  does not apply to the updated patch.

Changes in v2:
- Following Tomasz's suggestion, warn during initialization when
  the duration field's unit exponent is outside -8..0.
- Add Tomasz's Reviewed-by.

v2: https://lore.kernel.org/r/20261102-b4-pidff-rescale-exponent-v2-1-a75bcca65fd0@cherr.cc
v1: https://lore.kernel.org/r/20261029-b4-pidff-rescale-exponent-v1-1-3ba54accf767@cherr.cc
---
 drivers/hid/usbhid/hid-pidff.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 22951b7ecd17..7827b366fa5f 100644
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
@@ -1433,6 +1433,13 @@ static int pidff_init_fields(struct pidff_device *pidff, struct input_dev *dev)
 		return -ENODEV;
 	}
 
+	int exp = pidff->set_effect[PID_DURATION].field->unit_exponent;
+
+	if (exp < -8 || exp > 0)
+		hid_warn(pidff->hid,
+			 "duration field has unusual time unit exponent %d\n",
+			 exp);
+
 	PIDFF_FIND_FIELDS(block_load, PID_BLOCK_LOAD, 0);
 	if (!pidff->block_load[PID_EFFECT_BLOCK_INDEX].value) {
 		hid_err(pidff->hid, "unknown pid_block_load report layout\n");

---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20261028-b4-pidff-rescale-exponent-1d5c4e218e6d

Best regards,
--  
Shengzhuo Wei <me@cherr.cc>
