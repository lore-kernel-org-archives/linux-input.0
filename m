Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440511;
	b=DwP874jMRHdr/u3jJUuHgLegP+jqoNjE4OuuDmpjwpNEJNeTW/bWII3G4fGWyoGl3fjS
	 eAzvmQN7iu9lsUk/A2p7eSDThFhwmofI4iGm1GTSo/GPvkaQNp4NAbOW2N5TcZPwXhhr4
	 mJDELLz99B0UuTcYyqfKxHhoUkfcILCOzkdSELy8VwsaDeFEO44snmH2Z/04PjzObNNm6
	 KE7XnAvE7Q7Dwn4cd6cVWpF8hChdOzfIELOFjPItyfGfiwZ87CwKwE9H9fLzOJKFLDITU
	 3M6xLJzmA6MaCF/PGjsi8Jx7v3D2qK1UyyAiwjchuV80Z4JLpwLnLHoUqylwTZWJ2cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZRdXRrWaH3GXnj/xf+WF4Od3Gq+lG/ySQbyFtokDobQ=;
	b=ACJOLRHjUzUX9fB6ywJfDUpFLa059YOShsfrzZaImokjI2Bo4bqLj204SopPjh8O91v+
	 g8odF8JCIWNqgJZCFbEcbOXSAJUCyKJQnPtxKV3lLUD9RszPTtyLqe4/iETRERlWZieLl
	 1qhN8sMzq+MtV3sl4EX7e5qH6OP4tV1+bygqy8BCCsM3quLb2c5lNaPCCmr+LCtY/8CDD
	 kxmpk/MFRg2p+5uiUSDmrX/CPXkocDUaIRpsEmBpsSjt7bz79jmtBTAevy9Qs0/UkCC+o
	 Pvkg3eEaINyv8/qXqgnJgYPB7f1M9GbM7XwpXqq+T2aRpLd076LSLYgNMFregUP+KOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A2Qh507H;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD28B606A31A
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 09:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD28B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A2Qh507H
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a4dc547987so7870205e9.0
        for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 02:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793440509; x=1794045309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZRdXRrWaH3GXnj/xf+WF4Od3Gq+lG/ySQbyFtokDobQ=;
        b=A2Qh507HjQmeA+P5m9XKhryYbdN17f8lKZGAWxv+nA+hICvwXHyi0LcTij2wosUvp9
         4T65S+6TaCqcUcWn5ZHncrl2EgOPVXsrxszLH3BT+nWa9T9s3U+uhdm8xtaJNmag0Hxk
         X9MIg4QnRZ82ONsxf+wgvsWa0D16q+cPDPkRZHGuDnEEXmkrf9UCXjZ3/758k38PLH6N
         QEolL4+/5vBJiHSpZPmG8GPzEAuQOp+cQfwjjZVO6jS9Hwzzf71bEx2GHHyiDMh199f9
         T6YXT0njlhFl5YkocjUKdhtqvluDoCaRLRtoHAZj6/KKwjubfvlSbvjENsT/TJ2NzC6O
         6GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793440509; x=1794045309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZRdXRrWaH3GXnj/xf+WF4Od3Gq+lG/ySQbyFtokDobQ=;
        b=D1fRTRhtUkx9bOxAzcgRul+qQWNy9Z+NaX5LpfVc25ktIQfo/drse2i09SWKDZrRYl
         1dxlS4sNp09D4T2Hh5TsaZkdsKFXuFlSr161mHC3CFcVvCqXjTh9x+/UJlUg2mwUhyQ3
         Fl2d73DxspGKXVllkTgCeLvfh0YVYeEXcPkwaVsayN6tIxIp7cvSsqpsb6ZT22wp3M1f
         UiDfvUUkgjAaa89nbm4dMuJhb7M//8BWB2JX+3EkHYONysPrlZapTW7X/VE5aaos4kFW
         M6Edpcyt81OAgKGPnhjie8QsSXTvHly6P6mQnn8rmyV1W9QnoA6/g+qPuL40yUAptPs9
         hixQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbW2zK7uK1nQV9UmsojudXp0NWOfERqDAIgBHehSoNYMb0hebOJdAPzZ+0ndGfWC+udcv4Cs3skOL1Hg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLHzXc/psOZxRco4rmstQTiR2tHMhaLBhPx1p2/wRtXOEBp+6nK
	PQb9aqUgH1qMUaPV2ovPiu+kAgyGbxqC4CBPMlkLkkCwlTx59ePAQ7ux
X-Gm-Gg: AYBFou1yTgeUYg2BkLPn58ewx0T+tIIhG8vN7dTwT8WBimGoC2kr20oJQzidWks6Ewg
	eFu3/2R4nBR9kTk0js/yYOpBJAPDhd+Ah0aBNHXl2iUJwBLXqDJ7wZZM3VC4p9VS7X0kOl/V+zK
	NAuqr2h/W+9tCh4XLLedAUAnZvTX4FSHDSoe5khAocyCyP9aSbEvptpfdD3RM6iOecpmfLUqnJI
	PztBLC7qJtFtn/A36xua4djAn1npBGPhr5hi2vr38ec8ZsAKxrq19QXGGem9TBLSnxzMnwTyCOR
	5JxhQfz3/GanSUQzWAfIuUPNs+NdoSWC2CzocKXcJSynLVhXjqeF80sk+ijmjscXsaNP64Yc7E2
	tmLBx2q/wQ3uKqQJm2Uw77p98IzxNzovWzyTTlLHJsLl9SRgpHfDHFwHPdKlndT8FOS5YDWXB4o
	Fwi4/T2D198+PceUC/UzNeR8y9m+jKDuriSJCCchxurkr6bfdxB/O424s2yatEZdirvDg6Ryz+Y
	t6ez/W2wGedEEyGv0H2ojuJwK3VTCy6HELz0p16sQhy63uC7nnsKi0g/zvMVKqrzi4oKSjUy10k
	RYzC4u+FqnJjoBXoRPd4c9S7uFyHgbbakviAog+gOaBr7MFp0qRMF4SBlACrji+aHygbWfa1jj/
	kRGUW/Wm3od9peJhLw+F/W/wAcT3Jp8keagcIFPbI8NqgqMULzQRbodvmVOTR8V3oPqc=
X-Received: by 2002:a05:600c:4752:b0:4a1:9661:14b5 with SMTP id 5b1f17b1804b1-4ac18e5d4d0mr113107915e9.29.1793440509125;
        Sat, 31 Oct 2026 02:55:09 -0700 (PDT)
Received: from archlinux.tailbe3ea7.ts.net ([95.173.233.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a6bsm7869505f8f.27.2026.10.31.02.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 02:55:08 -0700 (PDT)
From: Ismail Tarim <ismailtarim7@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: James Ogletree <jogletre@opensource.cirrus.com>,
	Fred Treven <fred.treven@cirrus.com>,
	Ben Bright <ben.bright@cirrus.com>,
	patches@opensource.cirrus.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] Input: cs40l50 - fix OWT upload length
Date: Sat, 31 Oct 2026 12:54:34 +0300
Message-ID: <20261031095438.3070451-1-ismailtarim7@gmail.com>
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

cs40l50_upload_owt() passes the size of the effect in bytes as the
val_count argument of regmap_bulk_write(). The cs40l50 regmap uses
32-bit registers, so val_count is a number of registers and the call
covers four times the intended length.

regmap_bulk_write() copies val_count * val_bytes bytes from the source
buffer, so this reads past the end of new_owt_effect_data, which is
only sizeof(header) + len bytes long, and writes the extra data to the
DSP beyond the end of the uploaded effect. The free space check above
only covers the real size of the effect, so the write can also go past
the space reported as available in the open wavetable.

Pass the length in 32-bit words, matching header.data_words.

Fixes: c38fe1bb5d21 ("Input: cs40l50 - Add support for the CS40L50 haptic driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ismail Tarim <ismailtarim7@gmail.com>
---
Build-tested only (W=1, x86_64 defconfig with the CS40L50 drivers as
modules). I do not have CS40L50 hardware, so this was not runtime
tested.

 drivers/input/misc/cs40l50-vibra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/cs40l50-vibra.c b/drivers/input/misc/cs40l50-vibra.c
index 7ef4534fe..68f0c40ef 100644
--- a/drivers/input/misc/cs40l50-vibra.c
+++ b/drivers/input/misc/cs40l50-vibra.c
@@ -250,7 +250,7 @@ static int cs40l50_upload_owt(struct cs40l50_work *work_data)
 
 	error = regmap_bulk_write(vib->regmap, vib->dsp.owt_base_reg +
 				  (offset * sizeof(u32)), new_owt_effect_data,
-				  sizeof(header) + len);
+				  (sizeof(header) + len) / sizeof(u32));
 	if (error)
 		return error;
 
-- 
2.56.0

