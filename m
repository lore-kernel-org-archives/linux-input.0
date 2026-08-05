Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D12D2110E
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785894788; cv=none; b=WyjpgXgweKQBo15oOHUL3JlA++CaOmvagYGgkyFFzc/AUlSuNq+O1Qwr3DOTXg+L6TyN8SLyLFMJCyWVNvWPRSckIwJjlNJgsYTRZTBrqkTnOdhEu3wryumoCVcB0MHsJylEPKr7UqJhaMTITrfowlG5noMsz8WJrgPp171Ex3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785894788; c=relaxed/simple;
	bh=La7Z16oyKGa5wcaN01UPk3Dj4bqzdnuFHdpQCYC7mM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTslHIPLeyzdE3J05Q2JNsGhMWD6aFHRwZUiXVZ87tpN6xV8ecw7hKrSAaEvQG6dTbZAasPWUMe6OZwbQ1gg3l7RiFngtfiYkMSwu+EyVzxh74Oj6aNUs3L4//MJdEaqp4+nENBoGiqm5ZszNAZ0DWlt9u/X3VMq1eGf1FZ285k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=BeDuc965; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="BeDuc965"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785894769; bh=La7Z16oyKGa5wcaN01UPk3Dj4bqzdnuFHdpQCYC7mM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BeDuc965g3g9lyKRxIVonZZPgRR7mBwdeHEwT4ku7aw+KvOZCmOnvtuuId9WiJX1q
	 47NCwFVXtqMMTblPkbIKmye/E6LLPv+fu/idwvXaM5/5rzmS79Z1kaiejNMBHeX8yZ
	 GACWx01XMs4bA1hnL0kMfLAFE3XOvkj9K5tQoVwgWqqz9lQtG6AmExEAUw0ANd+xJf
	 2xMpPVYCnypzIP1SdlUuKRMcB9uXHs2gDNSvwC5cn4LrfwmmfFoHJU3SK32qT/yQZR
	 uHcozNNUVqb0JuzZm/MYb9kcS1ChbA8lHUSRgFOBi5GFuwX/exIg6zom3c8wvL4xAQ
	 5LjrTk98duhEw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 059A7A161;
	Tue, 04 Aug 2026 18:52:48 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH 2/5] HID: steam: Fix wording of connect/disconnect logs
Date: Tue,  4 Aug 2026 18:51:03 -0700
Message-ID: <20260805015116.3884465-3-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805015116.3884465-1-vi@endrift.com>
References: <20260805015116.3884465-1-vi@endrift.com>
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
index 111e57926d04..fdf32722c8b3 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1397,7 +1397,8 @@ static int steam_register(struct steam_device *steam)
 			"%s:steam_get_attributes failed with error %d\n",
 			__func__, ret);
 
-	hid_info(steam->hdev, "Steam Controller '%s' connected",
+	hid_info(steam->hdev, "Steam %s '%s' connected",
+			steam->quirks & STEAM_QUIRK_DECK ? "Deck" : "Controller",
 			steam->serial_no);
 
 	/* ignore battery errors, we can live without it */
@@ -1429,7 +1430,8 @@ static void steam_unregister(struct steam_device *steam)
 	if (!steam->serial_no[0])
 		return;
 
-	hid_info(steam->hdev, "Steam Controller '%s' disconnected",
+	hid_info(steam->hdev, "Steam %s '%s' disconnected",
+			steam->quirks & STEAM_QUIRK_DECK ? "Deck" : "Controller",
 			steam->serial_no);
 	steam_battery_unregister(steam);
 	steam_sensors_unregister(steam);
-- 
2.54.0

