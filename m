Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF1837701A
	for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788012082; cv=none; b=R2eu/jEhOr+C30M7l2P7OR08JDbBBBtXH7Cs6TEAgu0bDy58mt/lHWwQ6K4gRZfJ4ebG/dKKrjj/28IECCQoDTiskTKgqyQ5zlZf4IPs4tmDAdLj1nFwo3VP+0Sid50m1KCql9XadWWQ29T3Esaurhc3ftuTFhK3BrUpVqLNZGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788012082; c=relaxed/simple;
	bh=2lSqc2bQD+3BAB4HtH+U2/gL2LSerJv90szA9o/SbOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q9F761gBvkmmojUN4XzIYPHgDkHNES4NZU1HSsWo6gDHHP4IXVALMK18QvYwb0sQHYliP2rUNecGwIWjMklodipfikehb7aGcIqcOh6Kar4f/DhlKPqW6AC1joRcbAMS1CIE+UK3J38J//Wsu/CQNtwHI1JnxkpZkZu4aRWUGgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8isnG9r; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8isnG9r"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e58034d05so1718524a91.2
        for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 07:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788012081; x=1788616881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PM4UZAT9CCPbss6oTyHI3ruACwrbn6SRzKqwXx7LBog=;
        b=X8isnG9ro0NbVHR4J6MOfyUZeVU5JTbNDdH3Sl+BSOGjuzqetspoGsy3yEd1JyyLjw
         VHSWwi92NbGPXnquEKZ46S5C22SojMnf11XZon5Xkfzn09aYgLqUi32M87x5srVurJR6
         vPF2WPXC092QRAgRHlVFxq6CBU4sjXOhyioEa9IEzQ+fxmiwhNPB9xJtEk7hnnBDIsR+
         HiSD3lZLcik0F0Dp01vVl6ENmYVRtWPuGgJH6IcM9iO/+cUhADf+ziFCTyp1qS+vMYvC
         BSTDDWoTPVfeXc5mY0JWX8U7+X70+mqH67QX82633abAegR4sLjCmQbYFuVDVWOpULcD
         Nt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788012081; x=1788616881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PM4UZAT9CCPbss6oTyHI3ruACwrbn6SRzKqwXx7LBog=;
        b=sG/onPMBxKXl06L2dMiLkJZ1qaZLZCrIU70yrMZYRTaU3seD8A/Y2twjmacsl0k9Qi
         juIQGx31MTcqf+EqyvjyhPgqUquBkK0ofF+d6bWwvOfgI8w3G1kgDFe2PlaLw3tM5udu
         9BVyPjeFy4VZSxJIZK2eUSJt7BnvPQKAVTHOhMUCLiSiD/DTuMx7QScmqTwRfUCJKPJy
         89AJ8QFigVa0iSCqvNd/rCM3/PK55x9pd/Fhfwlyps8LUkSD3gQkeM3bHgdokwaKaf4f
         kfnz7vOrindQMbTRbPyZh+Pi4l/r/NcBYo2Zbs6Tg45F76G/yd0mHuXvphLY89R6Y8qZ
         12GA==
X-Gm-Message-State: AFuF++nTxsOxA5augaJLmbnZdc6+VDU8XLfMOx1AKWdO18XTKJZPPAfy
	vlfxIeleuUToDcSO9O2xThbEo57Feo1wf5wm8+Vti0zIckRZrj40SFDHqO0DLA==
X-Gm-Gg: AYBFou3eWNxFOsYf9zt4n5r8gDOcPP+feljC52xtnBstSJ/PRULKeGrHPm/P8ie9Fqr
	66Z5zZgLGPa16bmauv8KS3z+v7/HY77+8hlz38qRnXzbIN2+cM3+2k7UnAMZmWTd8Np3TZGfppD
	hRtCNh+WzJBIeBq6rmyWye9YvZ8gyCCpuCt6qGw4BJc0oKxsBZUKkz3c3tzu/2EH/T3KcBUYH00
	BaeKmjafz7bJYdvjaJNeadw7eta0e/eJZTbEFIuwlkufnNgKnG5MTBJXf0I1bea3SBIijJg9Ah1
	vH3HJrNPjuu454QBfcEvWEClEOCIH2UCFw/uTDE0xF1c1v2lrCBRBOIAC1ASymXM+oVJu20gpZZ
	5dT9Y3Ygq9BtqHKMXbC3nOxFNyWSF7w+la/+o1fHcwha4bmTlB+fnObZo9bJaA/4RYDk4hTtLgX
	ojaCmqX05PPosb6vHbW74IunXkZc5eA3HwkfqMBy0bNqfpIHNkGf53Z4NOBZEKh1w=
X-Received: by 2002:a17:90b:3e48:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-396d0ebd7fbmr26366003a91.7.1788012079250;
        Sat, 29 Aug 2026 07:01:19 -0700 (PDT)
Received: from Default ([2409:40f4:101d:58bb:2280:df9:f5e:8242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7836easm18638156eec.1.2026.08.29.07.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 07:01:12 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffin Philip <jeffinphilip14@gmail.com>,
	syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com
Subject: [PATCH v4] Input: atkbd - fix uaf in atkbd_set_repeat_rate
Date: Sat, 29 Aug 2026 19:29:59 +0530
Message-ID: <20260829135959.14882-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atkbd_disable() marks atkbd as disabled to prevent any work
event to be executed, however this can race with atkbd_event_work().
If a pending work passes the atkbd->enabled check and atkbd_disable()
runs after in disconnect, it could dereference dev which is freed in
disconnect following atkbd being marked disabled. Fix this by adding
disable_delayed_work_sync() which drops all work events preventing
any rescheduling after atkbd is marked disabled.

Reported-by: syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1e2ef9bcb29af666b2e6
Fixes: 0ef7a26af127 ("Input: atkbd - fix canceling event_work in disconnect")
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
---
Changelog:
 - Changed in v4:
     Changed location of disable_pending_work_sync() after input_unregister_device()
   as per Dmitry's suggestion.
 
 - Changes in v3:
     Rewrote the patch to include disable_delayed_work_sync() as per
   Dmitry's suggestion.
 
 - Changes in v2:
     Added a check for atkbd->enabled so userspace cannot queue events after
   atkbd_disable.
---
 drivers/input/keyboard/atkbd.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 5736f4bc5a50..41a0d55dae0e 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -966,12 +966,9 @@ static void atkbd_disconnect(struct serio *serio)
 	input_unregister_device(atkbd->dev);
 
 	/*
-	 * Make sure we don't have a command in flight.
-	 * Note that since atkbd->enabled is false event work will keep
-	 * rescheduling itself until it gets canceled and will not try
-	 * accessing freed input device or serio port.
+	 * Prevent work from being rescheduled after atkbd is marked disabled
 	 */
-	cancel_delayed_work_sync(&atkbd->event_work);
+	disable_delayed_work_sync(&atkbd->event_work);
 
 	serio_close(serio);
 	serio_set_drvdata(serio, NULL);
-- 
2.55.0

