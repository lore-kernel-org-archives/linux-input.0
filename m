Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115A021D3E8
	for <linux-input@vger.kernel.org>; Sun, 27 Sep 2026 01:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790471546; cv=none; b=YIj14qVyZ6WYrDMyP7ZXT9y0AIFn6f/oVoSxGXXsEPlVNl0ySawjRX3H3eukmLAa6NwvxFfaUcnc8HyIb9L3YmzTmoRns1SCNbQIV7H00pUhjMbSJylRzxG8v+7qJ2MYKqdo7lhdftwYKQ+51xyS8kxXdT/bxbLqDAlmLurp9BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790471546; c=relaxed/simple;
	bh=W8wcDQ2FZXhwd9mJcVSl0Evf6dP3etrpjlqlKfd4bsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E1N/6pRhVpXjby5b+DSXbdd90Pogw1W/ohC559Zdrg53yrgzRrwbWOtxMCUPAFbIymwIXGfPkShA0NeLzS863IEyVBDXrDcdGTvXGGhJdJTNysMKQ2VI70YGfzCJRMAd/KugUqAP313jKmt0/vPYY7uSrnfSRghcevYWE0+K/IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksqtgSg0; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksqtgSg0"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a29bf27so943276b6e.2
        for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 18:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790471544; x=1791076344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/HFfaDW5E4cWiFgwER8sJnsi7m9rFokF5uIxDH/N3BU=;
        b=ksqtgSg0+IGM5CO5fkh5g2xvFgu8SpmE/tkGNKOaxeCq9lV5abSzqsfijny58BIlHs
         DCYjZxH3yXB46aVbnj5+LxPbcknJjVF7vDGPhiq+/mo9qpjRE3nZ67XXUCV1CEZGjphH
         zq/ysyFpDsLvx5YHKCNRvdrYwPiGggMQ3/45pFsHpmbTyDQtCUMcQIZU95VgXnNXWNIt
         gIAjdV3Wh7cXaYRIfl6YOieYe72wjnV/0E+pV8b8u6Q85C3s7IdDiwhLxs6BBHCGlxA6
         d5KqLKowV+Y+AYl0mZ1xOxNhH1tMZ36N+sYcKsQC0l5IJ1lvkh2+4leAb+hMBSLs2kYa
         z6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790471544; x=1791076344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/HFfaDW5E4cWiFgwER8sJnsi7m9rFokF5uIxDH/N3BU=;
        b=TxBy1LA9UppxKcUaugS1nEgr6rwbH7iVZKTdeEG7JAnADyz6d358eMguFtpTvENw8Q
         rp5sviDTSRpYA58TjZvhbnom0LrKxoJR5ppGT0SrVN7Ow8LmxLAae4p6IGitv2BSImY7
         kr1WmRYWf3cKJayDHx+KX7pc9vqsoEar12SINngL91ZDpCwb0KyPdj0foJja8xe2Kx5j
         9vaEYS2tIWeEJCejTPxPBAIUpeqKzCKJHWHG9wfojo8umsoebwRIx6KkFgC9o73Toldv
         Uzf5gq5NMtu1ezyq6ZQDKOK6JSQ3tbwbOznx2WU6F5nwgswt5ITtGRIdlelo3YRG65GG
         y4MQ==
X-Forwarded-Encrypted: i=1; AKwUvBygSGnym7ZcYdsgbhzCj2BWH1atHrrbH+HTQyos2pvGnFPsFEXU3xouB2a+KTSkJJIltOIrkAGUOfgbeA==@vger.kernel.org
X-Gm-Message-State: AFuF++njPFW4iCgKjmpLkTlpAOD/reSgQdc1SMiNCmdjX7vCDSgtksTy
	nSNqT73cATMkT496s/2yaZSIHWP5aw5uIzTVKz7xkG2GjQU4F0CEKsTW
X-Gm-Gg: AYBFou3mKVohSmWbH5bcL8I8sKGbDi3FxAGt1xx5orapm4KNr7g0X26Ox5HHiyon1BG
	KJjnA7s0mB23ymHIwby6hYe25Gl8L0bKOaR+ESFORBwUVgQcK7+rrUKFcgW5GIx3uikA5Y7btBy
	LZr/n9HoFpLxXWamdlBoiPl6ZNL90/PuZ52Vb+L2Uuhwu5E5niW7nD5FC4jgu9y0kTl6p8p/K1W
	QInSVPGXe9ADhGe/z/oqL6DDnDBi04PaD5t7TrZO2bqspymtU7UBFDHZoL+j06mKcLIMYuyuiZy
	fKsdQY4TV34XJ87lIDYZafxUV3yFuRbttaJY5DNOr3TWjHW3ZA7fO05R9Kol6GhvwzEMgveIC3i
	S0H+pUUSuxSNC4Ze52v5YgYLExuScQmuUUevDaOSAtxlFTCmjW/sTwkyfkjw1rpMTIbbXt+A+XL
	8pvOynGd0vaMkF3xrfvWu8QYG9HQ02NHXlKNT3DV2cPE0RjEEZE8jar8xVfb5/Ia5nyd28ILmwl
	/wUKHr//oappBkEoOmwy9WKm66JWBE3yQrXv6sw
X-Received: by 2002:a05:6808:4f61:b0:4d6:9273:251c with SMTP id 5614622812f47-4d72cd32504mr11122286b6e.56.1790471543855;
        Sat, 26 Sep 2026 18:12:23 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-493356565b6sm6534210fac.9.2026.09.26.18.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 18:12:22 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>
Subject: [PATCH] HID: microsoft: cancel the rumble work on removal
Date: Sat, 26 Sep 2026 20:12:20 -0500
Message-ID: <20260927011220.4193-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1cfc77a64b71 ("HID: microsoft: move FF initialization to
.input_configured()") removed ms_remove_ff() along with ms_init_ff(),
and with it the only cancel_work_sync() of ff_worker. Nothing waits for
the rumble work any more before devres frees struct ms_data and the
report buffer that the work fills in.

Removing the device queues the work itself: hid_hw_stop() unregisters
the input device, and if an effect is playing, input_ff_flush() stops
it through ms_play_effect(). The work usually runs before remove()
returns, but nothing guarantees it.

Cancel the work again after hid_hw_stop(), when the input device is gone
and nothing can queue it any more. Initialize it in ms_probe(), so that
it can be cancelled for devices without force feedback too.

Fixes: 1cfc77a64b71 ("HID: microsoft: move FF initialization to .input_configured()")
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---

Notes:
    Tested in QEMU on a next-20260925 KASAN kernel with uhid devices bound
    to hid-microsoft: an Xbox Wireless Controller (BT 045e:0b13) destroyed
    while a rumble effect was playing and its evdev node was open (20
    cycles), a Natural Ergonomic 4000 (no force feedback, 5 cycles), then
    rmmod. Tracing shows the removal queuing ff_worker. There are no
    warnings with or without this patch: I could not reproduce the
    use-after-free, as the work always ran before remove() returned. A W=1
    build is clean.

 drivers/hid/hid-microsoft.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index a7d3493a6141..1b527954937d 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -335,7 +335,6 @@ static int ms_input_configured(struct hid_device *hdev, struct hid_input *hidinp
 		return 0;
 
 	ms->hdev = hdev;
-	INIT_WORK(&ms->ff_worker, ms_ff_worker);
 
 	ms->output_report_dmabuf = devm_kzalloc(&hdev->dev,
 						sizeof(struct xb1s_ff_report),
@@ -358,6 +357,7 @@ static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return -ENOMEM;
 
 	ms->quirks = quirks;
+	INIT_WORK(&ms->ff_worker, ms_ff_worker);
 
 	hid_set_drvdata(hdev, ms);
 
@@ -384,7 +384,11 @@ static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 }
 static void ms_remove(struct hid_device *hdev)
 {
+	struct ms_data *ms = hid_get_drvdata(hdev);
+
 	hid_hw_stop(hdev);
+	/* Unregistering the input device stops rumble, which queues the work */
+	cancel_work_sync(&ms->ff_worker);
 }
 
 static const struct hid_device_id ms_devices[] = {

base-commit: 3f35b678a1d6b4c2dc773ad73623b1515cfc5bc5
-- 
2.55.0

