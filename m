Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBAB4BA1E1
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888046; cv=none; b=amYpMOygP3b772dARugjY6nSh9StSFhOUt7Qgf9Xq7f4CTYOHKQK6NO5lpZpFaSpGfDjftIwN7ytsIWkTrtJNUkYuAIe/RylDUDcAKzrnpadY7+PHSgNKitm9v/93PSjDhPk7llFz2JviVeUEkiFH5nf/8CIbJZpAUECz/Uswak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888046; c=relaxed/simple;
	bh=zyhm+tvPqyFdAt4LKL/7t6P2vmUJBYQRiGLkrIn2NRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OyPtQQlLVvYzaF/uy2Dql8MwZvxXQEyXlPNwkDT/WCFvnYQJJvkmMyNAXf+g4lLaPKsP8xRQhMeTkm3bHCP4Xpm+r6NmHcDp8cj/khrUyUhcuVHI1LAzaKXCe7xZnEYgLVWrBMXAQxA2zSJeQCurlMQAIzav8CG742ieK2z72sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rj8VIV5U; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rj8VIV5U"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c4d870d54so1651866f8f.2
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 03:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791888043; x=1792492843; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qDhbS9FDOqI4/556ADfkrnJPUMQ/QAqgRJ0YFjeCtUc=;
        b=Rj8VIV5UCnENjgJC0b5ZKaNO1xawhm3vfszgk3QebHMi5lI9Ji5OP8PDb7iu4qkPm2
         H3sb6egWd+UTg73vjivrk1LlJD6UYQsMorUb7gnGfCpfhleMbJoAKeYhccxKQUtiLw+j
         c/GWCyitDJq7hfOPxllDWZqi/X47NwBW0gc0DZd/EVs5lLfqf46iWym3VCFmW4LnEg1j
         5EoFiDYCGt1ZZY3dVGlIORDhvaIK34QxYjwB+1O7cZPJ8XihnUKje8xZZqgmmIcJFbcw
         m1mlhoFNm86ROEhNp0lLdumMWv6iPTSLuFVpXBxH8O3JQjR5YsidSeBFVwjaCxtSesC+
         u20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791888043; x=1792492843;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qDhbS9FDOqI4/556ADfkrnJPUMQ/QAqgRJ0YFjeCtUc=;
        b=vg+d5KsGCP8HHhY4IZENItoWQJWxDPrHVLm9Nx0xBoCLPm0UeOmhSbw9a6YIxdSx69
         ayLlr8kFsLVSL1orQJDIxPAP7+3gkQG+1ULTuT9r5gDiKy15632Pq5KJKZIqBYP2tg8B
         U9NbJjyhp/54OH1+KJWZjmjePDn+4Z/mHLr4d5XN840xtv281rDLb17uokoGurazTxcJ
         dLEk7TqZoCsbrWe1So3QBYMvUT+BFl8qv9K9z6kIAKIeDw5ZF/+FfkdQ/4wDQdBJrkC8
         +iVoLOwxZVCMgCvSsbOaQdHhmNdcySpUYDb1JBUmOI0Ir1ZSBDquQ4qhWSbJxUI/Ug4I
         Eygg==
X-Forwarded-Encrypted: i=1; AKwUvBy56NJ48zDXSQ65HeHk5iVl5hiUC0mSWzkEAstcHFVT05/C7jodC1JQpJALMOq0Pb99LVlt6DGPAkte7A==@vger.kernel.org
X-Gm-Message-State: AFq9FYIEJ/iHgGoL6QyXE22u9EHmwDclBy2q6CjU55btyzqc6H7rgU9d
	4EfNgv2pcpudi5MxnUNgzuUmpel3j/yFApQGM2OUQsuNApsDU+yUIEsz
X-Gm-Gg: AYBFou3xGheoFSQXETyIIge7qdPGvnnnnIx/ZnQCrFG296KjDJ+19OA5bVN4FEmWC4K
	98Jav51zc+2aIGVzbXnVeF6fRYPc1/Ign4FFYwZVPCLI8tR5iCZgHl0brcWj44uA0R9ud/39y6l
	cxz736+iNnnz3yNY+LNmNHtUKAqJFDfKPpwJ8paP+YtspxW6yxJSQ/s6iLhI7RJnrLtj1/vQHa6
	BXl7o6z2djU+4hKuOYxsWNMm9Z79QTURmmt2sCJbv7SbPugX0Qz97TbKCE6rc0LdPjhWXQK3Tpm
	aEiQu+F9lPXHADOZq03w7OkgI0CnbUVUqB5w4B5q0v/qQ7Vr7EZoYFPuKpYqWk1S1huRUi/RS6K
	JXgHM0/hdqUbA/6oD6bSsnClogQLrqH7i+VX18KodYyYsRuFEK2FHcfpvYExyYoT5Z64lTtSB7D
	FvmTrFefmYmIe3XuT6ccl+Xmja8d7U+59MSzQMdgWnh7/RSRuXm0NV1pDSQS1euVD35iZ22NiGK
	+d5owf+GevHiXjpQhNV0vH2/NHI7uIxsTUuDWvY+ah7+p/nA2TRxbBbOQ==
X-Received: by 2002:a05:6000:2085:b0:488:7496:15b5 with SMTP id ffacd0b85a97d-48dbacf126amr21938485f8f.47.1791888042775;
        Tue, 13 Oct 2026 03:40:42 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:e22b:cb88:4091:8aab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bd777fsm4058709f8f.57.2026.10.13.03.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:40:42 -0700 (PDT)
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
Subject: [PATCH v3 7/7] HID: asus: Re-send the Zenbook Duo keyboard handshake after probe
Date: Tue, 13 Oct 2026 12:40:04 +0200
Message-ID: <20261013104033.36079-8-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013104033.36079-1-p.pisati@gmail.com>
References: <20261013104033.36079-1-p.pisati@gmail.com>
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

Assisted-by: LLM
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
index 503396963eeb..ce413eb011c4 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -173,6 +173,7 @@ struct asus_drvdata {
 	unsigned long battery_next_query;
 	struct asus_hid_listener listener;
 	bool fn_lock;
+	struct delayed_work reinit_work;
 };
 
 static int asus_report_battery(struct asus_drvdata *, u8 *, int);
@@ -1474,6 +1475,17 @@ static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
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
@@ -1570,6 +1582,8 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			is_vendor = true;
 	}
 
+	INIT_DELAYED_WORK(&drvdata->reinit_work, asus_reinit_work);
+
 	ret = asus_worker_create(hdev, drvdata);
 	if (ret) {
 		hid_warn(hdev, "Failed to initialize worker: %d\n", ret);
@@ -1605,6 +1619,16 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
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
@@ -1639,6 +1663,7 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	return 0;
 err_stop_hw:
+	cancel_delayed_work_sync(&drvdata->reinit_work);
 	if (drvdata->listener.brightness_set)
 		asus_hid_unregister_listener(&drvdata->listener);
 
@@ -1654,6 +1679,7 @@ static void asus_remove(struct hid_device *hdev)
 	if (drvdata->listener.brightness_set)
 		asus_hid_unregister_listener(&drvdata->listener);
 
+	cancel_delayed_work_sync(&drvdata->reinit_work);
 	asus_worker_stop(drvdata->worker);
 	hid_hw_stop(hdev);
 }
-- 
2.43.0

