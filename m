Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466246;
	b=4klUgHEyPpfASy4Wbm4O5XNyMt5cipCNDapnZ2P0JyPcRGtJlAVMpQqE3Z8yqnv744z3
	 uAhbxCI92BWdan1JWAjL5soY5jiA65zZrYAKEQd53IIqudn4fYH5i2u7bqPyCLodw1BW1
	 eBQT8TbcOT886olwX6aVRwOfdZGdvyF77zEhCpJO/aeREVsEVWLv138bU17OfpKtwCDA8
	 pQdCV02PBOGTJ+rRQSJkz4E3ltEu84gtqKdEEHxA9PSbPkXK3w0rKWwiHufmqwiGSPP5/
	 yGtFfqALnHutRiREpqbIgdPKBjUNdWlQbfhNhxiWneNptkm20wO0pDo/r4pu1hTushA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NT4jdGotJzxNuTLZO5N6SjybiH5BTjQ5c+C2HwxxXq4=;
	b=SMHg1qxMZVgr2p8eJbkFczQIJksYivDUWbPIB62IrsqdWrK6ItL+rvUxVYHQYMUjZ93C
	 /vBMV+UC/MWPXwxQOPJO8Ifk1SgfUYNi3PALlOo0ZL4h9RGUu9lzZ6iZ92vONOnYDeZyG
	 G21dkbZaJirXZivylrc5cLAYW75yVJBJ+kdjNRwvXi3YwCBEnI717BTliExBzU/EIem59
	 a8lSutUKVXkPR7mzIvLQeoSIzUHw/gTXzR4g5JN1Y0dLCDs/165mDakAeDmr5/8gp4+2t
	 CnWMM7QciWnXfgoy3S/0R7l/nMV406Km9Vyy1hiTu9jbl897hIg9w+N/NSl0ipFsZ3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T9w1Bdv7;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E066E606DC92
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 06:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E066E606DC92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T9w1Bdv7
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso2400739a91.2
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 22:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466245; x=1795071045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NT4jdGotJzxNuTLZO5N6SjybiH5BTjQ5c+C2HwxxXq4=;
        b=T9w1Bdv7HosVhLD3a83j84pnZVg5YS0p+0yDGBed/EdkNMQbcVElIpfp0Hrtv2m5TT
         zGWpqDTJuiEXvcVnzJwxkw0rO29SGi5SR8y5sQDHNHczPkaLHK48V8qj+KWhwEMVk3CG
         mtdgg4H7TiDipsZ+DnE/oKYmX9gEsFBTIcgqaOH9ptsL4YD8MszIxDdqo2XhNjJs+4dh
         mU/Pbau9lStyaGhcErPKYoTvmHb+nDHd9STzPt73qF2DI07topNWjf4I3PwH6kx482cL
         sArG/f3xb6mAHG5a+1Zk+AldIvcOXKcOOkh1Y8zqVEu6Mf7i1ev2R+EwHtaMVpUHFLss
         x8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466245; x=1795071045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NT4jdGotJzxNuTLZO5N6SjybiH5BTjQ5c+C2HwxxXq4=;
        b=wjVypE9WT6ZGGXddMLITqfsvpDCFTJuCeIbs2M3oDsUknHsWlsf+xDjBgYFmQwy1M7
         DQ0774UsSOxrFcuf6GMf6p3swPlaX5EWeNK/+9KqktJRrTGL204pFCnKwM+o3e6XuhsT
         DIHklVjcxRxczw1wFEi+Y+YCOp2OV58FhFsUM/LoQ7we1frSayehwiDo6WYHnrcCfe00
         ebYSifXc+dsFUUcuhocdKuxhnswCIzwkc+Gz6zGeCz0Tnj5UqpH7zaDltkVvXmFRwh9T
         wTxUB44XgSqLb7W2DkyjpKpTjJsERdVXMkjW5V+UtJ2Z3ShpxLOhtTAR0DXTscu1BE1T
         iHjQ==
X-Forwarded-Encrypted: i=1; AL+hErEk35XZpGvWgn4ATzgk1khYk9mNJiW9x2CNnJtdEA/3VqqvSYspGKfMVheU/pqEwu1GIjbJ2teIGoEZKg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+pthuWq1TP1XjAAaIbpraZ3TY+4NbzygDqDlJgviyVwj8ljArT
	ib9R/7XBstr/PBNkthIguojmV2UN+wGGscf5VwRvosHPuNCZwbfxCS1w
X-Gm-Gg: AYBFou3jT+f3OxgHUi8ErdK0v3PSGxMug5LZ2Pq6p1bZAP0IBUBZfB3G5G51ZGztvER
	GrbPO/FoRH/SAOlgra1/xtJJZeL4AkwUKSvsMRUFdkQsryi4yW3tCtdqaCq1EKb3yW/+D7u8eP9
	7AG2V9RDeGcAJ2Qb6GLzfJX1hitZ0U0oPNT8lUQMxD0dN+AuVJYe5Hxn82ubLFxQRtYZg/j9gmI
	MPbBHBc0qtNnY9BQdIlLVV5eC0IjzU3JHW2aOqyayHlfx3YmMwgS1jqo3mVWuRtev/3TMm1hJJn
	oIx8uIkmBl4iJhj909KU6TEXl1hGRw7ghayqr1xJ0TSv5xwuon3/rghZ2GqprY1jCT5vwkQUes1
	bTr2BGnqlrsBj+J3gwJ6YtJk1Y3dIt3diathL/7UXhuyplH7dj7K4ppeA7aWJEbzMKDpmbOeoqy
	it0Usaphiddl572ETAb5UkhnZpoa1VFbEWujhO2bcR+/jz7ECOxYQY4khyxZfuAXdJREfQjIY8d
	jIPMsM35VV8uXNv9ZYvICPXv368xmatSx3QE56idDHwfBSIDYye3xbgOHWPLeyDGInHWr18/Cyd
	ybc7QHCx/uWPMV6TBu56Po/aR+9IUlStWZW53N6UeuBiTeEgW+OjyoXXP4ZYUAph4oWFsu8/yLK
	Jv4iIIw1DRGY31cci
X-Received: by 2002:a17:90b:224e:b0:3ae:5572:c4e2 with SMTP id 98e67ed59e1d1-3b182f198d0mr4826630a91.57.1794466245413;
        Wed, 11 Nov 2026 22:50:45 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8aae8sm3073297a91.14.2026.11.11.22.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:50:44 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Johannes Kirchmair <johannes.kirchmair@skidata.com>,
	Yuki Horii <yuuki198708@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-input@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] Input: tsc2007 - fix minor coding style issues
Date: Wed, 11 Nov 2026 22:50:35 -0800
Message-ID: <20261112065037.1800467-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
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

Fix minor checkpatch warnings and checks across the tsc2007 driver:
document the mutex used to serialize I2C transfers between interrupt
handling and IIO reads, remove an unnecessary blank line following a
loop opening brace, and drop extraneous spacing after a cast.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/tsc2007.h      | 1 +
 drivers/input/touchscreen/tsc2007_core.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.h b/drivers/input/touchscreen/tsc2007.h
index f65186b8e709..e5153b420371 100644
--- a/drivers/input/touchscreen/tsc2007.h
+++ b/drivers/input/touchscreen/tsc2007.h
@@ -78,6 +78,7 @@ struct tsc2007 {
 	wait_queue_head_t	wait;
 	bool			stopped;
 
+	/* Serializes I2C transfers between the ISR and IIO reads */
 	struct mutex		mlock;
 };
 
diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index 51e4d985afcc..8197ad91ed8b 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -82,7 +82,7 @@ u32 tsc2007_calculate_resistance(struct tsc2007 *tsc, struct ts_event *tc)
 
 	if (rt > U32_MAX)
 		return U32_MAX;
-	return (u32) rt;
+	return (u32)rt;
 }
 
 bool tsc2007_is_pen_down(struct tsc2007 *ts)
@@ -115,7 +115,6 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 	u32 rt;
 
 	while (!ts->stopped && tsc2007_is_pen_down(ts)) {
-
 		/* pen is down, continue with the measurement */
 
 		/* Serialize access between the ISR and IIO reads. */
-- 
2.56.0.567.gdb80ae8cd5-goog

