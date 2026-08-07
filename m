Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF86838423A
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 01:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786066512; cv=none; b=LZxEfAe+grnovXPo+anljOR8FQSfTGMODpYflIo0Ji3OG7Rz2DQ9hS2kLtXyXXqOZbbKP5Mx38apm2B/N0OQUd1/R4RFOAU7h7uvRTxFKx5rP3U2e+psc2vHvDmF3HLIFBf+Nd5BQPgbd/TyQvr3dV8Ro0O3HUq3KpN7DuhOPek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786066512; c=relaxed/simple;
	bh=y1DaM9WleROTsZkqYcGmBE2eRZ1P4KJXudwiD2Soj1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9f70Snxc+NTfMN1W+1M3c4gLsE+1bfeZoSDC38Igi4lin3AqSMr754YJBBcwTM/QhRO1lBMJyl+pierX5MS5m1W0GuShP4PUVvPPOrCuyJlRtDmqNjpNptnsT2reKa2AgX/f6O9iPwLAQvskUFQiRU8hRVLYd8g8Sf72jbsH1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=Jb5cTHns; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="Jb5cTHns"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1786066501; bh=y1DaM9WleROTsZkqYcGmBE2eRZ1P4KJXudwiD2Soj1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jb5cTHns7FXhbfPFUAeRIyfFsz7WcKaNu73409bEycVoTlu1q4MZ4s7mpM7sTINee
	 Ug7gyArg/3dC5PuojhemSvrshE3NwYLP+eg3AMUWN+9H0VUS/GvgLnfl852u8vqmfE
	 bm7K4btgCBB+QjxeuRBMi0/IqRE2xZ95jcW6rZq7YETigQv4rwfAudOi88AQZGh3xh
	 9vflhjsqHeT2z/7H8P6vXsgfvkyA7qgA7aZOAdAY4lovIsznSQ9sntBb642qpXzJM9
	 UFt3aHISv+B+Efe4amosoNRAya6Cf0gyeJZ0jYw1KHVC36kkcHhi60yH0HDmIMXBDg
	 FKmt8f3STeYpA==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id D5173132031;
	Thu, 06 Aug 2026 18:35:00 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v3 3/6] HID: steam: Fix wording of connect/disconnect logs
Date: Thu,  6 Aug 2026 18:33:27 -0700
Message-ID: <20260807013334.2109386-4-vi@endrift.com>
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

It always said Controller, even on Deck. Since we special-case other
instances of Controller vs. Deck in strings, let's be consistent here too.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index ec7ccbe5aba0..8d3ef523682b 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1394,7 +1394,8 @@ static int steam_register(struct steam_device *steam)
 			"%s:steam_get_attributes failed with error %d\n",
 			__func__, ret);
 
-	hid_info(steam->hdev, "Steam Controller '%s' connected",
+	hid_info(steam->hdev, "Steam %s '%s' connected",
+			steam->quirks & STEAM_QUIRK_DECK ? "Deck" : "Controller",
 			steam->serial_no);
 
 	/* ignore battery errors, we can live without it */
@@ -1428,7 +1429,8 @@ static void steam_unregister(struct steam_device *steam)
 	if (!steam->registered)
 		return;
 
-	hid_info(steam->hdev, "Steam Controller '%s' disconnected",
+	hid_info(steam->hdev, "Steam %s '%s' disconnected",
+			steam->quirks & STEAM_QUIRK_DECK ? "Deck" : "Controller",
 			steam->serial_no);
 	steam->registered = false;
 	steam_battery_unregister(steam);
-- 
2.54.0

