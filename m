Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2731F3B85
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 05:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785128895; cv=none; b=E//BVQyMRcLKHyZoXMRDDixMiM3pZmnJ4xnlR/55W6A512vSRIPMBvLTYYMyt2jPiDw4S36QOhNqYcxwpPUS03W8v/r56ROn3Rk5BJW6fMFWDjMCfpI/zhM452TY3kqM+Iq+OQcF1manhQ8VkF1C63mchLii8w2Lgp1BXnjQ2oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785128895; c=relaxed/simple;
	bh=OgJ8N38NsTvAQFRRmyLfxYi8pTciXkfofWvF0le8vGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riRZhDxK3gDjBybR03Qf4V5ussbTGz9zhzrWOTskV2ucVgTkyftxtBDl1OuISY6Zy8V+skhsbqCeOmue6HKcogB+V79TPNxs17SzbYGnVChRWfyKsYXnX62KFbOxU1jxg9tr2u5klKkkWiMXIx2YyygyF+f6HtgWDhjvHDuOtiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z16P4rdF; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z16P4rdF"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dcbade417so2392154a91.1
        for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 22:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785128894; x=1785733694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zjMEFlGvpz9SM2fAzkrQzr1z14vUCo6kifoLS7yRwko=;
        b=Z16P4rdF/oSgx7n54xa/OYf6k4ghBNPopjnkhzmclsu8o/+RbQYtnHSa9NdCrp5QPI
         4mLK1t2Q2qAjPfEzWaRL9nRSGUNC2Ya9T47er4adTY89TUs47UfgEa4MFMp4MDnVN9JB
         UU1EqrY6QhjiDxtD32np8fnT9dKyXgag0g746Bvoubbyqb5ZZajx57Wsg9ZZ3sWsDPsb
         /o7QYmoYCsGUV/Icb7kmmDZE/iIGp6FuSpTByUFfUHMptS2crDgnnlKveZaOj4fv3FtA
         qr4Nc6/Fl2I+ZhAqRep95mIoTGp9tifRK0NZs5SHqzxB716teukWizjsJdGJKXIfKmGJ
         ZB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785128894; x=1785733694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zjMEFlGvpz9SM2fAzkrQzr1z14vUCo6kifoLS7yRwko=;
        b=jEesbfVib8/TT4xMKuVzr2QB0ScmZEmfodX2Z7hA8OcobBtbORvNRAKaZxD+Xa5C+K
         0N+fEVWD/BOurroSfP+zcDM61con1McfPxtRdz2cAAh+/vkoKPAzrJ4asgDGGzEMsICm
         b70I+V4cLRI+C3Wos3uViwCNgqpI8T3Qrynb74zWAqtmPmIyCKH1puMDMhFP8CF2Ny+u
         z6zmnPInYOnnvb20p1ktKj5O4WqtjusbImm+TtxgtYWSGOT4DB1uutfdX0dcpRK/T3YJ
         Ywx0jcrx2FhLs6Ep54fmf5gZidGLxi/MI8yndCzvD2iLGlN6BU4Z5E2/wiZbquJQn9kL
         YlDw==
X-Gm-Message-State: AOJu0Yz34qAVkmcirbBT98cFP5FS4Tev2qM+S+oqG735ClRk5CQiY9rx
	JlAFQZCb30jGkUwWlyBH+ClmEdJgpnjLaUJ8B+gpm4ywVJm7uU+np3eiLfqAzg==
X-Gm-Gg: AR+sD12u+G66O+qk48EyFR55gviKu+URu0pH9KpPtjDTuE63oFiZ7EGjy4kWQ2jMNlc
	bYvo0963UW+zVp6+1tpfttNkwREilgrwGDEa9BqbkSz6uAqcIGU83HxDaJ+4XyI9A0yxjNAHOHq
	wnXoZ6+Q7LyjBWMDWV6MyNtond5Pe7N7XKra/8OvGnhP7bbwEh3K5ZtBUPX8v06TauIBl+VL4RZ
	IYN19BBr2LRRYMbe0D6hgqA0PjVZL90m8UVRDcqI0pTdyYCWKNrXRwYtxI0xPXEpl5ugKgOq3w3
	vMfOpmrP3mNA2oDqSYKD5SmUkESR0gJ2VZfIOlwGqaQAg1wKFANoCB2Dhjvst6a+6EGyLHMHVNT
	mKGgKGxxk9Bj2OyZ/wmVV6KmHfcny0RMG9zIGfsQNt/Z7KPqo3vbg5mN9oGWsRqixXn6d7eEtLN
	Bxhp6nHJY0JTUHsQeooPCAufsW7okCtCO3TH3S1gLzdBU4p1r4RdB5ZiG+a6kyMYyndzZwiTBEl
	CrC
X-Received: by 2002:a17:90b:5888:b0:38e:8896:4024 with SMTP id 98e67ed59e1d1-38f298b76d6mr6867855a91.40.1785128893926;
        Sun, 26 Jul 2026 22:08:13 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:fc2f:1878:e714:ef41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d2d1d0d1esm27123411c88.0.2026.07.26.22.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 22:08:13 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>
Subject: [PATCH 4/4] Input: psmouse - use guard() for resource management
Date: Sun, 26 Jul 2026 22:08:01 -0700
Message-ID: <20260727050803.1269941-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260727050803.1269941-1-dmitry.torokhov@gmail.com>
References: <20260727050803.1269941-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual serialization with guard(mutex) and guard(serio_pause_rx)
where appropriate. This eliminates the need for explicit goto-based error
paths.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/psmouse-base.c | 31 ++++++++++++------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index a9a110f2c860..58b9b5dd7f08 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -256,9 +256,8 @@ static inline void __psmouse_set_state(struct psmouse *psmouse, enum psmouse_sta
  */
 void psmouse_set_state(struct psmouse *psmouse, enum psmouse_state new_state)
 {
-	serio_pause_rx(psmouse->ps2dev.serio);
+	guard(serio_pause_rx)(psmouse->ps2dev.serio);
 	__psmouse_set_state(psmouse, new_state);
-	serio_continue_rx(psmouse->ps2dev.serio);
 }
 
 /*
@@ -1318,10 +1317,10 @@ static void psmouse_resync(struct work_struct *work)
 	bool failed = false, enabled = false;
 	int i;
 
-	mutex_lock(&psmouse_mutex);
+	guard(mutex)(&psmouse_mutex);
 
 	if (psmouse->state != PSMOUSE_RESYNCING)
-		goto out;
+		return;
 
 	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
 		parent = psmouse_from_serio(serio->parent);
@@ -1399,8 +1398,6 @@ static void psmouse_resync(struct work_struct *work)
 
 	if (parent)
 		psmouse_activate(parent);
- out:
-	mutex_unlock(&psmouse_mutex);
 }
 
 /*
@@ -1411,7 +1408,7 @@ static void psmouse_cleanup(struct serio *serio)
 	struct psmouse *psmouse = psmouse_from_serio(serio);
 	struct psmouse *parent = NULL;
 
-	mutex_lock(&psmouse_mutex);
+	guard(mutex)(&psmouse_mutex);
 
 	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
 		parent = psmouse_from_serio(serio->parent);
@@ -1447,8 +1444,6 @@ static void psmouse_cleanup(struct serio *serio)
 
 		psmouse_activate(parent);
 	}
-
-	mutex_unlock(&psmouse_mutex);
 }
 
 /*
@@ -1461,7 +1456,7 @@ static void psmouse_disconnect(struct serio *serio)
 
 	disable_work_sync(&psmouse->resync_work);
 
-	mutex_lock(&psmouse_mutex);
+	guard(mutex)(&psmouse_mutex);
 
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 
@@ -1491,8 +1486,6 @@ static void psmouse_disconnect(struct serio *serio)
 
 	if (parent)
 		psmouse_activate(parent);
-
-	mutex_unlock(&psmouse_mutex);
 }
 
 static int psmouse_switch_protocol(struct psmouse *psmouse,
@@ -1661,14 +1654,12 @@ static int __psmouse_reconnect(struct serio *serio, bool fast_reconnect)
 	enum psmouse_type type;
 	int rc = -1;
 
-	mutex_lock(&psmouse_mutex);
+	lockdep_assert_held(&psmouse_mutex);
 
 	if (fast_reconnect) {
 		reconnect_handler = psmouse->fast_reconnect;
-		if (!reconnect_handler) {
-			rc = -ENOENT;
-			goto out_unlock;
-		}
+		if (!reconnect_handler)
+			return -ENOENT;
 	} else {
 		reconnect_handler = psmouse->reconnect;
 	}
@@ -1720,18 +1711,20 @@ static int __psmouse_reconnect(struct serio *serio, bool fast_reconnect)
 	if (parent)
 		psmouse_activate(parent);
 
-out_unlock:
-	mutex_unlock(&psmouse_mutex);
 	return rc;
 }
 
 static int psmouse_reconnect(struct serio *serio)
 {
+	guard(mutex)(&psmouse_mutex);
+
 	return __psmouse_reconnect(serio, false);
 }
 
 static int psmouse_fast_reconnect(struct serio *serio)
 {
+	guard(mutex)(&psmouse_mutex);
+
 	return __psmouse_reconnect(serio, true);
 }
 
-- 
2.55.0.229.g6434b31f56-goog

