Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C224233946
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 05:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785128890; cv=none; b=ap5InDjBSIyFkyH6Dzpj0PjM5yywMBRHZZlA/Lj2N85sJxL30EIggBZY/Rs8GAgp980I5YAuek3fb6maCifTuLtuFNDuo/mdNbeX7/w4Y5Jmpasdx5Ivre1R8AEjEhW63sNIAMeCQF749Az/fbo5TcSnaKKU6OrvKVVpu0qjFWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785128890; c=relaxed/simple;
	bh=BUsScM6KvGqW1ims5SqVddqYz4vnFsfigqJLk5dUbiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQxHwFPhVaN6SLl5pQOaWptmJnpvlcZOry8+waCk4rrHU2WF2T0DYpU5PWon/Y9F3lKWLBVoErQpJaAYx0zlTOp4CFow6glNiYHpNE3R7rxIwlpzEJ4U0TrDSKPHEDZHURNOIdHxzaYM5PP/JatkeUrEMWX24fBWcWD4YPdj610=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qUU3tJrX; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUU3tJrX"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so1580521a12.2
        for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 22:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785128889; x=1785733689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LuHeNNdwmlrvwjiZx43ClK4+ec/ENpcXyG1ojZSYDF0=;
        b=qUU3tJrXIMWV/9NZ5V+hwnt4mewaoiQfhwWIntUWH/TPqB54AhBKCXRm5DcMQUXkwA
         qtTbzRDMTdjLkcSgMyOe/id7GUKrL/PKk5cs5OakFPb1+0HzIwQv5mzn/1lBsfsHIiDm
         G4ZXfVoITx4nn2b1+K4XDuyd/KVq17Nx+38sVeX9Llphfi95SjeP9EDKAq6sDKe4A8Uo
         8pSvBmB6/Eqqdd5UmuWu7hCSIHFZx/6E26GgjW0cqvoC5Ps5fayQYZbiLILr3SMfbznB
         ns1NeI/r/ogEvNA9WyOoMGjVfhfZQcjC6E++cb/11RVMTvTo22Y6FNf8KlC1hUUO1R6J
         k2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785128889; x=1785733689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LuHeNNdwmlrvwjiZx43ClK4+ec/ENpcXyG1ojZSYDF0=;
        b=OJoBkd7eRprbIFctqU053ohHQJXrQDJElF22v5ywwynHlz+lPT/j9zn+4s5tPvPAbt
         /+hKlXZVrX1w5qhuR7uNxO+0UG8FBGdPZbv3jicPY0PXXxem++IzNpRzFMQinw+3OXIq
         dNTQsItsjyInakBWqbdh5X3tgyBkhzYKOF2XboURiD6Hnpjov/QEEtqH6/HDN8GwIsK+
         bj9GzrDN8sCzXvK2bXngdh7DOyjZbyCSJ4PlFrRYSuEzq76vwb98Gsmi0Z7ZIYjWRabG
         4lXLP2D/dAlnmYEG9dWnU+LHuSdzZOIV2qgodKXyY02djBFLsWx4U9fAsc02n9pBQxhL
         gijQ==
X-Gm-Message-State: AOJu0Yzkk1mDV4lADc8E0q2B+TKq6dU4MOdufJYRjW/K6xleb4i8bLdd
	mfohSojCr+nd4jNMMe2HS4b8v/+Bg1kO7MKA93FKpPJdokJOD3+BJi1LfzE6hg==
X-Gm-Gg: AR+sD11U2oE1lLY86jphwzVqx2f9uIqamSINQDvUYVqo62SAhxjhJa/HYM+NMoNRxVM
	BchnICTj6iMxSW06lK+WKiBXWF9HW0x6VQlrsED5GzsQBJLSidKIMOzpZnV3lB+byUhawNSZTLb
	Y+RbWxAz5oTKhR8SZoX7Hsu7S5/D1U06+Xk8nZQ7g84RTUEjvbxaKPFnmYy8COpZ60b5PtvgpZe
	TVhMzgCFExF5gn0dyKMaZZcxlYZZ7i/a4ugJ8xabYPmd/czmZ4P2+xKJdXSC/7nix30TPgKbinh
	pwBYLPSNLTorPODcbLbZuGJ9smq9j3/boPB/o172GneTVZQ7VCDbgePqkmv0pJXAY1b+fGDYVoa
	1NDXdkCjw2M92zaRrxZ9fUOqRhEYvUko1ASOdwXGpqrXqrQ7r0wzYWap2S1COcDD0Ptgr17b5DJ
	Z28V1ancdxruHJehadGNo19mufuNNsuKIPbXcGWhT4eiPz4vNPiR7vxKZ3mRW4/UeLqg==
X-Received: by 2002:a05:6a21:7111:b0:3c3:ac9c:9a66 with SMTP id adf61e73a8af0-3c67e0778f0mr7182753637.69.1785128888868;
        Sun, 26 Jul 2026 22:08:08 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:fc2f:1878:e714:ef41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d2d1d0d1esm27123411c88.0.2026.07.26.22.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 22:08:07 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>
Subject: [PATCH 2/4] Input: psmouse - clean up locking around disable_work_sync()
Date: Sun, 26 Jul 2026 22:07:59 -0700
Message-ID: <20260727050803.1269941-2-dmitry.torokhov@gmail.com>
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

In the past, psmouse_disconnect() used cancel_work_sync(). Because
cancel_work_sync() must be called with the psmouse_mutex dropped, and we
needed to prevent psmouse_receive_byte() from re-queueing the work
behind our back, the code transitioned the device to PSMOUSE_CMD_MODE
while holding the mutex, then dropped the mutex and cancelled the work.

When cancel_work_sync() was replaced with disable_work_sync() in this
path, the mutex juggling remained. However, disable_work_sync()
inherently prevents the work from being executed or re-queued, making
the mutex juggling unnecessary.

Clean this up by moving disable_work_sync() to the very top of
psmouse_disconnect(), before we acquire psmouse_mutex.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/psmouse-base.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 916a14b9b6a7..3fcc1d293c31 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -1458,15 +1458,12 @@ static void psmouse_disconnect(struct serio *serio)
 	struct psmouse *psmouse = psmouse_from_serio(serio);
 	struct psmouse *parent = NULL;
 
+	disable_work_sync(&psmouse->resync_work);
+
 	mutex_lock(&psmouse_mutex);
 
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 
-	/* make sure we don't have a resync in progress */
-	mutex_unlock(&psmouse_mutex);
-	disable_work_sync(&psmouse->resync_work);
-	mutex_lock(&psmouse_mutex);
-
 	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
 		parent = psmouse_from_serio(serio->parent);
 		psmouse_deactivate(parent);
-- 
2.55.0.229.g6434b31f56-goog

