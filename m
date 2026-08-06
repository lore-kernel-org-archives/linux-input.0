Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00FB3B1EC0
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 02:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983309; cv=none; b=OLwbG3xOAyVbaHYlG+YmofBoZ7wR3xWL6mMAd3d+KSqO6C9XVQM8FQ4DSAfPCxzi0nM6nH88pjGV6/TWKCzq60R4C8DRvnV9fcdX09EqDXWNyvrxUXg2OrWjVaPrce63Pqs5/sAEoSM6h9DeTh7blicRlSEWjb0Gs+rZNF1VKU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983309; c=relaxed/simple;
	bh=GgRwcyOfDD4LdmdJGGvMBEpHqLYmuU7tjTanYoTEQOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7FFXD1dQGOclhZTLKj5kXvBaFavd2EKm8ltrm7o7q4r/nkxxIIJWcjctnHD1kJZXgOzSixgpx4ulDln464NLL7VAP1QZFmMacyai31E80rg1XEibVDD6WBYmQv9leQMyYB4ocd6KiM0syuPq++gKK8BbM15FcyVMSqPd15c2qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=jfXVHOwc; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="jfXVHOwc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785983301; bh=GgRwcyOfDD4LdmdJGGvMBEpHqLYmuU7tjTanYoTEQOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jfXVHOwcgOUQe4N44ZwyRruIptBkSBKf4ftkev3HKATdNtpnFqsw6OAmYxGh1edsw
	 o/DmeH+C2rlwy8uj1dPMnL/gAA2Q7AaBn+FyOjQ5tbBgdv7p5SILZi2rZM6yf4OA4+
	 xq5M2KdFUlefuC4cY9njzogQteLmA9wpoL4kGOSDTlLne1T/1HA+bUu6LkifNx24nt
	 IkMFseW718IRd82VKgEW+5z1wYeKjjf3ucla9Ap7BOUzahLuSs+AoEF9KSVBrixGUg
	 wV0M6X8t8RAQNUFP+JW/5RKYtst3cxGfna3xqlnqT31jb6eBjek4DK5yKCbbqGMtYQ
	 NWPoLZuFLIA0A==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 57F4CA0EE;
	Wed, 05 Aug 2026 19:28:21 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v2 3/6] HID: steam: Fix wording of connect/disconnect logs
Date: Wed,  5 Aug 2026 19:26:42 -0700
Message-ID: <20260806022653.93939-4-vi@endrift.com>
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

It always said Controller, even on Deck. Since we special-case other
instances of Controller vs. Deck in strings, let's be consistent here too.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 6476fbdc5888..38c00dab0b06 100644
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
@@ -1427,7 +1428,8 @@ static void steam_unregister(struct steam_device *steam)
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

