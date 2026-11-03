Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714527;
	b=J3/VnqINwqNLHQnUoysNh2idQDRaIj8T5zB1/URuyrP+HUUqa5dWLs5Hgl0OXIPgvgMG
	 nW0sjOMfB4cRA6/tKu70a7j1skCrAXk5o8O/2jN+XzRxeA/pCnPNxml6TUhEWGZa41SL0
	 5uElki2JyWdKggBRzatIqdENVCxtUdFfNAnMZDKxuQOsdlEZRJWCmljQ8NAIHIyspQZVh
	 pm7VKD+NMZOK/1sbY8GC5bwU7+Xx9Kj74mUb6aTKtbZbyMVO8Pvb//fQWemtY5aC8oep7
	 PI5RcAIbltLReFIMdqvCKvTeR5qew3OdfG6nrLHWF4spgztV4gE+B31ZDjqk9ED/RbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3lqUuofFF+sym+aHyb1Hp/3ru9p7QB07qliBrnkjVYA=;
	b=yGr2hseOMj1sRDICzJfUS0X9emkyIsx30AoZqzBHJ2xOZ7ExD3t7jxl9GC/H9viW1H7X
	 wOmEG3JIj+xtPCEV5T6G8cHjBh2XhW669IRNeOqNRoqJHLG46x4uAFm1OwpmfR4NDKs41
	 ra7L6vFKrIUKQXMSnj0NrvHqhnF83t+uXCKd5Z7c0NCyaRV5Gz1jZlIzk9xfiGwZcXCFe
	 nV+djD9zCTsEijYU3GI1ubPjE8hikAqfkjVqfZLWWG2aqeCbi3OYm2E5Q3Q9+PyjCNjpz
	 DLHC8XZ+TNVRroFymq/mdgH280BCYlz5bZeBcD1mRNT0ZPjpSgMK10cWMxYsTXOAK1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BmmEzL2S;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4877606D809
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 14:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4877606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BmmEzL2S
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36a0eecf73fso714762eec.3
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 06:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793714526; x=1794319326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3lqUuofFF+sym+aHyb1Hp/3ru9p7QB07qliBrnkjVYA=;
        b=BmmEzL2SrMRSIITUPNL02a2fjqbMbKWDfbVDBqRMq5nSmXxRJN+YCeWyFbQGel5AEH
         FME01N7UEjxRGaXMpYdN6ylls1GdHaVU1TD9CjIOxzab8891tFyYbK9ZrCKPULAfbm9k
         pGXO/q2g9oKi4P38obZ9EkjU17DsD0nT1Z1gI/95OvFfMsQyPXDHDuyGYF183/H2mUW5
         l/5BE4t6REAcdx5ApRk2yle9atvK2hqP4c5iusWEaZ+nHxBUjR3kRMLOpy6cgca7Z9ev
         sPSKyzKuwkA1PlU+E+vVHtZixAxYfaorzaqNpDBPu+WpIbBiGuhCOvSN0AWQpnSBqnjf
         XRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714526; x=1794319326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3lqUuofFF+sym+aHyb1Hp/3ru9p7QB07qliBrnkjVYA=;
        b=H3CH7ihS88d2OI8pRDiWoMoJ35Gd7CI7DKOPthK9k330VKMQnNk+W/rxxrU07bpzCT
         RlN/5aEVuxadw9g1WecPA5+QEJX9KNkxw9gXFal4Y+qk4rEXcPJCCvYrq/0Yyewic1xU
         l5mCO/akO84dmGFD1xuijuDbL8XfGXsZzXR05SplYZYn8cA/RpNkZljCuKGG3kf4uqQ7
         Zr5VX1XnRYbZd+fMYqMpHkElh73WpfR7dAKCIDqDPDi1jj4zDLPeuvo/NsBkCVcbP2ga
         j+jv3IORvC4kEXhadyUbbC5Xu4MAS3BR69XB1iqY2PmalLJ9x6bTFaaeizJhTtqw5k8C
         PNrQ==
X-Gm-Message-State: APuU4Z8iQhe54+6qPuidpgBrrYeslDNUhPZOX+kXO4oahoUhh+fdPz7J
	Q9xoodEJj/1vIz2s/vZeohtFCOT3FZhwfsTkwT9zJ3HrVki8OJrJnwt++JyIDFuzeyU=
X-Gm-Gg: AYBFou1LAPVHFbs9NGTRK08LyWV+fsoFM1jXm5KFRihjb/KX9YEVFUOAXyijECVOYo0
	sEJOTRXS18LYngBJDECiXi9h8x+RfK90inCrKYCI7h7lKWQ/Izz4mJNx6Thm4X7+GGAnqkinPos
	UDhNTknlLeOFZ4YxIb+K1X9KCXuKYYrdeRJuDudCDqq9Px5Abn0wzCXS2q2LXFS+t2X+D9uBkjt
	Wej3HgGLcw6KFz+jnwQ4/M8jPnIEUOagJjJD7aL6D0LPICXa0MnHYLeQ51x5hPuFZG40oqylCF0
	W+EUjFtbNpJtaoKgdIhU7cvM7JT8Hlj6GSgVK4++Z1k8kuaBjzSHMnxfkWxCogtf6MCL3qe+U90
	R6GMXRLjZzC/2tlOaXKHuRk0yLgBbDSVJLaqrOnA+UDR7A9abO6ryKXAyIy+yYUmnC3mJ4v2neY
	6S7dz6I39sZIG4Xmt6cKPFuMC+zEQwBeYCF7IslolQuhaP3wGNPcH9SoeaAVjQ26gxFN3W1nt5n
	4a7PSMWIiF3FmN/Mjl/oCZ8qvt21RKcL5WvHidUwAGQtF7+weJRXyK4C2R2UaqgMR/s1ui+Ok+4
	RWWiPykmH1n4l9jM2+F5F10dueTs4TF8kAzjgwSfwA==
X-Received: by 2002:a05:693c:6304:b0:368:1f8c:5f23 with SMTP id 5a478bee46e88-36a4205b0bfmr29800396eec.0.1793714525925;
        Tue, 03 Nov 2026 06:02:05 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm56343226eec.25.2026.11.03.06.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:02:05 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] Input: cyapa - clamp SMBus block reads to the caller's buffer size
Date: Tue,  3 Nov 2026 22:00:06 +0800
Message-Id: <20261103140006.1587143-3-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103140006.1587143-1-lui2012qwq@gmail.com>
References: <20261103140006.1587143-1-lui2012qwq@gmail.com>
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

cyapa_smbus_read_block() passes the caller's buffer straight to
i2c_smbus_read_block_data() without passing the buffer size; the i2c
core then copies the device-provided count, and any count <= 32 passes
the adapters' range checks.  Both the group-read branch and the indexed
loop (on its final partial chunk) can therefore write past the caller's
buffer.

The affected callers use 27-byte stack objects:
cyapa_gen3_irq_handler() (struct cyapa_reg_data, on every touch
interrupt) and cyapa_gen3_get_query_data() (at probe).  A device
reporting a count of 32 overruns them by 5 bytes, with contents
controlled by the device, in interrupt context.

Also make short reads an error: the "ret > 0 ? len : ret" convention
otherwise masks them, and the callers' full-read checks would pass with
stack garbage in the unread part of the buffer.

Bounce through a full-size I2C_SMBUS_BLOCK_MAX buffer and clamp the
copy to the requested length in both branches.

Found by static analysis.

Fixes: 9f1cd857518f ("Input: cyapa - re-design driver to support multi-trackpad in one driver")
Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
 drivers/input/mouse/cyapa_gen3.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
index fc3fb95452..730ac925a6 100644
--- a/drivers/input/mouse/cyapa_gen3.c
+++ b/drivers/input/mouse/cyapa_gen3.c
@@ -254,20 +254,38 @@ ssize_t cyapa_smbus_read_block(struct cyapa *cyapa, u8 cmd, size_t len,
 		return -EINVAL;
 
 	if (SMBUS_GROUP_BLOCK_CMD_MASK & cmd) {
+		u8 tmp[I2C_SMBUS_BLOCK_MAX];
+
 		/* read specific block registers command. */
 		smbus_cmd = SMBUS_ENCODE_RW(cmd, SMBUS_READ);
-		ret = i2c_smbus_read_block_data(client, smbus_cmd, values);
+		ret = i2c_smbus_read_block_data(client, smbus_cmd, tmp);
+		if (ret >= 0 && ret < len) {
+			ret = -EIO;
+			goto out;
+		}
+		if (ret > 0)
+			/* never trust the device-provided count */
+			memcpy(values, tmp, min_t(size_t, ret, len));
 		goto out;
 	}
 
 	ret = 0;
 	for (index = 0; index * I2C_SMBUS_BLOCK_MAX < len; index++) {
+		u8 tmp[I2C_SMBUS_BLOCK_MAX];
+		size_t chunk = min_t(size_t, len - index * I2C_SMBUS_BLOCK_MAX,
+				     I2C_SMBUS_BLOCK_MAX);
+
 		smbus_cmd = SMBUS_ENCODE_IDX(cmd, index);
 		smbus_cmd = SMBUS_ENCODE_RW(smbus_cmd, SMBUS_READ);
 		buf = values + I2C_SMBUS_BLOCK_MAX * index;
-		ret = i2c_smbus_read_block_data(client, smbus_cmd, buf);
+		ret = i2c_smbus_read_block_data(client, smbus_cmd, tmp);
 		if (ret < 0)
 			goto out;
+		if (ret < chunk) {
+			ret = -EIO;
+			goto out;
+		}
+		memcpy(buf, tmp, chunk);
 	}
 
 out:
-- 
2.25.1

