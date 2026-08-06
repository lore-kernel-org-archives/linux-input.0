Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922C73B6C0A
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 02:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983308; cv=none; b=i93Y5Q1Z0JlBPfTpDiu3Ovfp/r1sSC8feqKV3/JSvJVOrNB37QuJSLnL4wqUMJjaz+5sXmNmKmpEPFGb2QbNs4n5klPxLYLngjrFpDHNGyivLFaVYHSRR4EKLRDbfBLJ5DFeN7liM/h5+rzvfPFYGxNAPVixWbaeFFaoouGaGEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983308; c=relaxed/simple;
	bh=GJgmH9wxxwbSitqQ8/L/cIsBM05VJYfq8o2MWDrGAFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhD8a6AhmEFcgVPuARf21aymuF8ZGmR3mE6joE/6PKgxIbaJC9cyc4htxJaIdKE61mRynvAax+99RO/nompy5DWRa8yctHcVWQyH/Pl8G7D0KSFORs5TsQkBljcizibaPupFz4PWH33VXAMUx+x6GrBO1vFJPDrEEKe1toEiXyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=Xbwpue6N; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="Xbwpue6N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785983300; bh=GJgmH9wxxwbSitqQ8/L/cIsBM05VJYfq8o2MWDrGAFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xbwpue6NPejeCigsTtXB14K/8tiLhBaE1Iv2nhXSjqrzJhf+qmVFPTT6gRV8vTclN
	 blgraWUXa/QaJPeyY3Zm/fUAi+crWPwaFciyqS82nZ/ob9mOhklzWRRHl/LoSAGBSI
	 ri3tdJ/odz2sjj8Zq+Y9acchTmCUVj+kax8UswIQ0GhZthVAnQC033ejlnkDFCfCaN
	 pZHhJMVTu9F8IB6QnJmFwp4gGpWtVHNT4/NkULmDjf+FdoyL9L2LQ6Lu8qH8QSyz0z
	 zlFveBnZVeG+r3QMCV2n3gMnUeIZYSIdAV8BiPxPHBt9SkNo+j0G7YcWFd5IXsmhnX
	 1PvhNGPSSa3bA==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 83858A06B;
	Wed, 05 Aug 2026 19:28:20 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v2 1/6] HID: steam: Unregister battery on partial registration error
Date: Wed,  5 Aug 2026 19:26:40 -0700
Message-ID: <20260806022653.93939-2-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806022653.93939-1-vi@endrift.com>
References: <20260806022653.93939-1-vi@endrift.com>
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

