Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D446137AA7A
	for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784360442; cv=none; b=gW6jYM2GPswSlbnLGPdtFp6IJmzndQLqqT0yQFfAvAC3c6Vobo4zpwXf07UKXSk2vhQBhZdNSaVvYYqlXWs0B849rnvm2Cms13Jk8F/8h+DfaxU5biiuqJZh8F4j0dLa2//lrXRGoSJOgQuhBgqT/YXO2ywTxh2WcFKGsL1+sHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784360442; c=relaxed/simple;
	bh=CHqctaXOh1YRZ6r+fEuQSQe/xUi6dXaEscZOn0peo18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZbHbVlSaBiZkYqujs5WGUrvbQOHxE7cFXIb7ySXyw/ycNznf/kpWiJtBRess7mNEtp5XG395X/wllZB4HlOBc5+osVAHvQcAnlML7HeSjCSKGhjt4T379LrxYRnOsFUYW84Wtzhsvbro2/R2Ib4FdXAOb68e9VEMdHMLnxvKN2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oIYg6s5H; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIYg6s5H"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso5023976a91.3
        for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 00:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784360440; x=1784965240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4sz+zAG3Op3BP7KFhD4nzcWAAX6/+g0R994WeqVfx14=;
        b=oIYg6s5HLIDMc3ITOkP51RXdF3lw4smzJ9e+oK5O0nflXZhRV3DlsO5YOshePUv+D9
         59j6KdYJuJIpAtsR/eBlHbzKTb69pvtPVKmVEgg/1N9+687+B+Q0rkzqVADcXq4w0CVc
         iiNkDsDfF0YxPr3oAotrzIatxGavtbYv8wRH6XCYDLKpt/tFoRvl+Fzp4CyYUdvuUZlz
         kNFKVg7YMG/bXksEmc4r7fTVrMKOKhrFzXgMlbt+mruRrzTEdrUkX/ym75P9oQq7T6oe
         EItB4mP4FF6kK5EwfdXjqCVkOz2rpwL1zCK5lZv5BQCZ32JA4aojqz1XK29zy5l6gPr8
         OXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784360440; x=1784965240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4sz+zAG3Op3BP7KFhD4nzcWAAX6/+g0R994WeqVfx14=;
        b=QJSxoqfuK+9ETLHjwN/WsOtfnvP+SoCljndL/3RAiSIcFjj5G0/v2t6W+93Pfbod6c
         wbcT3yuUDfjuLQ1TGkd5XOK2g+Skh4C/kPPnSh2ide/+aFkETkQJ1jLGfQoyu1R1QAjg
         Dp7faa1jmMQh4ydtxFEXEYG6UWR4t1XBK+OgKoaIzyrktfKcM/kUFn8yaVNYST+lp5gg
         w0siYqJ7hsm0ZykYADnnwhhkgp8V5Bm2gkNZBYYIGSJdzPTzJQ1qOsnB20ezkplE3kJ4
         pFZTn22bZlNe6BPRxIMzYsEgFxdV7xYFain/rQ0RKznpwpns4AiVPMttoLB2bK3Cy6Xi
         l74Q==
X-Forwarded-Encrypted: i=1; AHgh+RpynefkyIMtOb+sLnBUAyX8DE6ifv7+jPiwwyENNFt3BjVm7Oyazn/nrZoKSNyQLH6rXjlraS1GmLYw1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzxJFmgZ38dxXs8YN78ncdUnV2sX76ojyCIz+rGjex5/hOPGCH
	MvGSvo+VvIKgpT0M8cA+qUPtaDXVzIYsIB3VAbQY6mig+Vi8zY7PX7rY
X-Gm-Gg: AfdE7ckp8Hun3J3sBabnPR4LF/GvaP/ARrB4r3ji+G979vpLX4KC8n/cXaHRXSNYqZC
	Iyux6Xp99Nl70P0bCVL5ZWk8BinGSVpthLgkvcVYfDOCv7koaZA4+l1C2lee3TbjqsXQRsM9s76
	JH98fSit/3+VCGKDuCJ5wh9xP3e1GIAfK6QvqMn0dfS/qdRJ3OAdnoH5bUFbXQdkCU7Si/jaT71
	vjQvU51p9GJsBqt+1Ra8PVlAnOUiFQtWP/PWezfqd+bZTaWGubq7OS8YRgSRgtClqGUUuL/SRmO
	ejGjPnJTeE1Qucu4pg8ciF1o99Kd+uBPGxw0yatrcGufI7snLcQ5WXq5bQFB0g+vX5gMxUYnzhJ
	NCRQS7cK8X83haKC543xxm+XrrPcBlAETkOs2hHaUhSyqib6XaNNVtdLwD0IaslWIbu9lcZ/fM1
	3/Dv0Cc8BwChRJ0DUB9shL9gmws3yrjEmZ1EraLh/Xw4km9Nx0DpPJaj3DrLMGwnHjtOM=
X-Received: by 2002:a17:90b:1dca:b0:38d:ef48:b04 with SMTP id 98e67ed59e1d1-38e4b454d1cmr6489775a91.10.1784360440044;
        Sat, 18 Jul 2026 00:40:40 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e3a0d7a5bsm4311651a91.9.2026.07.18.00.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 00:40:39 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: James Ogletree <jogletre@opensource.cirrus.com>,
	Fred Treven <fred.treven@cirrus.com>,
	Ben Bright <ben.bright@cirrus.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: patches@opensource.cirrus.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH] Input: cs40l50-vibra - validate custom data from user space
Date: Sat, 18 Jul 2026 16:40:32 +0900
Message-ID: <20260718074032.1864861-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cs40l50_add() copies the custom data of an FF_PERIODIC/FF_CUSTOM effect
straight from the ff_effect the user passed to EVIOCSFF, without
requiring it to hold anything:

    work_data.custom_data = memdup_array_user(periodic->custom_data,
                                              periodic->custom_len,
                                              sizeof(s16));
    work_data.custom_len = periodic->custom_len;

The driver then reads two words out of that buffer: custom_data[0] as the
waveform bank in cs40l50_effect_bank_set(), and custom_data[1] as the
index within the bank in cs40l50_effect_index_set().  Neither read is
covered by a length check, and custom_len is fully user controlled:

  - custom_len == 0 makes memdup_array_user() call memdup_user() with a
    length of zero, which returns ZERO_SIZE_PTR rather than an error, so
    custom_data[0] dereferences it.

  - custom_len == 1 allocates two bytes.  A bank of ROM or RAM keeps
    effect->type out of the OWT case, and custom_data[1] is then read one
    word past the allocation.

The bank value itself is also mishandled.  It is masked with
CS40L50_CUSTOM_DATA_MASK (0xffff) but stored in an s16, so a
custom_data[0] of 0x8000 or above wraps to a negative value that passes
the "bank_type >= CS40L50_WVFRM_BANK_NUM" test.
cs40l50_effect_index_set() indexes vib->dsp.banks[] with it before the
switch statement's default case gets a chance to reject it:

    base_index = vib->dsp.banks[effect->type].base_index;
    max_index = vib->dsp.banks[effect->type].max_index;

Require the two words the driver reads to be present, and hold the masked
bank in a u32 so the existing upper-bound test covers the whole range.
The da7280 haptic driver already range checks custom_len this way.

Fixes: c38fe1bb5d21 ("Input: cs40l50 - Add support for the CS40L50 haptic driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/input/misc/cs40l50-vibra.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/cs40l50-vibra.c b/drivers/input/misc/cs40l50-vibra.c
index 996d6c38cca4..7ef4534fea2f 100644
--- a/drivers/input/misc/cs40l50-vibra.c
+++ b/drivers/input/misc/cs40l50-vibra.c
@@ -139,10 +139,10 @@ static struct cs40l50_effect *cs40l50_find_effect(int id, struct list_head *effe
 static int cs40l50_effect_bank_set(struct cs40l50_work *work_data,
 				   struct cs40l50_effect *effect)
 {
-	s16 bank_type = work_data->custom_data[0] & CS40L50_CUSTOM_DATA_MASK;
+	u32 bank_type = work_data->custom_data[0] & CS40L50_CUSTOM_DATA_MASK;
 
 	if (bank_type >= CS40L50_WVFRM_BANK_NUM) {
-		dev_err(work_data->vib->dev, "Invalid bank (%d)\n", bank_type);
+		dev_err(work_data->vib->dev, "Invalid bank (%u)\n", bank_type);
 		return -EINVAL;
 	}
 
@@ -326,6 +326,12 @@ static int cs40l50_add(struct input_dev *dev, struct ff_effect *effect,
 		return -EINVAL;
 	}
 
+	if (periodic->custom_len < CS40L50_OWT_CUSTOM_DATA_SIZE) {
+		dev_err(vib->dev, "Invalid custom data length (%u)\n",
+			periodic->custom_len);
+		return -EINVAL;
+	}
+
 	work_data.custom_data = memdup_array_user(effect->u.periodic.custom_data,
 						  effect->u.periodic.custom_len,
 						  sizeof(s16));
-- 
2.43.0

