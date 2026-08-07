Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294EB38D3ED
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 01:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786066513; cv=none; b=TkiUxGWfC85fEvQjcduK93bGg3TxS6Dy6NjkY/DBzpx7KsHIHxUMGPYUb3rbkNzvMV0Igaj4fD7c/+KJYCA1GY9i+p0z2KgsUBd6s/RGEo2ACA2QVwqjw+ihMne/pv9lH84UJ+pS/QbvkJou7lBZBOJrrUiV0pkJ2a+MWPMu8e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786066513; c=relaxed/simple;
	bh=GJgmH9wxxwbSitqQ8/L/cIsBM05VJYfq8o2MWDrGAFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmqn9RRX9Dq/hGg6NnyGU5bIqyHoaKSuMmHJKarbK22/4fZR/1uvWhkeNjljBEufVfpz/qnkqw2ZcXXG1Err1Cf0uAjLSDMWk0Pwb2GoqjUGMdm9t/aK22R8PY3deyqtb8yUYYMXRhGTWBieZYj5hAq+ro7KqXz99LWxrBQDyBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=SxLg7gAt; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="SxLg7gAt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1786066500; bh=GJgmH9wxxwbSitqQ8/L/cIsBM05VJYfq8o2MWDrGAFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SxLg7gAtY8IJqILlKpMeAn85k+doMwxL/GH5Wez8BmG5VyviRQ3WGnsOAkoi74ptk
	 exytzVAHg1ZB4TTUhI9SNOdLE7u6XXPFVSGzp8/MebOoeIVdLcs7/vPzm36VFpX1oi
	 mN5U7JIXVsTC39eyXMctumEmpCkcZeAAVFhBri8WBgVZf3yRm3WdVeKv3iLvJz84ac
	 vKi0hudNZujuzco+vmxoEt7S+o7zajWcTanFnl2Zu/vS1k2yIGb6HDj4hjjCVSU8vu
	 j46dC0ZdHV/WcZPnnxgYv/s1J+tSFcXpGe04NNEOtj7Uu+i3ex56opkLFudPQDC97y
	 mlvzzmQ/RvZCg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 0DBB1A12E;
	Thu, 06 Aug 2026 18:35:00 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v3 1/6] HID: steam: Unregister battery on partial registration error
Date: Thu,  6 Aug 2026 18:33:25 -0700
Message-ID: <20260807013334.2109386-2-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807013334.2109386-1-vi@endrift.com>
References: <20260807013334.2109386-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a previous refactor the code for unregistering a battery if later
registration steps failed was accidentally left out. As a result, a
lingering power_supply object could get left over after the steam object
was torn down.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 6199f67f3c4c..967f12c7a599 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1199,6 +1199,7 @@ static int steam_register(struct steam_device *steam)
 steam_register_sensors_fail:
 	steam_input_unregister(steam);
 steam_register_input_fail:
+	steam_battery_unregister(steam);
 	return ret;
 }
 
-- 
2.54.0

