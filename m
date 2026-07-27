Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4850C1DDC2B
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 05:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785128894; cv=none; b=lc9rmb5fmti/FMUgve0mQ8FaNjVPLQ7Dc+XFswWxZaTIGxDxORXypd3S8KH3IXS6qEfVaeOfNZHB9L39md+un6KZLWCfcKUVc/iWcZ9yHWqA4rQXKWKKYwXkaq5nLUmJMtxT/TvjDZ1/WJFWJiUt5UOAnzS51zAGE1gmgfYrEUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785128894; c=relaxed/simple;
	bh=8kGqi8XJacTgWgcULkdTuCxKC1Kw8qns4zp0nVGp6q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIV5HrMEFU1Viu7+8lCHOhokGF6iVdIuG1hqfaTSBcU3+H7Jp8DZQDTAq3iUu13Cm3ULQacKf7nXVFO0ZICDqz2crYsnDuPSzNuWyg6ioJqIiQ7vrpnkeH0oju1n/h19FcCc/9Z3h6mpo0EPLUH0hKXuHoL3zXeur1Ykq9ilXsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClBEd6uQ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClBEd6uQ"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so2227977a12.0
        for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 22:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785128893; x=1785733693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ayI3fMQNKAUGr9eYdwbKjsjWBkTFvaSGeszOvzbHGes=;
        b=ClBEd6uQ97Qm5DgNuwnXdVrzgu0yL8uy13pXc4lv5C47RuWt9MA2bAdrALvs4gtPF4
         XOHviIBzQVriCzIhFuLBioDxKEAgXdKnMRQkh3e9s7q+tcNFvWJaoq9ykcgMAG4Nh/9A
         rdUNCmumfYg6hnGM1g90c7TgD+xskiViYmILgITpQADF7d0P4MPOCZ4iWC6Oc2zP5vFU
         UiMzWtVzLM7wHAVzlsWSHUyQQz03YxZiaFu0lGt2W6cobKl9AemOC9JRluzJi/sZTzmE
         cXPX1R3duJ+QwbEMfOWOwyoHHSht/B3sV8G9zrQMa37vVIiq69Sx7OoXneT6KyGnpog7
         AFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785128893; x=1785733693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ayI3fMQNKAUGr9eYdwbKjsjWBkTFvaSGeszOvzbHGes=;
        b=An7LrauuThxVcW6lIFakbiU67BZatjhFCEWfStsGeF5B1k7DHleWlNrBHhw76cZRZs
         LBxaI2zlk1zS6UDjaF0Rg/92/TY+xXdbf1m6x+/qaJUB+Wl5NPF9Gcu8oD0mUVnM5+rJ
         f8CB4ojQS6RgKEYWeloGRp99ZCcAdrmY0luBhFqC8FncLxW3h3tM5nFA6bLvTs6ATgOO
         s4nx1VCDC4GU3IssDRe3XDPXrndp+opFrOtH19XBpiCqmIDhsrZCU20LdAZINFNJteQ6
         wPXqUS/6Q+dnCaslPQhQ6YeYBe5dAEan5+FzxQ80uHt42ZmU20EJN0kSOB1NJZkRzsqz
         7mzg==
X-Gm-Message-State: AOJu0YyzEnx0HWNiMoRGk7AKZeNGpnbPSYD6Kc3NMAcT/MpwbzSOWEsg
	3W8xy0EEH8orUpO0ACgTaZ/ynWouIVIOKIiEe51YV0YRxBWOX6+XThZdi2V0Sw==
X-Gm-Gg: AR+sD10F+jKbdlMgRa67HXmihUymaDYsSm9Umqqq2A29ODlJmBtgji1+91zyZe6nuSn
	ibDOJ62NCQSHgb7vpOhOx3f1n7/4S76D2VukB7hDaKcQ8OVgdyeqpPi8hycet9H8Rb/jm8Gfney
	Q5ONs+mFrU056kueZ/jBhP2bjmJ4HdUfda0kX9kfvGG4TLppHztxn4wTgqZZNm3raiUohPLld4e
	YqxRw0CVt3A0aj6Vm5x+HLOt4yG3i/86NpPceCTsDbPM9x15me1CBBXp7au4B4HasgnDwLhdN8C
	yJik/ByB4vUHM73H5XiCz9TaGsdHLyiZ7oREtq7d2td25J+QMl38Z6meXWFuQHX1hAqiA/kN2Gx
	tQAtEaXXhrmq0eBMr1LHWPXxu/jwXcalUi2eRQ/cKJWX9INPeIJM5DUd57rZI2LhKOC2v3da0On
	AEJBs37RWB4frruCOQ0y0DGlkgB3d4HLQILE/g+9QM7ZEbU4D7PClhENEw7fM7+J4UNQ==
X-Received: by 2002:a05:6a20:4320:b0:3c4:397a:69b8 with SMTP id adf61e73a8af0-3c67dc1532dmr7304406637.21.1785128892545;
        Sun, 26 Jul 2026 22:08:12 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:fc2f:1878:e714:ef41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d2d1d0d1esm27123411c88.0.2026.07.26.22.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 22:08:09 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>
Subject: [PATCH 3/4] Input: psmouse - modernize PNP ID parsing
Date: Sun, 26 Jul 2026 22:08:00 -0700
Message-ID: <20260727050803.1269941-3-dmitry.torokhov@gmail.com>
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

Rewrite psmouse_matches_pnp_id() to parse and match the space-separated
PNP ID string directly in place without dynamic memory allocation.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/psmouse-base.c | 39 +++++++++++++++---------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 3fcc1d293c31..a9a110f2c860 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -490,13 +490,16 @@ static int psmouse_poll(struct psmouse *psmouse)
 			   PSMOUSE_CMD_POLL | (psmouse->pktsize << 8));
 }
 
-static bool psmouse_check_pnp_id(const char *id, const char * const ids[])
+static bool psmouse_check_pnp_id(const char *p, const char * const ids[])
 {
-	int i;
+	const char * const *id;
+	size_t len;
 
-	for (i = 0; ids[i]; i++)
-		if (!strcasecmp(id, ids[i]))
+	for (id = ids; *id; id++) {
+		len = strlen(*id);
+		if (!strncasecmp(p, *id, len) && (p[len] == ' ' || p[len] == '\0'))
 			return true;
+	}
 
 	return false;
 }
@@ -507,28 +510,26 @@ static bool psmouse_check_pnp_id(const char *id, const char * const ids[])
 bool psmouse_matches_pnp_id(struct psmouse *psmouse, const char * const ids[])
 {
 	struct serio *serio = psmouse->ps2dev.serio;
-	char *p, *fw_id_copy, *save_ptr;
-	bool found = false;
+	const char *p = serio->firmware_id;
 
-	if (strncmp(serio->firmware_id, "PNP: ", 5))
+	if (!strstarts(p, "PNP: "))
 		return false;
 
-	fw_id_copy = kstrndup(&serio->firmware_id[5],
-			      sizeof(serio->firmware_id) - 5,
-			      GFP_KERNEL);
-	if (!fw_id_copy)
-		return false;
+	p += 5;
+	while (*p) {
+		p = skip_spaces(p);
+		if (!*p)
+			break;
 
-	save_ptr = fw_id_copy;
-	while ((p = strsep(&fw_id_copy, " ")) != NULL) {
-		if (psmouse_check_pnp_id(p, ids)) {
-			found = true;
+		if (psmouse_check_pnp_id(p, ids))
+			return true;
+
+		p = strchr(p, ' ');
+		if (!p)
 			break;
-		}
 	}
 
-	kfree(save_ptr);
-	return found;
+	return false;
 }
 
 /*
-- 
2.55.0.229.g6434b31f56-goog

