Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC7063B9
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 05:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785128889; cv=none; b=JrhsYWHK++Id/9TXZXnA82OC4axABsnBbMiJRAJqPR8xw9lKDDlnMJogmFDcQp2/IqIv4d5HudE6AiEDTw2ouzgnDMKb6n+fumuqwMmcqXxFmSJHSzqDwbDgirJZaHv8cu3xX7Q8WLj08FnoDq7jhKXrldqfCGOikeH/UkXIRYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785128889; c=relaxed/simple;
	bh=hrcGTn+o78aobGI8WJuYL9ijKI4HZMfUg1J8TBl4u44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B3yaO72A9db3gKN2pT/3y4F8zjzb9427ll6FX9VVY/PH4rX3DSUL3UhHznwcVlbf/FrIgs+EMsztZeM8Tho/owduYhbgWP8yNf3wgCXQa70wLi5jE+xgUOjGEx+QeHcErVXYCTkaHFkdm9LsronhF+kFGON7/mFxXP0F9sIGyCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUkd1Ngd; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUkd1Ngd"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso1304529a12.2
        for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 22:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785128887; x=1785733687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UvEFBVhRoHQmBUGbWpEFdFC3WxqapwFMgjQF5Tw0cqU=;
        b=eUkd1NgdL47m4wvvHkwAY40nQoIq00z9+0nCmlDRKQ4S+RiocHCv50Pe3sYLAMiFN6
         Wwk6dzv3m8NK4HMO5UnkHrV0khP6bxPYeipkBbITDrf8MTI0HqwuFxEdI6hLk2+yJJMP
         ukkHi6XkBSFSpuN3jJCM2ALPKMl03wskbmZc9ct+gmFnS0jToRjp2lYLfREtNkUSahkt
         xq/4zh1eHfl2rAt+JYjQn6V7QTIqzsAdReoINAvpbmNqReiN/mOp/WMTvxxZwKC/oPje
         yBcMbLCTnsTTzoTvojaUXAkL472nY6RP0dRa8oVuCXvA+SM45sOJ9XYEih9SoD6Ed75k
         y/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785128887; x=1785733687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UvEFBVhRoHQmBUGbWpEFdFC3WxqapwFMgjQF5Tw0cqU=;
        b=AZ+iIPJxx/NxMhslZSdV5hU+RID5hB5fUw/5b44cM8ytyeCV6jq6ceJpHlIamBJwjH
         RQPaKKEr1KgkV0Pa8sSotfawOg5+S1Fi+RrdEDFpueb1vOsWPzh2OMc1QoVRZy2eTL8j
         o6k53EhMnxUGYNzzqlPOkFNy+Psg5HQ5sj8iXY80Rg69WPdejRugjTj4+uXARWEX3JWZ
         HXH7d22DvpUodTzxb+y9xL8xM/LRh1tRv05MFZFhJdYpEm4PDZwM9bhrmA2spgO71HjO
         7/bBHeqE3xdJ735g9P4sHS7JfLM5FRQeVkjMi67iYAUPByrkKSZcYakDLIvdtr5HRyGp
         /aDg==
X-Gm-Message-State: AOJu0YwUs8gxui8Hn7GOi/o/zT2Wfk1nrifo7mv1/vcSNp9xf5+aCsqg
	bFGGe5CAgXsp/L8Qhf81PkEPUq9D57XwaxIh4/AWzfsV9D7brOnq2XnjJd3X2Q==
X-Gm-Gg: AR+sD11PMxr4Z1cFpWHHwjx5iS3SVN18xzS6AxsqyarrGeSSZfngmmWip8CQ+9OBNWo
	0fibOqXiRbpXVprqe7Tl13mpI0GBE2Lmv2D1OVlhQ9dREuwSpvOOBkzRsgMnqj2OknNQrVWMQrx
	XwBCQAeiNRhbSOXEk1TbRdUONHJ4Zku1NWO556S/7v97SXEyFJWTv74+2vsrH4UsZhq2DeuUiy1
	WtyBNkhcrRugJjLcVGYBqEqtGqx6d4+pZ4i4TuWdb0C1igTmon4A+2FgfGx2gO7C0pS5XHJ0NQU
	bCQ5AImr8kBmSYtRPWOBKpfICzXLLxkZL4z2CPP/FOi4aZkDr9On0PcpeVfurK1/FVqYiKkeUEV
	rQyhdnKImHFjOwcquoDP84HErriHRUPABdXAKdRtOUiqP6SzlGbn4nLoVrUvyT5Uc0DqoD4yr+T
	YzETTPrZEGHwLHLJBlvcXNgPcaxLc//XGhGXPKkB4ESK9UIjs0Li8TA0kWxM2Ik/YS4Q==
X-Received: by 2002:a05:6a21:a345:b0:3c3:c687:a3b9 with SMTP id adf61e73a8af0-3c67dde9a65mr6342384637.48.1785128887294;
        Sun, 26 Jul 2026 22:08:07 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:fc2f:1878:e714:ef41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d2d1d0d1esm27123411c88.0.2026.07.26.22.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 22:08:06 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>
Subject: [PATCH 1/4] Input: psmouse - fix use-after-free during protocol disconnect
Date: Sun, 26 Jul 2026 22:07:58 -0700
Message-ID: <20260727050803.1269941-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a PS/2 mouse is disconnected or unbound, psmouse_disconnect() calls
the protocol disconnect handler (psmouse->disconnect()). During this time,
stray bytes arriving from the physical controller can still be passed to
psmouse_handle_byte(), which will invoke psmouse->protocol_handler().

This creates an asynchronous race condition with vendor disconnect handlers
(such as synaptics_disconnect()), which free vendor-specific private
structures (psmouse->private). If a byte arrives while the structures
are being freed, it leads to a use-after-free or NULL pointer
dereference in the protocol handler.

Fix this by explicitly setting psmouse->protocol_handler to NULL
safely wrapped in scoped_guard(serio_pause_rx, serio) immediately before
calling the vendor disconnect handler. We also add an unlikely check
in psmouse_handle_byte() to safely drop incoming bytes if the protocol
handler is NULL.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/psmouse-base.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 6ab5f1d96eae..916a14b9b6a7 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -267,7 +267,13 @@ void psmouse_set_state(struct psmouse *psmouse, enum psmouse_state new_state)
  */
 static int psmouse_handle_byte(struct psmouse *psmouse)
 {
-	psmouse_ret_t rc = psmouse->protocol_handler(psmouse);
+	psmouse_ret_t rc;
+
+	/* protocol_handler is NULL when device is being disconnected */
+	if (unlikely(!psmouse->protocol_handler))
+		return 0;
+
+	rc = psmouse->protocol_handler(psmouse);
 
 	switch (rc) {
 	case PSMOUSE_BAD_DATA:
@@ -1466,6 +1472,9 @@ static void psmouse_disconnect(struct serio *serio)
 		psmouse_deactivate(parent);
 	}
 
+	scoped_guard(serio_pause_rx, serio)
+		psmouse->protocol_handler = NULL;
+
 	if (psmouse->disconnect)
 		psmouse->disconnect(psmouse);
 
-- 
2.55.0.229.g6434b31f56-goog

