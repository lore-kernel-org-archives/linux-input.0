Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A003F58C2
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 23:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786145114; cv=none; b=lPKeKQ3hDfHeFTCjDVYIY+0omJloBgvhCS1r6oZAM6ARZMn4v3EPu3MRjMKAz5U/FvtrZkan2GC+mOhzP3kY+NUpTD/ayuTXPnRBYP/5K9L5oJbfztS1sNHbW3ouGkdYOZVQ5IbBnzWjnQDPEP4ir2dK9O4m6YtFVG29WbhotPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786145114; c=relaxed/simple;
	bh=y1DaM9WleROTsZkqYcGmBE2eRZ1P4KJXudwiD2Soj1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1q85k48XSUflzXvk7IKnWOy+vDMrKkriYoTGk2RBCsRMhLGSKfYMTbeYBchdCGnQJyYGRxuE9r5Vv3fyojJFp3xwldW/V+btPYfsKQsUI2Ib0/xLgrrWDXHiZLlMCuEt9Eua+fCeuLkfR5PgfdCx3vSUHUjZkEFrG9hFgsRwhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=kQG7l6NH; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="kQG7l6NH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1786145106; bh=y1DaM9WleROTsZkqYcGmBE2eRZ1P4KJXudwiD2Soj1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kQG7l6NHb0F474/tWFPf1+1qcPS2FvLDKVWpTJNs8UAzXyJ8QPLUtxmoRHwAtZGsF
	 TpMyyB3mFvB5evFAVInUYWNEiPCNsyM5roGXdaatYfiFtxZkEGC4wDT7SYJR0e92D4
	 oMmCE3SJar7Vu5Yngs1atLDE+LccsO2DHwte9Ndlj7jpn21RqlfogTwAtohBMr2v0/
	 hv7l08UmCeOywM3HaCxMDqBNMr8dmushe0zUMmq8pySAdwtZQ+WxGs8M5RqUOmbegB
	 Mh/N22ZjOJXTlDd7/SQ0o2wUahINAiFyQrmnO3mqflK9P69Uh3E5Yakni+TlqUbn02
	 SYL6CoQEL/f/g==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 586D8132031;
	Fri, 07 Aug 2026 16:25:06 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v4 3/6] HID: steam: Fix wording of connect/disconnect logs
Date: Fri,  7 Aug 2026 16:23:34 -0700
Message-ID: <20260807232339.2799205-4-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807232339.2799205-1-vi@endrift.com>
References: <20260807232339.2799205-1-vi@endrift.com>
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

