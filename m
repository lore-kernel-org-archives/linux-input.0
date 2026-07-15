Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4567C379EE2;
	Wed, 15 Jul 2026 01:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078567; cv=none; b=lxTj/ijgLxk4p8C9JkiZFiDo95JfBFE3+b5ljKUaeDa5Dynq2IHMkTxsFgnu9mUU6BlXvpOS+BnYWiMU8g0iKzY1DWQ/Q2cdON64NJEt7nKpxOburONqIScpLhl8vqHP6LEfA+Cui3jPGi+wm5vyi9NfUhduMfDSKALWClI6V3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078567; c=relaxed/simple;
	bh=UkjDLG4XGjeBZA6yNdI13VlXhjqfFVoKD3WwStCIwwE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i6W5ELVngfelxIbNcECemSeun6XgMUyaj4lOy5riNhAhcf+Rq9cKCzUfYvjhR2qExvlZxxdhpOKDnSCc/p6VcraSNgWL3MIdBybI5bmSlsIBD5LEUs+HAVKJ3GxHFCEejVyouYSIohJhP1DAqbeQhEIDk9gJx3P/BLxIl8+ujf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=pUTkNY3a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OOGxqJGo; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="pUTkNY3a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OOGxqJGo"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 786C27A01AB;
	Tue, 14 Jul 2026 21:22:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 14 Jul 2026 21:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1784078564; x=1784164964; bh=qCwUqP5E/Tizzg6FQrFskv3X65mohBjV
	Tw6dw1aOwZY=; b=pUTkNY3ajKGQyJpihivMDZhqUfHQCbLmeZcITCFKcbiL3jZ9
	leAyaCr7HY39TJB481kA+fxMmotOb/WNmOwbXiyCWCJ7Bb06PvGPbx7sl1LGWRB1
	ezyCp287yuGRGq1O25Fa6WDP1yL98O5Rm3eV45efpTO+K5KZApz7ESR0/e9bpuYo
	F7Il2RELlXAuLBBJVEdbymLwDLtAJBrJ/Krfyd8URXKbjNEkk2rBreMnYX8mGZVY
	oJsBezshaLZiYKfAdsAVP9F6PzSSEsrowhw3vivsoCx5IuoX3r64sScBUIEenvOA
	v5pvep22dX9F91zxIRVewiMWZnLhqZJYUHSNug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784078564; x=
	1784164964; bh=qCwUqP5E/Tizzg6FQrFskv3X65mohBjVTw6dw1aOwZY=; b=O
	OGxqJGoU5+GfOHXn7wg6pJF/gapxFLFAbqWA5z99E+RTqrPa3hRjSOgsH8x/7wVt
	39nLDf4a8b6NorMgTcrLA8rw6eU2q0nkzC8NWZ837qnm9Jl6MRVvrW0p1vWAZuGN
	5orXGPumG9qM3jWmQbyurXgF0Vrp61EiMrLaa3FsrKkiJwdAahhcjqTkIYHrduuX
	IffZN3kPJhM9U71Hzlg7jYI7JZDCtcgOhSBwRazjKg2Pal9w5HE9zMC5FKXZUDsF
	TNcqea4Y1UojPz0ypTqX6N6l42RhDB8tjlJEEb8ppaikWW7qn08sv77nU7liqzVN
	Mj3KmmeiPK8xuiIC3zMsw==
X-ME-Sender: <xms:5OBWarhBVuzqT5pxhw1gAErmAhhe1QaN24t0n58pWFAydvtxBKG9MA>
    <xme:5OBWajeZ-5M6DFKHYyh_FBOAuWez50vOEuKiWWKy9iiwA4Op8Am62p7i73RSOxkE8
    cuA-hH1uhmEtIOK6D5o9GGgYqhv_aVAnIqE4vEyGyv6hsoJCYHeTw8>
X-ME-Received: <xmr:5OBWaum5ZobflZIh8p3QKiBFUKpYHPFALEqNNmfFtY2pomQGJgPhNY3UvDY>
X-ME-Proxy-Cause: dmFkZTFI/LtI7W6f1lF3OsQjfGRe8wa4mOKzgAHolKjPZkt7o4Av2dlAxiIpLI9nmoQecn
    0yLqQjeyLynHQ3vJHBmucmp4kn4WBfm+YfvkJLpc+c1ToRFq615QBAfbwCjH7Rnkfk2Hdr
    RkyMxDiEt75HUg+mZMEcvVmm8ktvzBtNjqdP6UhTer0AogpEmahMLXV7qbjGtmOKesBAtp
    ww6BrrM2wQ+I2tGn+ClIV3dfLLqQPKPF4LdrvS25XekfNCiZNo1P9pDzHZkPbjBZrgAxUq
    iRJ6trIA/m2yM570qkIFDRoMHaXprbIZBI+L1pEpiylYRqxClwyrS8ws2lUzr7uEW+Wtez
    gl38TXKad3hE+5TkirLFG5jkfMO6BwBH8KcrMiyOYO9MKjCAbChueBP3ocyjCzHqYAvNel
    vtTT3/r9wGZ2ZU+gYQ1a264RKTTOsplGhER/Ytb3zj4UOINycGaPoYUCN1th8A0p261jo7
    TfXGotlcw3VGkIqIN+F9k6sa2O9HPxYlVnGb7LdPUpHyVx6rdHUFmm5jpszbLGrccMC+Fg
    92c42hynXLo2ayZP6Wch23iM7Qg1uonl2GTFp4Z6n7ULwDbG+6SX23okO3S5c8XpXjydsD
    +f/cPNXbj9HVQBtHWxvRVJLcLvB2NoKwD3oaqAJzmwrcEMM4Oa/BY9sjEUug
X-ME-Proxy: <xmx:5OBWastkvRBgD8-anL1oL6EqxPM6XhM8P6v8n_hXPE2lOcPohMLXmA>
    <xmx:5OBWak_faOF8-kUY3k_eVrRouhR80FXlcjzEYAsX-O8hQI-0MMly1A>
    <xmx:5OBWauM4vRbOtsClrCVeV0AmIQrmfjJxNWush-us48QMADTj4-U63g>
    <xmx:5OBWaqHnBjBF4jm56dRUn85_xEgps4gh2IhDttoPkpfsBP8tPAhuvQ>
    <xmx:5OBWamyDNjhmYdQNMjFNWVOUj2zTQUtskMLGZbXAMHbKJgbjhqAeUQY_>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 21:22:43 -0400 (EDT)
Date: Tue, 14 Jul 2026 20:22:41 -0500
From: Ian Bridges <icb@fastmail.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] Input: wacom_w8001 - replace strlcat() with a strscpy()
 helper
Message-ID: <albg4Rv7QxvLJD05@dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In preparation for removing the strlcat() API[1], replace its five
uses with a small append helper built on strnlen() and strscpy().

The five calls append device name fragments to a basename buffer
that grows in place across the setup functions. The helper takes
the same arguments as strlcat() and writes the same bytes, including
when a fragment is truncated.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Ian Bridges <icb@fastmail.org>
---
The produced device names are unchanged.

A seq_buf conversion was considered instead of the helper and set
aside for two reasons. seq_buf_puts() drops a whole fragment when it
does not fit, while strlcat() writes the partial fragment, so the
produced bytes would change at the truncation boundary. The setup
functions would also change signature to take a struct seq_buf
pointer. A v2 can adopt seq_buf if that tradeoff is preferred.

The patch was tested as follows.

- W=1 build of drivers/input/touchscreen/, zero warnings.
- A userspace differential harness compiled the old and the new
  functions side by side. The name buffers were byte identical over
  their full length, and the return values and id assignments matched
  in every case.

 drivers/input/touchscreen/wacom_w8001.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index 45930d731873..d8d1cdc3f09e 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -417,6 +417,13 @@ static int w8001_detect(struct w8001 *w8001)
 	return 0;
 }
 
+static void w8001_append_suffix(char *dest, const char *suffix, size_t dest_sz)
+{
+	size_t used = strnlen(dest, dest_sz);
+
+	strscpy(dest + used, suffix, dest_sz - used);
+}
+
 static int w8001_setup_pen(struct w8001 *w8001, char *basename,
 			   size_t basename_sz)
 {
@@ -453,7 +460,7 @@ static int w8001_setup_pen(struct w8001 *w8001, char *basename,
 	}
 
 	w8001->id = 0x90;
-	strlcat(basename, " Penabled", basename_sz);
+	w8001_append_suffix(basename, " Penabled", basename_sz);
 
 	return 0;
 }
@@ -503,14 +510,14 @@ static int w8001_setup_touch(struct w8001 *w8001, char *basename,
 	case 2:
 		w8001->pktlen = W8001_PKTLEN_TOUCH93;
 		w8001->id = 0x93;
-		strlcat(basename, " 1FG", basename_sz);
+		w8001_append_suffix(basename, " 1FG", basename_sz);
 		break;
 
 	case 1:
 	case 3:
 	case 4:
 		w8001->pktlen = W8001_PKTLEN_TOUCH9A;
-		strlcat(basename, " 1FG", basename_sz);
+		w8001_append_suffix(basename, " 1FG", basename_sz);
 		w8001->id = 0x9a;
 		break;
 
@@ -534,7 +541,7 @@ static int w8001_setup_touch(struct w8001 *w8001, char *basename,
 		input_abs_set_res(dev, ABS_MT_POSITION_X, touch.panel_res);
 		input_abs_set_res(dev, ABS_MT_POSITION_Y, touch.panel_res);
 
-		strlcat(basename, " 2FG", basename_sz);
+		w8001_append_suffix(basename, " 2FG", basename_sz);
 		if (w8001->max_pen_x && w8001->max_pen_y)
 			w8001->id = 0xE3;
 		else
@@ -542,7 +549,7 @@ static int w8001_setup_touch(struct w8001 *w8001, char *basename,
 		break;
 	}
 
-	strlcat(basename, " Touchscreen", basename_sz);
+	w8001_append_suffix(basename, " Touchscreen", basename_sz);
 
 	return 0;
 }
-- 
2.47.3

