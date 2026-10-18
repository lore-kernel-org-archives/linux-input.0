Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC533E1227
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 23:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792366056; cv=none; b=DIdfPb9HV3wZ97yc/AIYwJEgcwsnOD4V8s3tg+v3d4W6qSz5CFhhbf5+UNhpFTQTZrcvfoZO3lPhyRpILMky46wWRfXGw0hkqBgj5OE6zrCCcRFte2s/4AZWiXGvUq4/r6LdjsRGK5Ki6Dhqj/36xlyDZKf6P+97iMfspWIiEz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792366056; c=relaxed/simple;
	bh=QhtqZ8JvQkNYctbC8ezaeTjXmAvSIP2MXRV9jfw2V/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oq+ltF5R6MpEe5s2rlQjdREuorHsSBLB4TBoGi6pV7HZlei8fimdZ+t3fJ2xXOi8kdtUV+pb2bDjjyToyLDQEDZs6lCfIgdBwnPoi/mymnTiH2b/CqmWDcg9fLycYH3AeBF8gamNgA9yYEJyPiHSeYseqsDNtMMlSQdxidvf48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hv18tJBL; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv18tJBL"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35d7fa491deso1771946eec.1
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 16:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792366054; x=1792970854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QWI86/f7dXA4qQFC/2INoo9kMVa4RadmnPFerxfI+FA=;
        b=Hv18tJBLQO3Qp93x/LuYf6SydUKBxNuNba/pcuy31gxGzBY2YtnrbNigY1nig3636J
         dL72i1ftSqvDUIvS8U/GBfIsKvocSvyeVxTpdu778ym5uxBYY+ec+Qt3whtn/3Zl3XBv
         GUQax2CKBXhwAxnEbKHtNihbMcGk/leileTC1rwQhq42IUnuX9mgFQPB6KfMuJeQbIh5
         nwj4CNtQHW0E/GSPFV0ZWxUGB4M/4dlUhE61PR/r2u36ZUoOao73IFvQE+CNd1Lr2NR4
         XaJeBntiMR2PVDIH6OXV0Y49LhS9z8LbRLYUAVoG8GaTaKc8QTdMSsB9m29CZ/uV1VaZ
         uleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792366054; x=1792970854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QWI86/f7dXA4qQFC/2INoo9kMVa4RadmnPFerxfI+FA=;
        b=aqzShx+0twX1tvXb5+jz2X2hu6Zv9uHWhvBypH7G+rXEeIRnA4q4mZOPHDtLDYwCmr
         jU1VqZxjJoaxDEg6B7YFJJ/K62GiKtyOqR1UyT+CKoc+J3agcVqjtURT1GLR6AuGh6eC
         Frb11ycpRyXj5PP/KFIsFBjGEL0duo30dI3ggpL1Yyt2XVjK4yqHcrGtpGNw0Sq4On74
         ooP0oxIq45HtEwTKb80WNHTxFkC8XcmRP/QEdBGDjGRP9PVYkvlLzNfZ6OToIw1Esv9o
         cKigeWWlFRqzPULBnpm4GGk6R6fj1YUVoQPfUhHgWecw/rTex+DGVTZ7SLYgaeCViBUQ
         1UTA==
X-Forwarded-Encrypted: i=1; AKwUvBz2T2OVabBZY+0+ojB4bFAtjypZnhBKuAdSzXDZMWq7and04Nx0/eIVTeA4JR/24llmH8h4IVQas96KLg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJdKPCHUs8mT1onbgIrjTRpeR4GmIr1sTAgZzXlS2aewN1oMFrS
	MzNabp83WUDW4yQ/mf/6ZV4gMW5ILFvRM7YoCFa5yK462/oT4l7jlBPqQaL55GoS
X-Gm-Gg: AYBFou0OHVhXNVULRi8bNTY9wnLhNEVkOcG/dtzjnQ/nEBalaQqkkAiuPQZtnqZVN4N
	a0bqNDyQsNk99OBCtRpC7P+TAbnq8YrKKijhdY2yRnTdXoz+ReunupU3CSTCLWFuk8X2awefLzq
	QytrYwDg7o0A+I7aAXC+AWNk/0J8kMS+f/G++wkUpB6CuJbIi5ee93ZVREpSZUQZcFVv7h8sYNJ
	PN9NIzvo5riXttL9fdhYltVd/uWVHCxuYaca/jDdCmNB1Z85/ShiceXpODCKGQ+pK+TB256ZBe4
	LPD/l0ZxdLX1lWW0VUMlyZ8PnI/xYOIa9SmR+KAZO1HIYsVWylxO07ShBGBHLKb2+u1QDlE77MP
	CO91HOK/UGiRKWyRyvpTxNtdeq6/7cV3S8CWHfqghyXc134AXrPG2jJYE4hho7icx8MN1FoGDxw
	XbRb4sjQKSDeAyaxj0omstJu1IQBokJdIeRgNzWweRPdRFMAqOGViPMo+kpgXh0ee4XFjPW2zAY
	fQRfJOFNArLOlFrQJhCPyi2Hl0sQxTrFgfx8Xx/ilT4Y1EOOCCojw==
X-Received: by 2002:a05:7301:2503:b0:359:fb64:11d7 with SMTP id 5a478bee46e88-361a2b3bfdbmr7682577eec.11.1792366053498;
        Sun, 18 Oct 2026 16:27:33 -0700 (PDT)
Received: from siegeengine2 (c-73-158-156-210.hsd1.ca.comcast.net. [73.158.156.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6ca5sm25571908eec.9.2026.10.18.16.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 16:27:33 -0700 (PDT)
From: Mark Pariente <markpariente@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mark Pariente <markpariente@gmail.com>
Subject: [PATCH v2 2/2] HID: logitech-dj: Re-announce connected devices on reset-resume
Date: Sun, 18 Oct 2026 16:26:54 -0700
Message-ID: <20261018232654.70571-3-markpariente@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018232654.70571-1-markpariente@gmail.com>
References: <20261018224627.60328-1-markpariente@gmail.com>
 <20261018232654.70571-1-markpariente@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a receiver is reset on resume, for example because a USB KVM switch
moved it to another host while the system was suspended, its paired
devices may have reconnected to it while the host was not listening.
The connection notification the receiver queued for the host is lost
in the USB reset, so hid-logitech-hidpp never re-runs its connect
handling for the device.

Devices drop host-configured state when they reconnect, so whatever
hidpp configured on connect is silently lost. The most visible case is
HID++ 2.0 hi-res scrolling: the mouse reverts to low-resolution wheel
reports while hidpp keeps scaling them by the hi-res multiplier, so
scrolling becomes extremely slow (1/15 of the normal speed on an MX
Master 3) until the receiver is replugged or the mouse power cycled.

logi_dj_reset_resume() only switches the receiver back to DJ mode. Also
ask the receiver to re-announce its connected devices with the HID++
"fake device arrival" request, which is already used to query paired
devices on non-DJ receivers, and which Solaar sends to all receivers on
startup. The resulting connect notifications are forwarded to the
existing child devices, whose drivers then reconfigure them.

On Unifying receivers, slots without a known device are then
enumerated through DJ notifications; this depends on the previous
patch, which stops HID++ connect notifications from adding them.

Reproduced with an MX Master 3 on a Unifying receiver (046d:c52b)
behind a USB KVM switch: suspend, switch the KVM away and back, move
the mouse while the host is still suspended, then resume. Without this
change the wheel stays in low-res mode with the hi-res multiplier
applied; with it, hidpp re-enables hi-res scrolling after resume.

Fixes: 534a7b8e10ec ("HID: Add full support for Logitech Unifying receivers")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=203421
Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/528
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Mark Pariente <markpariente@gmail.com>
---
 drivers/hid/hid-logitech-dj.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 383c762c503f..4230c47713ee 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -2016,6 +2016,16 @@ static int logi_dj_reset_resume(struct hid_device *hdev)
 		return 0;
 
 	logi_dj_recv_switch_to_dj_mode(djrcv_dev, 0);
+
+	/*
+	 * Paired devices may have reconnected and lost their configuration
+	 * (e.g. hi-res scrolling) while the receiver was unpowered or switched
+	 * away by a KVM. Have the receiver re-announce connected devices so
+	 * the child drivers run their connect handling again.
+	 */
+	if (djrcv_dev->dj_mode && logi_dj_recv_query_hidpp_devices(djrcv_dev))
+		hid_err(hdev, "%s: failed to query connected devices\n", __func__);
+
 	return 0;
 }
 
-- 
2.56.0

