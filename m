Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4C5395AFA
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144695; cv=none; b=s1D/wS31OHe90kXIsMPrWWQ1jIw5OPpAHMD3sPzO1llSGH7wcNSNs9zkaHSVgjRRTb1/pGoQIp/o3UExIUWAGzHf2pcc/l4tVPfC27k40d/PPbOY6hpXmE1ojMmRmPRRohMePlYUnmrIQSCBgsOIvD601aQDkP6q13cbzSkocmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144695; c=relaxed/simple;
	bh=+bsOwx9nTrOYEXFntbGCVjJcg5PLsYu5S2ZCTM7LJUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=awMt8VFh/OZ6WY+5MoJ8lA1YnX6KaQPPmWU1KYVGVBu4YK7JhdUc4miBURf3tKW1foXxO8f8lyknbZoy978S7Rw1EBvskSkDnCAVVa2tVWafPk5wrycOlxP+up7Dh0vx0QTrQkzF3mGSHy7B0uUpCJTn+2P16iFogBhJmQSFA/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5DB4iPF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5DB4iPF"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso1509747a91.1
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144693; x=1783749493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4acdNVktMdF/ZdKGXVy9IqprAtt4e6vm+MUIpvJ+to=;
        b=W5DB4iPFgvIZdwcj8RFIQvb7l9ya/cb8I6lAr8agXnoOs3eJuE8hg1SK9P7Ns+qc+K
         O+4kQduNIISzSQD7FM2U/w2IUqjXkwzGVAnDZnrwSkJk3AMa2ky7r1iFrMwZlO21w4Ps
         Pp9WqcbQWHAc6iJoEqRJeceJbxSkeC8cmU08O8ActvABzq6nwZgq8L+TWe/XY3meackt
         mx/IZrC97WrBnufMliw+blso3tz5jdkTS7uU5+voY1Iy8KwrYn8BL8m1v3IUaXIQYjHa
         6KNd2Y+1Ht59FC5lRFwV1NBWEtZkJ0HvyABxZp2uav4x8HsfJHxMtx1UMeEas6ekitpx
         HSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144693; x=1783749493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U4acdNVktMdF/ZdKGXVy9IqprAtt4e6vm+MUIpvJ+to=;
        b=YCUmH91HabP/prtIe1oIuuMtnSWffNiwPmNgZDerfmdmv40GCu/leIPSfoqv7kD9LE
         yWWlll8UN0BXrK6vSI2CBliokTdFEZ4AIoN6CthMh4LcNn9aIl8S57eF7IzChndn18HK
         sH08VpqJNDnNayreHcrzSDfQR7WuUDccBzHmnPHDOznH8Hkp6ebi7O5jNHZljfAxSUJH
         iq4nXysQH7JRdqHBOGBmjUXcWgA8QN3CC4p85lOnCT0bkt5BFFxUCXq2Bq/QgVKbc4Wu
         d7icxN5cAgLbqT5DPoPNS+D/oVhIzhFN40T11zJezfKzj88G4DmKSuk6CVN9djFK8EAX
         qNew==
X-Forwarded-Encrypted: i=1; AHgh+RrCt4+NMSpNfw4/aBHPaw+OE9dnEEVw2eTRzxUxARaYAh5r2yR8TI06QhywghdZHFMkU5aLRL1slZ2bkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzST+WTNqUoEOK4430cZdnERlGtSYNapi49tYfVEA+1vy6FH4nv
	CI0AqDZjWgwldfIUqmZUpL/uIjqytRcM9OpoPFB/+JHIHJy8JhDyn+5m
X-Gm-Gg: AfdE7cmNAhdhhDJ0C6kxxE7FjAakOApF9adPIVt8tjWRzdwvGAkhSIkiBS2HS7Ab0rQ
	k+hYzJU1AEB2QvKFO0kAvQBzOKljE/mLgDGKiNf+a1YRDwQ2J5nd2D2wo8h5P6C5R77Ua3VKksx
	x7R5Cdts4lm6Pp80iSl/VkSTvL3yIzJCed8XKmMYXH6r4l5qJsJ+MX6+jpJCGnT8NN3Tewy0sxS
	AZ1/h2onnUdGgmHj1sXBGWsTabb3TbBvAsK+lxWKzqu72N9WjE49RGUwhjN29MSNzPCDy3Fg5fK
	BmA7T+3QGDworaU3wxpWlfW2Y33LpcCM0J/Fw7IqQTSSj3uWD1JDTu1B0MZIt33QIdMOghdZFK/
	h3TU3MjJXmT9DZHK/QG0lvR9r/cz1AVoAJp0zu5glMhK/++LIRGpcF4dlmZCAOydO8r7zoW10FT
	QIwNuWd/k7RcL/gt4HUBdO1Ee3Gkaax5YgdPupjUMPCuvI+ZVUMKhzAqdPJmrTKOeGeHg1BnR35
	RU=
X-Received: by 2002:a17:90a:d406:b0:37e:144d:7f6e with SMTP id 98e67ed59e1d1-382802becaamr2576630a91.3.1783144692874;
        Fri, 03 Jul 2026 22:58:12 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:58:12 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:47 -0700
Subject: [PATCH 24/26] Input: maplemouse - fix style issues
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-24-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
In-Reply-To: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Florian Fuchs <fuchsfl@gmail.com>, 
 Adrian McMenamin <adrianmcmenamin@gmail.com>, linux-kernel@vger.kernel.org, 
 Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
X-Mailer: b4 0.16-dev-6911d

Fix coding style and formatting issues reported by checkpatch.pl.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/maplemouse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maplemouse.c
index 7842bd46c9a1..691cf334ae9c 100644
--- a/drivers/input/mouse/maplemouse.c
+++ b/drivers/input/mouse/maplemouse.c
@@ -50,8 +50,8 @@ static int dc_mouse_open(struct input_dev *dev)
 {
 	struct dc_mouse *mse = input_get_drvdata(dev);
 
-	maple_getcond_callback(mse->mdev, dc_mouse_callback, HZ/50,
-		MAPLE_FUNC_MOUSE);
+	maple_getcond_callback(mse->mdev, dc_mouse_callback, HZ / 50,
+			       MAPLE_FUNC_MOUSE);
 
 	return 0;
 }

-- 
2.55.0.rc0.799.gd6f94ed593-goog

