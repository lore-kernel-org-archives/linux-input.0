Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC126390C8C
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616918; cv=none; b=kJhJ+FAQ7l61JCCUjKqhhMrmW/ZKKKqACc6Xjt6bjnXWlTTEhgamWH5f0CnBTDNg94XktBxB/Wf8f4Xc9vhEUnYleTXW/In9XZNrg6PkIyMKr0+oLCkZbVRelrouDdm7+fUSTyHiv2jijk83OGN9GQp+9eodH1wxFpDyowld62E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616918; c=relaxed/simple;
	bh=onVBlW7MOcXY/4u/1wLc1luNV8JQgXpPbl+Dwq4jXa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C73twD8ghjs3m0NlnCsUR/LX8eElFG+7gbU9LF+MiS6+b0RHuEAFwTEiwx4Lr7fC6MIJET3ZZnq1yBSGoLxEiktDtDA7RmcjUbNluD4yRJzD/lZa49+aMzdpfuGKm9SINu74aBwY+sscIiH2+JWOOyV0TGXnp7ISPtOS98cJzSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWYzct+k; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWYzct+k"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-73720e58dafso1403099137.1
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 07:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788616896; x=1789221696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=005z03CIhBd04YrgIq3DK9hNQnxi1U/rfpjn1baG6tI=;
        b=dWYzct+kr3knNGg6/KnBWU/0/Pngwk0AJhgw9yVvAAqjhIYoWga64JMbEizqAVH3Oz
         fbPtkEiSfEmzpwGpMucu22cuAe4SJs3VpM7U7FZ9lw5NM8EqRRrr9S5I2JZKpJ4FemMa
         BgjsYZLAv6j2ukQ0ZRkF9WkQsF9FAs/lcYSJBQRqQJgmJ23yTqzG/YzU5W6whLGsS+Mw
         VBBfxdr7x8EAS1mz4F9o9p+OLUUAjQdgTGkd2JLHI7y82sc9nnrChcEzkxkgSLozG/kJ
         Cr4RzxeSdaLrtVEGTtp0Vp/jwdW7q69meF1Y/zJppkJotLc3CDXhV5QqPpZ6w+VX2qWH
         UQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788616896; x=1789221696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=005z03CIhBd04YrgIq3DK9hNQnxi1U/rfpjn1baG6tI=;
        b=l1IiwNbWVpDuEtpBGliE5B/Zs+7KyKL5TqvTM5aog0ejFTppGSafTar/ru6yOruQv9
         lw4F9NSosBgVwqyrrYBtXf/7Hs9ERD9q8MLnjAigi7lijXloXBMj+Vyun6vyBseJII7J
         +51ANAz6L2Yg4QxxRPcyWHnOm2Z1YVCIriqNQ1IQjClLgNTUX/Uy42G4hRERB5k6YOKK
         8j/TftbN4FyrM8Xwxlc9vBNRxsNh3hwCaQMG5bYRQcyx4+U6j656MQkLV8myM6Y3vXJx
         v9hgZf0X+tiVe02VVTuT5FYgfopQtZcEQ6TxnTWaT0pTkJHbvjPJuIJ/Ir5jw4R6Absh
         aJ9w==
X-Forwarded-Encrypted: i=1; AKwUvBz1RutSpSeROZ+EpYMbXgwWeLkoJn2d7csoQAD5algSfdyUrzZrkHvY7icwjSsl+7btrJTmpLDqjUT60A==@vger.kernel.org
X-Gm-Message-State: AFuF++lVMjCePAHJnWA6QshwTrcY2Fn0I4L1vVcvZzMAdZGih38AMbNU
	6NOfB2aaMP5cX4AADK+GR+xWv7AS1oaKqqaQhaocaz1pjOau7wUvBjTMah9LnHKG
X-Gm-Gg: AYBFou3H/CSQHegSKI9CDTziBaBpl1txHkkx+f3VEaK4XS9ILzDPXH0GT0oJXeMSjpm
	t4uw5vbZ/sai5EK1XB9s7t4q7QVBzSJniT7mUavT8vpB4mTXoTZtcaZgo5XNevRLlb9QqNtTP6l
	ykdH7IT0cNqlGEyFHoRkOnXNJKHH1Xg3uIGHf3Py2izpNlbn7ZeKkrIdIrNUX+pRLpy7vBNuhwL
	vK2yR5XUGrHqzIZh3rMU0cP1rz0qdNShqCqhgM0/FfwrsNy+mRfgiO+UaLcK5bf8/D63xUJ5/Na
	0LWT2O5SEKYISsrFK8FayDBhx/WoE0XD8eTaJPF76A35nPCgWQymeXhmHYOk5nFYVEDQzNLRC1V
	9as0MLlPKQd1eDQsUEAWOrlXe8m0W2FR0r5VE5L/XDdevPl0EKzkTgyDawxr0IHL5emGJEX3CIj
	P5dqTGV0wnUFqueijOA0G1/S2ZlNDfDvCnbPHQYjUz3SJXvxgioFgRAO1F9A+NhZTM5IkUc/QoX
	JMoMobDfcO3HpbwKJ9e1uCUUHptbUe8
X-Received: by 2002:a05:6102:3a0e:b0:786:c223:ad84 with SMTP id ada2fe7eead31-78a4a9c39cfmr5025994137.9.1788616895319;
        Sat, 05 Sep 2026 07:01:35 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee4d743sm3706877241.9.2026.09.05.07.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 07:01:33 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-clk@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v11 3/3] media: dvb-core: extirpate defective and unsafe ULE debug block
Date: Sat,  5 Sep 2026 11:01:13 -0300
Message-ID: <20260905140113.21638-3-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905140113.21638-1-breno3011alves@gmail.com>
References: <20260905140113.21638-1-breno3011alves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Completely purge the unmaintained DVB_ULE_DEBUG code block from
dvb_net.c and its Kconfig definition to eliminate severe lockless race
conditions and clean up the unused function signature parameter.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/media/dvb-core/Kconfig   | 11 ---------
 drivers/media/dvb-core/dvb_net.c | 42 +-------------------------------
 2 files changed, 1 insertion(+), 52 deletions(-)

diff --git a/drivers/media/dvb-core/Kconfig b/drivers/media/dvb-core/Kconfig
index 8b3f2d53c..c6a97add8 100644
--- a/drivers/media/dvb-core/Kconfig
+++ b/drivers/media/dvb-core/Kconfig
@@ -67,14 +67,3 @@ config DVB_DEMUX_SECTION_LOSS_LOG
 
 	  If you are unsure about this, say N here.
 
-config DVB_ULE_DEBUG
-	bool "Enable DVB net ULE packet debug messages"
-	depends on DVB_CORE
-	help
-	  Enable extra log messages meant to detect problems while
-	  handling DVB network ULE packet loss inside the Kernel.
-
-	  Should not be enabled on normal cases, as logs can
-	  be very verbose.
-
-	  If you are unsure about this, say N here.
diff --git a/drivers/media/dvb-core/dvb_net.c b/drivers/media/dvb-core/dvb_net.c
index a2159b2bc..5060b8866 100644
--- a/drivers/media/dvb-core/dvb_net.c
+++ b/drivers/media/dvb-core/dvb_net.c
@@ -68,19 +68,6 @@ static inline __u32 iov_crc32( __u32 c, struct kvec *iov, unsigned int cnt )
 
 #define DVB_NET_MULTICAST_MAX 10
 
-#ifdef DVB_ULE_DEBUG
-/*
- * The code inside DVB_ULE_DEBUG keeps a history of the
- * last 100 TS cells processed.
- */
-static unsigned char ule_hist[100*TS_SZ] = { 0 };
-static unsigned char *ule_where = ule_hist, ule_dump;
-
-static void hexdump(const unsigned char *buf, unsigned short len)
-{
-	print_hex_dump_debug("", DUMP_PREFIX_OFFSET, 16, 1, buf, len, true);
-}
-#endif
 
 struct dvb_net_priv {
 	int in_use;
@@ -320,16 +307,6 @@ static int dvb_net_ule_new_ts_cell(struct dvb_net_ule_handle *h)
 {
 	/* We are about to process a new TS cell. */
 
-#ifdef DVB_ULE_DEBUG
-	if (ule_where >= &ule_hist[100*TS_SZ])
-		ule_where = ule_hist;
-	memcpy(ule_where, h->ts, TS_SZ);
-	if (ule_dump) {
-		hexdump(ule_where, TS_SZ);
-		ule_dump = 0;
-	}
-	ule_where += TS_SZ;
-#endif
 
 	/*
 	 * Check TS h->error conditions: sync_byte, transport_error_indicator,
@@ -659,23 +636,6 @@ static void dvb_net_ule_check_crc(struct dvb_net_ule_handle *h,
 			h->ts_remain > 2 ?
 				*(unsigned short *)h->from_where : 0);
 
-	#ifdef DVB_ULE_DEBUG
-		hexdump(iov[0].iov_base, iov[0].iov_len);
-		hexdump(iov[1].iov_base, iov[1].iov_len);
-		hexdump(iov[2].iov_base, iov[2].iov_len);
-
-		if (ule_where == ule_hist) {
-			hexdump(&ule_hist[98*TS_SZ], TS_SZ);
-			hexdump(&ule_hist[99*TS_SZ], TS_SZ);
-		} else if (ule_where == &ule_hist[TS_SZ]) {
-			hexdump(&ule_hist[99*TS_SZ], TS_SZ);
-			hexdump(ule_hist, TS_SZ);
-		} else {
-			hexdump(ule_where - TS_SZ - TS_SZ, TS_SZ);
-			hexdump(ule_where - TS_SZ, TS_SZ);
-		}
-		ule_dump = 1;
-	#endif
 
 		h->dev->stats.rx_errors++;
 		h->dev->stats.rx_crc_errors++;
@@ -843,7 +803,7 @@ static void dvb_net_ule(struct net_device *dev, const u8 *buf, size_t buf_len)
 				       *(tail - 2) << 8 |
 				       *(tail - 1);
 
-			dvb_net_ule_check_crc(&h, iov, ule_crc, expected_crc);
+			dvb_net_ule_check_crc(&h, ule_crc, expected_crc);
 
 			/* Prepare for next SNDU. */
 			reset_ule(h.priv);
-- 
2.43.0

