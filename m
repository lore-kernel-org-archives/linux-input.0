Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CA9397689
	for <linux-input@vger.kernel.org>; Mon, 13 Apr 2026 22:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776118987; cv=none; b=F8Y4wclSwMZJx4L5Hl/kg5TXNyQmI8CVzbOhMzhAbctmbqZOVwYcRwgUNlCC8tOgsjzeLQxY8wekccx4eIkOW8lToetH1YPqwFa83SkX7eNPgf/h1fzIE1ql8DXvNPkO0m8ICVNx6KFo5LbWyTcXnPpYGU5lcq9HauYn/9gQfuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776118987; c=relaxed/simple;
	bh=BkklVpMlhTd+gH7Ejnq/e0uJuCjCLduLhF9pFyVjvCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrI+sjXE6TUqxOtjmwY3dkOO0PDm1jMnWwaBaG/ZYlLEnijMhVLqxwSQVGqrySD8xnxyL1ZULBcUq4gf8YxbN5DeC+9uPSrtzLdwe/84bGngAm7l5fW6WOIcVEyTHfppK6YhE4XYWivGD+Fd9oUoSnXTSPcskPF0R7H2LhRVGRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oMk4xTbl; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMk4xTbl"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-423b7100bedso3749857fac.2
        for <linux-input@vger.kernel.org>; Mon, 13 Apr 2026 15:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776118986; x=1776723786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tzt7ZlPIbuh9m3r4chtO7LLki6qG2/dJ0U5jd5tlIC8=;
        b=oMk4xTblZBhuqRb2rImcjFniKdDljrLxkoq+nOVNl5CJ/c+mgoaRzgC00dl1B2NEjy
         uhZHk3q1IWL4fEgTfffGX4gpRO8yscKLMSg0QxWvaQIg9VXnjiww3orNeLJmv9EY4ETN
         PUPNCnrbvUhyXxNJyjXEZ/g+C8nTBx4x15IYwxKlpY9ETiiwYOJO5rbjTfZtq05ZwMJf
         JtFwXR8GmxsXfM9RLIBPyqzDWHzx7+RpuGN8NqcnoQ8EUWqJMr3Vd9U4ezaCz7Z6v+YG
         T5nZWN8MMyj5dwQGwwQII7yUTOOU31uz81Drq9G7EMJd4HDlVRQ7cHBB85l0Xrkt70CV
         jGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776118986; x=1776723786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tzt7ZlPIbuh9m3r4chtO7LLki6qG2/dJ0U5jd5tlIC8=;
        b=p31aCs2oCnESIQdlhqWNpZem2DUIs7CHbXSWlWmX6jYuwIpPf3MbsXHCQY5rwl15Jb
         Zmp3MBqTk3DCIOjLMkeeimTLrADoovYMPh2g+k0DqioKAJQQeeAieKoZfzJtdOk6PW5U
         cKp+PXKdLQ7O5L20enHCcdq1+n27+2lanzMhk/flEEAY9X15TNxk7BplhlV3NCMcItAp
         IQ04Y/HYFPy31p5QfnYxCxgFEtzFJPQdFTDekwiTLvHqoAc/OO/Cr0PfIT5bLw1OBrUi
         Zt+77S57tm+HJpSKheBcA4FbK6+1RiEi7EwuCFDum5eRMRmOIyk+cUb1mv2abSJnU14Q
         264g==
X-Gm-Message-State: AOJu0YziEq2JeAj3GYl3VvI/RPzyt+aojAdRmbJ+O262AX444oMrvIri
	TbUJL2F4pZIlT2a5tJvMSzMv/y5X7CzFRG+I1GkLmSkurVEA5bViR5ZR
X-Gm-Gg: AeBDievGy1hNjtQhtvKGh+OGGvrWldVNgp6V2FV3yLX2wpR7iLfuwH8spIYtN658x1E
	Gx25YpWF6uk7SNTDdSC1gC0D+/19R51KFNiziD7g1AiwQcHrrCtg6xwkh3djDSItgsFK1brnqp0
	xH8qHn1t/YohsVmJ4oWlymwnR9haGBmPYa4IKUxG211RxSj01+QudwgX0udOgKv0AbGThjq3OHx
	k4xFg0Kf+mNOllYHbrX3GDd4vkBg+Zu1fTvCqRugT0yPx9OD/+RImVPEOoXmNfr0Ld+9BAboMfr
	TfOuUf1eCV157qfs6DQ2ACuwP7Ua+MGTj4eVwB8E8UjGVvnwHlWEZx5jqGfjQ++Z0GD9hH/tLwE
	hJ/ozzcR/raLyMndsmdym0onrQd33N94L0T+LGTIQ6/Md8ZB8/BctHovojeMiCKiAa52ttb+sui
	bolkscmtqKNFWJWplCQXC0FR9iVastbLXZmXY5
X-Received: by 2002:a05:6870:5d91:b0:41b:ff2c:de23 with SMTP id 586e51a60fabf-423e0e2c330mr10158863fac.10.1776118985786;
        Mon, 13 Apr 2026 15:23:05 -0700 (PDT)
Received: from Dell.cheetah-searobin.ts.net ([2600:1702:56e9:4b40::33])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddb80ccesm9403198fac.13.2026.04.13.15.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 15:23:04 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akash Sukhavasi <akash.sukhavasi@gmail.com>
Subject: [PATCH 2/2] Input: analog: Fix coding style - indentation and parenthesis spacing
Date: Mon, 13 Apr 2026 17:19:28 -0500
Message-ID: <20260413221928.21748-3-akash.sukhavasi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413221928.21748-1-akash.sukhavasi@gmail.com>
References: <20260413221928.21748-1-akash.sukhavasi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The checkpatch.pl script reports minor whitespace and indentation
warnings in the analog joystick driver. Specifically, there is a
misaligned port->loop assignment using spaces instead of tabs, and
an extraneous space before a closing parenthesis in the
ANALOG_BTNS_TLR mask expression.

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
 drivers/input/joystick/analog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index 6e1255a82..04fd5b119 100644
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@ -330,7 +330,7 @@ static void analog_calibrate_timer(struct analog_port *port)
 			tx = t;
 	}
 
-        port->loop = tx / 50;
+	port->loop = tx / 50;
 }
 
 /*
@@ -490,7 +490,7 @@ static int analog_init_masks(struct analog_port *port)
 			| ((~analog[0].mask & ANALOG_HAT_FCS) << 4);
 
 	analog[0].mask &= ~(ANALOG_THROTTLE | ANALOG_RUDDER)
-			| (((~analog[0].mask & ANALOG_BTNS_TLR ) >> 10)
+			| (((~analog[0].mask & ANALOG_BTNS_TLR) >> 10)
 			&  ((~analog[0].mask & ANALOG_BTNS_TLR2) >> 12));
 
 	analog[1].mask = ((i >> 20) & 0xff) | ((i >> 12) & 0xf0000);
-- 
2.53.0

