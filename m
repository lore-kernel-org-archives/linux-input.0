Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3FB3148BF
	for <linux-input@vger.kernel.org>; Sat, 19 Sep 2026 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789845741; cv=none; b=k4zETOTnYhG5HjbreblJ84eFD0a0YjjFhqYof/gY/5tF5b6QOWtXWbO/75PcKjZ76gAdGkpiNlxSSH7Q5CZ1Smpr7R5rEjltD7ttrAiV+dplHljrw+17XY9EFp+vSNthiEr42v5+A/DIv76Ky4x4LZTSScWxmIFKF30EyOi7MuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789845741; c=relaxed/simple;
	bh=q+zOBi9Fbyg/EVMUd6GFF1h1/qB5vJ2elhDaUOuGLzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PbOWFpQbOYemIrFTVxtP8bgQs+d31+dlZtH6WQvq0jy+nl9iWwuc+QxhnD0SStn+NiI85Puf23h+LiXDHZlxDgudZC5rVSd5d/48UDvrWfq7K0phRH+x4vE9sE6IFi1/LreaG67i3LCQNiF6BvIX+1YyBIEagH43ux/hQHxaOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFfofZFs; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFfofZFs"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b965f447cso14718835e9.3
        for <linux-input@vger.kernel.org>; Sat, 19 Sep 2026 12:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789845737; x=1790450537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lGVcRYCp6obQM+H51it6LnnHR+UH0Ymcwre3GKq2uUs=;
        b=EFfofZFsaCYV/riC2vQGCzxTWFbj4Gddro9Ih8vaU+yzqvEpjz0HgEpnaDMjAS3kpT
         Ami3K7J4aXTM6EYs7RPO2onDotfF4RV4dB5MjDZiz9OvXhEntSZHwY9QrWUsevc7x6cE
         w7ZBue8YLDcRSNgPPUB6ejBZuZO9Zy6StuQIPhnPwYGsQ83aovCGIFoeoFKQJzXbb8FF
         a6V1ayFMRK1FGm+kcuHYN6yk24fmS9jQ+t2sT26v3yUy8E0JyTdRGo3dpdjR7IDymaIg
         rLfloTtHyUiH72/CsgJohl9mO8MYo3KSt++7ZSgKkKAJpHBSyEyRNoI3+l1N3xfqwvqa
         XmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789845737; x=1790450537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lGVcRYCp6obQM+H51it6LnnHR+UH0Ymcwre3GKq2uUs=;
        b=veqArxyJEsAiNlFjsz5ldxIy62gBIgkjI12Ymw4qdgsXyc7stqqBEDETx3EibeQhjK
         4jTah1hW08mEBVNDE0Qo0ewqot2Ty0TGeYFfgjX4ycHsFZDVDH5SNKOM38QtHWcPpr05
         XB1W9qV7GmgS6fSe3gNGp7WLA/UlCr1wqNP/KXqFaTPzWTWLlmzNuTtk+yxsk/9B717d
         ZgSHae3rHqTWLOXpfFa1E6bxhMjMwHPKrEwQ1FXBUyCnWywOrvGsvtRporBhLdZVT7y1
         BFbNKpRWHQHcXFvEXssbXg/797y/2FKjkBhy+hD38e78db5lMe09rq40fBIHYLb+5Yc9
         9UyA==
X-Forwarded-Encrypted: i=1; AKwUvBw1fZLtrc6t9J2eLicibKoT4+FbMfSl0pUe4rshq75JksTfyCT6MyPrFpbyWlAwP7lrN9+dWCUuaTSufA==@vger.kernel.org
X-Gm-Message-State: AFuF++nP2x5BCkS0zn2Y3frsaM508t548COVU/C1qGr8+hA6XoKUTqLI
	t+hbYwIJ4zExClypMFqdCLBxMDON/yBMAMlxmlAh2TiCEahnpDO38Dca
X-Gm-Gg: AYBFou3hFmsyQW7Xxdj5j0lj1jveFo/NVZL8hH/ENGrOaYdzuVMJgeHhyuNu1vg2uTa
	0Y2VOVvrN882M4MzjRPrd0sMT+v0BjMwVxwo1uJMOGaur+86Naqy9YMngeRPSAcyPokR9bk7tc6
	EYm8lFpenvZIMCNc1PZ3yDKyL3YgDLHA86D+OiWHP/iI2YVvzFvfhptI/6OJQOpF1ZM8ZNyMG50
	zB54OOf+0HAwKSbuw0VRVlkl2fmAa4TEd7e2mpjJQ9vqSuK370BxdlXDsvAN9XE29uTkR2IVimF
	6AeoNhKrQDYvQLxmGykU4Tem1kvx5LNX57pQEcjNj3dzCvDWJ5bvZjnA4YBK6roMICkKEdvYIQe
	bptmmpkYJUnsO9Bxd4RiA2qqRfnL2nJNwwKN/RsT+UydHUf/Wbo31QWRtkT9sYqZsKbgn9EqiGs
	gTPjCfmnnagyZmOXG+xnqnS57XCjqDdt25ZRe13rtr/UF170MbQvNgG2ySc3S5Ga06sVmnqqaNM
	9mZ0z6KvqgmQUeaLpg2tgF0fomR3CQwsBz0+PE6YhdPyiKM8PCl
X-Received: by 2002:a05:600c:6211:b0:49c:fa20:cbfb with SMTP id 5b1f17b1804b1-49fc5728f84mr80166105e9.18.1789845736506;
        Sat, 19 Sep 2026 12:22:16 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724460978sm8865069f8f.11.2026.09.19.12.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 12:22:16 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: jayakumar.lkml@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] Input: wacom_w8001 - validate index before storing data byte
Date: Sun, 20 Sep 2026 00:21:53 +0500
Message-ID: <20260919192152.271808-2-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

w8001_interrupt() stores every incoming byte at w8001->data[w8001->idx]
before the following switch on w8001->idx++ has a chance to detect an
invalid packet and reset idx. The switch only resets idx for the
specific packet lengths it recognizes; once idx has advanced past all
of those (W8001_PKTLEN_TOUCH2FG - 1 at most), any further byte falls
into default, where idx is only reset for pen-only devices without a
touch_dev (the ThinkPad X60 workaround). A touch-capable device fed a
malformed or overlong packet therefore has nothing to stop idx from
growing without bound, and w8001->data[w8001->idx] = data runs past
the end of the W8001_MAX_LENGTH-sized array.

Reset idx before it is used as an index whenever it has reached the
end of the buffer, independent of device type, so the array store is
always in range and the existing lead-byte resync in case 0 can take
over on the next byte.

Fixes: 3eb1aa43ef5c ("Input: add support for Wacom W8001 penabled serial touchscreen")
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/input/touchscreen/wacom_w8001.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index d8d1cdc3f09e..bbbe7bc69776 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -285,6 +285,14 @@ static irqreturn_t w8001_interrupt(struct serio *serio,
 	struct w8001_coord coord;
 	unsigned char tmp;
 
+	/*
+	 * Resync if a malformed or overlong packet has pushed idx past
+	 * the end of the data array, so the array store below is always
+	 * in bounds.
+	 */
+	if (w8001->idx >= W8001_MAX_LENGTH)
+		w8001->idx = 0;
+
 	w8001->data[w8001->idx] = data;
 	switch (w8001->idx++) {
 	case 0:
-- 
2.55.0

