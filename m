Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A972F38D3EA
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235401; cv=none; b=VuVNAwGH7zm+d/7VE4JTk7Pu/7vqA4QQlQEHpqzgTqHd1cEv7XX1+Y5uEGmJVpVHyJixytlujvD7jioMD8C52nnlVVCKXH0fTnaNesY7poTPgluADcux1oKeO0LUcFFVhG57T6n6Fdl4LOmkZFKBv/VXbaq2OCrbqUGn2k+wc0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235401; c=relaxed/simple;
	bh=0hNSDaMFpIoYC9qG4s+my3KbkHEMWoAsTprEKYk1ExY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1DGXH+jsw6sJ7LS0u7EI2hmFiznaItg3W3DIXUfODspySwYbI0Lm3CROQOy37b5EGjOGFt1/biVJLeka68UCVz2qxsQoE8AysWwQEAncYjDIvKnDGjFySLxzibGVu7XyJeSI8QWCdL4JB7gztDj+xJn/EiWnfPiM1pcBc/1CYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1NSia53; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1NSia53"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-519f758bd33so269251cf.0
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 10:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782235398; x=1782840198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImqqtGD4Zo4n03HwR6t9nWNAQcI+DNp5gfSgOYXa+6s=;
        b=C1NSia53M48EeU2zJTZUE22QgpXI9E+Q03frMlsu/OeV+NVG5bH+/rIQXiuY571qhA
         SZZfESMGpUvKP0hDrfWJrMN6la1hIW5g+ii+UgxPKawCRgH0ms3ZPGYF3P4SqZ1ekX36
         Y71zYAS+avgM1qJMu11AOowBVBJgqVGSkg89+Cj3qMLCfJZFP1gLeJ13R1wPVyzRHh1Z
         UmvN6i/xYatrEnS/fUat+wBPLNHjj7h0FYJT4Nu9a++misvHQWY3BKJjtIjarBXVphN4
         k+tk8R+4Lvn6ei+LudPnFneKLXJtTQHMgeaYGAUy8diOkYdboLyBSZ0oaXmh5SssTtzy
         /Vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235398; x=1782840198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ImqqtGD4Zo4n03HwR6t9nWNAQcI+DNp5gfSgOYXa+6s=;
        b=S3RK9EUVoUsBehXhzYozSJrMGFiDiTQ6ti4XkC5j9F0iCoIofbIdzCjZK0scss5ZjB
         iHeNYsmmz4CJ2q82GDbA4gtzvVoFGwgK3BBK+FcoP+G5MlTs3LDc2leOfesjLR9ttuGT
         ZA+l1Rx2TjlNQ7t3OH8rvZJdhJr6Vah7WMYSVRQhdSBHtvPkOdPJ7GOakArxVkHgBhlk
         iDAqYzvWTDJvLXRKVt7uLVmgFpMsjNLWhjnv5LKzB6Uvyd/f0JYkl4AbqbrfeDus+BWz
         z5ad3GcHN8Xxg+4KOLRjz0x/Ci0zPti2QJXTcTP9VAV5DESMsvKdD42Zswoce6GI44LA
         05Kw==
X-Gm-Message-State: AOJu0Yy7snx2PJEHHEDDagnWtf9v2V+U50LxX0mhC8rngA993IX5TUDq
	31WjFSppg/YoVZyotiBzkujL5Tvhk3yrHNaOUEf/codN4EKQkYx7KvtNusqF7A==
X-Gm-Gg: AfdE7cmpxW4DBvAwaj8TFawWvRvZYAzYbWpMisMqO7B/9fFqag7/z9BN5fq82UhnUKd
	jTcIWrIFamkJGVpdrOwGR2Ue/ox/PmtGpxIYPpFkDItygYODs57JFUiD/DPQ+JFUA3iKYiaDptn
	KujE0rcwLl4xIzS7nx5UJmIo4J8+iVE+vTb4J6bQ6NmoSudVTjwDDvkccEHUjyxuRVXPJjWstcb
	soVjfPm+oXYKCMswvWzW3paOM52DKjFsoxPAN9ot8yA2fhk3Z4sjVtCxUfKdlGs//uxZdK5bxqo
	5tWnR/k7az4Fq6uRy4K579EKm6QoOU0sJFhpITtZh/wAaAqpFIL5d9SN69SLbktbM4cT9UPJi25
	0iHpcsHI/9ECfh2GH2ezMsFd2l74q9r1RnygEMZF/h/HOlaO95PqrhRjDO76xeerACC/gxWCSKg
	vQ7mqymXwVC26bu6r2nQHOMk+8++AizvrfsSSrCdXapzAsWCD+5xN2KQ/2kSg=
X-Received: by 2002:a05:622a:99a:b0:517:9e9b:162d with SMTP id d75a77b69052e-51a61bb4f08mr137411cf.32.1782235397449;
        Tue, 23 Jun 2026 10:23:17 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:124c:e000:ff10:313f:67f6:deeb])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a515c72c1sm29390531cf.10.2026.06.23.10.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:23:16 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Bastien Nocera <hadess@hadess.net>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v4 06/10] HID: steelseries: Report POWER_SUPPLY_STATUS_FULL when full
Date: Tue, 23 Jun 2026 13:23:06 -0400
Message-ID: <20260623172310.272708-7-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623172310.272708-1-srimanachanta@gmail.com>
References: <20260623172310.272708-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report POWER_SUPPLY_STATUS_FULL when the headset is connected, not
charging, and at 100% capacity. It reported DISCHARGING in that case
before.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries-arctis.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steelseries-arctis.c
index f00f4c5e6d9e..4be586db0004 100644
--- a/drivers/hid/hid-steelseries-arctis.c
+++ b/drivers/hid/hid-steelseries-arctis.c
@@ -216,6 +216,8 @@ static int steelseries_battery_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
 		else if (sd->battery_charging)
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (sd->battery_capacity >= 100)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
 		else
 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
 		break;
-- 
2.54.0

