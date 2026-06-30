Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AA33DE447
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840585; cv=none; b=ElEssS/NVHcQJgimRcHkMj5Crw9r/zs6Ae7npZaoWWZsJzYPU6/hl1ktKIUW7FnJmwfm7iDGuelihhifEJq8nTw122ev92xOB4H8/jJmbIkVU9stBDR+AQ1ek7Ap7EjpDnRyJG5EeyP9rHxRmVMdUZyiLfW99o0yBBqoAMVDaY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840585; c=relaxed/simple;
	bh=KgvA8tR0engBfmgev+UXFe5nXtgFNeOcypwhifOpm6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYF9Rj1CEyFWB5XGbOHjFpgo7XsxR3WHSUGd1f5oyxKvZtqljG8HfuB2PE13++Y0XKBedQSB1u/X2Z/nQ3g6vmQXP3w5BjkIsJ8MYF6VlFDsCNKa1dGiH6ZIQd/wPkXAKEZtTqSIO3hXEWJDwkP0ZpwtwuBjeG5ku/CzWxv8I94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6CaysqV; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6CaysqV"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51bf2479349so24245081cf.2
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 10:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782840583; x=1783445383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYw8fg6726N6rG2J38FtEOJNJf3HsBu+WcggZ4AYV7I=;
        b=g6CaysqVscG3MZTp18kzW8qSb0QpjEVgsSUFbeWDWx3MBaAF2/uI2OS8gWQAi8h61F
         EbNEjSe/+h30X0Wvh7nfvJ38OpHNwqv77nu3bSwawkAKiDrU47RxEiFmBmySG6RSTeyV
         Ly3QU/QERdRvOGutNoj/mlF4H3V3ZH/IujL5YulQWw7sY9ovIOUKs4z/Uv62IhsTpzoK
         l7kxpOa224V0AwdMa+dnx6mEQBhBXdL3WkyL7sZCkTMWk0vbvCg6VNPv+mm21fQ5Nqku
         xgfABm3mvdp6DAGNzeobFlxTPUHMAVgSwiiLXZhEHh/BWgZRFbvBqPoeGGXklJL14qfU
         FGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782840583; x=1783445383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NYw8fg6726N6rG2J38FtEOJNJf3HsBu+WcggZ4AYV7I=;
        b=nX4JnKsTHwn6VEHjnlZcWak8magf0gty0Ii9fXymi/yUK8RXbzSQr3S8PZFPng2cLC
         y7bS8cc42kqmBv3R+EAHroeLad+Qycd3nwPtRSwTTJiXmuRUPkIk+aGSBK51BDOzMhvU
         hrF0mv589eZt6nTF2+E4SOumXoS6bLOAnCluwTiehIDP52xtEIwt2SrCjHiM8NMaCDVL
         MK6cmWinPOh4XFv5J1iAlL/xMWrLMjYj8cbXO5fBLKqrNff1OHZCBCYyHj5HgHQWwgr3
         DmpOHf+YF1b2UPTUZiZfHnL72znhDNwE9mlBohSMW4+l9ZBn7FXRl2GnHmkHzaOfJXYu
         huQQ==
X-Gm-Message-State: AOJu0YzmM8iEcHWV8Ui2RISED/STRDyh6kEjEvkKq03Zov6Wh05YI/6D
	DcQog/lDpEpFTTiIlHERluKMPPsYDcsOM9yuZR8IWxNNrvYWZ/3Q1M4B
X-Gm-Gg: AfdE7clp/cV+DkqEi2G2rHUKJ02v92gNsKyy3RYvsOSsmUBvWghuN2gWMTCWnNdADXZ
	a1DgPVbhVPk6IKIqFGA+l8Y/9t8N/Tn9o9FAXy4fufO+gJYg+W7fW3yKvh8qj0cB4Hgzw8PYgZG
	2Jw9rKqqX3vVSbq2pPtLzgVJYQIyBSqOtnkalwG5fz7H3FXDxsKGhqNSHcDF4dAC7OUIGwRqLzH
	+Z2Zqn7KNgP8eid9IV4B5XGKWR09LzKskfql8DK0IRLj+vJEh9tsTBOw3tbvap5zgAu0crxULi8
	hqVg534Ztfm1PT9ShCfcSGx8/MPDx/++2SYcWPNUmL0wmD76Jeb6GRZLs3SJHnmICGDDyMqyUYF
	aZbyYvtN/6Y2jjf/cbAn43VT7bYlfxrfmPh7q4HVU3Es7sPeRDN0v84OkPS3DDFUkIj0XBY125z
	EycssN7eeJEDq15Fz1Ia203Nz8EZ1B/M4Fc28CdCTtBh/qUZcd
X-Received: by 2002:a05:622a:1b8d:b0:51c:667:7e30 with SMTP id d75a77b69052e-51c1082d73dmr57544141cf.47.1782840582703;
        Tue, 30 Jun 2026 10:29:42 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:122a:dd00:da6a:a6e4:2464:e6a1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a69c32cdsm29822906d6.31.2026.06.30.10.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:29:42 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v5 5/9] HID: steelseries: Report POWER_SUPPLY_STATUS_FULL when full
Date: Tue, 30 Jun 2026 13:29:26 -0400
Message-ID: <3d06ba7fcb4873c9d9d69c1fcbcd3d6bc21fadd0.1782840133.git.srimanachanta@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782840133.git.srimanachanta@gmail.com>
References: <cover.1782840133.git.srimanachanta@gmail.com>
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
index c54c56db9ddd..ce5875c03e73 100644
--- a/drivers/hid/hid-steelseries-arctis.c
+++ b/drivers/hid/hid-steelseries-arctis.c
@@ -215,6 +215,8 @@ static int steelseries_battery_get_property(struct power_supply *psy,
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

