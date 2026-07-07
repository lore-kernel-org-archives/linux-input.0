Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0925C36A360
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436032; cv=none; b=YbBSSUPY2rYGWM5xGBnaaT9cYTCFkhDse7hcoiWphE2L7J/5Z+nrvWspkttzsesEhJIptzeSLK1CLgvzOS0okVbToaQILz7b4STdRal3qhS2SUE1EzJGpGyqcXIrUUFLj9mwxqZBtFRYK3e6E4E0kIbw65ThwjulYp/DCP2iNGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436032; c=relaxed/simple;
	bh=CzrIdF1nbeHBSS89V19tgL383kJPDeuI6sNseLUC2N8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vEwmtjjOsV77GI61JNCfImGVSKcEQ1hMw9GvMsmjSawc+oLmq1sDrDYsziV7W/lgjku2ds/NuEyfS67URX5yZ8eZ2LKEqaf131qQG/Hka01M7RsyHcPcaZJMSDCfONg7WU5JQvecUvFOH6CviFhzt6yXbefzxl+W97i9lXkdsvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cIx926Db; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cIx926Db"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b77b150aso39164345e9.2
        for <linux-input@vger.kernel.org>; Tue, 07 Jul 2026 07:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783436027; x=1784040827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bWmMpMhPBO/EOzHg9dXhWeBCCLH108Nq2eDZhsT4OEA=;
        b=cIx926DbMQfPB8QozBNnvtf/FDPD38tDWLwcezIWzwKT/7RrlsORWY1JHzpmrzwTDj
         QMUQfXZmmHbGN7wDfNSXooG3P2vdwpZ6HKUTTl9FKNEHs/255JoPISRvDr/JEaJna8GB
         aj7RDtZ0DgOOEl5BUaSlRMZVgl/edFSirPpMxnX23JwwPXfkPXlKbbe23f6vGjOW4oyP
         ueEAWzpFW+d+vPcZRR9XqQWPVP84bOVBUdIGEoasC46/EagtjT+BfwGbWH9AidLs0LMH
         05Pe1VwJqqM4IWHC3ZSzxx5cx/ZIGtZIri7R/76UlZwD/60/gAbLLP9TwXJgY/UMtupp
         PkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783436027; x=1784040827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bWmMpMhPBO/EOzHg9dXhWeBCCLH108Nq2eDZhsT4OEA=;
        b=CZQMFVgmBHDAfoPkj3DCsoTVpB8wHh3pZQHF4vDLZIA6Wrz16zaT4OaII64qj3EA+S
         E4zg10i87RE7hYWaZSuF0UJtwzVJUueBMtCEVsAFztEdYk2Sol6vnmlN05BPEMgACn6G
         4KdRaVc5e9Augrr5mnZdgyuf5wnIfDrQoGOMZzHHNxYaPSnsqO9Ocjf5PE2pJpMqZBHJ
         OauJ8AF5ItTi86wCweO8PYNWEqu/t1OOJlJSyoXEJ5b1Nlp/zBGbmYRh+glZ46Tr+S5U
         vx1OIG4zbVRjFfayi9oO4S8isNPall0HOO5TkaF5Pp0eweDsvnY3+djFFgQomtGcrLva
         Fo2g==
X-Forwarded-Encrypted: i=1; AHgh+RrlizRNY2pClMjmGsR7h56m37Bmy8trwYX4iJPMWPhkmlvevHawfVIul6l4mepEHo/G1P2aNvL4WiP8zg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6owY6yKd5vy5s75hUR3qWdgD5KyjJSuizS6e1TLDYtPCFt3vN
	C2u5k9xUCiNVM0iyZ2g2tx4ugCD4jvge7C8F1DcFDE2hnjbE0TY/JTxkGodlwEB89Lo=
X-Gm-Gg: AfdE7cnZcTlosi+Vw4jtK0wQOE/Dq81TDIZ2y1xpL/t0fSX8T5yxOUwM/dvyhnCkrDJ
	3Ls+FEvyISrefjZwHu73VZZY+nZkyGdx/W/goAz1gxlOjrUliyZiH16FhUrHG1pibJGvywD8912
	yJgdILt+ZCm/GHg0hQ3LoZXe7DeCexATlJHyrxUJFM+z/Wr+fMVfKktzcfogG6I7i+neu2plxDy
	c2SDUZKrIwKb1dxorUuuTBsRG535K/lzhlMaFNeoPu+du54lXaJxsutNl57U7Sd/x7excWw8aup
	9rsytetPcoAnmoghtsFS9tcJ/xZ5SRN3Oy7QPM/zvxpWf2HDZeGqCr3zHLezO3TqVvA5O7ZxbMP
	/ryxrtogTi11kV77tYZmtEyNzXa/vclOhQ/qnohSLVS+5d1oHDuk0ztTYes4SZf5DvP3ENLH8sh
	70zyi7YcBiZyD7ox6/ZTswGcW4bkmxPSw/s9c=
X-Received: by 2002:a05:600c:b85:b0:492:4723:166b with SMTP id 5b1f17b1804b1-493df05f8e3mr59452385e9.13.1783436027489;
        Tue, 07 Jul 2026 07:53:47 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e10af550sm60425025e9.1.2026.07.07.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 07:53:47 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>
Subject: [PATCH RFC 0/2] HID: Replace system_wq with system_dfl_wq
Date: Tue,  7 Jul 2026 16:53:01 +0200
Message-ID: <20260707145327.313292-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Currently the code uses the per-cpu workqueue system_wq to schedule
delayed works.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Another good reason to have this unbound,
is the "queue_delayed_work()" function, used to enqueue the work item.

~~~ Details about queue_delayed_work ~~~

system_wq is a per-cpu workqueue and it is used as a parameter of
mod_delayed_work(). This function schedule an item that it will later
be enqueued (once the timer will fire). __queue_delayed_work() does the job
receiving as "cpu" WORK_CPU_UNBOUND:

    if (housekeeping_enabled(HK_TYPE_TIMER)) {
    //      [....]
    } else {
            if (likely(cpu == WORK_CPU_UNBOUND))
                    add_timer_global(timer);
            else
                    add_timer_on(timer, cpu);
    }

The timer is global, so can fire everywhere, and the work item will be
enqueued where the timer fired.

Since the workqueue work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change the
workqueue with system_dfl_wq, so that the used workqueue is now unbound
and can benefit from scheduler task placement.

Thanks!

Marco Crivellari (2):
  HID: hid-oxp: Replace system_wq with system_dfl_wq
  HID: appletb-kdb: Replace system_wq with system_dfl_wq

 drivers/hid/hid-appletb-kbd.c | 6 +++---
 drivers/hid/hid-oxp.c         | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.54.0

