Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69072380FDF
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783030985; cv=none; b=Ds0pQlb3hTtwlWfv+a4R9dTKhVI9inGe9T8Guc5Ee1Eddk5DiMPhdMGrXlgVUHi8NI+lPizMUzuh0Yl+VRs3TD4A4KgV7lqrKjynrDOuOp32wxy0cQ1pho6LG+wKFB4owh33kVFxxuUeU0hpeCrYIcv111VJ3Y/h1ZTBycgOi3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783030985; c=relaxed/simple;
	bh=/9v2/MdCT9aBt1aF9Oa2fp0ByNvOlFUwtEC7s5klnnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIqhwL1LnZd4htuJQNAP61m8MDgocgN5w8dKva5WihApX3MEjc+NYG9PkIYgoqxy7wM+uNf1bcDkjZyVjxM0IatEs1LAdUveyBIfsGtUUEdykm4KiqDMrt0s3id6++myrfvGEMiSAPjJ5QdSlMcp8gG6/5FPm8oQeQloL5K0r1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=p/eLhYc/; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="p/eLhYc/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783030983; bh=/9v2/MdCT9aBt1aF9Oa2fp0ByNvOlFUwtEC7s5klnnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/eLhYc/RhrCtlR/j8LPRL7mmU4TNCjStdTMFDXHxoVKrob+65Z22ZmWAJKY5lR07
	 kaiCATyhk47zolkWEDKWICTZn21/+A7OwUS0wGxBh086v4ljGJgfYM79vzqQwXkSiE
	 rK4zt+mPEacnWsJiF5zelmzjBZFEBgpt8FJEEUjQ4dq84+1ofoMx7IFVthcNHPs86V
	 YUkFjep2qOXgi2Lm0URtiZc8V80GsSrmBq+DSgZ8Vecn053rJY5HH58naY35LtY+v4
	 /1b5cAhHtsSKrBR0E9eVvQBeC+eqVHZcZiEIX0QBX2PV4mb9cK5IhKBI7gagOt11pl
	 W8OXRVOVp8yHw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id A0F84A023;
	Thu, 02 Jul 2026 15:23:03 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 07/10] HID: steam: Rearrange deinitialization sequence
Date: Thu,  2 Jul 2026 15:21:40 -0700
Message-ID: <20260702222145.1863104-7-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702222145.1863104-1-vi@endrift.com>
References: <20260702222145.1863104-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a narrow window during the deinitialization where callbacks
could still be scheduled during cleanup that would then have a dangling
pointer to the now-freed steam struct.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 546916da31f9..9d1fe9792101 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1443,18 +1443,18 @@ static void steam_remove(struct hid_device *hdev)
 	}
 
 	hid_destroy_device(steam->client_hdev);
-	cancel_delayed_work_sync(&steam->mode_switch);
-	cancel_work_sync(&steam->work_connect);
-	cancel_work_sync(&steam->rumble_work);
-	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
 	steam->client_hdev = NULL;
+	hid_hw_close(hdev);
+	cancel_work_sync(&steam->work_connect);
 	steam->client_opened = 0;
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
 		hid_info(hdev, "Steam wireless receiver disconnected");
 	}
-	hid_hw_close(hdev);
-	hid_hw_stop(hdev);
 	steam_unregister(steam);
+	cancel_work_sync(&steam->rumble_work);
+	cancel_delayed_work_sync(&steam->mode_switch);
+	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
+	hid_hw_stop(hdev);
 }
 
 static void steam_do_connect_event(struct steam_device *steam, bool connected)
-- 
2.54.0

