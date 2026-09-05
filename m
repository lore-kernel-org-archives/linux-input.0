Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91EF488203
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613787; cv=none; b=DjUelbRXbJltB+vF4ozKW8VxkHYWaoc1z/5rWa5OJt0Jp1EeaugG7utgRl69GTaDO4pDm5OD2mC/O1wx0ygk/oR7Ud9hHwInooO3DRSNliRchCJjnmCEOJau/OpiE0oe07ZJpSnbrgkRYXjxec0GFLukxEOpW1MOUzthITu2sbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613787; c=relaxed/simple;
	bh=9oavKokRiGlYKumk2qr2nWS7TMcpdvvTbgd4joGd2sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZo3BZKgJduVWAoLFBsZHjCPup4XFaVbMK7aF6J4prPoCbAgxCzkaIp+LiflF1EPo2/E66L4THW+YFdq140WthayGu5pkGwm/WVHsFgOrr4Ia+/N0QdtumzBXbcq6CBuIhoJPcEbD13brHtCYAK4HqHpZ+oLexh4ic76BlMHJmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tLW5/HO5; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLW5/HO5"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5c681c2a6a7so798309e0c.0
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 06:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788613784; x=1789218584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7EzzJgiv2Lpk9t8SNtDocd6qJ1tIEeCqMQeAGgeJvM0=;
        b=tLW5/HO5Brdmek9dqA2ZcqMQpbN3lzz1pLbf1F51K2+fE1a7THTcmyKKfwVBBukyKW
         447MV7tzp87JRp/Mx/8HvZ/PJCUpSAiHHNJXSN39/BDEQkeDflU1mMyVRb4yyNAjqKLh
         F1yd4dwbWtwWtseSsA1FAzYma9jgB1tJ8bWmnG5IXtruTNwEohyXSzFeXpmmEaOSuQwn
         UA2JaYwNdZC/Lya1txighWG9dyLHLTl0gn7ZcVJ7XVNuCl6W22ccMce+UrdnGJ5tlYjp
         9SOFWDrG6NX7IedrhHVHFRnFr0d+6xr1TfMjKWm/g+MoCyO9ExYeQh9plWuBNR00rWSf
         0/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788613784; x=1789218584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7EzzJgiv2Lpk9t8SNtDocd6qJ1tIEeCqMQeAGgeJvM0=;
        b=JZIUJqhmW/HJQGBII/MMQsA0VyvATpnenMD0IG2pCYoM7GOMo9qeT7zGtTPCwwKEpa
         u25g8oMxHZ79VnDCA8lH8MG47yP3dhaBJCOYjEi1s/bp/Py/OrpzmUGB68dPialUrWla
         MV1nIykCkXFgzlb0sj6bWgnwqPfMoA50jp9X6RJFlYSzFwrdvfswpcpdct28Htmrgsma
         YrWgxcowK1cgVsx5/KgTJEDKk9ksVVlzbcDWKAKKYSHBEB8kqwkIl//Utfl5al218D1G
         I71yPdghmtjMp2wx5MkGw7v6s9aCyS138cmYvJtBsDd/NK5n7LDSslxgMPOHcwjSJby8
         qVGg==
X-Forwarded-Encrypted: i=1; AKwUvBz8k/0qyp2hBA2pGO94bJcmEdWeQIj5IdvQ4oin4xlMnU0I0ymPnB06Jz7g28mlW2jtDoAUItjynsUYEQ==@vger.kernel.org
X-Gm-Message-State: AFuF++l0CHl+U3tR0CPGeJbtF0MFOYJtKyQ+lfIOitNoDHCK0iYkUO2u
	MZbd8HL64JSLUQNEiPgZrUgczJbeOU+EEuWiykDCMoAgcrVQj5gAujd7
X-Gm-Gg: AYBFou1rfkxuU53Dpdn6FcsyfdJmIMnd+aXoLpjNo9h+kCDcpwOrE4pN16z/U0ZKMiJ
	MIjYGqkItz6BxrQWVhus81lzedkES61lNj/yjxpC06jsIvPfyDdI9zR6GhFxtbrQWKSZCpHgq6j
	uHxwjKvIGP2miparTDXMcWoJJE4NrX+2c8mdOreT9M4i/osOylPxfKHgvP8gwN7khMCMfqG5It4
	327nl//YBeIzeK6vEzC5bhVuJVdnnLM8IR98XVh69hkjCQZ02M8xgNOmutAmGt6Jr4vI5CrfTPn
	kQqU7on5Y2+55sORhgRz7dyqgacLC8uYThk7SigtAylNAZB8g+uLn8ppvPt8aFrvVTm5pLM/A1g
	7Pkb86rPPA/STNUGkjcp4scla//NHlw0I/Y3p4trzRVcsj++Ww7DzaYoqPK4b7flMBpVEjF/erL
	+/zrfRPaPw5Gix0uPERpELAjuxbL+OPL7gs6iO2rggazkHU4QVyDMEdWe8KtgU8p5n9KS37v1DW
	/KeQn6xXspACn7Euj8ZwpEQbeFhxqlW
X-Received: by 2002:a05:6102:441b:b0:784:d83f:2a59 with SMTP id ada2fe7eead31-78a4aa99295mr3711296137.9.1788613783614;
        Sat, 05 Sep 2026 06:09:43 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a47a76487sm3719782137.5.2026.09.05.06.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 06:09:43 -0700 (PDT)
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
Subject: [PATCH v9 3/3] media: dvb-core: extirpate defective and unsafe ULE debug block
Date: Sat,  5 Sep 2026 10:09:25 -0300
Message-ID: <20260905130925.7115-3-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905130925.7115-1-breno3011alves@gmail.com>
References: <20260905130925.7115-1-breno3011alves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Completely purge the unmaintained DVB_ULE_DEBUG code block from
dvb_net.c and its Kconfig definition to eliminate severe lockless race
conditions and clean up unused function parameters.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/media/dvb-core/Kconfig   | 11 --------
 drivers/media/dvb-core/dvb_net.c | 46 --------------------------------
 2 files changed, 57 deletions(-)

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
index a2159b2bc..29f99dfe2 100644
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
@@ -823,12 +783,6 @@ static void dvb_net_ule(struct net_device *dev, const u8 *buf, size_t buf_len)
 			__be16 ulen = htons(h.priv->ule_sndu_len);
 			__be16 utype = htons(h.priv->ule_sndu_type);
 			const u8 *tail;
-			struct kvec iov[3] = {
-				{ &ulen, sizeof ulen },
-				{ &utype, sizeof utype },
-				{ h.priv->ule_skb->data,
-				  h.priv->ule_skb->len - 4 }
-			};
 			u32 ule_crc = ~0L, expected_crc;
 			if (h.priv->ule_dbit) {
 				/* Set D-bit for CRC32 verification,
-- 
2.43.0

