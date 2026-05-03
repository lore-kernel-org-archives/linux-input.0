Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CF335F612
	for <linux-input@vger.kernel.org>; Sun,  3 May 2026 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777793219; cv=none; b=C2HnLTPwmd8NNzCcuZcdAVQ6O1XdSPtyMUI2FddCBsTLqoBNmIlpZTOxVb6PNcrsTdoo1St7LatYM9/EMSzbVtDTgfDx10sVGm5ndNRnkHitD2WVgtccklLGgMFiFUecvFluHEycJvwezmwatPuaDAVpvjkeYMr9aYKoxfWMGK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777793219; c=relaxed/simple;
	bh=MAnhnGSHDh4DLEx17HlkmYqXOA6wnOEn0B10wMuS0ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DL0S+0cicjxKRDN4YQcH0rZwATbCx5xunLpjcLM5VQtn12+3a8HqBsoTcXlPisVFu384lZ8Sa3FZXbb1Kh0oibnlU0ZyXrEQAVM4QfHmPfL9ChU7zToCAio84TE1garzgF+v4RVLXqfUgOQrIjwQWhheP4ZznOw59Zw5Ypzm/Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MViRjv7S; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MViRjv7S"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba17c8cfacso2176775ad.2
        for <linux-input@vger.kernel.org>; Sun, 03 May 2026 00:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777793218; x=1778398018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOg4qBHTe+7jqP3ABxr8VsEBH6RAq2wSVE0e7j4wKpE=;
        b=MViRjv7SDWq3aY+LO6csNEAFE/EMgX3BjBmRvQs2aumUWOAwoAWTwyRzHVTlSccXJV
         BLeItDqqWMkgWml9P2ij0j8A8jgtORErzUMjCEm/KPayo4aGaOcogBFJRHOh56YKPBtj
         tQGQXrwNvVP5t8OItb0ow3GxyyCMFdS6xvjFl+v9mfnOE6Vt5JgP9FJtK02ZtwFvO4tL
         dRRxY4KxiMGgq1LeMCCdRoskjHKWGCZ42nE6F1q+ABefbgWsDW72U7Karz9WB4P4aXRO
         5XbBLkOtwN7vSmHusbQkTvVTSrN1pP23GEfxYyrumdesNqk5/CoSnJcJR2wifoZw98qx
         fj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777793218; x=1778398018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SOg4qBHTe+7jqP3ABxr8VsEBH6RAq2wSVE0e7j4wKpE=;
        b=YlZSzjRtt2qLunRg2gDaV9tAh/zQj9Bl+evuAvSbcJWRyzuO8G9zfk6S1ZnB5m+sY1
         JA5puOBWcSkpplyiJZz85CAKR3vjbx2PtkEFmZe0cqaz+OBHl4/PblTzk5oHouacO0Uc
         iRc76vROBeyL4QC/7RyM6rp+sFEV4l5jGU9ZlJXHQsBgrloTZMuQYd7lvnE1AfGXjgdn
         6Rbpszw0Wsrsn5BRB1feOGgHgi2l1vGG82t4NW9KOnM5Ayi6/4dwBSutVV2x/g9xipxZ
         M1qTShOQDuAMo8ZmrdBfSob9a/4CIIrOka3kjg8gwSmZ/uDXodv/n6Nd8x+iC1LIBi+r
         oNZA==
X-Gm-Message-State: AOJu0YwRRHG/V3qLWdicAM0xI9Ym751lwoiE5J/uh1qFJSaB/J4y/gnB
	99xGkBYO4FoEH4WW9F+C46eXKBiCiAGR5+GGPNMGkZGDbB10mzDiOKp+
X-Gm-Gg: AeBDieuwIvnprc6C3gdT1Q9n3uSvPyxSocct2OL6M9hpwRykL54OYqvYaeRf7yVEPwF
	hyI260F6wNYunggKkPXiCJ2ilHmwlJmvxmpaOJIiYLg3TqTIk+NSB0qy6dS/yyqyF/8NCISsGAI
	5hTAHMqRQdj54u3BoR57cs4hxkaHBws83jkGMXEnFr3FLmXObRF4pI645lhExA5yqIDyaTJ6A8o
	IM8N5Ql8DyrPCmxVRj5NYhAs/3RkAYwT3YQbbCFLMFAArlS9fR1tN78XOw7Ij9BFnpY/FP9G0bp
	RZRdGjosKn3b0mftPgAtesSd6TnxjlS3z822wleKF8t1EJISYzoXKe+04tjvaGN7Wp54cd+2rQY
	YFapWcphI9uvN2rBYWjMkg6gASiqBpj3srpWwe4SigQ1OwgBbQDV7V2Q7gZnpF8/jMlfEXH8Vgt
	EdCocuNfDpsJ/HgFNlsDPttj9iy3h2SqdV2MSSBfzTxE/sumvyM0D+IHv2VparjHW8jJyzgA==
X-Received: by 2002:a17:902:e548:b0:2b0:6e60:9586 with SMTP id d9443c01a7336-2b9f2579a38mr55557645ad.17.1777793217743;
        Sun, 03 May 2026 00:26:57 -0700 (PDT)
Received: from tranquility.wa.lan (60-241-74-71.static.tpgi.com.au. [60.241.74.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae16a9esm64942945ad.50.2026.05.03.00.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 00:26:57 -0700 (PDT)
From: James Ye <jye836@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	lee@kernel.org,
	pavel@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	denis.benato@linux.dev,
	James Ye <jye836@gmail.com>
Subject: [PATCH 1/6] HID: input: delete hid_battery on disconnect
Date: Sun,  3 May 2026 17:26:38 +1000
Message-ID: <20260503072643.2774762-2-jye836@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260503072643.2774762-1-jye836@gmail.com>
References: <20260503072643.2774762-1-jye836@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a use-after-free when an HID device containing a battery is
disconnected then reconnected, such as due to binding to a different
driver.

    BUG: KASAN: slab-use-after-free in hidinput_setup_battery.isra.0+0x15a/0x9db [hid]

Signed-off-by: James Ye <jye836@gmail.com>
---
 drivers/hid/hid-input.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d73cfa2e73d3..ae0e11c61eb8 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -2408,6 +2408,7 @@ EXPORT_SYMBOL_GPL(hidinput_connect);
 void hidinput_disconnect(struct hid_device *hid)
 {
 	struct hid_input *hidinput, *next;
+	struct hid_battery *bat, *bat_next;
 
 	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
 		list_del(&hidinput->list);
@@ -2419,6 +2420,10 @@ void hidinput_disconnect(struct hid_device *hid)
 		kfree(hidinput);
 	}
 
+	list_for_each_entry_safe(bat, bat_next, &hid->batteries, list) {
+		list_del(&bat->list);
+	}
+
 	/* led_work is spawned by input_dev callbacks, but doesn't access the
 	 * parent input_dev at all. Once all input devices are removed, we
 	 * know that led_work will never get restarted, so we can cancel it
-- 
2.54.0

