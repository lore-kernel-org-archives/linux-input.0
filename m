Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8CB3905E4
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144681; cv=none; b=g0VAvuan+nz+K5S4xyxiLJDJJQutIGTxxkIH2wxKi6NAVjPlLY04XDJtg0QD4uF5VHW3RynKTNdJ9oCdql6Rv/z13Rjlig0KutqrP1i4qYUq1FigXmXOtmk0q/GwZZN7qqeft4FfmqhH5SlQT7p1o8NE6DVLRI3FGQmUgEOQMJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144681; c=relaxed/simple;
	bh=Fs6EjUYWLfgk7BpJioQZmhwclDt/RhFo1HMJtLPrH44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jlefDdeqNpjoF2WaEuXVtjyoEQnaIjreFP3sU3B+A8qxCbFM+bWqWRKe4IvDr1vTcYHriv98/tuISCmOP8wO0sOeXEpnEV1X+IxbDJpiIlqlT1Kx6G09wbE5MnKruXWrxpi41tVT9v+IOVfzyZbKLT5NI6JR9JzG39i9QPUcQdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPhypgAd; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPhypgAd"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so1196448a91.1
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144679; x=1783749479; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G71WVzAdPJBBE0mgQ/IIQpuK0upICMjfyPciQ2pRo20=;
        b=MPhypgAdyoYKMZnkLwwHjELlsE3TmjuGkLpz8RNyB0U7H5SFSdg/xPusCjuTplmHvD
         C++euyUwAlFmiI03mYEzMEWcv/gaX5947O3JFEOmSK8zCf952mAPULfLH41nbVPj5y/v
         pSSyECN0ZofHJUkfUN/MJXpAbh4iEsK/E5pVKW38ZcijU2ai/R0PuxV+ieNqfgSXL/TW
         xhjszvwMcpeXViGHIyaRQ/4ZvPpXmp6+gyzBDIFluOhpOEXpA6ncB14PGi9wVvIZsflE
         LAeVjSdt00EWPqioduLkRsg8m8V+reZqayzFp5K8wyH21/7Js+EZ8p1Zf42tlCLq+8f9
         oZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144679; x=1783749479;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G71WVzAdPJBBE0mgQ/IIQpuK0upICMjfyPciQ2pRo20=;
        b=ffVHoOhUMR44Tjd1ipjECma2tusGLLbuf94PyvMZDVp1Tzfhc/BWpf4Sa/NNWztLn4
         zpFpwKRnBhTFS/BzBYxZHcy9nEvM7x5Ee6sL9H/7Hfod1junsFvZnZQL8eEsOyGlKt5R
         6VNLh740GRcoFfDC8cj7ViEkBwAeaaPDoN71hSWmf2+VNKq/AoL+ITcHTD10NM86mw0n
         OQsVyImE6PVbS/NW9NYzfzXu3TMY6kkCS0OD/qB10ZmK8d9QRcHWiMtquAt1YZBKeecV
         dnKzw/LD6sUkYia6KM9EqJ3/QRKIchzJnk/4RaCOHSG64bUR3wn4DPbfkbAy5Rjf6aQM
         PNGA==
X-Forwarded-Encrypted: i=1; AHgh+RqTaf8831GPiu0noeDzeI7LLpJI1pyLhbAcstlUx/1H5dC8FpiPLC25r0c4l+nMVNKjOTKNk9ExMHJ58Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YylfjlQZKjr0fdpOdfAKsPetAFQSQ74ykxogVOQd8yVeD0T96OY
	4hjQWTxn5zWLL/VuxbQq3jR4ahrkMYPq7V6WFLsTztwX3Z/km3iljDQF
X-Gm-Gg: AfdE7ckLVsPBgVxOq9r2A/QyYFOKAvreH2mZP/iIOYZF8e0dZTP8WvzveH5ChgS8ZDQ
	z5WROJ+WXdLa8UDOwqW4ap5H1H20wvGJhgjfVmeznYautDZuO7qaKv0Em9sE/G4Cmuw86oIYE02
	xGFIzMU0GhmNhzzUlHjaaVD2FDZQtB5wXXNTaKyh6pVpQPPSdeWvuk6kv8aggLLm7yfLaaiu5Rn
	fPRHC0HhFTAv+1f+6NiDQJLjjMn7BdCOOqcDNc/zs6/Yo2HXuY2mkYyyEx9zoS53uGOg2i65Y1q
	CtFVfPVZdIn4YL+QFQfCyyY4RobiRE8pNxD6kOOldxe9TJAkDPIpAkAI43q2R5SzAHR4IY+b2ec
	Ud2HD+Dn18MuaH90F60Vw7QInARrsgOXB7FIPKAd90myy9ZY1sorNT2QRMK7LvOSOI3CKHb2+Bl
	93xltGSjxKoWkV08LXPjlcxbkd1LGldfutmQ9NOtUKJJ/4gGaBwf+jzTsVNr1YntvfTV9KeAowH
	XI=
X-Received: by 2002:a17:90b:1810:b0:37f:9ce1:cdaf with SMTP id 98e67ed59e1d1-3829f9deb8fmr2518876a91.29.1783144679425;
        Fri, 03 Jul 2026 22:57:59 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:58 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:39 -0700
Subject: [PATCH 16/26] sh: maple: remove unused driver field from struct
 maple_device
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-16-41e424964da5@gmail.com>
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

The driver field in struct maple_device was not really used since
commit 1795cf48b322 ("sh/maple: clean maple bus code") which removed
the reading of this field.

Now that all the writers are gone as well, remove the field from struct
maple_device.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/maple.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/maple.h b/include/linux/maple.h
index 22f2930251ed..90c26c86e3ed 100644
--- a/include/linux/maple.h
+++ b/include/linux/maple.h
@@ -64,7 +64,6 @@ struct maple_devinfo {
 };
 
 struct maple_device {
-	struct maple_driver *driver;
 	struct mapleq *mq;
 	void (*callback) (struct mapleq * mq);
 	void (*fileerr_handler)(struct maple_device *mdev, void *recvbuf);

-- 
2.55.0.rc0.799.gd6f94ed593-goog

