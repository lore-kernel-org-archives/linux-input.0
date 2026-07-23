Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817EC34F497
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 03:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778108; cv=none; b=L0RJxb2itusGQzroO8KiiP3JfDP+8/XQTmCzIpMvFFArhvDiuqHW9Z/xjOeFPYLQ1jmtCz/JvWaJwZYFwBLCjfxBd3XvSYbyIHW3ie5r3KG8yCBj3SRKKCuXcvXZwanhF6vDFe1qH0KddJrCSTVnGfHjI5AAni7umTCpGzyrwrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778108; c=relaxed/simple;
	bh=Vvyncg15bJ4O7PjCkXUDVg65lNLsE5U5XJCeL2puIT4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=b0a3G0i4JP6/MO2Nf2Ho50UifxWJ37sJRey19Atjbxf7BEqBtvtoEMGHziLcfs3/WQQ7uEBUsu0H/BWndA8pwyUJQFREeoBKHSDZHMTSEvz6VtvBqVJM3QxvZB4K0xb5d5tyre6/D/oA2YIwTkQa6jC6kWAOD7tnlGV1hB1Vp/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oLzMyBpl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLzMyBpl"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cf452def93so25775ad.1
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 20:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784778107; x=1785382907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RClF6Xi4/ZSHQG3Aa5cQmShxSvGEjTB+8O0FFcMBNhc=;
        b=oLzMyBplqTQzkuUO5zysUuWsEbcJmhcKcPi7beRCbU8h2QFI47qlo9JeVnsff7GhZi
         NprPrc7xmGOJanbQWBg2RuD+9Da4benkfQ/5Zz/S6d62j6sEpNBT5PNMYkICaYEiIYLx
         uHiwFgajIxiiFvTn0PEiw543OwYLTO87a0XflXARvipp+Rx1GDZvmkxjbJrNaixrzf56
         cTxZgRoKSgCNI/poEIOtgFvi+JSmJ4TYrGjgRA60G6o0XAZIlX68TVBhL6bshWcc9TcN
         6E6MoEeUgN5x/RtYK8AS5eyFFSQT3+dUwLZ1VA8OgD2qJSK5nhVfY0lnhPncxZRqYZf+
         W5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784778107; x=1785382907;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RClF6Xi4/ZSHQG3Aa5cQmShxSvGEjTB+8O0FFcMBNhc=;
        b=Qzz5SbRDzhRvtZtFqpKZb5dUMyElDpJ1bxcrjTpfI9YAfTSQ470h5XEnGexOkYjpH+
         gSZ1XyTfbpSixGZxrrjcrmH0zlVP5GedmsmTiDVkeBxGP+LsrEJtvse9o01cpQOLCz3z
         cbDPFqQiq3rPc68Xxuioj1vpGH4yJldDqCgs6WYM5mJaoHceB95uEBJWDgKw1WYeDGvR
         pR8nGu8hdo2mrjTRHjYGP/CBbiPtYTDmwgY1UK30VNoPPdCIpGc5Oa53RZ8qYTqRBLXC
         xBl0vAT7pbb+JOyKpEWWhsXwUh764noVgpfcicP8wkrj/hi4yuPOtydZDApOAvxR+/0O
         TXQg==
X-Gm-Message-State: AOJu0YzjjwtVHOhP7yr1OMztTxrH5rov9pgPqj318vHSFXa/3xpnDMTO
	90dAkTAEc8bfMJijxl4SDA4N4x56+20EMk12/LKE+CX1Vb0v5dcZ/2ax
X-Gm-Gg: AR+sD13GDCgcS9jf9lUJSAYbMorPb/OTZc8WsxDKrn4B67p/4sYO3omTggJQVCAjMGh
	P+ApMQTxPUpv8HN8qga99cIaELuyiRsp49Ar8Sv/rhh9Goc4iLlKH3eqiTzHKU2qm0xFBKcZc0h
	437OUSm3UGBFs7+yyJVY4cWu3bWtYalbDkUHqsEE/LrIwyTQtOy2nXAm4sMY7zy+uLjpU/e4ESP
	esa0pyGoRP7K8tV3PupE98sgH+0ZRxU1oiJrhh4O/N763Bv8eBOT/7BmmL54KvFhK/+HX/lTdWa
	9w0+b0VdAfJtxDosjYzhqMh1l1WOvMvu9SavvlylANmTnOtl2qmziPk+tNhE9Dn4awcCCqiXF0h
	IwIJtIaG/lr6zKhSbf6+GaJWze6dXqsnO8N1CGuEvj6OUZgrXJR9X+8GEVeT648uv4uoXjL4BQl
	2W1nclKRUeXJXUy2sWnB7AKQ4rVWvuHg==
X-Received: by 2002:a17:902:dac6:b0:2ca:eff:ff58 with SMTP id d9443c01a7336-2cfa95025a6mr10093435ad.15.1784778106597;
        Wed, 22 Jul 2026 20:41:46 -0700 (PDT)
Received: from [192.168.228.190] ([120.236.174.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f310644sm24440715ad.55.2026.07.22.20.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 20:41:46 -0700 (PDT)
Message-ID: <f03a892c-0961-4e07-a6e1-dbc3ff2064db@gmail.com>
Date: Thu, 23 Jul 2026 11:41:43 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
From: Liang Zhan <liangzhan5dev@gmail.com>
Subject: [PATCH] Input: tca8418_keypad - fix potential infinite loop and OOB,
 access on I2C error
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

 From 187224ee38e19fd3f74bfc08d1908c97398fef82 Mon Sep 17 00:00:00 2001
From: Zhian Liang <liangzhan5dev@gmail.com>
Date: Thu, 23 Jul 2026 00:08:15 +0800
Subject: [PATCH] Input: tca8418_keypad - fix potential infinite loop and OOB
  access on I2C error
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
If the I2C bus returns 0xFF (e.g., due to a stuck bus or device fault),
the original code would treat it as a valid key event, leading to two
critical issues:
1. The loop in tca8418_read_keypad() would never terminate because the
    condition "reg <= 0" is false for 0xFF (255). This stalls the threaded
    IRQ handler indefinitely.
2. The extracted hardware keycode (127) is used to compute row/col
    indices that exceed the valid range (rows*cols ≤ 80), causing an
    out-of-bounds read on "keymap[code]" when reporting the key.
Fix both by:
- Recognizing 0xFF as an empty FIFO condition (along with 0x00).
- Validating the keycode before calculating row/col, skipping invalid
   codes and preventing array overrun.
Cc: stable@vger.kernel.org
Signed-off-by: Zhian Liang <liangzhan5dev@gmail.com>
---
  drivers/input/keyboard/tca8418_keypad.c | 11 +++++++++--
  1 file changed, 9 insertions(+), 2 deletions(-)
diff --git a/drivers/input/keyboard/tca8418_keypad.c 
b/drivers/input/keyboard/tca8418_keypad.c
index b124e576feca..cec6a589192d 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -171,13 +171,20 @@ static void tca8418_read_keypad(struct 
tca8418_keypad *keypad_data)
             break;
         }
-       /* Assume that key code 0 signifies empty FIFO */
-       if (reg <= 0)
+       /* 0x00 =  empty FIFO, 0xFF = likely bus fault */
+       if (reg == 0 || reg == 0xFF)
             break;
         state = reg & KEY_EVENT_VALUE;
         code  = reg & KEY_EVENT_CODE;
+       /* validate keycode: must be non-zero and within hardware limits */
+       if (code == 0 || code > TCA8418_MAX_ROWS * TCA8418_MAX_COLS){
+           dev_err(&keypad_data->client->dev,
+               "invalid key code: %d\n", code);
+           continue;
+       }
+
         row = code / TCA8418_MAX_COLS;
         col = code % TCA8418_MAX_COLS;
-- 
2.34.1

