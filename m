Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BED390CA9
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 03:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783567428; cv=none; b=g2K5q1qwgjeO0YYmRrD9WKiqtd/5j0/Z6T2ZY46Fh6iKxqmJUTQ5IOJBd/7mQpLTvtJwlZmYrDN8uLti0SLYtgzfVwf45xom8p1H/KyfFaZUCqGImhTj5hnj7RVagg65T8k2/+MfeCfN2qTkwIJgo+H1BVdFHgjNriMlDYImEQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783567428; c=relaxed/simple;
	bh=uvNRu7VwkLgyVEb6c18GtX0ngFqdvlNtdeQuNi8mXi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deMtuaGAXesx2GXXmJxSfq9H9y4VHPyE74gExCaoxW3u6lqsKmhYmX6WjQrgAKajd0FhfDg7/4+PZ2acWEqM6xXJIkiezYR/h4M4sI3nOCFfbY5jM1JOSzC5PKR2jB9aZTyxEU3X0H0VstPsxufYOZfScnSaT8feJu7A77BW4AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5i1YRXh; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5i1YRXh"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e7c6ec9dbso22650985a.0
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2026 20:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783567425; x=1784172225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7k+2LFugv12aKxLGSNgu1/z6R4ElLMqVe5DZAa8WwVQ=;
        b=Q5i1YRXhj9eGMME/KSx7RdUBJwjIJ8KPjXk2sHAsv7xw0nrTRNzO/pxlRZpxB5cmO8
         ZbarFQIqzSeDU6gIabBgHQHS7nNx3ZKBSvWii8gtE7Hg+cGGeenwdmPMIRsVSdLa/3Ks
         9CxhawJniHOEfILfTAGdLUbOz5USitHIs2iVGBlmTVyC5yZuOXgLZF2ZMsLd1ngf/ioa
         sIKGmgj7l5z3ZKC05ZKJUO7zSJi9g7vlyulyOINREnoLoWm8we0rlpuJ2oheHaqi9895
         166JXfhGYytmNSRyOlwSOk1CbXEanX1XRq1nvjkTYpCwt07fvHgOMVMWH4Y5lWl4/Rc0
         s+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783567425; x=1784172225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7k+2LFugv12aKxLGSNgu1/z6R4ElLMqVe5DZAa8WwVQ=;
        b=CI5lyE7VNrpvmAIXItYX3FIzk6RaHJ2W6Ua9gMtecSuLsWvRdOsVhPn48x5JgbYPLu
         3HcFJ71HRaVfdDd+my4VHN8KUXnYhAjjxcyRa06Hy0Lll0euPy4hbztRxKJYb6PdZFqB
         G4oMYlybsLHCT9iQXIrniCLsKgdyx4iwLhq9SL8baYtc/xM5nG+oaaoYRGMR8Ibk1tYS
         +veDHiOAOPb190n49V49gjbPS42BULRnxcd9gbxgF7cDBo7HXsbHMfZSQTscjUK1TXrX
         MFyynx/fP3aXTAFtBy+3+I3J4Lx0ccCm3ocnRG7bBgg/Kc9xRUvU4W07NvAlzo5AkALg
         3CDA==
X-Gm-Message-State: AOJu0Yxe8mCrvONs2zzNVPJ2K/eNh6UvrobqYNJJEOKltSgbGl8MuUUq
	Xo/fTabLc8lHL9HIxK5m/AFMrqvgdwICKhODHO1qe+lwPqXg3hdOz6Ds
X-Gm-Gg: AfdE7clS8+j6cPa3A3ne5TVcCfNDhuRYaghUNUGj77MbJY5fayuJrvQ1YAbpqexvDzi
	nz7o7CnWKmz8cwgz7Fu+bwfd/XZafkH6sxM1DnwzLP1e/ncJutBKpW6JABdIKqgSpJxO7In+ZXG
	5yD18Mk+IJFExCJZbOMzLObzyzByJQY8jti7enlFjTBpD2IiZsa4601lZtC90bfr050fQkX2izv
	j97OqCdYFIRl9LVGQFyMEsUvGVrQs1ue8bYc/XfhVPg7B+Cig5gWr0Qrnu7zOKSAG2rk7OEtSvO
	XM4qfibTMC8UPjQeNqPAdOVwDQwnLkSRpiZ0x8wM519tkWrXufriI1Au+D3IS9XHkAFisEFlnBV
	L93vU75D0ehTrVxYmL7w1J+ASfg1JIMk7GJBPGQpf7TzcspjJH6ZmsTXsCO2HT65OZn5Mmi6P6T
	vv3XcMLmJoz0uZVBGIZ6epj7uK96FqoiM0wUB/krATYOcgsL6eTacGty3S1m/raszf8CLko+YUl
	Njm/kiq
X-Received: by 2002:a05:620a:46a0:b0:921:9df8:d38f with SMTP id af79cd13be357-92ecf64acc3mr547122385a.43.1783567425204;
        Wed, 08 Jul 2026 20:23:45 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:122a:dd00:da6a:a6e4:2464:e6a1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e9c0f7de9sm1336872185a.26.2026.07.08.20.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 20:23:44 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
X-Google-Original-From: Sriman Achanta <68172138+srimanachanta@users.noreply.github.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v6 5/9] HID: steelseries: Report POWER_SUPPLY_STATUS_FULL when full
Date: Wed,  8 Jul 2026 23:23:12 -0400
Message-ID: <20260709032316.1908460-6-68172138+srimanachanta@users.noreply.github.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
References: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriman Achanta <srimanachanta@gmail.com>

Report POWER_SUPPLY_STATUS_FULL when the headset is connected, charging,
and at 100% capacity. It reported CHARGING in that case before.

The charging flag doubles as a power-present signal: the headset keeps
reporting charging while it sits docked at 100%, and clears the flag as
soon as it runs on battery. Gating FULL on the charging flag therefore
avoids reporting FULL for an unplugged headset that merely happens to be
at 100%, which would otherwise hide the discharge state from userspace.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries-arctis.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steelseries-arctis.c
index c54c56db9ddd..7b8f5f2623b0 100644
--- a/drivers/hid/hid-steelseries-arctis.c
+++ b/drivers/hid/hid-steelseries-arctis.c
@@ -214,7 +214,9 @@ static int steelseries_battery_get_property(struct power_supply *psy,
 		if (!sd->headset_connected)
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
 		else if (sd->battery_charging)
-			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+			val->intval = sd->battery_capacity >= 100 ?
+				POWER_SUPPLY_STATUS_FULL :
+				POWER_SUPPLY_STATUS_CHARGING;
 		else
 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
 		break;
-- 
2.55.0

