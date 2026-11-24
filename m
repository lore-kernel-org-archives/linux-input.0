Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795510277;
	b=WbncGpmJuVBT0F2vzQWxDMbCkxvB5UXtsByTN8JhLkQR+mSdKGidcABZaZRm6TrbVM8l
	 W05Y8Gn29FfGn4tTev6juuUSugDYcUQAOTmay756/BD7ogKhMf5HLLMxioSu7IqDFpdLL
	 k26PmcPU9Iz1dJOCvN/c0z3oT2clGeLzBUt61B1Vf2iHFFHvyCKecYlf2Yfmk6zN+Yd1b
	 lnbUm5ohLETGmNvjqZVQ31ljP5Q70CH9kY3G0nj4rPydFmAq+uz+v2zgx1AVW1KeohsBB
	 Jc8MJc8Vo12O0759aACb9yscuwzaenn3X1qgnoJsz5GlYdoQJQ7Oq0LTIB26Hgleq4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g+tEAauVDFwo0LFqluBw/XabLtSrlP/ZHi6sb+R8lbE=;
	b=gZgC7Y/4ORKfFwuvOm42zNU4i+USN7sqSC9UsBEG66x0vKS+57cqQyS4nM/Y+sXwfaZe
	 hzVaGbxxTXiXZVEm4j7C8RDpACDtDkZFKgj0NNABeCkEWWeSRtB0mh4zhAAmJ5OxGyANW
	 eLbEK4JcoNSftkk1cCUhv0cG1eX7/YCQ+VY6N132RjDCGNVcmaVi9OeD6hjlPjR1V2jFs
	 G1aTsOSIoJDBJc9lZnJSdJhLPuOYnC24nIOhNQqnfKrciOY/f9K1e3KYFxct9DwNkqHQY
	 gULzPJGbXoJn+g5YnK/Uk3Kci1vMG631Z9/HfXhEmGWn77M4S9WxAmY2R4bTWT4jO2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w+rAwjIG;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95D8606A327
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 08:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B95D8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w+rAwjIG
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-497614c95f0so2323188f8f.1
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 00:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795510275; x=1796115075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g+tEAauVDFwo0LFqluBw/XabLtSrlP/ZHi6sb+R8lbE=;
        b=w+rAwjIGq2RAS3Jn7nk07N6ZmRWPFI7EhxaWPnuYNPwb7hQsU3nMDpS0c/lepPS405
         kxNBzFj9AbUjUiaJHXpmG2PE1V3CZVYhrGr7zBaDRCdX/I27V9FK1aDs/voEG6UOLxza
         B/WSKvWm8MFkN6jPm1ssp3zs+yhLvIMeSJdnt6VjU0v0nNLAVJm8/LEXj5tmFF2UmgJj
         dexZxY4ooGZiByNd/PZWB1/vjdBjqll2Pi7h5fsC7hQ0/N8RhDsy6JjhufgcK818zbr6
         aMrhY0jOlcoanJ7qlgRoXqg+lXQLGlz119Cfr5WAWTGlJum+6wBrMOtANFoariGhIj3H
         CrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795510275; x=1796115075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g+tEAauVDFwo0LFqluBw/XabLtSrlP/ZHi6sb+R8lbE=;
        b=I+E1kISyA5fnEhuW2OTpiaa1XTO8ZIA4ZBuVB1sUz4mMJDgO14a5XEkGCtAQHCwixE
         OaTtmyUBNFgI4k6QO9NtC2tyNlm/fMkogS9hl6RdLxYDdA4FJ3LVuwZWk+EO7+DpGVrS
         z+yC49bJ+WAwvf9uL12f8bXc0HjiYQMeHgsRKZA8caAjx8H1kaim0eRSsPzhBAcZhBa5
         QUCEK2bLcPzkpAH0y2VS2Vn6VlqFezMFkelCQ7GQvTJ1XZx1ONdDyhTreMsWHoE7Exjb
         mZtQAJzs1L6An2sRCR+vd0ouMTaziryi9Bbbekkk+HZitjem6Mf6IIlrI5uhvN8kgRZL
         1INw==
X-Forwarded-Encrypted: i=1; AL+hErEyFynuRtm7ZVRjROFJHku+hHcdnMQi2jmR1PjUPf4hSE1raPyaDV1B4Gs+nW35ORkMhTiQH8VwOUHhjA==@vger.kernel.org
X-Gm-Message-State: APuU4Z82GlLgtLrWufXXrY9AVYkZjo7O+sIq7rXCGZYGMoAEXdkwwYla
	gYL4YdZtUJ0GQdG0Soq+5oqfKqSDfzS1VGHZNL+ENW3h34u7rj7CuUyS6S4/uZt5Yur2Xg==
X-Gm-Gg: AZFdTZcLsuwNlsevzzowJnL8nR5VehRaFBPE06hpG7f8TXWYdqEmeUdgcwgEjTiEPeQ
	QHGonNvFk8JA3A0Y6S17YJ4fR9aJevOtBWF0huZmLA5pzNJBPXLX442IxpGG6YbgaCtZG7rGERz
	+5bP+SlJNMhvLZ+aYZyNVTIkqBiXWC5uYE18wcpmKhcofynxEZr51gXp8w/a8iBES2LcpgFAvxN
	dDqrhaA5J9LEayt2TmMgMOscXtR07knlWBssCoyA1u1Cgp/RIpKcGC4h4GhkgqepowSahuytmYO
	0/R2+rZR1Gkk6Virla9XjAE1DKsXQ1OVJZY8hqqg4Tmui/mv5NecgRw3tSiwK3yWPDgD/EZNmNb
	OgEkZ0c6A6pAw62i/fTHvAtSm5uwGTrJm+S05uxEhnz9kXXQP4RZeRkW5qmhZTZ0NvgMWMTBVPs
	uMqciy45ZHD4XkjvAIcPnvPPxPg6MkP8FAA/6pZo5LNat1TTMXcTLOQqbYryJILjTCk4l7OQNyE
	+1YNCwzNGo2PF+n0OlZAGmBHyW2lnJ0f5pzUVub5B+S09J3de3jfFJjR7QRFtx4BPM27l8V1+Yi
	BRiVOkS5hKAiZ4JB0G6MCgMJ
X-Received: by 2002:a05:6000:29d2:b0:4aa:1100:72a4 with SMTP id ffacd0b85a97d-4abb400af07mr18504917f8f.34.1795510274996;
        Tue, 24 Nov 2026 00:51:14 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ad644140b5sm23692999f8f.17.2026.11.24.00.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 00:51:14 -0800 (PST)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] Input: goodix - sync the irq controller while starting firmware
Date: Tue, 24 Nov 2026 09:46:22 +0100
Message-ID: <20261124085058.128173-1-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
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

On the Lenovo Tab E7 (TB-7104F), which has a Goodix GT-912 touch screen,
the touch screen fails to come online after loading firmware, printing
the error "Error reading 1 bytes from 0x8041: -6".

Comparing the upstream code with the Android stock sources, the existing
call to goodix_int_sync should be moved between the upload of the firmware
and the watchdog restart. With this change the touchscreen is correctly
detected and working.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
Relevant bit of the stock source driver at [1].

Credits for noticing the issue and finding its cause go to matemiller992
on the postmarketOS forums, I cannot provide tags as he wants to stay
anonymous.

Patch tested on the Lenovo Tab E7 (TB-7104F).

Changes in v2:
- Instead of adding a second call to goodix_int_sync, move the existing
  one;
- Simplify the access to the necessary arguments/parameters.

v1: [2]

[1] https://github.com/lscorcia/linux-lenovo-tb7104f/blob/2dad69c9f28611ac6d3db2f1ee11b480a60d83ee/kernel-4.4/drivers/input/touchscreen/mediatek/gt912_p98996/gt9xx_driver.c#L1529
[2] https://lore.kernel.org/linux-mediatek/20261020122712.526797-1-l.scorcia@gmail.com/

 drivers/input/touchscreen/goodix_fwupload.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/goodix_fwupload.c b/drivers/input/touchscreen/goodix_fwupload.c
index 888da7538c06..642a632d363c 100644
--- a/drivers/input/touchscreen/goodix_fwupload.c
+++ b/drivers/input/touchscreen/goodix_fwupload.c
@@ -153,8 +153,9 @@ static int goodix_enter_upload_mode(struct i2c_client *client)
 	return 0;
 }
 
-static int goodix_start_firmware(struct i2c_client *client)
+static int goodix_start_firmware(struct goodix_ts_data *ts)
 {
+	struct i2c_client *client = ts->client;
 	int error;
 	u8 val;
 
@@ -168,6 +169,10 @@ static int goodix_start_firmware(struct i2c_client *client)
 	if (error)
 		return error;
 
+	error = goodix_int_sync(ts);
+	if (error)
+		return error;
+
 	error = goodix_i2c_read(client, GOODIX_REG_SW_WDT, &val, 1);
 	if (error)
 		return error;
@@ -249,11 +254,7 @@ static int goodix_firmware_upload(struct goodix_ts_data *ts)
 	if (error)
 		return error;
 
-	error = goodix_start_firmware(ts->client);
-	if (error)
-		return error;
-
-	error = goodix_int_sync(ts);
+	error = goodix_start_firmware(ts);
 	if (error)
 		return error;
 
-- 
2.43.0

