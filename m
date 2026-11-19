Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079602;
	b=A1i+C820ZhoPCWUNu1bCS4StjkjPaKZfl8w2GVwrLuA8S4QA1+hvt//3OV0k5if8Jg8E
	 z5vhr5zMn2uOQ8OY8PCfckzzgJ9RxhlnZo2vSmG4Sgv2YAQZK1DAMtYRZkUkwFsUsSRRI
	 JhMP5qbOuiLY6FNwYD4FvYY94Uf5Am2pDFzi/XtTgb6Vet8sIbArUk6wJLny0fiamm3wI
	 gwWSNs9oke2GtJqs7S7Fok8HoHC6I7ES4PqTm5B0OC3m4wYrKfe1FhNEgdkxDy8/uLjpr
	 37gn5U2aSId30slX6pgwS9FAn8hC+XBYWz4YAx+Wsmw4JwEboa2TQgjyVG+RZv8w/sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079602;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=mN65O16zzGwvi6EWpqGGNLhGsvAzjp+Jp7Y25gDSCnU=;
	b=dilrtB8L1kuetLzJ0ccc+ESNP3qNe22eqY7xhZkzsWko1PcO4QsLgdiVd5Wl+opj8gcX
	 xiefO0sDNrT/rj1STadP93+Cg1Ke2E01ZY2Tac4Poswc0kgZPmGIeOOkKCcs2Qxbu6r1n
	 hNLIqyL81usqhuuiquuf+wN7L+ivmcCpdU7uGHmlcgCGP/KxCa/QEFn3rYum2duu3Lmp0
	 FGd/Hlz8Gcqsk1QReaqf4aoI4/pbcD2a10RRRenUZYHv3nHY6ox7zChtfBPGzktv6wa1r
	 ouLfQBdHE2C0/Fx6ARg7sN0PkXPT5BkH8zWI1n0YFJuVq7AY+y/fUImPBbfJ+CxViEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b="S/tSAnfw";
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B7F606A33E;
	Thu, 19 Nov 2026 09:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48B7F606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=S/tSAnfw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=mN65O16zzGwvi6EWpqGGNLhGsvAzjp+Jp7Y25gDSCnU=; b=S/tSAnfw2V9cXEHlY6r7hwX9sh
	OpkGU7z53G1jGpdubXVlK9cyxBipnYVl9jOlqtj65wbt0PvZSgMCVtS6sU1D4vU8gKV86ugu+XkW0
	oqNAKPl9uX9hLRiC4oegmU22xekXQbUpnoiIS15w3mTngny5lmbNyrbmt1WxWSvcOAV6qAorEYjPp
	vcS+hbiWhbypySwY8bDw8WP2LGz7MS+RDsMFTBM69/jiLTnRdpGYYmiuzYPuXYpNK23AAzRSRgt3L
	eqXYtizWiKmiteZiRj7GpdSJQSOhgHaoyTkESg0cvkOjDF5Eq+o5yT6vx9jXVFhF/CjigLJjTH26b
	wKlQvrTQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTyCj-001yyo-0X;
	Thu, 19 Nov 2026 09:13:17 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: intel-thc-hid: intel-thc: raw spinlocks for registers
Date: Thu, 19 Nov 2026 17:13:11 +0800
Message-ID: <20261119091311.471920-1-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
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
X-Debian-User: emfox

The primary interrupt handlers of intel-quickspi, intel-quicki2c and
intel-ipts reach the registers from hardirq context. The map is a fast_io
one, so its lock is a spinlock_t, which on PREEMPT_RT is a sleeping lock:
taking it there is an invalid wait context.

Ask for a raw spinlock instead. The accessors only touch MMIO, and the map
is fast_io precisely because it is used where sleeping is not possible, so
nothing else changes.

Fixes: 1b2d05384c29 ("HID: intel-thc-hid: Add basic THC driver skeleton")
Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
index 7feda4160..e318f26ad 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
@@ -49,6 +49,7 @@ static const struct regmap_config thc_regmap_cfg = {
 	.reg_write = thc_regmap_write,
 	.cache_type = REGCACHE_NONE,
 	.fast_io = true,
+	.use_raw_spinlock = true,
 	.rd_table = &thc_rw_table,
 	.wr_table = &thc_rw_table,
 	.volatile_table	= &thc_rw_table,

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
