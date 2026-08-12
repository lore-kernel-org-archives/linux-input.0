Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B9F368D74
	for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786497341; cv=none; b=Ag19DV3bTViMdHy/oKbsZUVNKjJef3c35kvgSiz4OsnsiVhI7WPsPrXYcoAIQcImJ45BmGqklxH1+0AWWuLUlXDGi/X4nI5KQO1tB1NG4c+oONiXweLB9X8Q0C+ZAeLN0YtWyH4bsQyyMNhdCLcH8fSOI9MXrQhLkCKPW+Cwpf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786497341; c=relaxed/simple;
	bh=1Q/Magh6kJPcNY7LkVnwES+lJMD2jC6lI/uRHNii+O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ltsi4/gLVzrqfePQnq2HWlyVS9fVQ+s/xxIfWzn3MRTAY7WPMY3sUk7VPFEnqOMT6GA4AN00UJd+O7urGvJ0TBk3E5AxdzVoFmss6qLSKVj2npJbmdAEZOfXDhtQ9BgPku2o3htP9Pef98UHIWXnvFIc/ZqE9AWxgIP5Ej+Uwdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=lR1bTVul; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="lR1bTVul"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1786497333; bh=1Q/Magh6kJPcNY7LkVnwES+lJMD2jC6lI/uRHNii+O8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lR1bTVulE3dK93JgMDA1yUkEOoHLiM2YWfF4GbGSmJ21TU+x1K88ijuIVZvX9gCuY
	 0eYeJTAtXkIK8a3vrKc1SLjkwwu+J2EyKX5qL4uAlLitkybp1gmgac6gjsXF7Uqzo0
	 40AynP93ShqseGZL/hJBmoLbH54GjZt0k1k9+KVBOnZZhN0jgk1eyvOqHpsAlAYoYw
	 J3/hpNes68j3528HACNfOThQAd4O5wZc7iKRjCwPRyZX8cHK4oy40iMSdRbBJBEhVT
	 awgBUySS7bLPsI0lFZkjnAcw35JQUbNroBRJ8e4z/cifUuf4TEWUJ/Ka7wi9nxYwuK
	 d5WLXyxg8g6jw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 67C2FA099;
	Tue, 11 Aug 2026 18:15:33 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v5 3/6] HID: steam: Fix wording of connect/disconnect logs
Date: Tue, 11 Aug 2026 18:13:54 -0700
Message-ID: <20260812011401.3250968-4-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812011401.3250968-1-vi@endrift.com>
References: <20260812011401.3250968-1-vi@endrift.com>
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
index 29de32051319..461ebf37171b 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1391,7 +1391,8 @@ static int steam_register(struct steam_device *steam)
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

