Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014744E8E0D
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560116; cv=none; b=YVIHb0ebwB7tpK+Q0y6YixGg0tlFiFQv0TNibQmufCP4LtOl0IMbAbvRj2hA6Z1BHbXI5/cbEfF8r9JEtehxgW/tNjly1E2lTcIg1XK2yhbC1HBZHtD5Npd70AXq3tNWtEBClxJVATFhC6VX0/1U0gUShc9nBUNTdPYcelxvo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560116; c=relaxed/simple;
	bh=vHzDO/Njhccd+8suQo5aq0hHa112CnSGbrWTB7PvTCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+ExlKD/G3qT6KuesRvRY2FlOt9/edS5Zkuf4krprxpty8F6dfszVBEgWUuux9MmbW/o34iiPEj+D5K0lrIN6P2tu8YgAGO6uDD5igjUVYJYBLTCUZMndo8d6L/Eqjl7ow5PJdRukjDknTZsGTGt1uRpkuK4jgLiMtb/oTg+LME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ueth6F9K; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ueth6F9K"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48b060ec084so3010679f8f.0
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791560111; x=1792164911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=izxmWzhWymqhQF43ATaLAqZjx1TQjQJSOpVFPY6esDM=;
        b=Ueth6F9KUjPGqFNqwDffaf85ick8WUlXehQBrYfVRd7JqK6s0b1yJhb10I+cn65eF/
         BPJsxsxd7jNXgJtMSjL+HAbrmiPywO2oEkgKQ3MuoC/FkdAC+Y7Y0FE9D+LIBXbau64T
         0sVegB6luZ47Gc5oNYy+R7UfhOnHP+oE5FZwCtDacIl7C/v3T0sswiBAESpcZAsFllI0
         BR3AYW1818k+OruU27ReroymSbSd8g6T005YW30M+pQmVihCsWa1+GhKAP/SYGY3hB68
         ePACxZ8GOrBZP0A+oGs2nz+NWrKV4z4dXlHz+F+dJCwXQ04iUfKSePWVZt+kgtk32GtH
         0vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791560111; x=1792164911;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=izxmWzhWymqhQF43ATaLAqZjx1TQjQJSOpVFPY6esDM=;
        b=HoQbqbdlt+US4HcCh16Lp1ikAVQhXTcGDJ6SsFw56N318nYp/X1r6r6jGdJKNlGKpS
         YpdY2UwSGbkm3prt3zzFRT/k92vYF4TgbN9WBr8g4NaTVc066SKiO0lAFP5Eu2NLM0Fo
         XQv86mEX0n6h4Vl79ARQc913A8p1iAHIXeqahHOXj1pSC15ADjrKxZgj0FJK/3Diw8cQ
         EFNaDIoD5Q31O4ZbmSxObVkJtDJKQyUvaCqIqd8syiN8Lk0sc8xmeqF4HmaEbPJpx9XK
         G1AZ/YeZ/0ORt4dywxv+eGZyBjNMJx7laZugv1f2oWQetKky/4TE7YauYtDb6kLLWvfK
         tt/g==
X-Forwarded-Encrypted: i=1; AKwUvBy4HTIppuUhFz3j/qrcZQL+Ns83vx6K/KNZScZAJKVj9qAFBL5yy6DigVez8At6/1csxizss9M3Xozsig==@vger.kernel.org
X-Gm-Message-State: AFq9FYIcrOvNaDq8PX7shKq2xUrX+GaIM1FC1XviUWt6WTwdPf7TE18w
	LObT4gwW7R4JNNIyoyp5riN2wI3TqY9KeDow9gUv5Skc63SyqG32vrTT
X-Gm-Gg: AYBFou3Ru3GQABt8VsR9YyAXUppZojpEG+3R85ep8GPxsiKj4fFzDdyCUFlZXkuSV/z
	sj0cOCUzNf/6fhohtJepzZUh4So5rhfYCkBP9YKjKb1o9rmTgFJVTK3Z/8xindX9NZsacntFrKp
	qylxIV8MnTvsajhu2r303TvkRR78vv6ARycHFe7/skERrY87U+wezVqBXl93KTT6XLabUOBwINX
	TcwtwOpeWkTtJe2bdSplMMNUPn3yfTNyDRfrQs3egRdug3WO8d2ZElzxl6V84nb3Aw0tIz29EfO
	ovdQKv/gdoJijjQuPuSNdVCl/fVr1EgbUCARxtTIu+cOf/z2kWqxrF7o0P3FNuqjHisTGZnvaiN
	JfT1l1S2GyxxW06xH2Fe24NRTOmQSJ/jb26X8Vle9TIWu7kFqveYgOnebUqjOx9GGXbEc+HLaoW
	qWxDOnxbIWLmiheePourlpx+Y7SU2ToR3ASUaxi2xyVNb5oSRi6eapQRhMj6MyDjSZBnY8pBKXl
	7Twb7GrKQnWff6HXR9rPntpmeDYlBIHorXNZsseUSsFK3qG0sesELBcvg==
X-Received: by 2002:a05:6000:46da:b0:488:8437:b8b7 with SMTP id ffacd0b85a97d-48dba7b3557mr3460751f8f.7.1791560110956;
        Fri, 09 Oct 2026 08:35:10 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:8516:411c:ea75:bb84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9463230sm5395471f8f.1.2026.10.09.08.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 08:35:10 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luke Jones <luke@ljones.dev>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	Ivan Levchenko <me@livan.pro>,
	Nathan Chancellor <nathan@kernel.org>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v2 7/7] HID: asus: Re-send the Zenbook Duo keyboard handshake after probe
Date: Fri,  9 Oct 2026 17:34:34 +0200
Message-ID: <20261009153459.124752-8-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009153459.124752-1-p.pisati@gmail.com>
References: <20261009153459.124752-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rebecca Mara Müller <rebecca.mara@posteo.de>

When docked, the Zenbook Duo keyboard powers up in F-key mode and
needs the "ASUS Tech.Inc." handshake to emit hotkeys at all. The
handshake sent from probe is lost again when hid-multitouch configures
the touchpad on the sibling USB interface, which resets the keyboard
to F-key mode, so the hotkeys stop working as soon as the touchpad is
set up.

Re-send the handshake from delayed work two seconds after probe.

Signed-off-by: Rebecca Mara Müller <rebecca.mara@posteo.de>
Link: https://lore.kernel.org/r/20260811125548.1975748-1-rebecca.mara@posteo.de
[pisati: taken from Rebecca's standalone UX8407AA patch and adapted to
 the current driver; initialize and cancel the work unconditionally]
Assisted-by: LLM
Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 drivers/hid/hid-asus.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index a0a04ddb30af..f60f9a8fafbd 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -173,6 +173,7 @@ struct asus_drvdata {
 	unsigned long battery_next_query;
 	struct asus_hid_listener listener;
 	bool fn_lock;
+	struct delayed_work reinit_work;
 };
 
 static int asus_report_battery(struct asus_drvdata *, u8 *, int);
@@ -1459,6 +1460,17 @@ static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
 	return 0;
 }
 
+static void asus_reinit_work(struct work_struct *work)
+{
+	struct asus_drvdata *drvdata = container_of(work, struct asus_drvdata,
+						    reinit_work.work);
+	int ret;
+
+	ret = asus_kbd_init(drvdata->hdev, FEATURE_KBD_REPORT_ID);
+	if (ret < 0)
+		hid_warn(drvdata->hdev, "Failed to re-initialize the keyboard: %d\n", ret);
+}
+
 static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct hid_report_enum *rep_enum;
@@ -1555,6 +1567,8 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			is_vendor = true;
 	}
 
+	INIT_DELAYED_WORK(&drvdata->reinit_work, asus_reinit_work);
+
 	ret = asus_worker_create(hdev, drvdata);
 	if (ret) {
 		hid_warn(hdev, "Failed to initialize worker: %d\n", ret);
@@ -1590,6 +1604,16 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		}
 	}
 
+	/*
+	 * When docked, the Zenbook Duo keyboard drops back to F-key mode when
+	 * hid-multitouch configures the touchpad on the sibling USB interface,
+	 * which can happen after the handshake above. Send it again once the
+	 * dust has settled.
+	 */
+	if (is_vendor && (drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) &&
+	    hid_is_usb(hdev))
+		schedule_delayed_work(&drvdata->reinit_work, msecs_to_jiffies(2000));
+
 	/* Laptops keyboard backlight is always at 0x5a */
 	if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
 	    (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
@@ -1624,6 +1648,7 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	return 0;
 err_stop_hw:
+	cancel_delayed_work_sync(&drvdata->reinit_work);
 	if (drvdata->listener.brightness_set)
 		asus_hid_unregister_listener(&drvdata->listener);
 
@@ -1639,6 +1664,7 @@ static void asus_remove(struct hid_device *hdev)
 	if (drvdata->listener.brightness_set)
 		asus_hid_unregister_listener(&drvdata->listener);
 
+	cancel_delayed_work_sync(&drvdata->reinit_work);
 	asus_worker_stop(drvdata->worker);
 	hid_hw_stop(hdev);
 }
-- 
2.43.0

